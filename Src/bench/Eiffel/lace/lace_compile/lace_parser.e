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
--|#line 75
	yy_do_action_1
when 2 then
--|#line 77
	yy_do_action_2
when 3 then
--|#line 81
	yy_do_action_3
when 4 then
--|#line 85
	yy_do_action_4
when 5 then
--|#line 89
	yy_do_action_5
when 6 then
--|#line 93
	yy_do_action_6
when 8 then
--|#line 99
	yy_do_action_8
when 10 then
--|#line 105
	yy_do_action_10
when 11 then
--|#line 109
	yy_do_action_11
when 12 then
--|#line 111
	yy_do_action_12
when 13 then
--|#line 115
	yy_do_action_13
when 14 then
--|#line 120
	yy_do_action_14
when 15 then
--|#line 127
	yy_do_action_15
when 16 then
--|#line 129
	yy_do_action_16
when 17 then
--|#line 131
	yy_do_action_17
when 18 then
--|#line 133
	yy_do_action_18
when 19 then
--|#line 135
	yy_do_action_19
when 20 then
--|#line 137
	yy_do_action_20
when 22 then
--|#line 143
	yy_do_action_22
when 23 then
--|#line 148
	yy_do_action_23
when 24 then
--|#line 150
	yy_do_action_24
when 25 then
--|#line 152
	yy_do_action_25
when 26 then
--|#line 154
	yy_do_action_26
when 27 then
--|#line 156
	yy_do_action_27
when 28 then
--|#line 158
	yy_do_action_28
when 29 then
--|#line 160
	yy_do_action_29
when 30 then
--|#line 162
	yy_do_action_30
when 31 then
--|#line 166
	yy_do_action_31
when 33 then
--|#line 173
	yy_do_action_33
when 34 then
--|#line 178
	yy_do_action_34
when 35 then
--|#line 186
	yy_do_action_35
when 37 then
--|#line 192
	yy_do_action_37
when 38 then
--|#line 197
	yy_do_action_38
when 40 then
--|#line 203
	yy_do_action_40
when 41 then
--|#line 207
	yy_do_action_41
when 44 then
--|#line 215
	yy_do_action_44
when 45 then
--|#line 219
	yy_do_action_45
when 47 then
--|#line 225
	yy_do_action_47
when 48 then
--|#line 230
	yy_do_action_48
when 49 then
--|#line 237
	yy_do_action_49
when 50 then
--|#line 242
	yy_do_action_50
when 51 then
--|#line 249
	yy_do_action_51
when 52 then
--|#line 254
	yy_do_action_52
when 54 then
--|#line 263
	yy_do_action_54
when 55 then
--|#line 267
	yy_do_action_55
when 57 then
--|#line 273
	yy_do_action_57
when 58 then
--|#line 278
	yy_do_action_58
when 59 then
--|#line 285
	yy_do_action_59
when 60 then
--|#line 287
	yy_do_action_60
when 61 then
--|#line 291
	yy_do_action_61
when 62 then
--|#line 296
	yy_do_action_62
when 63 then
--|#line 303
	yy_do_action_63
when 65 then
--|#line 309
	yy_do_action_65
when 66 then
--|#line 313
	yy_do_action_66
when 69 then
--|#line 321
	yy_do_action_69
when 70 then
--|#line 325
	yy_do_action_70
when 72 then
--|#line 331
	yy_do_action_72
when 73 then
--|#line 336
	yy_do_action_73
when 74 then
--|#line 343
	yy_do_action_74
when 75 then
--|#line 345
	yy_do_action_75
when 76 then
--|#line 347
	yy_do_action_76
when 77 then
--|#line 349
	yy_do_action_77
when 78 then
--|#line 353
	yy_do_action_78
when 79 then
--|#line 355
	yy_do_action_79
when 80 then
--|#line 357
	yy_do_action_80
when 81 then
--|#line 359
	yy_do_action_81
when 82 then
--|#line 361
	yy_do_action_82
when 83 then
--|#line 363
	yy_do_action_83
when 84 then
--|#line 372
	yy_do_action_84
when 85 then
--|#line 377
	yy_do_action_85
when 86 then
--|#line 384
	yy_do_action_86
when 88 then
--|#line 390
	yy_do_action_88
when 89 then
--|#line 394
	yy_do_action_89
when 90 then
--|#line 399
	yy_do_action_90
when 92 then
--|#line 408
	yy_do_action_92
when 93 then
--|#line 412
	yy_do_action_93
when 94 then
--|#line 414
	yy_do_action_94
when 95 then
--|#line 416
	yy_do_action_95
when 96 then
--|#line 420
	yy_do_action_96
when 97 then
--|#line 422
	yy_do_action_97
when 98 then
--|#line 424
	yy_do_action_98
when 99 then
--|#line 428
	yy_do_action_99
when 100 then
--|#line 430
	yy_do_action_100
when 101 then
--|#line 432
	yy_do_action_101
when 102 then
--|#line 434
	yy_do_action_102
when 103 then
--|#line 436
	yy_do_action_103
when 105 then
--|#line 442
	yy_do_action_105
when 107 then
--|#line 448
	yy_do_action_107
when 108 then
--|#line 453
	yy_do_action_108
when 109 then
--|#line 460
	yy_do_action_109
when 110 then
--|#line 464
	yy_do_action_110
when 114 then
--|#line 477
	yy_do_action_114
when 115 then
--|#line 482
	yy_do_action_115
when 122 then
--|#line 507
	yy_do_action_122
when 123 then
--|#line 511
	yy_do_action_123
when 125 then
--|#line 517
	yy_do_action_125
when 126 then
--|#line 522
	yy_do_action_126
when 127 then
--|#line 529
	yy_do_action_127
when 128 then
--|#line 531
	yy_do_action_128
when 129 then
--|#line 533
	yy_do_action_129
when 130 then
--|#line 535
	yy_do_action_130
when 131 then
--|#line 537
	yy_do_action_131
when 132 then
--|#line 539
	yy_do_action_132
when 133 then
--|#line 543
	yy_do_action_133
when 135 then
--|#line 549
	yy_do_action_135
when 136 then
--|#line 553
	yy_do_action_136
when 138 then
--|#line 559
	yy_do_action_138
when 139 then
--|#line 563
	yy_do_action_139
when 141 then
--|#line 569
	yy_do_action_141
when 142 then
--|#line 574
	yy_do_action_142
when 144 then
--|#line 583
	yy_do_action_144
when 145 then
--|#line 587
	yy_do_action_145
when 146 then
--|#line 591
	yy_do_action_146
when 147 then
--|#line 596
	yy_do_action_147
when 149 then
--|#line 605
	yy_do_action_149
when 150 then
--|#line 609
	yy_do_action_150
when 151 then
--|#line 611
	yy_do_action_151
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 75
		local

		do
			yyval := yyval_default;
ast := yytype1 (yyvs.item (yyvsp)) 

		end

	yy_do_action_2 is
			--|#line 77
		local

		do
			yyval := yyval_default;
ast := yytype3 (yyvs.item (yyvsp)) 

		end

	yy_do_action_3 is
			--|#line 81
		local
			yyval1: ACE_SD
		do

yyval1 := new_ace_sd (yytype7 (yyvs.item (yyvsp - 6)), yytype13 (yyvs.item (yyvsp - 5)), yytype19 (yyvs.item (yyvsp - 4)), yytype18 (yyvs.item (yyvsp - 3)), yytype25 (yyvs.item (yyvsp - 2)), click_list) 
			yyval := yyval1
		end

	yy_do_action_4 is
			--|#line 85
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
		end

	yy_do_action_5 is
			--|#line 89
		local
			yyval13: ROOT_SD
		do

yyval13 := new_root (yytype30 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval13
		end

	yy_do_action_6 is
			--|#line 93
		local
			yyval30: PAIR [ID_SD, CLICK_AST]
		do

yyval30 := new_clickable_id (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval30
		end

	yy_do_action_8 is
			--|#line 99
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp - 1)) 
			yyval := yyval7
		end

	yy_do_action_10 is
			--|#line 105
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
		end

	yy_do_action_11 is
			--|#line 109
		local
			yyval18: LACE_LIST [CLUSTER_SD]
		do

yyval18 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval18
		end

	yy_do_action_12 is
			--|#line 111
		local
			yyval18: LACE_LIST [CLUSTER_SD]
		do

yyval18 := Void 
			yyval := yyval18
		end

	yy_do_action_13 is
			--|#line 115
		local
			yyval18: LACE_LIST [CLUSTER_SD]
		do

				yyval18 := new_lace_list_cluster_sd (10)
				yyval18.extend (yytype5 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval18
		end

	yy_do_action_14 is
			--|#line 120
		local
			yyval18: LACE_LIST [CLUSTER_SD]
		do

				yyval18 := yytype18 (yyvs.item (yyvsp - 2))
				yyval18.extend (yytype5 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval18
		end

	yy_do_action_15 is
			--|#line 127
		local
			yyval5: CLUSTER_SD
		do

yyval5 := new_cluster_sd (yytype7 (yyvs.item (yyvsp - 3)), yytype7 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp)), Void, False, False) 
			yyval := yyval5
		end

	yy_do_action_16 is
			--|#line 129
		local
			yyval5: CLUSTER_SD
		do

yyval5 := new_cluster_sd (yytype7 (yyvs.item (yyvsp - 3)), yytype7 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp)), Void, True, False) 
			yyval := yyval5
		end

	yy_do_action_17 is
			--|#line 131
		local
			yyval5: CLUSTER_SD
		do

yyval5 := new_cluster_sd (yytype7 (yyvs.item (yyvsp - 3)), yytype7 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp)), Void, True, True) 
			yyval := yyval5
		end

	yy_do_action_18 is
			--|#line 133
		local
			yyval5: CLUSTER_SD
		do

yyval5 := new_cluster_sd (yytype7 (yyvs.item (yyvsp - 5)), yytype7 (yyvs.item (yyvsp - 4)), yytype7 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), False, False) 
			yyval := yyval5
		end

	yy_do_action_19 is
			--|#line 135
		local
			yyval5: CLUSTER_SD
		do

yyval5 := new_cluster_sd (yytype7 (yyvs.item (yyvsp - 5)), yytype7 (yyvs.item (yyvsp - 4)), yytype7 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), True, False) 
			yyval := yyval5
		end

	yy_do_action_20 is
			--|#line 137
		local
			yyval5: CLUSTER_SD
		do

yyval5 := new_cluster_sd (yytype7 (yyvs.item (yyvsp - 5)), yytype7 (yyvs.item (yyvsp - 4)), yytype7 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), True, True) 
			yyval := yyval5
		end

	yy_do_action_22 is
			--|#line 143
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp - 1)) 
			yyval := yyval7
		end

	yy_do_action_23 is
			--|#line 148
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (yytype28 (yyvs.item (yyvsp - 7)), yytype7 (yyvs.item (yyvsp - 6)), yytype24 (yyvs.item (yyvsp - 5)), yytype21 (yyvs.item (yyvsp - 4)), yytype17 (yyvs.item (yyvsp - 3)), yytype19 (yyvs.item (yyvsp - 2)), yytype26 (yyvs.item (yyvsp - 1)), yytype16 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_24 is
			--|#line 150
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, yytype7 (yyvs.item (yyvsp - 6)), yytype24 (yyvs.item (yyvsp - 5)), yytype21 (yyvs.item (yyvsp - 4)), yytype17 (yyvs.item (yyvsp - 3)), yytype19 (yyvs.item (yyvsp - 2)), yytype26 (yyvs.item (yyvsp - 1)), yytype16 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_25 is
			--|#line 152
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, yytype24 (yyvs.item (yyvsp - 5)), yytype21 (yyvs.item (yyvsp - 4)), yytype17 (yyvs.item (yyvsp - 3)), yytype19 (yyvs.item (yyvsp - 2)), yytype26 (yyvs.item (yyvsp - 1)), yytype16 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_26 is
			--|#line 154
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, Void, yytype21 (yyvs.item (yyvsp - 4)), yytype17 (yyvs.item (yyvsp - 3)), yytype19 (yyvs.item (yyvsp - 2)), yytype26 (yyvs.item (yyvsp - 1)), yytype16 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_27 is
			--|#line 156
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, Void, Void, yytype17 (yyvs.item (yyvsp - 3)), yytype19 (yyvs.item (yyvsp - 2)), yytype26 (yyvs.item (yyvsp - 1)), yytype16 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_28 is
			--|#line 158
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, Void, Void, Void, yytype19 (yyvs.item (yyvsp - 2)), yytype26 (yyvs.item (yyvsp - 1)), yytype16 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_29 is
			--|#line 160
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, Void, Void, Void, Void, yytype26 (yyvs.item (yyvsp - 1)), yytype16 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_30 is
			--|#line 162
		local
			yyval3: CLUST_PROP_SD
		do

yyval3 := new_clust_prop_sd (Void, Void, Void, Void, Void, Void, Void, yytype16 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_31 is
			--|#line 166
		local
			yyval28: LACE_LIST [DEPEND_SD]
		do

yyval28 := yytype28 (yyvs.item (yyvsp)) 
			yyval := yyval28
		end

	yy_do_action_33 is
			--|#line 173
		local
			yyval28: LACE_LIST [DEPEND_SD]
		do

				yyval28 := new_lace_list_depend_sd (10)
				yyval28.extend (yytype15 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval28
		end

	yy_do_action_34 is
			--|#line 178
		local
			yyval28: LACE_LIST [DEPEND_SD]
		do

				yyval28 := yytype28 (yyvs.item (yyvsp - 2))
				yyval28.extend (yytype15 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval28
		end

	yy_do_action_35 is
			--|#line 186
		local
			yyval15: DEPEND_SD
		do

yyval15 := new_depend_sd (yytype22 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval15
		end

	yy_do_action_37 is
			--|#line 192
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
		end

	yy_do_action_38 is
			--|#line 197
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
		end

	yy_do_action_40 is
			--|#line 203
		local
			yyval24: LACE_LIST [INCLUDE_SD]
		do

yyval24 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval24
		end

	yy_do_action_41 is
			--|#line 207
		local
			yyval24: LACE_LIST [INCLUDE_SD]
		do

yyval24 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval24
		end

	yy_do_action_44 is
			--|#line 215
		local
			yyval21: LACE_LIST [EXCLUDE_SD]
		do

yyval21 := yytype21 (yyvs.item (yyvsp)) 
			yyval := yyval21
		end

	yy_do_action_45 is
			--|#line 219
		local
			yyval21: LACE_LIST [EXCLUDE_SD]
		do

yyval21 := yytype21 (yyvs.item (yyvsp)) 
			yyval := yyval21
		end

	yy_do_action_47 is
			--|#line 225
		local
			yyval24: LACE_LIST [INCLUDE_SD]
		do

				yyval24 := new_lace_list_include_sd (10)
				yyval24.extend (new_include_sd (yytype7 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval24
		end

	yy_do_action_48 is
			--|#line 230
		local
			yyval24: LACE_LIST [INCLUDE_SD]
		do

				yyval24 := yytype24 (yyvs.item (yyvsp - 2))
				yyval24.extend (new_include_sd (yytype7 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval24
		end

	yy_do_action_49 is
			--|#line 237
		local
			yyval21: LACE_LIST [EXCLUDE_SD]
		do

				yyval21 := new_lace_list_exclude_sd (10)
				yyval21.extend (new_exclude_sd (yytype7 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval21
		end

	yy_do_action_50 is
			--|#line 242
		local
			yyval21: LACE_LIST [EXCLUDE_SD]
		do

				yyval21 := yytype21 (yyvs.item (yyvsp - 2))
				yyval21.extend (new_exclude_sd (yytype7 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval21
		end

	yy_do_action_51 is
			--|#line 249
		local
			yyval22: LACE_LIST [ID_SD]
		do

				yyval22 := new_lace_list_id_sd (10)
				yyval22.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_52 is
			--|#line 254
		local
			yyval22: LACE_LIST [ID_SD]
		do

				yyval22 := yytype22 (yyvs.item (yyvsp - 2))
				yyval22.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_54 is
			--|#line 263
		local
			yyval17: LACE_LIST [CLUST_ADAPT_SD]
		do

yyval17 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval17
		end

	yy_do_action_55 is
			--|#line 267
		local
			yyval17: LACE_LIST [CLUST_ADAPT_SD]
		do

yyval17 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval17
		end

	yy_do_action_57 is
			--|#line 273
		local
			yyval17: LACE_LIST [CLUST_ADAPT_SD]
		do

				yyval17 := new_lace_list_clust_adapt_sd (10)
				yyval17.extend (yytype4 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval17
		end

	yy_do_action_58 is
			--|#line 278
		local
			yyval17: LACE_LIST [CLUST_ADAPT_SD]
		do

				yyval17 := yytype17 (yyvs.item (yyvsp - 2))
				yyval17.extend (yytype4 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval17
		end

	yy_do_action_59 is
			--|#line 285
		local
			yyval4: CLUST_ADAPT_SD
		do

yyval4 := new_clust_ign_sd (yytype7 (yyvs.item (yyvsp - 2))) 
			yyval := yyval4
		end

	yy_do_action_60 is
			--|#line 287
		local
			yyval4: CLUST_ADAPT_SD
		do

yyval4 := new_clust_ren_sd (yytype7 (yyvs.item (yyvsp - 3)), yytype27 (yyvs.item (yyvsp))) 
			yyval := yyval4
		end

	yy_do_action_61 is
			--|#line 291
		local
			yyval27: LACE_LIST [TWO_NAME_SD]
		do

				yyval27 := new_lace_list_two_name_sd (10)
				yyval27.extend (yytype14 (yyvs.item (yyvsp)))
			
			yyval := yyval27
		end

	yy_do_action_62 is
			--|#line 296
		local
			yyval27: LACE_LIST [TWO_NAME_SD]
		do

				yyval27 := yytype27 (yyvs.item (yyvsp - 2))
				yyval27.extend (yytype14 (yyvs.item (yyvsp)))
			
			yyval := yyval27
		end

	yy_do_action_63 is
			--|#line 303
		local
			yyval14: TWO_NAME_SD
		do

yyval14 := new_two_name_sd (yytype7 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval14
		end

	yy_do_action_65 is
			--|#line 309
		local
			yyval19: LACE_LIST [D_OPTION_SD]
		do

yyval19 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval19
		end

	yy_do_action_66 is
			--|#line 313
		local
			yyval19: LACE_LIST [D_OPTION_SD]
		do

yyval19 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval19
		end

	yy_do_action_69 is
			--|#line 321
		local
			yyval26: LACE_LIST [O_OPTION_SD]
		do

yyval26 := yytype26 (yyvs.item (yyvsp)) 
			yyval := yyval26
		end

	yy_do_action_70 is
			--|#line 325
		local
			yyval26: LACE_LIST [O_OPTION_SD]
		do

yyval26 := yytype26 (yyvs.item (yyvsp)) 
			yyval := yyval26
		end

	yy_do_action_72 is
			--|#line 331
		local
			yyval19: LACE_LIST [D_OPTION_SD]
		do

				yyval19 := new_lace_list_d_option_sd (10)
				yyval19.extend (yytype6 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval19
		end

	yy_do_action_73 is
			--|#line 336
		local
			yyval19: LACE_LIST [D_OPTION_SD]
		do

				yyval19 := yytype19 (yyvs.item (yyvsp - 2))
				yyval19.extend (yytype6 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval19
		end

	yy_do_action_74 is
			--|#line 343
		local
			yyval6: D_OPTION_SD
		do

yyval6 := new_d_precompiled_sd (Precompiled_keyword, yytype11 (yyvs.item (yyvsp)), Void) 
			yyval := yyval6
		end

	yy_do_action_75 is
			--|#line 345
		local
			yyval6: D_OPTION_SD
		do

yyval6 := new_d_precompiled_sd (Precompiled_keyword, yytype11 (yyvs.item (yyvsp - 1)), Void) 
			yyval := yyval6
		end

	yy_do_action_76 is
			--|#line 347
		local
			yyval6: D_OPTION_SD
		do

yyval6 := new_d_precompiled_sd (Precompiled_keyword, yytype11 (yyvs.item (yyvsp - 2)), yytype27 (yyvs.item (yyvsp - 1))) 
			yyval := yyval6
		end

	yy_do_action_77 is
			--|#line 349
		local
			yyval6: D_OPTION_SD
		do

yyval6 := new_d_option_sd (yytype12 (yyvs.item (yyvsp - 1)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval6
		end

	yy_do_action_78 is
			--|#line 353
		local
			yyval12: OPTION_SD
		do

yyval12 := Assertion_keyword 
			yyval := yyval12
		end

	yy_do_action_79 is
			--|#line 355
		local
			yyval12: OPTION_SD
		do

yyval12 := Debug_keyword 
			yyval := yyval12
		end

	yy_do_action_80 is
			--|#line 357
		local
			yyval12: OPTION_SD
		do

yyval12 := Disabled_debug_keyword 
			yyval := yyval12
		end

	yy_do_action_81 is
			--|#line 359
		local
			yyval12: OPTION_SD
		do

yyval12 := Optimize_keyword 
			yyval := yyval12
		end

	yy_do_action_82 is
			--|#line 361
		local
			yyval12: OPTION_SD
		do

yyval12 := Trace_keyword 
			yyval := yyval12
		end

	yy_do_action_83 is
			--|#line 363
		local
			yyval12: OPTION_SD
		do

				yyval12 := new_free_option_sd (yytype7 (yyvs.item (yyvsp)))
				if not yyval12.is_valid then
					raise_error
				end
			
			yyval := yyval12
		end

	yy_do_action_84 is
			--|#line 372
		local
			yyval26: LACE_LIST [O_OPTION_SD]
		do

				yyval26 := new_lace_list_o_option_sd (10)
				yyval26.extend (yytype10 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval26
		end

	yy_do_action_85 is
			--|#line 377
		local
			yyval26: LACE_LIST [O_OPTION_SD]
		do

				yyval26 := yytype26 (yyvs.item (yyvsp - 2))
				yyval26.extend (yytype10 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval26
		end

	yy_do_action_86 is
			--|#line 384
		local
			yyval10: O_OPTION_SD
		do

yyval10 := new_o_option_sd (yytype12 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp - 1)), yytype22 (yyvs.item (yyvsp))) 
			yyval := yyval10
		end

	yy_do_action_88 is
			--|#line 390
		local
			yyval22: LACE_LIST [ID_SD]
		do

yyval22 := yytype22 (yyvs.item (yyvsp)) 
			yyval := yyval22
		end

	yy_do_action_89 is
			--|#line 394
		local
			yyval22: LACE_LIST [ID_SD]
		do

				yyval22 := new_lace_list_id_sd (10)
				yyval22.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_90 is
			--|#line 399
		local
			yyval22: LACE_LIST [ID_SD]
		do

				yyval22 := yytype22 (yyvs.item (yyvsp - 2))
				yyval22.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_92 is
			--|#line 408
		local
			yyval11: OPT_VAL_SD
		do

yyval11 := yytype11 (yyvs.item (yyvsp - 1)) 
			yyval := yyval11
		end

	yy_do_action_93 is
			--|#line 412
		local
			yyval11: OPT_VAL_SD
		do

yyval11 := yytype11 (yyvs.item (yyvsp)) 
			yyval := yyval11
		end

	yy_do_action_94 is
			--|#line 414
		local
			yyval11: OPT_VAL_SD
		do

yyval11 := yytype11 (yyvs.item (yyvsp)) 
			yyval := yyval11
		end

	yy_do_action_95 is
			--|#line 416
		local
			yyval11: OPT_VAL_SD
		do

yyval11 := new_name_sd (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval11
		end

	yy_do_action_96 is
			--|#line 420
		local
			yyval11: OPT_VAL_SD
		do

yyval11 := Yes_keyword 
			yyval := yyval11
		end

	yy_do_action_97 is
			--|#line 422
		local
			yyval11: OPT_VAL_SD
		do

yyval11 := No_keyword 
			yyval := yyval11
		end

	yy_do_action_98 is
			--|#line 424
		local
			yyval11: OPT_VAL_SD
		do

yyval11 := All_keyword 
			yyval := yyval11
		end

	yy_do_action_99 is
			--|#line 428
		local
			yyval11: OPT_VAL_SD
		do

yyval11 := Require_keyword 
			yyval := yyval11
		end

	yy_do_action_100 is
			--|#line 430
		local
			yyval11: OPT_VAL_SD
		do

yyval11 := Ensure_keyword 
			yyval := yyval11
		end

	yy_do_action_101 is
			--|#line 432
		local
			yyval11: OPT_VAL_SD
		do

yyval11 := Invariant_keyword 
			yyval := yyval11
		end

	yy_do_action_102 is
			--|#line 434
		local
			yyval11: OPT_VAL_SD
		do

yyval11 := Loop_keyword 
			yyval := yyval11
		end

	yy_do_action_103 is
			--|#line 436
		local
			yyval11: OPT_VAL_SD
		do

yyval11 := Check_keyword 
			yyval := yyval11
		end

	yy_do_action_105 is
			--|#line 442
		local
			yyval25: LACE_LIST [LANG_TRIB_SD]
		do

yyval25 := yytype25 (yyvs.item (yyvsp)) 
			yyval := yyval25
		end

	yy_do_action_107 is
			--|#line 448
		local
			yyval25: LACE_LIST [LANG_TRIB_SD]
		do

				yyval25 := new_lace_list_lang_trib_sd (10)
				yyval25.extend (yytype8 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval25
		end

	yy_do_action_108 is
			--|#line 453
		local
			yyval25: LACE_LIST [LANG_TRIB_SD]
		do

				yyval25 := yytype25 (yyvs.item (yyvsp - 2))
				yyval25.extend (yytype8 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval25
		end

	yy_do_action_109 is
			--|#line 460
		local
			yyval8: LANG_TRIB_SD
		do

yyval8 := new_lang_trib_sd (yytype9 (yyvs.item (yyvsp - 2)), yytype22 (yyvs.item (yyvsp))) 
			yyval := yyval8
		end

	yy_do_action_110 is
			--|#line 464
		local
			yyval9: LANGUAGE_NAME_SD
		do

yyval9 := new_language_name_sd (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval9
		end

	yy_do_action_114 is
			--|#line 477
		local

		do
			yyval := yyval_default;
--		$$ := new_lace_list_lang_gen_sd (10)
--		$$.extend ($1)
	

		end

	yy_do_action_115 is
			--|#line 482
		local

		do
			yyval := yyval_default;
--		$$ := $1
--		$$.extend ($2)
	

		end

	yy_do_action_122 is
			--|#line 507
		local
			yyval16: LACE_LIST [CLAS_VISI_SD]
		do

yyval16 := yytype16 (yyvs.item (yyvsp)) 
			yyval := yyval16
		end

	yy_do_action_123 is
			--|#line 511
		local
			yyval16: LACE_LIST [CLAS_VISI_SD]
		do

yyval16 := yytype16 (yyvs.item (yyvsp)) 
			yyval := yyval16
		end

	yy_do_action_125 is
			--|#line 517
		local
			yyval16: LACE_LIST [CLAS_VISI_SD]
		do

				yyval16 := new_lace_list_clas_visi_sd (10)
				yyval16.extend (yytype2 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval16
		end

	yy_do_action_126 is
			--|#line 522
		local
			yyval16: LACE_LIST [CLAS_VISI_SD]
		do

				yyval16 := yytype16 (yyvs.item (yyvsp - 2))
				yyval16.extend (yytype2 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval16
		end

	yy_do_action_127 is
			--|#line 529
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp)), Void, Void, Void, Void) 
			yyval := yyval2
		end

	yy_do_action_128 is
			--|#line 531
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void) 
			yyval := yyval2
		end

	yy_do_action_129 is
			--|#line 533
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 2)), Void, Void, Void, yytype27 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_130 is
			--|#line 535
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 3)), Void, Void, yytype22 (yyvs.item (yyvsp - 2)), yytype27 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_131 is
			--|#line 537
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 4)), Void, yytype22 (yyvs.item (yyvsp - 3)), yytype22 (yyvs.item (yyvsp - 2)), yytype27 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_132 is
			--|#line 539
		local
			yyval2: CLAS_VISI_SD
		do

yyval2 := new_clas_visi_sd (yytype7 (yyvs.item (yyvsp - 5)), yytype7 (yyvs.item (yyvsp - 4)), yytype22 (yyvs.item (yyvsp - 3)), yytype22 (yyvs.item (yyvsp - 2)), yytype27 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_133 is
			--|#line 543
		local
			yyval7: ID_SD
		do

yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
		end

	yy_do_action_135 is
			--|#line 549
		local
			yyval22: LACE_LIST [ID_SD]
		do

yyval22 := yytype22 (yyvs.item (yyvsp)) 
			yyval := yyval22
		end

	yy_do_action_136 is
			--|#line 553
		local
			yyval22: LACE_LIST [ID_SD]
		do

yyval22 := yytype22 (yyvs.item (yyvsp)) 
			yyval := yyval22
		end

	yy_do_action_138 is
			--|#line 559
		local
			yyval22: LACE_LIST [ID_SD]
		do

yyval22 := yytype22 (yyvs.item (yyvsp)) 
			yyval := yyval22
		end

	yy_do_action_139 is
			--|#line 563
		local
			yyval22: LACE_LIST [ID_SD]
		do

yyval22 := yytype22 (yyvs.item (yyvsp)) 
			yyval := yyval22
		end

	yy_do_action_141 is
			--|#line 569
		local
			yyval22: LACE_LIST [ID_SD]
		do

				yyval22 := new_lace_list_id_sd (10)
				yyval22.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_142 is
			--|#line 574
		local
			yyval22: LACE_LIST [ID_SD]
		do

				yyval22 := yytype22 (yyvs.item (yyvsp - 2))
				yyval22.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_144 is
			--|#line 583
		local
			yyval27: LACE_LIST [TWO_NAME_SD]
		do

yyval27 := yytype27 (yyvs.item (yyvsp)) 
			yyval := yyval27
		end

	yy_do_action_145 is
			--|#line 587
		local
			yyval27: LACE_LIST [TWO_NAME_SD]
		do

yyval27 := yytype27 (yyvs.item (yyvsp)) 
			yyval := yyval27
		end

	yy_do_action_146 is
			--|#line 591
		local
			yyval27: LACE_LIST [TWO_NAME_SD]
		do

				yyval27 := new_lace_list_two_name_sd (10)
				yyval27.extend (yytype14 (yyvs.item (yyvsp)))
			
			yyval := yyval27
		end

	yy_do_action_147 is
			--|#line 596
		local
			yyval27: LACE_LIST [TWO_NAME_SD]
		do

				yyval27 := yytype27 (yyvs.item (yyvsp - 2))
				yyval27.extend (yytype14 (yyvs.item (yyvsp)))
			
			yyval := yyval27
		end

	yy_do_action_149 is
			--|#line 605
		local
			yyval14: TWO_NAME_SD
		do

yyval14 := new_two_name_sd (yytype7 (yyvs.item (yyvsp - 2)), yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval14
		end

	yy_do_action_150 is
			--|#line 609
		local
			yyval7: ID_SD
		do

yyval7 := new_id_sd (token_buffer, False) 
			yyval := yyval7
		end

	yy_do_action_151 is
			--|#line 611
		local
			yyval7: ID_SD
		do

yyval7 := new_id_sd (token_buffer, True) 
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
			   35,   36,   37,   38,   39,   40,   41,   42,   43>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  107,  107,   44,   55,   66,  106,   56,   56,   57,
			   57,   76,   76,   77,   77,   48,   48,   48,   48,   48,
			   48,   54,   54,   46,   46,   46,   46,   46,   46,   46,
			   46,  105,  105,  104,  104,   69,   53,   53,   52,   93,
			   93,   92,   92,   82,   82,   81,   81,   94,   94,   83,
			   83,   91,   91,   74,   74,   73,   73,   75,   75,   47,
			   47,  103,  103,   68,   80,   80,   79,   79,   99,   99,
			   98,   98,   78,   78,   49,   49,   49,   49,   65,   65,
			   65,   65,   65,   65,   97,   97,   60,   89,   89,   90,
			   90,   61,   61,   62,   62,   62,   63,   63,   63,   64,

			   64,   64,   64,   64,   95,   95,   95,   96,   96,   58,
			   59,  108,  108,  108,  110,  110,  111,  112,  112,  113,
			  113,   72,   72,   71,   71,   70,   70,   45,   45,   45,
			   45,   45,   45,   51,   88,   88,   87,   86,   86,   85,
			   84,   84,   84,  102,  102,  101,  100,  100,   67,   67,
			   50,   50,  109,  109>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,    1,    1,    7,    2,    4,    1,    0,    3,    0,
			    2,    2,    2,    2,    3,    4,    5,    5,    6,    7,
			    7,    0,    3,    8,    7,    6,    5,    4,    3,    2,
			    1,    2,    2,    2,    3,    3,    0,    1,    2,    0,
			    1,    2,    2,    0,    1,    2,    2,    2,    3,    2,
			    3,    1,    3,    0,    1,    2,    2,    2,    3,    3,
			    4,    1,    3,    3,    0,    1,    2,    2,    0,    1,
			    2,    2,    2,    3,    2,    3,    4,    2,    1,    1,
			    1,    1,    1,    1,    2,    3,    3,    0,    2,    1,
			    3,    0,    3,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    0,    2,    2,    2,    3,    3,
			    1,    0,    2,    2,    2,    3,    4,    0,    3,    1,
			    1,    0,    1,    2,    2,    2,    3,    1,    2,    3,
			    4,    5,    6,    2,    0,    1,    2,    0,    1,    2,
			    0,    1,    3,    0,    1,    2,    1,    3,    0,    3,
			    1,    1,    0,    1>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  152,    0,    0,  152,  152,  152,  152,  152,  152,
			    1,    2,   39,    0,   30,   64,   68,   53,   43,  121,
			   36,  151,  153,  150,  152,  127,  123,  124,   38,    4,
			   82,   81,   80,   79,   78,   83,  152,   91,   70,   71,
			  152,   41,   42,   51,  152,    0,   31,   32,  152,   45,
			   46,   91,  152,   91,   66,   67,  152,    0,   55,   56,
			   40,   43,    0,   64,   65,   68,   69,  121,   54,   64,
			   44,   53,  122,   29,   37,   39,  125,  148,  140,  128,
			  140,    0,  134,  143,  137,    0,  152,   84,    0,   87,
			  152,   47,  152,   33,    0,    0,  152,   49,  152,   74,

			   72,   77,  152,   57,    0,  152,   53,    6,    7,    0,
			  121,   28,   68,   64,   43,    0,  146,  145,  141,  139,
			  136,  133,  135,  137,  144,    0,  138,  143,  129,  126,
			   96,   99,   97,  102,  101,  100,  103,   98,   95,    0,
			   93,   94,    0,   86,   85,   48,   52,   35,   34,   50,
			   75,    0,   73,    0,   59,   58,   64,    0,    9,  152,
			  104,   27,  121,   68,   53,    0,  148,    0,  143,  130,
			    0,   92,   89,   88,   76,    0,   61,   60,   68,    0,
			    0,    5,    0,    0,  152,   21,   11,   12,  152,  111,
			   26,  121,   64,  149,  147,  142,    0,  131,    0,    0,

			    0,  121,    8,   10,   21,   21,   13,    0,    0,  152,
			  110,  152,    0,  105,  106,  152,    0,   25,   68,  132,
			   90,   63,   62,   24,    0,    0,    0,    0,   14,  107,
			    0,  152,  117,  113,  112,  152,    3,  121,    0,    0,
			   22,   15,  109,  108,    0,    0,  152,  114,   23,   17,
			   16,    0,  119,  120,    0,    0,  115,    0,    0,   18,
			  118,  116,   20,   19,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   10,   24,   11,   56,  184,   52,   35,   82,   12,   75,
			  208,   13,  158,  181,  211,  212,   36,   89,  139,  140,
			  141,   37,   63,  116,  176,   44,   26,   72,   73,   15,
			   69,   58,  160,  186,   54,   64,   65,   17,   71,   49,
			  119,  126,  127,   84,  123,  143,  173,   45,   18,   61,
			   41,  189,  213,   38,   66,   67,  117,  124,  125,  177,
			   46,   20,  108,  264,  216,   27,  234,  235,  245,  254>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   71,   49,    4,    4,  276,   49,   49,   49,  255,   49,
			 -32768, -32768,  133,  134, -32768,  103,   76,  129,  131,   55,
			  132, -32768, -32768, -32768,   37,   24,    4, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,   37,  136,  267, -32768,
			   37,    4, -32768, -32768,   37,   73,    4, -32768,   37,    4,
			 -32768,  136,   37,  136,  256, -32768,   37,  152,    4, -32768,
			 -32768,  131,    4,  103, -32768,   76, -32768,   55, -32768,  103,
			 -32768,  129, -32768, -32768, -32768,  133, -32768,    4,    4, -32768,
			    4,    4,  143,   98,  123,  138,   37, -32768,  218,  140,
			   37, -32768,   37, -32768,    4,    4,   37, -32768,   37,   12,

			 -32768, -32768,   37, -32768,   -2,   37,  129, -32768,  124,  139,
			   55, -32768,   76,  103,  131,  141, -32768,  135, -32768,  130,
			  130, -32768, -32768,  123, -32768,  122, -32768,   98, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  104,
			 -32768, -32768,    4, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  121, -32768,    4, -32768, -32768,  103,    4,  126,   32,
			  113, -32768,   55,   76,  129,    4,    4,    4,   98, -32768,
			  116, -32768, -32768,  119, -32768,  120, -32768,  117,   76,   92,
			    4, -32768,    4,    4,   37,   89,   29, -32768,   49,   97,
			 -32768,   55,  103, -32768, -32768, -32768,  102, -32768,    4,    4,

			    4,   55, -32768, -32768,   89,   89, -32768,    4,  105,   37,
			 -32768,   37,  101,    4, -32768,   49,   88, -32768,   76, -32768,
			 -32768, -32768, -32768, -32768,   91,   90,   63,    4, -32768, -32768,
			    4,   37,   72, -32768,    4,   37, -32768,   55,    4,    4,
			 -32768,  191,   68, -32768,   10,   38,   37, -32768, -32768,  191,
			  191,   45, -32768, -32768,  -10,    4, -32768,   34,   22, -32768,
			 -32768, -32768, -32768, -32768,   31,   28, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -32768,  166, -191,  144,    5,  142,   -1, -32768,  170, -32768,
			 -113, -32768, -32768, -32768,  -24, -192,  150,  -19, -32768, -32768,
			 -32768,   11, -32768,   18,  -23,  137, -32768,    9,  -57,   -4,
			  -60, -32768, -32768, -32768, -32768,    7,  -49,   -6,  -44, -32768,
			  106,  153,   50,   94, -32768, -32768, -32768,  -55,    6,   99,
			 -32768, -32768, -32768, -32768,    3,  -50, -32768,   -9, -105, -32768,
			 -32768, -32768, -32768, -32768, -32768,  115, -32768,  -64, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   25,   28,   29,   19,   40,   43,   48,   16,   57,   14,
			  111,  113,   70,   68,  109,  110,   85,  106,   60,   53,
			  112,  154,  170,  232,  260,   25,   23,  150,  266,   81,
			  153,  265,   99,  183,  101,   80,  183,  263,  253,   79,
			   92,   21,  232,   78,   77,   43,  156,  255,   98,  262,
			  251,   23,  252,  161,   23,   70,   77,   57,  257,  258,
			  259,  107,  162,  196,  163,   53,   21,   68,   22,   21,
			  164,   23,  182,   22,    9,  182,  115,  118,   94,  118,
			  121,   60,   95,   94,    8,   22,   21,  138,    7,    6,
			  151,  224,  225,  146,  147,    5,    1,  240,  244,  239,

			  238,    4,   68,  236,  192,  190,    4,  178,   70,    3,
			  230,    2,    1,  191,  227,  207,    8,  219,  215,   39,
			   42,   47,   50,   55,   59,  199,  202,  200,  201,  198,
			   77,  197,    9,  188,  217,  180,  174,  169,  171,   76,
			  167,  172,   78,  218,  223,  166,  165,  159,    7,  142,
			  157,   87,  175,  128,   80,   91,  179,    5,  185,   93,
			   68,  104,   88,   97,  193,  115,  195,  100,  237,   62,
			  246,  103,    2,  168,  114,  242,  122,  222,   83,  203,
			  248,  204,  205,   96,  194,  185,  120,  210,   90,  231,
			   74,  209,   86,    0,    9,    0,  102,  220,  221,  175,

			    0,  129,  105,    0,    8,  144,  226,  145,    7,    6,
			    0,  148,  210,  149,  210,    5,    0,  152,    0,    0,
			  155,    4,  137,    0,    0,  136,  241,    0,    0,   43,
			    0,    2,    1,  210,  135,    0,    0,  249,  250,    0,
			   23,    0,    0,  134,   19,  133,  132,    0,   16,    0,
			   14,  131,   19,   19,  261,   21,   16,   16,   14,   14,
			  130,   34,   34,    0,    0,    0,    0,   33,   33,   32,
			   32,    0,    0,   34,  187,    0,    0,   23,   23,   33,
			    0,   32,   34,    0,   31,   31,   51,   51,   33,   23,
			   32,   22,   21,   21,   30,   30,   31,    0,   23,  206,

			    0,    0,    0,  214,   21,   31,   30,    0,    0,    0,
			    0,    0,   22,   21,    0,   30,    0,    0,    0,    0,
			    0,    0,    0,    0,  228,    0,  229,    0,    0,    0,
			  233,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  243,    0,    0,    0,
			  247,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  256>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,    2,    3,    0,    5,    6,    7,    0,    9,    0,
			   67,   71,   18,   17,   63,   65,   25,   61,   12,    8,
			   69,   23,  127,  215,   34,   26,   22,   15,    0,    5,
			   32,    0,   51,    4,   53,   11,    4,   15,   28,   15,
			   41,   37,  234,   19,   32,   46,  106,    9,   49,   15,
			  241,   22,   42,  110,   22,   61,   32,   58,  249,  250,
			   15,   62,  112,  168,  113,   54,   37,   71,   36,   37,
			  114,   22,   43,   36,    3,   43,   77,   78,   10,   80,
			   81,   75,    9,   10,   13,   36,   37,   88,   17,   18,
			   99,  204,  205,   94,   95,   24,   41,   34,   26,    9,

			    9,   30,  106,   15,  164,  162,   30,  156,  114,   38,
			    9,   40,   41,  163,    9,   26,   13,   15,   21,    4,
			    5,    6,    7,    8,    9,    5,   34,   10,  178,   10,
			   32,   15,    3,   20,  191,    9,   15,   15,   34,   24,
			   10,  142,   19,  192,  201,   10,    5,    8,   17,    9,
			   26,   36,  153,   15,   11,   40,  157,   24,  159,   44,
			  164,    9,   26,   48,  165,  166,  167,   52,  218,   35,
			  234,   56,   40,  123,   75,  230,   82,  200,   25,  180,
			  237,  182,  183,   46,  166,  186,   80,  188,   38,  213,
			   20,  186,   26,   -1,    3,   -1,   54,  198,  199,  200,

			   -1,   86,   58,   -1,   13,   90,  207,   92,   17,   18,
			   -1,   96,  213,   98,  215,   24,   -1,  102,   -1,   -1,
			  105,   30,    4,   -1,   -1,    7,  227,   -1,   -1,  230,
			   -1,   40,   41,  234,   16,   -1,   -1,  238,  239,   -1,
			   22,   -1,   -1,   25,  241,   27,   28,   -1,  241,   -1,
			  241,   33,  249,  250,  255,   37,  249,  250,  249,  250,
			   42,    6,    6,   -1,   -1,   -1,   -1,   12,   12,   14,
			   14,   -1,   -1,    6,  159,   -1,   -1,   22,   22,   12,
			   -1,   14,    6,   -1,   29,   29,   31,   31,   12,   22,
			   14,   36,   37,   37,   39,   39,   29,   -1,   22,  184,

			   -1,   -1,   -1,  188,   37,   29,   39,   -1,   -1,   -1,
			   -1,   -1,   36,   37,   -1,   39,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  209,   -1,  211,   -1,   -1,   -1,
			  215,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  231,   -1,   -1,   -1,
			  235,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  246>>)
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

	yytype8 (v: ANY): LANG_TRIB_SD is
		require
			valid_type: yyis_type8 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type8 (v: ANY): BOOLEAN is
		local
			u: LANG_TRIB_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype9 (v: ANY): LANGUAGE_NAME_SD is
		require
			valid_type: yyis_type9 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type9 (v: ANY): BOOLEAN is
		local
			u: LANGUAGE_NAME_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype10 (v: ANY): O_OPTION_SD is
		require
			valid_type: yyis_type10 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type10 (v: ANY): BOOLEAN is
		local
			u: O_OPTION_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype11 (v: ANY): OPT_VAL_SD is
		require
			valid_type: yyis_type11 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type11 (v: ANY): BOOLEAN is
		local
			u: OPT_VAL_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype12 (v: ANY): OPTION_SD is
		require
			valid_type: yyis_type12 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type12 (v: ANY): BOOLEAN is
		local
			u: OPTION_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype13 (v: ANY): ROOT_SD is
		require
			valid_type: yyis_type13 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type13 (v: ANY): BOOLEAN is
		local
			u: ROOT_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype14 (v: ANY): TWO_NAME_SD is
		require
			valid_type: yyis_type14 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type14 (v: ANY): BOOLEAN is
		local
			u: TWO_NAME_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype15 (v: ANY): DEPEND_SD is
		require
			valid_type: yyis_type15 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type15 (v: ANY): BOOLEAN is
		local
			u: DEPEND_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype16 (v: ANY): LACE_LIST [CLAS_VISI_SD] is
		require
			valid_type: yyis_type16 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type16 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [CLAS_VISI_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype17 (v: ANY): LACE_LIST [CLUST_ADAPT_SD] is
		require
			valid_type: yyis_type17 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type17 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [CLUST_ADAPT_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype18 (v: ANY): LACE_LIST [CLUSTER_SD] is
		require
			valid_type: yyis_type18 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type18 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [CLUSTER_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype19 (v: ANY): LACE_LIST [D_OPTION_SD] is
		require
			valid_type: yyis_type19 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type19 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [D_OPTION_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype20 (v: ANY): EXCLUDE_SD is
		require
			valid_type: yyis_type20 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type20 (v: ANY): BOOLEAN is
		local
			u: EXCLUDE_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype21 (v: ANY): LACE_LIST [EXCLUDE_SD] is
		require
			valid_type: yyis_type21 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type21 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [EXCLUDE_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype22 (v: ANY): LACE_LIST [ID_SD] is
		require
			valid_type: yyis_type22 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type22 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [ID_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype23 (v: ANY): INCLUDE_SD is
		require
			valid_type: yyis_type23 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type23 (v: ANY): BOOLEAN is
		local
			u: INCLUDE_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype24 (v: ANY): LACE_LIST [INCLUDE_SD] is
		require
			valid_type: yyis_type24 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type24 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [INCLUDE_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype25 (v: ANY): LACE_LIST [LANG_TRIB_SD] is
		require
			valid_type: yyis_type25 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type25 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [LANG_TRIB_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype26 (v: ANY): LACE_LIST [O_OPTION_SD] is
		require
			valid_type: yyis_type26 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type26 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [O_OPTION_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype27 (v: ANY): LACE_LIST [TWO_NAME_SD] is
		require
			valid_type: yyis_type27 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type27 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [TWO_NAME_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype28 (v: ANY): LACE_LIST [DEPEND_SD] is
		require
			valid_type: yyis_type28 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type28 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [DEPEND_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype29 (v: ANY): CLICK_AST is
		require
			valid_type: yyis_type29 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type29 (v: ANY): BOOLEAN is
		local
			u: CLICK_AST
		do
			u ?= v
			Result := (u = v)
		end

	yytype30 (v: ANY): PAIR [ID_SD, CLICK_AST] is
		require
			valid_type: yyis_type30 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type30 (v: ANY): BOOLEAN is
		local
			u: PAIR [ID_SD, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 266
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 44
			-- Number of tokens

	yyLast: INTEGER is 361
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 298
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 114
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
