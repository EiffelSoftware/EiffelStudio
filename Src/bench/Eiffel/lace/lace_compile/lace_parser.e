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
when 20 then
--|#line 137
	yy_do_action_20
when 21 then
--|#line 142
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
--|#line 158
	yy_do_action_28
when 30 then
--|#line 164
	yy_do_action_30
when 31 then
--|#line 168
	yy_do_action_31
when 34 then
--|#line 176
	yy_do_action_34
when 35 then
--|#line 180
	yy_do_action_35
when 37 then
--|#line 186
	yy_do_action_37
when 38 then
--|#line 191
	yy_do_action_38
when 39 then
--|#line 198
	yy_do_action_39
when 40 then
--|#line 203
	yy_do_action_40
when 41 then
--|#line 210
	yy_do_action_41
when 42 then
--|#line 215
	yy_do_action_42
when 44 then
--|#line 224
	yy_do_action_44
when 45 then
--|#line 228
	yy_do_action_45
when 47 then
--|#line 234
	yy_do_action_47
when 48 then
--|#line 239
	yy_do_action_48
when 49 then
--|#line 246
	yy_do_action_49
when 50 then
--|#line 248
	yy_do_action_50
when 51 then
--|#line 252
	yy_do_action_51
when 52 then
--|#line 257
	yy_do_action_52
when 53 then
--|#line 264
	yy_do_action_53
when 55 then
--|#line 270
	yy_do_action_55
when 56 then
--|#line 274
	yy_do_action_56
when 59 then
--|#line 282
	yy_do_action_59
when 60 then
--|#line 286
	yy_do_action_60
when 62 then
--|#line 292
	yy_do_action_62
when 63 then
--|#line 297
	yy_do_action_63
when 64 then
--|#line 304
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
--|#line 314
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
--|#line 326
	yy_do_action_73
when 74 then
--|#line 331
	yy_do_action_74
when 75 then
--|#line 338
	yy_do_action_75
when 77 then
--|#line 344
	yy_do_action_77
when 78 then
--|#line 348
	yy_do_action_78
when 79 then
--|#line 353
	yy_do_action_79
when 81 then
--|#line 362
	yy_do_action_81
when 82 then
--|#line 366
	yy_do_action_82
when 83 then
--|#line 368
	yy_do_action_83
when 84 then
--|#line 370
	yy_do_action_84
when 85 then
--|#line 374
	yy_do_action_85
when 86 then
--|#line 376
	yy_do_action_86
when 87 then
--|#line 378
	yy_do_action_87
when 88 then
--|#line 382
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
when 94 then
--|#line 396
	yy_do_action_94
when 96 then
--|#line 402
	yy_do_action_96
when 97 then
--|#line 407
	yy_do_action_97
when 98 then
--|#line 414
	yy_do_action_98
when 99 then
--|#line 418
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
when 106 then
--|#line 434
	yy_do_action_106
when 108 then
--|#line 440
	yy_do_action_108
when 109 then
--|#line 445
	yy_do_action_109
when 110 then
--|#line 452
	yy_do_action_110
when 112 then
--|#line 458
	yy_do_action_112
when 113 then
--|#line 462
	yy_do_action_113
when 114 then
--|#line 464
	yy_do_action_114
when 116 then
--|#line 470
	yy_do_action_116
when 117 then
--|#line 474
	yy_do_action_117
when 119 then
--|#line 480
	yy_do_action_119
when 120 then
--|#line 485
	yy_do_action_120
when 121 then
--|#line 492
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
--|#line 506
	yy_do_action_127
when 129 then
--|#line 512
	yy_do_action_129
when 130 then
--|#line 516
	yy_do_action_130
when 132 then
--|#line 522
	yy_do_action_132
when 133 then
--|#line 526
	yy_do_action_133
when 135 then
--|#line 532
	yy_do_action_135
when 136 then
--|#line 537
	yy_do_action_136
when 138 then
--|#line 546
	yy_do_action_138
when 139 then
--|#line 550
	yy_do_action_139
when 140 then
--|#line 554
	yy_do_action_140
when 141 then
--|#line 559
	yy_do_action_141
when 143 then
--|#line 568
	yy_do_action_143
when 144 then
--|#line 572
	yy_do_action_144
when 145 then
--|#line 574
	yy_do_action_145
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

yyval5 := new_cluster_sd (yytype7 (yyvs.item (yyvsp - 3)), yytype7 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp)), Void) 
			yyval := yyval5
		end

	yy_do_action_17 is
			--|#line 129
		local
			yyval5: CLUSTER_SD
		do

yyval5 := new_cluster_sd (yytype7 (yyvs.item (yyvsp - 5)), yytype7 (yyvs.item (yyvsp - 4)), yytype7 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1))) 
			yyval := yyval5
		end

	yy_do_action_18 is
			--|#line 131
		local
			yyval5: CLUSTER_SD
		do

yyval5 := new_cluster_sd (yytype7 (yyvs.item (yyvsp - 4)), yytype7 (yyvs.item (yyvsp - 3)), yytype7 (yyvs.item (yyvsp - 1)), Void) 
			yyval := yyval5
		end

	yy_do_action_20 is
			--|#line 137
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp - 1)) 
			yyval := yyval7
		end

	yy_do_action_21 is
			--|#line 142
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (yytype7 (yyvs.item (yyvsp - 6)), yytype25 (yyvs.item (yyvsp - 5)), yytype22 (yyvs.item (yyvsp - 4)), yytype18 (yyvs.item (yyvsp - 3)), yytype20 (yyvs.item (yyvsp - 2)), yytype28 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_22 is
			--|#line 144
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, yytype25 (yyvs.item (yyvsp - 5)), yytype22 (yyvs.item (yyvsp - 4)), yytype18 (yyvs.item (yyvsp - 3)), yytype20 (yyvs.item (yyvsp - 2)), yytype28 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_23 is
			--|#line 146
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, yytype22 (yyvs.item (yyvsp - 4)), yytype18 (yyvs.item (yyvsp - 3)), yytype20 (yyvs.item (yyvsp - 2)), yytype28 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_24 is
			--|#line 148
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, Void, yytype18 (yyvs.item (yyvsp - 3)), yytype20 (yyvs.item (yyvsp - 2)), yytype28 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_25 is
			--|#line 150
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, Void, Void, yytype20 (yyvs.item (yyvsp - 2)), yytype28 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_26 is
			--|#line 152
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, Void, Void, Void, yytype28 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_27 is
			--|#line 154
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, Void, Void, Void, Void, yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_28 is
			--|#line 158
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
		end

	yy_do_action_30 is
			--|#line 164
		local
			yyval25: LACE_LIST [INCLUDE_SD]
		do

yyval25 := yytype25 (yyvs.item (yyvsp)) 
			yyval := yyval25
		end

	yy_do_action_31 is
			--|#line 168
		local
			yyval25: LACE_LIST [INCLUDE_SD]
		do

yyval25 := yytype25 (yyvs.item (yyvsp)) 
			yyval := yyval25
		end

	yy_do_action_34 is
			--|#line 176
		local
			yyval22: LACE_LIST [EXCLUDE_SD]
		do

yyval22 := yytype22 (yyvs.item (yyvsp)) 
			yyval := yyval22
		end

	yy_do_action_35 is
			--|#line 180
		local
			yyval22: LACE_LIST [EXCLUDE_SD]
		do

yyval22 := yytype22 (yyvs.item (yyvsp)) 
			yyval := yyval22
		end

	yy_do_action_37 is
			--|#line 186
		local
			yyval25: LACE_LIST [INCLUDE_SD]
		do

				yyval25 := new_lace_list_include_sd (10)
				yyval25.extend (new_include_sd (yytype7 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval25
		end

	yy_do_action_38 is
			--|#line 191
		local
			yyval25: LACE_LIST [INCLUDE_SD]
		do

				yyval25 := yytype25 (yyvs.item (yyvsp - 2))
				yyval25.extend (new_include_sd (yytype7 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval25
		end

	yy_do_action_39 is
			--|#line 198
		local
			yyval22: LACE_LIST [EXCLUDE_SD]
		do

				yyval22 := new_lace_list_exclude_sd (10)
				yyval22.extend (new_exclude_sd (yytype7 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval22
		end

	yy_do_action_40 is
			--|#line 203
		local
			yyval22: LACE_LIST [EXCLUDE_SD]
		do

				yyval22 := yytype22 (yyvs.item (yyvsp - 2))
				yyval22.extend (new_exclude_sd (yytype7 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval22
		end

	yy_do_action_41 is
			--|#line 210
		local
			yyval23: LACE_LIST [ID_SD]
		do

				yyval23 := new_lace_list_id_sd (10)
				yyval23.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_42 is
			--|#line 215
		local
			yyval23: LACE_LIST [ID_SD]
		do

				yyval23 := yytype23 (yyvs.item (yyvsp - 2))
				yyval23.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_44 is
			--|#line 224
		local
			yyval18: LACE_LIST [CLUST_ADAPT_SD]
		do

yyval18 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval18
		end

	yy_do_action_45 is
			--|#line 228
		local
			yyval18: LACE_LIST [CLUST_ADAPT_SD]
		do

yyval18 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval18
		end

	yy_do_action_47 is
			--|#line 234
		local
			yyval18: LACE_LIST [CLUST_ADAPT_SD]
		do

				yyval18 := new_lace_list_clust_adapt_sd (10)
				yyval18.extend (yytype4 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval18
		end

	yy_do_action_48 is
			--|#line 239
		local
			yyval18: LACE_LIST [CLUST_ADAPT_SD]
		do

				yyval18 := yytype18 (yyvs.item (yyvsp - 2))
				yyval18.extend (yytype4 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval18
		end

	yy_do_action_49 is
			--|#line 246
		local
			yyval4: CLUST_ADAPT_SD
		do

yyval4 := new_clust_ign_sd (yytype7 (yyvs.item (yyvsp - 2))) 
			yyval := yyval4
		end

	yy_do_action_50 is
			--|#line 248
		local
			yyval4: CLUST_ADAPT_SD
		do

yyval4 := new_clust_ren_sd (yytype7 (yyvs.item (yyvsp - 3)), yytype29 (yyvs.item (yyvsp))) 
			yyval := yyval4
		end

	yy_do_action_51 is
			--|#line 252
		local
			yyval29: LACE_LIST [TWO_NAME_SD]
		do

				yyval29 := new_lace_list_two_name_sd (10)
				yyval29.extend (yytype15 (yyvs.item (yyvsp)))
			
			yyval := yyval29
		end

	yy_do_action_52 is
			--|#line 257
		local
			yyval29: LACE_LIST [TWO_NAME_SD]
		do

				yyval29 := yytype29 (yyvs.item (yyvsp - 2))
				yyval29.extend (yytype15 (yyvs.item (yyvsp)))
			
			yyval := yyval29
		end

	yy_do_action_53 is
			--|#line 264
		local
			yyval15: TWO_NAME_SD
		do

yyval15 := new_two_name_sd (yytype7 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval15
		end

	yy_do_action_55 is
			--|#line 270
		local
			yyval20: LACE_LIST [D_OPTION_SD]
		do

yyval20 := yytype20 (yyvs.item (yyvsp)) 
			yyval := yyval20
		end

	yy_do_action_56 is
			--|#line 274
		local
			yyval20: LACE_LIST [D_OPTION_SD]
		do

yyval20 := yytype20 (yyvs.item (yyvsp)) 
			yyval := yyval20
		end

	yy_do_action_59 is
			--|#line 282
		local
			yyval28: LACE_LIST [O_OPTION_SD]
		do

yyval28 := yytype28 (yyvs.item (yyvsp)) 
			yyval := yyval28
		end

	yy_do_action_60 is
			--|#line 286
		local
			yyval28: LACE_LIST [O_OPTION_SD]
		do

yyval28 := yytype28 (yyvs.item (yyvsp)) 
			yyval := yyval28
		end

	yy_do_action_62 is
			--|#line 292
		local
			yyval20: LACE_LIST [D_OPTION_SD]
		do

				yyval20 := new_lace_list_d_option_sd (10)
				yyval20.extend (yytype6 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval20
		end

	yy_do_action_63 is
			--|#line 297
		local
			yyval20: LACE_LIST [D_OPTION_SD]
		do

				yyval20 := yytype20 (yyvs.item (yyvsp - 2))
				yyval20.extend (yytype6 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval20
		end

	yy_do_action_64 is
			--|#line 304
		local
			yyval6: D_OPTION_SD
		do

yyval6 := new_d_precompiled_sd (Precompiled_keyword, yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval6
		end

	yy_do_action_65 is
			--|#line 306
		local
			yyval6: D_OPTION_SD
		do

yyval6 := new_d_precompiled_sd (Precompiled_keyword, yytype12 (yyvs.item (yyvsp - 1)), Void) 
			yyval := yyval6
		end

	yy_do_action_66 is
			--|#line 308
		local
			yyval6: D_OPTION_SD
		do

yyval6 := new_d_precompiled_sd (Precompiled_keyword, yytype12 (yyvs.item (yyvsp - 2)), yytype29 (yyvs.item (yyvsp - 1))) 
			yyval := yyval6
		end

	yy_do_action_67 is
			--|#line 310
		local
			yyval6: D_OPTION_SD
		do

yyval6 := new_d_option_sd (yytype13 (yyvs.item (yyvsp - 1)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval6
		end

	yy_do_action_68 is
			--|#line 314
		local
			yyval13: OPTION_SD
		do

yyval13 := Assertion_keyword 
			yyval := yyval13
		end

	yy_do_action_69 is
			--|#line 316
		local
			yyval13: OPTION_SD
		do

yyval13 := Debug_keyword 
			yyval := yyval13
		end

	yy_do_action_70 is
			--|#line 318
		local
			yyval13: OPTION_SD
		do

yyval13 := Optimize_keyword 
			yyval := yyval13
		end

	yy_do_action_71 is
			--|#line 320
		local
			yyval13: OPTION_SD
		do

yyval13 := Trace_keyword 
			yyval := yyval13
		end

	yy_do_action_72 is
			--|#line 322
		local
			yyval13: OPTION_SD
		do

yyval13 := new_free_option_sd (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval13
		end

	yy_do_action_73 is
			--|#line 326
		local
			yyval28: LACE_LIST [O_OPTION_SD]
		do

				yyval28 := new_lace_list_o_option_sd (10)
				yyval28.extend (yytype11 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval28
		end

	yy_do_action_74 is
			--|#line 331
		local
			yyval28: LACE_LIST [O_OPTION_SD]
		do

				yyval28 := yytype28 (yyvs.item (yyvsp - 2))
				yyval28.extend (yytype11 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval28
		end

	yy_do_action_75 is
			--|#line 338
		local
			yyval11: O_OPTION_SD
		do

yyval11 := new_o_option_sd (yytype13 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval11
		end

	yy_do_action_77 is
			--|#line 344
		local
			yyval23: LACE_LIST [ID_SD]
		do

yyval23 := yytype23 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_78 is
			--|#line 348
		local
			yyval23: LACE_LIST [ID_SD]
		do

				yyval23 := new_lace_list_id_sd (10)
				yyval23.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_79 is
			--|#line 353
		local
			yyval23: LACE_LIST [ID_SD]
		do

				yyval23 := yytype23 (yyvs.item (yyvsp - 2))
				yyval23.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_81 is
			--|#line 362
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := yytype12 (yyvs.item (yyvsp - 1)) 
			yyval := yyval12
		end

	yy_do_action_82 is
			--|#line 366
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := yytype12 (yyvs.item (yyvsp)) 
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

yyval12 := new_name_sd (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval12
		end

	yy_do_action_85 is
			--|#line 374
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Yes_keyword 
			yyval := yyval12
		end

	yy_do_action_86 is
			--|#line 376
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := No_keyword 
			yyval := yyval12
		end

	yy_do_action_87 is
			--|#line 378
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := All_keyword 
			yyval := yyval12
		end

	yy_do_action_88 is
			--|#line 382
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Require_keyword 
			yyval := yyval12
		end

	yy_do_action_89 is
			--|#line 384
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Ensure_keyword 
			yyval := yyval12
		end

	yy_do_action_90 is
			--|#line 386
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Invariant_keyword 
			yyval := yyval12
		end

	yy_do_action_91 is
			--|#line 388
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Loop_keyword 
			yyval := yyval12
		end

	yy_do_action_92 is
			--|#line 390
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Check_keyword 
			yyval := yyval12
		end

	yy_do_action_94 is
			--|#line 396
		local
			yyval27: LACE_LIST [LANG_TRIB_SD]
		do

yyval27 := yytype27 (yyvs.item (yyvsp)) 
			yyval := yyval27
		end

	yy_do_action_96 is
			--|#line 402
		local
			yyval27: LACE_LIST [LANG_TRIB_SD]
		do

				yyval27 := new_lace_list_lang_trib_sd (10)
				yyval27.extend (yytype9 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval27
		end

	yy_do_action_97 is
			--|#line 407
		local
			yyval27: LACE_LIST [LANG_TRIB_SD]
		do

				yyval27 := yytype27 (yyvs.item (yyvsp - 2))
				yyval27.extend (yytype9 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval27
		end

	yy_do_action_98 is
			--|#line 414
		local
			yyval9: LANG_TRIB_SD
		do

yyval9 := new_lang_trib_sd (yytype10 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval9
		end

	yy_do_action_99 is
			--|#line 418
		local
			yyval10: LANGUAGE_NAME_SD
		do

yyval10 := C_keyword 
			yyval := yyval10
		end

	yy_do_action_100 is
			--|#line 420
		local
			yyval10: LANGUAGE_NAME_SD
		do

yyval10 := Include_path_keyword 
			yyval := yyval10
		end

	yy_do_action_101 is
			--|#line 422
		local
			yyval10: LANGUAGE_NAME_SD
		do

yyval10 := Make_keyword 
			yyval := yyval10
		end

	yy_do_action_102 is
			--|#line 424
		local
			yyval10: LANGUAGE_NAME_SD
		do

yyval10 := Object_keyword 
			yyval := yyval10
		end

	yy_do_action_103 is
			--|#line 426
		local
			yyval10: LANGUAGE_NAME_SD
		do

yyval10 := Executable_keyword 
			yyval := yyval10
		end

	yy_do_action_104 is
			--|#line 428
		local
			yyval10: LANGUAGE_NAME_SD
		do

yyval10 := new_language_name_sd (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval10
		end

	yy_do_action_106 is
			--|#line 434
		local
			yyval26: LACE_LIST [LANG_GEN_SD]
		do

yyval26 := yytype26 (yyvs.item (yyvsp)) 
			yyval := yyval26
		end

	yy_do_action_108 is
			--|#line 440
		local
			yyval26: LACE_LIST [LANG_GEN_SD]
		do

				yyval26 := new_lace_list_lang_gen_sd (10)
				yyval26.extend (yytype8 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval26
		end

	yy_do_action_109 is
			--|#line 445
		local
			yyval26: LACE_LIST [LANG_GEN_SD]
		do

				yyval26 := yytype26 (yyvs.item (yyvsp - 2))
				yyval26.extend (yytype8 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval26
		end

	yy_do_action_110 is
			--|#line 452
		local
			yyval8: LANG_GEN_SD
		do

yyval8 := new_lang_gen_sd (yytype10 (yyvs.item (yyvsp - 3)), yytype16 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval8
		end

	yy_do_action_112 is
			--|#line 458
		local
			yyval16: YES_OR_NO_SD
		do

yyval16 := yytype16 (yyvs.item (yyvsp - 1)) 
			yyval := yyval16
		end

	yy_do_action_113 is
			--|#line 462
		local
			yyval16: YES_OR_NO_SD
		do

yyval16 := Yes_keyword 
			yyval := yyval16
		end

	yy_do_action_114 is
			--|#line 464
		local
			yyval16: YES_OR_NO_SD
		do

yyval16 := No_keyword 
			yyval := yyval16
		end

	yy_do_action_116 is
			--|#line 470
		local
			yyval17: LACE_LIST [CLAS_VISI_SD]
		do

yyval17 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval17
		end

	yy_do_action_117 is
			--|#line 474
		local
			yyval17: LACE_LIST [CLAS_VISI_SD]
		do

yyval17 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval17
		end

	yy_do_action_119 is
			--|#line 480
		local
			yyval17: LACE_LIST [CLAS_VISI_SD]
		do

				yyval17 := new_lace_list_clas_visi_sd (10)
				yyval17.extend (yytype2 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval17
		end

	yy_do_action_120 is
			--|#line 485
		local
			yyval17: LACE_LIST [CLAS_VISI_SD]
		do

				yyval17 := yytype17 (yyvs.item (yyvsp - 2))
				yyval17.extend (yytype2 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval17
		end

	yy_do_action_121 is
			--|#line 492
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp)), Void, Void, Void, Void) 
			yyval := yyval2
		end

	yy_do_action_122 is
			--|#line 494
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 5)), yytype7 (yyvs.item (yyvsp - 4)), yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp - 2)), yytype29 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_123 is
			--|#line 496
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 4)), Void, yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp - 2)), yytype29 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_124 is
			--|#line 498
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 3)), Void, Void, yytype23 (yyvs.item (yyvsp - 2)), yytype29 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_125 is
			--|#line 500
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 2)), Void, Void, Void, yytype29 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_126 is
			--|#line 502
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void) 
			yyval := yyval2
		end

	yy_do_action_127 is
			--|#line 506
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
		end

	yy_do_action_129 is
			--|#line 512
		local
			yyval23: LACE_LIST [ID_SD]
		do

yyval23 := yytype23 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_130 is
			--|#line 516
		local
			yyval23: LACE_LIST [ID_SD]
		do

yyval23 := yytype23 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_132 is
			--|#line 522
		local
			yyval23: LACE_LIST [ID_SD]
		do

yyval23 := yytype23 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_133 is
			--|#line 526
		local
			yyval23: LACE_LIST [ID_SD]
		do

yyval23 := yytype23 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_135 is
			--|#line 532
		local
			yyval23: LACE_LIST [ID_SD]
		do

				yyval23 := new_lace_list_id_sd (10)
				yyval23.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_136 is
			--|#line 537
		local
			yyval23: LACE_LIST [ID_SD]
		do

				yyval23 := yytype23 (yyvs.item (yyvsp - 2))
				yyval23.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_138 is
			--|#line 546
		local
			yyval29: LACE_LIST [TWO_NAME_SD]
		do

yyval29 := yytype29 (yyvs.item (yyvsp)) 
			yyval := yyval29
		end

	yy_do_action_139 is
			--|#line 550
		local
			yyval29: LACE_LIST [TWO_NAME_SD]
		do

yyval29 := yytype29 (yyvs.item (yyvsp)) 
			yyval := yyval29
		end

	yy_do_action_140 is
			--|#line 554
		local
			yyval29: LACE_LIST [TWO_NAME_SD]
		do

				yyval29 := new_lace_list_two_name_sd (10)
				yyval29.extend (yytype15 (yyvs.item (yyvsp)))
			
			yyval := yyval29
		end

	yy_do_action_141 is
			--|#line 559
		local
			yyval29: LACE_LIST [TWO_NAME_SD]
		do

				yyval29 := yytype29 (yyvs.item (yyvsp - 2))
				yyval29.extend (yytype15 (yyvs.item (yyvsp)))
			
			yyval := yyval29
		end

	yy_do_action_143 is
			--|#line 568
		local
			yyval15: TWO_NAME_SD
		do

yyval15 := new_two_name_sd (yytype7 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval15
		end

	yy_do_action_144 is
			--|#line 572
		local
			yyval7: ID_SD
		do

yyval7 := new_id_sd (token_buffer) 
			yyval := yyval7
		end

	yy_do_action_145 is
			--|#line 574
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
			   58,   79,   79,   79,   80,   80,   50,   50,   50,   55,
			   55,   48,   48,   48,   48,   48,   48,   48,   54,   96,
			   96,   95,   95,   85,   85,   84,   84,   97,   97,   86,
			   86,   94,   94,   77,   77,   76,   76,   78,   78,   49,
			   49,  108,  108,   70,   83,   83,   82,   82,  104,  104,
			  103,  103,   81,   81,   51,   51,   51,   51,   67,   67,
			   67,   67,   67,  102,  102,   62,   92,   92,   93,   93,
			   63,   63,   64,   64,   64,   65,   65,   65,   66,   66,
			   66,   66,   66,  100,  100,  100,  101,  101,   60,   61,

			   61,   61,   61,   61,   61,   98,   98,   98,   99,   99,
			   59,   71,   71,   72,   72,   75,   75,   74,   74,   73,
			   73,   47,   47,   47,   47,   47,   47,   53,   91,   91,
			   90,   89,   89,   88,   87,   87,   87,  107,  107,  106,
			  105,  105,   69,   69,   52,   52,  111,  111>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,    1,    1,    7,    2,    4,    1,    0,    3,    0,
			    2,    0,    2,    2,    2,    3,    4,    6,    5,    0,
			    3,    7,    6,    5,    4,    3,    2,    1,    2,    0,
			    1,    2,    2,    0,    1,    2,    2,    2,    3,    2,
			    3,    1,    3,    0,    1,    2,    2,    2,    3,    3,
			    4,    1,    3,    3,    0,    1,    2,    2,    0,    1,
			    2,    2,    2,    3,    2,    3,    4,    2,    1,    1,
			    1,    1,    1,    2,    3,    3,    0,    2,    1,    3,
			    0,    3,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    0,    2,    2,    2,    3,    3,    1,

			    1,    1,    1,    1,    1,    0,    2,    2,    2,    3,
			    4,    0,    3,    1,    1,    0,    1,    2,    2,    2,
			    3,    1,    6,    5,    4,    3,    2,    2,    0,    1,
			    2,    0,    1,    2,    0,    1,    3,    0,    1,    2,
			    1,    3,    0,    3,    1,    1,    0,    1>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  146,    0,    0,  146,  146,  146,  146,  146,    1,
			    2,   29,    0,   27,   54,   58,   43,   33,  115,  145,
			  147,  144,  146,  121,  117,  118,   28,    4,   71,   70,
			   69,   68,   72,  146,   80,   60,   61,  146,   31,   32,
			  146,   35,   36,   80,  146,   80,   56,   57,  146,    0,
			   45,   46,   30,   33,    0,   54,   55,   58,   59,  115,
			   44,   54,   34,   43,  116,   26,  119,  142,  134,  126,
			  134,    0,  128,  137,  131,    0,  146,   73,    0,   76,
			  146,   37,  146,   39,  146,   64,   62,   67,  146,   47,
			    0,  146,   43,    6,    7,   11,  115,   25,   58,   54,

			    0,  140,  139,  135,  133,  130,  127,  129,  131,  138,
			    0,  132,  137,  125,  120,   85,   88,   86,   91,   90,
			   89,   92,   87,   84,    0,   82,   83,    0,   75,   74,
			   38,   40,   65,    0,   63,    0,   49,   48,   54,    0,
			    9,  146,   93,   24,  115,   58,    0,  142,    0,  137,
			  124,    0,   81,   78,   77,   66,    0,   51,   50,   58,
			    0,    0,    5,  146,   19,   12,   13,  146,  105,   23,
			  115,  143,  141,  136,    0,  123,    0,    0,    0,  115,
			    8,   10,   14,    0,    0,  146,  102,  101,  100,  103,
			   99,  104,  146,    0,   94,   95,  146,    0,   22,  122,

			   79,   53,   52,   21,    0,    0,   15,   96,    0,  146,
			  146,  111,  106,  107,    3,   20,   16,   41,   98,   97,
			  108,    0,    0,  146,   18,    0,    0,  113,  114,    0,
			    0,  109,   17,   42,  112,  110,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    9,   22,   10,   48,  163,   44,   32,   72,   11,  184,
			   12,  140,  162,  210,  192,  193,   33,   79,  124,  125,
			  126,   34,   55,  101,  157,  222,  229,   24,   64,   65,
			   60,   61,   50,  142,  165,   46,   56,   57,   16,   63,
			   41,  104,  111,  112,   74,  108,  128,  154,  218,   17,
			   53,   38,  197,  212,  168,  194,   35,   58,   59,  102,
			  109,  110,  158,   94,  236,   25>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  100,    2,   -5,   -5,  166,    2,    2,  129,    2, -32768,
			 -32768,  157,  135, -32768,  113,   77,  151,  150,   41, -32768,
			 -32768, -32768,   17,  143,   -5, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,   17,  153,  208, -32768,   17,   -5, -32768,
			   17,   -5, -32768,  153,   17,  153,   52, -32768,   17,  160,
			   -5, -32768, -32768,  150,   -5,  113, -32768,   77, -32768,   41,
			 -32768,  113, -32768,  151, -32768, -32768, -32768,   -5,   -5, -32768,
			   -5,   -5,  147,   86,  118,  142,   17, -32768,   83,  146,
			   17, -32768,   17, -32768,   17,    4, -32768, -32768,   17, -32768,
			   55,   17,  151, -32768,  125,  144,   41, -32768,   77,  113,

			  145, -32768,  138, -32768,  128,  128, -32768, -32768,  118, -32768,
			  121, -32768,   86, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,   93, -32768, -32768,   -5, -32768, -32768,
			 -32768, -32768, -32768,  117, -32768,   -5, -32768, -32768,  113,   -5,
			  115,    2,  109, -32768,   41,   77,   -5,   -5,   -5,   86,
			 -32768,  105, -32768, -32768,  107, -32768,  102, -32768,   90,   77,
			   56,   -5, -32768,   17,   68,   -5, -32768,  220,   76, -32768,
			   41, -32768, -32768, -32768,   74, -32768,   -5,   -5,   -5,   41,
			 -32768, -32768, -32768,   -5,   73,   17, -32768, -32768, -32768, -32768,
			 -32768, -32768,   17,   72,  236, -32768,  220,   66, -32768, -32768,

			 -32768, -32768, -32768, -32768,   42,   -5, -32768, -32768,   -5,   17,
			   17,   53,  236, -32768, -32768, -32768,   19, -32768,   65, -32768,
			 -32768,   43,   37,   17, -32768,   23,   -5, -32768, -32768,   38,
			   -5, -32768, -32768, -32768, -32768, -32768,   26,   20, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -32768,  178,  -13,  149,   32,  154,   -1, -32768, -32768, -32768,
			 -32768, -32768, -32768,  -16,    7, -152,  159,  -18, -32768, -32768,
			 -32768,    5, -32768,   45,   12, -32768, -32768, -32768,   10,  -48,
			    8,  -47, -32768, -32768, -32768, -32768,    6,  -40,    1,  132,
			 -32768,  119,  161,   78,  111, -32768, -32768, -32768, -32768,  163,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,    3,  -43, -32768,
			  -14,  -99, -32768, -32768, -32768,   24>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   23,   26,   27,   18,   37,   40,   15,   49,   14,   75,
			   13,   97,   45,  151,   96,   95,   99,   21,   62,  132,
			  238,   98,    8,   23,   21,   85,  237,   87,   36,   39,
			   42,   47,   51,    7,  224,   19,    6,   82,  232,   67,
			   84,   20,   19,    5,  211,  138,   66,  230,  143,   49,
			  174,   45,    4,   93,   62,  144,   20,   77,   31,  145,
			  211,   81,    2,    1,   83,   30,  100,  103,   86,  103,
			  106,  133,   89,  228,   21,  234,  226,  123,  136,  215,
			  221,  214,  208,  205,   29,    1,   43,  122,  227,  199,
			  135,  121,   19,  180,   28,  183,  169,  196,  159,  120,

			  114,  178,  170,    8,  129,   21,  130,  177,  131,  119,
			    4,  118,  134,  117,    7,  137,  179,    6,  176,  116,
			  175,   67,  198,   19,    5,  161,  153,    7,  115,  167,
			  152,  203,  155,    4,  156,   31,  150,   68,  160,  148,
			  164,    3,   30,    2,    1,  171,  100,  173,   71,  147,
			  146,   21,  139,  141,    8,   70,  127,  113,   69,   70,
			  181,   29,   68,   43,  164,  166,  191,    6,   20,   19,
			   90,   28,   31,   54,   52,  200,  201,  156,   67,   30,
			   78,    5,  204,  107,   73,   92,  149,  182,   21,  105,
			  202,  195,  172,  191,   80,  191,  223,  185,   29,   91,

			   88,  209,   76,  225,  216,   20,   19,  217,   28,  206,
			    0,  191,    0,    0,   31,    0,  207,    0,    0,   18,
			  213,   30,   15,    0,   14,  233,   13,  190,    0,  235,
			   21,    0,    0,  219,  220,    0,    0,    0,  189,    0,
			   29,    0,   21,  190,    0,  188,    0,  231,   19,  187,
			   28,  186,    0,    0,  189,    0,    0,    0,   21,   20,
			   19,  188,    0,    0,    0,  187,    0,  186,    0,    0,
			    0,    0,    0,    0,    0,    0,   19>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,    2,    3,    0,    5,    6,    0,    8,    0,   23,
			    0,   59,    7,  112,   57,   55,   63,   22,   17,   15,
			    0,   61,    3,   24,   22,   43,    0,   45,    4,    5,
			    6,    7,    8,   14,   15,   40,   17,   38,   15,   35,
			   41,   39,   40,   24,  196,   92,   22,   10,   96,   50,
			  149,   46,   33,   54,   53,   98,   39,   33,    6,   99,
			  212,   37,   43,   44,   40,   13,   67,   68,   44,   70,
			   71,   85,   48,   30,   22,   37,   11,   78,   23,   37,
			   27,   15,   10,   10,   32,   44,   34,    4,   45,   15,
			   35,    8,   40,   37,   42,   27,  144,   21,  138,   16,

			   76,   11,  145,    3,   80,   22,   82,    5,   84,   26,
			   33,   28,   88,   30,   14,   91,  159,   17,   11,   36,
			   15,   35,  170,   40,   24,   10,  127,   14,   45,   20,
			   37,  179,   15,   33,  135,    6,   15,   19,  139,   11,
			  141,   41,   13,   43,   44,  146,  147,  148,    5,   11,
			    5,   22,   27,    9,    3,   12,   10,   15,   15,   12,
			  161,   32,   19,   34,  165,  141,  167,   17,   39,   40,
			   10,   42,    6,   38,   11,  176,  177,  178,   35,   13,
			   27,   24,  183,   72,   23,   53,  108,  163,   22,   70,
			  178,  167,  147,  194,   35,  196,  212,  165,   32,   50,

			   46,  194,   24,  216,  205,   39,   40,  208,   42,  185,
			    0,  212,    0,    0,    6,    0,  192,    0,    0,  216,
			  196,   13,  216,    0,  216,  226,  216,    7,    0,  230,
			   22,    0,    0,  209,  210,    0,    0,    0,   18,    0,
			   32,    0,   22,    7,    0,   25,    0,  223,   40,   29,
			   42,   31,    0,    0,   18,    0,    0,    0,   22,   39,
			   40,   25,    0,    0,    0,   29,    0,   31,    0,    0,
			    0,    0,    0,    0,    0,    0,   40>>)
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

	yyFinal: INTEGER is 238
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 46
			-- Number of tokens

	yyLast: INTEGER is 276
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
