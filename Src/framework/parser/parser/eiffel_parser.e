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
			yyvsp124 := -1
			yyvsp125 := -1
		end

	yy_clear_value_stacks
			-- Clear objects in semantic value stacks so that
			-- they can be collected by the garbage collector.
		local
			l_yyvs1_default_item: ANY
			l_yyvs2_default_item: ID_AS
			l_yyvs3_default_item: CHAR_AS
			l_yyvs4_default_item: SYMBOL_AS
			l_yyvs5_default_item: BOOL_AS
			l_yyvs6_default_item: RESULT_AS
			l_yyvs7_default_item: RETRY_AS
			l_yyvs8_default_item: UNIQUE_AS
			l_yyvs9_default_item: CURRENT_AS
			l_yyvs10_default_item: DEFERRED_AS
			l_yyvs11_default_item: VOID_AS
			l_yyvs12_default_item: KEYWORD_AS
			l_yyvs13_default_item: STRING
			l_yyvs14_default_item: INTEGER
			l_yyvs15_default_item: TUPLE [KEYWORD_AS, ID_AS, INTEGER, INTEGER, STRING]
			l_yyvs16_default_item: STRING_AS
			l_yyvs17_default_item: ALIAS_TRIPLE
			l_yyvs18_default_item: INSTRUCTION_AS
			l_yyvs19_default_item: EIFFEL_LIST [INSTRUCTION_AS]
			l_yyvs20_default_item: PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]
			l_yyvs21_default_item: PAIR [KEYWORD_AS, ID_AS]
			l_yyvs22_default_item: PAIR [KEYWORD_AS, STRING_AS]
			l_yyvs23_default_item: IDENTIFIER_LIST
			l_yyvs24_default_item: TAGGED_AS
			l_yyvs25_default_item: EIFFEL_LIST [TAGGED_AS]
			l_yyvs26_default_item: PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]
			l_yyvs27_default_item: EXPR_AS
			l_yyvs28_default_item: PAIR [KEYWORD_AS, EXPR_AS]
			l_yyvs29_default_item: AGENT_TARGET_TRIPLE
			l_yyvs30_default_item: ACCESS_AS
			l_yyvs31_default_item: ACCESS_FEAT_AS
			l_yyvs32_default_item: ACCESS_INV_AS
			l_yyvs33_default_item: ARRAY_AS
			l_yyvs34_default_item: ASSIGN_AS
			l_yyvs35_default_item: ASSIGNER_CALL_AS
			l_yyvs36_default_item: ATOMIC_AS
			l_yyvs37_default_item: BINARY_AS
			l_yyvs38_default_item: BIT_CONST_AS
			l_yyvs39_default_item: BODY_AS
			l_yyvs40_default_item: CALL_AS
			l_yyvs41_default_item: CASE_AS
			l_yyvs42_default_item: CHECK_AS
			l_yyvs43_default_item: CLIENT_AS
			l_yyvs44_default_item: CONSTANT_AS
			l_yyvs45_default_item: CONVERT_FEAT_AS
			l_yyvs46_default_item: CREATE_AS
			l_yyvs47_default_item: CREATION_AS
			l_yyvs48_default_item: CREATION_EXPR_AS
			l_yyvs49_default_item: DEBUG_AS
			l_yyvs50_default_item: ELSIF_AS
			l_yyvs51_default_item: ENSURE_AS
			l_yyvs52_default_item: EXPORT_ITEM_AS
			l_yyvs53_default_item: EXTERNAL_AS
			l_yyvs54_default_item: EXTERNAL_LANG_AS
			l_yyvs55_default_item: FEATURE_AS
			l_yyvs56_default_item: FEATURE_CLAUSE_AS
			l_yyvs57_default_item: FEATURE_SET_AS
			l_yyvs58_default_item: FORMAL_AS
			l_yyvs59_default_item: FORMAL_DEC_AS
			l_yyvs60_default_item: GUARD_AS
			l_yyvs61_default_item: IF_AS
			l_yyvs62_default_item: INDEX_AS
			l_yyvs63_default_item: INSPECT_AS
			l_yyvs64_default_item: INTEGER_AS
			l_yyvs65_default_item: INTERNAL_AS
			l_yyvs66_default_item: INTERVAL_AS
			l_yyvs67_default_item: INVARIANT_AS
			l_yyvs68_default_item: LOOP_EXPR_AS
			l_yyvs69_default_item: LOOP_AS
			l_yyvs70_default_item: NESTED_AS
			l_yyvs71_default_item: OPERAND_AS
			l_yyvs72_default_item: PARENT_AS
			l_yyvs73_default_item: PRECURSOR_AS
			l_yyvs74_default_item: STATIC_ACCESS_AS
			l_yyvs75_default_item: REAL_AS
			l_yyvs76_default_item: RENAME_AS
			l_yyvs77_default_item: REQUIRE_AS
			l_yyvs78_default_item: REVERSE_AS
			l_yyvs79_default_item: ROUT_BODY_AS
			l_yyvs80_default_item: ROUTINE_AS
			l_yyvs81_default_item: ROUTINE_CREATION_AS
			l_yyvs82_default_item: TUPLE_AS
			l_yyvs83_default_item: TYPE_AS
			l_yyvs84_default_item: QUALIFIED_ANCHORED_TYPE_AS
			l_yyvs85_default_item: PAIR [SYMBOL_AS, TYPE_AS]
			l_yyvs86_default_item: CLASS_TYPE_AS
			l_yyvs87_default_item: TYPE_DEC_AS
			l_yyvs88_default_item: VARIANT_AS
			l_yyvs89_default_item: FEATURE_NAME
			l_yyvs90_default_item: EIFFEL_LIST [ATOMIC_AS]
			l_yyvs91_default_item: EIFFEL_LIST [CASE_AS]
			l_yyvs92_default_item: CONVERT_FEAT_LIST_AS
			l_yyvs93_default_item: EIFFEL_LIST [CREATE_AS]
			l_yyvs94_default_item: EIFFEL_LIST [ELSIF_AS]
			l_yyvs95_default_item: EIFFEL_LIST [EXPORT_ITEM_AS]
			l_yyvs96_default_item: EXPORT_CLAUSE_AS
			l_yyvs97_default_item: EIFFEL_LIST [EXPR_AS]
			l_yyvs98_default_item: PARAMETER_LIST_AS
			l_yyvs99_default_item: EIFFEL_LIST [FEATURE_AS]
			l_yyvs100_default_item: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			l_yyvs101_default_item: EIFFEL_LIST [FEATURE_NAME]
			l_yyvs102_default_item: CREATION_CONSTRAIN_TRIPLE
			l_yyvs103_default_item: UNDEFINE_CLAUSE_AS
			l_yyvs104_default_item: REDEFINE_CLAUSE_AS
			l_yyvs105_default_item: SELECT_CLAUSE_AS
			l_yyvs106_default_item: PAIR [KEYWORD_AS, SELECT_CLAUSE_AS]
			l_yyvs107_default_item: FORMAL_GENERIC_LIST_AS
			l_yyvs108_default_item: CLASS_LIST_AS
			l_yyvs109_default_item: INDEXING_CLAUSE_AS
			l_yyvs110_default_item: ITERATION_AS
			l_yyvs111_default_item: EIFFEL_LIST [INTERVAL_AS]
			l_yyvs112_default_item: EIFFEL_LIST [OPERAND_AS]
			l_yyvs113_default_item: DELAYED_ACTUAL_LIST_AS
			l_yyvs114_default_item: PARENT_LIST_AS
			l_yyvs115_default_item: EIFFEL_LIST [RENAME_AS]
			l_yyvs116_default_item: RENAME_CLAUSE_AS
			l_yyvs117_default_item: EIFFEL_LIST [STRING_AS]
			l_yyvs118_default_item: KEY_LIST_AS
			l_yyvs119_default_item: TYPE_LIST_AS
			l_yyvs120_default_item: TYPE_DEC_LIST_AS
			l_yyvs121_default_item: LOCAL_DEC_LIST_AS
			l_yyvs122_default_item: FORMAL_ARGU_DEC_LIST_AS
			l_yyvs123_default_item: CONSTRAINT_TRIPLE
			l_yyvs124_default_item: CONSTRAINT_LIST_AS
			l_yyvs125_default_item: CONSTRAINING_TYPE_AS
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
			if yyvs12 /= Void then
				yyvs12.fill_with (l_yyvs12_default_item, 0, yyvs12.upper)
			end
			if yyvs13 /= Void then
				yyvs13.fill_with (l_yyvs13_default_item, 0, yyvs13.upper)
			end
			if yyvs14 /= Void then
				yyvs14.fill_with (l_yyvs14_default_item, 0, yyvs14.upper)
			end
			if yyvs15 /= Void then
				yyvs15.fill_with (l_yyvs15_default_item, 0, yyvs15.upper)
			end
			if yyvs16 /= Void then
				yyvs16.fill_with (l_yyvs16_default_item, 0, yyvs16.upper)
			end
			if yyvs17 /= Void then
				yyvs17.fill_with (l_yyvs17_default_item, 0, yyvs17.upper)
			end
			if yyvs18 /= Void then
				yyvs18.fill_with (l_yyvs18_default_item, 0, yyvs18.upper)
			end
			if yyvs19 /= Void then
				yyvs19.fill_with (l_yyvs19_default_item, 0, yyvs19.upper)
			end
			if yyvs20 /= Void then
				yyvs20.fill_with (l_yyvs20_default_item, 0, yyvs20.upper)
			end
			if yyvs21 /= Void then
				yyvs21.fill_with (l_yyvs21_default_item, 0, yyvs21.upper)
			end
			if yyvs22 /= Void then
				yyvs22.fill_with (l_yyvs22_default_item, 0, yyvs22.upper)
			end
			if yyvs23 /= Void then
				yyvs23.fill_with (l_yyvs23_default_item, 0, yyvs23.upper)
			end
			if yyvs24 /= Void then
				yyvs24.fill_with (l_yyvs24_default_item, 0, yyvs24.upper)
			end
			if yyvs25 /= Void then
				yyvs25.fill_with (l_yyvs25_default_item, 0, yyvs25.upper)
			end
			if yyvs26 /= Void then
				yyvs26.fill_with (l_yyvs26_default_item, 0, yyvs26.upper)
			end
			if yyvs27 /= Void then
				yyvs27.fill_with (l_yyvs27_default_item, 0, yyvs27.upper)
			end
			if yyvs28 /= Void then
				yyvs28.fill_with (l_yyvs28_default_item, 0, yyvs28.upper)
			end
			if yyvs29 /= Void then
				yyvs29.fill_with (l_yyvs29_default_item, 0, yyvs29.upper)
			end
			if yyvs30 /= Void then
				yyvs30.fill_with (l_yyvs30_default_item, 0, yyvs30.upper)
			end
			if yyvs31 /= Void then
				yyvs31.fill_with (l_yyvs31_default_item, 0, yyvs31.upper)
			end
			if yyvs32 /= Void then
				yyvs32.fill_with (l_yyvs32_default_item, 0, yyvs32.upper)
			end
			if yyvs33 /= Void then
				yyvs33.fill_with (l_yyvs33_default_item, 0, yyvs33.upper)
			end
			if yyvs34 /= Void then
				yyvs34.fill_with (l_yyvs34_default_item, 0, yyvs34.upper)
			end
			if yyvs35 /= Void then
				yyvs35.fill_with (l_yyvs35_default_item, 0, yyvs35.upper)
			end
			if yyvs36 /= Void then
				yyvs36.fill_with (l_yyvs36_default_item, 0, yyvs36.upper)
			end
			if yyvs37 /= Void then
				yyvs37.fill_with (l_yyvs37_default_item, 0, yyvs37.upper)
			end
			if yyvs38 /= Void then
				yyvs38.fill_with (l_yyvs38_default_item, 0, yyvs38.upper)
			end
			if yyvs39 /= Void then
				yyvs39.fill_with (l_yyvs39_default_item, 0, yyvs39.upper)
			end
			if yyvs40 /= Void then
				yyvs40.fill_with (l_yyvs40_default_item, 0, yyvs40.upper)
			end
			if yyvs41 /= Void then
				yyvs41.fill_with (l_yyvs41_default_item, 0, yyvs41.upper)
			end
			if yyvs42 /= Void then
				yyvs42.fill_with (l_yyvs42_default_item, 0, yyvs42.upper)
			end
			if yyvs43 /= Void then
				yyvs43.fill_with (l_yyvs43_default_item, 0, yyvs43.upper)
			end
			if yyvs44 /= Void then
				yyvs44.fill_with (l_yyvs44_default_item, 0, yyvs44.upper)
			end
			if yyvs45 /= Void then
				yyvs45.fill_with (l_yyvs45_default_item, 0, yyvs45.upper)
			end
			if yyvs46 /= Void then
				yyvs46.fill_with (l_yyvs46_default_item, 0, yyvs46.upper)
			end
			if yyvs47 /= Void then
				yyvs47.fill_with (l_yyvs47_default_item, 0, yyvs47.upper)
			end
			if yyvs48 /= Void then
				yyvs48.fill_with (l_yyvs48_default_item, 0, yyvs48.upper)
			end
			if yyvs49 /= Void then
				yyvs49.fill_with (l_yyvs49_default_item, 0, yyvs49.upper)
			end
			if yyvs50 /= Void then
				yyvs50.fill_with (l_yyvs50_default_item, 0, yyvs50.upper)
			end
			if yyvs51 /= Void then
				yyvs51.fill_with (l_yyvs51_default_item, 0, yyvs51.upper)
			end
			if yyvs52 /= Void then
				yyvs52.fill_with (l_yyvs52_default_item, 0, yyvs52.upper)
			end
			if yyvs53 /= Void then
				yyvs53.fill_with (l_yyvs53_default_item, 0, yyvs53.upper)
			end
			if yyvs54 /= Void then
				yyvs54.fill_with (l_yyvs54_default_item, 0, yyvs54.upper)
			end
			if yyvs55 /= Void then
				yyvs55.fill_with (l_yyvs55_default_item, 0, yyvs55.upper)
			end
			if yyvs56 /= Void then
				yyvs56.fill_with (l_yyvs56_default_item, 0, yyvs56.upper)
			end
			if yyvs57 /= Void then
				yyvs57.fill_with (l_yyvs57_default_item, 0, yyvs57.upper)
			end
			if yyvs58 /= Void then
				yyvs58.fill_with (l_yyvs58_default_item, 0, yyvs58.upper)
			end
			if yyvs59 /= Void then
				yyvs59.fill_with (l_yyvs59_default_item, 0, yyvs59.upper)
			end
			if yyvs60 /= Void then
				yyvs60.fill_with (l_yyvs60_default_item, 0, yyvs60.upper)
			end
			if yyvs61 /= Void then
				yyvs61.fill_with (l_yyvs61_default_item, 0, yyvs61.upper)
			end
			if yyvs62 /= Void then
				yyvs62.fill_with (l_yyvs62_default_item, 0, yyvs62.upper)
			end
			if yyvs63 /= Void then
				yyvs63.fill_with (l_yyvs63_default_item, 0, yyvs63.upper)
			end
			if yyvs64 /= Void then
				yyvs64.fill_with (l_yyvs64_default_item, 0, yyvs64.upper)
			end
			if yyvs65 /= Void then
				yyvs65.fill_with (l_yyvs65_default_item, 0, yyvs65.upper)
			end
			if yyvs66 /= Void then
				yyvs66.fill_with (l_yyvs66_default_item, 0, yyvs66.upper)
			end
			if yyvs67 /= Void then
				yyvs67.fill_with (l_yyvs67_default_item, 0, yyvs67.upper)
			end
			if yyvs68 /= Void then
				yyvs68.fill_with (l_yyvs68_default_item, 0, yyvs68.upper)
			end
			if yyvs69 /= Void then
				yyvs69.fill_with (l_yyvs69_default_item, 0, yyvs69.upper)
			end
			if yyvs70 /= Void then
				yyvs70.fill_with (l_yyvs70_default_item, 0, yyvs70.upper)
			end
			if yyvs71 /= Void then
				yyvs71.fill_with (l_yyvs71_default_item, 0, yyvs71.upper)
			end
			if yyvs72 /= Void then
				yyvs72.fill_with (l_yyvs72_default_item, 0, yyvs72.upper)
			end
			if yyvs73 /= Void then
				yyvs73.fill_with (l_yyvs73_default_item, 0, yyvs73.upper)
			end
			if yyvs74 /= Void then
				yyvs74.fill_with (l_yyvs74_default_item, 0, yyvs74.upper)
			end
			if yyvs75 /= Void then
				yyvs75.fill_with (l_yyvs75_default_item, 0, yyvs75.upper)
			end
			if yyvs76 /= Void then
				yyvs76.fill_with (l_yyvs76_default_item, 0, yyvs76.upper)
			end
			if yyvs77 /= Void then
				yyvs77.fill_with (l_yyvs77_default_item, 0, yyvs77.upper)
			end
			if yyvs78 /= Void then
				yyvs78.fill_with (l_yyvs78_default_item, 0, yyvs78.upper)
			end
			if yyvs79 /= Void then
				yyvs79.fill_with (l_yyvs79_default_item, 0, yyvs79.upper)
			end
			if yyvs80 /= Void then
				yyvs80.fill_with (l_yyvs80_default_item, 0, yyvs80.upper)
			end
			if yyvs81 /= Void then
				yyvs81.fill_with (l_yyvs81_default_item, 0, yyvs81.upper)
			end
			if yyvs82 /= Void then
				yyvs82.fill_with (l_yyvs82_default_item, 0, yyvs82.upper)
			end
			if yyvs83 /= Void then
				yyvs83.fill_with (l_yyvs83_default_item, 0, yyvs83.upper)
			end
			if yyvs84 /= Void then
				yyvs84.fill_with (l_yyvs84_default_item, 0, yyvs84.upper)
			end
			if yyvs85 /= Void then
				yyvs85.fill_with (l_yyvs85_default_item, 0, yyvs85.upper)
			end
			if yyvs86 /= Void then
				yyvs86.fill_with (l_yyvs86_default_item, 0, yyvs86.upper)
			end
			if yyvs87 /= Void then
				yyvs87.fill_with (l_yyvs87_default_item, 0, yyvs87.upper)
			end
			if yyvs88 /= Void then
				yyvs88.fill_with (l_yyvs88_default_item, 0, yyvs88.upper)
			end
			if yyvs89 /= Void then
				yyvs89.fill_with (l_yyvs89_default_item, 0, yyvs89.upper)
			end
			if yyvs90 /= Void then
				yyvs90.fill_with (l_yyvs90_default_item, 0, yyvs90.upper)
			end
			if yyvs91 /= Void then
				yyvs91.fill_with (l_yyvs91_default_item, 0, yyvs91.upper)
			end
			if yyvs92 /= Void then
				yyvs92.fill_with (l_yyvs92_default_item, 0, yyvs92.upper)
			end
			if yyvs93 /= Void then
				yyvs93.fill_with (l_yyvs93_default_item, 0, yyvs93.upper)
			end
			if yyvs94 /= Void then
				yyvs94.fill_with (l_yyvs94_default_item, 0, yyvs94.upper)
			end
			if yyvs95 /= Void then
				yyvs95.fill_with (l_yyvs95_default_item, 0, yyvs95.upper)
			end
			if yyvs96 /= Void then
				yyvs96.fill_with (l_yyvs96_default_item, 0, yyvs96.upper)
			end
			if yyvs97 /= Void then
				yyvs97.fill_with (l_yyvs97_default_item, 0, yyvs97.upper)
			end
			if yyvs98 /= Void then
				yyvs98.fill_with (l_yyvs98_default_item, 0, yyvs98.upper)
			end
			if yyvs99 /= Void then
				yyvs99.fill_with (l_yyvs99_default_item, 0, yyvs99.upper)
			end
			if yyvs100 /= Void then
				yyvs100.fill_with (l_yyvs100_default_item, 0, yyvs100.upper)
			end
			if yyvs101 /= Void then
				yyvs101.fill_with (l_yyvs101_default_item, 0, yyvs101.upper)
			end
			if yyvs102 /= Void then
				yyvs102.fill_with (l_yyvs102_default_item, 0, yyvs102.upper)
			end
			if yyvs103 /= Void then
				yyvs103.fill_with (l_yyvs103_default_item, 0, yyvs103.upper)
			end
			if yyvs104 /= Void then
				yyvs104.fill_with (l_yyvs104_default_item, 0, yyvs104.upper)
			end
			if yyvs105 /= Void then
				yyvs105.fill_with (l_yyvs105_default_item, 0, yyvs105.upper)
			end
			if yyvs106 /= Void then
				yyvs106.fill_with (l_yyvs106_default_item, 0, yyvs106.upper)
			end
			if yyvs107 /= Void then
				yyvs107.fill_with (l_yyvs107_default_item, 0, yyvs107.upper)
			end
			if yyvs108 /= Void then
				yyvs108.fill_with (l_yyvs108_default_item, 0, yyvs108.upper)
			end
			if yyvs109 /= Void then
				yyvs109.fill_with (l_yyvs109_default_item, 0, yyvs109.upper)
			end
			if yyvs110 /= Void then
				yyvs110.fill_with (l_yyvs110_default_item, 0, yyvs110.upper)
			end
			if yyvs111 /= Void then
				yyvs111.fill_with (l_yyvs111_default_item, 0, yyvs111.upper)
			end
			if yyvs112 /= Void then
				yyvs112.fill_with (l_yyvs112_default_item, 0, yyvs112.upper)
			end
			if yyvs113 /= Void then
				yyvs113.fill_with (l_yyvs113_default_item, 0, yyvs113.upper)
			end
			if yyvs114 /= Void then
				yyvs114.fill_with (l_yyvs114_default_item, 0, yyvs114.upper)
			end
			if yyvs115 /= Void then
				yyvs115.fill_with (l_yyvs115_default_item, 0, yyvs115.upper)
			end
			if yyvs116 /= Void then
				yyvs116.fill_with (l_yyvs116_default_item, 0, yyvs116.upper)
			end
			if yyvs117 /= Void then
				yyvs117.fill_with (l_yyvs117_default_item, 0, yyvs117.upper)
			end
			if yyvs118 /= Void then
				yyvs118.fill_with (l_yyvs118_default_item, 0, yyvs118.upper)
			end
			if yyvs119 /= Void then
				yyvs119.fill_with (l_yyvs119_default_item, 0, yyvs119.upper)
			end
			if yyvs120 /= Void then
				yyvs120.fill_with (l_yyvs120_default_item, 0, yyvs120.upper)
			end
			if yyvs121 /= Void then
				yyvs121.fill_with (l_yyvs121_default_item, 0, yyvs121.upper)
			end
			if yyvs122 /= Void then
				yyvs122.fill_with (l_yyvs122_default_item, 0, yyvs122.upper)
			end
			if yyvs123 /= Void then
				yyvs123.fill_with (l_yyvs123_default_item, 0, yyvs123.upper)
			end
			if yyvs124 /= Void then
				yyvs124.fill_with (l_yyvs124_default_item, 0, yyvs124.upper)
			end
			if yyvs125 /= Void then
				yyvs125.fill_with (l_yyvs125_default_item, 0, yyvs125.upper)
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
				yyvs1.put (last_any_value, yyvsp1)
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
				yyvs4.put (last_symbol_as_value, yyvsp4)
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
				yyvs12.put (last_keyword_as_value, yyvsp12)
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
				yyvs3.put (last_char_as_value, yyvsp3)
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
				yyvs5.put (last_bool_as_value, yyvsp5)
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
				yyvs6.put (last_result_as_value, yyvsp6)
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
				yyvs7.put (last_retry_as_value, yyvsp7)
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
				yyvs8.put (last_unique_as_value, yyvsp8)
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
				yyvs9.put (last_current_as_value, yyvsp9)
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
				yyvs10.put (last_deferred_as_value, yyvsp10)
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
				yyvs11.put (last_void_as_value, yyvsp11)
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
				yyvs15.put (last_keyword_id_value, yyvsp15)
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
				yyvs16.put (last_string_as_value, yyvsp16)
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
			yyvs1.put (yyval1, yyvsp1)
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
			when 124 then
				yyvsp124 := yyvsp124 - 1
			when 125 then
				yyvsp125 := yyvsp125 - 1
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
		local
			yyval1: ANY
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_2
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not type_parser or expression_parser or feature_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				type_node := yyvs83.item (yyvsp83)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp83 := yyvsp83 -1
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

	yy_do_action_3
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not feature_parser or type_parser or expression_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				feature_node := yyvs55.item (yyvsp55)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp55 := yyvsp55 -1
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

	yy_do_action_4
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not expression_parser or type_parser or feature_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				expression_node := yyvs27.item (yyvsp27)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_5
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not indexing_parser or type_parser or expression_parser or feature_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				indexing_node := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp109 := yyvsp109 -1
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

	yy_do_action_6
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not invariant_parser or type_parser or expression_parser or feature_parser or indexing_parser or entity_declaration_parser then
					raise_error
				end
				invariant_node := yyvs67.item (yyvsp67)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp67 := yyvsp67 -1
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

	yy_do_action_7
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
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

	yy_do_action_8
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not entity_declaration_parser or type_parser or expression_parser or feature_parser or indexing_parser or invariant_parser then
					raise_error
				end
				entity_declaration_node := yyvs120.item (yyvsp120)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp12 := yyvsp12 -1
	yyvsp120 := yyvsp120 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_9
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs22.item (yyvsp22 - 1) /= Void then
					temp_string_as1 := yyvs22.item (yyvsp22 - 1).second
				else
					temp_string_as1 := Void
				end
				if yyvs22.item (yyvsp22) /= Void then
					temp_string_as2 := yyvs22.item (yyvsp22).second
				else
					temp_string_as2 := Void
				end
				
				root_node := new_class_description (yyvs2.item (yyvsp2), temp_string_as1,
					is_deferred, is_expanded, is_separate, is_frozen_class, is_external_class, is_partial_class,
					yyvs109.item (yyvsp109 - 1), yyvs109.item (yyvsp109), yyvs107.item (yyvsp107), yyvs114.item (yyvsp114 - 1), yyvs114.item (yyvsp114), yyvs93.item (yyvsp93), yyvs92.item (yyvsp92), yyvs100.item (yyvsp100), yyvs67.item (yyvsp67), suppliers, temp_string_as2, yyvs12.item (yyvsp12))
				if root_node /= Void then
					root_node.set_text_positions (
						formal_generics_end_position,				conforming_inheritance_end_position,	non_conforming_inheritance_end_position,
						features_end_position)
						if yyvs22.item (yyvsp22 - 1) /= Void then
							root_node.set_alias_keyword (yyvs22.item (yyvsp22 - 1).first)
						end
						if yyvs22.item (yyvsp22) /= Void then
							root_node.set_obsolete_keyword (yyvs22.item (yyvsp22).first)
						end
						root_node.set_header_mark (frozen_keyword, expanded_keyword, deferred_keyword, separate_keyword, external_keyword)
						root_node.set_class_keyword (yyvs12.item (yyvsp12 - 1))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 19
	yyvsp1 := yyvsp1 -4
	yyvsp109 := yyvsp109 -2
	yyvsp12 := yyvsp12 -2
	yyvsp2 := yyvsp2 -1
	yyvsp107 := yyvsp107 -1
	yyvsp22 := yyvsp22 -2
	yyvsp114 := yyvsp114 -2
	yyvsp93 := yyvsp93 -1
	yyvsp92 := yyvsp92 -1
	yyvsp100 := yyvsp100 -1
	yyvsp67 := yyvsp67 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_10
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

conforming_inheritance_flag := False; non_conforming_inheritance_flag := False 
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

	yy_do_action_11
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

conforming_inheritance_end_position := position; conforming_inheritance_flag := True
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

	yy_do_action_12
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

non_conforming_inheritance_end_position := position
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

	yy_do_action_13
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

features_end_position := position 
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

	yy_do_action_14
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

feature_clause_end_position := position 
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

	yy_do_action_15
			--|#line <not available> "eiffel.y"
		local
			yyval109: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


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

	yy_do_action_16
			--|#line <not available> "eiffel.y"
		local
			yyval109: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := yyvs109.item (yyvsp109)
				if yyval109 /= Void then
					yyval109.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
				end				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp15 := yyvsp15 -1
	yyvsp1 := yyvsp1 -2
	yyvs109.put (yyval109, yyvsp109)
end
		end

	yy_do_action_17
			--|#line <not available> "eiffel.y"
		local
			yyval109: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := ast_factory.new_indexing_clause_as (0)
				if yyval109 /= Void then
					yyval109.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp109 := yyvsp109 + 1
	yyvsp15 := yyvsp15 -1
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

	yy_do_action_18
			--|#line <not available> "eiffel.y"
		local
			yyval109: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := yyvs109.item (yyvsp109)
				if yyval109 /= Void then
					yyval109.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
				end				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp15 := yyvsp15 -1
	yyvsp1 := yyvsp1 -2
	yyvs109.put (yyval109, yyvsp109)
end
		end

	yy_do_action_19
			--|#line <not available> "eiffel.y"
		local
			yyval109: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := ast_factory.new_indexing_clause_as (0)
				if yyval109 /= Void then
					yyval109.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp109 := yyvsp109 + 1
	yyvsp15 := yyvsp15 -1
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

	yy_do_action_20
			--|#line <not available> "eiffel.y"
		local
			yyval109: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


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

	yy_do_action_21
			--|#line <not available> "eiffel.y"
		local
			yyval109: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := ast_factory.new_indexing_clause_as (0)
				if yyval109 /= Void then
						yyval109.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
						yyval109.set_end_keyword (yyvs12.item (yyvsp12))
				end		
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Missing `attribute' keyword before `end' keyword."))
				end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp109 := yyvsp109 + 1
	yyvsp15 := yyvsp15 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_22
			--|#line <not available> "eiffel.y"
		local
			yyval109: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := yyvs109.item (yyvsp109)
				if yyval109 /= Void then
					if yyvs15.item (yyvsp15) /= Void then
						yyval109.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
					end
					if yyvs12.item (yyvsp12) /= Void then	
						yyval109.set_end_keyword (yyvs12.item (yyvsp12))
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
	yyvs109.put (yyval109, yyvsp109)
end
		end

	yy_do_action_23
			--|#line <not available> "eiffel.y"
		local
			yyval109: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := ast_factory.new_indexing_clause_as (counter_value + 1)
				if yyval109 /= Void and yyvs62.item (yyvsp62) /= Void then
					yyval109.reverse_extend (yyvs62.item (yyvsp62))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp109 := yyvsp109 + 1
	yyvsp62 := yyvsp62 -1
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

	yy_do_action_24
			--|#line <not available> "eiffel.y"
		local
			yyval109: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := yyvs109.item (yyvsp109)
				if yyval109 /= Void and yyvs62.item (yyvsp62) /= Void then
					yyval109.reverse_extend (yyvs62.item (yyvsp62))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp1 := yyvsp1 -1
	yyvs109.put (yyval109, yyvsp109)
end
		end

	yy_do_action_25
			--|#line <not available> "eiffel.y"
		local
			yyval109: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := ast_factory.new_indexing_clause_as (counter_value + 1)
				if yyval109 /= Void and yyvs62.item (yyvsp62) /= Void then
					yyval109.reverse_extend (yyvs62.item (yyvsp62))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp109 := yyvsp109 + 1
	yyvsp62 := yyvsp62 -1
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

	yy_do_action_26
			--|#line <not available> "eiffel.y"
		local
			yyval109: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := yyvs109.item (yyvsp109)
				if yyval109 /= Void and yyvs62.item (yyvsp62) /= Void then
					yyval109.reverse_extend (yyvs62.item (yyvsp62))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp62 := yyvsp62 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs109.put (yyval109, yyvsp109)
end
		end

	yy_do_action_27
			--|#line <not available> "eiffel.y"
		local
			yyval62: INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_28
			--|#line <not available> "eiffel.y"
		local
			yyval62: INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_29
			--|#line <not available> "eiffel.y"
		local
			yyval62: INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval62 := ast_factory.new_index_as (yyvs2.item (yyvsp2), yyvs90.item (yyvsp90), yyvs4.item (yyvsp4 - 1))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp62 := yyvsp62 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp90 := yyvsp90 -1
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

	yy_do_action_30
			--|#line <not available> "eiffel.y"
		local
			yyval62: INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval62 := ast_factory.new_index_as (Void, yyvs90.item (yyvsp90), Void)
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs90.item (yyvsp90)), token_column (yyvs90.item (yyvsp90)), filename,
						once "Missing `Index' part of `Index_clause'."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 + 1
	yyvsp90 := yyvsp90 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_31
			--|#line <not available> "eiffel.y"
		local
			yyval62: INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval62 := ast_factory.new_index_as (yyvs2.item (yyvsp2), yyvs90.item (yyvsp90), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp90 := yyvsp90 -1
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

	yy_do_action_32
			--|#line <not available> "eiffel.y"
		local
			yyval90: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval90 := ast_factory.new_eiffel_list_atomic_as (counter_value + 1)
				if yyval90 /= Void and yyvs36.item (yyvsp36) /= Void then
					yyval90.reverse_extend (yyvs36.item (yyvsp36))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp90 := yyvsp90 + 1
	yyvsp36 := yyvsp36 -1
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

	yy_do_action_33
			--|#line <not available> "eiffel.y"
		local
			yyval90: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval90 := yyvs90.item (yyvsp90)
				if yyval90 /= Void and yyvs36.item (yyvsp36) /= Void then
					yyval90.reverse_extend (yyvs36.item (yyvsp36))
					ast_factory.reverse_extend_separator (yyval90, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp36 := yyvsp36 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs90.put (yyval90, yyvsp90)
end
		end

	yy_do_action_34
			--|#line <not available> "eiffel.y"
		local
			yyval90: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval90 := ast_factory.new_eiffel_list_atomic_as (0)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp90 := yyvsp90 + 1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_35
			--|#line <not available> "eiffel.y"
		local
			yyval90: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval90 := ast_factory.new_eiffel_list_atomic_as (counter_value + 1)
				if yyval90 /= Void and yyvs36.item (yyvsp36) /= Void then
					yyval90.reverse_extend (yyvs36.item (yyvsp36))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp90 := yyvsp90 + 1
	yyvsp36 := yyvsp36 -1
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

	yy_do_action_36
			--|#line <not available> "eiffel.y"
		local
			yyval90: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval90 := yyvs90.item (yyvsp90)
				if yyval90 /= Void and yyvs36.item (yyvsp36) /= Void then
					yyval90.reverse_extend (yyvs36.item (yyvsp36))
					ast_factory.reverse_extend_separator (yyval90, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp36 := yyvsp36 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs90.put (yyval90, yyvsp90)
end
		end

	yy_do_action_37
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_38
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs36.item (yyvsp36) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs36.put (yyval36, yyvsp36)
end
		end

	yy_do_action_39
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := ast_factory.new_custom_attribute_as (yyvs48.item (yyvsp48), Void, yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp36 := yyvsp36 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp48 := yyvsp48 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_40
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := ast_factory.new_custom_attribute_as (yyvs48.item (yyvsp48), yyvs82.item (yyvsp82), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp36 := yyvsp36 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp48 := yyvsp48 -1
	yyvsp82 := yyvsp82 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_41
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			is_supplier_recorded := False
		
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

	yy_do_action_42
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			is_supplier_recorded := True
		
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

	yy_do_action_43
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
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

	yy_do_action_44
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
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

	yy_do_action_45
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_46
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_47
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_48
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_49
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
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

	yy_do_action_50
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_51
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
					external_keyword := yyvs12.item (yyvsp12)
				else
						-- Trigger a syntax error.
					raise_error
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_52
			--|#line <not available> "eiffel.y"
		local
			yyval12: KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval12 := yyvs12.item (yyvsp12);
				is_partial_class := false;
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs12.put (yyval12, yyvsp12)
end
		end

	yy_do_action_53
			--|#line <not available> "eiffel.y"
		local
			yyval12: KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval12 := yyvs12.item (yyvsp12);
			is_partial_class := true;
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs12.put (yyval12, yyvsp12)
end
		end

	yy_do_action_54
			--|#line <not available> "eiffel.y"
		local
			yyval22: PAIR [KEYWORD_AS, STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_55
			--|#line <not available> "eiffel.y"
		local
			yyval22: PAIR [KEYWORD_AS, STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval22 := ast_factory.new_keyword_string_pair (yyvs12.item (yyvsp12), yyvs16.item (yyvsp16))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp22 := yyvsp22 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp16 := yyvsp16 -1
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

	yy_do_action_56
			--|#line <not available> "eiffel.y"
		local
			yyval100: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp100 := yyvsp100 + 1
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

	yy_do_action_57
			--|#line <not available> "eiffel.y"
		local
			yyval100: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval100 := yyvs100.item (yyvsp100)
				if yyval100 /= Void and then yyval100.is_empty then
					yyval100 := Void
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs100.put (yyval100, yyvsp100)
end
		end

	yy_do_action_58
			--|#line <not available> "eiffel.y"
		local
			yyval100: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval100 := ast_factory.new_eiffel_list_feature_clause_as (counter_value + 1)
				if yyval100 /= Void and yyvs56.item (yyvsp56) /= Void then
					yyval100.reverse_extend (yyvs56.item (yyvsp56))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp100 := yyvsp100 + 1
	yyvsp56 := yyvsp56 -1
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

	yy_do_action_59
			--|#line <not available> "eiffel.y"
		local
			yyval100: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval100 := yyvs100.item (yyvsp100)
				if yyval100 /= Void and yyvs56.item (yyvsp56) /= Void then
					yyval100.reverse_extend (yyvs56.item (yyvsp56))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp56 := yyvsp56 -1
	yyvsp1 := yyvsp1 -1
	yyvs100.put (yyval100, yyvsp100)
end
		end

	yy_do_action_60
			--|#line <not available> "eiffel.y"
		local
			yyval56: FEATURE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval56 := ast_factory.new_feature_clause_as (yyvs43.item (yyvsp43),
				ast_factory.new_eiffel_list_feature_as (0), fclause_pos, feature_clause_end_position) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp56 := yyvsp56 + 1
	yyvsp43 := yyvsp43 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_61
			--|#line <not available> "eiffel.y"
		local
			yyval56: FEATURE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval56 := ast_factory.new_feature_clause_as (yyvs43.item (yyvsp43), yyvs99.item (yyvsp99), fclause_pos, feature_clause_end_position) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp56 := yyvsp56 + 1
	yyvsp43 := yyvsp43 -1
	yyvsp1 := yyvsp1 -3
	yyvsp99 := yyvsp99 -1
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

	yy_do_action_62
			--|#line <not available> "eiffel.y"
		local
			yyval43: CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval43 := yyvs43.item (yyvsp43) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp43 := yyvsp43 -1
	yyvsp12 := yyvsp12 -1
	yyvs43.put (yyval43, yyvsp43)
end
		end

	yy_do_action_63
			--|#line <not available> "eiffel.y"
		local
			yyval43: CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				fclause_pos := yyvs12.item (yyvsp12)
				if yyvs12.item (yyvsp12) /= Void then
						-- Originally, it was 8, I changed it to 7, delete the following line when fully tested. (Jason)
					fclause_pos.set_position (line, column, position, 7)
				else
						-- Originally, it was 8, I changed it to 7 (Jason)
					fclause_pos := ast_factory.new_feature_keyword_as (line, column, position, 7, Current)
				end
				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp43 := yyvsp43 + 1
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

	yy_do_action_64
			--|#line <not available> "eiffel.y"
		local
			yyval43: CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp43 := yyvsp43 + 1
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

	yy_do_action_65
			--|#line <not available> "eiffel.y"
		local
			yyval43: CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval43 := ast_factory.new_client_as (yyvs108.item (yyvsp108)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp43 := yyvsp43 + 1
	yyvsp108 := yyvsp108 -1
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

	yy_do_action_66
			--|#line <not available> "eiffel.y"
		local
			yyval108: CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval108 := ast_factory.new_class_list_as (1)
				if yyval108 /= Void then
					yyval108.reverse_extend (new_none_id)
					yyval108.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					yyval108.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp108 := yyvsp108 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_67
			--|#line <not available> "eiffel.y"
		local
			yyval108: CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval108 := yyvs108.item (yyvsp108)
				if yyval108 /= Void then
					yyval108.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					yyval108.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvs108.put (yyval108, yyvsp108)
end
		end

	yy_do_action_68
			--|#line <not available> "eiffel.y"
		local
			yyval108: CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval108 := ast_factory.new_class_list_as (counter_value + 1)
				if yyval108 /= Void and yyvs2.item (yyvsp2) /= Void then
					yyval108.reverse_extend (yyvs2.item (yyvsp2))
					suppliers.insert_light_supplier_id (yyvs2.item (yyvsp2))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp108 := yyvsp108 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_69
			--|#line <not available> "eiffel.y"
		local
			yyval108: CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval108 := yyvs108.item (yyvsp108)
				if yyval108 /= Void and yyvs2.item (yyvsp2) /= Void then
					yyval108.reverse_extend (yyvs2.item (yyvsp2))
					suppliers.insert_light_supplier_id (yyvs2.item (yyvsp2))
					ast_factory.reverse_extend_separator (yyval108, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs108.put (yyval108, yyvsp108)
end
		end

	yy_do_action_70
			--|#line <not available> "eiffel.y"
		local
			yyval99: EIFFEL_LIST [FEATURE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval99 := ast_factory.new_eiffel_list_feature_as (counter_value + 1)
				if yyval99 /= Void and yyvs55.item (yyvsp55) /= Void then
					yyval99.reverse_extend (yyvs55.item (yyvsp55))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp99 := yyvsp99 + 1
	yyvsp55 := yyvsp55 -1
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

	yy_do_action_71
			--|#line <not available> "eiffel.y"
		local
			yyval99: EIFFEL_LIST [FEATURE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval99 := yyvs99.item (yyvsp99)
				if yyval99 /= Void and yyvs55.item (yyvsp55) /= Void then
					yyval99.reverse_extend (yyvs55.item (yyvsp55))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp55 := yyvsp55 -1
	yyvsp1 := yyvsp1 -1
	yyvs99.put (yyval99, yyvsp99)
end
		end

	yy_do_action_72
			--|#line <not available> "eiffel.y"
		local
			yyval4: SYMBOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
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
	yyvs4.put (yyval4, yyvsp4)
end
		end

	yy_do_action_73
			--|#line <not available> "eiffel.y"
		local
			yyval4: SYMBOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs4.put (yyval4, yyvsp4)
end
		end

	yy_do_action_74
			--|#line <not available> "eiffel.y"
		local
			yyval55: FEATURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval55 := ast_factory.new_feature_as (yyvs101.item (yyvsp101), yyvs39.item (yyvsp39), feature_indexes, position)
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
					attached (yyval55) as l_feature_as and then 
					attached l_feature_as.once_as as l_once_as
				then
					if l_once_as.has_key_conflict (yyval55) then
						report_one_error (ast_factory.new_vvok1_error (token_line (l_once_as), token_column (l_once_as), filename, yyval55))
					elseif l_once_as.has_invalid_key (yyval55) then
						if attached l_once_as.invalid_key (yyval55) as l_once_invalid_key then
							report_one_error (ast_factory.new_vvok2_error (token_line (l_once_invalid_key), token_column (l_once_invalid_key), filename, yyval55))
						else
							report_one_error (ast_factory.new_vvok2_error (token_line (l_once_as), token_column (l_once_as), filename, yyval55))
						end
					end
				end

				feature_indexes := Void
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp55 := yyvsp55 + 1
	yyvsp1 := yyvsp1 -3
	yyvsp101 := yyvsp101 -1
	yyvsp39 := yyvsp39 -1
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

	yy_do_action_75
			--|#line <not available> "eiffel.y"
		local
			yyval101: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval101 := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if yyval101 /= Void and yyvs89.item (yyvsp89) /= Void then
					yyval101.reverse_extend (yyvs89.item (yyvsp89))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp101 := yyvsp101 + 1
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_76
			--|#line <not available> "eiffel.y"
		local
			yyval101: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval101 := yyvs101.item (yyvsp101)
				if yyval101 /= Void and yyvs89.item (yyvsp89) /= Void then
					yyval101.reverse_extend (yyvs89.item (yyvsp89))
					ast_factory.reverse_extend_separator (yyval101, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp89 := yyvsp89 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs101.put (yyval101, yyvsp101)
end
		end

	yy_do_action_77
			--|#line <not available> "eiffel.y"
		local
			yyval89: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval89 := yyvs89.item (yyvsp89) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs89.put (yyval89, yyvsp89)
end
		end

	yy_do_action_78
			--|#line <not available> "eiffel.y"
		local
			yyval89: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval89 := yyvs89.item (yyvsp89)
				if yyval89 /= Void then
					yyval89.set_frozen_keyword (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyvs89.put (yyval89, yyvsp89)
end
		end

	yy_do_action_79
			--|#line <not available> "eiffel.y"
		local
			yyval89: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval89 := yyvs89.item (yyvsp89) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs89.put (yyval89, yyvsp89)
end
		end

	yy_do_action_80
			--|#line <not available> "eiffel.y"
		local
			yyval89: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs17.item (yyvsp17) /= Void then
					yyval89 := ast_factory.new_feature_name_alias_as (yyvs2.item (yyvsp2), yyvs17.item (yyvsp17).alias_name, has_convert_mark, yyvs17.item (yyvsp17).alias_keyword, yyvs17.item (yyvsp17).convert_keyword)
				else
					yyval89 := ast_factory.new_feature_name_alias_as (yyvs2.item (yyvsp2), Void, has_convert_mark, Void, Void)
				end
				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp89 := yyvsp89 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp17 := yyvsp17 -1
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

	yy_do_action_81
			--|#line <not available> "eiffel.y"
		local
			yyval89: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval89 := ast_factory.new_feature_name_id_as (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp89 := yyvsp89 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_82
			--|#line <not available> "eiffel.y"
		local
			yyval89: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval89 := yyvs89.item (yyvsp89) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs89.put (yyval89, yyvsp89)
end
		end

	yy_do_action_83
			--|#line <not available> "eiffel.y"
		local
			yyval89: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval89 := yyvs89.item (yyvsp89) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs89.put (yyval89, yyvsp89)
end
		end

	yy_do_action_84
			--|#line <not available> "eiffel.y"
		local
			yyval89: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval89 := ast_factory.new_infix_as (yyvs16.item (yyvsp16), yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use the alias form of the infix routine."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp89 := yyvsp89 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp16 := yyvsp16 -1
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

	yy_do_action_85
			--|#line <not available> "eiffel.y"
		local
			yyval89: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval89 := ast_factory.new_prefix_as (yyvs16.item (yyvsp16), yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use the alias form of the prefix routine."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp89 := yyvsp89 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp16 := yyvsp16 -1
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

	yy_do_action_86
			--|#line <not available> "eiffel.y"
		local
			yyval17: ALIAS_TRIPLE
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

	yy_do_action_87
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_88
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_89
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_90
			--|#line <not available> "eiffel.y"
		local
			yyval12: KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

has_convert_mark := False 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
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
	yyvs12.put (yyval12, yyvsp12)
end
		end

	yy_do_action_91
			--|#line <not available> "eiffel.y"
		local
			yyval12: KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

has_convert_mark := True
				yyval12 := yyvs12.item (yyvsp12)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs12.put (yyval12, yyvsp12)
end
		end

	yy_do_action_92
			--|#line <not available> "eiffel.y"
		local
			yyval12: KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval12 := Void 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
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
	yyvs12.put (yyval12, yyvsp12)
end
		end

	yy_do_action_93
			--|#line <not available> "eiffel.y"
		local
			yyval12: KEYWORD_AS
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

	yy_do_action_94
			--|#line <not available> "eiffel.y"
		local
			yyval39: BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Attribute case
				if yyvs21.item (yyvsp21) = Void then
					yyval39 := ast_factory.new_body_as (Void, yyvs83.item (yyvsp83), Void, Void, yyvs4.item (yyvsp4), Void, Void, yyvs109.item (yyvsp109))
				else
					yyval39 := ast_factory.new_body_as (Void, yyvs83.item (yyvsp83), yyvs21.item (yyvsp21).second, Void, yyvs4.item (yyvsp4), Void, yyvs21.item (yyvsp21).first, yyvs109.item (yyvsp109))
				end				
				feature_indexes := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp39 := yyvsp39 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp83 := yyvsp83 -1
	yyvsp21 := yyvsp21 -1
	yyvsp109 := yyvsp109 -1
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

	yy_do_action_95
			--|#line <not available> "eiffel.y"
		local
			yyval39: BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Constant case
				if yyvs21.item (yyvsp21) = Void then
					yyval39 := ast_factory.new_body_as (Void, yyvs83.item (yyvsp83), Void, yyvs44.item (yyvsp44), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), Void, yyvs109.item (yyvsp109))
				else
					yyval39 := ast_factory.new_body_as (Void, yyvs83.item (yyvsp83), yyvs21.item (yyvsp21).second, yyvs44.item (yyvsp44), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), yyvs21.item (yyvsp21).first, yyvs109.item (yyvsp109))
				end
				
				feature_indexes := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp39 := yyvsp39 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp83 := yyvsp83 -1
	yyvsp21 := yyvsp21 -1
	yyvsp44 := yyvsp44 -1
	yyvsp109 := yyvsp109 -1
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

	yy_do_action_96
			--|#line <not available> "eiffel.y"
		local
			yyval39: BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Constant case
				if yyvs21.item (yyvsp21) = Void then
					yyval39 := ast_factory.new_body_as (Void, yyvs83.item (yyvsp83), Void, yyvs44.item (yyvsp44), yyvs4.item (yyvsp4), extract_keyword (yyvs15.item (yyvsp15)), Void, yyvs109.item (yyvsp109))
				else
					yyval39 := ast_factory.new_body_as (Void, yyvs83.item (yyvsp83), yyvs21.item (yyvsp21).second, yyvs44.item (yyvsp44), yyvs4.item (yyvsp4), extract_keyword (yyvs15.item (yyvsp15)), yyvs21.item (yyvsp21).first, yyvs109.item (yyvsp109))
				end
				
				feature_indexes := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp39 := yyvsp39 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp83 := yyvsp83 -1
	yyvsp21 := yyvsp21 -1
	yyvsp15 := yyvsp15 -1
	yyvsp44 := yyvsp44 -1
	yyvsp109 := yyvsp109 -1
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

	yy_do_action_97
			--|#line <not available> "eiffel.y"
		local
			yyval39: BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- procedure without arguments		
				yyval39 := ast_factory.new_body_as (Void, Void, Void, yyvs80.item (yyvsp80), Void, yyvs12.item (yyvsp12), Void, yyvs109.item (yyvsp109))
				feature_indexes := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp39 := yyvsp39 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp109 := yyvsp109 -1
	yyvsp80 := yyvsp80 -1
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

	yy_do_action_98
			--|#line <not available> "eiffel.y"
		local
			yyval39: BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Function without arguments
				if yyvs21.item (yyvsp21) = Void then
					yyval39 := ast_factory.new_body_as (Void, yyvs83.item (yyvsp83), Void, yyvs80.item (yyvsp80), yyvs4.item (yyvsp4), extract_keyword (yyvs15.item (yyvsp15)), Void, yyvs109.item (yyvsp109))
				else
					yyval39 := ast_factory.new_body_as (Void, yyvs83.item (yyvsp83), yyvs21.item (yyvsp21).second, yyvs80.item (yyvsp80), yyvs4.item (yyvsp4), extract_keyword (yyvs15.item (yyvsp15)), yyvs21.item (yyvsp21).first, yyvs109.item (yyvsp109))
				end
				
				feature_indexes := yyvs109.item (yyvsp109)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp39 := yyvsp39 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp83 := yyvsp83 -1
	yyvsp21 := yyvsp21 -1
	yyvsp15 := yyvsp15 -1
	yyvsp109 := yyvsp109 -1
	yyvsp80 := yyvsp80 -1
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

	yy_do_action_99
			--|#line <not available> "eiffel.y"
		local
			yyval39: BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Function without arguments
				if yyvs21.item (yyvsp21) = Void then
					yyval39 := ast_factory.new_body_as (Void, yyvs83.item (yyvsp83), Void, yyvs80.item (yyvsp80), yyvs4.item (yyvsp4), Void, Void, yyvs109.item (yyvsp109))
				else
					yyval39 := ast_factory.new_body_as (Void, yyvs83.item (yyvsp83), yyvs21.item (yyvsp21).second, yyvs80.item (yyvsp80), yyvs4.item (yyvsp4), Void, yyvs21.item (yyvsp21).first, yyvs109.item (yyvsp109))
				end
				
				feature_indexes := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp39 := yyvsp39 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp83 := yyvsp83 -1
	yyvsp21 := yyvsp21 -1
	yyvsp109 := yyvsp109 -1
	yyvsp80 := yyvsp80 -1
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

	yy_do_action_100
			--|#line <not available> "eiffel.y"
		local
			yyval39: BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- procedure with arguments
				yyval39 := ast_factory.new_body_as (yyvs122.item (yyvsp122), Void, Void, yyvs80.item (yyvsp80), Void, yyvs12.item (yyvsp12), Void, yyvs109.item (yyvsp109))
				feature_indexes := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp39 := yyvsp39 + 1
	yyvsp122 := yyvsp122 -1
	yyvsp12 := yyvsp12 -1
	yyvsp109 := yyvsp109 -1
	yyvsp80 := yyvsp80 -1
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

	yy_do_action_101
			--|#line <not available> "eiffel.y"
		local
			yyval39: BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Function with arguments
				if yyvs21.item (yyvsp21) = Void then
					yyval39 := ast_factory.new_body_as (yyvs122.item (yyvsp122), yyvs83.item (yyvsp83), Void, yyvs80.item (yyvsp80), yyvs4.item (yyvsp4), yyvs12.item (yyvsp12), Void, yyvs109.item (yyvsp109))
				else
					yyval39 := ast_factory.new_body_as (yyvs122.item (yyvsp122), yyvs83.item (yyvsp83), yyvs21.item (yyvsp21).second, yyvs80.item (yyvsp80), yyvs4.item (yyvsp4), yyvs12.item (yyvsp12), yyvs21.item (yyvsp21).first, yyvs109.item (yyvsp109))
				end				
				feature_indexes := yyvs109.item (yyvsp109)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp39 := yyvsp39 + 1
	yyvsp122 := yyvsp122 -1
	yyvsp4 := yyvsp4 -1
	yyvsp83 := yyvsp83 -1
	yyvsp21 := yyvsp21 -1
	yyvsp12 := yyvsp12 -1
	yyvsp109 := yyvsp109 -1
	yyvsp80 := yyvsp80 -1
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

	yy_do_action_102
			--|#line <not available> "eiffel.y"
		local
			yyval21: PAIR [KEYWORD_AS, ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval21 := ast_factory.new_assigner_mark_as (Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
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
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_103
			--|#line <not available> "eiffel.y"
		local
			yyval21: PAIR [KEYWORD_AS, ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval21 := ast_factory.new_assigner_mark_as (extract_keyword (yyvs15.item (yyvsp15)), yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp21 := yyvsp21 + 1
	yyvsp15 := yyvsp15 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_104
			--|#line <not available> "eiffel.y"
		local
			yyval44: CONSTANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				setup_binary_manifest_string (yyvs36.item (yyvsp36))
				yyval44 := ast_factory.new_constant_as (yyvs36.item (yyvsp36)) 
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp44 := yyvsp44 + 1
	yyvsp36 := yyvsp36 -1
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

	yy_do_action_105
			--|#line <not available> "eiffel.y"
		local
			yyval44: CONSTANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval44 := ast_factory.new_constant_as (yyvs8.item (yyvsp8)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp44 := yyvsp44 + 1
	yyvsp8 := yyvsp8 -1
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

	yy_do_action_106
			--|#line <not available> "eiffel.y"
		local
			yyval114: PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval114 := Void 
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

	yy_do_action_107
			--|#line <not available> "eiffel.y"
		local
			yyval114: PARENT_LIST_AS
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
					yyval114 := ast_factory.new_eiffel_list_parent_as (0)
					if yyval114 /= Void then
						yyval114.set_inheritance_tokens (yyvs12.item (yyvsp12), Void, Void, Void)
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
	yyvsp114 := yyvsp114 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_108
			--|#line <not available> "eiffel.y"
		local
			yyval114: PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not conforming_inheritance_flag then
						-- Conforming inheritance
					yyval114 := yyvs114.item (yyvsp114)
					if yyval114 /= Void then
						yyval114.set_inheritance_tokens (yyvs12.item (yyvsp12), Void, Void, Void)
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
	yyvs114.put (yyval114, yyvsp114)
end
		end

	yy_do_action_109
			--|#line <not available> "eiffel.y"
		local
			yyval114: PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval114 := yyvs114.item (yyvsp114)
				if yyval114 /= Void then
					yyval114.set_inheritance_tokens (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4 - 1), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp114 := yyvsp114 -1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -2
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvs114.put (yyval114, yyvsp114)
end
		end

	yy_do_action_110
			--|#line <not available> "eiffel.y"
		local
			yyval114: PARENT_LIST_AS
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

	yy_do_action_111
			--|#line <not available> "eiffel.y"
		local
			yyval114: PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval114 := ast_factory.new_eiffel_list_parent_as (counter_value + 1)
				if yyval114 /= Void and yyvs72.item (yyvsp72) /= Void then
					yyval114.reverse_extend (yyvs72.item (yyvsp72))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp114 := yyvsp114 + 1
	yyvsp72 := yyvsp72 -1
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

	yy_do_action_112
			--|#line <not available> "eiffel.y"
		local
			yyval114: PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval114 := yyvs114.item (yyvsp114)
				if yyval114 /= Void and yyvs72.item (yyvsp72) /= Void then
					yyval114.reverse_extend (yyvs72.item (yyvsp72))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp72 := yyvsp72 -1
	yyvsp1 := yyvsp1 -1
	yyvs114.put (yyval114, yyvsp114)
end
		end

	yy_do_action_113
			--|#line <not available> "eiffel.y"
		local
			yyval72: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs72.put (yyval72, yyvsp72)
end
		end

	yy_do_action_114
			--|#line <not available> "eiffel.y"
		local
			yyval86: CLASS_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval86 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), yyvs119.item (yyvsp119)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp86 := yyvsp86 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp119 := yyvsp119 -1
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

	yy_do_action_115
			--|#line <not available> "eiffel.y"
		local
			yyval72: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := ast_factory.new_parent_as (yyvs86.item (yyvsp86), Void, Void, Void, Void, Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp72 := yyvsp72 + 1
	yyvsp86 := yyvsp86 -1
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

	yy_do_action_116
			--|#line <not available> "eiffel.y"
		local
			yyval72: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if non_conforming_inheritance_flag then
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs106.item (yyvsp106).first), token_column (yyvs106.item (yyvsp106).first), filename, "Non-conforming inheritance may not use select clause"))
				end
				yyval72 := ast_factory.new_parent_as (yyvs86.item (yyvsp86), Void, Void, Void, Void, yyvs106.item (yyvsp106).second, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp72 := yyvsp72 + 1
	yyvsp86 := yyvsp86 -1
	yyvsp106 := yyvsp106 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_117
			--|#line <not available> "eiffel.y"
		local
			yyval72: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if non_conforming_inheritance_flag and then yyvs106.item (yyvsp106) /= Void then
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs106.item (yyvsp106).first), token_column (yyvs106.item (yyvsp106).first), filename, "Non-conforming inheritance may not use select clause"))
				end
				yyval72 := ast_factory.new_parent_as (yyvs86.item (yyvsp86), Void, Void, Void, yyvs104.item (yyvsp104), yyvs106.item (yyvsp106).second, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp72 := yyvsp72 + 1
	yyvsp86 := yyvsp86 -1
	yyvsp104 := yyvsp104 -1
	yyvsp106 := yyvsp106 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_118
			--|#line <not available> "eiffel.y"
		local
			yyval72: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if non_conforming_inheritance_flag and then yyvs106.item (yyvsp106) /= Void then
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs106.item (yyvsp106).first), token_column (yyvs106.item (yyvsp106).first), filename, "Non-conforming inheritance may not use select clause"))
				end
				yyval72 := ast_factory.new_parent_as (yyvs86.item (yyvsp86), Void, Void, yyvs103.item (yyvsp103), yyvs104.item (yyvsp104), yyvs106.item (yyvsp106).second, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp72 := yyvsp72 + 1
	yyvsp86 := yyvsp86 -1
	yyvsp103 := yyvsp103 -1
	yyvsp104 := yyvsp104 -1
	yyvsp106 := yyvsp106 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_119
			--|#line <not available> "eiffel.y"
		local
			yyval72: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if non_conforming_inheritance_flag and then yyvs106.item (yyvsp106) /= Void then
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs106.item (yyvsp106).first), token_column (yyvs106.item (yyvsp106).first), filename, "Non-conforming inheritance may not use select clause"))
				end
				yyval72 := ast_factory.new_parent_as (yyvs86.item (yyvsp86), Void, yyvs96.item (yyvsp96), yyvs103.item (yyvsp103), yyvs104.item (yyvsp104), yyvs106.item (yyvsp106).second, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp72 := yyvsp72 + 1
	yyvsp86 := yyvsp86 -1
	yyvsp96 := yyvsp96 -1
	yyvsp103 := yyvsp103 -1
	yyvsp104 := yyvsp104 -1
	yyvsp106 := yyvsp106 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_120
			--|#line <not available> "eiffel.y"
		local
			yyval72: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if non_conforming_inheritance_flag and then yyvs106.item (yyvsp106) /= Void then
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs106.item (yyvsp106).first), token_column (yyvs106.item (yyvsp106).first), filename, "Non-conforming inheritance may not use select clause"))
				end
				yyval72 := ast_factory.new_parent_as (yyvs86.item (yyvsp86), yyvs116.item (yyvsp116), yyvs96.item (yyvsp96), yyvs103.item (yyvsp103), yyvs104.item (yyvsp104), yyvs106.item (yyvsp106).second, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp72 := yyvsp72 + 1
	yyvsp86 := yyvsp86 -1
	yyvsp116 := yyvsp116 -1
	yyvsp96 := yyvsp96 -1
	yyvsp103 := yyvsp103 -1
	yyvsp104 := yyvsp104 -1
	yyvsp106 := yyvsp106 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_121
			--|#line <not available> "eiffel.y"
		local
			yyval116: RENAME_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval116 := ast_factory.new_rename_clause_as (Void, yyvs12.item (yyvsp12))
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
	yyvsp116 := yyvsp116 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_122
			--|#line <not available> "eiffel.y"
		local
			yyval116: RENAME_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval116 := ast_factory.new_rename_clause_as (yyvs115.item (yyvsp115), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp116 := yyvsp116 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -2
	yyvsp115 := yyvsp115 -1
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

	yy_do_action_123
			--|#line <not available> "eiffel.y"
		local
			yyval115: EIFFEL_LIST [RENAME_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval115 := ast_factory.new_eiffel_list_rename_as (counter_value + 1)
				if yyval115 /= Void and yyvs76.item (yyvsp76) /= Void then
					yyval115.reverse_extend (yyvs76.item (yyvsp76))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp115 := yyvsp115 + 1
	yyvsp76 := yyvsp76 -1
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

	yy_do_action_124
			--|#line <not available> "eiffel.y"
		local
			yyval115: EIFFEL_LIST [RENAME_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval115 := yyvs115.item (yyvsp115)
				if yyval115 /= Void and yyvs76.item (yyvsp76) /= Void then
					yyval115.reverse_extend (yyvs76.item (yyvsp76))
					ast_factory.reverse_extend_separator (yyval115, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp76 := yyvsp76 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs115.put (yyval115, yyvsp115)
end
		end

	yy_do_action_125
			--|#line <not available> "eiffel.y"
		local
			yyval76: RENAME_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval76 := ast_factory.new_rename_as (yyvs89.item (yyvsp89 - 1), yyvs89.item (yyvsp89), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp76 := yyvsp76 + 1
	yyvsp89 := yyvsp89 -2
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_126
			--|#line <not available> "eiffel.y"
		local
			yyval96: EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


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

	yy_do_action_127
			--|#line <not available> "eiffel.y"
		local
			yyval96: EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval96 := yyvs96.item (yyvsp96) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs96.put (yyval96, yyvsp96)
end
		end

	yy_do_action_128
			--|#line <not available> "eiffel.y"
		local
			yyval96: EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval96 := ast_factory.new_export_clause_as (yyvs95.item (yyvsp95), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp96 := yyvsp96 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -2
	yyvsp95 := yyvsp95 -1
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

	yy_do_action_129
			--|#line <not available> "eiffel.y"
		local
			yyval96: EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval96 := ast_factory.new_export_clause_as (Void, yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp96 := yyvsp96 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_130
			--|#line <not available> "eiffel.y"
		local
			yyval95: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval95 := ast_factory.new_eiffel_list_export_item_as (counter_value + 1)
				if yyval95 /= Void and yyvs52.item (yyvsp52) /= Void then
					yyval95.reverse_extend (yyvs52.item (yyvsp52))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp95 := yyvsp95 + 1
	yyvsp52 := yyvsp52 -1
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

	yy_do_action_131
			--|#line <not available> "eiffel.y"
		local
			yyval95: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval95 := yyvs95.item (yyvsp95)
				if yyval95 /= Void and yyvs52.item (yyvsp52) /= Void then
					yyval95.reverse_extend (yyvs52.item (yyvsp52))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp52 := yyvsp52 -1
	yyvsp1 := yyvsp1 -1
	yyvs95.put (yyval95, yyvsp95)
end
		end

	yy_do_action_132
			--|#line <not available> "eiffel.y"
		local
			yyval52: EXPORT_ITEM_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					yyval52 := ast_factory.new_export_item_as (ast_factory.new_client_as (yyvs108.item (yyvsp108)), yyvs57.item (yyvsp57))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp52 := yyvsp52 + 1
	yyvsp108 := yyvsp108 -1
	yyvsp57 := yyvsp57 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_133
			--|#line <not available> "eiffel.y"
		local
			yyval57: FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp57 := yyvsp57 + 1
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

	yy_do_action_134
			--|#line <not available> "eiffel.y"
		local
			yyval57: FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := ast_factory.new_all_as (yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp57 := yyvsp57 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_135
			--|#line <not available> "eiffel.y"
		local
			yyval57: FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := ast_factory.new_feature_list_as (yyvs101.item (yyvsp101)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp57 := yyvsp57 + 1
	yyvsp101 := yyvsp101 -1
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

	yy_do_action_136
			--|#line <not available> "eiffel.y"
		local
			yyval92: CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_137
			--|#line <not available> "eiffel.y"
		local
			yyval92: CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval92 := yyvs92.item (yyvsp92)
			if yyval92 /= Void then
				yyval92.set_convert_keyword (yyvs12.item (yyvsp12))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -2
	yyvs92.put (yyval92, yyvsp92)
end
		end

	yy_do_action_138
			--|#line <not available> "eiffel.y"
		local
			yyval92: CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval92 := ast_factory.new_eiffel_list_convert (counter_value + 1)
			if yyval92 /= Void and yyvs45.item (yyvsp45) /= Void then
				yyval92.reverse_extend (yyvs45.item (yyvsp45))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp92 := yyvsp92 + 1
	yyvsp45 := yyvsp45 -1
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

	yy_do_action_139
			--|#line <not available> "eiffel.y"
		local
			yyval92: CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval92 := yyvs92.item (yyvsp92)
			if yyval92 /= Void and yyvs45.item (yyvsp45) /= Void then
				yyval92.reverse_extend (yyvs45.item (yyvsp45))
				ast_factory.reverse_extend_separator (yyval92, yyvs4.item (yyvsp4))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp45 := yyvsp45 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs92.put (yyval92, yyvsp92)
end
		end

	yy_do_action_140
			--|#line <not available> "eiffel.y"
		local
			yyval45: CONVERT_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- True because this is a conversion feature used as a creation
				-- procedure in current class.
			yyval45 := ast_factory.new_convert_feat_as (True, yyvs89.item (yyvsp89), yyvs119.item (yyvsp119), yyvs4.item (yyvsp4 - 3), yyvs4.item (yyvsp4), Void, yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp45 := yyvsp45 + 1
	yyvsp89 := yyvsp89 -1
	yyvsp4 := yyvsp4 -4
	yyvsp119 := yyvsp119 -1
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

	yy_do_action_141
			--|#line <not available> "eiffel.y"
		local
			yyval45: CONVERT_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- False because this is not a conversion feature used as a creation
				-- procedure.
			yyval45 := ast_factory.new_convert_feat_as (False, yyvs89.item (yyvsp89), yyvs119.item (yyvsp119), Void, Void, yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp45 := yyvsp45 + 1
	yyvsp89 := yyvsp89 -1
	yyvsp4 := yyvsp4 -3
	yyvsp119 := yyvsp119 -1
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

	yy_do_action_142
			--|#line <not available> "eiffel.y"
		local
			yyval101: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval101 := yyvs101.item (yyvsp101) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs101.put (yyval101, yyvsp101)
end
		end

	yy_do_action_143
			--|#line <not available> "eiffel.y"
		local
			yyval101: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval101 := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if yyval101 /= Void and yyvs89.item (yyvsp89) /= Void then
					yyval101.reverse_extend (yyvs89.item (yyvsp89))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp101 := yyvsp101 + 1
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_144
			--|#line <not available> "eiffel.y"
		local
			yyval101: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval101 := yyvs101.item (yyvsp101)
				if yyval101 /= Void and yyvs89.item (yyvsp89) /= Void then
					yyval101.reverse_extend (yyvs89.item (yyvsp89))
					ast_factory.reverse_extend_separator (yyval101, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp89 := yyvsp89 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs101.put (yyval101, yyvsp101)
end
		end

	yy_do_action_145
			--|#line <not available> "eiffel.y"
		local
			yyval103: UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_146
			--|#line <not available> "eiffel.y"
		local
			yyval103: UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval103 := yyvs103.item (yyvsp103) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs103.put (yyval103, yyvsp103)
end
		end

	yy_do_action_147
			--|#line <not available> "eiffel.y"
		local
			yyval103: UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval103 := ast_factory.new_undefine_clause_as (Void, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp103 := yyvsp103 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_148
			--|#line <not available> "eiffel.y"
		local
			yyval103: UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval103 := ast_factory.new_undefine_clause_as (yyvs101.item (yyvsp101), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp103 := yyvsp103 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp101 := yyvsp101 -1
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

	yy_do_action_149
			--|#line <not available> "eiffel.y"
		local
			yyval104: REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_150
			--|#line <not available> "eiffel.y"
		local
			yyval104: REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval104 := yyvs104.item (yyvsp104) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs104.put (yyval104, yyvsp104)
end
		end

	yy_do_action_151
			--|#line <not available> "eiffel.y"
		local
			yyval104: REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval104 := ast_factory.new_redefine_clause_as (Void, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp104 := yyvsp104 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_152
			--|#line <not available> "eiffel.y"
		local
			yyval104: REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval104 := ast_factory.new_redefine_clause_as (yyvs101.item (yyvsp101), yyvs12.item (yyvsp12))				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp104 := yyvsp104 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp101 := yyvsp101 -1
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

	yy_do_action_153
			--|#line <not available> "eiffel.y"
		local
			yyval106: PAIR [KEYWORD_AS, SELECT_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp106 := yyvsp106 + 1
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

	yy_do_action_154
			--|#line <not available> "eiffel.y"
		local
			yyval106: PAIR [KEYWORD_AS, SELECT_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval106 := yyvs106.item (yyvsp106) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs106.put (yyval106, yyvsp106)
end
		end

	yy_do_action_155
			--|#line <not available> "eiffel.y"
		local
			yyval106: PAIR [KEYWORD_AS, SELECT_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				create yyval106.make (yyvs12.item (yyvsp12), ast_factory.new_select_clause_as (Void, yyvs12.item (yyvsp12)))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp106 := yyvsp106 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_156
			--|#line <not available> "eiffel.y"
		local
			yyval106: PAIR [KEYWORD_AS, SELECT_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				create yyval106.make (yyvs12.item (yyvsp12), ast_factory.new_select_clause_as (yyvs101.item (yyvsp101), yyvs12.item (yyvsp12)))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp106 := yyvsp106 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp101 := yyvsp101 -1
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

	yy_do_action_157
			--|#line <not available> "eiffel.y"
		local
			yyval122: FORMAL_ARGU_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval122 := ast_factory.new_formal_argu_dec_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp122 := yyvsp122 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp122 >= yyvsc122 then
		if yyvs122 = Void then
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
	yyvs122.put (yyval122, yyvsp122)
end
		end

	yy_do_action_158
			--|#line <not available> "eiffel.y"
		local
			yyval122: FORMAL_ARGU_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval122 := ast_factory.new_formal_argu_dec_list_as (yyvs120.item (yyvsp120), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp122 := yyvsp122 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp120 := yyvsp120 -1
	if yyvsp122 >= yyvsc122 then
		if yyvs122 = Void then
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
	yyvs122.put (yyval122, yyvsp122)
end
		end

	yy_do_action_159
			--|#line <not available> "eiffel.y"
		local
			yyval120: TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval120 := ast_factory.new_eiffel_list_type_dec_as (counter_value + 1)
				if yyval120 /= Void and yyvs87.item (yyvsp87) /= Void then
					yyval120.reverse_extend (yyvs87.item (yyvsp87))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp120 := yyvsp120 + 1
	yyvsp87 := yyvsp87 -1
	if yyvsp120 >= yyvsc120 then
		if yyvs120 = Void then
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
	yyvs120.put (yyval120, yyvsp120)
end
		end

	yy_do_action_160
			--|#line <not available> "eiffel.y"
		local
			yyval120: TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval120 := yyvs120.item (yyvsp120)
				if yyval120 /= Void and yyvs87.item (yyvsp87) /= Void then
					yyval120.reverse_extend (yyvs87.item (yyvsp87))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp87 := yyvsp87 -1
	yyvsp1 := yyvsp1 -1
	yyvs120.put (yyval120, yyvsp120)
end
		end

	yy_do_action_161
			--|#line <not available> "eiffel.y"
		local
			yyval87: TYPE_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval87 := ast_factory.new_type_dec_as (yyvs23.item (yyvsp23), yyvs83.item (yyvsp83), yyvs4.item (yyvsp4 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp87 := yyvsp87 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp23 := yyvsp23 -1
	yyvsp4 := yyvsp4 -2
	yyvsp83 := yyvsp83 -1
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

	yy_do_action_162
			--|#line <not available> "eiffel.y"
		local
			yyval23: IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval23 := ast_factory.new_identifier_list (counter_value + 1)
				if yyval23 /= Void and yyvs2.item (yyvsp2) /= Void then
					yyval23.reverse_extend (yyvs2.item (yyvsp2).name_id)
					ast_factory.reverse_extend_identifier (yyval23, yyvs2.item (yyvsp2))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp23 := yyvsp23 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_163
			--|#line <not available> "eiffel.y"
		local
			yyval23: IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval23 := yyvs23.item (yyvsp23)
				if yyval23 /= Void and yyvs2.item (yyvsp2) /= Void then
					yyval23.reverse_extend (yyvs2.item (yyvsp2).name_id)
					ast_factory.reverse_extend_identifier (yyval23, yyvs2.item (yyvsp2))
					ast_factory.reverse_extend_identifier_separator (yyval23, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_164
			--|#line <not available> "eiffel.y"
		local
			yyval23: IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval23 := ast_factory.new_identifier_list (0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
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
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_165
			--|#line <not available> "eiffel.y"
		local
			yyval23: IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval23 := yyvs23.item (yyvsp23) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_166
			--|#line <not available> "eiffel.y"
		local
			yyval80: ROUTINE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs22.item (yyvsp22) /= Void then
					temp_string_as1 := yyvs22.item (yyvsp22).second
					temp_keyword_as := yyvs22.item (yyvsp22).first
				else
					temp_string_as1 := Void
					temp_keyword_as := Void
				end
				if yyvs20.item (yyvsp20) /= Void then
					yyval80 := ast_factory.new_routine_as (temp_string_as1, yyvs77.item (yyvsp77), yyvs121.item (yyvsp121), yyvs79.item (yyvsp79), yyvs51.item (yyvsp51), yyvs20.item (yyvsp20).second, yyvs12.item (yyvsp12), once_manifest_string_counter_value, fbody_pos, temp_keyword_as, yyvs20.item (yyvsp20).first, object_test_locals)
				else
					yyval80 := ast_factory.new_routine_as (temp_string_as1, yyvs77.item (yyvsp77), yyvs121.item (yyvsp121), yyvs79.item (yyvsp79), yyvs51.item (yyvsp51), Void, yyvs12.item (yyvsp12), once_manifest_string_counter_value, fbody_pos, temp_keyword_as, Void, object_test_locals)
				end
				reset_once_manifest_string_counter
				object_test_locals := Void
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp22 := yyvsp22 -1
	yyvsp77 := yyvsp77 -1
	yyvsp121 := yyvsp121 -1
	yyvsp79 := yyvsp79 -1
	yyvsp51 := yyvsp51 -1
	yyvsp20 := yyvsp20 -1
	yyvsp12 := yyvsp12 -1
	yyvs80.put (yyval80, yyvsp80)
end
		end

	yy_do_action_167
			--|#line <not available> "eiffel.y"
		local
			yyval80: ROUTINE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_fbody_pos (position) 
if yy_parsing_status >= yyContinue then
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

	yy_do_action_168
			--|#line <not available> "eiffel.y"
		local
			yyval79: ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval79 := yyvs65.item (yyvsp65) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp65 := yyvsp65 -1
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

	yy_do_action_169
			--|#line <not available> "eiffel.y"
		local
			yyval79: ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval79 := yyvs53.item (yyvsp53) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp53 := yyvsp53 -1
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

	yy_do_action_170
			--|#line <not available> "eiffel.y"
		local
			yyval79: ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval79 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp10 := yyvsp10 -1
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

	yy_do_action_171
			--|#line <not available> "eiffel.y"
		local
			yyval53: EXTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs54.item (yyvsp54) /= Void and then yyvs54.item (yyvsp54).is_built_in then
					if yyvs22.item (yyvsp22) /= Void then 
						yyval53 := ast_factory.new_built_in_as (yyvs54.item (yyvsp54), yyvs22.item (yyvsp22).second, yyvs12.item (yyvsp12), yyvs22.item (yyvsp22).first)
					else
						yyval53 := ast_factory.new_built_in_as (yyvs54.item (yyvsp54), Void, yyvs12.item (yyvsp12), Void)
					end
				elseif yyvs22.item (yyvsp22) /= Void then
					yyval53 := ast_factory.new_external_as (yyvs54.item (yyvsp54), yyvs22.item (yyvsp22).second, yyvs12.item (yyvsp12), yyvs22.item (yyvsp22).first)
				else
					yyval53 := ast_factory.new_external_as (yyvs54.item (yyvsp54), Void, yyvs12.item (yyvsp12), Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp53 := yyvsp53 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp54 := yyvsp54 -1
	yyvsp22 := yyvsp22 -1
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

	yy_do_action_172
			--|#line <not available> "eiffel.y"
		local
			yyval54: EXTERNAL_LANG_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval54 := ast_factory.new_external_lang_as (yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp54 := yyvsp54 + 1
	yyvsp16 := yyvsp16 -1
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

	yy_do_action_173
			--|#line <not available> "eiffel.y"
		local
			yyval22: PAIR [KEYWORD_AS, STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_174
			--|#line <not available> "eiffel.y"
		local
			yyval22: PAIR [KEYWORD_AS, STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval22 := ast_factory.new_keyword_string_pair (yyvs12.item (yyvsp12), yyvs16.item (yyvsp16))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp22 := yyvsp22 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp16 := yyvsp16 -1
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

	yy_do_action_175
			--|#line <not available> "eiffel.y"
		local
			yyval65: INTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_do_as (yyvs19.item (yyvsp19), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp65 := yyvsp65 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp19 := yyvsp19 -1
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

	yy_do_action_176
			--|#line <not available> "eiffel.y"
		local
			yyval65: INTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_once_as (yyvs12.item (yyvsp12), yyvs118.item (yyvsp118), yyvs19.item (yyvsp19)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp65 := yyvsp65 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp118 := yyvsp118 -1
	yyvsp19 := yyvsp19 -1
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

	yy_do_action_177
			--|#line <not available> "eiffel.y"
		local
			yyval65: INTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_attribute_as (yyvs19.item (yyvsp19), extract_keyword (yyvs15.item (yyvsp15))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp65 := yyvsp65 + 1
	yyvsp15 := yyvsp15 -1
	yyvsp19 := yyvsp19 -1
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

	yy_do_action_178
			--|#line <not available> "eiffel.y"
		local
			yyval121: LOCAL_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp121 := yyvsp121 + 1
	if yyvsp121 >= yyvsc121 then
		if yyvs121 = Void then
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
	yyvs121.put (yyval121, yyvsp121)
end
		end

	yy_do_action_179
			--|#line <not available> "eiffel.y"
		local
			yyval121: LOCAL_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval121 := ast_factory.new_local_dec_list_as (ast_factory.new_eiffel_list_type_dec_as (0), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp121 := yyvsp121 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp121 >= yyvsc121 then
		if yyvs121 = Void then
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
	yyvs121.put (yyval121, yyvsp121)
end
		end

	yy_do_action_180
			--|#line <not available> "eiffel.y"
		local
			yyval121: LOCAL_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval121 := ast_factory.new_local_dec_list_as (yyvs120.item (yyvsp120), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp121 := yyvsp121 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -2
	yyvsp120 := yyvsp120 -1
	if yyvsp121 >= yyvsc121 then
		if yyvs121 = Void then
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
	yyvs121.put (yyval121, yyvsp121)
end
		end

	yy_do_action_181
			--|#line <not available> "eiffel.y"
		local
			yyval19: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp19 := yyvsp19 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_182
			--|#line <not available> "eiffel.y"
		local
			yyval19: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval19 := yyvs19.item (yyvsp19) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -3
	yyvs19.put (yyval19, yyvsp19)
end
		end

	yy_do_action_183
			--|#line <not available> "eiffel.y"
		local
			yyval19: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval19 := ast_factory.new_eiffel_list_instruction_as (counter_value + 1)
				if yyval19 /= Void and yyvs18.item (yyvsp18) /= Void then
					yyval19.reverse_extend (yyvs18.item (yyvsp18))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp19 := yyvsp19 + 1
	yyvsp18 := yyvsp18 -1
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

	yy_do_action_184
			--|#line <not available> "eiffel.y"
		local
			yyval19: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval19 := yyvs19.item (yyvsp19)
				if yyval19 /= Void and yyvs18.item (yyvsp18) /= Void then
					yyval19.reverse_extend (yyvs18.item (yyvsp18))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 -1
	yyvsp1 := yyvsp1 -1
	yyvs19.put (yyval19, yyvsp19)
end
		end

	yy_do_action_185
			--|#line <not available> "eiffel.y"
		local
			yyval18: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval18 := yyvs18.item (yyvsp18) 
				if yyval18 /= Void then
					yyval18.set_line_pragma (last_line_pragma)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_186
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_187
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_188
			--|#line <not available> "eiffel.y"
		local
			yyval18: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := yyvs47.item (yyvsp47) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp18 := yyvsp18 + 1
	yyvsp47 := yyvsp47 -1
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

	yy_do_action_189
			--|#line <not available> "eiffel.y"
		local
			yyval18: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Call production should be used instead,
					-- but this complicates the grammar.
				if has_type then
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs27.item (yyvsp27)), token_column (yyvs27.item (yyvsp27)),
						filename, "Expression cannot be used as an instruction"))
				elseif yyvs27.item (yyvsp27) /= Void then
					yyval18 := new_call_instruction_from_expression (yyvs27.item (yyvsp27))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp18 := yyvsp18 + 1
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_190
			--|#line <not available> "eiffel.y"
		local
			yyval18: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := yyvs35.item (yyvsp35) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -1
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

	yy_do_action_191
			--|#line <not available> "eiffel.y"
		local
			yyval18: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := yyvs34.item (yyvsp34) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp18 := yyvsp18 + 1
	yyvsp34 := yyvsp34 -1
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

	yy_do_action_192
			--|#line <not available> "eiffel.y"
		local
			yyval18: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := yyvs78.item (yyvsp78) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp18 := yyvsp18 + 1
	yyvsp78 := yyvsp78 -1
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

	yy_do_action_193
			--|#line <not available> "eiffel.y"
		local
			yyval18: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp18 := yyvsp18 + 1
	yyvsp61 := yyvsp61 -1
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

	yy_do_action_194
			--|#line <not available> "eiffel.y"
		local
			yyval18: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := yyvs69.item (yyvsp69) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp18 := yyvsp18 + 1
	yyvsp69 := yyvsp69 -1
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

	yy_do_action_195
			--|#line <not available> "eiffel.y"
		local
			yyval18: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := yyvs63.item (yyvsp63) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp18 := yyvsp18 + 1
	yyvsp63 := yyvsp63 -1
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

	yy_do_action_196
			--|#line <not available> "eiffel.y"
		local
			yyval18: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := yyvs49.item (yyvsp49) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp18 := yyvsp18 + 1
	yyvsp49 := yyvsp49 -1
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

	yy_do_action_197
			--|#line <not available> "eiffel.y"
		local
			yyval18: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := yyvs42.item (yyvsp42) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp18 := yyvsp18 + 1
	yyvsp42 := yyvsp42 -1
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

	yy_do_action_198
			--|#line <not available> "eiffel.y"
		local
			yyval18: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := yyvs60.item (yyvsp60) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp18 := yyvsp18 + 1
	yyvsp60 := yyvsp60 -1
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

	yy_do_action_199
			--|#line <not available> "eiffel.y"
		local
			yyval18: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp18 := yyvsp18 + 1
	yyvsp7 := yyvsp7 -1
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

	yy_do_action_200
			--|#line <not available> "eiffel.y"
		local
			yyval77: REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
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

	yy_do_action_201
			--|#line <not available> "eiffel.y"
		local
			yyval77: REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval77 := ast_factory.new_require_as (yyvs25.item (yyvsp25), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp25 := yyvsp25 -1
	yyvs77.put (yyval77, yyvsp77)
end
		end

	yy_do_action_202
			--|#line <not available> "eiffel.y"
		local
			yyval77: REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Assert_level) 
if yy_parsing_status >= yyContinue then
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

	yy_do_action_203
			--|#line <not available> "eiffel.y"
		local
			yyval77: REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval77 := ast_factory.new_require_else_as (yyvs25.item (yyvsp25), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -2
	yyvsp25 := yyvsp25 -1
	yyvs77.put (yyval77, yyvsp77)
end
		end

	yy_do_action_204
			--|#line <not available> "eiffel.y"
		local
			yyval77: REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Assert_level) 
if yy_parsing_status >= yyContinue then
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

	yy_do_action_205
			--|#line <not available> "eiffel.y"
		local
			yyval51: ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp51 := yyvsp51 + 1
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

	yy_do_action_206
			--|#line <not available> "eiffel.y"
		local
			yyval51: ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval51 := ast_factory.new_ensure_as (yyvs25.item (yyvsp25), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp25 := yyvsp25 -1
	yyvs51.put (yyval51, yyvsp51)
end
		end

	yy_do_action_207
			--|#line <not available> "eiffel.y"
		local
			yyval51: ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Assert_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp51 := yyvsp51 + 1
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

	yy_do_action_208
			--|#line <not available> "eiffel.y"
		local
			yyval51: ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval51 := ast_factory.new_ensure_then_as (yyvs25.item (yyvsp25), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -2
	yyvsp25 := yyvsp25 -1
	yyvs51.put (yyval51, yyvsp51)
end
		end

	yy_do_action_209
			--|#line <not available> "eiffel.y"
		local
			yyval51: ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Assert_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp51 := yyvsp51 + 1
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

	yy_do_action_210
			--|#line <not available> "eiffel.y"
		local
			yyval25: EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_211
			--|#line <not available> "eiffel.y"
		local
			yyval25: EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval25 := yyvs25.item (yyvsp25)
				if yyval25 /= Void and then yyval25.is_empty then
					yyval25 := Void
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_212
			--|#line <not available> "eiffel.y"
		local
			yyval25: EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Special list treatment here as we do not want Void
					-- element in `Assertion_list'.
				if yyvs24.item (yyvsp24) /= Void then
					yyval25 := ast_factory.new_eiffel_list_tagged_as (counter_value + 1)
					if yyval25 /= Void then
						yyval25.reverse_extend (yyvs24.item (yyvsp24))
					end
				else
					yyval25 := ast_factory.new_eiffel_list_tagged_as (counter_value)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp25 := yyvsp25 + 1
	yyvsp24 := yyvsp24 -1
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

	yy_do_action_213
			--|#line <not available> "eiffel.y"
		local
			yyval25: EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval25 := yyvs25.item (yyvsp25)
				if yyval25 /= Void and yyvs24.item (yyvsp24) /= Void then
					yyval25.reverse_extend (yyvs24.item (yyvsp24))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp25 := yyvsp25 -1
	yyvsp24 := yyvsp24 -1
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_214
			--|#line <not available> "eiffel.y"
		local
			yyval25: EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Only increment counter when clause is not Void.
				if yyvs24.item (yyvsp24) /= Void then
					increment_counter
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

	yy_do_action_215
			--|#line <not available> "eiffel.y"
		local
			yyval24: TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval24 := ast_factory.new_tagged_as (Void, yyvs27.item (yyvsp27), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp24 := yyvsp24 + 1
	yyvsp27 := yyvsp27 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_216
			--|#line <not available> "eiffel.y"
		local
			yyval24: TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval24 := ast_factory.new_tagged_as (yyvs2.item (yyvsp2), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp24 := yyvsp24 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_217
			--|#line <not available> "eiffel.y"
		local
			yyval24: TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			-- Always create an object here for roundtrip parser.
			-- This "fake" assertion will be filtered out later.
			yyval24 := ast_factory.new_tagged_as (yyvs2.item (yyvsp2), Void, yyvs4.item (yyvsp4 - 1))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp24 := yyvsp24 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_218
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_219
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_220
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_221
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_222
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_223
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := new_class_type (yyvs2.item (yyvsp2), yyvs119.item (yyvsp119)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp119 := yyvsp119 -1
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

	yy_do_action_224
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_225
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_226
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_227
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				ast_factory.set_expanded_class_type (yyval83, True, yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Make an expanded version of the base class associated with this type."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_228
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := ast_factory.new_bits_as (yyvs64.item (yyvsp64), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp64 := yyvsp64 -1
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

	yy_do_action_229
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := ast_factory.new_bits_symbol_as (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_230
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_231
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				if not is_ignoring_attachment_marks and then yyval83 /= Void then
					yyval83.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_232
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				if not is_ignoring_attachment_marks and then yyval83 /= Void then
					yyval83.set_attachment_mark (yyvs4.item (yyvsp4), True, False)
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4)), token_column (yyvs4.item (yyvsp4)), filename,
						once "Use the `attached' keyword instead of !."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_233
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				if not is_ignoring_attachment_marks and then yyval83 /= Void then
					yyval83.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_234
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				if not is_ignoring_attachment_marks and then yyval83 /= Void then
					yyval83.set_attachment_mark (yyvs4.item (yyvsp4), False, True)
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4)), token_column (yyvs4.item (yyvsp4)), filename,
						once "Use the `detachable' keyword instead of ?."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_235
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_236
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_237
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				if not is_ignoring_attachment_marks and then yyval83 /= Void then
					yyval83.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_238
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				if not is_ignoring_attachment_marks and then yyval83 /= Void then
					yyval83.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_239
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				if not is_ignoring_attachment_marks and then yyval83 /= Void then
					yyval83.set_attachment_mark (yyvs4.item (yyvsp4), True, False)
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4)), token_column (yyvs4.item (yyvsp4)), filename,
						once "Use the `attached' keyword instead of !."))
				end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_240
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				if not is_ignoring_attachment_marks and then yyval83 /= Void then
					yyval83.set_attachment_mark (yyvs4.item (yyvsp4), False, True)
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4)), token_column (yyvs4.item (yyvsp4)), filename,
						once "Use the `detachable' keyword instead of ?."))
				end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_241
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := new_class_type (yyvs2.item (yyvsp2), yyvs119.item (yyvsp119)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp119 := yyvsp119 -1
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

	yy_do_action_242
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_243
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_244
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_245
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				if not is_ignoring_separate_mark and then attached yyval83 then
					yyval83.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_246
			--|#line <not available> "eiffel.y"
		local
			yyval119: TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp119 := yyvsp119 + 1
	if yyvsp119 >= yyvsc119 then
		if yyvs119 = Void then
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
	yyvs119.put (yyval119, yyvsp119)
end
		end

	yy_do_action_247
			--|#line <not available> "eiffel.y"
		local
			yyval119: TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval119 := yyvs119.item (yyvsp119)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs119.put (yyval119, yyvsp119)
end
		end

	yy_do_action_248
			--|#line <not available> "eiffel.y"
		local
			yyval119: TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval119 := yyvs119.item (yyvsp119)
				if yyval119 /= Void then
					yyval119.set_positions (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyvs119.put (yyval119, yyvsp119)
end
		end

	yy_do_action_249
			--|#line <not available> "eiffel.y"
		local
			yyval119: TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval119 := ast_factory.new_eiffel_list_type (0)
				if yyval119 /= Void then
					yyval119.set_positions (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end	
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp119 := yyvsp119 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp119 >= yyvsc119 then
		if yyvs119 = Void then
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
	yyvs119.put (yyval119, yyvsp119)
end
		end

	yy_do_action_250
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_251
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs84.item (yyvsp84) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp83 := yyvsp83 + 1
	yyvsp84 := yyvsp84 -1
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

	yy_do_action_252
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_253
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				if not is_ignoring_separate_mark and then attached yyval83 then
					yyval83.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_254
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := ast_factory.new_like_id_as (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_255
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := ast_factory.new_like_current_as (yyvs9.item (yyvsp9), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp9 := yyvsp9 -1
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

	yy_do_action_256
			--|#line <not available> "eiffel.y"
		local
			yyval84: QUALIFIED_ANCHORED_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval84 := ast_factory.new_qualified_anchored_type (yyvs83.item (yyvsp83), yyvs4.item (yyvsp4), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp84 := yyvsp84 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_257
			--|#line <not available> "eiffel.y"
		local
			yyval84: QUALIFIED_ANCHORED_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval84 := ast_factory.new_qualified_anchored_type_with_type (yyvs12.item (yyvsp12), yyvs83.item (yyvsp83), yyvs4.item (yyvsp4), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp84 := yyvsp84 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp83 := yyvsp83 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_258
			--|#line <not available> "eiffel.y"
		local
			yyval84: QUALIFIED_ANCHORED_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval84 := yyvs84.item (yyvsp84)
				if attached yyval84 as q then
					q.extend (yyvs4.item (yyvsp4), yyvs2.item (yyvsp2))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvs84.put (yyval84, yyvsp84)
end
		end

	yy_do_action_259
			--|#line <not available> "eiffel.y"
		local
			yyval119: TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval119 := yyvs119.item (yyvsp119) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs119.put (yyval119, yyvsp119)
end
		end

	yy_do_action_260
			--|#line <not available> "eiffel.y"
		local
			yyval119: TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval119 := ast_factory.new_eiffel_list_type (counter_value + 1)
				if yyval119 /= Void and yyvs83.item (yyvsp83) /= Void then
					yyval119.reverse_extend (yyvs83.item (yyvsp83))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp119 := yyvsp119 + 1
	yyvsp83 := yyvsp83 -1
	if yyvsp119 >= yyvsc119 then
		if yyvs119 = Void then
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
	yyvs119.put (yyval119, yyvsp119)
end
		end

	yy_do_action_261
			--|#line <not available> "eiffel.y"
		local
			yyval119: TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval119 := yyvs119.item (yyvsp119)
				if yyval119 /= Void and yyvs83.item (yyvsp83) /= Void then
					yyval119.reverse_extend (yyvs83.item (yyvsp83))
					ast_factory.reverse_extend_separator (yyval119, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp83 := yyvsp83 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs119.put (yyval119, yyvsp119)
end
		end

	yy_do_action_262
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status >= yyContinue then
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

	yy_do_action_263
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				last_type_list := ast_factory.new_eiffel_list_type (0)
				if last_type_list /= Void then
					last_type_list.set_positions (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end
				yyval83 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), last_type_list)
				last_type_list := Void
				remove_counter
				remove_counter2
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_264
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs119.item (yyvsp119) /= Void then
					yyvs119.item (yyvsp119).set_positions (yyvs4.item (yyvsp4), last_rsqure.item)
				end
				yyval83 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), yyvs119.item (yyvsp119))
				last_rsqure.remove
				remove_counter
				remove_counter2
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -1
	yyvsp119 := yyvsp119 -1
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

	yy_do_action_265
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := ast_factory.new_named_tuple_type_as (
					yyvs2.item (yyvsp2), ast_factory.new_formal_argu_dec_list_as (yyvs120.item (yyvsp120), yyvs4.item (yyvsp4), last_rsqure.item))
				last_rsqure.remove
				remove_counter
				remove_counter2
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -1
	yyvsp120 := yyvsp120 -1
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

	yy_do_action_266
			--|#line <not available> "eiffel.y"
		local
			yyval119: TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval119 := ast_factory.new_eiffel_list_type (counter_value + 1)
				if yyval119 /= Void and yyvs83.item (yyvsp83) /= Void then
					yyval119.reverse_extend (yyvs83.item (yyvsp83))
				end
				last_rsqure.force (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp119 := yyvsp119 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp119 >= yyvsc119 then
		if yyvs119 = Void then
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
	yyvs119.put (yyval119, yyvsp119)
end
		end

	yy_do_action_267
			--|#line <not available> "eiffel.y"
		local
			yyval119: TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval119 := yyvs119.item (yyvsp119)
				if yyval119 /= Void and yyvs2.item (yyvsp2) /= Void then
					yyvs2.item (yyvsp2).to_upper		
					yyval119.reverse_extend (new_class_type (yyvs2.item (yyvsp2), Void))
					ast_factory.reverse_extend_separator (yyval119, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs119.put (yyval119, yyvsp119)
end
		end

	yy_do_action_268
			--|#line <not available> "eiffel.y"
		local
			yyval119: TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval119 := yyvs119.item (yyvsp119)
				if yyval119 /= Void and yyvs83.item (yyvsp83) /= Void then
					yyval119.reverse_extend (yyvs83.item (yyvsp83))
					ast_factory.reverse_extend_separator (yyval119, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp83 := yyvsp83 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs119.put (yyval119, yyvsp119)
end
		end

	yy_do_action_269
			--|#line <not available> "eiffel.y"
		local
			yyval120: TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval120 := ast_factory.new_eiffel_list_type_dec_as (counter2_value + 1)
				last_identifier_list := ast_factory.new_identifier_list (counter_value + 1)
				
				if yyval120 /= Void and last_identifier_list /= Void and yyvs2.item (yyvsp2) /= Void then
					yyvs2.item (yyvsp2).to_lower		
					last_identifier_list.reverse_extend (yyvs2.item (yyvsp2).name_id)
					ast_factory.reverse_extend_identifier (last_identifier_list, yyvs2.item (yyvsp2))
					yyval120.reverse_extend (ast_factory.new_type_dec_as (last_identifier_list, yyvs83.item (yyvsp83), yyvs4.item (yyvsp4 - 1)))
				end
				last_identifier_list := Void
				last_rsqure.force (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp120 := yyvsp120 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp83 := yyvsp83 -1
	if yyvsp120 >= yyvsc120 then
		if yyvs120 = Void then
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
	yyvs120.put (yyval120, yyvsp120)
end
		end

	yy_do_action_270
			--|#line <not available> "eiffel.y"
		local
			yyval120: TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval120 := yyvs120.item (yyvsp120)
				if yyval120 /= Void and then not yyval120.is_empty then
					last_identifier_list := yyval120.reversed_first.id_list
					if last_identifier_list /= Void then
						yyvs2.item (yyvsp2).to_lower		
						last_identifier_list.reverse_extend (yyvs2.item (yyvsp2).name_id)
						ast_factory.reverse_extend_identifier (last_identifier_list, yyvs2.item (yyvsp2))
						ast_factory.reverse_extend_identifier_separator (last_identifier_list, yyvs4.item (yyvsp4))
					end
					last_identifier_list := Void
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs120.put (yyval120, yyvsp120)
end
		end

	yy_do_action_271
			--|#line <not available> "eiffel.y"
		local
			yyval120: TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				remove_counter
				yyval120 := yyvs120.item (yyvsp120)
				last_identifier_list := ast_factory.new_identifier_list (counter_value + 1)
				
				if yyval120 /= Void and yyvs2.item (yyvsp2) /= Void and yyvs83.item (yyvsp83) /= Void and last_identifier_list /= Void then
					yyvs2.item (yyvsp2).to_lower		
					last_identifier_list.reverse_extend (yyvs2.item (yyvsp2).name_id)
					ast_factory.reverse_extend_identifier (last_identifier_list, yyvs2.item (yyvsp2))
					yyval120.reverse_extend (ast_factory.new_type_dec_as (last_identifier_list, yyvs83.item (yyvsp83), yyvs4.item (yyvsp4 - 1)))
				end
				last_identifier_list := Void
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp83 := yyvsp83 -1
	yyvsp1 := yyvsp1 -2
	yyvs120.put (yyval120, yyvsp120)
end
		end

	yy_do_action_272
			--|#line <not available> "eiffel.y"
		local
			yyval107: FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- $$ := Void
				formal_generics_end_position := 0
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp107 := yyvsp107 + 1
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

	yy_do_action_273
			--|#line <not available> "eiffel.y"
		local
			yyval107: FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				formal_generics_end_position := position
				yyval107 := ast_factory.new_eiffel_list_formal_dec_as (0)
				if yyval107 /= Void then
					yyval107.set_squre_symbols (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp107 := yyvsp107 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_274
			--|#line <not available> "eiffel.y"
		local
			yyval107: FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				formal_generics_end_position := position
				yyval107 := yyvs107.item (yyvsp107)
				if yyval107 /= Void then
					yyval107.transform_class_types_to_formals_and_record_suppliers (ast_factory, suppliers, formal_parameters)
					yyval107.set_squre_symbols (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -4
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_275
			--|#line <not available> "eiffel.y"
		local
			yyval107: FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval107 := ast_factory.new_eiffel_list_formal_dec_as (counter_value + 1)
				if yyval107 /= Void and yyvs59.item (yyvsp59) /= Void then
					yyval107.reverse_extend (yyvs59.item (yyvsp59))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp107 := yyvsp107 + 1
	yyvsp59 := yyvsp59 -1
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

	yy_do_action_276
			--|#line <not available> "eiffel.y"
		local
			yyval107: FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval107 := yyvs107.item (yyvsp107)
				if yyval107 /= Void and yyvs59.item (yyvsp59) /= Void then
					yyval107.reverse_extend (yyvs59.item (yyvsp59))
					ast_factory.reverse_extend_separator (yyval107, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp59 := yyvsp59 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_277
			--|#line <not available> "eiffel.y"
		local
			yyval58: FORMAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs2.item (yyvsp2) /= Void and then {PREDEFINED_NAMES}.none_class_name_id = yyvs2.item (yyvsp2).name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$2' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					yyval58 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), True, False, yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp58 := yyvsp58 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_278
			--|#line <not available> "eiffel.y"
		local
			yyval58: FORMAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs2.item (yyvsp2) /= Void and then {PREDEFINED_NAMES}.none_class_name_id = yyvs2.item (yyvsp2).name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$2' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					yyval58 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), False, True, yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp58 := yyvsp58 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_279
			--|#line <not available> "eiffel.y"
		local
			yyval58: FORMAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs2.item (yyvsp2) /= Void and then {PREDEFINED_NAMES}.none_class_name_id = yyvs2.item (yyvsp2).name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$1' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					yyval58 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), False, False, Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp58 := yyvsp58 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_280
			--|#line <not available> "eiffel.y"
		local
			yyval59: FORMAL_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs123.item (yyvsp123) /= Void then
					if yyvs123.item (yyvsp123).creation_constrain /= Void then
						yyval59 := ast_factory.new_formal_dec_as (yyvs58.item (yyvsp58), yyvs123.item (yyvsp123).type, yyvs123.item (yyvsp123).creation_constrain.feature_list, yyvs123.item (yyvsp123).constrain_symbol, yyvs123.item (yyvsp123).creation_constrain.create_keyword, yyvs123.item (yyvsp123).creation_constrain.end_keyword)
					else
						yyval59 := ast_factory.new_formal_dec_as (yyvs58.item (yyvsp58), yyvs123.item (yyvsp123).type, Void, yyvs123.item (yyvsp123).constrain_symbol, Void, Void)
					end					
				else
					yyval59 := ast_factory.new_formal_dec_as (yyvs58.item (yyvsp58), Void, Void, Void, Void, Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp58 := yyvsp58 -1
	yyvsp123 := yyvsp123 -1
	yyvs59.put (yyval59, yyvsp59)
end
		end

	yy_do_action_281
			--|#line <not available> "eiffel.y"
		local
			yyval59: FORMAL_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs58.item (yyvsp58) /= Void then
						-- Needs to be done here, in case current formal is used in
						-- Constraint.
					formal_parameters.extend (yyvs58.item (yyvsp58))
					yyvs58.item (yyvsp58).set_position (formal_parameters.count)
				end
			
if yy_parsing_status >= yyContinue then
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

	yy_do_action_282
			--|#line <not available> "eiffel.y"
		local
			yyval123: CONSTRAINT_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp123 := yyvsp123 + 1
	if yyvsp123 >= yyvsc123 then
		if yyvs123 = Void then
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
	yyvs123.put (yyval123, yyvsp123)
end
		end

	yy_do_action_283
			--|#line <not available> "eiffel.y"
		local
			yyval123: CONSTRAINT_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- We do not want Void items in this list.
				if yyvs125.item (yyvsp125) /= Void then
					constraining_type_list := ast_factory.new_eiffel_list_constraining_type_as (1)
					constraining_type_list.reverse_extend (yyvs125.item (yyvsp125))
				else
					constraining_type_list := Void
				end

				yyval123 := ast_factory.new_constraint_triple (yyvs4.item (yyvsp4), constraining_type_list, yyvs102.item (yyvsp102))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp123 := yyvsp123 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp125 := yyvsp125 -1
	yyvsp102 := yyvsp102 -1
	if yyvsp123 >= yyvsc123 then
		if yyvs123 = Void then
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
	yyvs123.put (yyval123, yyvsp123)
end
		end

	yy_do_action_284
			--|#line <not available> "eiffel.y"
		local
			yyval123: CONSTRAINT_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval123 := ast_factory.new_constraint_triple (yyvs4.item (yyvsp4 - 2), yyvs124.item (yyvsp124), yyvs102.item (yyvsp102))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp123 := yyvsp123 + 1
	yyvsp4 := yyvsp4 -3
	yyvsp1 := yyvsp1 -2
	yyvsp124 := yyvsp124 -1
	yyvsp102 := yyvsp102 -1
	if yyvsp123 >= yyvsc123 then
		if yyvs123 = Void then
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
	yyvs123.put (yyval123, yyvsp123)
end
		end

	yy_do_action_285
			--|#line <not available> "eiffel.y"
		local
			yyval125: CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval125 := ast_factory.new_constraining_type (yyvs83.item (yyvsp83), yyvs116.item (yyvsp116), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp125 := yyvsp125 -1
	yyvsp83 := yyvsp83 -1
	yyvsp116 := yyvsp116 -1
	yyvsp12 := yyvsp12 -1
	yyvs125.put (yyval125, yyvsp125)
end
		end

	yy_do_action_286
			--|#line <not available> "eiffel.y"
		local
			yyval125: CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

is_constraint_renaming := True
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp125 := yyvsp125 + 1
	if yyvsp125 >= yyvsc125 then
		if yyvs125 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs125")
			end
			create yyspecial_routines125
			yyvsc125 := yyInitial_yyvs_size
			yyvs125 := yyspecial_routines125.make (yyvsc125)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs125")
			end
			yyvsc125 := yyvsc125 + yyInitial_yyvs_size
			yyvs125 := yyspecial_routines125.resize (yyvs125, yyvsc125)
		end
	end
	yyvs125.put (yyval125, yyvsp125)
end
		end

	yy_do_action_287
			--|#line <not available> "eiffel.y"
		local
			yyval125: CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

is_constraint_renaming := False
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp125 := yyvsp125 + 1
	if yyvsp125 >= yyvsc125 then
		if yyvs125 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs125")
			end
			create yyspecial_routines125
			yyvsc125 := yyInitial_yyvs_size
			yyvs125 := yyspecial_routines125.make (yyvsc125)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs125")
			end
			yyvsc125 := yyvsc125 + yyInitial_yyvs_size
			yyvs125 := yyspecial_routines125.resize (yyvs125, yyvsc125)
		end
	end
	yyvs125.put (yyval125, yyvsp125)
end
		end

	yy_do_action_288
			--|#line <not available> "eiffel.y"
		local
			yyval125: CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval125 := ast_factory.new_constraining_type (yyvs83.item (yyvsp83), Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp125 := yyvsp125 + 1
	yyvsp83 := yyvsp83 -1
	if yyvsp125 >= yyvsc125 then
		if yyvs125 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs125")
			end
			create yyspecial_routines125
			yyvsc125 := yyInitial_yyvs_size
			yyvs125 := yyspecial_routines125.make (yyvsc125)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs125")
			end
			yyvsc125 := yyvsc125 + yyInitial_yyvs_size
			yyvs125 := yyspecial_routines125.resize (yyvs125, yyvsc125)
		end
	end
	yyvs125.put (yyval125, yyvsp125)
end
		end

	yy_do_action_289
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				if attached yyvs83.item (yyvsp83) as t and then t.has_anchor then
					report_one_error (ast_factory.new_vtgc1_error (token_line (yyvs83.item (yyvsp83)), token_column (yyvs83.item (yyvsp83)), filename, yyvs83.item (yyvsp83)))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_290
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				report_one_error (ast_factory.new_vtgc1_error (token_line (yyvs83.item (yyvsp83)), token_column (yyvs83.item (yyvsp83)), filename, yyvs83.item (yyvsp83)))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_291
			--|#line <not available> "eiffel.y"
		local
			yyval124: CONSTRAINT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Special list treatment here as we do not want Void
					-- element in `Assertion_list'.
				if yyvs125.item (yyvsp125) /= Void then
					yyval124 := ast_factory.new_eiffel_list_constraining_type_as (counter_value + 1)
					if yyval124 /= Void then
						yyval124.reverse_extend (yyvs125.item (yyvsp125))
					end
				else
					yyval124 := ast_factory.new_eiffel_list_constraining_type_as (counter_value)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp124 := yyvsp124 + 1
	yyvsp125 := yyvsp125 -1
	if yyvsp124 >= yyvsc124 then
		if yyvs124 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs124")
			end
			create yyspecial_routines124
			yyvsc124 := yyInitial_yyvs_size
			yyvs124 := yyspecial_routines124.make (yyvsc124)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs124")
			end
			yyvsc124 := yyvsc124 + yyInitial_yyvs_size
			yyvs124 := yyspecial_routines124.resize (yyvs124, yyvsc124)
		end
	end
	yyvs124.put (yyval124, yyvsp124)
end
		end

	yy_do_action_292
			--|#line <not available> "eiffel.y"
		local
			yyval124: CONSTRAINT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval124 := yyvs124.item (yyvsp124)
				if yyval124 /= Void and yyvs125.item (yyvsp125) /= Void then
					yyval124.reverse_extend (yyvs125.item (yyvsp125))
					ast_factory.reverse_extend_separator (yyval124, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp124 := yyvsp124 -1
	yyvsp125 := yyvsp125 -1
	yyvsp4 := yyvsp4 -1
	yyvs124.put (yyval124, yyvsp124)
end
		end

	yy_do_action_293
			--|#line <not available> "eiffel.y"
		local
			yyval124: CONSTRAINT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Only increment counter when clause is not Void.
				if yyvs125.item (yyvsp125) /= Void then
					increment_counter
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp124 := yyvsp124 + 1
	if yyvsp124 >= yyvsc124 then
		if yyvs124 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs124")
			end
			create yyspecial_routines124
			yyvsc124 := yyInitial_yyvs_size
			yyvs124 := yyspecial_routines124.make (yyvsc124)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs124")
			end
			yyvsc124 := yyvsc124 + yyInitial_yyvs_size
			yyvs124 := yyspecial_routines124.resize (yyvs124, yyvsc124)
		end
	end
	yyvs124.put (yyval124, yyvsp124)
end
		end

	yy_do_action_294
			--|#line <not available> "eiffel.y"
		local
			yyval102: CREATION_CONSTRAIN_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_295
			--|#line <not available> "eiffel.y"
		local
			yyval102: CREATION_CONSTRAIN_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval102 := ast_factory.new_creation_constrain_triple (yyvs101.item (yyvsp101), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp102 := yyvsp102 + 1
	yyvsp12 := yyvsp12 -2
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

	yy_do_action_296
			--|#line <not available> "eiffel.y"
		local
			yyval61: IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval61 := ast_factory.new_if_as (yyvs27.item (yyvsp27), yyvs19.item (yyvsp19), Void, Void, yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp61 := yyvsp61 + 1
	yyvsp12 := yyvsp12 -3
	yyvsp27 := yyvsp27 -1
	yyvsp19 := yyvsp19 -1
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

	yy_do_action_297
			--|#line <not available> "eiffel.y"
		local
			yyval61: IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs20.item (yyvsp20) /= Void then
					yyval61 := ast_factory.new_if_as (yyvs27.item (yyvsp27), yyvs19.item (yyvsp19), Void, yyvs20.item (yyvsp20).second, yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1), yyvs20.item (yyvsp20).first)
				else
					yyval61 := ast_factory.new_if_as (yyvs27.item (yyvsp27), yyvs19.item (yyvsp19), Void, Void, yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1), Void)

				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp61 := yyvsp61 + 1
	yyvsp12 := yyvsp12 -3
	yyvsp27 := yyvsp27 -1
	yyvsp19 := yyvsp19 -1
	yyvsp20 := yyvsp20 -1
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

	yy_do_action_298
			--|#line <not available> "eiffel.y"
		local
			yyval61: IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval61 := ast_factory.new_if_as (yyvs27.item (yyvsp27), yyvs19.item (yyvsp19), yyvs94.item (yyvsp94), Void, yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp61 := yyvsp61 + 1
	yyvsp12 := yyvsp12 -3
	yyvsp27 := yyvsp27 -1
	yyvsp19 := yyvsp19 -1
	yyvsp94 := yyvsp94 -1
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

	yy_do_action_299
			--|#line <not available> "eiffel.y"
		local
			yyval61: IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs20.item (yyvsp20) /= Void then
					yyval61 := ast_factory.new_if_as (yyvs27.item (yyvsp27), yyvs19.item (yyvsp19), yyvs94.item (yyvsp94), yyvs20.item (yyvsp20).second, yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1), yyvs20.item (yyvsp20).first)
				else
					yyval61 := ast_factory.new_if_as (yyvs27.item (yyvsp27), yyvs19.item (yyvsp19), yyvs94.item (yyvsp94), Void, yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1), Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp61 := yyvsp61 + 1
	yyvsp12 := yyvsp12 -3
	yyvsp27 := yyvsp27 -1
	yyvsp19 := yyvsp19 -1
	yyvsp94 := yyvsp94 -1
	yyvsp20 := yyvsp20 -1
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

	yy_do_action_300
			--|#line <not available> "eiffel.y"
		local
			yyval94: EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval94 := yyvs94.item (yyvsp94) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs94.put (yyval94, yyvsp94)
end
		end

	yy_do_action_301
			--|#line <not available> "eiffel.y"
		local
			yyval94: EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval94 := ast_factory.new_eiffel_list_elseif_as (counter_value + 1)
				if yyval94 /= Void and yyvs50.item (yyvsp50) /= Void then
					yyval94.reverse_extend (yyvs50.item (yyvsp50))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp94 := yyvsp94 + 1
	yyvsp50 := yyvsp50 -1
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

	yy_do_action_302
			--|#line <not available> "eiffel.y"
		local
			yyval94: EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval94 := yyvs94.item (yyvsp94)
				if yyval94 /= Void and yyvs50.item (yyvsp50) /= Void then
					yyval94.reverse_extend (yyvs50.item (yyvsp50))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 -1
	yyvsp1 := yyvsp1 -1
	yyvs94.put (yyval94, yyvsp94)
end
		end

	yy_do_action_303
			--|#line <not available> "eiffel.y"
		local
			yyval50: ELSIF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval50 := ast_factory.new_elseif_as (yyvs27.item (yyvsp27), yyvs19.item (yyvsp19), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp50 := yyvsp50 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp27 := yyvsp27 -1
	yyvsp19 := yyvsp19 -1
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

	yy_do_action_304
			--|#line <not available> "eiffel.y"
		local
			yyval20: PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval20 := ast_factory.new_keyword_instruction_list_pair (yyvs12.item (yyvsp12), yyvs19.item (yyvsp19)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp19 := yyvsp19 -1
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

	yy_do_action_305
			--|#line <not available> "eiffel.y"
		local
			yyval63: INSPECT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_inspect_as (yyvs27.item (yyvsp27), yyvs91.item (yyvsp91), Void, yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 1), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp63 := yyvsp63 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp27 := yyvsp27 -1
	yyvsp91 := yyvsp91 -1
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

	yy_do_action_306
			--|#line <not available> "eiffel.y"
		local
			yyval63: INSPECT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs19.item (yyvsp19) /= Void then
					yyval63 := ast_factory.new_inspect_as (yyvs27.item (yyvsp27), yyvs91.item (yyvsp91), yyvs19.item (yyvsp19), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				else
					yyval63 := ast_factory.new_inspect_as (yyvs27.item (yyvsp27), yyvs91.item (yyvsp91),
						ast_factory.new_eiffel_list_instruction_as (0), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp63 := yyvsp63 + 1
	yyvsp12 := yyvsp12 -3
	yyvsp27 := yyvsp27 -1
	yyvsp91 := yyvsp91 -1
	yyvsp19 := yyvsp19 -1
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

	yy_do_action_307
			--|#line <not available> "eiffel.y"
		local
			yyval91: EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


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

	yy_do_action_308
			--|#line <not available> "eiffel.y"
		local
			yyval91: EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval91 := yyvs91.item (yyvsp91) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs91.put (yyval91, yyvsp91)
end
		end

	yy_do_action_309
			--|#line <not available> "eiffel.y"
		local
			yyval91: EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval91 := ast_factory.new_eiffel_list_case_as (counter_value + 1)
				if yyval91 /= Void and yyvs41.item (yyvsp41) /= Void then
					yyval91.reverse_extend (yyvs41.item (yyvsp41))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp91 := yyvsp91 + 1
	yyvsp41 := yyvsp41 -1
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

	yy_do_action_310
			--|#line <not available> "eiffel.y"
		local
			yyval91: EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval91 := yyvs91.item (yyvsp91)
				if yyval91 /= Void and yyvs41.item (yyvsp41) /= Void then
					yyval91.reverse_extend (yyvs41.item (yyvsp41))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp41 := yyvsp41 -1
	yyvsp1 := yyvsp1 -1
	yyvs91.put (yyval91, yyvsp91)
end
		end

	yy_do_action_311
			--|#line <not available> "eiffel.y"
		local
			yyval41: CASE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval41 := ast_factory.new_case_as (yyvs111.item (yyvsp111), yyvs19.item (yyvsp19), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp41 := yyvsp41 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp1 := yyvsp1 -2
	yyvsp111 := yyvsp111 -1
	yyvsp19 := yyvsp19 -1
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

	yy_do_action_312
			--|#line <not available> "eiffel.y"
		local
			yyval111: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval111 := ast_factory.new_eiffel_list_interval_as (counter_value + 1)
				if yyval111 /= Void and yyvs66.item (yyvsp66) /= Void then
					yyval111.reverse_extend (yyvs66.item (yyvsp66))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp111 := yyvsp111 + 1
	yyvsp66 := yyvsp66 -1
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

	yy_do_action_313
			--|#line <not available> "eiffel.y"
		local
			yyval111: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval111 := yyvs111.item (yyvsp111)
				if yyval111 /= Void and yyvs66.item (yyvsp66) /= Void then
					yyval111.reverse_extend (yyvs66.item (yyvsp66))
					ast_factory.reverse_extend_separator (yyval111, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp66 := yyvsp66 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs111.put (yyval111, yyvsp111)
end
		end

	yy_do_action_314
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs64.item (yyvsp64), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp66 := yyvsp66 + 1
	yyvsp64 := yyvsp64 -1
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

	yy_do_action_315
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs64.item (yyvsp64 - 1), yyvs64.item (yyvsp64), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp64 := yyvsp64 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_316
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs3.item (yyvsp3), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp66 := yyvsp66 + 1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_317
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs3.item (yyvsp3 - 1), yyvs3.item (yyvsp3), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp3 := yyvsp3 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_318
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), Void, Void) 
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

	yy_do_action_319
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_320
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs64.item (yyvsp64), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp64 := yyvsp64 -1
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

	yy_do_action_321
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs64.item (yyvsp64), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_322
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs3.item (yyvsp3), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_323
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs3.item (yyvsp3), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_324
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs74.item (yyvsp74), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp66 := yyvsp66 + 1
	yyvsp74 := yyvsp74 -1
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

	yy_do_action_325
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs74.item (yyvsp74), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp74 := yyvsp74 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_326
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs74.item (yyvsp74), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp74 := yyvsp74 -1
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

	yy_do_action_327
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs74.item (yyvsp74 - 1), yyvs74.item (yyvsp74), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp74 := yyvsp74 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_328
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs74.item (yyvsp74), yyvs64.item (yyvsp64), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp74 := yyvsp74 -1
	yyvsp4 := yyvsp4 -1
	yyvsp64 := yyvsp64 -1
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

	yy_do_action_329
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs64.item (yyvsp64), yyvs74.item (yyvsp74), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp4 := yyvsp4 -1
	yyvsp74 := yyvsp74 -1
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

	yy_do_action_330
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs74.item (yyvsp74), yyvs3.item (yyvsp3), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp74 := yyvsp74 -1
	yyvsp4 := yyvsp4 -1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_331
			--|#line <not available> "eiffel.y"
		local
			yyval66: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_interval_as (yyvs3.item (yyvsp3), yyvs74.item (yyvsp74), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp4 := yyvsp4 -1
	yyvsp74 := yyvsp74 -1
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

	yy_do_action_332
			--|#line <not available> "eiffel.y"
		local
			yyval69: LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs88.item (yyvsp88)), token_column (yyvs88.item (yyvsp88)), filename,
						once "Loop variant should appear just before the end keyword of the loop."))
				end
				if yyvs26.item (yyvsp26) /= Void then
					yyval69 := ast_factory.new_loop_as (Void, yyvs19.item (yyvsp19 - 1), yyvs26.item (yyvsp26).second, yyvs88.item (yyvsp88), yyvs27.item (yyvsp27), yyvs19.item (yyvsp19), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), yyvs26.item (yyvsp26).first, yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				else
					yyval69 := ast_factory.new_loop_as (Void, yyvs19.item (yyvsp19 - 1), Void, yyvs88.item (yyvsp88), yyvs27.item (yyvsp27), yyvs19.item (yyvsp19), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), Void, yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				end
				has_type := False
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp69 := yyvsp69 + 1
	yyvsp12 := yyvsp12 -4
	yyvsp19 := yyvsp19 -2
	yyvsp26 := yyvsp26 -1
	yyvsp88 := yyvsp88 -1
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_333
			--|#line <not available> "eiffel.y"
		local
			yyval69: LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs26.item (yyvsp26) /= Void then
					yyval69 := ast_factory.new_loop_as (Void, yyvs19.item (yyvsp19 - 1), yyvs26.item (yyvsp26).second, yyvs88.item (yyvsp88), yyvs27.item (yyvsp27), yyvs19.item (yyvsp19), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), yyvs26.item (yyvsp26).first, yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				else
					yyval69 := ast_factory.new_loop_as (Void, yyvs19.item (yyvsp19 - 1), Void, yyvs88.item (yyvsp88), yyvs27.item (yyvsp27), yyvs19.item (yyvsp19), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), Void, yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				end
				has_type := False
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp69 := yyvsp69 + 1
	yyvsp12 := yyvsp12 -4
	yyvsp19 := yyvsp19 -2
	yyvsp26 := yyvsp26 -1
	yyvsp27 := yyvsp27 -1
	yyvsp88 := yyvsp88 -1
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

	yy_do_action_334
			--|#line <not available> "eiffel.y"
		local
			yyval69: LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs26.item (yyvsp26) /= Void then
					if yyvs28.item (yyvsp28) /= Void then
						yyval69 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), yyvs19.item (yyvsp19 - 1), yyvs26.item (yyvsp26).second, yyvs88.item (yyvsp88), yyvs28.item (yyvsp28).second, yyvs19.item (yyvsp19), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs26.item (yyvsp26).first, yyvs28.item (yyvsp28).first, yyvs12.item (yyvsp12 - 1))
					else
						yyval69 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), yyvs19.item (yyvsp19 - 1), yyvs26.item (yyvsp26).second, yyvs88.item (yyvsp88), Void, yyvs19.item (yyvsp19), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs26.item (yyvsp26).first, Void, yyvs12.item (yyvsp12 - 1))
					end
				else
					if yyvs28.item (yyvsp28) /= Void then
						yyval69 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), yyvs19.item (yyvsp19 - 1), Void, yyvs88.item (yyvsp88), yyvs28.item (yyvsp28).second, yyvs19.item (yyvsp19), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), Void, yyvs28.item (yyvsp28).first, yyvs12.item (yyvsp12 - 1))
					else
						yyval69 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), yyvs19.item (yyvsp19 - 1), Void, yyvs88.item (yyvsp88), Void, yyvs19.item (yyvsp19), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), Void, Void, yyvs12.item (yyvsp12 - 1))
					end
				end
				has_type := False
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp69 := yyvsp69 + 1
	yyvsp110 := yyvsp110 -1
	yyvsp12 := yyvsp12 -3
	yyvsp19 := yyvsp19 -2
	yyvsp26 := yyvsp26 -1
	yyvsp28 := yyvsp28 -1
	yyvsp88 := yyvsp88 -1
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

	yy_do_action_335
			--|#line <not available> "eiffel.y"
		local
			yyval69: LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs26.item (yyvsp26) /= Void then
					if yyvs28.item (yyvsp28) /= Void then
						yyval69 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), Void, yyvs26.item (yyvsp26).second, yyvs88.item (yyvsp88), yyvs28.item (yyvsp28).second, yyvs19.item (yyvsp19), yyvs12.item (yyvsp12), Void, yyvs26.item (yyvsp26).first, yyvs28.item (yyvsp28).first, yyvs12.item (yyvsp12 - 1))
					else
						yyval69 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), Void, yyvs26.item (yyvsp26).second, yyvs88.item (yyvsp88), Void, yyvs19.item (yyvsp19), yyvs12.item (yyvsp12), Void, yyvs26.item (yyvsp26).first, Void, yyvs12.item (yyvsp12 - 1))
					end
				else
					if yyvs28.item (yyvsp28) /= Void then
						yyval69 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), Void, Void, yyvs88.item (yyvsp88), yyvs28.item (yyvsp28).second, yyvs19.item (yyvsp19), yyvs12.item (yyvsp12), Void, Void, yyvs28.item (yyvsp28).first, yyvs12.item (yyvsp12 - 1))
					else
						yyval69 := ast_factory.new_loop_as (yyvs110.item (yyvsp110), Void, Void, yyvs88.item (yyvsp88), Void, yyvs19.item (yyvsp19), yyvs12.item (yyvsp12), Void, Void, Void, yyvs12.item (yyvsp12 - 1))
					end
				end
				has_type := False
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp69 := yyvsp69 + 1
	yyvsp110 := yyvsp110 -1
	yyvsp26 := yyvsp26 -1
	yyvsp28 := yyvsp28 -1
	yyvsp12 := yyvsp12 -2
	yyvsp19 := yyvsp19 -1
	yyvsp88 := yyvsp88 -1
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

	yy_do_action_336
			--|#line <not available> "eiffel.y"
		local
			yyval68: LOOP_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs26.item (yyvsp26) /= Void then
					if yyvs28.item (yyvsp28) /= Void then
						yyval68 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), yyvs26.item (yyvsp26).first, yyvs26.item (yyvsp26).second, yyvs28.item (yyvsp28).first, yyvs28.item (yyvsp28).second, yyvs12.item (yyvsp12 - 1), True, yyvs27.item (yyvsp27), yyvs88.item (yyvsp88), yyvs12.item (yyvsp12))
					else
						yyval68 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), yyvs26.item (yyvsp26).first, yyvs26.item (yyvsp26).second, Void, Void, yyvs12.item (yyvsp12 - 1), True, yyvs27.item (yyvsp27), yyvs88.item (yyvsp88), yyvs12.item (yyvsp12))
					end
				else
					if yyvs28.item (yyvsp28) /= Void then
						yyval68 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), Void, Void, yyvs28.item (yyvsp28).first, yyvs28.item (yyvsp28).second, yyvs12.item (yyvsp12 - 1), True, yyvs27.item (yyvsp27), yyvs88.item (yyvsp88), yyvs12.item (yyvsp12))
					else
						yyval68 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), Void, Void, Void, Void, yyvs12.item (yyvsp12 - 1), True, yyvs27.item (yyvsp27), yyvs88.item (yyvsp88), yyvs12.item (yyvsp12))
					end
				end
				has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp68 := yyvsp68 + 1
	yyvsp110 := yyvsp110 -1
	yyvsp26 := yyvsp26 -1
	yyvsp28 := yyvsp28 -1
	yyvsp12 := yyvsp12 -2
	yyvsp27 := yyvsp27 -1
	yyvsp88 := yyvsp88 -1
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

	yy_do_action_337
			--|#line <not available> "eiffel.y"
		local
			yyval68: LOOP_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs26.item (yyvsp26) /= Void then
					if yyvs28.item (yyvsp28) /= Void then
						yyval68 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), yyvs26.item (yyvsp26).first, yyvs26.item (yyvsp26).second, yyvs28.item (yyvsp28).first, yyvs28.item (yyvsp28).second, extract_keyword (yyvs15.item (yyvsp15)), False, yyvs27.item (yyvsp27), yyvs88.item (yyvsp88), yyvs12.item (yyvsp12))
					else
						yyval68 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), yyvs26.item (yyvsp26).first, yyvs26.item (yyvsp26).second, Void, Void, extract_keyword (yyvs15.item (yyvsp15)), False, yyvs27.item (yyvsp27), yyvs88.item (yyvsp88), yyvs12.item (yyvsp12))
					end
				else
					if yyvs28.item (yyvsp28) /= Void then
						yyval68 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), Void, Void, yyvs28.item (yyvsp28).first, yyvs28.item (yyvsp28).second, extract_keyword (yyvs15.item (yyvsp15)), False, yyvs27.item (yyvsp27), yyvs88.item (yyvsp88), yyvs12.item (yyvsp12))
					else
						yyval68 := ast_factory.new_loop_expr_as (yyvs110.item (yyvsp110), Void, Void, Void, Void, extract_keyword (yyvs15.item (yyvsp15)), False, yyvs27.item (yyvsp27), yyvs88.item (yyvsp88), yyvs12.item (yyvsp12))
					end
				end
				has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp68 := yyvsp68 + 1
	yyvsp110 := yyvsp110 -1
	yyvsp26 := yyvsp26 -1
	yyvsp28 := yyvsp28 -1
	yyvsp15 := yyvsp15 -1
	yyvsp27 := yyvsp27 -1
	yyvsp88 := yyvsp88 -1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_338
			--|#line <not available> "eiffel.y"
		local
			yyval110: ITERATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				insert_supplier ("ITERABLE", yyvs2.item (yyvsp2))
				insert_supplier ("ITERATION_CURSOR", yyvs2.item (yyvsp2))
				yyval110 := ast_factory.new_iteration_as (extract_keyword (yyvs15.item (yyvsp15)), yyvs27.item (yyvsp27), yyvs12.item (yyvsp12), yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp110 := yyvsp110 + 1
	yyvsp15 := yyvsp15 -1
	yyvsp27 := yyvsp27 -1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_339
			--|#line <not available> "eiffel.y"
		local
			yyval26: PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp26 := yyvsp26 + 1
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

	yy_do_action_340
			--|#line <not available> "eiffel.y"
		local
			yyval26: PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval26 := ast_factory.new_invariant_pair (yyvs12.item (yyvsp12), yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp25 := yyvsp25 -1
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

	yy_do_action_341
			--|#line <not available> "eiffel.y"
		local
			yyval67: INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


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

	yy_do_action_342
			--|#line <not available> "eiffel.y"
		local
			yyval67: INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval67 := ast_factory.new_invariant_as (yyvs25.item (yyvsp25), once_manifest_string_counter_value, yyvs12.item (yyvsp12), object_test_locals)
				reset_once_manifest_string_counter
				object_test_locals := Void
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp25 := yyvsp25 -1
	yyvs67.put (yyval67, yyvsp67)
end
		end

	yy_do_action_343
			--|#line <not available> "eiffel.y"
		local
			yyval67: INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Invariant_level) 
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

	yy_do_action_344
			--|#line <not available> "eiffel.y"
		local
			yyval28: PAIR [KEYWORD_AS, EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp28 := yyvsp28 + 1
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

	yy_do_action_345
			--|#line <not available> "eiffel.y"
		local
			yyval28: PAIR [KEYWORD_AS, EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := ast_factory.new_exit_condition_pair (yyvs12.item (yyvsp12), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp28 := yyvsp28 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_346
			--|#line <not available> "eiffel.y"
		local
			yyval88: VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
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

	yy_do_action_347
			--|#line <not available> "eiffel.y"
		local
			yyval88: VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval88 := yyvs88.item (yyvsp88) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs88.put (yyval88, yyvsp88)
end
		end

	yy_do_action_348
			--|#line <not available> "eiffel.y"
		local
			yyval88: VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval88 := ast_factory.new_variant_as (yyvs2.item (yyvsp2), yyvs27.item (yyvsp27), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp88 := yyvsp88 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_349
			--|#line <not available> "eiffel.y"
		local
			yyval88: VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval88 := ast_factory.new_variant_as (Void, yyvs27.item (yyvsp27), yyvs12.item (yyvsp12), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp88 := yyvsp88 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_350
			--|#line <not available> "eiffel.y"
		local
			yyval49: DEBUG_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_debug_as (yyvs118.item (yyvsp118), yyvs19.item (yyvsp19), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp49 := yyvsp49 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp118 := yyvsp118 -1
	yyvsp19 := yyvsp19 -1
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

	yy_do_action_351
			--|#line <not available> "eiffel.y"
		local
			yyval118: KEY_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp118 := yyvsp118 + 1
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

	yy_do_action_352
			--|#line <not available> "eiffel.y"
		local
			yyval118: KEY_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval118 := ast_factory.new_key_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp118 := yyvsp118 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_353
			--|#line <not available> "eiffel.y"
		local
			yyval118: KEY_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval118 := ast_factory.new_key_list_as (yyvs117.item (yyvsp117), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp118 := yyvsp118 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp117 := yyvsp117 -1
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

	yy_do_action_354
			--|#line <not available> "eiffel.y"
		local
			yyval117: EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval117 := ast_factory.new_eiffel_list_string_as (counter_value + 1)
				if yyval117 /= Void and yyvs16.item (yyvsp16) /= Void then
					yyval117.reverse_extend (yyvs16.item (yyvsp16))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp117 := yyvsp117 + 1
	yyvsp16 := yyvsp16 -1
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

	yy_do_action_355
			--|#line <not available> "eiffel.y"
		local
			yyval117: EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval117 := yyvs117.item (yyvsp117)
				if yyval117 /= Void and yyvs16.item (yyvsp16) /= Void then
					yyval117.reverse_extend (yyvs16.item (yyvsp16))
					ast_factory.reverse_extend_separator (yyval117, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp16 := yyvsp16 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs117.put (yyval117, yyvsp117)
end
		end

	yy_do_action_356
			--|#line <not available> "eiffel.y"
		local
			yyval20: PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
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
	yyvs20.put (yyval20, yyvsp20)
end
		end

	yy_do_action_357
			--|#line <not available> "eiffel.y"
		local
			yyval20: PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs19.item (yyvsp19) = Void then
					yyval20 := ast_factory.new_keyword_instruction_list_pair (yyvs12.item (yyvsp12), ast_factory.new_eiffel_list_instruction_as (0))
				else
					yyval20 := ast_factory.new_keyword_instruction_list_pair (yyvs12.item (yyvsp12), yyvs19.item (yyvsp19))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp19 := yyvsp19 -1
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

	yy_do_action_358
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs37.item (yyvsp37) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp37 := yyvsp37 -1
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

	yy_do_action_359
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs27.item (yyvsp27) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_360
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_expr_call_as (yyvs40.item (yyvsp40)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp40 := yyvsp40 -1
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

	yy_do_action_361
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs74.item (yyvsp74) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp74 := yyvsp74 -1
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

	yy_do_action_362
			--|#line <not available> "eiffel.y"
		local
			yyval35: ASSIGNER_CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_assigner_call_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp35 := yyvsp35 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_363
			--|#line <not available> "eiffel.y"
		local
			yyval34: ASSIGN_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := ast_factory.new_assign_as (ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp34 := yyvsp34 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_364
			--|#line <not available> "eiffel.y"
		local
			yyval34: ASSIGN_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval34 := ast_factory.new_assign_as (yyvs6.item (yyvsp6), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp34 := yyvsp34 + 1
	yyvsp6 := yyvsp6 -1
	yyvsp4 := yyvsp4 -1
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_365
			--|#line <not available> "eiffel.y"
		local
			yyval78: REVERSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval78 := ast_factory.new_reverse_as (ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp78 := yyvsp78 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_366
			--|#line <not available> "eiffel.y"
		local
			yyval78: REVERSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval78 := ast_factory.new_reverse_as (yyvs6.item (yyvsp6), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp78 := yyvsp78 + 1
	yyvsp6 := yyvsp6 -1
	yyvsp4 := yyvsp4 -1
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_367
			--|#line <not available> "eiffel.y"
		local
			yyval93: EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


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

	yy_do_action_368
			--|#line <not available> "eiffel.y"
		local
			yyval93: EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval93 := yyvs93.item (yyvsp93) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs93.put (yyval93, yyvsp93)
end
		end

	yy_do_action_369
			--|#line <not available> "eiffel.y"
		local
			yyval93: EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval93 := ast_factory.new_eiffel_list_create_as (counter_value + 1)
				if yyval93 /= Void and yyvs46.item (yyvsp46) /= Void then
					yyval93.reverse_extend (yyvs46.item (yyvsp46))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp93 := yyvsp93 + 1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_370
			--|#line <not available> "eiffel.y"
		local
			yyval93: EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval93 := yyvs93.item (yyvsp93)
				if yyval93 /= Void and yyvs46.item (yyvsp46) /= Void then
					yyval93.reverse_extend (yyvs46.item (yyvsp46))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp46 := yyvsp46 -1
	yyvsp1 := yyvsp1 -1
	yyvs93.put (yyval93, yyvsp93)
end
		end

	yy_do_action_371
			--|#line <not available> "eiffel.y"
		local
			yyval46: CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval46 := ast_factory.new_create_as (Void, Void, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_372
			--|#line <not available> "eiffel.y"
		local
			yyval46: CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval46 := ast_factory.new_create_as (yyvs43.item (yyvsp43), yyvs101.item (yyvsp101), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp46 := yyvsp46 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp43 := yyvsp43 -1
	yyvsp101 := yyvsp101 -1
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

	yy_do_action_373
			--|#line <not available> "eiffel.y"
		local
			yyval46: CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval46 := ast_factory.new_create_as (ast_factory.new_client_as (yyvs108.item (yyvsp108)), Void, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp46 := yyvsp46 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp108 := yyvsp108 -1
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

	yy_do_action_374
			--|#line <not available> "eiffel.y"
		local
			yyval46: CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval46 := ast_factory.new_create_as (Void, Void, yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_375
			--|#line <not available> "eiffel.y"
		local
			yyval46: CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval46 := ast_factory.new_create_as (yyvs43.item (yyvsp43), yyvs101.item (yyvsp101), yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp46 := yyvsp46 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp43 := yyvsp43 -1
	yyvsp101 := yyvsp101 -1
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

	yy_do_action_376
			--|#line <not available> "eiffel.y"
		local
			yyval46: CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval46 := ast_factory.new_create_as (ast_factory.new_client_as (yyvs108.item (yyvsp108)), Void, yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp46 := yyvsp46 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp108 := yyvsp108 -1
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

	yy_do_action_377
			--|#line <not available> "eiffel.y"
		local
			yyval81: ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if yyvs85.item (yyvsp85) /= Void then
				last_type := yyvs85.item (yyvsp85).second
				last_symbol := yyvs85.item (yyvsp85).first
			else
				last_type := Void
				last_symbol := Void
			end
			
			yyval81 := ast_factory.new_inline_agent_creation_as (
				ast_factory.new_body_as (yyvs122.item (yyvsp122), last_type, Void, yyvs80.item (yyvsp80), last_symbol, Void, Void, Void), yyvs113.item (yyvsp113), yyvs12.item (yyvsp12))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp81 := yyvsp81 -1
	yyvsp12 := yyvsp12 -1
	yyvsp122 := yyvsp122 -1
	yyvsp85 := yyvsp85 -1
	yyvsp80 := yyvsp80 -1
	yyvsp113 := yyvsp113 -1
	yyvs81.put (yyval81, yyvsp81)
end
		end

	yy_do_action_378
			--|#line <not available> "eiffel.y"
		local
			yyval81: ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_feature_frame
if yy_parsing_status >= yyContinue then
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

	yy_do_action_379
			--|#line <not available> "eiffel.y"
		local
			yyval81: ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

remove_feature_frame
if yy_parsing_status >= yyContinue then
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

	yy_do_action_380
			--|#line <not available> "eiffel.y"
		local
			yyval81: ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval81 := ast_factory.new_agent_routine_creation_as (
				Void, yyvs2.item (yyvsp2), yyvs113.item (yyvsp113), False, yyvs12.item (yyvsp12), Void)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp81 := yyvsp81 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	yyvsp113 := yyvsp113 -1
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

	yy_do_action_381
			--|#line <not available> "eiffel.y"
		local
			yyval81: ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if yyvs29.item (yyvsp29) /= Void then
				yyval81 := ast_factory.new_agent_routine_creation_as (yyvs29.item (yyvsp29).operand, yyvs2.item (yyvsp2), yyvs113.item (yyvsp113), True, yyvs12.item (yyvsp12), yyvs4.item (yyvsp4))
				if yyval81 /= Void then
					yyval81.set_lparan_symbol (yyvs29.item (yyvsp29).lparan_symbol)
					yyval81.set_rparan_symbol (yyvs29.item (yyvsp29).rparan_symbol)
				end
			else
				yyval81 := ast_factory.new_agent_routine_creation_as (Void, yyvs2.item (yyvsp2), yyvs113.item (yyvsp113), True, yyvs12.item (yyvsp12), yyvs4.item (yyvsp4))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp81 := yyvsp81 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp29 := yyvsp29 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp113 := yyvsp113 -1
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

	yy_do_action_382
			--|#line <not available> "eiffel.y"
		local
			yyval122: FORMAL_ARGU_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp122 := yyvsp122 + 1
	if yyvsp122 >= yyvsc122 then
		if yyvs122 = Void then
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
	yyvs122.put (yyval122, yyvsp122)
end
		end

	yy_do_action_383
			--|#line <not available> "eiffel.y"
		local
			yyval122: FORMAL_ARGU_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval122 := yyvs122.item (yyvsp122)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs122.put (yyval122, yyvsp122)
end
		end

	yy_do_action_384
			--|#line <not available> "eiffel.y"
		local
			yyval85: PAIR [SYMBOL_AS, TYPE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
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

	yy_do_action_385
			--|#line <not available> "eiffel.y"
		local
			yyval85: PAIR [SYMBOL_AS, TYPE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			create yyval85.make (yyvs4.item (yyvsp4), yyvs83.item (yyvsp83))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp85 := yyvsp85 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp83 := yyvsp83 -1
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

	yy_do_action_386
			--|#line <not available> "eiffel.y"
		local
			yyval29: AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), Void)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp29 := yyvsp29 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_387
			--|#line <not available> "eiffel.y"
		local
			yyval29: AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_agent_target_triple (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), ast_factory.new_operand_as (Void, Void, yyvs27.item (yyvsp27))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp29 := yyvsp29 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -4
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_388
			--|#line <not available> "eiffel.y"
		local
			yyval29: AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, yyvs6.item (yyvsp6), Void)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp29 := yyvsp29 + 1
	yyvsp6 := yyvsp6 -1
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

	yy_do_action_389
			--|#line <not available> "eiffel.y"
		local
			yyval29: AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, yyvs9.item (yyvsp9), Void)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp29 := yyvsp29 + 1
	yyvsp9 := yyvsp9 -1
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

	yy_do_action_390
			--|#line <not available> "eiffel.y"
		local
			yyval29: AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (yyvs83.item (yyvsp83), Void, Void))
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp29 := yyvsp29 + 1
	yyvsp83 := yyvsp83 -1
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

	yy_do_action_391
			--|#line <not available> "eiffel.y"
		local
			yyval29: AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			temp_operand_as := ast_factory.new_operand_as (Void, Void, Void)
			if temp_operand_as /= Void then
				temp_operand_as.set_question_mark_symbol (yyvs4.item (yyvsp4))
			end
			yyval29 := ast_factory.new_agent_target_triple (Void, Void, temp_operand_as)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp29 := yyvsp29 + 1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_392
			--|#line <not available> "eiffel.y"
		local
			yyval113: DELAYED_ACTUAL_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp113 := yyvsp113 + 1
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

	yy_do_action_393
			--|#line <not available> "eiffel.y"
		local
			yyval113: DELAYED_ACTUAL_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval113 := ast_factory.new_delayed_actual_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp113 := yyvsp113 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_394
			--|#line <not available> "eiffel.y"
		local
			yyval113: DELAYED_ACTUAL_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval113 := ast_factory.new_delayed_actual_list_as (yyvs112.item (yyvsp112), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp113 := yyvsp113 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp112 := yyvsp112 -1
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

	yy_do_action_395
			--|#line <not available> "eiffel.y"
		local
			yyval112: EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval112 := ast_factory.new_eiffel_list_operand_as (counter_value + 1)
				if yyval112 /= Void and yyvs71.item (yyvsp71) /= Void then
					yyval112.reverse_extend (yyvs71.item (yyvsp71))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp112 := yyvsp112 + 1
	yyvsp71 := yyvsp71 -1
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

	yy_do_action_396
			--|#line <not available> "eiffel.y"
		local
			yyval112: EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval112 := yyvs112.item (yyvsp112)
				if yyval112 /= Void and yyvs71.item (yyvsp71) /= Void then
					yyval112.reverse_extend (yyvs71.item (yyvsp71))
					ast_factory.reverse_extend_separator (yyval112, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp71 := yyvsp71 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_397
			--|#line <not available> "eiffel.y"
		local
			yyval71: OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := ast_factory.new_operand_as (Void, Void, Void)
				if yyval71 /= Void then
					yyval71.set_question_mark_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp71 := yyvsp71 + 1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_398
			--|#line <not available> "eiffel.y"
		local
			yyval71: OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := ast_factory.new_operand_as (yyvs83.item (yyvsp83), Void, Void)
				if yyval71 /= Void then
					yyval71.set_question_mark_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp71 := yyvsp71 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_399
			--|#line <not available> "eiffel.y"
		local
			yyval71: OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := ast_factory.new_operand_as (Void, Void, yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp71 := yyvsp71 + 1
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_400
			--|#line <not available> "eiffel.y"
		local
			yyval47: CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval47 := ast_factory.new_bang_creation_as (Void, yyvs30.item (yyvsp30), yyvs32.item (yyvsp32), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)),
						filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp47 := yyvsp47 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp30 := yyvsp30 -1
	yyvsp32 := yyvsp32 -1
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

	yy_do_action_401
			--|#line <not available> "eiffel.y"
		local
			yyval47: CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval47 := ast_factory.new_bang_creation_as (yyvs83.item (yyvsp83), yyvs30.item (yyvsp30), yyvs32.item (yyvsp32), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)),
						filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp47 := yyvsp47 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp83 := yyvsp83 -1
	yyvsp30 := yyvsp30 -1
	yyvsp32 := yyvsp32 -1
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

	yy_do_action_402
			--|#line <not available> "eiffel.y"
		local
			yyval47: CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval47 := ast_factory.new_create_creation_as (Void, yyvs30.item (yyvsp30), yyvs32.item (yyvsp32), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp47 := yyvsp47 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp30 := yyvsp30 -1
	yyvsp32 := yyvsp32 -1
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

	yy_do_action_403
			--|#line <not available> "eiffel.y"
		local
			yyval47: CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval47 := ast_factory.new_create_creation_as (yyvs83.item (yyvsp83), yyvs30.item (yyvsp30), yyvs32.item (yyvsp32), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp47 := yyvsp47 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp83 := yyvsp83 -1
	yyvsp30 := yyvsp30 -1
	yyvsp32 := yyvsp32 -1
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

	yy_do_action_404
			--|#line <not available> "eiffel.y"
		local
			yyval48: CREATION_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_create_creation_expr_as (yyvs83.item (yyvsp83), yyvs32.item (yyvsp32), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp48 := yyvsp48 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp83 := yyvsp83 -1
	yyvsp32 := yyvsp32 -1
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

	yy_do_action_405
			--|#line <not available> "eiffel.y"
		local
			yyval48: CREATION_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval48 := ast_factory.new_bang_creation_expr_as (yyvs83.item (yyvsp83), yyvs32.item (yyvsp32), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)),
						filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp48 := yyvsp48 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp83 := yyvsp83 -1
	yyvsp32 := yyvsp32 -1
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

	yy_do_action_406
			--|#line <not available> "eiffel.y"
		local
			yyval30: ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_407
			--|#line <not available> "eiffel.y"
		local
			yyval30: ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := yyvs6.item (yyvsp6) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp30 := yyvsp30 + 1
	yyvsp6 := yyvsp6 -1
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

	yy_do_action_408
			--|#line <not available> "eiffel.y"
		local
			yyval32: ACCESS_INV_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp32 := yyvsp32 + 1
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

	yy_do_action_409
			--|#line <not available> "eiffel.y"
		local
			yyval32: ACCESS_INV_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_access_inv_as (yyvs2.item (yyvsp2), yyvs98.item (yyvsp98), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp98 := yyvsp98 -1
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

	yy_do_action_410
			--|#line <not available> "eiffel.y"
		local
			yyval40: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := yyvs30.item (yyvsp30) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp40 := yyvsp40 + 1
	yyvsp30 := yyvsp30 -1
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

	yy_do_action_411
			--|#line <not available> "eiffel.y"
		local
			yyval40: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := yyvs73.item (yyvsp73) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp40 := yyvsp40 + 1
	yyvsp73 := yyvsp73 -1
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

	yy_do_action_412
			--|#line <not available> "eiffel.y"
		local
			yyval40: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := yyvs74.item (yyvsp74) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp40 := yyvsp40 + 1
	yyvsp74 := yyvsp74 -1
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

	yy_do_action_413
			--|#line <not available> "eiffel.y"
		local
			yyval40: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := yyvs40.item (yyvsp40) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs40.put (yyval40, yyvsp40)
end
		end

	yy_do_action_414
			--|#line <not available> "eiffel.y"
		local
			yyval42: CHECK_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval42 := ast_factory.new_check_as (yyvs25.item (yyvsp25), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp42 := yyvsp42 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp25 := yyvsp25 -1
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

	yy_do_action_415
			--|#line <not available> "eiffel.y"
		local
			yyval60: GUARD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := ast_factory.new_guard_as (yyvs12.item (yyvsp12 - 2), yyvs25.item (yyvsp25), yyvs12.item (yyvsp12 - 1), yyvs19.item (yyvsp19), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp60 := yyvsp60 + 1
	yyvsp12 := yyvsp12 -3
	yyvsp25 := yyvsp25 -1
	yyvsp19 := yyvsp19 -1
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

	yy_do_action_416
			--|#line <not available> "eiffel.y"
		local
			yyval83: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := yyvs83.item (yyvsp83)
				if yyval83 /= Void then
					yyval83.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					yyval83.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_417
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs64.item (yyvsp64); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp64 := yyvsp64 -1
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

	yy_do_action_418
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs75.item (yyvsp75); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp75 := yyvsp75 -1
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

	yy_do_action_419
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs27.item (yyvsp27) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_420
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_bin_tilde_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp27 := yyvsp27 -1
	yyvsp4 := yyvsp4 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_421
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_bin_not_tilde_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp27 := yyvsp27 -1
	yyvsp4 := yyvsp4 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_422
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_bin_eq_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp27 := yyvsp27 -1
	yyvsp4 := yyvsp4 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_423
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_bin_ne_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp27 := yyvsp27 -1
	yyvsp4 := yyvsp4 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_424
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs37.item (yyvsp37); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp37 := yyvsp37 -1
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

	yy_do_action_425
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				check_object_test_expression (yyvs27.item (yyvsp27))
				yyval27 := ast_factory.new_object_test_as (extract_keyword (yyvs15.item (yyvsp15)), Void, yyvs27.item (yyvsp27), Void, Void)
				has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_426
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				check_object_test_expression (yyvs27.item (yyvsp27))
				yyval27 := ast_factory.new_object_test_as (extract_keyword (yyvs15.item (yyvsp15)), Void, yyvs27.item (yyvsp27), yyvs12.item (yyvsp12), yyvs2.item (yyvsp2))
				has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp15 := yyvsp15 -1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_427
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs83.item (yyvsp83) /= Void then
					yyvs83.item (yyvsp83).set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					yyvs83.item (yyvsp83).set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
				check_object_test_expression (yyvs27.item (yyvsp27))
				yyval27 := ast_factory.new_object_test_as (extract_keyword (yyvs15.item (yyvsp15)), yyvs83.item (yyvsp83), yyvs27.item (yyvsp27), Void, Void)
				has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp15 := yyvsp15 -1
	yyvsp4 := yyvsp4 -2
	yyvsp83 := yyvsp83 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_428
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs83.item (yyvsp83) /= Void then
					yyvs83.item (yyvsp83).set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					yyvs83.item (yyvsp83).set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
				check_object_test_expression (yyvs27.item (yyvsp27))
				yyval27 := ast_factory.new_object_test_as (extract_keyword (yyvs15.item (yyvsp15)), yyvs83.item (yyvsp83), yyvs27.item (yyvsp27), yyvs12.item (yyvsp12), yyvs2.item (yyvsp2))
				has_type := True
				if object_test_locals = Void then
					create object_test_locals.make (1)
				end
				object_test_locals.extend ([yyvs2.item (yyvsp2), yyvs83.item (yyvsp83)])
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp15 := yyvsp15 -1
	yyvsp4 := yyvsp4 -2
	yyvsp83 := yyvsp83 -1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_429
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				check_object_test_expression (yyvs27.item (yyvsp27))
				yyval27 := ast_factory.new_old_syntax_object_test_as (yyvs4.item (yyvsp4 - 2), yyvs2.item (yyvsp2), yyvs83.item (yyvsp83), yyvs27.item (yyvsp27))
				has_type := True
				if object_test_locals = Void then
					create object_test_locals.make (1)
				end
				object_test_locals.extend ([yyvs2.item (yyvsp2), yyvs83.item (yyvsp83)])
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 2)), token_column (yyvs4.item (yyvsp4 - 2)),
							filename, once "Use the new syntax for object test `attached {T} exp as x'."))

				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp4 := yyvsp4 -3
	yyvsp2 := yyvsp2 -1
	yyvsp83 := yyvsp83 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_430
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_plus_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_431
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_minus_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_432
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_star_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_433
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_slash_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_434
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_mod_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_435
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_div_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_436
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_power_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_437
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_and_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_438
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_and_then_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp12 := yyvsp12 -2
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

	yy_do_action_439
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_or_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_440
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_or_else_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27),yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp12 := yyvsp12 -2
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

	yy_do_action_441
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_implies_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_442
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_xor_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp12 := yyvsp12 -1
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

	yy_do_action_443
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_ge_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_444
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_gt_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_445
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_le_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_446
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_lt_as (yyvs27.item (yyvsp27 - 1), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_447
			--|#line <not available> "eiffel.y"
		local
			yyval37: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_bin_free_as (yyvs27.item (yyvsp27 - 1), yyvs2.item (yyvsp2), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp27 := yyvsp27 -2
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_448
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs11.item (yyvsp11); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp11 := yyvsp11 -1
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

	yy_do_action_449
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs33.item (yyvsp33); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp33 := yyvsp33 -1
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

	yy_do_action_450
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs81.item (yyvsp81); has_type := False 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp81 := yyvsp81 -1
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

	yy_do_action_451
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_un_old_as (yyvs27.item (yyvsp27), yyvs12.item (yyvsp12)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_452
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval27 := ast_factory.new_un_strip_as (yyvs23.item (yyvsp23), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)); has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp27 := yyvsp27 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -2
	yyvsp23 := yyvsp23 -1
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

	yy_do_action_453
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_address_as (yyvs89.item (yyvsp89), yyvs4.item (yyvsp4)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp27 := yyvsp27 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_454
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval27 := ast_factory.new_expr_address_as (yyvs27.item (yyvsp27), yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)); has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -3
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_455
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval27 := ast_factory.new_address_current_as (yyvs9.item (yyvsp9), yyvs4.item (yyvsp4)); has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp27 := yyvsp27 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp9 := yyvsp9 -1
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

	yy_do_action_456
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval27 := ast_factory.new_address_result_as (yyvs6.item (yyvsp6), yyvs4.item (yyvsp4)); has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp27 := yyvsp27 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp6 := yyvsp6 -1
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

	yy_do_action_457
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs27.item (yyvsp27) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_458
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs27.item (yyvsp27); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_459
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_bracket_as (yyvs27.item (yyvsp27), yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp97 := yyvsp97 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_460
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_un_minus_as (yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_461
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_un_plus_as (yyvs27.item (yyvsp27), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_462
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_un_not_as (yyvs27.item (yyvsp27), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_463
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_un_free_as (yyvs2.item (yyvsp2), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_464
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_type_expr_as (yyvs83.item (yyvsp83)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp83 := yyvsp83 -1
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

	yy_do_action_465
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs64.item (yyvsp64) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp64 := yyvsp64 -1
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

	yy_do_action_466
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp75 := yyvsp75 -1
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

	yy_do_action_467
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs2.item (yyvsp2) /= Void then
					yyvs2.item (yyvsp2).to_lower
				end
				yyval2 := yyvs2.item (yyvsp2)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_468
			--|#line <not available> "eiffel.y"
		local
			yyval40: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := ast_factory.new_nested_as (yyvs9.item (yyvsp9), yyvs40.item (yyvsp40), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp9 := yyvsp9 -1
	yyvsp4 := yyvsp4 -1
	yyvs40.put (yyval40, yyvsp40)
end
		end

	yy_do_action_469
			--|#line <not available> "eiffel.y"
		local
			yyval40: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := ast_factory.new_nested_as (yyvs6.item (yyvsp6), yyvs40.item (yyvsp40), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp6 := yyvsp6 -1
	yyvsp4 := yyvsp4 -1
	yyvs40.put (yyval40, yyvsp40)
end
		end

	yy_do_action_470
			--|#line <not available> "eiffel.y"
		local
			yyval40: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := ast_factory.new_nested_as (yyvs30.item (yyvsp30), yyvs40.item (yyvsp40), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp30 := yyvsp30 -1
	yyvsp4 := yyvsp4 -1
	yyvs40.put (yyval40, yyvsp40)
end
		end

	yy_do_action_471
			--|#line <not available> "eiffel.y"
		local
			yyval40: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := ast_factory.new_nested_expr_as (yyvs27.item (yyvsp27), yyvs40.item (yyvsp40), yyvs4.item (yyvsp4), yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -3
	yyvsp27 := yyvsp27 -1
	yyvs40.put (yyval40, yyvsp40)
end
		end

	yy_do_action_472
			--|#line <not available> "eiffel.y"
		local
			yyval40: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := ast_factory.new_nested_expr_as (ast_factory.new_bracket_as (yyvs27.item (yyvsp27), yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1)), yyvs40.item (yyvsp40), yyvs4.item (yyvsp4), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp27 := yyvsp27 -1
	yyvsp4 := yyvsp4 -3
	yyvsp1 := yyvsp1 -2
	yyvsp97 := yyvsp97 -1
	yyvs40.put (yyval40, yyvsp40)
end
		end

	yy_do_action_473
			--|#line <not available> "eiffel.y"
		local
			yyval40: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := ast_factory.new_nested_as (yyvs73.item (yyvsp73), yyvs40.item (yyvsp40), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp73 := yyvsp73 -1
	yyvsp4 := yyvsp4 -1
	yyvs40.put (yyval40, yyvsp40)
end
		end

	yy_do_action_474
			--|#line <not available> "eiffel.y"
		local
			yyval40: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := ast_factory.new_nested_as (yyvs74.item (yyvsp74), yyvs40.item (yyvsp40), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp74 := yyvsp74 -1
	yyvsp4 := yyvsp4 -1
	yyvs40.put (yyval40, yyvsp40)
end
		end

	yy_do_action_475
			--|#line <not available> "eiffel.y"
		local
			yyval73: PRECURSOR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval73 := ast_factory.new_precursor_as (yyvs12.item (yyvsp12), Void, yyvs98.item (yyvsp98)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp73 := yyvsp73 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp98 := yyvsp98 -1
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

	yy_do_action_476
			--|#line <not available> "eiffel.y"
		local
			yyval73: PRECURSOR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				temp_class_type_as := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), Void)
				if temp_class_type_as /= Void then
					temp_class_type_as.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					temp_class_type_as.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
				yyval73 := ast_factory.new_precursor_as (yyvs12.item (yyvsp12), temp_class_type_as, yyvs98.item (yyvsp98))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp73 := yyvsp73 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -2
	yyvsp2 := yyvsp2 -1
	yyvsp98 := yyvsp98 -1
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

	yy_do_action_477
			--|#line <not available> "eiffel.y"
		local
			yyval74: STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval74 := yyvs74.item (yyvsp74) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs74.put (yyval74, yyvsp74)
end
		end

	yy_do_action_478
			--|#line <not available> "eiffel.y"
		local
			yyval74: STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval74 := yyvs74.item (yyvsp74) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs74.put (yyval74, yyvsp74)
end
		end

	yy_do_action_479
			--|#line <not available> "eiffel.y"
		local
			yyval74: STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval74 := ast_factory.new_static_access_as (yyvs83.item (yyvsp83), yyvs2.item (yyvsp2), yyvs98.item (yyvsp98), Void, yyvs4.item (yyvsp4)); 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp74 := yyvsp74 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp98 := yyvsp98 -1
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

	yy_do_action_480
			--|#line <not available> "eiffel.y"
		local
			yyval74: STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval74 := ast_factory.new_static_access_as (yyvs83.item (yyvsp83), yyvs2.item (yyvsp2), yyvs98.item (yyvsp98), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4));
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)),
							filename, once "Remove the `feature' keyword."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp74 := yyvsp74 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp83 := yyvsp83 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp98 := yyvsp98 -1
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

	yy_do_action_481
			--|#line <not available> "eiffel.y"
		local
			yyval40: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := yyvs70.item (yyvsp70) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp40 := yyvsp40 + 1
	yyvsp70 := yyvsp70 -1
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

	yy_do_action_482
			--|#line <not available> "eiffel.y"
		local
			yyval40: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := yyvs31.item (yyvsp31) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp40 := yyvsp40 + 1
	yyvsp31 := yyvsp31 -1
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

	yy_do_action_483
			--|#line <not available> "eiffel.y"
		local
			yyval70: NESTED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval70 := ast_factory.new_nested_as (yyvs31.item (yyvsp31 - 1), yyvs31.item (yyvsp31), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp70 := yyvsp70 + 1
	yyvsp31 := yyvsp31 -2
	yyvsp4 := yyvsp4 -1
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

	yy_do_action_484
			--|#line <not available> "eiffel.y"
		local
			yyval70: NESTED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval70 := ast_factory.new_nested_as (yyvs31.item (yyvsp31), yyvs70.item (yyvsp70), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 -1
	yyvsp4 := yyvsp4 -1
	yyvs70.put (yyval70, yyvsp70)
end
		end

	yy_do_action_485
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval2 := yyvs2.item (yyvsp2)
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_486
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs89.item (yyvsp89) /= Void then
					yyval2 := yyvs89.item (yyvsp89).internal_name
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_487
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs89.item (yyvsp89) /= Void then
					yyval2 := yyvs89.item (yyvsp89).internal_name
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_488
			--|#line <not available> "eiffel.y"
		local
			yyval30: ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				inspect id_level
				when Normal_level then
					yyval30 := ast_factory.new_access_id_as (yyvs2.item (yyvsp2), yyvs98.item (yyvsp98))
				when Assert_level then
					yyval30 := ast_factory.new_access_assert_as (yyvs2.item (yyvsp2), yyvs98.item (yyvsp98))
				when Invariant_level then
					yyval30 := ast_factory.new_access_inv_as (yyvs2.item (yyvsp2), yyvs98.item (yyvsp98), Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp30 := yyvsp30 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp98 := yyvsp98 -1
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

	yy_do_action_489
			--|#line <not available> "eiffel.y"
		local
			yyval31: ACCESS_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_access_feat_as (yyvs2.item (yyvsp2), yyvs98.item (yyvsp98)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp98 := yyvsp98 -1
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

	yy_do_action_490
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs36.item (yyvsp36); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp36 := yyvsp36 -1
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

	yy_do_action_491
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs27.item (yyvsp27); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_492
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs82.item (yyvsp82); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp82 := yyvsp82 -1
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

	yy_do_action_493
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_expr_call_as (yyvs9.item (yyvsp9)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp9 := yyvsp9 -1
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

	yy_do_action_494
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_expr_call_as (yyvs6.item (yyvsp6)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp6 := yyvsp6 -1
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

	yy_do_action_495
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_expr_call_as (yyvs40.item (yyvsp40)); has_type := False 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp40 := yyvsp40 -1
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

	yy_do_action_496
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_expr_call_as (yyvs48.item (yyvsp48)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp48 := yyvsp48 -1
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

	yy_do_action_497
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := yyvs68.item (yyvsp68) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp27 := yyvsp27 + 1
	yyvsp68 := yyvsp68 -1
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

	yy_do_action_498
			--|#line <not available> "eiffel.y"
		local
			yyval27: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_paran_as (yyvs27.item (yyvsp27), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_499
			--|#line <not available> "eiffel.y"
		local
			yyval98: PARAMETER_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_500
			--|#line <not available> "eiffel.y"
		local
			yyval98: PARAMETER_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval98 := ast_factory.new_parameter_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp98 := yyvsp98 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_501
			--|#line <not available> "eiffel.y"
		local
			yyval98: PARAMETER_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval98 := ast_factory.new_parameter_list_as (yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp98 := yyvsp98 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp97 := yyvsp97 -1
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

	yy_do_action_502
			--|#line <not available> "eiffel.y"
		local
			yyval97: EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval97 := ast_factory.new_eiffel_list_expr_as (counter_value + 1)
				if yyval97 /= Void and yyvs27.item (yyvsp27) /= Void then
					yyval97.reverse_extend (yyvs27.item (yyvsp27))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp97 := yyvsp97 + 1
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_503
			--|#line <not available> "eiffel.y"
		local
			yyval97: EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval97 := yyvs97.item (yyvsp97)
				if yyval97 /= Void and yyvs27.item (yyvsp27) /= Void then
					yyval97.reverse_extend (yyvs27.item (yyvsp27))
					ast_factory.reverse_extend_separator (yyval97, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp27 := yyvsp27 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyvs97.put (yyval97, yyvsp97)
end
		end

	yy_do_action_504
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval2 := yyvs2.item (yyvsp2)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_505
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval2 := yyvs2.item (yyvsp2);
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_506
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs2.item (yyvsp2) /= Void then
					yyvs2.item (yyvsp2).to_upper		
				end
				yyval2 := yyvs2.item (yyvsp2)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_507
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
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

	yy_do_action_508
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
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

	yy_do_action_509
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
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

	yy_do_action_510
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
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

	yy_do_action_511
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
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

	yy_do_action_512
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
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

	yy_do_action_513
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs2.item (yyvsp2) /= Void then
					yyvs2.item (yyvsp2).to_upper
				end
				yyval2 := yyvs2.item (yyvsp2)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_514
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs2.item (yyvsp2) /= Void then
					yyvs2.item (yyvsp2).to_lower
				end
				yyval2 := yyvs2.item (yyvsp2)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_515
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs2.item (yyvsp2) /= Void then
					yyvs2.item (yyvsp2).to_lower
				end
				yyval2 := yyvs2.item (yyvsp2)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_516
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
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

	yy_do_action_517
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
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

	yy_do_action_518
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
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

	yy_do_action_519
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
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

	yy_do_action_520
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp5 := yyvsp5 -1
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

	yy_do_action_521
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_522
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs64.item (yyvsp64) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp64 := yyvsp64 -1
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

	yy_do_action_523
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp75 := yyvsp75 -1
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

	yy_do_action_524
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs38.item (yyvsp38) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp38 := yyvsp38 -1
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

	yy_do_action_525
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp16 := yyvsp16 -1
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

	yy_do_action_526
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp5 := yyvsp5 -1
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

	yy_do_action_527
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs64.item (yyvsp64) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp64 := yyvsp64 -1
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

	yy_do_action_528
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs64.item (yyvsp64) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp64 := yyvsp64 -1
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

	yy_do_action_529
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp75 := yyvsp75 -1
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

	yy_do_action_530
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp75 := yyvsp75 -1
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

	yy_do_action_531
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_532
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := yyvs38.item (yyvsp38) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp38 := yyvsp38 -1
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

	yy_do_action_533
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				setup_binary_manifest_string (yyvs16.item (yyvsp16))
				yyval36 := yyvs16.item (yyvsp16) 
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp36 := yyvsp36 + 1
	yyvsp16 := yyvsp16 -1
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

	yy_do_action_534
			--|#line <not available> "eiffel.y"
		local
			yyval36: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs16.item (yyvsp16) /= Void then
					yyvs16.item (yyvsp16).set_is_once_string (True)
					yyvs16.item (yyvsp16).set_once_string_keyword (yyvs12.item (yyvsp12))
					setup_binary_manifest_string (yyvs16.item (yyvsp16))
				end
				increment_once_manifest_string_counter
				yyval36 := yyvs16.item (yyvsp16)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp36 := yyvsp36 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp16 := yyvsp16 -1
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

	yy_do_action_535
			--|#line <not available> "eiffel.y"
		local
			yyval5: BOOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs5.put (yyval5, yyvsp5)
end
		end

	yy_do_action_536
			--|#line <not available> "eiffel.y"
		local
			yyval5: BOOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs5.put (yyval5, yyvsp5)
end
		end

	yy_do_action_537
			--|#line <not available> "eiffel.y"
		local
			yyval3: CHAR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval3 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs3.put (yyval3, yyvsp3)
end
		end

	yy_do_action_538
			--|#line <not available> "eiffel.y"
		local
			yyval3: CHAR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval3 := ast_factory.new_typed_char_as (yyvs83.item (yyvsp83), yyvs3.item (yyvsp3)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 -1
	yyvs3.put (yyval3, yyvsp3)
end
		end

	yy_do_action_539
			--|#line <not available> "eiffel.y"
		local
			yyval64: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := yyvs64.item (yyvsp64) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs64.put (yyval64, yyvsp64)
end
		end

	yy_do_action_540
			--|#line <not available> "eiffel.y"
		local
			yyval64: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := yyvs64.item (yyvsp64) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs64.put (yyval64, yyvsp64)
end
		end

	yy_do_action_541
			--|#line <not available> "eiffel.y"
		local
			yyval64: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := yyvs64.item (yyvsp64) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs64.put (yyval64, yyvsp64)
end
		end

	yy_do_action_542
			--|#line <not available> "eiffel.y"
		local
			yyval64: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval64 := ast_factory.new_integer_value (Current, '+', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp64 := yyvsp64 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_543
			--|#line <not available> "eiffel.y"
		local
			yyval64: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval64 := ast_factory.new_integer_value (Current, '-', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp64 := yyvsp64 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_544
			--|#line <not available> "eiffel.y"
		local
			yyval64: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval64 := ast_factory.new_integer_value (Current, '%U', Void, token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp64 := yyvsp64 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_545
			--|#line <not available> "eiffel.y"
		local
			yyval64: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := yyvs64.item (yyvsp64) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs64.put (yyval64, yyvsp64)
end
		end

	yy_do_action_546
			--|#line <not available> "eiffel.y"
		local
			yyval64: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := yyvs64.item (yyvsp64) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs64.put (yyval64, yyvsp64)
end
		end

	yy_do_action_547
			--|#line <not available> "eiffel.y"
		local
			yyval64: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval64 := ast_factory.new_integer_value (Current, '%U', yyvs83.item (yyvsp83), token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp64 := yyvsp64 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_548
			--|#line <not available> "eiffel.y"
		local
			yyval64: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval64 := ast_factory.new_integer_value (Current, '+', yyvs83.item (yyvsp83), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp64 := yyvsp64 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_549
			--|#line <not available> "eiffel.y"
		local
			yyval64: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval64 := ast_factory.new_integer_value (Current, '-', yyvs83.item (yyvsp83), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp64 := yyvsp64 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_550
			--|#line <not available> "eiffel.y"
		local
			yyval75: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval75 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs75.put (yyval75, yyvsp75)
end
		end

	yy_do_action_551
			--|#line <not available> "eiffel.y"
		local
			yyval75: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval75 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs75.put (yyval75, yyvsp75)
end
		end

	yy_do_action_552
			--|#line <not available> "eiffel.y"
		local
			yyval75: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval75 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs75.put (yyval75, yyvsp75)
end
		end

	yy_do_action_553
			--|#line <not available> "eiffel.y"
		local
			yyval75: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := ast_factory.new_real_value (Current, False, '%U', Void, token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp75 := yyvsp75 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_554
			--|#line <not available> "eiffel.y"
		local
			yyval75: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := ast_factory.new_real_value (Current, True, '+', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp75 := yyvsp75 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_555
			--|#line <not available> "eiffel.y"
		local
			yyval75: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := ast_factory.new_real_value (Current, True, '-', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp75 := yyvsp75 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_556
			--|#line <not available> "eiffel.y"
		local
			yyval75: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval75 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs75.put (yyval75, yyvsp75)
end
		end

	yy_do_action_557
			--|#line <not available> "eiffel.y"
		local
			yyval75: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval75 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs75.put (yyval75, yyvsp75)
end
		end

	yy_do_action_558
			--|#line <not available> "eiffel.y"
		local
			yyval75: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := ast_factory.new_real_value (Current, False, '%U', yyvs83.item (yyvsp83), token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp75 := yyvsp75 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_559
			--|#line <not available> "eiffel.y"
		local
			yyval75: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := ast_factory.new_real_value (Current, True, '+', yyvs83.item (yyvsp83), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp75 := yyvsp75 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_560
			--|#line <not available> "eiffel.y"
		local
			yyval75: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := ast_factory.new_real_value (Current, True, '-', yyvs83.item (yyvsp83), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp75 := yyvsp75 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_561
			--|#line <not available> "eiffel.y"
		local
			yyval38: BIT_CONST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval38 := ast_factory.new_bit_const_as (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp38 := yyvsp38 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_562
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_563
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_564
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_565
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_566
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_567
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval16 := yyvs16.item (yyvsp16)
				if yyval16 /= Void then
					yyval16.set_type (yyvs83.item (yyvsp83))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 -1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_568
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_569
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_570
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_571
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_572
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_573
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_574
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_575
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_576
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_577
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_578
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_579
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_580
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_581
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_582
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_583
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_584
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_585
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_586
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_587
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_588
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_589
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_590
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_591
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_592
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if yyvs16.item (yyvsp16) /= Void then
					yyvs16.item (yyvsp16).value.to_lower
				end
				yyval16 := yyvs16.item (yyvsp16)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_593
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if yyvs16.item (yyvsp16) /= Void then
					yyvs16.item (yyvsp16).value.to_lower
				end
				yyval16 := yyvs16.item (yyvsp16)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_594
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_595
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_596
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_597
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_598
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_599
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_600
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_601
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_602
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_603
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_604
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_605
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if yyvs16.item (yyvsp16) /= Void then
					yyvs16.item (yyvsp16).value.to_lower
				end
				yyval16 := yyvs16.item (yyvsp16)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_606
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if yyvs16.item (yyvsp16) /= Void then
					yyvs16.item (yyvsp16).value.to_lower
				end
				yyval16 := yyvs16.item (yyvsp16)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_607
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if yyvs16.item (yyvsp16) /= Void then
					yyvs16.item (yyvsp16).value.to_lower
				end
				yyval16 := yyvs16.item (yyvsp16)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_608
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if yyvs16.item (yyvsp16) /= Void then
					yyvs16.item (yyvsp16).value.to_lower
				end
				yyval16 := yyvs16.item (yyvsp16)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_609
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if yyvs16.item (yyvsp16) /= Void then
					yyvs16.item (yyvsp16).value.to_lower
				end
				yyval16 := yyvs16.item (yyvsp16)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_610
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if yyvs16.item (yyvsp16) /= Void then
					yyvs16.item (yyvsp16).value.to_lower
				end
				yyval16 := yyvs16.item (yyvsp16)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_611
			--|#line <not available> "eiffel.y"
		local
			yyval16: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if yyvs16.item (yyvsp16) /= Void then
					yyvs16.item (yyvsp16).value.to_lower
				end
				yyval16 := yyvs16.item (yyvsp16)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_612
			--|#line <not available> "eiffel.y"
		local
			yyval33: ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval33 := ast_factory.new_array_as (ast_factory.new_eiffel_list_expr_as (0), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp33 := yyvsp33 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_613
			--|#line <not available> "eiffel.y"
		local
			yyval33: ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval33 := ast_factory.new_array_as (yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp33 := yyvsp33 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp97 := yyvsp97 -1
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

	yy_do_action_614
			--|#line <not available> "eiffel.y"
		local
			yyval82: TUPLE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := ast_factory.new_tuple_as (ast_factory.new_eiffel_list_expr_as (0), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp82 := yyvsp82 + 1
	yyvsp4 := yyvsp4 -2
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

	yy_do_action_615
			--|#line <not available> "eiffel.y"
		local
			yyval82: TUPLE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := ast_factory.new_tuple_as (yyvs97.item (yyvsp97), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp82 := yyvsp82 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp97 := yyvsp97 -1
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

	yy_do_action_616
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_617
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_618
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter2 
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

	yy_do_action_619
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
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

	yy_do_action_620
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter2 
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

	yy_do_action_621
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

remove_counter 
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
			when 1096 then
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
			    0,  343,  343,  343,  343,  343,  343,  343,  343,  344,
			  348,  349,  350,  351,  352,  312,  312,  312,  312,  312,
			  315,  315,  315,  313,  313,  314,  314,  207,  209,  208,
			  208,  210,  280,  280,  280,  281,  281,  161,  161,  161,
			  161,  357,  358,  355,  356,  347,  347,  347,  359,  359,
			  360,  360,  174,  174,  148,  148,  296,  296,  297,  297,
			  195,  195,  176,  361,  175,  175,  310,  310,  311,  311,
			  295,  295,  140,  140,  194,  300,  300,  279,  279,  278,
			  278,  277,  277,  277,  275,  276,  143,  251,  251,  251,
			  141,  141,  142,  142,  166,  166,  166,  166,  166,  166,

			  166,  166,  146,  146,  177,  177,  322,  322,  322,  322,
			  363,  323,  323,  227,  271,  228,  228,  228,  228,  228,
			  228,  325,  325,  324,  324,  239,  292,  292,  291,  291,
			  290,  290,  185,  196,  196,  196,  285,  285,  284,  284,
			  178,  178,  298,  299,  299,  303,  303,  302,  302,  305,
			  305,  304,  304,  307,  307,  306,  306,  338,  338,  335,
			  335,  272,  149,  149,  150,  150,  243,  364,  242,  242,
			  242,  192,  193,  147,  147,  220,  220,  220,  337,  337,
			  337,  317,  317,  318,  318,  212,  362,  362,  213,  213,
			  213,  213,  213,  213,  213,  213,  213,  213,  213,  213,

			  240,  240,  365,  240,  366,  184,  184,  367,  184,  368,
			  328,  328,  329,  329,  369,  252,  252,  252,  254,  254,
			  256,  256,  256,  264,  264,  264,  264,  257,  257,  257,
			  257,  257,  257,  257,  257,  259,  259,  262,  262,  262,
			  262,  260,  266,  266,  261,  261,  331,  331,  330,  330,
			  265,  265,  255,  255,  267,  267,  269,  269,  269,  332,
			  333,  333,  263,  263,  263,  263,  334,  334,  334,  336,
			  336,  336,  308,  308,  308,  309,  309,  197,  197,  197,
			  198,  372,  340,  340,  340,  342,  373,  374,  342,  268,
			  268,  341,  341,  375,  301,  301,  206,  206,  206,  206,

			  288,  289,  289,  183,  144,  211,  211,  282,  282,  283,
			  283,  171,  319,  319,  221,  221,  221,  221,  221,  221,
			  221,  221,  221,  221,  221,  221,  221,  221,  221,  221,
			  221,  221,  224,  224,  224,  224,  223,  223,  316,  151,
			  151,  222,  222,  376,  152,  152,  274,  274,  273,  273,
			  182,  327,  327,  327,  326,  326,  145,  145,  189,  189,
			  189,  189,  160,  159,  159,  241,  241,  286,  286,  287,
			  287,  179,  179,  179,  179,  179,  179,  244,  377,  378,
			  244,  244,  339,  339,  270,  270,  153,  153,  153,  153,
			  153,  153,  321,  321,  321,  320,  320,  226,  226,  226,

			  180,  180,  180,  180,  181,  181,  155,  155,  157,  157,
			  168,  168,  168,  168,  173,  199,  258,  187,  187,  187,
			  187,  187,  187,  187,  187,  187,  187,  187,  187,  187,
			  164,  164,  164,  164,  164,  164,  164,  164,  164,  164,
			  164,  164,  164,  164,  164,  164,  164,  164,  188,  188,
			  188,  188,  188,  188,  188,  188,  188,  188,  188,  190,
			  190,  190,  190,  190,  191,  191,  191,  204,  170,  170,
			  170,  170,  170,  170,  170,  229,  229,  230,  230,  232,
			  231,  169,  169,  225,  225,  205,  205,  205,  154,  156,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  294,

			  294,  294,  293,  293,  200,  200,  201,  201,  201,  201,
			  201,  201,  201,  202,  203,  203,  203,  203,  203,  203,
			  162,  162,  162,  162,  162,  162,  163,  163,  163,  163,
			  163,  163,  163,  163,  163,  167,  167,  172,  172,  214,
			  214,  214,  215,  215,  216,  217,  217,  218,  219,  219,
			  233,  233,  233,  235,  234,  234,  236,  236,  237,  238,
			  238,  165,  245,  245,  247,  247,  247,  248,  246,  246,
			  246,  246,  246,  246,  246,  246,  246,  246,  246,  246,
			  246,  246,  246,  246,  246,  246,  246,  246,  246,  246,
			  250,  250,  250,  250,  249,  249,  249,  249,  249,  249,

			  249,  249,  249,  249,  249,  249,  249,  249,  249,  249,
			  249,  249,  158,  158,  253,  253,  353,  345,  370,  354,
			  371,  346, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER]
			-- Template for `yytypes1'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1098)
			yytypes1_template_1 (an_array)
			yytypes1_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytypes1_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    1,   15,   15,   15,   15,   15,   15,   12,   12,   12,
			   12,    2,    2,    2,  109,    1,    1,    1,    1,   12,
			   67,   55,    1,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   15,   15,   12,
			   12,   12,   12,   12,   12,   12,   11,    9,    6,    5,
			    5,    4,    4,    4,    4,    4,    3,    1,    1,    2,
			    4,   12,   12,   12,    2,    4,    4,   30,   33,   36,
			   37,   38,    5,   40,   40,    3,   48,   27,   27,   27,
			   27,   27,    2,    2,    2,   64,   64,   64,   64,   68,

			   73,   74,   74,   74,   75,   75,   75,   75,   81,   16,
			   16,   16,   16,   82,   83,   89,   89,  110,   15,   15,
			   15,   15,   15,   15,   12,   12,   12,   12,    4,    4,
			    2,    2,    2,    2,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   84,   12,   10,    1,    1,
			   62,  109,    1,   62,  109,    1,   87,  120,    1,   67,
			   12,    2,   89,   89,   89,   89,   89,  101,    4,   27,
			   27,    4,   16,   83,   83,   83,    9,    6,    4,    4,
			   29,    2,    2,   83,  122,  122,   16,   16,   16,   16,
			   16,    4,    4,   98,   16,   16,   16,   16,   16,   16,

			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,    4,    4,   15,   15,   12,    4,    4,
			   83,   83,   83,   83,   15,   15,   15,   15,    2,    2,
			    2,   83,    4,    1,    9,    6,    4,    2,   89,    4,
			    1,   27,   27,    4,   27,    1,    1,   27,    1,    1,
			   27,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,   12,   12,
			   12,   12,    2,   27,   98,    4,    4,    3,    1,    1,
			    4,    4,    4,   16,   12,   26,   15,   15,   83,   83,
			   83,   83,   83,   83,    9,    2,   83,   83,    4,    4,

			    2,   64,   64,   64,   64,   64,   64,   83,   12,   12,
			   83,   83,   83,   83,    4,  119,  119,    1,    4,    4,
			   12,    1,   12,   12,   12,   12,    1,    4,    4,    1,
			    2,   62,    1,    1,    4,    4,    4,   36,   36,   38,
			    5,    3,    2,   62,   64,   75,   75,   75,   75,   75,
			   75,   16,   83,   90,    1,    1,    1,   23,    2,   25,
			    1,   89,   12,   17,    4,    1,   83,   12,   12,    4,
			    4,   32,    4,    1,    4,    4,  113,    4,   85,    2,
			    4,    1,   31,   40,    2,   70,   40,    4,    4,    4,
			   27,   97,   27,   97,    4,   23,    1,   40,    1,   27,

			   27,   27,   27,   27,   27,   27,   27,   27,   27,   27,
			   27,   27,   27,   27,   12,   27,   27,   12,   27,   27,
			   27,   40,   40,    2,    1,    1,    1,    1,   25,   12,
			   28,    4,    4,    4,    4,  119,    1,    1,    2,    2,
			    2,    2,    2,    1,    1,    4,    1,  109,    4,    4,
			    1,    4,   48,  120,    1,    4,   27,    2,   24,   25,
			   16,   16,   16,   16,    1,   15,    4,    4,   12,   39,
			  122,    4,    2,    2,    2,    2,  120,    1,    2,    4,
			    1,   83,   81,    4,   97,    4,   98,   32,   83,    4,
			    1,    4,    1,    4,    4,   23,   97,   27,   27,   98,

			   27,   15,   12,    2,    4,   83,  119,    4,    4,  107,
			  109,   36,    2,   90,    1,   90,   12,   82,    4,    1,
			    4,    4,   25,    1,   12,   12,  101,   83,    1,  109,
			    1,    4,   12,   27,   98,   98,    1,   27,    2,  113,
			    4,   27,   71,   83,  112,   12,   22,   80,   98,    1,
			   31,   70,    4,    1,    4,    4,   40,    1,    1,   27,
			   27,    4,    1,    4,    2,    2,   83,   83,   83,   83,
			   83,  119,  120,    4,    1,   12,   22,    4,   90,    4,
			    1,   12,   83,   23,    4,   27,   25,   15,   21,   80,
			    4,   83,  109,   12,    4,    1,    4,    4,    1,   16,

			   80,   81,    4,   27,   97,    4,   12,   88,   88,   88,
			    1,    4,    4,  119,    4,    4,    1,   16,   22,    1,
			    1,    4,    4,    2,   15,   15,    4,  109,  109,   21,
			   80,    2,    1,    1,    4,   12,   77,  113,    4,   27,
			    2,   12,   12,  119,    1,   83,    1,   12,   12,   58,
			   59,    2,  107,    1,   90,    8,   36,   44,  109,   12,
			    1,   44,   80,   12,    4,  112,   12,   77,   12,  121,
			   40,    4,  119,  120,    4,    4,    2,  119,    2,    2,
			   59,    4,    1,   12,  114,   15,  109,   80,  109,  109,
			  109,   77,   25,    1,   15,   12,   12,   12,   10,   53,

			   65,   79,   27,    1,    4,    4,  123,    1,    1,    4,
			    4,    1,    1,    1,    1,   80,   25,  120,   19,    1,
			    4,  118,   54,   16,   19,   12,   51,    1,    1,   15,
			   15,    4,    4,    4,   83,   83,   83,  125,  107,    4,
			    2,    2,   72,   72,   86,  114,  114,  109,   12,    1,
			    1,    4,    1,   19,   22,   12,   51,   12,   20,    2,
			  120,    1,  125,   12,  102,    4,  119,    1,    4,   12,
			   12,   12,   12,   12,   96,  103,  104,  106,  116,    1,
			    1,    1,   12,   12,   12,   12,   12,   12,    7,    6,
			    4,   34,   35,   37,   40,   42,   47,   49,   27,   27,

			   27,   60,    2,   61,   63,   18,   18,   69,   74,   78,
			  110,   19,   16,  117,   51,   25,   19,   12,    4,  124,
			  125,  116,  101,    1,  114,  114,  101,  101,    1,  101,
			    4,    1,  103,  103,  104,  104,  106,  106,   12,   96,
			   96,   93,    1,   27,   27,   19,  118,    6,   30,    2,
			   83,   25,    4,    4,    4,   83,    4,    4,    4,    1,
			    1,   12,   26,    1,    4,    1,   25,    1,    1,    4,
			  125,   12,   89,  101,    1,   76,   89,  115,    4,   52,
			   95,  108,  104,  106,   12,  103,   12,   92,   12,   12,
			   46,   93,   91,    1,   12,   26,   19,   32,   30,   12,

			   12,   27,   27,   30,    4,   27,   27,   27,   19,   19,
			   28,    1,    4,    4,  124,   12,    4,    1,  114,    4,
			   12,    1,    4,    1,    1,    1,   12,   57,  101,  106,
			   12,  104,    1,  100,    1,   43,  108,   43,  108,    1,
			    1,   12,   12,   12,   41,   91,   19,   12,   88,   12,
			   32,   19,   32,   30,   26,   12,  117,  102,  124,    1,
			    1,    1,   89,    2,  108,   95,    4,   12,  106,   45,
			   89,   92,    1,   12,   43,   56,  100,  101,  101,   93,
			   19,    1,    1,    1,   12,   12,   20,   94,    1,   27,
			   12,   12,   32,   28,   19,  101,  115,    4,    1,   12, yyDummy>>,
			1, 1000, 0)
		end

	yytypes1_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    4,    4,    4,    1,   67,   43,    1,    1,    1,    1,
			   12,    3,    2,   64,   66,   74,   83,  111,   91,   19,
			   12,   12,   20,   12,   50,   94,   12,   27,   12,   88,
			    1,    4,    1,    4,    4,  109,   43,  108,   55,   99,
			  100,    4,    4,    4,    4,    4,    1,   12,   27,    1,
			    1,   19,   12,   19,   12,  108,   92,  119,  119,   12,
			    1,    1,    3,    2,   74,   83,    3,    2,   64,   74,
			    2,   64,   74,   83,    1,    3,    2,   64,   74,   12,
			   12,   94,   88,   19,   88,    4,    4,   99,    1,  111,
			   19,   19,   12,   12,   12,    4,    1,    1,    1, yyDummy>>,
			1, 99, 1000)
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
			create an_array.make (0, 1098)
			yydefact_template_1 (an_array)
			yydefact_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yydefact_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			   15,  616,  616,  519,  518,  517,  516,  617,  341,  617,
			    0,  515,  514,    0,   48,    1,  617,  617,  617,  343,
			    6,    3,    0,  581,  589,  588,  587,  586,  585,  584,
			  583,  582,  580,  579,  578,  577,  576,  575,  574,  573,
			  572,  571,  570,  566,  569,  565,  568,  518,  516,    0,
			    0,    0,  382,    0,  499,    0,  448,  493,  494,  536,
			  535,    0,    0,  617,    0,  617,  537,  553,  544,  561,
			    0,    0,    0,    0,  467,    0,    0,  410,  449,  490,
			  424,  532,  526,  495,  413,  531,  496,  457,    4,  419,
			  458,  491,  485,    0,  499,  527,  417,  465,  528,  497,

			  411,  412,  478,  477,  529,  418,  466,  530,  450,  533,
			  564,  562,  563,  492,  464,  486,  487,  339,  512,  511,
			  510,  509,  508,  507,    0,    0,    0,    0,    0,    0,
			  513,  506,  246,  617,    2,  230,  219,  218,  242,  235,
			  236,  243,  252,  244,  250,  251,   49,   50,    0,   50,
			   72,  621,    0,  619,  621,   43,  619,  621,    0,  617,
			    0,   81,   82,   83,   79,   77,   75,  621,    0,  425,
			    0,    0,  534,    0,    0,  408,  389,  388,  391,  617,
			    0,  485,  392,  390,  383,  384,  593,  592,  591,  590,
			   85,    0,  617,  475,  611,  610,  609,  608,  607,  606,

			  605,  604,  603,  602,  601,  600,  599,  598,  597,  596,
			  595,  594,   84,    0,    0,  511,  510,    0,    0,    0,
			    0,  222,  220,  221,  519,  518,  517,  516,  515,  514,
			    0,    0,  612,    0,  455,  456,    0,   81,  453,  614,
			    0,    0,  451,  617,  462,  555,  543,  460,  554,  542,
			  461,    0,  617,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  463,  488,    0,    0,  538,  558,  547,
			    0,    0,    0,  567,  617,  344,  511,  510,  233,  237,
			  231,  238,  253,  245,  255,  254,    0,  227,    0,    0,

			  229,  228,  539,  540,  541,  545,  546,    0,    0,    0,
			  240,  234,  239,  232,  617,  247,  241,  618,    0,    0,
			   51,   46,   52,   53,    0,   50,   45,   73,  619,   18,
			    0,  621,  617,   16,   34,    0,    0,   32,   38,  524,
			  520,  521,   37,  621,  522,  523,  550,  551,  552,  556,
			  557,  525,    0,   72,    0,  617,    8,  621,  162,  342,
			    0,   78,    0,   80,  619,   92,    0,    0,    0,    0,
			    0,  404,  157,  617,    0,  617,  380,    0,  378,    0,
			  500,    0,  482,  468,  499,  481,  469,  408,    0,  416,
			  502,  621,    0,  621,  498,    0,    0,  470,    0,  436,

			  435,  434,  433,  432,  431,  430,  443,  445,  444,  446,
			  422,  423,  421,  420,    0,  437,  442,    0,  439,  441,
			  447,  473,  474,  499,  560,  549,  559,  548,  340,    0,
			    0,    0,    0,    0,  249,    0,    0,    0,  256,  258,
			  272,  505,  504,   47,  617,   43,   28,   24,  619,   43,
			   27,   30,    0,  160,    0,  619,   72,  485,  214,  621,
			   89,   88,   87,   90,    0,   93,    0,  617,   15,  186,
			   92,  416,  426,  338,  499,  499,  621,    0,  392,  393,
			    0,  385,   54,  499,  621,    0,  489,  405,    0,  619,
			    0,  454,    0,    0,  452,  621,  621,  438,  440,  479,

			  345,    0,    0,  257,  248,  260,  621,    0,  617,  173,
			   26,   35,   37,   31,   43,   72,   44,    0,    0,    0,
			  215,   72,    0,  211,   91,   86,   76,  102,  617,   54,
			   74,    0,   15,  427,  480,  409,    0,  621,  485,  381,
			  397,  399,  395,  464,  621,    0,  167,  379,  476,    0,
			  483,  484,    0,    0,  613,  615,  471,  165,    0,  346,
			  346,  619,  259,  263,  506,  246,    0,  225,  236,  243,
			    0,  264,  265,  273,   41,    0,   54,  619,   33,   29,
			   39,   44,   72,  163,  217,   72,  213,    0,   20,   97,
			  187,  102,   54,    0,  158,  621,  619,  398,    0,   55,

			  200,  392,  501,  429,  503,  459,    0,  347,    0,    0,
			    0,  619,    0,  247,  266,  619,    0,  174,   10,   43,
			   40,  161,  216,  103,   15,  616,    0,   54,   94,   92,
			  100,  428,    0,    0,  394,  202,  178,  377,    0,  349,
			  485,  337,  336,  261,    0,   72,    0,    0,    0,  281,
			  275,  279,   42,  106,   36,  105,  104,   20,   54,   21,
			  617,   20,   99,   15,  387,  396,  204,  617,  617,    0,
			  472,    0,  267,  270,  269,  620,  506,  268,  277,  278,
			  282,  619,  621,  617,   11,  616,   96,   98,  621,   95,
			   54,  617,  201,  617,  186,  351,    0,  186,  170,  169,

			  168,  205,  348,  617,  619,    0,  280,    0,    0,    0,
			  107,    0,  106,  617,   16,  101,  203,  621,  177,  617,
			  617,  186,  173,  172,  175,  207,  356,    0,    0,  511,
			  510,    0,    0,  617,  290,  289,  288,  294,  276,  274,
			    0,  246,  619,   72,  115,  621,   12,  621,   22,  180,
			    0,  352,    0,  176,  171,  209,  617,  186,    0,    0,
			  271,    0,    0,  617,  283,  110,  114,    0,  113,  617,
			  617,  617,  617,  617,  145,  149,  153,    0,  126,  108,
			  617,    0,    0,    0,  186,  351,    0,  617,  199,  494,
			    0,  191,  190,  424,  413,  197,  188,  196,  189,    0,

			  458,  198,  485,  193,  195,  619,  186,  194,  412,  192,
			  339,  621,  354,  621,  617,  206,  357,  166,  619,  621,
			  291,  287,    0,    0,  617,  112,  148,  156,    0,  152,
			  129,    0,  146,  149,  150,  153,  154,    0,  116,  127,
			  145,  136,    0,  617,    0,  339,  186,  407,  408,  406,
			  408,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  185,  186,  344,  182,  619,    0,  208,    0,    0,  293,
			    0,  295,  143,  621,    0,  123,    0,  621,  617,  619,
			  621,  617,  153,    0,  117,  149,  617,  617,  371,  374,
			  619,  621,    0,    0,  186,    0,    0,  402,  408,  186,

			  414,  366,  364,  408,  408,  362,  365,  363,  184,  339,
			    0,    0,  353,  294,    0,  285,  619,  142,  621,  619,
			    0,  122,   66,    0,    0,  128,  134,   72,  135,    0,
			  118,  153,    0,   13,    0,  617,  373,  617,  376,    0,
			  368,  186,  305,  617,  619,  621,  617,    0,    0,  350,
			  403,    0,  400,  408,  344,  186,  355,  284,  292,    0,
			  109,    0,  125,   68,  621,  131,  132,  119,    0,  138,
			    0,  621,  341,   63,  617,  619,  621,  372,  375,  370,
			    0,    0,    0,  308,  186,  296,    0,    0,    0,    0,
			    0,  415,  401,    0,  346,  144,  124,  619,    0,  120, yyDummy>>,
			1, 1000, 0)
		end

	yydefact_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			  619,    0,    0,  137,   15,   64,  617,   60,    0,   57,
			  306,  316,  318,  314,  312,  324,    0,  621,  310,  304,
			  297,  298,    0,    0,  619,  621,  186,    0,  186,    0,
			    0,   67,    0,  617,  617,    0,   62,   65,  619,  621,
			   59,    0,    0,    0,  619,    0,    0,  299,    0,    0,
			  300,  346,  186,  346,  335,   69,  139,    0,    0,    9,
			  617,   14,  317,  323,  331,    0,  322,  319,  320,  326,
			  321,  315,  329,    0,    0,  330,  325,  328,  327,  186,
			  186,  302,    0,    0,    0,  141,    0,   71,   61,  313,
			  311,  303,  333,  332,  334,  140,    0,    0,    0, yyDummy>>,
			1, 99, 1000)
		end

	yydefgoto_template: SPECIAL [INTEGER]
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			  328,  525,  468,  363,  986,  758,  588,  576,  546,  357,
			  395,  285,  430,  180,   77,  848,  382,  371,   78,  791,
			  792,  337,  338,   79,   80,   81,  469,   82,   83,  383,
			   84,  944,   85,  795,  324,  935,  974,  657,  969,  890,
			  796,   86,  797, 1024,  726,  879,   87,  390,   89,  799,
			   90,   91,  699,  722, 1038,  975,  927,  649,  650,  801,
			  963,  132,  133,   92,   93,   94,  803,  153,  343,  150,
			  331,  804,  805,  806,  344,   95,   96,  304,   97,   98,
			  700, 1014,   20,   99,  807,  385,  542,  742,  743,  100,
			  101,  102,  103,  345,  104,  105,  348,  106,  107,  875,

			  636,  809,  701,  547,  108,  109,  110,  111,  112,  212,
			  190,  463,  458,  113,  566,  135,  220,  136,  114,  137,
			  138,  139,  140,  141,  570,  142,  143,  144,  736,  145,
			  378,  744,  156,  607,  608,  115,  116,  164,  165,  166,
			  353,  513,  892,  945,  971,  887,  841,  891,  987, 1025,
			  880,  774,  840,  391,  193, 1039,  933,  976,  822,  873,
			  167,  764,  832,  833,  834,  835,  836,  837,  509,  652,
			  881,  964,   14,  154,  151,  628,  117,  718,  811, 1017,
			  544,  376,  684,  745,  877,  778,  813,  721,  359,  459,
			  315,  316,  435,  506,  672,  476,  673,  669,  184,  185,

			  706,  819,  820, 1096,   15,  360,  329,  148,  653,  712,
			  780,  972, 1007,   16,  332,  354,  580,  616,  682,  149,
			  321, 1005,  719,  824,  600,  667,  691,  756,  814,  522,
			  437,  703,  680,  762,  870,  914,  159,  482,  601, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER]
			-- Template for `yypact'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1098)
			yypact_template_1 (an_array)
			yypact_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yypact_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			 1224, 1448, 1370, -32768, -32768, -32768, -32768,  977,  430, -32768,
			 2416, -32768, -32768, 3818,   89, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 3661, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2785, 2416, 3657,
			  936,  936, 3928,  160,  336, 4277, -32768,  947,  946, -32768,
			 -32768, 3854, 3831,  928, 1133,  935, -32768, -32768, -32768, -32768,
			 2416, 2416,  942, 2416, -32768, 2662, 2539,  940, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  927, 4333, -32768,
			 -32768, -32768, -32768, 2416,  823, -32768, -32768, -32768, -32768, -32768,

			  934,  932, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, 3141, -32768, -32768,  559, -32768,  601,
			  601, -32768, -32768, -32768, 1295,  284,  222, 1175,  235,  235,
			 -32768, -32768,  706, 3653, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  930,  929, -32768,  825,  368,  370,
			 1170, -32768,  550, 1300, -32768, 2839,   61, -32768,  550,   86,
			 1456,  888, -32768, -32768, -32768, -32768,  896, -32768, 3831,  878,
			 4127, 3818, -32768, 4174,  915,  573, -32768, -32768, -32768,  814,
			  914,  912,  770, -32768, -32768,  891, -32768, -32768, -32768, -32768,
			 -32768,  222,  894, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, 1456, 1456,  317,  317,  846,  832,  832,
			  873, -32768, -32768, -32768, 3305, 1640, 3566, 3479,  192, 3392,
			  877,  875, -32768, 2416, -32768, -32768, 2416, -32768, -32768, -32768,
			 2416, 4247, -32768,  874, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, 1456, -32768, 2416, 2416, 2416, 2416, 2416, 2416, 2416,
			 2416, 2416, 2416, 2416, 2416, 2416, 2416, 2416, 2293, 2416,
			 2170, 2416, 2416, -32768, -32768, 1456, 1456, -32768, -32768, -32768,
			  550,  580,  564, -32768,  628,  487, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  884, -32768,  876,  863,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  409,  638,  451,
			 -32768, -32768, -32768, -32768,  871, -32768, -32768, -32768,  550,  550,
			 -32768, -32768, -32768, -32768,  638,  825, -32768, -32768, -32768, -32768,
			  859, -32768, -32768, -32768, -32768,  562,  549,  853, -32768, -32768,
			 -32768, -32768,  858, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 3165,  596,   57, -32768, -32768, -32768,  851, -32768,
			 2416, -32768, 4238, -32768, -32768,   95,  850,  550,  550,  550,
			  550, -32768, -32768, -32768, 1456,  856, -32768, 3818, -32768,  847,
			 -32768, 2416,  794, -32768,  823, -32768, -32768,  573, 3818, -32768,
			 4147, -32768, 4209, -32768,  862,  855,  550, -32768, 2416,  526,

			  526,  526,  526,  526,  907,  907, 1454, 1454, 1454, 1454,
			 1454, 1454, 1454, 1454, 2416, 4104, 3310, 2416, 4409, 4372,
			 -32768, -32768, -32768,  823, -32768, -32768, -32768, -32768, -32768, 2416,
			   15,  550,  854,  852, -32768,  849, 3818,  848, -32768, -32768,
			  843, -32768, -32768, -32768, -32768, 2962, -32768, -32768, -32768, 2839,
			 -32768, -32768,  204, -32768,  829, -32768, 4167,  824,  734, -32768,
			 -32768, -32768, -32768,  788, 3661, -32768, 3818,  814,  121, -32768,
			   25, 2416, -32768, -32768,  823,  823, -32768, 2416,  770, -32768,
			 1924, -32768,  675,  823, -32768, 1456, -32768, -32768,  807, -32768,
			  806, -32768,  805, 1456, -32768, -32768, -32768, 4104, 4409, -32768,

			 4333, 2416, 2416, -32768, -32768,  796, -32768, 1469,  800,  689,
			 -32768,  792, -32768, -32768, 2839,  596, -32768,  776, 3818,  550,
			 -32768, 2047, 2416, -32768, -32768, -32768, -32768,  697, -32768,  675,
			  632, 3818,  121,  765, -32768, -32768,  789, 4333,  497, -32768,
			 -32768, 4333,  782, 1022, -32768, 3657, -32768, -32768, -32768,  787,
			  794, -32768, 2416, 2416, -32768, -32768, -32768, -32768,  778, 2921,
			 2921, -32768, -32768, -32768,  468,  706,  775,  771,  773,  769,
			  763, -32768, -32768, -32768, -32768, 4174,  675, -32768, -32768, -32768,
			 -32768, -32768,  596, -32768, -32768, 4167, -32768,  550,  177, -32768,
			 -32768,  697,  675,  550, -32768, -32768, -32768, -32768,  759, -32768,

			  698,  770, -32768, -32768, -32768,  764, 2416, -32768,  735,  731,
			 3818, -32768, 3818,  737, -32768, -32768, 1181, -32768, -32768, 2962,
			 -32768, -32768, -32768, -32768, 2990, 1700, 3113,  675, -32768,  676,
			 -32768, -32768,  741, 1924, -32768,  707,  691, -32768, 1456, 4333,
			  733, -32768, -32768, -32768, 3807,  398, 1695,  222,  222, -32768,
			  730, -32768, -32768,  674, -32768, -32768, -32768,  665,  675, -32768,
			 -32768,  665, -32768,  121, -32768, -32768, -32768,  512,  572,  217,
			 -32768, 2416, -32768, -32768, -32768, -32768,  728, -32768, -32768, -32768,
			  721, -32768, -32768, 4017, -32768,  709, -32768, -32768, -32768, -32768,
			  675,  512, -32768, -32768, -32768,  695, 4198, -32768, -32768, -32768,

			 -32768,  684, 4333, -32768, -32768, 3906, -32768, 1181,  724,  222,
			 -32768,  222,  674, -32768,  666, -32768, -32768, -32768, -32768, 1906,
			  716, -32768,  689, -32768, -32768,  657,  653,  645, 1695,  757,
			  757,  757,  757, -32768, -32768, -32768,  654,  569, -32768, -32768,
			  700,  706, 1512,  596,  760, -32768, -32768, -32768, -32768, -32768,
			 1801, -32768, 4198, -32768, -32768, -32768,  105, -32768,  681,  456,
			 -32768, 3922,  644, -32768, -32768, -32768, -32768,  222, -32768,  188,
			  672,  392,   73,  173,  594,  555,  515,  671,  647, -32768,
			  325,  666, 2416, 2416, -32768,  695, 1311,   42, -32768,  274,
			 1557, -32768, -32768,  717,  715, -32768, -32768, -32768, 4333,  714,

			  704, -32768,  125, -32768, -32768, 2029, -32768, -32768,  292, -32768,
			  288, -32768,  656, -32768,  105, -32768, -32768, -32768, -32768, -32768,
			  655, -32768,  641, 1456, -32768, -32768, -32768, -32768, 1456, -32768,
			 -32768,  443, -32768,  555, -32768,  515, -32768,  639, -32768, -32768,
			  594,  610,  275, 4035, 3204,  559, -32768, -32768,  573, -32768,
			  767,   21, 2416, 2416,  960,  643, 2416, 2416, 2416, 1801,
			  632, -32768,  487, -32768, -32768,  634, -32768,  645,  629, -32768,
			  612, -32768,  615, -32768,  222,  607,  584, -32768,  608,  205,
			 -32768,  577,  515,  592, -32768,  555, -32768,  276, 1486, 1486,
			  199, -32768,  323,  423, -32768,  397,  590, -32768,  573, -32768,

			 -32768, 4333, 4333,  573,  767, 4333, 4333, 4333, -32768,  559,
			   68, 4198, -32768,  569, 3922, -32768, -32768, -32768, -32768, -32768,
			 1456, -32768, -32768,  638,  443, -32768, -32768,  596, -32768,  575,
			 -32768,  515, 1456, -32768,  389, -32768, 1786, -32768, 1786,  275,
			 -32768, -32768, -32768, -32768,  322, -32768,  303, 2416,  503, -32768,
			 -32768,  544, -32768,  573,  487, -32768, -32768, -32768, -32768, 1456,
			 -32768, 1456, -32768,  527, -32768, -32768, -32768, -32768,  488,  494,
			  249, -32768,  430, -32768,  324,   98, -32768, -32768, -32768, -32768,
			  472,  196,  423, -32768, -32768, -32768,  464,  164,  332, 3812,
			 2416, -32768, -32768,  420,  236, -32768, -32768, -32768,  449, -32768, yyDummy>>,
			1, 1000, 0)
		end

	yypact_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			 -32768,  447,  445, -32768,  121,  443, -32768, -32768,  389, -32768,
			 -32768,  480,  461,  459,  399,  429,  386, -32768, -32768, -32768,
			 -32768, -32768,  366, 2416,   49, -32768, -32768, 3792, -32768,  361,
			  638, -32768, 1456, -32768, -32768,  356, -32768, -32768,  134, -32768,
			 -32768,  990,  196,  696, -32768,  196,  300, -32768, 3041,  332,
			 -32768,  236, -32768,  236, -32768, -32768, -32768,  237,  132, -32768,
			 -32768, -32768, -32768, -32768, -32768,  338, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,  518,  196, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  269,  242,  184, -32768,  159, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  147,  117, -32768, yyDummy>>,
			1, 99, 1000)
		end

	yypgoto_template: SPECIAL [INTEGER]
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			 -260, -32768, -422, -32768,  186, -32768,  581,  444,  560, -337,
			 -32768, -706, -792, -32768, -32768, -612,  680, -331, -32768, -32768,
			 -32768, -399, -510, -32768, -650,   75, -32768,   60, -32768, -170,
			 -660, -32768, -128, -32768, -32768, -821, -32768,  509, -32768, -32768,
			 -32768,  780, -32768, -32768, -32768, -32768, -32768,  822,  552, -32768,
			 -674, -32768, -32768, -32768, 1120, -32768, -32768, -32768, -32768, -32768,
			  802, -168, -307,    0,  712,  -26, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  -78,   63,  -15, -32768,  -40,  -56,
			 -32768, -32768,  138, -32768, -32768,  614, -32768, -32768, -32768, -32768,
			 -687, -32768, -32768, -32768,   40,  -71, -32768,  -86,  -98, -32768,

			 -32768, -32768, -32768, -479, -32768,   11, -654,  -81, -32768,  745,
			 -32768, -32768, -32768,  651,   34, -105,  306,  -36,  -48, -670,
			  -53,  -91, -477,  -54, -32768,  -46,  -84,  -97, -32768, -32768,
			 -32768, -32768, -32768,  171, -519,   -9,  -10,  -59, -154, -32768,
			 -361,  450, -32768,   83,   32, -32768, -32768,  124, -32768,    4,
			  128,  282, -32768, -201,  143,  -12, -32768,   43, -675,   88,
			  574,  133,  293,  179,  287, -724,  280, -753, -32768,  310,
			 -814,  -14, -447, -289,  585, -200, -684,  412,  156,  -60,
			  379, -427,  298, -709,   48,  244,   96,  219, -250,  478,
			  434,  251, -409,  378, -454,   -2, -471, -32768,  619, -32768,

			 -32768,   66,  278, -32768, -32768,    2,  844, -32768, -32768, -32768,
			 -32768, -32768,  -83,    8,  606, -32768,  401, -32768, -32768, -32768,
			 -104, -32768, -445, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER]
			-- Template for `yytable'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 4433)
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
			   13,  173,  174,  175,  183,  238,  361,  223,  222,   18,
			   17,   22,  163,  162,  288,  290,  157,  442,  152,  155,
			  158,  529,  161,  379,  530,  221,  182,  341,  289,  291,
			  568,  311,  313,  283,  428,  735,  572,  310,  312,  393,
			  293,  609,  723,  447,  386,  326,  511,  134,  532,  301,
			  589,  539,  181,  571,  163,  162,  487,  350,  825,  495,
			  172, -159,  230,  808,  237,  233,  810,  240,  937,  349,
			  910,  306,  531,  297,  936,  938,  800,  296,  292,  307,
			  900,  397,  883,  502,  347,  592, -210,  305,  515,   -5,
			  794,  735,  283,  451,  826,  827,  231,  829,  812,  306,

			  793, -210,   61, -159,  862,  421,  422,  352, -301,  882,
			  288,  290,  303,  630,  656,  305,  656, 1098, -159,  288,
			  290,  311,  313,  899,  467,  295, -301,  300,  858,  929,
			  501,   51, -151,  289,  291,  317,  502, -159,  465,  895,
			  303,  627,  466, -159, -210, -210,  147, 1097,  662,  146,
			  163,  162,  330,  578, -159,  342,  441,  -58,  358,  955,
			  161,  931,  993,  857, -210,  918,  351,  568,  230,  568,
			 -159,  292,  808, -151,  637,  810, 1086,  658,  968,  687,
			  484,  373,  583,  501, 1036,  800,  -58,  384,  384,  626,
			  302, 1037,  677,  -70,  381,  346,  520,  496, -210,  794,

			 -210, 1095,  366,  954, -210,  231,  928,  663,  465,  793,
			  -58,  715,  -58,  299,  298,  340,  690,  -70,  302,  327,
			  511,  443,  -70, 1021,  293,  384,   12,   11, -513,   68,
			  339,   66,  -72,    2,  -15,    1, -513,  274,  898,  171,
			   65,  984,  903, 1094,  735,  396,  -70, -147,  -70,  384,
			  384,  568,  131,  -15,  398,  579,  760,  812, -369,  -15,
			  977,  584,  978,  516, -130,  131,  130,  -15,  -72,  -15,
			  -15,  283, -369,  -72,  698,  -15,  -72,  853, 1002,   50,
			  423, 1085, -369, -147,  189,  188,  -15, -369, -147,  625,
			  624,    1,  953,  697, 1015, -361, 1001,  187,  186,  696,

			 -130, 1093,  214,    6,    5, -130,    4,    3, -130,  295,
			  695, -369,  852, -369,   12,   11,  436,  341,  438,  439,
			  276,  341,  621,  556,  309,  622,  694,  171, 1092,  123,
			  122,  121,  287,  286,  155,  -56,  308,  118,  889,  565,
			  294,  606,  123,  122,  121,  287,  286,  350,  478,  888,
			  118,  350,  604,  453, 1064, 1069, 1072,  158, 1078,  349,
			  457,  860,  985,  349,  -56,  192,  280,  472,  473,  474,
			  475,  688,  861,  277,  347,  477,  284,  480,  347,  191,
			  984, -309,  942,  -14, -367,  675,  341, 1015,  -56,  306,
			  -56,    6,    5,  306,    4,    3,  358,  352, -367, -309,

			  941,  352, 1079,  433,  432,  305,  125,  -14, -367,  305,
			 1023,  481,  -14, -367,  280, 1059,  350,  692,  217,  279,
			 1054,  277,  488,  710,  747, 1047,  433,  432,  349,  323,
			  303,  503,  543, 1045,  303,  674,  -14, -367,  -14, -367,
			  322,  716,  279,  347,  327,  512,  152, 1044,  651,  512,
			  325, -121,  320,  569,  163,  162,  351,  686,  306,  384,
			  351,  689,  283, 1043,  161, 1042,  352,  384,  670,  528,
			  505,  567,  973, -121,  305, 1029,  565,  538,  565,  678,
			  679,   12,   11,  768, 1041,  346,  878, -121, 1034,  346,
			 1033,  341, -121, 1031,  617, -121,  341,  173,  341,  303,

			  527,  947,  606,  612,  818,  340,  815,  294,  302,  340,
			  574, 1028,  302,  830,  512,  612,  611,  897,   19,  358,
			  339,  350,  457, 1020,  339,  351,  350,  486,  350,  943,
			  158, 1010, 1082,  349, 1084,  433,  432,  851,  349,  651,
			  349,  740, 1000,  741, -162,  455,  280,  999,  347,  253,
			   74,  279,  582,  347,  346,  347,  599, 1035,    6,    5,
			  565,    4,    3,  306,  866,  591,  499,  950,  306, -210,
			  306,  352,  952,  487,  340,  997,  352,  302,  352,  305,
			   12,   11,  249,  248,  305,  543,  305,  623, -210,  339,
			  569,  429,  569,  631, -210,  246,  245,  427,  426,  741,

			  734,  370, -210,  991,  303, -210,  640,  990,  567,  303,
			  567,  303,  384,  425,  424,  770,  442,  534,  535,  512,
			 -133, -210,  992, -133, 1057, 1058,  548,  247,  250, -179,
			  351,  131,  130,  660,  967,  351, -133,  351,  289,  291,
			  310,  312,  327,  763,  505,  926,  645,  284, -179,  949,
			  772,  930,  922,  920, -179,  919,  734,    6,    5,  346,
			    4,    3,  155,  916,  346, -179,  346,  966,  131,  130,
			  693,  915, -133,  913,  569,  759,  912, -133,  590,  340,
			 -133, -179,  302,  886,  340,  711,  340,  302,  904,  302,
			  125,  717,  567,  713,  339,  158, -210,  769,  884,  339,

			  871,  339,  124,  869,  864,  727,  741, -359,  123,  122,
			  121,  287,  286,  299,  298,  155,  118,  856, -360, -210,
			 -358,  750,  752,  442,  720,  748,   12,   11,  773,   68,
			  838, -155, -210, -210, -212,  761,  223,  222,  850,  171,
			  817,  771,  314, -210,  765,  123,  122,  121,  287,  286,
			  802, -286,  757,  118,  221,  441,  575,  313,  751,  755,
			  683,  739,  355,  725,  872,  823,  962,  545,  659,  876,
			  705,  823,  823,  828,  823,  831,  704,  685,  681,   50,
			  671,  668,  842,  664,  666, -223,  849,  131,  130,  465,
			  642, -212,  638, -212,  641,  370,  635,   12,   11,  375,

			  272,  634, -212,    6,    5,  587,    4,    3, -219,  734,
			 -212,  615,  614,  163,  162,  605, -212, -224,  163,  162,
			  847, -226,  485,  237, -212, -212,  874, -212,  237,  602,
			  596,  594,   88, -212,  593,  581, -212,  573, -212, -212,
			  577,  773,  555, -212,  561,  893, -212,  554, -212, -212,
			  849,  552,  192, 1011,  849,  772,  372,  771,  308,  802,
			  770,  524,  441,  769,  123,  122,  121,  287,  286,  169,
			  170,  521,  118,  970,    6,    5,  518,    4,    3,  508,
			  923,  272,  272,  823,  507,  427,  504,  425,  932,  934,
			  493,  483,  241,  242,  471,  244,  249,  494,  479,  455,

			  872,  448,  876, 1013,  849,  449,  445,  320,  434,  246,
			  163,  162,  431, 1062, 1066,  273, -164, 1075,  387,  389,
			  161,  309,  163,  162,  388,  306,  257,  256,  255,  254,
			  253,   74,  237, 1016,  444,  125,  380,  823,  377,  823,
			 -386,  305,  374,  369,  364,  981, 1011,  367,  988,  163,
			  162,  163,  162,  272,  272,  362,  272,  319,  318,  237,
			  276,  237,  275,  252, 1068, 1071,  303, 1077,  251,  232,
			  464,  243,  239,  970,  214,  213, 1006,   -7, 1088,  171,
			  958, 1012,  620,  737,  470,  272,  306,  306,  643,  306,
			   12,   11,  766, 1065, 1016, 1073, 1013, 1016,  333,  613, yyDummy>>,
			1, 1000, 0)
		end

	yytable_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  586,  356,  305,  305,  846,  305,  821,  956,   22,  996,
			  746,  365,  665,  847, 1089,  908, 1055,  738,  306,  885,
			   12,   11,  163,  162,  777,   66, 1016,  303,  303,  510,
			  303,  776,  237,  171,  305,  436,  436,  775,  526,  282,
			  281, 1063, 1067, 1070,  302, 1076,  957,  995, 1087,  309,
			  280, 1040,  965, 1081,  514,  279,  278,  277,  392,  303,
			  839,  519,   22,  979, 1056, 1018,  948,    6,    5,  654,
			    4,    3,  597,   50, 1012,  399,  400,  401,  402,  403,
			  404,  405,  406,  407,  408,  409,  410,  411,  412,  413,
			  415,  416,  418,  419,  420,  553,  855,    6,    5,  551,

			    4,    3,  272,  517,  272,  302,  302,  462,  302,  724,
			 1004,  272,  272,  272,  272,  272,  272,  272,  272,  272,
			  272,  272,  272,  272,  272,  272,  440,  272,  272,   21,
			  272,  272,  272,  753,  452,  661,  618,  302,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,  236,   12,   11,  550,  754,  610,  272,  816,
			  -25,    0,  629, 1022,    0,  446,    0,    0,    0,    0,
			    0,    0,  456,  619,    0,    0,  235,  450,    0,  234,
			    0,    0,  299,  298,    0,   55,  845,    0,   53,    0,

			    0,  454,  633,    0,    0,   12,   11,    0,   68,  272,
			  272,  131,  272,    0,    0,    0,  327,  644,  171,    0,
			    0,  646,    0,    0,    0,    0,    0,  -25,    0,  -25,
			  -25,  -25,    0,    0,    0,  490,  497,  492,    0,  498,
			    6,    5,  -25,    4,    3,  272,  -25,    0,    0,  272,
			  -25,  500,  -25,  272,   12,   11,    0,    0,  896,    0,
			  -25,  648,  -25,  -25,    0,    0,    0,    0,  -25,    0,
			    0,  272,  272,  909,    0,    0,    0,  647,    0,  -25,
			    0,    0,    6,    5,    0,    4,    3,  707,  123,  122,
			  121,  287,  286,  533,    0,   10,  118,  272,    0,  537,

			  -23,    0,  541,  523,    0,    0,  946,    9,    0,    0,
			  728,  951,    8,    0,    7,  272,    0,    0,    0,    0,
			  536,    0,    0,  559,  560,  131,  130,    0,  549,    0,
			    0,    6,    5,    0,    4,    3,    2,    0,    1,  557,
			  558,   12,   11,  585,  456,    0,    0,    0,  767,    0,
			  562,  272,    0,  980,  171,    0,    0,  -23,    0,  -23,
			  -23,  -23,    0,    0,  847,    0,    0,  994,    0,    0,
			  -17,    0,  -23,    0,  603,    0,  -23,    0,    0,    0,
			  -23,  595,  -23,    0,  125,    0,    0,    0,  598,    0,
			  -23,    0,  -23,  -23,    0,    0, 1019,    0,  -23,    0,

			    0,    0,  123,  122,  121,  287,  286,    0,    0,  -23,
			  118,  859,    0,    0,  272,    0,    0,    0,    6,    5,
			    0,    4,    3,    0,  867,    0,    0,  -17,  639,  -17,
			  -17,  -17,    0,    0,    0,    0,    0,    0, 1051,  632,
			 1053,    0,  -17,    0,    0,    0,  -17,    0,  -19,    0,
			  -17,    0,  -17,    0,    0,  541,    0,    0,    0,    0,
			  -17,    0,  -17,  -17, 1083,    0,    0,    0,  -17,    0,
			  911,  259,  258,  257,  256,  255,  254,  253,   74,  -17,
			    0,    0,    0,    0,    0,  924,   12,   11,    0,    0,
			    0, 1090, 1091,  702,    0,    0,  939,    0,    0,  564,

			  130,    0,    0,    0,    0,  -19,  563,  -19,  -19,  -19,
			  272,    0,    0,    0,  129,    0,  -64,  -64,   55,  128,
			  -19,   53,  959,    0,  -19,  961,  708,    0,  -19,  878,
			  -19,    0,  714,    0,    0,    0,    0,    0,  -19,  127,
			  -19,  -19,    0,    0,    0,    0,  -19,    0,  -64,  126,
			  982,  -64,    0,    0,    0,  272,  272,  -19,  125,    0,
			    0,  749,    0,    6,    5,    0,    4,    3,    0,    0,
			  124, -111,  798,    0,    0, -111,  123,  122,  121,  120,
			  119, 1008,    0,    0,  118, -111, -111,  131,  130,  779,
			    0,  781,    0,  -64,  -64, -111,  -64,  -64, -111,    0,

			 -111,    0,  854, 1030,  843,  844, 1032,  218,    0,    0,
			    0,    0,    0,  272,  272,    0,    0,  272,  272,  272,
			    0,    0,    0,    0, -111,    0, -111,  127,    0,    0,
			 1049,    0,    0,    0,    0,    0,    0,  126,    0,    0,
			 -510,    0,    0,    0, 1060,    0,  125,    0,    0,    0,
			 1074,    0, -510,    0,    0,  863,    0,  865,  217,    0,
			    0,    0,    0,  868,  123,  122,  121,  216,  215,    0,
			  131,  130,  118,    0,  901,  902, -510, -510,  905,  906,
			  907,  798, -510,    0, -510, -510, -510,    0, -510,    0,
			    0,    0,    0,    0,    0,    0,    0, -510,    0, -510,

			 -510,  272, -510,    0,    0, -510,    0,    0,    0,    0,
			    0,    0,    0,    0, -510,    0, -510,  917,    0,    0,
			    0,  921, -510, -510,  925,  676,  130,    0, -510,  125,
			 -510,    0, -510, -510,    0,  940,    0, -510, -510,  272,
			  129,  124,    0,    0,    0,  128,    0,  123,  122,  121,
			  287,  286, -510, -510, -510,  118,    0,  -17,    0,  659,
			  272,    0,  960,    0,    0,  127,    0,    0,    0,  989,
			    0,    0,    0,    0,    0,  126,  -17,    0,    0,    0,
			    0,    0,  -17,    0,  125,    0,    0,    0,    0,  983,
			  -17,    0,  -17,  -17,    0,    0,  124,    0,  -17,    0,

			    0,    0,  123,  122,  121,  120,  119,    0,  998,  -17,
			  118,    0, 1027,    0,    0, 1003,  -65,  -65,   76,   75,
			 1009,    0,    0,    0,    0,   74,   73,   72,   71,    0,
			   70,   12,   11,   69,   68,   67,   66,   65,    0,    0,
			   64,   63,    0,    0,   62, 1048,  790,    0,  -65,    0,
			    0,  -65,   60,   59,  789,  788,    0,   57,    0,   56,
			    0, 1046,    0,   55,    0,   54,   53,   52,    0, 1050,
			    0,    0,  787,    0,    0,  786,  785,    0,    0,    0,
			    0,    0,    0, 1061,   50,  784,  783,    0,  782,    0,
			    0,    0,    0,  -65,  -65,   49,  -65,  -65,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,   48,    5,
			    0,   47,    3,    0,    0,    0,    0,   46,   45,   44,
			   43,   42,   41,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   76,   75,    0,    0,    0,    0,    0,   74,   73,
			   72,   71,  590,   70,   12,   11,   69,   68,   67,   66,
			   65,    0,    0,   64,   63, -181,    0,   62,    0,   61,
			    0,    0,    0,    0,  540,   60,   59,   58,    0,    0,
			   57,    0,   56, -181, -181, -181,   55,    0,   54,   53,
			   52,    0,    0,    0, -181,    0,    0, -181,   51,    0, yyDummy>>,
			1, 1000, 1000)
		end

	yytable_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,    0,    0,    0, -181,    0,   50,    0,    0,
			 -181, -181, -181,    0,    0,    0,    0,    0,   49,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   48,    5,    0,   47,    3,    0,    0,    0,    0,
			   46,   45,   44,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   76,   75,    0,    0,    0,    0,
			    0,   74,   73,   72,   71,    0,   70,   12,   11,   69,
			   68,   67,   66,   65,    0,    0,   64,   63, -183,    0,
			   62,    0,   61,  327,    0,    0,    0,    0,   60,   59,

			   58,    0,    0,   57,    0,   56, -183, -183, -183,   55,
			    0,   54,   53,   52,    0,    0,    0, -183,    0,    0,
			 -183,   51,    0,    0,    0,    0,    0,    0, -183,    0,
			   50,    0,    0, -183, -183, -183,    0,    0,    0,    0,
			    0,   49,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   48,    5,    0,   47,    3,    0,
			    0,    0,    0,   46,   45,   44,   43,   42,   41,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   76,   75,    0,
			    0,    0,    0,    0,   74,   73,   72,   71,    0,   70,

			   12,   11,   69,   68,   67,   66,   65,    0,    0,   64,
			   63,    0,    0,   62,    0,   61,    0,    0,    0,    0,
			    0,   60,   59,   58,    0,    0,   57,    0,   56,    0,
			    0,    0,   55,    0,   54,   53,   52,    0,    0,    0,
			    0,    0,    0,    0,   51,    0,    0,  417,    0,    0,
			    0,    0,    0,   50,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   49,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   48,    5,    0,
			   47,    3,    0,    0,    0,    0,   46,   45,   44,   43,
			   42,   41,   40,   39,   38,   37,   36,   35,   34,   33,

			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   76,   75,    0,    0,    0,    0,    0,   74,   73,   72,
			   71,    0,   70,   12,   11,   69,   68,   67,   66,   65,
			    0,    0,   64,   63,    0,    0,   62,    0,   61,    0,
			    0,    0,    0,    0,   60,   59,   58,    0,    0,   57,
			    0,   56,    0,    0,    0,   55,    0,   54,   53,   52,
			    0,    0,    0,    0,    0,    0,    0,   51,    0,    0,
			    0,    0,    0,    0,    0,    0,   50,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   49,    0,    0,
			    0,    0,    0,    0,    0,  414,    0,    0,    0,    0,

			   48,    5,    0,   47,    3,    0,    0,    0,    0,   46,
			   45,   44,   43,   42,   41,   40,   39,   38,   37,   36,
			   35,   34,   33,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,   76,   75,    0,    0,    0,    0,    0,
			   74,   73,   72,   71,    0,   70,   12,   11,   69,   68,
			   67,   66,   65,    0,    0,   64,   63,    0,    0,   62,
			    0,   61,    0,    0,    0,    0,    0,   60,   59,   58,
			    0,    0,   57,    0,   56,    0,    0,    0,   55,    0,
			   54,   53,   52,    0,    0,    0,    0,    0,    0,    0,
			   51,    0,    0,    0,    0,    0,    0,    0,    0,   50,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			   49,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   48,    5,    0,   47,    3,    0,    0,
			    0,    0,   46,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,   76,   75,    0,    0,
			    0,    0,    0,   74,   73,   72,   71,    0,   70,   12,
			   11,   69,  249,  248,   66,   65,    0,    0,   64,   63,
			    0,    0,  171,    0,   61,    0,    0,    0,    0,    0,
			   60,   59,   58,    0,    0,   57,    0,   56,    0,    0,

			    0,   55,    0,   54,   53,   52,    0,    0,    0,    0,
			    0,    0,    0,   51,    0,    0,    0,    0,    0,    0,
			    0,    0,   50,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   49,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   48,    5,    0,    4,
			    3,    0,    0,    0,    0,   46,   45,   44,   43,   42,
			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   76,
			   75,    0,    0,    0,    0,    0,   74,   73,   72,   71,
			    0,   70,   12,   11,   69,  246,  245,   66,   65,    0,

			    0,   64,   63,    0,    0,  171,    0,   61,    0,    0,
			    0,    0,    0,   60,   59,   58,    0,    0,   57,    0,
			   56,    0,    0,    0,   55,    0,   54,   53,   52,    0,
			    0,    0,    0,    0,    0,    0,   51,    0,    0,    0,
			    0,    0,    0,    0,    0,   50,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   49,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   48,
			    5,    0,    4,    3,    0,    0,    0,    0,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,

			   24,   23,   76,   75,    0,    0,    0,    0,    0,   74,
			   73,   72,   71,    0,   70,   12,   11,   69,   68,   67,
			   66,   65,    0,    0,   64,   63,    0,    0,  168,    0,
			   61,    0,    0,    0,    0,    0,   60,   59,   58,    0,
			    0,   57,    0,   56,    0,    0,    0,   55,    0,   54,
			   53,   52,    0,    0,    0,    0,  336,  335,    0,   51,
			    0,    0,    0,    0,    0,    0,    0,    0,   50,   12,
			   11,   69,   68,   67,   66,    0,    0,    0,    0,   49,
			    0,    0,  171,    0,    0,  334,    0,    0,    0,    0,
			   60,   59,   48,    5,    0,   47,    3,    0,    0,    0,

			    0,   46,   45,   44,   43,   42,   41,   40,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,    0,  271,  270,  269,  268,
			  267,  266,  265,  264,  263,  262,  261,  260,  259,  258,
			  257,  256,  255,  254,  253,   74,    6,    5,    0,    4,
			    3,    0,    0,    0,    0,   46,   45,   44,   43,   42,
			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,  336,
			  335,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   12,   11,   69,   68,   67,   66,    0,    0, yyDummy>>,
			1, 1000, 2000)
		end

	yytable_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,    0,    0,    0,  171,    0,  336,  335,    0,
			    0,    0,    0,   60,   59,    0,    0,    0,    0,    0,
			    0,    0,   69,   68,   67,   66,  606,    0,    0,    0,
			    0,    0,    0,  171,    0,    0,    0,    0,    0,    0,
			    0,   60,   59,    0,    0,  655,  271,  270,  269,  268,
			  267,  266,  265,  264,  263,  262,  261,  260,  259,  258,
			  257,  256,  255,  254,  253,   74,    0,    0,    0,    6,
			    5,    0,    4,    3,    0,    0,    0,    0,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,

			   24,   23,    2,    0,    1,    0,   46,   45,   44,   43,
			   42,   41,   40,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			  336,  335,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0, 1080,    0,   69,   68,   67,   66,    0,
			    0,    0,    0,    0,    0,    0,  171,    0,  282,  281,
			    0,    0,    0,    0,   60,   59,    0,    0,  655,  280,
			    0,    0,    0,    0,  279,  278,  277,    0,    0,    0,
			    0,    0,  282,  281,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  279,  278,

			  277,    0,    0,    0,    0,    0,    0,    0,    0,  271,
			  270,  269,  268,  267,  266,  265,  264,  263,  262,  261,
			  260,  259,  258,  257,  256,  255,  254,  253,   74,   46,
			   45,   44,   43,   42,   41,   40,   39,   38,   37,   36,
			   35,   34,   33,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,    0,    0,    0,    0,   46,   45,   44,
			   43,   42,   41,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   46,   45,   44,   43,   42,   41,   40,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,

			   27,   26,   25,   24,   23, -511,  894,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0, -511,  268,  267,
			  266,  265,  264,  263,  262,  261,  260,  259,  258,  257,
			  256,  255,  254,  253,   74,  131,  130,    0,    0,    0,
			    0, -511, -511,    0,    0,    0,    0, -511,    0, -511,
			 -511, -511,    0, -511,    0,    0,    0,    0,    0,    0,
			    0,    0, -511,    0, -511, -511,    0, -511,    0,    0,
			 -511,    0,    0,    0,    0,    0,    0,    0,    0, -511,
			    0, -511,    0,    0,    0,    0,    0, -511, -511,    0,
			    0,    0, -506, -511,  125, -511,    0, -511, -511,    0,

			    0,    0, -511, -511, -506,    0,  124,    0,    0,    0,
			    0,    0,  123,  122,  121,  287,  286, -511, -511, -511,
			  118,    0, -506, -506,    0,    0,    0,    0, -506, -506,
			    0,    0,    0,    0, -506,    0, -506, -506, -506,    0,
			 -506,    0,    0,    0,    0,    0,    0,    0,    0, -506,
			    0, -506, -506,    0, -506,    0,    0, -506,    0,    0,
			    0,    0,    0,    0,    0,    0, -506,    0, -506,    0,
			    0,    0,    0,    0, -506, -506,    0,    0,    0, -507,
			 -506,    0, -506,    0, -506, -506,    0,    0,    0, -506,
			 -506, -507,    0,    0,    0,    0,    0,    0,    0, -506,

			 -506, -506, -506, -506, -506, -506, -506,    0,    0, -507,
			 -507,    0,    0,    0,    0, -507, -507,    0,    0,    0,
			    0, -507,    0, -507, -507, -507,    0, -507,    0,    0,
			    0,    0,    0,    0,    0,    0, -507,    0, -507, -507,
			    0, -507,    0,    0, -507,    0,    0,    0,    0,    0,
			    0,    0,    0, -507,    0, -507,    0,    0,    0,    0,
			    0, -507, -507,    0,    0,    0, -508, -507,    0, -507,
			    0, -507, -507,    0,    0,    0, -507, -507, -508,    0,
			    0,    0,    0,    0,    0,    0, -507, -507, -507, -507,
			 -507, -507, -507, -507,    0,    0, -508, -508,    0,    0,

			    0,    0, -508, -508,    0,    0,    0,    0, -508,    0,
			 -508, -508, -508,    0, -508,    0,    0,    0,    0,    0,
			    0,    0,    0, -508,    0, -508, -508,    0, -508,    0,
			    0, -508,    0,    0,    0,    0,    0,    0,    0,    0,
			 -508,    0, -508,    0,    0,    0,    0,    0, -508, -508,
			    0,    0,    0, -262, -508,    0, -508,    0, -508, -508,
			    0,    0,    0, -508, -508, -262,    0,    0,    0,    0,
			    0,    0,    0, -508, -508, -508, -508, -508, -508, -508,
			 -508,    0,    0, -262, -262,    0,    0,    0,    0,    0,
			 -262,   12,   11,    0,    0, -262,    0, -262, -262, -262,

			  171, -262,    0,    0,    0,    0,    0,    0,    0,    0,
			 -262,    0, -262, -262,    0, -262,    0,    0, -262,    0,
			    0,  160,    0,   55,    0,    0,   53, -262,    0, -262,
			    0,    0,    0,    0,    0, -262, -262,    0,    0,    0,
			    0, -262,    0, -262,    0, -262, -262,    0,    0,    0,
			 -262, -262,    0,    0,    0,    0,    0,    0,    0,    0,
			 -262, -262, -262, -262, -262, -262, -262, -262,    6,    5,
			    0,    4,    3,   46,   45,   44,   43,   42,   41,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,  271,  270,  269,

			  268,  267,  266,  265,  264,  263,  262,  261,  260,  259,
			  258,  257,  256,  255,  254,  253,   74,  271,  270,  269,
			  268,  267,  266,  265,  264,  263,  262,  261,  260,  259,
			  258,  257,  256,  255,  254,  253,   74,  564,  130,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  131,  130,
			    0,    0,  129,    0,    0,    0,    0,  128,    0,    0,
			    0,  229,  228,  129,    0,    0,    0,    0,  128,    0,
			    0,    0,    0,    0,    0,    0,  129,  127,    0,    0,
			    0,  128,    0, 1052,  131,  130,    0,  126,  127,    0,
			    0,    0,    0,    0,    0,    0,  125,    0,  126,  219,

			    0,  127,    0, 1026,  218,    0,    0,  125,  124,    0,
			    0,  126,    0,    0,  123,  122,  121,  120,  119,  124,
			  125,    0,  118,    0,  127,  123,  122,  121,  120,  119,
			    0,    0,  124,  118,  126,    0,  131,  130,  227,  226,
			  121,  225,  224,  125,    0,    0,  118,    0,    0,  733,
			    0,  732,  131,  130,    0,  217,  731,  179,   12,   11,
			    0,  123,  122,  121,  216,  215,    0,  732,    0,  118,
			    0,  171,  731,    0,    0,    0,    0,    0,  178,    0,
			    0,  177,    0,    0,  176,    0,    0,    0,    0,    0,
			   55,    0,    0,   53,    0,  125,    0,    0,    0,    0, yyDummy>>,
			1, 1000, 3000)
		end

	yytable_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,    0,    0,    0,    0,    0,  124,    0,    0,
			    0,  125,    0,  123,  122,  121,  730,  729,    0,    0,
			    0,  118,    0,  124,    0,    0,    0,    0,    0,  123,
			  122,  121,  730,  729,    0,    6,    5,  118,    4,    3,
			  271,  270,  269,  268,  267,  266,  265,  264,  263,  262,
			  261,  260,  259,  258,  257,  256,  255,  254,  253,   74,
			  709,    0,    0,  327,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  -72,    0,    0,    0,
			  -72,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  -72,  -72,    0,    0, -307,    0,    0,    0,    0,    0,

			  -72,    0,    0,  -72,    0,  -72,    0,    0,    0,    0,
			    0,    0, -307,  267,  266,  265,  264,  263,  262,  261,
			  260,  259,  258,  257,  256,  255,  254,  253,   74,  -72,
			    0,  -72,  271,  270,  269,  268,  267,  266,  265,  264,
			  263,  262,  261,  260,  259,  258,  257,  256,  255,  254,
			  253,   74,  271,  270,  269,  268,  267,  266,  265,  264,
			  263,  262,  261,  260,  259,  258,  257,  256,  255,  254,
			  253,   74,  271,  270,  269,  268,  267,  266,  265,  264,
			  263,  262,  261,  260,  259,  258,  257,  256,  255,  254,
			  253,   74,    0,    0,    0,  489,  368,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  327,  271,  270,  269,  268,  267,  266,
			  265,  264,  263,  262,  261,  260,  259,  258,  257,  256,
			  255,  254,  253,   74,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  491,  271,  270,  269,  268,  267,  266,  265,  264,
			  263,  262,  261,  260,  259,  258,  257,  256,  255,  254,
			  253,   74,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  394,
			   46,   45,   44,   43,   42,   41,   40,   39,   38,   37,

			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   46,    0,   44,    0,   42,   41,
			   40,   39,   38,   37,   36,   35,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,  271,  270,
			  269,  268,  267,  266,  265,  264,  263,  262,  261,  260,
			  259,  258,  257,  256,  255,  254,  253,   74,  211,  210,
			  209,  208,  207,  206,  205,  204,  203,  202,  201,  200,
			  199,  198,  197,  196,  195,  461,  194,  460,  270,  269,
			  268,  267,  266,  265,  264,  263,  262,  261,  260,  259,
			  258,  257,  256,  255,  254,  253,   74,  211,  210,  209,

			  208,  207,  206,  205,  204,  203,  202,  201,  200,  199,
			  198,  197,  196,  195,    0,  194,  269,  268,  267,  266,
			  265,  264,  263,  262,  261,  260,  259,  258,  257,  256,
			  255,  254,  253,   74, yyDummy>>,
			1, 434, 4000)
		end

	yycheck_template: SPECIAL [INTEGER]
			-- Template for `yycheck'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 4433)
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
			    0,   49,   50,   51,   52,   64,  160,   61,   61,    7,
			    2,    9,   22,   22,  119,  120,   18,  324,   16,   17,
			   18,  468,   22,  191,  469,   61,   52,  155,  119,  120,
			  507,  128,  129,  114,  284,  705,  507,  128,  129,  240,
			  124,  560,  696,  332,  214,  149,  445,   13,  470,  127,
			  529,  478,   52,  507,   64,   64,  387,  155,  767,  396,
			   49,    0,   62,  750,   64,   63,  750,   65,  889,  155,
			  862,  127,   47,  126,  888,  889,  750,  125,  124,  127,
			   59,  251,  835,   68,  155,  532,    0,  127,  449,    0,
			  750,  761,  173,  353,  769,  770,   62,  772,  752,  155,

			  750,   59,   45,   42,  810,  275,  276,  155,   59,  833,
			  215,  216,  127,  592,  624,  155,  626,    0,   57,  224,
			  225,  218,  219,  102,   29,  125,   77,  127,    3,  882,
			  115,   74,   59,  224,  225,  133,   68,   76,  113,  845,
			  155,  588,   47,   82,  102,   59,   57,    0,  627,   60,
			  160,  160,  152,  514,   93,  155,  324,   59,  158,   91,
			  160,  885,  954,   38,   59,  874,  155,  644,  168,  646,
			  109,  217,  859,  100,  601,  859,   44,  624,  931,  658,
			  381,  179,  519,  115, 1005,  859,   88,  213,  214,   12,
			  127, 1005,  646,   59,  192,  155,  456,  398,  112,  859,

			  114,   42,  168,  909,   99,  171,  881,  629,  113,  859,
			  112,  690,  114,   17,   18,  155,  663,   83,  155,   46,
			  619,  325,   88,   59,  308,  251,   30,   31,   36,   33,
			  155,   35,   59,  112,   57,  114,   44,   94,  850,   43,
			   36,   77,  854,   59,  914,  243,  112,   59,  114,  275,
			  276,  728,   30,   76,  252,  515,  727,  911,   59,   82,
			  935,  521,  937,   59,   59,   30,   31,   90,   95,   92,
			   93,  352,   73,  100,   57,   98,  103,    3,   29,   83,
			  280,   44,   83,   95,  124,  125,  109,   88,  100,  112,
			  113,  114,  904,   76,  981,    3,   47,  137,  138,   82,

			   95,   59,   28,  107,  108,  100,  110,  111,  103,  309,
			   93,  112,   38,  114,   30,   31,  314,  445,  318,  319,
			   28,  449,  582,  493,   89,  585,  109,   43,   59,  107,
			  108,  109,  110,  111,  332,   59,  101,  115,   63,  507,
			   56,  105,  107,  108,  109,  110,  111,  445,  374,   74,
			  115,  449,  553,  355, 1041, 1042, 1043,  355, 1045,  445,
			  360,  806,   59,  449,   88,   29,   28,  367,  368,  369,
			  370,  660,   84,   35,  445,  373,   88,  375,  449,   43,
			   77,   59,   59,   59,   59,  645,  514, 1074,  112,  445,
			  114,  107,  108,  449,  110,  111,  396,  445,   73,   77,

			   77,  449,  102,   17,   18,  445,   89,   83,   83,  449,
			   78,  377,   88,   88,   28,   59,  514,  667,  101,   33,
			   59,   35,  388,  683,  713,   59,   17,   18,  514,   61,
			  445,  431,  480,    4,  449,   37,  112,  112,  114,  114,
			   72,  691,   33,  514,   46,  445,  444,   48,  616,  449,
			   80,   59,   82,  507,  464,  464,  445,  657,  514,  485,
			  449,  661,  543,    4,  464,    4,  514,  493,  638,  467,
			  436,  507,   83,   81,  514,  994,  644,  477,  646,  647,
			  648,   30,   31,  743,    4,  445,   43,   95,   43,  449,
			   43,  619,  100,   44,  575,  103,  624,  545,  626,  514,

			  466,  104,  105,   47,   48,  445,  756,   56,  445,  449,
			  508,   91,  449,  773,  514,   47,   48,  848,   88,  519,
			  445,  619,  522,   59,  449,  514,  624,  384,  626,  106,
			  528,   59, 1051,  619, 1053,   17,   18,  787,  624,  707,
			  626,  709,   48,  711,   47,   48,   28,   59,  619,   23,
			   24,   33,  518,  624,  514,  626,  545, 1004,  107,  108,
			  728,  110,  111,  619,  814,  531,  423,  898,  624,   57,
			  626,  619,  903,  904,  514,   48,  624,  514,  626,  619,
			   30,   31,   33,   34,  624,  633,  626,  587,   76,  514,
			  644,  104,  646,  593,   82,   33,   34,   33,   34,  767,

			  705,   28,   90,   59,  619,   93,  606,  104,  644,  624,
			  646,  626,  638,   33,   34,  100,  923,  474,  475,  619,
			   43,  109,  953,   46, 1033, 1034,  483,   75,   76,   57,
			  619,   30,   31,  625,   59,  624,   59,  626,  729,  730,
			  731,  732,   46,   74,  610,   68,  612,   88,   76,   59,
			   95,   59,   44,   69,   82,   48,  761,  107,  108,  619,
			  110,  111,  660,   48,  624,   93,  626,  927,   30,   31,
			  668,   59,   95,   44,  728,   30,   42,  100,   46,  619,
			  103,  109,  619,   73,  624,  683,  626,  624,   45,  626,
			   89,  693,  728,  685,  619,  693,   68,  103,   59,  624,

			   59,  626,  101,   48,   48,  703,  874,    3,  107,  108,
			  109,  110,  111,   17,   18,  713,  115,    3,    3,   91,
			    3,  719,  720, 1030,   29,   59,   30,   31,   81,   33,
			   59,   59,  104,  105,    0,  733,  790,  790,  786,   43,
			   59,   97,   36,  115,   44,  107,  108,  109,  110,  111,
			  750,   97,   99,  115,  790,  923,   67,  854,   42,  102,
			   86,   37,  156,   79,  823,  763,  920,   92,   59,  828,
			   49,  769,  770,  771,  772,  773,   48,  112,   48,   83,
			   47,   90,  780,   42,   77,   48,  786,   30,   31,  113,
			   59,   57,   28,   59,   59,   28,   98,   30,   31,   29,

			   88,   42,   68,  107,  108,  108,  110,  111,   37,  914,
			   76,   48,   37,  823,  823,   37,   82,   48,  828,  828,
			   53,   48,   28,  823,   90,   91,  824,   93,  828,   42,
			   48,   42,   10,   99,   69,   59,  102,   37,  104,  105,
			   48,   81,   37,  109,   48,  843,  112,   41,  114,  115,
			  850,   44,   29,  981,  854,   95,   42,   97,  101,  859,
			  100,   73, 1030,  103,  107,  108,  109,  110,  111,   47,
			   48,   47,  115,  932,  107,  108,   47,  110,  111,   36,
			  878,  169,  170,  881,   36,   33,   37,   33,  886,  887,
			   28,   44,   70,   71,   44,   73,   33,   42,   42,   48,

			  959,   48,  961,  981,  904,   47,   47,   82,   37,   33,
			  920,  920,   28, 1041, 1042,   93,   42, 1045,   45,   44,
			  920,   89,  932,  932,   47,  981,   19,   20,   21,   22,
			   23,   24,  932,  981,  328,   89,   42,  935,   47,  937,
			   28,  981,   28,   28,   48,  943, 1074,   69,  946,  959,
			  959,  961,  961,  241,  242,   67,  244,   28,   28,  959,
			   28,  961,   28,   36, 1042, 1043,  981, 1045,   28,   41,
			  364,   29,   37, 1032,   28,   28,  974,    0, 1061,   43,
			  914,  981,  581,  705,  365,  273, 1042, 1043,  610, 1045,
			   30,   31,  741, 1041, 1042, 1043, 1074, 1045,  154,  565, yyDummy>>,
			1, 1000, 0)
		end

	yycheck_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  522,  157, 1042, 1043,  785, 1045,  762,  911, 1006,  961,
			  712,  167,  633,   53, 1074,  859, 1030,  707, 1074,  840,
			   30,   31, 1032, 1032,  744,   35, 1074, 1042, 1043,  444,
			 1045,  744, 1032,   43, 1074, 1033, 1034,  744,  464,   17,
			   18, 1041, 1042, 1043,  981, 1045,  913,  959, 1060,   89,
			   28, 1008,  924, 1049,  448,   33,   34,   35,  236, 1074,
			  778,  455, 1060,  939, 1032,  982,  895,  107,  108,  619,
			  110,  111,   50,   83, 1074,  253,  254,  255,  256,  257,
			  258,  259,  260,  261,  262,  263,  264,  265,  266,  267,
			  268,  269,  270,  271,  272,  489,  790,  107,  108,  485,

			  110,  111,  390,  452,  392, 1042, 1043,  362, 1045,  697,
			  972,  399,  400,  401,  402,  403,  404,  405,  406,  407,
			  408,  409,  410,  411,  412,  413,  324,  415,  416,    9,
			  418,  419,  420,  721,  354,  626,  576, 1074,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,  131,  132,  133,  134,  135,  136,  137,
			  138,  139,   29,   30,   31,  485,  722,  561,  456,  757,
			    0,   -1,  591,  987,   -1,  331,   -1,   -1,   -1,   -1,
			   -1,   -1,  360,  577,   -1,   -1,   53,  343,   -1,   56,
			   -1,   -1,   17,   18,   -1,   62,  784,   -1,   65,   -1,

			   -1,  357,  596,   -1,   -1,   30,   31,   -1,   33,  497,
			  498,   30,  500,   -1,   -1,   -1,   46,  611,   43,   -1,
			   -1,  615,   -1,   -1,   -1,   -1,   -1,   57,   -1,   59,
			   60,   61,   -1,   -1,   -1,  391,  414,  393,   -1,  417,
			  107,  108,   72,  110,  111,  533,   76,   -1,   -1,  537,
			   80,  429,   82,  541,   30,   31,   -1,   -1,  846,   -1,
			   90,   80,   92,   93,   -1,   -1,   -1,   -1,   98,   -1,
			   -1,  559,  560,  861,   -1,   -1,   -1,   96,   -1,  109,
			   -1,   -1,  107,  108,   -1,  110,  111,  681,  107,  108,
			  109,  110,  111,  471,   -1,   71,  115,  585,   -1,  477,

			    0,   -1,  480,  459,   -1,   -1,  894,   83,   -1,   -1,
			  704,  899,   88,   -1,   90,  603,   -1,   -1,   -1,   -1,
			  476,   -1,   -1,  501,  502,   30,   31,   -1,  484,   -1,
			   -1,  107,  108,   -1,  110,  111,  112,   -1,  114,  495,
			  496,   30,   31,  521,  522,   -1,   -1,   -1,  742,   -1,
			  506,  639,   -1,  941,   43,   -1,   -1,   57,   -1,   59,
			   60,   61,   -1,   -1,   53,   -1,   -1,  955,   -1,   -1,
			    0,   -1,   72,   -1,  552,   -1,   76,   -1,   -1,   -1,
			   80,  537,   82,   -1,   89,   -1,   -1,   -1,  544,   -1,
			   90,   -1,   92,   93,   -1,   -1,  984,   -1,   98,   -1,

			   -1,   -1,  107,  108,  109,  110,  111,   -1,   -1,  109,
			  115,  805,   -1,   -1,  702,   -1,   -1,   -1,  107,  108,
			   -1,  110,  111,   -1,  818,   -1,   -1,   57,  606,   59,
			   60,   61,   -1,   -1,   -1,   -1,   -1,   -1, 1026,  595,
			 1028,   -1,   72,   -1,   -1,   -1,   76,   -1,    0,   -1,
			   80,   -1,   82,   -1,   -1,  633,   -1,   -1,   -1,   -1,
			   90,   -1,   92,   93, 1052,   -1,   -1,   -1,   98,   -1,
			  864,   17,   18,   19,   20,   21,   22,   23,   24,  109,
			   -1,   -1,   -1,   -1,   -1,  879,   30,   31,   -1,   -1,
			   -1, 1079, 1080,  671,   -1,   -1,  890,   -1,   -1,   30,

			   31,   -1,   -1,   -1,   -1,   57,   37,   59,   60,   61,
			  798,   -1,   -1,   -1,   45,   -1,   30,   31,   62,   50,
			   72,   65,  916,   -1,   76,  919,  682,   -1,   80,   43,
			   82,   -1,  688,   -1,   -1,   -1,   -1,   -1,   90,   70,
			   92,   93,   -1,   -1,   -1,   -1,   98,   -1,   62,   80,
			  944,   65,   -1,   -1,   -1,  843,  844,  109,   89,   -1,
			   -1,  717,   -1,  107,  108,   -1,  110,  111,   -1,   -1,
			  101,   59,  750,   -1,   -1,   63,  107,  108,  109,  110,
			  111,  975,   -1,   -1,  115,   73,   74,   30,   31,  745,
			   -1,  747,   -1,  107,  108,   83,  110,  111,   86,   -1,

			   88,   -1,   45,  997,  782,  783, 1000,   50,   -1,   -1,
			   -1,   -1,   -1,  901,  902,   -1,   -1,  905,  906,  907,
			   -1,   -1,   -1,   -1,  112,   -1,  114,   70,   -1,   -1,
			 1024,   -1,   -1,   -1,   -1,   -1,   -1,   80,   -1,   -1,
			    0,   -1,   -1,   -1, 1038,   -1,   89,   -1,   -1,   -1,
			 1044,   -1,   12,   -1,   -1,  811,   -1,  813,  101,   -1,
			   -1,   -1,   -1,  819,  107,  108,  109,  110,  111,   -1,
			   30,   31,  115,   -1,  852,  853,   36,   37,  856,  857,
			  858,  859,   42,   -1,   44,   45,   46,   -1,   48,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   57,   -1,   59,

			   60,  989,   62,   -1,   -1,   65,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   74,   -1,   76,  873,   -1,   -1,
			   -1,  877,   82,   83,  880,   30,   31,   -1,   88,   89,
			   90,   -1,   92,   93,   -1,  891,   -1,   97,   98, 1027,
			   45,  101,   -1,   -1,   -1,   50,   -1,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,   -1,   57,   -1,   59,
			 1048,   -1,  918,   -1,   -1,   70,   -1,   -1,   -1,  947,
			   -1,   -1,   -1,   -1,   -1,   80,   76,   -1,   -1,   -1,
			   -1,   -1,   82,   -1,   89,   -1,   -1,   -1,   -1,  945,
			   90,   -1,   92,   93,   -1,   -1,  101,   -1,   98,   -1,

			   -1,   -1,  107,  108,  109,  110,  111,   -1,  964,  109,
			  115,   -1,  990,   -1,   -1,  971,   30,   31,   17,   18,
			  976,   -1,   -1,   -1,   -1,   24,   25,   26,   27,   -1,
			   29,   30,   31,   32,   33,   34,   35,   36,   -1,   -1,
			   39,   40,   -1,   -1,   43, 1023,   45,   -1,   62,   -1,
			   -1,   65,   51,   52,   53,   54,   -1,   56,   -1,   58,
			   -1, 1017,   -1,   62,   -1,   64,   65,   66,   -1, 1025,
			   -1,   -1,   71,   -1,   -1,   74,   75,   -1,   -1,   -1,
			   -1,   -1,   -1, 1039,   83,   84,   85,   -1,   87,   -1,
			   -1,   -1,   -1,  107,  108,   94,  110,  111,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  107,  108,
			   -1,  110,  111,   -1,   -1,   -1,   -1,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,  137,  138,
			  139,   17,   18,   -1,   -1,   -1,   -1,   -1,   24,   25,
			   26,   27,   46,   29,   30,   31,   32,   33,   34,   35,
			   36,   -1,   -1,   39,   40,   59,   -1,   43,   -1,   45,
			   -1,   -1,   -1,   -1,   50,   51,   52,   53,   -1,   -1,
			   56,   -1,   58,   77,   78,   79,   62,   -1,   64,   65,
			   66,   -1,   -1,   -1,   88,   -1,   -1,   91,   74,   -1, yyDummy>>,
			1, 1000, 1000)
		end

	yycheck_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1,   -1,   -1,   -1,   99,   -1,   83,   -1,   -1,
			  104,  105,  106,   -1,   -1,   -1,   -1,   -1,   94,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  107,  108,   -1,  110,  111,   -1,   -1,   -1,   -1,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,  137,  138,  139,   17,   18,   -1,   -1,   -1,   -1,
			   -1,   24,   25,   26,   27,   -1,   29,   30,   31,   32,
			   33,   34,   35,   36,   -1,   -1,   39,   40,   59,   -1,
			   43,   -1,   45,   46,   -1,   -1,   -1,   -1,   51,   52,

			   53,   -1,   -1,   56,   -1,   58,   77,   78,   79,   62,
			   -1,   64,   65,   66,   -1,   -1,   -1,   88,   -1,   -1,
			   91,   74,   -1,   -1,   -1,   -1,   -1,   -1,   99,   -1,
			   83,   -1,   -1,  104,  105,  106,   -1,   -1,   -1,   -1,
			   -1,   94,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  107,  108,   -1,  110,  111,   -1,
			   -1,   -1,   -1,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,  137,  138,  139,   17,   18,   -1,
			   -1,   -1,   -1,   -1,   24,   25,   26,   27,   -1,   29,

			   30,   31,   32,   33,   34,   35,   36,   -1,   -1,   39,
			   40,   -1,   -1,   43,   -1,   45,   -1,   -1,   -1,   -1,
			   -1,   51,   52,   53,   -1,   -1,   56,   -1,   58,   -1,
			   -1,   -1,   62,   -1,   64,   65,   66,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   74,   -1,   -1,   77,   -1,   -1,
			   -1,   -1,   -1,   83,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   94,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  107,  108,   -1,
			  110,  111,   -1,   -1,   -1,   -1,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,

			  130,  131,  132,  133,  134,  135,  136,  137,  138,  139,
			   17,   18,   -1,   -1,   -1,   -1,   -1,   24,   25,   26,
			   27,   -1,   29,   30,   31,   32,   33,   34,   35,   36,
			   -1,   -1,   39,   40,   -1,   -1,   43,   -1,   45,   -1,
			   -1,   -1,   -1,   -1,   51,   52,   53,   -1,   -1,   56,
			   -1,   58,   -1,   -1,   -1,   62,   -1,   64,   65,   66,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   74,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   83,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   94,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  102,   -1,   -1,   -1,   -1,

			  107,  108,   -1,  110,  111,   -1,   -1,   -1,   -1,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			  137,  138,  139,   17,   18,   -1,   -1,   -1,   -1,   -1,
			   24,   25,   26,   27,   -1,   29,   30,   31,   32,   33,
			   34,   35,   36,   -1,   -1,   39,   40,   -1,   -1,   43,
			   -1,   45,   -1,   -1,   -1,   -1,   -1,   51,   52,   53,
			   -1,   -1,   56,   -1,   58,   -1,   -1,   -1,   62,   -1,
			   64,   65,   66,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   74,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   83,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   94,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  107,  108,   -1,  110,  111,   -1,   -1,
			   -1,   -1,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,  137,  138,  139,   17,   18,   -1,   -1,
			   -1,   -1,   -1,   24,   25,   26,   27,   -1,   29,   30,
			   31,   32,   33,   34,   35,   36,   -1,   -1,   39,   40,
			   -1,   -1,   43,   -1,   45,   -1,   -1,   -1,   -1,   -1,
			   51,   52,   53,   -1,   -1,   56,   -1,   58,   -1,   -1,

			   -1,   62,   -1,   64,   65,   66,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   74,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   83,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   94,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  107,  108,   -1,  110,
			  111,   -1,   -1,   -1,   -1,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,  137,  138,  139,   17,
			   18,   -1,   -1,   -1,   -1,   -1,   24,   25,   26,   27,
			   -1,   29,   30,   31,   32,   33,   34,   35,   36,   -1,

			   -1,   39,   40,   -1,   -1,   43,   -1,   45,   -1,   -1,
			   -1,   -1,   -1,   51,   52,   53,   -1,   -1,   56,   -1,
			   58,   -1,   -1,   -1,   62,   -1,   64,   65,   66,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   74,   -1,   -1,   -1,
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
			   65,   66,   -1,   -1,   -1,   -1,   17,   18,   -1,   74,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   83,   30,
			   31,   32,   33,   34,   35,   -1,   -1,   -1,   -1,   94,
			   -1,   -1,   43,   -1,   -1,   46,   -1,   -1,   -1,   -1,
			   51,   52,  107,  108,   -1,  110,  111,   -1,   -1,   -1,

			   -1,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137,  138,  139,   -1,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   22,   23,   24,  107,  108,   -1,  110,
			  111,   -1,   -1,   -1,   -1,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,  137,  138,  139,   17,
			   18,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   30,   31,   32,   33,   34,   35,   -1,   -1, yyDummy>>,
			1, 1000, 2000)
		end

	yycheck_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1,   -1,   -1,   -1,   43,   -1,   17,   18,   -1,
			   -1,   -1,   -1,   51,   52,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   32,   33,   34,   35,  105,   -1,   -1,   -1,
			   -1,   -1,   -1,   43,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   51,   52,   -1,   -1,   55,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   22,   23,   24,   -1,   -1,   -1,  107,
			  108,   -1,  110,  111,   -1,   -1,   -1,   -1,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,  131,  132,  133,  134,  135,  136,  137,

			  138,  139,  112,   -1,  114,   -1,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,  132,  133,  134,  135,  136,  137,  138,  139,
			   17,   18,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  102,   -1,   32,   33,   34,   35,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   43,   -1,   17,   18,
			   -1,   -1,   -1,   -1,   51,   52,   -1,   -1,   55,   28,
			   -1,   -1,   -1,   -1,   33,   34,   35,   -1,   -1,   -1,
			   -1,   -1,   17,   18,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   33,   34,

			   35,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   22,   23,   24,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			  137,  138,  139,   -1,   -1,   -1,   -1,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,  137,  138,
			  139,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,

			  135,  136,  137,  138,  139,    0,  102,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   12,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   22,   23,   24,   30,   31,   -1,   -1,   -1,
			   -1,   36,   37,   -1,   -1,   -1,   -1,   42,   -1,   44,
			   45,   46,   -1,   48,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   57,   -1,   59,   60,   -1,   62,   -1,   -1,
			   65,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   74,
			   -1,   76,   -1,   -1,   -1,   -1,   -1,   82,   83,   -1,
			   -1,   -1,    0,   88,   89,   90,   -1,   92,   93,   -1,

			   -1,   -1,   97,   98,   12,   -1,  101,   -1,   -1,   -1,
			   -1,   -1,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,   -1,   30,   31,   -1,   -1,   -1,   -1,   36,   37,
			   -1,   -1,   -1,   -1,   42,   -1,   44,   45,   46,   -1,
			   48,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   57,
			   -1,   59,   60,   -1,   62,   -1,   -1,   65,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   74,   -1,   76,   -1,
			   -1,   -1,   -1,   -1,   82,   83,   -1,   -1,   -1,    0,
			   88,   -1,   90,   -1,   92,   93,   -1,   -1,   -1,   97,
			   98,   12,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  107,

			  108,  109,  110,  111,  112,  113,  114,   -1,   -1,   30,
			   31,   -1,   -1,   -1,   -1,   36,   37,   -1,   -1,   -1,
			   -1,   42,   -1,   44,   45,   46,   -1,   48,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   57,   -1,   59,   60,
			   -1,   62,   -1,   -1,   65,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   74,   -1,   76,   -1,   -1,   -1,   -1,
			   -1,   82,   83,   -1,   -1,   -1,    0,   88,   -1,   90,
			   -1,   92,   93,   -1,   -1,   -1,   97,   98,   12,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  107,  108,  109,  110,
			  111,  112,  113,  114,   -1,   -1,   30,   31,   -1,   -1,

			   -1,   -1,   36,   37,   -1,   -1,   -1,   -1,   42,   -1,
			   44,   45,   46,   -1,   48,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   57,   -1,   59,   60,   -1,   62,   -1,
			   -1,   65,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   74,   -1,   76,   -1,   -1,   -1,   -1,   -1,   82,   83,
			   -1,   -1,   -1,    0,   88,   -1,   90,   -1,   92,   93,
			   -1,   -1,   -1,   97,   98,   12,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  107,  108,  109,  110,  111,  112,  113,
			  114,   -1,   -1,   30,   31,   -1,   -1,   -1,   -1,   -1,
			   37,   30,   31,   -1,   -1,   42,   -1,   44,   45,   46,

			   43,   48,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   57,   -1,   59,   60,   -1,   62,   -1,   -1,   65,   -1,
			   -1,   60,   -1,   62,   -1,   -1,   65,   74,   -1,   76,
			   -1,   -1,   -1,   -1,   -1,   82,   83,   -1,   -1,   -1,
			   -1,   88,   -1,   90,   -1,   92,   93,   -1,   -1,   -1,
			   97,   98,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  107,  108,  109,  110,  111,  112,  113,  114,  107,  108,
			   -1,  110,  111,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,  137,  138,  139,    5,    6,    7,

			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   22,   23,   24,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   22,   23,   24,   30,   31,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   30,   31,
			   -1,   -1,   45,   -1,   -1,   -1,   -1,   50,   -1,   -1,
			   -1,   30,   31,   45,   -1,   -1,   -1,   -1,   50,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   45,   70,   -1,   -1,
			   -1,   50,   -1,   91,   30,   31,   -1,   80,   70,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   89,   -1,   80,   45,

			   -1,   70,   -1,   91,   50,   -1,   -1,   89,  101,   -1,
			   -1,   80,   -1,   -1,  107,  108,  109,  110,  111,  101,
			   89,   -1,  115,   -1,   70,  107,  108,  109,  110,  111,
			   -1,   -1,  101,  115,   80,   -1,   30,   31,  107,  108,
			  109,  110,  111,   89,   -1,   -1,  115,   -1,   -1,   43,
			   -1,   45,   30,   31,   -1,  101,   50,   29,   30,   31,
			   -1,  107,  108,  109,  110,  111,   -1,   45,   -1,  115,
			   -1,   43,   50,   -1,   -1,   -1,   -1,   -1,   50,   -1,
			   -1,   53,   -1,   -1,   56,   -1,   -1,   -1,   -1,   -1,
			   62,   -1,   -1,   65,   -1,   89,   -1,   -1,   -1,   -1, yyDummy>>,
			1, 1000, 3000)
		end

	yycheck_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  101,   -1,   -1,
			   -1,   89,   -1,  107,  108,  109,  110,  111,   -1,   -1,
			   -1,  115,   -1,  101,   -1,   -1,   -1,   -1,   -1,  107,
			  108,  109,  110,  111,   -1,  107,  108,  115,  110,  111,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   43,   -1,   -1,   46,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   59,   -1,   -1,   -1,
			   63,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   73,   74,   -1,   -1,   59,   -1,   -1,   -1,   -1,   -1,

			   83,   -1,   -1,   86,   -1,   88,   -1,   -1,   -1,   -1,
			   -1,   -1,   77,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   22,   23,   24,  112,
			   -1,  114,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,   -1,   -1,   -1,   48,   69,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   46,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   22,   23,   24,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   42,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   42,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,

			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,  137,  138,  139,  116,   -1,  118,   -1,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,
			  132,  133,  134,  135,  136,  137,  138,  139,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   22,   23,   24,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,
			  132,  133,  134,  135,  136,  137,  138,  139,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   22,   23,   24,  120,  121,  122,

			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,   -1,  138,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   22,   23,   24, yyDummy>>,
			1, 434, 4000)
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

	yyvs3: SPECIAL [CHAR_AS]
			-- Stack for semantic values of type CHAR_AS

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [CHAR_AS]
			-- Routines that ought to be in SPECIAL [CHAR_AS]

	yyvs4: SPECIAL [SYMBOL_AS]
			-- Stack for semantic values of type SYMBOL_AS

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: KL_SPECIAL_ROUTINES [SYMBOL_AS]
			-- Routines that ought to be in SPECIAL [SYMBOL_AS]

	yyvs5: SPECIAL [BOOL_AS]
			-- Stack for semantic values of type BOOL_AS

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [BOOL_AS]
			-- Routines that ought to be in SPECIAL [BOOL_AS]

	yyvs6: SPECIAL [RESULT_AS]
			-- Stack for semantic values of type RESULT_AS

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [RESULT_AS]
			-- Routines that ought to be in SPECIAL [RESULT_AS]

	yyvs7: SPECIAL [RETRY_AS]
			-- Stack for semantic values of type RETRY_AS

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [RETRY_AS]
			-- Routines that ought to be in SPECIAL [RETRY_AS]

	yyvs8: SPECIAL [UNIQUE_AS]
			-- Stack for semantic values of type UNIQUE_AS

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [UNIQUE_AS]
			-- Routines that ought to be in SPECIAL [UNIQUE_AS]

	yyvs9: SPECIAL [CURRENT_AS]
			-- Stack for semantic values of type CURRENT_AS

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: KL_SPECIAL_ROUTINES [CURRENT_AS]
			-- Routines that ought to be in SPECIAL [CURRENT_AS]

	yyvs10: SPECIAL [DEFERRED_AS]
			-- Stack for semantic values of type DEFERRED_AS

	yyvsc10: INTEGER
			-- Capacity of semantic value stack `yyvs10'

	yyvsp10: INTEGER
			-- Top of semantic value stack `yyvs10'

	yyspecial_routines10: KL_SPECIAL_ROUTINES [DEFERRED_AS]
			-- Routines that ought to be in SPECIAL [DEFERRED_AS]

	yyvs11: SPECIAL [VOID_AS]
			-- Stack for semantic values of type VOID_AS

	yyvsc11: INTEGER
			-- Capacity of semantic value stack `yyvs11'

	yyvsp11: INTEGER
			-- Top of semantic value stack `yyvs11'

	yyspecial_routines11: KL_SPECIAL_ROUTINES [VOID_AS]
			-- Routines that ought to be in SPECIAL [VOID_AS]

	yyvs12: SPECIAL [KEYWORD_AS]
			-- Stack for semantic values of type KEYWORD_AS

	yyvsc12: INTEGER
			-- Capacity of semantic value stack `yyvs12'

	yyvsp12: INTEGER
			-- Top of semantic value stack `yyvs12'

	yyspecial_routines12: KL_SPECIAL_ROUTINES [KEYWORD_AS]
			-- Routines that ought to be in SPECIAL [KEYWORD_AS]

	yyvs13: SPECIAL [STRING]
			-- Stack for semantic values of type STRING

	yyvsc13: INTEGER
			-- Capacity of semantic value stack `yyvs13'

	yyvsp13: INTEGER
			-- Top of semantic value stack `yyvs13'

	yyspecial_routines13: KL_SPECIAL_ROUTINES [STRING]
			-- Routines that ought to be in SPECIAL [STRING]

	yyvs14: SPECIAL [INTEGER]
			-- Stack for semantic values of type INTEGER

	yyvsc14: INTEGER
			-- Capacity of semantic value stack `yyvs14'

	yyvsp14: INTEGER
			-- Top of semantic value stack `yyvs14'

	yyspecial_routines14: KL_SPECIAL_ROUTINES [INTEGER]
			-- Routines that ought to be in SPECIAL [INTEGER]

	yyvs15: SPECIAL [TUPLE [KEYWORD_AS, ID_AS, INTEGER, INTEGER, STRING]]
			-- Stack for semantic values of type TUPLE [KEYWORD_AS, ID_AS, INTEGER, INTEGER, STRING]

	yyvsc15: INTEGER
			-- Capacity of semantic value stack `yyvs15'

	yyvsp15: INTEGER
			-- Top of semantic value stack `yyvs15'

	yyspecial_routines15: KL_SPECIAL_ROUTINES [TUPLE [KEYWORD_AS, ID_AS, INTEGER, INTEGER, STRING]]
			-- Routines that ought to be in SPECIAL [TUPLE [KEYWORD_AS, ID_AS, INTEGER, INTEGER, STRING]]

	yyvs16: SPECIAL [STRING_AS]
			-- Stack for semantic values of type STRING_AS

	yyvsc16: INTEGER
			-- Capacity of semantic value stack `yyvs16'

	yyvsp16: INTEGER
			-- Top of semantic value stack `yyvs16'

	yyspecial_routines16: KL_SPECIAL_ROUTINES [STRING_AS]
			-- Routines that ought to be in SPECIAL [STRING_AS]

	yyvs17: SPECIAL [ALIAS_TRIPLE]
			-- Stack for semantic values of type ALIAS_TRIPLE

	yyvsc17: INTEGER
			-- Capacity of semantic value stack `yyvs17'

	yyvsp17: INTEGER
			-- Top of semantic value stack `yyvs17'

	yyspecial_routines17: KL_SPECIAL_ROUTINES [ALIAS_TRIPLE]
			-- Routines that ought to be in SPECIAL [ALIAS_TRIPLE]

	yyvs18: SPECIAL [INSTRUCTION_AS]
			-- Stack for semantic values of type INSTRUCTION_AS

	yyvsc18: INTEGER
			-- Capacity of semantic value stack `yyvs18'

	yyvsp18: INTEGER
			-- Top of semantic value stack `yyvs18'

	yyspecial_routines18: KL_SPECIAL_ROUTINES [INSTRUCTION_AS]
			-- Routines that ought to be in SPECIAL [INSTRUCTION_AS]

	yyvs19: SPECIAL [EIFFEL_LIST [INSTRUCTION_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [INSTRUCTION_AS]

	yyvsc19: INTEGER
			-- Capacity of semantic value stack `yyvs19'

	yyvsp19: INTEGER
			-- Top of semantic value stack `yyvs19'

	yyspecial_routines19: KL_SPECIAL_ROUTINES [EIFFEL_LIST [INSTRUCTION_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [INSTRUCTION_AS]]

	yyvs20: SPECIAL [PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]]
			-- Stack for semantic values of type PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]

	yyvsc20: INTEGER
			-- Capacity of semantic value stack `yyvs20'

	yyvsp20: INTEGER
			-- Top of semantic value stack `yyvs20'

	yyspecial_routines20: KL_SPECIAL_ROUTINES [PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]]
			-- Routines that ought to be in SPECIAL [PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]]

	yyvs21: SPECIAL [PAIR [KEYWORD_AS, ID_AS]]
			-- Stack for semantic values of type PAIR [KEYWORD_AS, ID_AS]

	yyvsc21: INTEGER
			-- Capacity of semantic value stack `yyvs21'

	yyvsp21: INTEGER
			-- Top of semantic value stack `yyvs21'

	yyspecial_routines21: KL_SPECIAL_ROUTINES [PAIR [KEYWORD_AS, ID_AS]]
			-- Routines that ought to be in SPECIAL [PAIR [KEYWORD_AS, ID_AS]]

	yyvs22: SPECIAL [PAIR [KEYWORD_AS, STRING_AS]]
			-- Stack for semantic values of type PAIR [KEYWORD_AS, STRING_AS]

	yyvsc22: INTEGER
			-- Capacity of semantic value stack `yyvs22'

	yyvsp22: INTEGER
			-- Top of semantic value stack `yyvs22'

	yyspecial_routines22: KL_SPECIAL_ROUTINES [PAIR [KEYWORD_AS, STRING_AS]]
			-- Routines that ought to be in SPECIAL [PAIR [KEYWORD_AS, STRING_AS]]

	yyvs23: SPECIAL [IDENTIFIER_LIST]
			-- Stack for semantic values of type IDENTIFIER_LIST

	yyvsc23: INTEGER
			-- Capacity of semantic value stack `yyvs23'

	yyvsp23: INTEGER
			-- Top of semantic value stack `yyvs23'

	yyspecial_routines23: KL_SPECIAL_ROUTINES [IDENTIFIER_LIST]
			-- Routines that ought to be in SPECIAL [IDENTIFIER_LIST]

	yyvs24: SPECIAL [TAGGED_AS]
			-- Stack for semantic values of type TAGGED_AS

	yyvsc24: INTEGER
			-- Capacity of semantic value stack `yyvs24'

	yyvsp24: INTEGER
			-- Top of semantic value stack `yyvs24'

	yyspecial_routines24: KL_SPECIAL_ROUTINES [TAGGED_AS]
			-- Routines that ought to be in SPECIAL [TAGGED_AS]

	yyvs25: SPECIAL [EIFFEL_LIST [TAGGED_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [TAGGED_AS]

	yyvsc25: INTEGER
			-- Capacity of semantic value stack `yyvs25'

	yyvsp25: INTEGER
			-- Top of semantic value stack `yyvs25'

	yyspecial_routines25: KL_SPECIAL_ROUTINES [EIFFEL_LIST [TAGGED_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [TAGGED_AS]]

	yyvs26: SPECIAL [PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]]
			-- Stack for semantic values of type PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]

	yyvsc26: INTEGER
			-- Capacity of semantic value stack `yyvs26'

	yyvsp26: INTEGER
			-- Top of semantic value stack `yyvs26'

	yyspecial_routines26: KL_SPECIAL_ROUTINES [PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]]
			-- Routines that ought to be in SPECIAL [PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]]

	yyvs27: SPECIAL [EXPR_AS]
			-- Stack for semantic values of type EXPR_AS

	yyvsc27: INTEGER
			-- Capacity of semantic value stack `yyvs27'

	yyvsp27: INTEGER
			-- Top of semantic value stack `yyvs27'

	yyspecial_routines27: KL_SPECIAL_ROUTINES [EXPR_AS]
			-- Routines that ought to be in SPECIAL [EXPR_AS]

	yyvs28: SPECIAL [PAIR [KEYWORD_AS, EXPR_AS]]
			-- Stack for semantic values of type PAIR [KEYWORD_AS, EXPR_AS]

	yyvsc28: INTEGER
			-- Capacity of semantic value stack `yyvs28'

	yyvsp28: INTEGER
			-- Top of semantic value stack `yyvs28'

	yyspecial_routines28: KL_SPECIAL_ROUTINES [PAIR [KEYWORD_AS, EXPR_AS]]
			-- Routines that ought to be in SPECIAL [PAIR [KEYWORD_AS, EXPR_AS]]

	yyvs29: SPECIAL [AGENT_TARGET_TRIPLE]
			-- Stack for semantic values of type AGENT_TARGET_TRIPLE

	yyvsc29: INTEGER
			-- Capacity of semantic value stack `yyvs29'

	yyvsp29: INTEGER
			-- Top of semantic value stack `yyvs29'

	yyspecial_routines29: KL_SPECIAL_ROUTINES [AGENT_TARGET_TRIPLE]
			-- Routines that ought to be in SPECIAL [AGENT_TARGET_TRIPLE]

	yyvs30: SPECIAL [ACCESS_AS]
			-- Stack for semantic values of type ACCESS_AS

	yyvsc30: INTEGER
			-- Capacity of semantic value stack `yyvs30'

	yyvsp30: INTEGER
			-- Top of semantic value stack `yyvs30'

	yyspecial_routines30: KL_SPECIAL_ROUTINES [ACCESS_AS]
			-- Routines that ought to be in SPECIAL [ACCESS_AS]

	yyvs31: SPECIAL [ACCESS_FEAT_AS]
			-- Stack for semantic values of type ACCESS_FEAT_AS

	yyvsc31: INTEGER
			-- Capacity of semantic value stack `yyvs31'

	yyvsp31: INTEGER
			-- Top of semantic value stack `yyvs31'

	yyspecial_routines31: KL_SPECIAL_ROUTINES [ACCESS_FEAT_AS]
			-- Routines that ought to be in SPECIAL [ACCESS_FEAT_AS]

	yyvs32: SPECIAL [ACCESS_INV_AS]
			-- Stack for semantic values of type ACCESS_INV_AS

	yyvsc32: INTEGER
			-- Capacity of semantic value stack `yyvs32'

	yyvsp32: INTEGER
			-- Top of semantic value stack `yyvs32'

	yyspecial_routines32: KL_SPECIAL_ROUTINES [ACCESS_INV_AS]
			-- Routines that ought to be in SPECIAL [ACCESS_INV_AS]

	yyvs33: SPECIAL [ARRAY_AS]
			-- Stack for semantic values of type ARRAY_AS

	yyvsc33: INTEGER
			-- Capacity of semantic value stack `yyvs33'

	yyvsp33: INTEGER
			-- Top of semantic value stack `yyvs33'

	yyspecial_routines33: KL_SPECIAL_ROUTINES [ARRAY_AS]
			-- Routines that ought to be in SPECIAL [ARRAY_AS]

	yyvs34: SPECIAL [ASSIGN_AS]
			-- Stack for semantic values of type ASSIGN_AS

	yyvsc34: INTEGER
			-- Capacity of semantic value stack `yyvs34'

	yyvsp34: INTEGER
			-- Top of semantic value stack `yyvs34'

	yyspecial_routines34: KL_SPECIAL_ROUTINES [ASSIGN_AS]
			-- Routines that ought to be in SPECIAL [ASSIGN_AS]

	yyvs35: SPECIAL [ASSIGNER_CALL_AS]
			-- Stack for semantic values of type ASSIGNER_CALL_AS

	yyvsc35: INTEGER
			-- Capacity of semantic value stack `yyvs35'

	yyvsp35: INTEGER
			-- Top of semantic value stack `yyvs35'

	yyspecial_routines35: KL_SPECIAL_ROUTINES [ASSIGNER_CALL_AS]
			-- Routines that ought to be in SPECIAL [ASSIGNER_CALL_AS]

	yyvs36: SPECIAL [ATOMIC_AS]
			-- Stack for semantic values of type ATOMIC_AS

	yyvsc36: INTEGER
			-- Capacity of semantic value stack `yyvs36'

	yyvsp36: INTEGER
			-- Top of semantic value stack `yyvs36'

	yyspecial_routines36: KL_SPECIAL_ROUTINES [ATOMIC_AS]
			-- Routines that ought to be in SPECIAL [ATOMIC_AS]

	yyvs37: SPECIAL [BINARY_AS]
			-- Stack for semantic values of type BINARY_AS

	yyvsc37: INTEGER
			-- Capacity of semantic value stack `yyvs37'

	yyvsp37: INTEGER
			-- Top of semantic value stack `yyvs37'

	yyspecial_routines37: KL_SPECIAL_ROUTINES [BINARY_AS]
			-- Routines that ought to be in SPECIAL [BINARY_AS]

	yyvs38: SPECIAL [BIT_CONST_AS]
			-- Stack for semantic values of type BIT_CONST_AS

	yyvsc38: INTEGER
			-- Capacity of semantic value stack `yyvs38'

	yyvsp38: INTEGER
			-- Top of semantic value stack `yyvs38'

	yyspecial_routines38: KL_SPECIAL_ROUTINES [BIT_CONST_AS]
			-- Routines that ought to be in SPECIAL [BIT_CONST_AS]

	yyvs39: SPECIAL [BODY_AS]
			-- Stack for semantic values of type BODY_AS

	yyvsc39: INTEGER
			-- Capacity of semantic value stack `yyvs39'

	yyvsp39: INTEGER
			-- Top of semantic value stack `yyvs39'

	yyspecial_routines39: KL_SPECIAL_ROUTINES [BODY_AS]
			-- Routines that ought to be in SPECIAL [BODY_AS]

	yyvs40: SPECIAL [CALL_AS]
			-- Stack for semantic values of type CALL_AS

	yyvsc40: INTEGER
			-- Capacity of semantic value stack `yyvs40'

	yyvsp40: INTEGER
			-- Top of semantic value stack `yyvs40'

	yyspecial_routines40: KL_SPECIAL_ROUTINES [CALL_AS]
			-- Routines that ought to be in SPECIAL [CALL_AS]

	yyvs41: SPECIAL [CASE_AS]
			-- Stack for semantic values of type CASE_AS

	yyvsc41: INTEGER
			-- Capacity of semantic value stack `yyvs41'

	yyvsp41: INTEGER
			-- Top of semantic value stack `yyvs41'

	yyspecial_routines41: KL_SPECIAL_ROUTINES [CASE_AS]
			-- Routines that ought to be in SPECIAL [CASE_AS]

	yyvs42: SPECIAL [CHECK_AS]
			-- Stack for semantic values of type CHECK_AS

	yyvsc42: INTEGER
			-- Capacity of semantic value stack `yyvs42'

	yyvsp42: INTEGER
			-- Top of semantic value stack `yyvs42'

	yyspecial_routines42: KL_SPECIAL_ROUTINES [CHECK_AS]
			-- Routines that ought to be in SPECIAL [CHECK_AS]

	yyvs43: SPECIAL [CLIENT_AS]
			-- Stack for semantic values of type CLIENT_AS

	yyvsc43: INTEGER
			-- Capacity of semantic value stack `yyvs43'

	yyvsp43: INTEGER
			-- Top of semantic value stack `yyvs43'

	yyspecial_routines43: KL_SPECIAL_ROUTINES [CLIENT_AS]
			-- Routines that ought to be in SPECIAL [CLIENT_AS]

	yyvs44: SPECIAL [CONSTANT_AS]
			-- Stack for semantic values of type CONSTANT_AS

	yyvsc44: INTEGER
			-- Capacity of semantic value stack `yyvs44'

	yyvsp44: INTEGER
			-- Top of semantic value stack `yyvs44'

	yyspecial_routines44: KL_SPECIAL_ROUTINES [CONSTANT_AS]
			-- Routines that ought to be in SPECIAL [CONSTANT_AS]

	yyvs45: SPECIAL [CONVERT_FEAT_AS]
			-- Stack for semantic values of type CONVERT_FEAT_AS

	yyvsc45: INTEGER
			-- Capacity of semantic value stack `yyvs45'

	yyvsp45: INTEGER
			-- Top of semantic value stack `yyvs45'

	yyspecial_routines45: KL_SPECIAL_ROUTINES [CONVERT_FEAT_AS]
			-- Routines that ought to be in SPECIAL [CONVERT_FEAT_AS]

	yyvs46: SPECIAL [CREATE_AS]
			-- Stack for semantic values of type CREATE_AS

	yyvsc46: INTEGER
			-- Capacity of semantic value stack `yyvs46'

	yyvsp46: INTEGER
			-- Top of semantic value stack `yyvs46'

	yyspecial_routines46: KL_SPECIAL_ROUTINES [CREATE_AS]
			-- Routines that ought to be in SPECIAL [CREATE_AS]

	yyvs47: SPECIAL [CREATION_AS]
			-- Stack for semantic values of type CREATION_AS

	yyvsc47: INTEGER
			-- Capacity of semantic value stack `yyvs47'

	yyvsp47: INTEGER
			-- Top of semantic value stack `yyvs47'

	yyspecial_routines47: KL_SPECIAL_ROUTINES [CREATION_AS]
			-- Routines that ought to be in SPECIAL [CREATION_AS]

	yyvs48: SPECIAL [CREATION_EXPR_AS]
			-- Stack for semantic values of type CREATION_EXPR_AS

	yyvsc48: INTEGER
			-- Capacity of semantic value stack `yyvs48'

	yyvsp48: INTEGER
			-- Top of semantic value stack `yyvs48'

	yyspecial_routines48: KL_SPECIAL_ROUTINES [CREATION_EXPR_AS]
			-- Routines that ought to be in SPECIAL [CREATION_EXPR_AS]

	yyvs49: SPECIAL [DEBUG_AS]
			-- Stack for semantic values of type DEBUG_AS

	yyvsc49: INTEGER
			-- Capacity of semantic value stack `yyvs49'

	yyvsp49: INTEGER
			-- Top of semantic value stack `yyvs49'

	yyspecial_routines49: KL_SPECIAL_ROUTINES [DEBUG_AS]
			-- Routines that ought to be in SPECIAL [DEBUG_AS]

	yyvs50: SPECIAL [ELSIF_AS]
			-- Stack for semantic values of type ELSIF_AS

	yyvsc50: INTEGER
			-- Capacity of semantic value stack `yyvs50'

	yyvsp50: INTEGER
			-- Top of semantic value stack `yyvs50'

	yyspecial_routines50: KL_SPECIAL_ROUTINES [ELSIF_AS]
			-- Routines that ought to be in SPECIAL [ELSIF_AS]

	yyvs51: SPECIAL [ENSURE_AS]
			-- Stack for semantic values of type ENSURE_AS

	yyvsc51: INTEGER
			-- Capacity of semantic value stack `yyvs51'

	yyvsp51: INTEGER
			-- Top of semantic value stack `yyvs51'

	yyspecial_routines51: KL_SPECIAL_ROUTINES [ENSURE_AS]
			-- Routines that ought to be in SPECIAL [ENSURE_AS]

	yyvs52: SPECIAL [EXPORT_ITEM_AS]
			-- Stack for semantic values of type EXPORT_ITEM_AS

	yyvsc52: INTEGER
			-- Capacity of semantic value stack `yyvs52'

	yyvsp52: INTEGER
			-- Top of semantic value stack `yyvs52'

	yyspecial_routines52: KL_SPECIAL_ROUTINES [EXPORT_ITEM_AS]
			-- Routines that ought to be in SPECIAL [EXPORT_ITEM_AS]

	yyvs53: SPECIAL [EXTERNAL_AS]
			-- Stack for semantic values of type EXTERNAL_AS

	yyvsc53: INTEGER
			-- Capacity of semantic value stack `yyvs53'

	yyvsp53: INTEGER
			-- Top of semantic value stack `yyvs53'

	yyspecial_routines53: KL_SPECIAL_ROUTINES [EXTERNAL_AS]
			-- Routines that ought to be in SPECIAL [EXTERNAL_AS]

	yyvs54: SPECIAL [EXTERNAL_LANG_AS]
			-- Stack for semantic values of type EXTERNAL_LANG_AS

	yyvsc54: INTEGER
			-- Capacity of semantic value stack `yyvs54'

	yyvsp54: INTEGER
			-- Top of semantic value stack `yyvs54'

	yyspecial_routines54: KL_SPECIAL_ROUTINES [EXTERNAL_LANG_AS]
			-- Routines that ought to be in SPECIAL [EXTERNAL_LANG_AS]

	yyvs55: SPECIAL [FEATURE_AS]
			-- Stack for semantic values of type FEATURE_AS

	yyvsc55: INTEGER
			-- Capacity of semantic value stack `yyvs55'

	yyvsp55: INTEGER
			-- Top of semantic value stack `yyvs55'

	yyspecial_routines55: KL_SPECIAL_ROUTINES [FEATURE_AS]
			-- Routines that ought to be in SPECIAL [FEATURE_AS]

	yyvs56: SPECIAL [FEATURE_CLAUSE_AS]
			-- Stack for semantic values of type FEATURE_CLAUSE_AS

	yyvsc56: INTEGER
			-- Capacity of semantic value stack `yyvs56'

	yyvsp56: INTEGER
			-- Top of semantic value stack `yyvs56'

	yyspecial_routines56: KL_SPECIAL_ROUTINES [FEATURE_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [FEATURE_CLAUSE_AS]

	yyvs57: SPECIAL [FEATURE_SET_AS]
			-- Stack for semantic values of type FEATURE_SET_AS

	yyvsc57: INTEGER
			-- Capacity of semantic value stack `yyvs57'

	yyvsp57: INTEGER
			-- Top of semantic value stack `yyvs57'

	yyspecial_routines57: KL_SPECIAL_ROUTINES [FEATURE_SET_AS]
			-- Routines that ought to be in SPECIAL [FEATURE_SET_AS]

	yyvs58: SPECIAL [FORMAL_AS]
			-- Stack for semantic values of type FORMAL_AS

	yyvsc58: INTEGER
			-- Capacity of semantic value stack `yyvs58'

	yyvsp58: INTEGER
			-- Top of semantic value stack `yyvs58'

	yyspecial_routines58: KL_SPECIAL_ROUTINES [FORMAL_AS]
			-- Routines that ought to be in SPECIAL [FORMAL_AS]

	yyvs59: SPECIAL [FORMAL_DEC_AS]
			-- Stack for semantic values of type FORMAL_DEC_AS

	yyvsc59: INTEGER
			-- Capacity of semantic value stack `yyvs59'

	yyvsp59: INTEGER
			-- Top of semantic value stack `yyvs59'

	yyspecial_routines59: KL_SPECIAL_ROUTINES [FORMAL_DEC_AS]
			-- Routines that ought to be in SPECIAL [FORMAL_DEC_AS]

	yyvs60: SPECIAL [GUARD_AS]
			-- Stack for semantic values of type GUARD_AS

	yyvsc60: INTEGER
			-- Capacity of semantic value stack `yyvs60'

	yyvsp60: INTEGER
			-- Top of semantic value stack `yyvs60'

	yyspecial_routines60: KL_SPECIAL_ROUTINES [GUARD_AS]
			-- Routines that ought to be in SPECIAL [GUARD_AS]

	yyvs61: SPECIAL [IF_AS]
			-- Stack for semantic values of type IF_AS

	yyvsc61: INTEGER
			-- Capacity of semantic value stack `yyvs61'

	yyvsp61: INTEGER
			-- Top of semantic value stack `yyvs61'

	yyspecial_routines61: KL_SPECIAL_ROUTINES [IF_AS]
			-- Routines that ought to be in SPECIAL [IF_AS]

	yyvs62: SPECIAL [INDEX_AS]
			-- Stack for semantic values of type INDEX_AS

	yyvsc62: INTEGER
			-- Capacity of semantic value stack `yyvs62'

	yyvsp62: INTEGER
			-- Top of semantic value stack `yyvs62'

	yyspecial_routines62: KL_SPECIAL_ROUTINES [INDEX_AS]
			-- Routines that ought to be in SPECIAL [INDEX_AS]

	yyvs63: SPECIAL [INSPECT_AS]
			-- Stack for semantic values of type INSPECT_AS

	yyvsc63: INTEGER
			-- Capacity of semantic value stack `yyvs63'

	yyvsp63: INTEGER
			-- Top of semantic value stack `yyvs63'

	yyspecial_routines63: KL_SPECIAL_ROUTINES [INSPECT_AS]
			-- Routines that ought to be in SPECIAL [INSPECT_AS]

	yyvs64: SPECIAL [INTEGER_AS]
			-- Stack for semantic values of type INTEGER_AS

	yyvsc64: INTEGER
			-- Capacity of semantic value stack `yyvs64'

	yyvsp64: INTEGER
			-- Top of semantic value stack `yyvs64'

	yyspecial_routines64: KL_SPECIAL_ROUTINES [INTEGER_AS]
			-- Routines that ought to be in SPECIAL [INTEGER_AS]

	yyvs65: SPECIAL [INTERNAL_AS]
			-- Stack for semantic values of type INTERNAL_AS

	yyvsc65: INTEGER
			-- Capacity of semantic value stack `yyvs65'

	yyvsp65: INTEGER
			-- Top of semantic value stack `yyvs65'

	yyspecial_routines65: KL_SPECIAL_ROUTINES [INTERNAL_AS]
			-- Routines that ought to be in SPECIAL [INTERNAL_AS]

	yyvs66: SPECIAL [INTERVAL_AS]
			-- Stack for semantic values of type INTERVAL_AS

	yyvsc66: INTEGER
			-- Capacity of semantic value stack `yyvs66'

	yyvsp66: INTEGER
			-- Top of semantic value stack `yyvs66'

	yyspecial_routines66: KL_SPECIAL_ROUTINES [INTERVAL_AS]
			-- Routines that ought to be in SPECIAL [INTERVAL_AS]

	yyvs67: SPECIAL [INVARIANT_AS]
			-- Stack for semantic values of type INVARIANT_AS

	yyvsc67: INTEGER
			-- Capacity of semantic value stack `yyvs67'

	yyvsp67: INTEGER
			-- Top of semantic value stack `yyvs67'

	yyspecial_routines67: KL_SPECIAL_ROUTINES [INVARIANT_AS]
			-- Routines that ought to be in SPECIAL [INVARIANT_AS]

	yyvs68: SPECIAL [LOOP_EXPR_AS]
			-- Stack for semantic values of type LOOP_EXPR_AS

	yyvsc68: INTEGER
			-- Capacity of semantic value stack `yyvs68'

	yyvsp68: INTEGER
			-- Top of semantic value stack `yyvs68'

	yyspecial_routines68: KL_SPECIAL_ROUTINES [LOOP_EXPR_AS]
			-- Routines that ought to be in SPECIAL [LOOP_EXPR_AS]

	yyvs69: SPECIAL [LOOP_AS]
			-- Stack for semantic values of type LOOP_AS

	yyvsc69: INTEGER
			-- Capacity of semantic value stack `yyvs69'

	yyvsp69: INTEGER
			-- Top of semantic value stack `yyvs69'

	yyspecial_routines69: KL_SPECIAL_ROUTINES [LOOP_AS]
			-- Routines that ought to be in SPECIAL [LOOP_AS]

	yyvs70: SPECIAL [NESTED_AS]
			-- Stack for semantic values of type NESTED_AS

	yyvsc70: INTEGER
			-- Capacity of semantic value stack `yyvs70'

	yyvsp70: INTEGER
			-- Top of semantic value stack `yyvs70'

	yyspecial_routines70: KL_SPECIAL_ROUTINES [NESTED_AS]
			-- Routines that ought to be in SPECIAL [NESTED_AS]

	yyvs71: SPECIAL [OPERAND_AS]
			-- Stack for semantic values of type OPERAND_AS

	yyvsc71: INTEGER
			-- Capacity of semantic value stack `yyvs71'

	yyvsp71: INTEGER
			-- Top of semantic value stack `yyvs71'

	yyspecial_routines71: KL_SPECIAL_ROUTINES [OPERAND_AS]
			-- Routines that ought to be in SPECIAL [OPERAND_AS]

	yyvs72: SPECIAL [PARENT_AS]
			-- Stack for semantic values of type PARENT_AS

	yyvsc72: INTEGER
			-- Capacity of semantic value stack `yyvs72'

	yyvsp72: INTEGER
			-- Top of semantic value stack `yyvs72'

	yyspecial_routines72: KL_SPECIAL_ROUTINES [PARENT_AS]
			-- Routines that ought to be in SPECIAL [PARENT_AS]

	yyvs73: SPECIAL [PRECURSOR_AS]
			-- Stack for semantic values of type PRECURSOR_AS

	yyvsc73: INTEGER
			-- Capacity of semantic value stack `yyvs73'

	yyvsp73: INTEGER
			-- Top of semantic value stack `yyvs73'

	yyspecial_routines73: KL_SPECIAL_ROUTINES [PRECURSOR_AS]
			-- Routines that ought to be in SPECIAL [PRECURSOR_AS]

	yyvs74: SPECIAL [STATIC_ACCESS_AS]
			-- Stack for semantic values of type STATIC_ACCESS_AS

	yyvsc74: INTEGER
			-- Capacity of semantic value stack `yyvs74'

	yyvsp74: INTEGER
			-- Top of semantic value stack `yyvs74'

	yyspecial_routines74: KL_SPECIAL_ROUTINES [STATIC_ACCESS_AS]
			-- Routines that ought to be in SPECIAL [STATIC_ACCESS_AS]

	yyvs75: SPECIAL [REAL_AS]
			-- Stack for semantic values of type REAL_AS

	yyvsc75: INTEGER
			-- Capacity of semantic value stack `yyvs75'

	yyvsp75: INTEGER
			-- Top of semantic value stack `yyvs75'

	yyspecial_routines75: KL_SPECIAL_ROUTINES [REAL_AS]
			-- Routines that ought to be in SPECIAL [REAL_AS]

	yyvs76: SPECIAL [RENAME_AS]
			-- Stack for semantic values of type RENAME_AS

	yyvsc76: INTEGER
			-- Capacity of semantic value stack `yyvs76'

	yyvsp76: INTEGER
			-- Top of semantic value stack `yyvs76'

	yyspecial_routines76: KL_SPECIAL_ROUTINES [RENAME_AS]
			-- Routines that ought to be in SPECIAL [RENAME_AS]

	yyvs77: SPECIAL [REQUIRE_AS]
			-- Stack for semantic values of type REQUIRE_AS

	yyvsc77: INTEGER
			-- Capacity of semantic value stack `yyvs77'

	yyvsp77: INTEGER
			-- Top of semantic value stack `yyvs77'

	yyspecial_routines77: KL_SPECIAL_ROUTINES [REQUIRE_AS]
			-- Routines that ought to be in SPECIAL [REQUIRE_AS]

	yyvs78: SPECIAL [REVERSE_AS]
			-- Stack for semantic values of type REVERSE_AS

	yyvsc78: INTEGER
			-- Capacity of semantic value stack `yyvs78'

	yyvsp78: INTEGER
			-- Top of semantic value stack `yyvs78'

	yyspecial_routines78: KL_SPECIAL_ROUTINES [REVERSE_AS]
			-- Routines that ought to be in SPECIAL [REVERSE_AS]

	yyvs79: SPECIAL [ROUT_BODY_AS]
			-- Stack for semantic values of type ROUT_BODY_AS

	yyvsc79: INTEGER
			-- Capacity of semantic value stack `yyvs79'

	yyvsp79: INTEGER
			-- Top of semantic value stack `yyvs79'

	yyspecial_routines79: KL_SPECIAL_ROUTINES [ROUT_BODY_AS]
			-- Routines that ought to be in SPECIAL [ROUT_BODY_AS]

	yyvs80: SPECIAL [ROUTINE_AS]
			-- Stack for semantic values of type ROUTINE_AS

	yyvsc80: INTEGER
			-- Capacity of semantic value stack `yyvs80'

	yyvsp80: INTEGER
			-- Top of semantic value stack `yyvs80'

	yyspecial_routines80: KL_SPECIAL_ROUTINES [ROUTINE_AS]
			-- Routines that ought to be in SPECIAL [ROUTINE_AS]

	yyvs81: SPECIAL [ROUTINE_CREATION_AS]
			-- Stack for semantic values of type ROUTINE_CREATION_AS

	yyvsc81: INTEGER
			-- Capacity of semantic value stack `yyvs81'

	yyvsp81: INTEGER
			-- Top of semantic value stack `yyvs81'

	yyspecial_routines81: KL_SPECIAL_ROUTINES [ROUTINE_CREATION_AS]
			-- Routines that ought to be in SPECIAL [ROUTINE_CREATION_AS]

	yyvs82: SPECIAL [TUPLE_AS]
			-- Stack for semantic values of type TUPLE_AS

	yyvsc82: INTEGER
			-- Capacity of semantic value stack `yyvs82'

	yyvsp82: INTEGER
			-- Top of semantic value stack `yyvs82'

	yyspecial_routines82: KL_SPECIAL_ROUTINES [TUPLE_AS]
			-- Routines that ought to be in SPECIAL [TUPLE_AS]

	yyvs83: SPECIAL [TYPE_AS]
			-- Stack for semantic values of type TYPE_AS

	yyvsc83: INTEGER
			-- Capacity of semantic value stack `yyvs83'

	yyvsp83: INTEGER
			-- Top of semantic value stack `yyvs83'

	yyspecial_routines83: KL_SPECIAL_ROUTINES [TYPE_AS]
			-- Routines that ought to be in SPECIAL [TYPE_AS]

	yyvs84: SPECIAL [QUALIFIED_ANCHORED_TYPE_AS]
			-- Stack for semantic values of type QUALIFIED_ANCHORED_TYPE_AS

	yyvsc84: INTEGER
			-- Capacity of semantic value stack `yyvs84'

	yyvsp84: INTEGER
			-- Top of semantic value stack `yyvs84'

	yyspecial_routines84: KL_SPECIAL_ROUTINES [QUALIFIED_ANCHORED_TYPE_AS]
			-- Routines that ought to be in SPECIAL [QUALIFIED_ANCHORED_TYPE_AS]

	yyvs85: SPECIAL [PAIR [SYMBOL_AS, TYPE_AS]]
			-- Stack for semantic values of type PAIR [SYMBOL_AS, TYPE_AS]

	yyvsc85: INTEGER
			-- Capacity of semantic value stack `yyvs85'

	yyvsp85: INTEGER
			-- Top of semantic value stack `yyvs85'

	yyspecial_routines85: KL_SPECIAL_ROUTINES [PAIR [SYMBOL_AS, TYPE_AS]]
			-- Routines that ought to be in SPECIAL [PAIR [SYMBOL_AS, TYPE_AS]]

	yyvs86: SPECIAL [CLASS_TYPE_AS]
			-- Stack for semantic values of type CLASS_TYPE_AS

	yyvsc86: INTEGER
			-- Capacity of semantic value stack `yyvs86'

	yyvsp86: INTEGER
			-- Top of semantic value stack `yyvs86'

	yyspecial_routines86: KL_SPECIAL_ROUTINES [CLASS_TYPE_AS]
			-- Routines that ought to be in SPECIAL [CLASS_TYPE_AS]

	yyvs87: SPECIAL [TYPE_DEC_AS]
			-- Stack for semantic values of type TYPE_DEC_AS

	yyvsc87: INTEGER
			-- Capacity of semantic value stack `yyvs87'

	yyvsp87: INTEGER
			-- Top of semantic value stack `yyvs87'

	yyspecial_routines87: KL_SPECIAL_ROUTINES [TYPE_DEC_AS]
			-- Routines that ought to be in SPECIAL [TYPE_DEC_AS]

	yyvs88: SPECIAL [VARIANT_AS]
			-- Stack for semantic values of type VARIANT_AS

	yyvsc88: INTEGER
			-- Capacity of semantic value stack `yyvs88'

	yyvsp88: INTEGER
			-- Top of semantic value stack `yyvs88'

	yyspecial_routines88: KL_SPECIAL_ROUTINES [VARIANT_AS]
			-- Routines that ought to be in SPECIAL [VARIANT_AS]

	yyvs89: SPECIAL [FEATURE_NAME]
			-- Stack for semantic values of type FEATURE_NAME

	yyvsc89: INTEGER
			-- Capacity of semantic value stack `yyvs89'

	yyvsp89: INTEGER
			-- Top of semantic value stack `yyvs89'

	yyspecial_routines89: KL_SPECIAL_ROUTINES [FEATURE_NAME]
			-- Routines that ought to be in SPECIAL [FEATURE_NAME]

	yyvs90: SPECIAL [EIFFEL_LIST [ATOMIC_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [ATOMIC_AS]

	yyvsc90: INTEGER
			-- Capacity of semantic value stack `yyvs90'

	yyvsp90: INTEGER
			-- Top of semantic value stack `yyvs90'

	yyspecial_routines90: KL_SPECIAL_ROUTINES [EIFFEL_LIST [ATOMIC_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [ATOMIC_AS]]

	yyvs91: SPECIAL [EIFFEL_LIST [CASE_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [CASE_AS]

	yyvsc91: INTEGER
			-- Capacity of semantic value stack `yyvs91'

	yyvsp91: INTEGER
			-- Top of semantic value stack `yyvs91'

	yyspecial_routines91: KL_SPECIAL_ROUTINES [EIFFEL_LIST [CASE_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [CASE_AS]]

	yyvs92: SPECIAL [CONVERT_FEAT_LIST_AS]
			-- Stack for semantic values of type CONVERT_FEAT_LIST_AS

	yyvsc92: INTEGER
			-- Capacity of semantic value stack `yyvs92'

	yyvsp92: INTEGER
			-- Top of semantic value stack `yyvs92'

	yyspecial_routines92: KL_SPECIAL_ROUTINES [CONVERT_FEAT_LIST_AS]
			-- Routines that ought to be in SPECIAL [CONVERT_FEAT_LIST_AS]

	yyvs93: SPECIAL [EIFFEL_LIST [CREATE_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [CREATE_AS]

	yyvsc93: INTEGER
			-- Capacity of semantic value stack `yyvs93'

	yyvsp93: INTEGER
			-- Top of semantic value stack `yyvs93'

	yyspecial_routines93: KL_SPECIAL_ROUTINES [EIFFEL_LIST [CREATE_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [CREATE_AS]]

	yyvs94: SPECIAL [EIFFEL_LIST [ELSIF_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [ELSIF_AS]

	yyvsc94: INTEGER
			-- Capacity of semantic value stack `yyvs94'

	yyvsp94: INTEGER
			-- Top of semantic value stack `yyvs94'

	yyspecial_routines94: KL_SPECIAL_ROUTINES [EIFFEL_LIST [ELSIF_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [ELSIF_AS]]

	yyvs95: SPECIAL [EIFFEL_LIST [EXPORT_ITEM_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [EXPORT_ITEM_AS]

	yyvsc95: INTEGER
			-- Capacity of semantic value stack `yyvs95'

	yyvsp95: INTEGER
			-- Top of semantic value stack `yyvs95'

	yyspecial_routines95: KL_SPECIAL_ROUTINES [EIFFEL_LIST [EXPORT_ITEM_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [EXPORT_ITEM_AS]]

	yyvs96: SPECIAL [EXPORT_CLAUSE_AS]
			-- Stack for semantic values of type EXPORT_CLAUSE_AS

	yyvsc96: INTEGER
			-- Capacity of semantic value stack `yyvs96'

	yyvsp96: INTEGER
			-- Top of semantic value stack `yyvs96'

	yyspecial_routines96: KL_SPECIAL_ROUTINES [EXPORT_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [EXPORT_CLAUSE_AS]

	yyvs97: SPECIAL [EIFFEL_LIST [EXPR_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [EXPR_AS]

	yyvsc97: INTEGER
			-- Capacity of semantic value stack `yyvs97'

	yyvsp97: INTEGER
			-- Top of semantic value stack `yyvs97'

	yyspecial_routines97: KL_SPECIAL_ROUTINES [EIFFEL_LIST [EXPR_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [EXPR_AS]]

	yyvs98: SPECIAL [PARAMETER_LIST_AS]
			-- Stack for semantic values of type PARAMETER_LIST_AS

	yyvsc98: INTEGER
			-- Capacity of semantic value stack `yyvs98'

	yyvsp98: INTEGER
			-- Top of semantic value stack `yyvs98'

	yyspecial_routines98: KL_SPECIAL_ROUTINES [PARAMETER_LIST_AS]
			-- Routines that ought to be in SPECIAL [PARAMETER_LIST_AS]

	yyvs99: SPECIAL [EIFFEL_LIST [FEATURE_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [FEATURE_AS]

	yyvsc99: INTEGER
			-- Capacity of semantic value stack `yyvs99'

	yyvsp99: INTEGER
			-- Top of semantic value stack `yyvs99'

	yyspecial_routines99: KL_SPECIAL_ROUTINES [EIFFEL_LIST [FEATURE_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [FEATURE_AS]]

	yyvs100: SPECIAL [EIFFEL_LIST [FEATURE_CLAUSE_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [FEATURE_CLAUSE_AS]

	yyvsc100: INTEGER
			-- Capacity of semantic value stack `yyvs100'

	yyvsp100: INTEGER
			-- Top of semantic value stack `yyvs100'

	yyspecial_routines100: KL_SPECIAL_ROUTINES [EIFFEL_LIST [FEATURE_CLAUSE_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [FEATURE_CLAUSE_AS]]

	yyvs101: SPECIAL [EIFFEL_LIST [FEATURE_NAME]]
			-- Stack for semantic values of type EIFFEL_LIST [FEATURE_NAME]

	yyvsc101: INTEGER
			-- Capacity of semantic value stack `yyvs101'

	yyvsp101: INTEGER
			-- Top of semantic value stack `yyvs101'

	yyspecial_routines101: KL_SPECIAL_ROUTINES [EIFFEL_LIST [FEATURE_NAME]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [FEATURE_NAME]]

	yyvs102: SPECIAL [CREATION_CONSTRAIN_TRIPLE]
			-- Stack for semantic values of type CREATION_CONSTRAIN_TRIPLE

	yyvsc102: INTEGER
			-- Capacity of semantic value stack `yyvs102'

	yyvsp102: INTEGER
			-- Top of semantic value stack `yyvs102'

	yyspecial_routines102: KL_SPECIAL_ROUTINES [CREATION_CONSTRAIN_TRIPLE]
			-- Routines that ought to be in SPECIAL [CREATION_CONSTRAIN_TRIPLE]

	yyvs103: SPECIAL [UNDEFINE_CLAUSE_AS]
			-- Stack for semantic values of type UNDEFINE_CLAUSE_AS

	yyvsc103: INTEGER
			-- Capacity of semantic value stack `yyvs103'

	yyvsp103: INTEGER
			-- Top of semantic value stack `yyvs103'

	yyspecial_routines103: KL_SPECIAL_ROUTINES [UNDEFINE_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [UNDEFINE_CLAUSE_AS]

	yyvs104: SPECIAL [REDEFINE_CLAUSE_AS]
			-- Stack for semantic values of type REDEFINE_CLAUSE_AS

	yyvsc104: INTEGER
			-- Capacity of semantic value stack `yyvs104'

	yyvsp104: INTEGER
			-- Top of semantic value stack `yyvs104'

	yyspecial_routines104: KL_SPECIAL_ROUTINES [REDEFINE_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [REDEFINE_CLAUSE_AS]

	yyvs105: SPECIAL [SELECT_CLAUSE_AS]
			-- Stack for semantic values of type SELECT_CLAUSE_AS

	yyvsc105: INTEGER
			-- Capacity of semantic value stack `yyvs105'

	yyvsp105: INTEGER
			-- Top of semantic value stack `yyvs105'

	yyspecial_routines105: KL_SPECIAL_ROUTINES [SELECT_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [SELECT_CLAUSE_AS]

	yyvs106: SPECIAL [PAIR [KEYWORD_AS, SELECT_CLAUSE_AS]]
			-- Stack for semantic values of type PAIR [KEYWORD_AS, SELECT_CLAUSE_AS]

	yyvsc106: INTEGER
			-- Capacity of semantic value stack `yyvs106'

	yyvsp106: INTEGER
			-- Top of semantic value stack `yyvs106'

	yyspecial_routines106: KL_SPECIAL_ROUTINES [PAIR [KEYWORD_AS, SELECT_CLAUSE_AS]]
			-- Routines that ought to be in SPECIAL [PAIR [KEYWORD_AS, SELECT_CLAUSE_AS]]

	yyvs107: SPECIAL [FORMAL_GENERIC_LIST_AS]
			-- Stack for semantic values of type FORMAL_GENERIC_LIST_AS

	yyvsc107: INTEGER
			-- Capacity of semantic value stack `yyvs107'

	yyvsp107: INTEGER
			-- Top of semantic value stack `yyvs107'

	yyspecial_routines107: KL_SPECIAL_ROUTINES [FORMAL_GENERIC_LIST_AS]
			-- Routines that ought to be in SPECIAL [FORMAL_GENERIC_LIST_AS]

	yyvs108: SPECIAL [CLASS_LIST_AS]
			-- Stack for semantic values of type CLASS_LIST_AS

	yyvsc108: INTEGER
			-- Capacity of semantic value stack `yyvs108'

	yyvsp108: INTEGER
			-- Top of semantic value stack `yyvs108'

	yyspecial_routines108: KL_SPECIAL_ROUTINES [CLASS_LIST_AS]
			-- Routines that ought to be in SPECIAL [CLASS_LIST_AS]

	yyvs109: SPECIAL [INDEXING_CLAUSE_AS]
			-- Stack for semantic values of type INDEXING_CLAUSE_AS

	yyvsc109: INTEGER
			-- Capacity of semantic value stack `yyvs109'

	yyvsp109: INTEGER
			-- Top of semantic value stack `yyvs109'

	yyspecial_routines109: KL_SPECIAL_ROUTINES [INDEXING_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [INDEXING_CLAUSE_AS]

	yyvs110: SPECIAL [ITERATION_AS]
			-- Stack for semantic values of type ITERATION_AS

	yyvsc110: INTEGER
			-- Capacity of semantic value stack `yyvs110'

	yyvsp110: INTEGER
			-- Top of semantic value stack `yyvs110'

	yyspecial_routines110: KL_SPECIAL_ROUTINES [ITERATION_AS]
			-- Routines that ought to be in SPECIAL [ITERATION_AS]

	yyvs111: SPECIAL [EIFFEL_LIST [INTERVAL_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [INTERVAL_AS]

	yyvsc111: INTEGER
			-- Capacity of semantic value stack `yyvs111'

	yyvsp111: INTEGER
			-- Top of semantic value stack `yyvs111'

	yyspecial_routines111: KL_SPECIAL_ROUTINES [EIFFEL_LIST [INTERVAL_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [INTERVAL_AS]]

	yyvs112: SPECIAL [EIFFEL_LIST [OPERAND_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [OPERAND_AS]

	yyvsc112: INTEGER
			-- Capacity of semantic value stack `yyvs112'

	yyvsp112: INTEGER
			-- Top of semantic value stack `yyvs112'

	yyspecial_routines112: KL_SPECIAL_ROUTINES [EIFFEL_LIST [OPERAND_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [OPERAND_AS]]

	yyvs113: SPECIAL [DELAYED_ACTUAL_LIST_AS]
			-- Stack for semantic values of type DELAYED_ACTUAL_LIST_AS

	yyvsc113: INTEGER
			-- Capacity of semantic value stack `yyvs113'

	yyvsp113: INTEGER
			-- Top of semantic value stack `yyvs113'

	yyspecial_routines113: KL_SPECIAL_ROUTINES [DELAYED_ACTUAL_LIST_AS]
			-- Routines that ought to be in SPECIAL [DELAYED_ACTUAL_LIST_AS]

	yyvs114: SPECIAL [PARENT_LIST_AS]
			-- Stack for semantic values of type PARENT_LIST_AS

	yyvsc114: INTEGER
			-- Capacity of semantic value stack `yyvs114'

	yyvsp114: INTEGER
			-- Top of semantic value stack `yyvs114'

	yyspecial_routines114: KL_SPECIAL_ROUTINES [PARENT_LIST_AS]
			-- Routines that ought to be in SPECIAL [PARENT_LIST_AS]

	yyvs115: SPECIAL [EIFFEL_LIST [RENAME_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [RENAME_AS]

	yyvsc115: INTEGER
			-- Capacity of semantic value stack `yyvs115'

	yyvsp115: INTEGER
			-- Top of semantic value stack `yyvs115'

	yyspecial_routines115: KL_SPECIAL_ROUTINES [EIFFEL_LIST [RENAME_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [RENAME_AS]]

	yyvs116: SPECIAL [RENAME_CLAUSE_AS]
			-- Stack for semantic values of type RENAME_CLAUSE_AS

	yyvsc116: INTEGER
			-- Capacity of semantic value stack `yyvs116'

	yyvsp116: INTEGER
			-- Top of semantic value stack `yyvs116'

	yyspecial_routines116: KL_SPECIAL_ROUTINES [RENAME_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [RENAME_CLAUSE_AS]

	yyvs117: SPECIAL [EIFFEL_LIST [STRING_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [STRING_AS]

	yyvsc117: INTEGER
			-- Capacity of semantic value stack `yyvs117'

	yyvsp117: INTEGER
			-- Top of semantic value stack `yyvs117'

	yyspecial_routines117: KL_SPECIAL_ROUTINES [EIFFEL_LIST [STRING_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [STRING_AS]]

	yyvs118: SPECIAL [KEY_LIST_AS]
			-- Stack for semantic values of type KEY_LIST_AS

	yyvsc118: INTEGER
			-- Capacity of semantic value stack `yyvs118'

	yyvsp118: INTEGER
			-- Top of semantic value stack `yyvs118'

	yyspecial_routines118: KL_SPECIAL_ROUTINES [KEY_LIST_AS]
			-- Routines that ought to be in SPECIAL [KEY_LIST_AS]

	yyvs119: SPECIAL [TYPE_LIST_AS]
			-- Stack for semantic values of type TYPE_LIST_AS

	yyvsc119: INTEGER
			-- Capacity of semantic value stack `yyvs119'

	yyvsp119: INTEGER
			-- Top of semantic value stack `yyvs119'

	yyspecial_routines119: KL_SPECIAL_ROUTINES [TYPE_LIST_AS]
			-- Routines that ought to be in SPECIAL [TYPE_LIST_AS]

	yyvs120: SPECIAL [TYPE_DEC_LIST_AS]
			-- Stack for semantic values of type TYPE_DEC_LIST_AS

	yyvsc120: INTEGER
			-- Capacity of semantic value stack `yyvs120'

	yyvsp120: INTEGER
			-- Top of semantic value stack `yyvs120'

	yyspecial_routines120: KL_SPECIAL_ROUTINES [TYPE_DEC_LIST_AS]
			-- Routines that ought to be in SPECIAL [TYPE_DEC_LIST_AS]

	yyvs121: SPECIAL [LOCAL_DEC_LIST_AS]
			-- Stack for semantic values of type LOCAL_DEC_LIST_AS

	yyvsc121: INTEGER
			-- Capacity of semantic value stack `yyvs121'

	yyvsp121: INTEGER
			-- Top of semantic value stack `yyvs121'

	yyspecial_routines121: KL_SPECIAL_ROUTINES [LOCAL_DEC_LIST_AS]
			-- Routines that ought to be in SPECIAL [LOCAL_DEC_LIST_AS]

	yyvs122: SPECIAL [FORMAL_ARGU_DEC_LIST_AS]
			-- Stack for semantic values of type FORMAL_ARGU_DEC_LIST_AS

	yyvsc122: INTEGER
			-- Capacity of semantic value stack `yyvs122'

	yyvsp122: INTEGER
			-- Top of semantic value stack `yyvs122'

	yyspecial_routines122: KL_SPECIAL_ROUTINES [FORMAL_ARGU_DEC_LIST_AS]
			-- Routines that ought to be in SPECIAL [FORMAL_ARGU_DEC_LIST_AS]

	yyvs123: SPECIAL [CONSTRAINT_TRIPLE]
			-- Stack for semantic values of type CONSTRAINT_TRIPLE

	yyvsc123: INTEGER
			-- Capacity of semantic value stack `yyvs123'

	yyvsp123: INTEGER
			-- Top of semantic value stack `yyvs123'

	yyspecial_routines123: KL_SPECIAL_ROUTINES [CONSTRAINT_TRIPLE]
			-- Routines that ought to be in SPECIAL [CONSTRAINT_TRIPLE]

	yyvs124: SPECIAL [CONSTRAINT_LIST_AS]
			-- Stack for semantic values of type CONSTRAINT_LIST_AS

	yyvsc124: INTEGER
			-- Capacity of semantic value stack `yyvs124'

	yyvsp124: INTEGER
			-- Top of semantic value stack `yyvs124'

	yyspecial_routines124: KL_SPECIAL_ROUTINES [CONSTRAINT_LIST_AS]
			-- Routines that ought to be in SPECIAL [CONSTRAINT_LIST_AS]

	yyvs125: SPECIAL [CONSTRAINING_TYPE_AS]
			-- Stack for semantic values of type CONSTRAINING_TYPE_AS

	yyvsc125: INTEGER
			-- Capacity of semantic value stack `yyvs125'

	yyvsp125: INTEGER
			-- Top of semantic value stack `yyvs125'

	yyspecial_routines125: KL_SPECIAL_ROUTINES [CONSTRAINING_TYPE_AS]
			-- Routines that ought to be in SPECIAL [CONSTRAINING_TYPE_AS]

feature {NONE} -- Constants

	yyFinal: INTEGER = 1098
			-- Termination state id

	yyFlag: INTEGER = -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER = 140
			-- Number of tokens

	yyLast: INTEGER = 4433
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER = 394
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER = 379
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



note
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_PARSER

