indexing

	description: "Lace parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class LACE_PARSER

inherit

	LACE_PARSER_SKELETON

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
--|#line 73
	yy_do_action_1
when 2 then
--|#line 75
	yy_do_action_2
when 3 then
--|#line 79
	yy_do_action_3
when 4 then
--|#line 83
	yy_do_action_4
when 5 then
--|#line 87
	yy_do_action_5
when 6 then
--|#line 91
	yy_do_action_6
when 8 then
--|#line 97
	yy_do_action_8
when 10 then
--|#line 103
	yy_do_action_10
when 12 then
--|#line 109
	yy_do_action_12
when 14 then
--|#line 115
	yy_do_action_14
when 15 then
--|#line 120
	yy_do_action_15
when 16 then
--|#line 127
	yy_do_action_16
when 17 then
--|#line 129
	yy_do_action_17
when 18 then
--|#line 131
	yy_do_action_18
when 19 then
--|#line 133
	yy_do_action_19
when 21 then
--|#line 139
	yy_do_action_21
when 22 then
--|#line 144
	yy_do_action_22
when 23 then
--|#line 146
	yy_do_action_23
when 24 then
--|#line 148
	yy_do_action_24
when 25 then
--|#line 150
	yy_do_action_25
when 26 then
--|#line 152
	yy_do_action_26
when 27 then
--|#line 154
	yy_do_action_27
when 28 then
--|#line 156
	yy_do_action_28
when 29 then
--|#line 160
	yy_do_action_29
when 31 then
--|#line 166
	yy_do_action_31
when 32 then
--|#line 170
	yy_do_action_32
when 35 then
--|#line 178
	yy_do_action_35
when 36 then
--|#line 182
	yy_do_action_36
when 38 then
--|#line 188
	yy_do_action_38
when 39 then
--|#line 193
	yy_do_action_39
when 40 then
--|#line 200
	yy_do_action_40
when 41 then
--|#line 205
	yy_do_action_41
when 42 then
--|#line 212
	yy_do_action_42
when 43 then
--|#line 217
	yy_do_action_43
when 45 then
--|#line 226
	yy_do_action_45
when 46 then
--|#line 230
	yy_do_action_46
when 48 then
--|#line 236
	yy_do_action_48
when 49 then
--|#line 241
	yy_do_action_49
when 50 then
--|#line 248
	yy_do_action_50
when 51 then
--|#line 250
	yy_do_action_51
when 52 then
--|#line 254
	yy_do_action_52
when 53 then
--|#line 259
	yy_do_action_53
when 54 then
--|#line 266
	yy_do_action_54
when 56 then
--|#line 272
	yy_do_action_56
when 57 then
--|#line 276
	yy_do_action_57
when 60 then
--|#line 284
	yy_do_action_60
when 61 then
--|#line 288
	yy_do_action_61
when 63 then
--|#line 294
	yy_do_action_63
when 64 then
--|#line 299
	yy_do_action_64
when 65 then
--|#line 306
	yy_do_action_65
when 66 then
--|#line 308
	yy_do_action_66
when 67 then
--|#line 310
	yy_do_action_67
when 68 then
--|#line 312
	yy_do_action_68
when 69 then
--|#line 316
	yy_do_action_69
when 70 then
--|#line 318
	yy_do_action_70
when 71 then
--|#line 320
	yy_do_action_71
when 72 then
--|#line 322
	yy_do_action_72
when 73 then
--|#line 324
	yy_do_action_73
when 74 then
--|#line 328
	yy_do_action_74
when 75 then
--|#line 333
	yy_do_action_75
when 76 then
--|#line 340
	yy_do_action_76
when 78 then
--|#line 346
	yy_do_action_78
when 79 then
--|#line 350
	yy_do_action_79
when 80 then
--|#line 355
	yy_do_action_80
when 82 then
--|#line 364
	yy_do_action_82
when 83 then
--|#line 368
	yy_do_action_83
when 84 then
--|#line 370
	yy_do_action_84
when 85 then
--|#line 372
	yy_do_action_85
when 86 then
--|#line 376
	yy_do_action_86
when 87 then
--|#line 378
	yy_do_action_87
when 88 then
--|#line 380
	yy_do_action_88
when 89 then
--|#line 384
	yy_do_action_89
when 90 then
--|#line 386
	yy_do_action_90
when 91 then
--|#line 388
	yy_do_action_91
when 92 then
--|#line 390
	yy_do_action_92
when 93 then
--|#line 392
	yy_do_action_93
when 95 then
--|#line 398
	yy_do_action_95
when 97 then
--|#line 404
	yy_do_action_97
when 98 then
--|#line 409
	yy_do_action_98
when 99 then
--|#line 416
	yy_do_action_99
when 100 then
--|#line 420
	yy_do_action_100
when 101 then
--|#line 422
	yy_do_action_101
when 102 then
--|#line 424
	yy_do_action_102
when 103 then
--|#line 426
	yy_do_action_103
when 104 then
--|#line 428
	yy_do_action_104
when 105 then
--|#line 430
	yy_do_action_105
when 107 then
--|#line 436
	yy_do_action_107
when 109 then
--|#line 442
	yy_do_action_109
when 110 then
--|#line 447
	yy_do_action_110
when 111 then
--|#line 454
	yy_do_action_111
when 113 then
--|#line 460
	yy_do_action_113
when 114 then
--|#line 464
	yy_do_action_114
when 115 then
--|#line 466
	yy_do_action_115
when 117 then
--|#line 472
	yy_do_action_117
when 118 then
--|#line 476
	yy_do_action_118
when 120 then
--|#line 482
	yy_do_action_120
when 121 then
--|#line 487
	yy_do_action_121
when 122 then
--|#line 494
	yy_do_action_122
when 123 then
--|#line 496
	yy_do_action_123
when 124 then
--|#line 498
	yy_do_action_124
when 125 then
--|#line 500
	yy_do_action_125
when 126 then
--|#line 502
	yy_do_action_126
when 127 then
--|#line 504
	yy_do_action_127
when 128 then
--|#line 508
	yy_do_action_128
when 130 then
--|#line 514
	yy_do_action_130
when 131 then
--|#line 518
	yy_do_action_131
when 133 then
--|#line 524
	yy_do_action_133
when 134 then
--|#line 528
	yy_do_action_134
when 136 then
--|#line 534
	yy_do_action_136
when 137 then
--|#line 539
	yy_do_action_137
when 139 then
--|#line 548
	yy_do_action_139
when 140 then
--|#line 552
	yy_do_action_140
when 141 then
--|#line 556
	yy_do_action_141
when 142 then
--|#line 561
	yy_do_action_142
when 144 then
--|#line 570
	yy_do_action_144
when 145 then
--|#line 574
	yy_do_action_145
when 146 then
--|#line 576
	yy_do_action_146
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 73
		local

		do
			yyval := yyval_default;
ast := yytype1 (yyvs.item (yyvsp)) 

		end

	yy_do_action_2 is
			--|#line 75
		local

		do
			yyval := yyval_default;
ast := yytype3 (yyvs.item (yyvsp)) 

		end

	yy_do_action_3 is
			--|#line 79
		local
			yyval1: ACE_SD
		do

yyval1 := new_ace_sd (yytype7 (yyvs.item (yyvsp - 6)), yytype14 (yyvs.item (yyvsp - 5)), yytype20 (yyvs.item (yyvsp - 4)), yytype19 (yyvs.item (yyvsp - 3)), yytype27 (yyvs.item (yyvsp - 2)), yytype26 (yyvs.item (yyvsp - 1)), click_list) 
			yyval := yyval1
		end

	yy_do_action_4 is
			--|#line 83
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
		end

	yy_do_action_5 is
			--|#line 87
		local
			yyval14: ROOT_SD
		do

yyval14 := new_root (yytype31 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval14
		end

	yy_do_action_6 is
			--|#line 91
		local
			yyval31: PAIR [ID_SD, CLICK_AST]
		do

yyval31 := new_clickable_id (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval31
		end

	yy_do_action_8 is
			--|#line 97
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp - 1)) 
			yyval := yyval7
		end

	yy_do_action_10 is
			--|#line 103
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
		end

	yy_do_action_12 is
			--|#line 109
		local
			yyval19: LACE_LIST [CLUSTER_SD]
		do

yyval19 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval19
		end

	yy_do_action_14 is
			--|#line 115
		local
			yyval19: LACE_LIST [CLUSTER_SD]
		do

				yyval19 := new_lace_list_cluster_sd (10)
				yyval19.extend (yytype5 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval19
		end

	yy_do_action_15 is
			--|#line 120
		local
			yyval19: LACE_LIST [CLUSTER_SD]
		do

				yyval19 := yytype19 (yyvs.item (yyvsp - 2))
				yyval19.extend (yytype5 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval19
		end

	yy_do_action_16 is
			--|#line 127
		local
			yyval5: CLUSTER_SD
		do

yyval5 := new_cluster_sd (yytype7 (yyvs.item (yyvsp - 3)), yytype7 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp)), Void, False) 
			yyval := yyval5
		end

	yy_do_action_17 is
			--|#line 129
		local
			yyval5: CLUSTER_SD
		do

yyval5 := new_cluster_sd (yytype7 (yyvs.item (yyvsp - 3)), yytype7 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp)), Void, True) 
			yyval := yyval5
		end

	yy_do_action_18 is
			--|#line 131
		local
			yyval5: CLUSTER_SD
		do

yyval5 := new_cluster_sd (yytype7 (yyvs.item (yyvsp - 5)), yytype7 (yyvs.item (yyvsp - 4)), yytype7 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), False) 
			yyval := yyval5
		end

	yy_do_action_19 is
			--|#line 133
		local
			yyval5: CLUSTER_SD
		do

yyval5 := new_cluster_sd (yytype7 (yyvs.item (yyvsp - 5)), yytype7 (yyvs.item (yyvsp - 4)), yytype7 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), True) 
			yyval := yyval5
		end

	yy_do_action_21 is
			--|#line 139
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp - 1)) 
			yyval := yyval7
		end

	yy_do_action_22 is
			--|#line 144
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (yytype7 (yyvs.item (yyvsp - 6)), yytype25 (yyvs.item (yyvsp - 5)), yytype22 (yyvs.item (yyvsp - 4)), yytype18 (yyvs.item (yyvsp - 3)), yytype20 (yyvs.item (yyvsp - 2)), yytype28 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_23 is
			--|#line 146
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, yytype25 (yyvs.item (yyvsp - 5)), yytype22 (yyvs.item (yyvsp - 4)), yytype18 (yyvs.item (yyvsp - 3)), yytype20 (yyvs.item (yyvsp - 2)), yytype28 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_24 is
			--|#line 148
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, yytype22 (yyvs.item (yyvsp - 4)), yytype18 (yyvs.item (yyvsp - 3)), yytype20 (yyvs.item (yyvsp - 2)), yytype28 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_25 is
			--|#line 150
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, Void, yytype18 (yyvs.item (yyvsp - 3)), yytype20 (yyvs.item (yyvsp - 2)), yytype28 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_26 is
			--|#line 152
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, Void, Void, yytype20 (yyvs.item (yyvsp - 2)), yytype28 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_27 is
			--|#line 154
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, Void, Void, Void, yytype28 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_28 is
			--|#line 156
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, Void, Void, Void, Void, yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_29 is
			--|#line 160
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
		end

	yy_do_action_31 is
			--|#line 166
		local
			yyval25: LACE_LIST [INCLUDE_SD]
		do

yyval25 := yytype25 (yyvs.item (yyvsp)) 
			yyval := yyval25
		end

	yy_do_action_32 is
			--|#line 170
		local
			yyval25: LACE_LIST [INCLUDE_SD]
		do

yyval25 := yytype25 (yyvs.item (yyvsp)) 
			yyval := yyval25
		end

	yy_do_action_35 is
			--|#line 178
		local
			yyval22: LACE_LIST [EXCLUDE_SD]
		do

yyval22 := yytype22 (yyvs.item (yyvsp)) 
			yyval := yyval22
		end

	yy_do_action_36 is
			--|#line 182
		local
			yyval22: LACE_LIST [EXCLUDE_SD]
		do

yyval22 := yytype22 (yyvs.item (yyvsp)) 
			yyval := yyval22
		end

	yy_do_action_38 is
			--|#line 188
		local
			yyval25: LACE_LIST [INCLUDE_SD]
		do

				yyval25 := new_lace_list_include_sd (10)
				yyval25.extend (new_include_sd (yytype7 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval25
		end

	yy_do_action_39 is
			--|#line 193
		local
			yyval25: LACE_LIST [INCLUDE_SD]
		do

				yyval25 := yytype25 (yyvs.item (yyvsp - 2))
				yyval25.extend (new_include_sd (yytype7 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval25
		end

	yy_do_action_40 is
			--|#line 200
		local
			yyval22: LACE_LIST [EXCLUDE_SD]
		do

				yyval22 := new_lace_list_exclude_sd (10)
				yyval22.extend (new_exclude_sd (yytype7 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval22
		end

	yy_do_action_41 is
			--|#line 205
		local
			yyval22: LACE_LIST [EXCLUDE_SD]
		do

				yyval22 := yytype22 (yyvs.item (yyvsp - 2))
				yyval22.extend (new_exclude_sd (yytype7 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval22
		end

	yy_do_action_42 is
			--|#line 212
		local
			yyval23: LACE_LIST [ID_SD]
		do

				yyval23 := new_lace_list_id_sd (10)
				yyval23.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_43 is
			--|#line 217
		local
			yyval23: LACE_LIST [ID_SD]
		do

				yyval23 := yytype23 (yyvs.item (yyvsp - 2))
				yyval23.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_45 is
			--|#line 226
		local
			yyval18: LACE_LIST [CLUST_ADAPT_SD]
		do

yyval18 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval18
		end

	yy_do_action_46 is
			--|#line 230
		local
			yyval18: LACE_LIST [CLUST_ADAPT_SD]
		do

yyval18 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval18
		end

	yy_do_action_48 is
			--|#line 236
		local
			yyval18: LACE_LIST [CLUST_ADAPT_SD]
		do

				yyval18 := new_lace_list_clust_adapt_sd (10)
				yyval18.extend (yytype4 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval18
		end

	yy_do_action_49 is
			--|#line 241
		local
			yyval18: LACE_LIST [CLUST_ADAPT_SD]
		do

				yyval18 := yytype18 (yyvs.item (yyvsp - 2))
				yyval18.extend (yytype4 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval18
		end

	yy_do_action_50 is
			--|#line 248
		local
			yyval4: CLUST_ADAPT_SD
		do

yyval4 := new_clust_ign_sd (yytype7 (yyvs.item (yyvsp - 2))) 
			yyval := yyval4
		end

	yy_do_action_51 is
			--|#line 250
		local
			yyval4: CLUST_ADAPT_SD
		do

yyval4 := new_clust_ren_sd (yytype7 (yyvs.item (yyvsp - 3)), yytype29 (yyvs.item (yyvsp))) 
			yyval := yyval4
		end

	yy_do_action_52 is
			--|#line 254
		local
			yyval29: LACE_LIST [TWO_NAME_SD]
		do

				yyval29 := new_lace_list_two_name_sd (10)
				yyval29.extend (yytype15 (yyvs.item (yyvsp)))
			
			yyval := yyval29
		end

	yy_do_action_53 is
			--|#line 259
		local
			yyval29: LACE_LIST [TWO_NAME_SD]
		do

				yyval29 := yytype29 (yyvs.item (yyvsp - 2))
				yyval29.extend (yytype15 (yyvs.item (yyvsp)))
			
			yyval := yyval29
		end

	yy_do_action_54 is
			--|#line 266
		local
			yyval15: TWO_NAME_SD
		do

yyval15 := new_two_name_sd (yytype7 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval15
		end

	yy_do_action_56 is
			--|#line 272
		local
			yyval20: LACE_LIST [D_OPTION_SD]
		do

yyval20 := yytype20 (yyvs.item (yyvsp)) 
			yyval := yyval20
		end

	yy_do_action_57 is
			--|#line 276
		local
			yyval20: LACE_LIST [D_OPTION_SD]
		do

yyval20 := yytype20 (yyvs.item (yyvsp)) 
			yyval := yyval20
		end

	yy_do_action_60 is
			--|#line 284
		local
			yyval28: LACE_LIST [O_OPTION_SD]
		do

yyval28 := yytype28 (yyvs.item (yyvsp)) 
			yyval := yyval28
		end

	yy_do_action_61 is
			--|#line 288
		local
			yyval28: LACE_LIST [O_OPTION_SD]
		do

yyval28 := yytype28 (yyvs.item (yyvsp)) 
			yyval := yyval28
		end

	yy_do_action_63 is
			--|#line 294
		local
			yyval20: LACE_LIST [D_OPTION_SD]
		do

				yyval20 := new_lace_list_d_option_sd (10)
				yyval20.extend (yytype6 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval20
		end

	yy_do_action_64 is
			--|#line 299
		local
			yyval20: LACE_LIST [D_OPTION_SD]
		do

				yyval20 := yytype20 (yyvs.item (yyvsp - 2))
				yyval20.extend (yytype6 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval20
		end

	yy_do_action_65 is
			--|#line 306
		local
			yyval6: D_OPTION_SD
		do

yyval6 := new_d_precompiled_sd (Precompiled_keyword, yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval6
		end

	yy_do_action_66 is
			--|#line 308
		local
			yyval6: D_OPTION_SD
		do

yyval6 := new_d_precompiled_sd (Precompiled_keyword, yytype12 (yyvs.item (yyvsp - 1)), Void) 
			yyval := yyval6
		end

	yy_do_action_67 is
			--|#line 310
		local
			yyval6: D_OPTION_SD
		do

yyval6 := new_d_precompiled_sd (Precompiled_keyword, yytype12 (yyvs.item (yyvsp - 2)), yytype29 (yyvs.item (yyvsp - 1))) 
			yyval := yyval6
		end

	yy_do_action_68 is
			--|#line 312
		local
			yyval6: D_OPTION_SD
		do

yyval6 := new_d_option_sd (yytype13 (yyvs.item (yyvsp - 1)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval6
		end

	yy_do_action_69 is
			--|#line 316
		local
			yyval13: OPTION_SD
		do

yyval13 := Assertion_keyword 
			yyval := yyval13
		end

	yy_do_action_70 is
			--|#line 318
		local
			yyval13: OPTION_SD
		do

yyval13 := Debug_keyword 
			yyval := yyval13
		end

	yy_do_action_71 is
			--|#line 320
		local
			yyval13: OPTION_SD
		do

yyval13 := Optimize_keyword 
			yyval := yyval13
		end

	yy_do_action_72 is
			--|#line 322
		local
			yyval13: OPTION_SD
		do

yyval13 := Trace_keyword 
			yyval := yyval13
		end

	yy_do_action_73 is
			--|#line 324
		local
			yyval13: OPTION_SD
		do

yyval13 := new_free_option_sd (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval13
		end

	yy_do_action_74 is
			--|#line 328
		local
			yyval28: LACE_LIST [O_OPTION_SD]
		do

				yyval28 := new_lace_list_o_option_sd (10)
				yyval28.extend (yytype11 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval28
		end

	yy_do_action_75 is
			--|#line 333
		local
			yyval28: LACE_LIST [O_OPTION_SD]
		do

				yyval28 := yytype28 (yyvs.item (yyvsp - 2))
				yyval28.extend (yytype11 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval28
		end

	yy_do_action_76 is
			--|#line 340
		local
			yyval11: O_OPTION_SD
		do

yyval11 := new_o_option_sd (yytype13 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval11
		end

	yy_do_action_78 is
			--|#line 346
		local
			yyval23: LACE_LIST [ID_SD]
		do

yyval23 := yytype23 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_79 is
			--|#line 350
		local
			yyval23: LACE_LIST [ID_SD]
		do

				yyval23 := new_lace_list_id_sd (10)
				yyval23.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_80 is
			--|#line 355
		local
			yyval23: LACE_LIST [ID_SD]
		do

				yyval23 := yytype23 (yyvs.item (yyvsp - 2))
				yyval23.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_82 is
			--|#line 364
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := yytype12 (yyvs.item (yyvsp - 1)) 
			yyval := yyval12
		end

	yy_do_action_83 is
			--|#line 368
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval12
		end

	yy_do_action_84 is
			--|#line 370
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval12
		end

	yy_do_action_85 is
			--|#line 372
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := new_name_sd (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval12
		end

	yy_do_action_86 is
			--|#line 376
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Yes_keyword 
			yyval := yyval12
		end

	yy_do_action_87 is
			--|#line 378
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := No_keyword 
			yyval := yyval12
		end

	yy_do_action_88 is
			--|#line 380
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := All_keyword 
			yyval := yyval12
		end

	yy_do_action_89 is
			--|#line 384
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Require_keyword 
			yyval := yyval12
		end

	yy_do_action_90 is
			--|#line 386
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Ensure_keyword 
			yyval := yyval12
		end

	yy_do_action_91 is
			--|#line 388
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Invariant_keyword 
			yyval := yyval12
		end

	yy_do_action_92 is
			--|#line 390
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Loop_keyword 
			yyval := yyval12
		end

	yy_do_action_93 is
			--|#line 392
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Check_keyword 
			yyval := yyval12
		end

	yy_do_action_95 is
			--|#line 398
		local
			yyval27: LACE_LIST [LANG_TRIB_SD]
		do

yyval27 := yytype27 (yyvs.item (yyvsp)) 
			yyval := yyval27
		end

	yy_do_action_97 is
			--|#line 404
		local
			yyval27: LACE_LIST [LANG_TRIB_SD]
		do

				yyval27 := new_lace_list_lang_trib_sd (10)
				yyval27.extend (yytype9 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval27
		end

	yy_do_action_98 is
			--|#line 409
		local
			yyval27: LACE_LIST [LANG_TRIB_SD]
		do

				yyval27 := yytype27 (yyvs.item (yyvsp - 2))
				yyval27.extend (yytype9 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval27
		end

	yy_do_action_99 is
			--|#line 416
		local
			yyval9: LANG_TRIB_SD
		do

yyval9 := new_lang_trib_sd (yytype10 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval9
		end

	yy_do_action_100 is
			--|#line 420
		local
			yyval10: LANGUAGE_NAME_SD
		do

yyval10 := C_keyword 
			yyval := yyval10
		end

	yy_do_action_101 is
			--|#line 422
		local
			yyval10: LANGUAGE_NAME_SD
		do

yyval10 := Include_path_keyword 
			yyval := yyval10
		end

	yy_do_action_102 is
			--|#line 424
		local
			yyval10: LANGUAGE_NAME_SD
		do

yyval10 := Make_keyword 
			yyval := yyval10
		end

	yy_do_action_103 is
			--|#line 426
		local
			yyval10: LANGUAGE_NAME_SD
		do

yyval10 := Object_keyword 
			yyval := yyval10
		end

	yy_do_action_104 is
			--|#line 428
		local
			yyval10: LANGUAGE_NAME_SD
		do

yyval10 := Executable_keyword 
			yyval := yyval10
		end

	yy_do_action_105 is
			--|#line 430
		local
			yyval10: LANGUAGE_NAME_SD
		do

yyval10 := new_language_name_sd (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval10
		end

	yy_do_action_107 is
			--|#line 436
		local
			yyval26: LACE_LIST [LANG_GEN_SD]
		do

yyval26 := yytype26 (yyvs.item (yyvsp)) 
			yyval := yyval26
		end

	yy_do_action_109 is
			--|#line 442
		local
			yyval26: LACE_LIST [LANG_GEN_SD]
		do

				yyval26 := new_lace_list_lang_gen_sd (10)
				yyval26.extend (yytype8 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval26
		end

	yy_do_action_110 is
			--|#line 447
		local
			yyval26: LACE_LIST [LANG_GEN_SD]
		do

				yyval26 := yytype26 (yyvs.item (yyvsp - 2))
				yyval26.extend (yytype8 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval26
		end

	yy_do_action_111 is
			--|#line 454
		local
			yyval8: LANG_GEN_SD
		do

yyval8 := new_lang_gen_sd (yytype10 (yyvs.item (yyvsp - 3)), yytype16 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval8
		end

	yy_do_action_113 is
			--|#line 460
		local
			yyval16: YES_OR_NO_SD
		do

yyval16 := yytype16 (yyvs.item (yyvsp - 1)) 
			yyval := yyval16
		end

	yy_do_action_114 is
			--|#line 464
		local
			yyval16: YES_OR_NO_SD
		do

yyval16 := Yes_keyword 
			yyval := yyval16
		end

	yy_do_action_115 is
			--|#line 466
		local
			yyval16: YES_OR_NO_SD
		do

yyval16 := No_keyword 
			yyval := yyval16
		end

	yy_do_action_117 is
			--|#line 472
		local
			yyval17: LACE_LIST [CLAS_VISI_SD]
		do

yyval17 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval17
		end

	yy_do_action_118 is
			--|#line 476
		local
			yyval17: LACE_LIST [CLAS_VISI_SD]
		do

yyval17 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval17
		end

	yy_do_action_120 is
			--|#line 482
		local
			yyval17: LACE_LIST [CLAS_VISI_SD]
		do

				yyval17 := new_lace_list_clas_visi_sd (10)
				yyval17.extend (yytype2 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval17
		end

	yy_do_action_121 is
			--|#line 487
		local
			yyval17: LACE_LIST [CLAS_VISI_SD]
		do

				yyval17 := yytype17 (yyvs.item (yyvsp - 2))
				yyval17.extend (yytype2 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval17
		end

	yy_do_action_122 is
			--|#line 494
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp)), Void, Void, Void, Void) 
			yyval := yyval2
		end

	yy_do_action_123 is
			--|#line 496
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 5)), yytype7 (yyvs.item (yyvsp - 4)), yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp - 2)), yytype29 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_124 is
			--|#line 498
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 4)), Void, yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp - 2)), yytype29 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_125 is
			--|#line 500
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 3)), Void, Void, yytype23 (yyvs.item (yyvsp - 2)), yytype29 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_126 is
			--|#line 502
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 2)), Void, Void, Void, yytype29 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_127 is
			--|#line 504
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void) 
			yyval := yyval2
		end

	yy_do_action_128 is
			--|#line 508
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
		end

	yy_do_action_130 is
			--|#line 514
		local
			yyval23: LACE_LIST [ID_SD]
		do

yyval23 := yytype23 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_131 is
			--|#line 518
		local
			yyval23: LACE_LIST [ID_SD]
		do

yyval23 := yytype23 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_133 is
			--|#line 524
		local
			yyval23: LACE_LIST [ID_SD]
		do

yyval23 := yytype23 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_134 is
			--|#line 528
		local
			yyval23: LACE_LIST [ID_SD]
		do

yyval23 := yytype23 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_136 is
			--|#line 534
		local
			yyval23: LACE_LIST [ID_SD]
		do

				yyval23 := new_lace_list_id_sd (10)
				yyval23.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_137 is
			--|#line 539
		local
			yyval23: LACE_LIST [ID_SD]
		do

				yyval23 := yytype23 (yyvs.item (yyvsp - 2))
				yyval23.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_139 is
			--|#line 548
		local
			yyval29: LACE_LIST [TWO_NAME_SD]
		do

yyval29 := yytype29 (yyvs.item (yyvsp)) 
			yyval := yyval29
		end

	yy_do_action_140 is
			--|#line 552
		local
			yyval29: LACE_LIST [TWO_NAME_SD]
		do

yyval29 := yytype29 (yyvs.item (yyvsp)) 
			yyval := yyval29
		end

	yy_do_action_141 is
			--|#line 556
		local
			yyval29: LACE_LIST [TWO_NAME_SD]
		do

				yyval29 := new_lace_list_two_name_sd (10)
				yyval29.extend (yytype15 (yyvs.item (yyvsp)))
			
			yyval := yyval29
		end

	yy_do_action_142 is
			--|#line 561
		local
			yyval29: LACE_LIST [TWO_NAME_SD]
		do

				yyval29 := yytype29 (yyvs.item (yyvsp - 2))
				yyval29.extend (yytype15 (yyvs.item (yyvsp)))
			
			yyval := yyval29
		end

	yy_do_action_144 is
			--|#line 570
		local
			yyval15: TWO_NAME_SD
		do

yyval15 := new_two_name_sd (yytype7 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval15
		end

	yy_do_action_145 is
			--|#line 574
		local
			yyval7: ID_SD
		do

yyval7 := new_id_sd (token_buffer) 
			yyval := yyval7
		end

	yy_do_action_146 is
			--|#line 576
		local
			yyval7: ID_SD
		do

yyval7 := new_id_sd (token_buffer) 
			yyval := yyval7
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

			   45>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  110,  110,   46,   56,   68,  109,   57,   57,   58,
			   58,   79,   79,   79,   80,   80,   50,   50,   50,   50,
			   55,   55,   48,   48,   48,   48,   48,   48,   48,   54,
			   96,   96,   95,   95,   85,   85,   84,   84,   97,   97,
			   86,   86,   94,   94,   77,   77,   76,   76,   78,   78,
			   49,   49,  108,  108,   70,   83,   83,   82,   82,  104,
			  104,  103,  103,   81,   81,   51,   51,   51,   51,   67,
			   67,   67,   67,   67,  102,  102,   62,   92,   92,   93,
			   93,   63,   63,   64,   64,   64,   65,   65,   65,   66,
			   66,   66,   66,   66,  100,  100,  100,  101,  101,   60,

			   61,   61,   61,   61,   61,   61,   98,   98,   98,   99,
			   99,   59,   71,   71,   72,   72,   75,   75,   74,   74,
			   73,   73,   47,   47,   47,   47,   47,   47,   53,   91,
			   91,   90,   89,   89,   88,   87,   87,   87,  107,  107,
			  106,  105,  105,   69,   69,   52,   52,  111,  111>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,    1,    1,    7,    2,    4,    1,    0,    3,    0,
			    2,    0,    2,    2,    2,    3,    4,    5,    6,    7,
			    0,    3,    7,    6,    5,    4,    3,    2,    1,    2,
			    0,    1,    2,    2,    0,    1,    2,    2,    2,    3,
			    2,    3,    1,    3,    0,    1,    2,    2,    2,    3,
			    3,    4,    1,    3,    3,    0,    1,    2,    2,    0,
			    1,    2,    2,    2,    3,    2,    3,    4,    2,    1,
			    1,    1,    1,    1,    2,    3,    3,    0,    2,    1,
			    3,    0,    3,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    0,    2,    2,    2,    3,    3,

			    1,    1,    1,    1,    1,    1,    0,    2,    2,    2,
			    3,    4,    0,    3,    1,    1,    0,    1,    2,    2,
			    2,    3,    1,    6,    5,    4,    3,    2,    2,    0,
			    1,    2,    0,    1,    2,    0,    1,    3,    0,    1,
			    2,    1,    3,    0,    3,    1,    1,    0,    1>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  147,    0,    0,  147,  147,  147,  147,  147,    1,
			    2,   30,    0,   28,   55,   59,   44,   34,  116,  146,
			  148,  145,  147,  122,  118,  119,   29,    4,   72,   71,
			   70,   69,   73,  147,   81,   61,   62,  147,   32,   33,
			  147,   36,   37,   81,  147,   81,   57,   58,  147,    0,
			   46,   47,   31,   34,    0,   55,   56,   59,   60,  116,
			   45,   55,   35,   44,  117,   27,  120,  143,  135,  127,
			  135,    0,  129,  138,  132,    0,  147,   74,    0,   77,
			  147,   38,  147,   40,  147,   65,   63,   68,  147,   48,
			    0,  147,   44,    6,    7,   11,  116,   26,   59,   55,

			    0,  141,  140,  136,  134,  131,  128,  130,  132,  139,
			    0,  133,  138,  126,  121,   86,   89,   87,   92,   91,
			   90,   93,   88,   85,    0,   83,   84,    0,   76,   75,
			   39,   41,   66,    0,   64,    0,   50,   49,   55,    0,
			    9,  147,   94,   25,  116,   59,    0,  143,    0,  138,
			  125,    0,   82,   79,   78,   67,    0,   52,   51,   59,
			    0,    0,    5,    0,  147,   20,   12,   13,  147,  106,
			   24,  116,  144,  142,  137,    0,  124,    0,    0,    0,
			  116,    8,   10,   20,   14,    0,    0,  147,  103,  102,
			  101,  104,  100,  105,  147,    0,   95,   96,  147,    0,

			   23,  123,   80,   54,   53,   22,    0,    0,    0,   15,
			   97,    0,  147,  147,  112,  107,  108,    3,    0,   21,
			   16,   42,   99,   98,  109,    0,    0,  147,   17,    0,
			    0,  114,  115,    0,    0,  110,    0,   18,   43,  113,
			  111,   19,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    9,   22,   10,   48,  164,   44,   32,   72,   11,  186,
			   12,  140,  162,  213,  194,  195,   33,   79,  124,  125,
			  126,   34,   55,  101,  157,  226,  233,   24,   64,   65,
			   14,   61,   50,  142,  166,   46,   56,   57,   16,   63,
			   41,  104,  111,  112,   74,  108,  128,  154,  222,   17,
			   53,   38,  199,  215,  169,  196,   35,   58,   59,  102,
			  109,  110,  158,   94,  242,   25>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  108,   -6,   -2,   -2,  200,   -6,   -6,  148,   -6, -32768,
			 -32768,  172,  143, -32768,  130,   85,  160,  155,   59, -32768,
			 -32768, -32768,   29,  101,   -2, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,   29,  152,  235, -32768,   29,   -2, -32768,
			   29,   -2, -32768,  152,   29,  152,  151, -32768,   29,  165,
			   -2, -32768, -32768,  155,   -2,  130, -32768,   85, -32768,   59,
			 -32768,  130, -32768,  160, -32768, -32768, -32768,   -2,   -2, -32768,
			   -2,   -2,  162,   93,  136,  156,   29, -32768,   74,  159,
			   29, -32768,   29, -32768,   29,    0, -32768, -32768,   29, -32768,
			    9,   29,  160, -32768,  141,  157,   59, -32768,   85,  130,

			  154, -32768,  147, -32768,  145,  145, -32768, -32768,  136, -32768,
			  138, -32768,   93, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  111, -32768, -32768,   -2, -32768, -32768,
			 -32768, -32768, -32768,  135, -32768,   -2, -32768, -32768,  130,   -2,
			  133,   25,  117, -32768,   59,   85,   -2,   -2,   -2,   93,
			 -32768,  114, -32768, -32768,  113, -32768,  118, -32768,   98,   85,
			   80,   -2, -32768,   -2,   29,   78,   75, -32768,  240,   87,
			 -32768,   59, -32768, -32768, -32768,   92, -32768,   -2,   -2,   -2,
			   59, -32768, -32768,   78, -32768,   -2,   83,   29, -32768, -32768,
			 -32768, -32768, -32768, -32768,   29,   82,  187, -32768,  240,   72,

			 -32768, -32768, -32768, -32768, -32768, -32768,   76,   48,   -2, -32768,
			 -32768,   -2,   29,   29,   49,  187, -32768, -32768,   -2, -32768,
			   28, -32768,   69, -32768, -32768,   -4,   65,   29,   28,   33,
			   -2, -32768, -32768,  -12,   -2, -32768,   13, -32768, -32768, -32768,
			 -32768, -32768,   39,   21, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -32768,  206, -198,  171,   45,  179,   -1, -32768, -32768,   41,
			 -32768, -32768, -32768,    5,   12, -179,  169,   38, -32768, -32768,
			 -32768,    4, -32768,   53,   24, -32768, -32768, -32768,    8,  -50,
			   -3,  -49, -32768, -32768, -32768, -32768,    6,  -37,   10,  149,
			 -32768,  131,  176,   81,  126, -32768, -32768, -32768, -32768,  175,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,    3,  -47, -32768,
			  -11,  -95, -32768, -32768, -32768,   51>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   23,   26,   27,   18,   37,   40,   15,   49,   13,   97,
			   96,   45,   75,   60,   99,  132,   21,  151,   95,  214,
			   21,  244,  229,   23,   98,  239,  232,   62,  241,  163,
			  236,    8,  136,   20,   19,   67,  214,   82,   19,  243,
			   84,  231,    7,  138,  135,    6,  143,   21,  237,   49,
			   45,  144,    5,   93,  175,   36,   39,   42,   47,   51,
			   60,    4,  145,   62,   20,   19,  100,  103,   20,  103,
			  106,    2,    1,   66,  133,  234,  225,  123,  122,  163,
			  230,   85,  121,   87,   77,  219,  218,  217,   81,   60,
			  120,   83,  211,  208,  170,   86,   21,   21,  171,   89,

			  119,  159,  118,    1,  117,  185,   71,  201,  198,  179,
			  116,    8,  180,   70,   19,   19,   69,  181,    4,  115,
			   68,  200,    7,  178,  177,    6,  153,  114,   67,  176,
			  205,  129,    5,  130,  156,  131,   67,  168,  160,  134,
			  165,    4,  137,  161,    7,  172,  100,  174,  152,    3,
			  155,    2,    1,  150,   31,   68,  148,   31,  147,  146,
			  182,   30,  183,    8,   30,  165,  141,  193,  139,  127,
			   21,  113,    6,   21,   70,   90,  202,  203,  156,   78,
			   29,   54,   43,   29,  207,   43,   52,   20,   19,  149,
			   28,   19,  167,   28,  192,  193,    5,  193,  107,   73,

			  173,  105,   92,  204,   80,  191,   31,  220,  212,   21,
			  221,  187,  190,   30,  193,  184,  189,  228,  188,  197,
			  227,   91,   21,   18,  206,   88,   15,   19,   13,  238,
			   76,   18,   29,  240,   15,    0,   13,    0,  209,   20,
			   19,   31,   28,    0,    0,  210,    0,  192,   30,  216,
			    0,    0,    0,    0,    0,    0,    0,   21,  191,    0,
			    0,    0,   21,  223,  224,  190,    0,   29,    0,  189,
			    0,  188,    0,    0,    0,   19,    0,   28,  235,   20,
			   19>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,    2,    3,    0,    5,    6,    0,    8,    0,   59,
			   57,    7,   23,   16,   63,   15,   22,  112,   55,  198,
			   22,    0,  220,   24,   61,   37,   30,   17,   15,    4,
			  228,    3,   23,   39,   40,   35,  215,   38,   40,    0,
			   41,   45,   14,   92,   35,   17,   96,   22,   15,   50,
			   46,   98,   24,   54,  149,    4,    5,    6,    7,    8,
			   63,   33,   99,   53,   39,   40,   67,   68,   39,   70,
			   71,   43,   44,   22,   85,   10,   27,   78,    4,    4,
			   11,   43,    8,   45,   33,   37,   10,   15,   37,   92,
			   16,   40,   10,   10,  144,   44,   22,   22,  145,   48,

			   26,  138,   28,   44,   30,   27,    5,   15,   21,   11,
			   36,    3,  159,   12,   40,   40,   15,   37,   33,   45,
			   19,  171,   14,    5,   11,   17,  127,   76,   35,   15,
			  180,   80,   24,   82,  135,   84,   35,   20,  139,   88,
			  141,   33,   91,   10,   14,  146,  147,  148,   37,   41,
			   15,   43,   44,   15,    6,   19,   11,    6,   11,    5,
			  161,   13,  163,    3,   13,  166,    9,  168,   27,   10,
			   22,   15,   17,   22,   12,   10,  177,  178,  179,   27,
			   32,   38,   34,   32,  185,   34,   11,   39,   40,  108,
			   42,   40,  141,   42,    7,  196,   24,  198,   72,   23,

			  147,   70,   53,  179,   35,   18,    6,  208,  196,   22,
			  211,  166,   25,   13,  215,  164,   29,  218,   31,  168,
			  215,   50,   22,  220,  183,   46,  220,   40,  220,  230,
			   24,  228,   32,  234,  228,    0,  228,    0,  187,   39,
			   40,    6,   42,    0,    0,  194,    0,    7,   13,  198,
			    0,    0,    0,    0,    0,    0,    0,   22,   18,    0,
			    0,    0,   22,  212,  213,   25,    0,   32,    0,   29,
			    0,   31,    0,    0,    0,   40,    0,   42,  227,   39,
			   40>>)
		end

feature {NONE} -- Conversion

	yytype1 (v: ANY): ACE_SD is
		require
			valid_type: yyis_type1 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type1 (v: ANY): BOOLEAN is
		local
			u: ACE_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype2 (v: ANY): CLAS_VISI_SD is
		require
			valid_type: yyis_type2 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type2 (v: ANY): BOOLEAN is
		local
			u: CLAS_VISI_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype3 (v: ANY): CLUST_PROP_SD is
		require
			valid_type: yyis_type3 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type3 (v: ANY): BOOLEAN is
		local
			u: CLUST_PROP_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype4 (v: ANY): CLUST_ADAPT_SD is
		require
			valid_type: yyis_type4 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type4 (v: ANY): BOOLEAN is
		local
			u: CLUST_ADAPT_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype5 (v: ANY): CLUSTER_SD is
		require
			valid_type: yyis_type5 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type5 (v: ANY): BOOLEAN is
		local
			u: CLUSTER_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype6 (v: ANY): D_OPTION_SD is
		require
			valid_type: yyis_type6 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type6 (v: ANY): BOOLEAN is
		local
			u: D_OPTION_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype7 (v: ANY): ID_SD is
		require
			valid_type: yyis_type7 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type7 (v: ANY): BOOLEAN is
		local
			u: ID_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype8 (v: ANY): LANG_GEN_SD is
		require
			valid_type: yyis_type8 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type8 (v: ANY): BOOLEAN is
		local
			u: LANG_GEN_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype9 (v: ANY): LANG_TRIB_SD is
		require
			valid_type: yyis_type9 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type9 (v: ANY): BOOLEAN is
		local
			u: LANG_TRIB_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype10 (v: ANY): LANGUAGE_NAME_SD is
		require
			valid_type: yyis_type10 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type10 (v: ANY): BOOLEAN is
		local
			u: LANGUAGE_NAME_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype11 (v: ANY): O_OPTION_SD is
		require
			valid_type: yyis_type11 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type11 (v: ANY): BOOLEAN is
		local
			u: O_OPTION_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype12 (v: ANY): OPT_VAL_SD is
		require
			valid_type: yyis_type12 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type12 (v: ANY): BOOLEAN is
		local
			u: OPT_VAL_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype13 (v: ANY): OPTION_SD is
		require
			valid_type: yyis_type13 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type13 (v: ANY): BOOLEAN is
		local
			u: OPTION_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype14 (v: ANY): ROOT_SD is
		require
			valid_type: yyis_type14 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type14 (v: ANY): BOOLEAN is
		local
			u: ROOT_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype15 (v: ANY): TWO_NAME_SD is
		require
			valid_type: yyis_type15 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type15 (v: ANY): BOOLEAN is
		local
			u: TWO_NAME_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype16 (v: ANY): YES_OR_NO_SD is
		require
			valid_type: yyis_type16 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type16 (v: ANY): BOOLEAN is
		local
			u: YES_OR_NO_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype17 (v: ANY): LACE_LIST [CLAS_VISI_SD] is
		require
			valid_type: yyis_type17 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type17 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [CLAS_VISI_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype18 (v: ANY): LACE_LIST [CLUST_ADAPT_SD] is
		require
			valid_type: yyis_type18 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type18 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [CLUST_ADAPT_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype19 (v: ANY): LACE_LIST [CLUSTER_SD] is
		require
			valid_type: yyis_type19 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type19 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [CLUSTER_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype20 (v: ANY): LACE_LIST [D_OPTION_SD] is
		require
			valid_type: yyis_type20 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type20 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [D_OPTION_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype21 (v: ANY): EXCLUDE_SD is
		require
			valid_type: yyis_type21 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type21 (v: ANY): BOOLEAN is
		local
			u: EXCLUDE_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype22 (v: ANY): LACE_LIST [EXCLUDE_SD] is
		require
			valid_type: yyis_type22 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type22 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [EXCLUDE_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype23 (v: ANY): LACE_LIST [ID_SD] is
		require
			valid_type: yyis_type23 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type23 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [ID_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype24 (v: ANY): INCLUDE_SD is
		require
			valid_type: yyis_type24 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type24 (v: ANY): BOOLEAN is
		local
			u: INCLUDE_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype25 (v: ANY): LACE_LIST [INCLUDE_SD] is
		require
			valid_type: yyis_type25 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type25 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [INCLUDE_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype26 (v: ANY): LACE_LIST [LANG_GEN_SD] is
		require
			valid_type: yyis_type26 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type26 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [LANG_GEN_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype27 (v: ANY): LACE_LIST [LANG_TRIB_SD] is
		require
			valid_type: yyis_type27 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type27 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [LANG_TRIB_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype28 (v: ANY): LACE_LIST [O_OPTION_SD] is
		require
			valid_type: yyis_type28 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type28 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [O_OPTION_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype29 (v: ANY): LACE_LIST [TWO_NAME_SD] is
		require
			valid_type: yyis_type29 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type29 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [TWO_NAME_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype30 (v: ANY): CLICK_AST is
		require
			valid_type: yyis_type30 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type30 (v: ANY): BOOLEAN is
		local
			u: CLICK_AST
		do
			u ?= v
			Result := (u = v)
		end

	yytype31 (v: ANY): PAIR [ID_SD, CLICK_AST] is
		require
			valid_type: yyis_type31 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type31 (v: ANY): BOOLEAN is
		local
			u: PAIR [ID_SD, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 244
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 46
			-- Number of tokens

	yyLast: INTEGER is 280
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 300
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 112
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



end -- class LACE_PARSER


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
