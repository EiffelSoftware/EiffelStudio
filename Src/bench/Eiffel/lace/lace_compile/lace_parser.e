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
--|#line 77
	yy_do_action_1
when 2 then
--|#line 79
	yy_do_action_2
when 3 then
--|#line 83
	yy_do_action_3
when 4 then
--|#line 87
	yy_do_action_4
when 5 then
--|#line 91
	yy_do_action_5
when 6 then
--|#line 98
	yy_do_action_6
when 8 then
--|#line 104
	yy_do_action_8
when 10 then
--|#line 110
	yy_do_action_10
when 11 then
--|#line 114
	yy_do_action_11
when 12 then
--|#line 116
	yy_do_action_12
when 13 then
--|#line 120
	yy_do_action_13
when 14 then
--|#line 125
	yy_do_action_14
when 15 then
--|#line 132
	yy_do_action_15
when 16 then
--|#line 134
	yy_do_action_16
when 17 then
--|#line 136
	yy_do_action_17
when 18 then
--|#line 138
	yy_do_action_18
when 19 then
--|#line 140
	yy_do_action_19
when 20 then
--|#line 142
	yy_do_action_20
when 22 then
--|#line 148
	yy_do_action_22
when 23 then
--|#line 153
	yy_do_action_23
when 24 then
--|#line 155
	yy_do_action_24
when 25 then
--|#line 157
	yy_do_action_25
when 26 then
--|#line 159
	yy_do_action_26
when 27 then
--|#line 161
	yy_do_action_27
when 28 then
--|#line 163
	yy_do_action_28
when 29 then
--|#line 165
	yy_do_action_29
when 30 then
--|#line 167
	yy_do_action_30
when 31 then
--|#line 171
	yy_do_action_31
when 33 then
--|#line 178
	yy_do_action_33
when 34 then
--|#line 183
	yy_do_action_34
when 35 then
--|#line 191
	yy_do_action_35
when 37 then
--|#line 197
	yy_do_action_37
when 38 then
--|#line 202
	yy_do_action_38
when 40 then
--|#line 208
	yy_do_action_40
when 41 then
--|#line 212
	yy_do_action_41
when 44 then
--|#line 220
	yy_do_action_44
when 45 then
--|#line 224
	yy_do_action_45
when 47 then
--|#line 230
	yy_do_action_47
when 48 then
--|#line 235
	yy_do_action_48
when 49 then
--|#line 242
	yy_do_action_49
when 50 then
--|#line 247
	yy_do_action_50
when 51 then
--|#line 254
	yy_do_action_51
when 52 then
--|#line 259
	yy_do_action_52
when 54 then
--|#line 268
	yy_do_action_54
when 55 then
--|#line 272
	yy_do_action_55
when 57 then
--|#line 278
	yy_do_action_57
when 58 then
--|#line 283
	yy_do_action_58
when 59 then
--|#line 290
	yy_do_action_59
when 60 then
--|#line 292
	yy_do_action_60
when 61 then
--|#line 296
	yy_do_action_61
when 62 then
--|#line 301
	yy_do_action_62
when 63 then
--|#line 308
	yy_do_action_63
when 65 then
--|#line 314
	yy_do_action_65
when 66 then
--|#line 318
	yy_do_action_66
when 69 then
--|#line 326
	yy_do_action_69
when 70 then
--|#line 330
	yy_do_action_70
when 72 then
--|#line 336
	yy_do_action_72
when 73 then
--|#line 341
	yy_do_action_73
when 74 then
--|#line 348
	yy_do_action_74
when 75 then
--|#line 350
	yy_do_action_75
when 76 then
--|#line 352
	yy_do_action_76
when 77 then
--|#line 354
	yy_do_action_77
when 78 then
--|#line 358
	yy_do_action_78
when 79 then
--|#line 360
	yy_do_action_79
when 80 then
--|#line 362
	yy_do_action_80
when 81 then
--|#line 364
	yy_do_action_81
when 82 then
--|#line 366
	yy_do_action_82
when 83 then
--|#line 368
	yy_do_action_83
when 84 then
--|#line 377
	yy_do_action_84
when 85 then
--|#line 382
	yy_do_action_85
when 86 then
--|#line 389
	yy_do_action_86
when 88 then
--|#line 395
	yy_do_action_88
when 89 then
--|#line 399
	yy_do_action_89
when 90 then
--|#line 404
	yy_do_action_90
when 92 then
--|#line 413
	yy_do_action_92
when 93 then
--|#line 417
	yy_do_action_93
when 94 then
--|#line 419
	yy_do_action_94
when 95 then
--|#line 421
	yy_do_action_95
when 96 then
--|#line 425
	yy_do_action_96
when 97 then
--|#line 427
	yy_do_action_97
when 98 then
--|#line 429
	yy_do_action_98
when 99 then
--|#line 433
	yy_do_action_99
when 100 then
--|#line 435
	yy_do_action_100
when 101 then
--|#line 437
	yy_do_action_101
when 102 then
--|#line 439
	yy_do_action_102
when 103 then
--|#line 441
	yy_do_action_103
when 105 then
--|#line 447
	yy_do_action_105
when 107 then
--|#line 453
	yy_do_action_107
when 108 then
--|#line 458
	yy_do_action_108
when 109 then
--|#line 465
	yy_do_action_109
when 110 then
--|#line 470
	yy_do_action_110
when 112 then
--|#line 479
	yy_do_action_112
when 114 then
--|#line 485
	yy_do_action_114
when 116 then
--|#line 491
	yy_do_action_116
when 117 then
--|#line 496
	yy_do_action_117
when 118 then
--|#line 503
	yy_do_action_118
when 119 then
--|#line 507
	yy_do_action_119
when 123 then
--|#line 520
	yy_do_action_123
when 124 then
--|#line 525
	yy_do_action_124
when 131 then
--|#line 550
	yy_do_action_131
when 132 then
--|#line 554
	yy_do_action_132
when 134 then
--|#line 560
	yy_do_action_134
when 135 then
--|#line 565
	yy_do_action_135
when 136 then
--|#line 572
	yy_do_action_136
when 137 then
--|#line 574
	yy_do_action_137
when 138 then
--|#line 576
	yy_do_action_138
when 139 then
--|#line 578
	yy_do_action_139
when 140 then
--|#line 580
	yy_do_action_140
when 141 then
--|#line 582
	yy_do_action_141
when 142 then
--|#line 586
	yy_do_action_142
when 144 then
--|#line 592
	yy_do_action_144
when 145 then
--|#line 596
	yy_do_action_145
when 147 then
--|#line 602
	yy_do_action_147
when 148 then
--|#line 606
	yy_do_action_148
when 150 then
--|#line 612
	yy_do_action_150
when 151 then
--|#line 617
	yy_do_action_151
when 153 then
--|#line 626
	yy_do_action_153
when 154 then
--|#line 630
	yy_do_action_154
when 155 then
--|#line 634
	yy_do_action_155
when 156 then
--|#line 639
	yy_do_action_156
when 158 then
--|#line 648
	yy_do_action_158
when 159 then
--|#line 652
	yy_do_action_159
when 160 then
--|#line 654
	yy_do_action_160
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 77
		local

		do
			yyval := yyval_default;
ast := yytype1 (yyvs.item (yyvsp)) 

		end

	yy_do_action_2 is
			--|#line 79
		local

		do
			yyval := yyval_default;
ast := yytype3 (yyvs.item (yyvsp)) 

		end

	yy_do_action_3 is
			--|#line 83
		local
			yyval1: ACE_SD
		do

create yyval1.initialize (yytype8 (yyvs.item (yyvsp - 7)), yytype14 (yyvs.item (yyvsp - 6)), yytype21 (yyvs.item (yyvsp - 5)), yytype19 (yyvs.item (yyvsp - 4)), yytype20 (yyvs.item (yyvsp - 3)), yytype25 (yyvs.item (yyvsp - 2)), click_list) 
			yyval := yyval1
		end

	yy_do_action_4 is
			--|#line 87
		local
			yyval8: ID_SD
		do

yyval8 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval8
		end

	yy_do_action_5 is
			--|#line 91
		local
			yyval14: ROOT_SD
		do

				create yyval14.initialize (yytype30 (yyvs.item (yyvsp - 2)).first, yytype8 (yyvs.item (yyvsp - 1)), yytype8 (yyvs.item (yyvsp)))
				yytype30 (yyvs.item (yyvsp - 2)).second.set_node (yyval14)
			
			yyval := yyval14
		end

	yy_do_action_6 is
			--|#line 98
		local
			yyval30: PAIR [ID_SD, CLICK_AST]
		do

yyval30 := new_clickable_id (yytype8 (yyvs.item (yyvsp))) 
			yyval := yyval30
		end

	yy_do_action_8 is
			--|#line 104
		local
			yyval8: ID_SD
		do

yyval8 := yytype8 (yyvs.item (yyvsp - 1)) 
			yyval := yyval8
		end

	yy_do_action_10 is
			--|#line 110
		local
			yyval8: ID_SD
		do

yyval8 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval8
		end

	yy_do_action_11 is
			--|#line 114
		local
			yyval19: LACE_LIST [CLUSTER_SD]
		do

yyval19 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval19
		end

	yy_do_action_12 is
			--|#line 116
		local
			yyval19: LACE_LIST [CLUSTER_SD]
		do

yyval19 := Void 
			yyval := yyval19
		end

	yy_do_action_13 is
			--|#line 120
		local
			yyval19: LACE_LIST [CLUSTER_SD]
		do

				create yyval19.make (10)
				yyval19.extend (yytype5 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval19
		end

	yy_do_action_14 is
			--|#line 125
		local
			yyval19: LACE_LIST [CLUSTER_SD]
		do

				yyval19 := yytype19 (yyvs.item (yyvsp - 2))
				yyval19.extend (yytype5 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval19
		end

	yy_do_action_15 is
			--|#line 132
		local
			yyval5: CLUSTER_SD
		do

create yyval5.initialize (yytype8 (yyvs.item (yyvsp - 3)), yytype8 (yyvs.item (yyvsp - 2)), yytype8 (yyvs.item (yyvsp)), Void, False, False) 
			yyval := yyval5
		end

	yy_do_action_16 is
			--|#line 134
		local
			yyval5: CLUSTER_SD
		do

create yyval5.initialize (yytype8 (yyvs.item (yyvsp - 3)), yytype8 (yyvs.item (yyvsp - 2)), yytype8 (yyvs.item (yyvsp)), Void, True, False) 
			yyval := yyval5
		end

	yy_do_action_17 is
			--|#line 136
		local
			yyval5: CLUSTER_SD
		do

create yyval5.initialize (yytype8 (yyvs.item (yyvsp - 3)), yytype8 (yyvs.item (yyvsp - 2)), yytype8 (yyvs.item (yyvsp)), Void, True, True) 
			yyval := yyval5
		end

	yy_do_action_18 is
			--|#line 138
		local
			yyval5: CLUSTER_SD
		do

create yyval5.initialize (yytype8 (yyvs.item (yyvsp - 5)), yytype8 (yyvs.item (yyvsp - 4)), yytype8 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), False, False) 
			yyval := yyval5
		end

	yy_do_action_19 is
			--|#line 140
		local
			yyval5: CLUSTER_SD
		do

create yyval5.initialize (yytype8 (yyvs.item (yyvsp - 5)), yytype8 (yyvs.item (yyvsp - 4)), yytype8 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), True, False) 
			yyval := yyval5
		end

	yy_do_action_20 is
			--|#line 142
		local
			yyval5: CLUSTER_SD
		do

create yyval5.initialize (yytype8 (yyvs.item (yyvsp - 5)), yytype8 (yyvs.item (yyvsp - 4)), yytype8 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), True, True) 
			yyval := yyval5
		end

	yy_do_action_22 is
			--|#line 148
		local
			yyval8: ID_SD
		do

yyval8 := yytype8 (yyvs.item (yyvsp - 1)) 
			yyval := yyval8
		end

	yy_do_action_23 is
			--|#line 153
		local
			yyval3: CLUST_PROP_SD
		do

create yyval3.initialize (yytype28 (yyvs.item (yyvsp - 7)), yytype8 (yyvs.item (yyvsp - 6)), yytype24 (yyvs.item (yyvsp - 5)), yytype24 (yyvs.item (yyvsp - 4)), yytype18 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype26 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_24 is
			--|#line 155
		local
			yyval3: CLUST_PROP_SD
		do

create yyval3.initialize (Void, yytype8 (yyvs.item (yyvsp - 6)), yytype24 (yyvs.item (yyvsp - 5)), yytype24 (yyvs.item (yyvsp - 4)), yytype18 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype26 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_25 is
			--|#line 157
		local
			yyval3: CLUST_PROP_SD
		do

create yyval3.initialize (Void, Void, yytype24 (yyvs.item (yyvsp - 5)), yytype24 (yyvs.item (yyvsp - 4)), yytype18 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype26 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_26 is
			--|#line 159
		local
			yyval3: CLUST_PROP_SD
		do

create yyval3.initialize (Void, Void, Void, yytype24 (yyvs.item (yyvsp - 4)), yytype18 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype26 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_27 is
			--|#line 161
		local
			yyval3: CLUST_PROP_SD
		do

create yyval3.initialize (Void, Void, Void, Void, yytype18 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype26 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_28 is
			--|#line 163
		local
			yyval3: CLUST_PROP_SD
		do

create yyval3.initialize (Void, Void, Void, Void, Void, yytype21 (yyvs.item (yyvsp - 2)), yytype26 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_29 is
			--|#line 165
		local
			yyval3: CLUST_PROP_SD
		do

create yyval3.initialize (Void, Void, Void, Void, Void, Void, yytype26 (yyvs.item (yyvsp - 1)), yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_30 is
			--|#line 167
		local
			yyval3: CLUST_PROP_SD
		do

create yyval3.initialize (Void, Void, Void, Void, Void, Void, Void, yytype17 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_31 is
			--|#line 171
		local
			yyval28: LACE_LIST [DEPEND_SD]
		do

yyval28 := yytype28 (yyvs.item (yyvsp)) 
			yyval := yyval28
		end

	yy_do_action_33 is
			--|#line 178
		local
			yyval28: LACE_LIST [DEPEND_SD]
		do

				create yyval28.make (10)
				yyval28.extend (yytype16 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval28
		end

	yy_do_action_34 is
			--|#line 183
		local
			yyval28: LACE_LIST [DEPEND_SD]
		do

				yyval28 := yytype28 (yyvs.item (yyvsp - 2))
				yyval28.extend (yytype16 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval28
		end

	yy_do_action_35 is
			--|#line 191
		local
			yyval16: DEPEND_SD
		do

create yyval16.initialize (yytype22 (yyvs.item (yyvsp - 2)), yytype8 (yyvs.item (yyvsp))) 
			yyval := yyval16
		end

	yy_do_action_37 is
			--|#line 197
		local
			yyval8: ID_SD
		do

yyval8 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval8
		end

	yy_do_action_38 is
			--|#line 202
		local
			yyval8: ID_SD
		do

yyval8 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval8
		end

	yy_do_action_40 is
			--|#line 208
		local
			yyval24: LACE_LIST [FILE_NAME_SD]
		do

yyval24 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval24
		end

	yy_do_action_41 is
			--|#line 212
		local
			yyval24: LACE_LIST [FILE_NAME_SD]
		do

yyval24 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval24
		end

	yy_do_action_44 is
			--|#line 220
		local
			yyval24: LACE_LIST [FILE_NAME_SD]
		do

yyval24 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval24
		end

	yy_do_action_45 is
			--|#line 224
		local
			yyval24: LACE_LIST [FILE_NAME_SD]
		do

yyval24 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval24
		end

	yy_do_action_47 is
			--|#line 230
		local
			yyval24: LACE_LIST [FILE_NAME_SD]
		do

				create yyval24.make (10)
				yyval24.extend (create {FILE_NAME_SD}.initialize (yytype8 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval24
		end

	yy_do_action_48 is
			--|#line 235
		local
			yyval24: LACE_LIST [FILE_NAME_SD]
		do

				yyval24 := yytype24 (yyvs.item (yyvsp - 2))
				yyval24.extend (create {FILE_NAME_SD}.initialize (yytype8 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval24
		end

	yy_do_action_49 is
			--|#line 242
		local
			yyval24: LACE_LIST [FILE_NAME_SD]
		do

				create yyval24.make (10)
				yyval24.extend (create {FILE_NAME_SD}.initialize (yytype8 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval24
		end

	yy_do_action_50 is
			--|#line 247
		local
			yyval24: LACE_LIST [FILE_NAME_SD]
		do

				yyval24 := yytype24 (yyvs.item (yyvsp - 2))
				yyval24.extend (create {FILE_NAME_SD}.initialize (yytype8 (yyvs.item (yyvsp - 1))))
			
			yyval := yyval24
		end

	yy_do_action_51 is
			--|#line 254
		local
			yyval22: LACE_LIST [ID_SD]
		do

				create yyval22.make (10)
				yyval22.extend (yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_52 is
			--|#line 259
		local
			yyval22: LACE_LIST [ID_SD]
		do

				yyval22 := yytype22 (yyvs.item (yyvsp - 2))
				yyval22.extend (yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_54 is
			--|#line 268
		local
			yyval18: LACE_LIST [CLUST_ADAPT_SD]
		do

yyval18 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval18
		end

	yy_do_action_55 is
			--|#line 272
		local
			yyval18: LACE_LIST [CLUST_ADAPT_SD]
		do

yyval18 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval18
		end

	yy_do_action_57 is
			--|#line 278
		local
			yyval18: LACE_LIST [CLUST_ADAPT_SD]
		do

				create yyval18.make (10)
				yyval18.extend (yytype4 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval18
		end

	yy_do_action_58 is
			--|#line 283
		local
			yyval18: LACE_LIST [CLUST_ADAPT_SD]
		do

				yyval18 := yytype18 (yyvs.item (yyvsp - 2))
				yyval18.extend (yytype4 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval18
		end

	yy_do_action_59 is
			--|#line 290
		local
			yyval4: CLUST_ADAPT_SD
		do

create {CLUST_IGN_SD} yyval4.initialize (yytype8 (yyvs.item (yyvsp - 2))) 
			yyval := yyval4
		end

	yy_do_action_60 is
			--|#line 292
		local
			yyval4: CLUST_ADAPT_SD
		do

create {CLUST_REN_SD} yyval4.initialize (yytype8 (yyvs.item (yyvsp - 3)), yytype27 (yyvs.item (yyvsp))) 
			yyval := yyval4
		end

	yy_do_action_61 is
			--|#line 296
		local
			yyval27: LACE_LIST [TWO_NAME_SD]
		do

				create yyval27.make (10)
				yyval27.extend (yytype15 (yyvs.item (yyvsp)))
			
			yyval := yyval27
		end

	yy_do_action_62 is
			--|#line 301
		local
			yyval27: LACE_LIST [TWO_NAME_SD]
		do

				yyval27 := yytype27 (yyvs.item (yyvsp - 2))
				yyval27.extend (yytype15 (yyvs.item (yyvsp)))
			
			yyval := yyval27
		end

	yy_do_action_63 is
			--|#line 308
		local
			yyval15: TWO_NAME_SD
		do

create yyval15.initialize (yytype8 (yyvs.item (yyvsp - 2)), yytype8 (yyvs.item (yyvsp))) 
			yyval := yyval15
		end

	yy_do_action_65 is
			--|#line 314
		local
			yyval21: LACE_LIST [D_OPTION_SD]
		do

yyval21 := yytype21 (yyvs.item (yyvsp)) 
			yyval := yyval21
		end

	yy_do_action_66 is
			--|#line 318
		local
			yyval21: LACE_LIST [D_OPTION_SD]
		do

yyval21 := yytype21 (yyvs.item (yyvsp)) 
			yyval := yyval21
		end

	yy_do_action_69 is
			--|#line 326
		local
			yyval26: LACE_LIST [O_OPTION_SD]
		do

yyval26 := yytype26 (yyvs.item (yyvsp)) 
			yyval := yyval26
		end

	yy_do_action_70 is
			--|#line 330
		local
			yyval26: LACE_LIST [O_OPTION_SD]
		do

yyval26 := yytype26 (yyvs.item (yyvsp)) 
			yyval := yyval26
		end

	yy_do_action_72 is
			--|#line 336
		local
			yyval21: LACE_LIST [D_OPTION_SD]
		do

				create yyval21.make (10)
				yyval21.extend (yytype7 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval21
		end

	yy_do_action_73 is
			--|#line 341
		local
			yyval21: LACE_LIST [D_OPTION_SD]
		do

				yyval21 := yytype21 (yyvs.item (yyvsp - 2))
				yyval21.extend (yytype7 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval21
		end

	yy_do_action_74 is
			--|#line 348
		local
			yyval7: D_OPTION_SD
		do

create {D_PRECOMPILED_SD} yyval7.initialize (Precompiled_keyword, yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval7
		end

	yy_do_action_75 is
			--|#line 350
		local
			yyval7: D_OPTION_SD
		do

create {D_PRECOMPILED_SD} yyval7.initialize (Precompiled_keyword, yytype12 (yyvs.item (yyvsp - 1)), Void) 
			yyval := yyval7
		end

	yy_do_action_76 is
			--|#line 352
		local
			yyval7: D_OPTION_SD
		do

create {D_PRECOMPILED_SD} yyval7.initialize (Precompiled_keyword, yytype12 (yyvs.item (yyvsp - 2)), yytype27 (yyvs.item (yyvsp - 1))) 
			yyval := yyval7
		end

	yy_do_action_77 is
			--|#line 354
		local
			yyval7: D_OPTION_SD
		do

create yyval7.initialize (yytype13 (yyvs.item (yyvsp - 1)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval7
		end

	yy_do_action_78 is
			--|#line 358
		local
			yyval13: OPTION_SD
		do

yyval13 := Assertion_keyword 
			yyval := yyval13
		end

	yy_do_action_79 is
			--|#line 360
		local
			yyval13: OPTION_SD
		do

yyval13 := Debug_keyword 
			yyval := yyval13
		end

	yy_do_action_80 is
			--|#line 362
		local
			yyval13: OPTION_SD
		do

yyval13 := Disabled_debug_keyword 
			yyval := yyval13
		end

	yy_do_action_81 is
			--|#line 364
		local
			yyval13: OPTION_SD
		do

yyval13 := Optimize_keyword 
			yyval := yyval13
		end

	yy_do_action_82 is
			--|#line 366
		local
			yyval13: OPTION_SD
		do

yyval13 := Trace_keyword 
			yyval := yyval13
		end

	yy_do_action_83 is
			--|#line 368
		local
			yyval13: OPTION_SD
		do

				create {FREE_OPTION_SD} yyval13.initialize (yytype8 (yyvs.item (yyvsp)))
				if not yyval13.is_valid then
					raise_error
				end
			
			yyval := yyval13
		end

	yy_do_action_84 is
			--|#line 377
		local
			yyval26: LACE_LIST [O_OPTION_SD]
		do

				create yyval26.make (10)
				yyval26.extend (yytype11 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval26
		end

	yy_do_action_85 is
			--|#line 382
		local
			yyval26: LACE_LIST [O_OPTION_SD]
		do

				yyval26 := yytype26 (yyvs.item (yyvsp - 2))
				yyval26.extend (yytype11 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval26
		end

	yy_do_action_86 is
			--|#line 389
		local
			yyval11: O_OPTION_SD
		do

create yyval11.initialize (yytype13 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp - 1)), yytype22 (yyvs.item (yyvsp))) 
			yyval := yyval11
		end

	yy_do_action_88 is
			--|#line 395
		local
			yyval22: LACE_LIST [ID_SD]
		do

yyval22 := yytype22 (yyvs.item (yyvsp)) 
			yyval := yyval22
		end

	yy_do_action_89 is
			--|#line 399
		local
			yyval22: LACE_LIST [ID_SD]
		do

				create yyval22.make (10)
				yyval22.extend (yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_90 is
			--|#line 404
		local
			yyval22: LACE_LIST [ID_SD]
		do

				yyval22 := yytype22 (yyvs.item (yyvsp - 2))
				yyval22.extend (yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_92 is
			--|#line 413
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := yytype12 (yyvs.item (yyvsp - 1)) 
			yyval := yyval12
		end

	yy_do_action_93 is
			--|#line 417
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval12
		end

	yy_do_action_94 is
			--|#line 419
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval12
		end

	yy_do_action_95 is
			--|#line 421
		local
			yyval12: OPT_VAL_SD
		do

create yyval12.make (yytype8 (yyvs.item (yyvsp))) 
			yyval := yyval12
		end

	yy_do_action_96 is
			--|#line 425
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Yes_keyword 
			yyval := yyval12
		end

	yy_do_action_97 is
			--|#line 427
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := No_keyword 
			yyval := yyval12
		end

	yy_do_action_98 is
			--|#line 429
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := All_keyword 
			yyval := yyval12
		end

	yy_do_action_99 is
			--|#line 433
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Require_keyword 
			yyval := yyval12
		end

	yy_do_action_100 is
			--|#line 435
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Ensure_keyword 
			yyval := yyval12
		end

	yy_do_action_101 is
			--|#line 437
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Invariant_keyword 
			yyval := yyval12
		end

	yy_do_action_102 is
			--|#line 439
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Loop_keyword 
			yyval := yyval12
		end

	yy_do_action_103 is
			--|#line 441
		local
			yyval12: OPT_VAL_SD
		do

yyval12 := Check_keyword 
			yyval := yyval12
		end

	yy_do_action_105 is
			--|#line 447
		local
			yyval20: LACE_LIST [ASSEMBLY_SD]
		do

yyval20 := yytype20 (yyvs.item (yyvsp)) 
			yyval := yyval20
		end

	yy_do_action_107 is
			--|#line 453
		local
			yyval20: LACE_LIST [ASSEMBLY_SD]
		do

				create yyval20.make (5)
				yyval20.extend (yytype6 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval20
		end

	yy_do_action_108 is
			--|#line 458
		local
			yyval20: LACE_LIST [ASSEMBLY_SD]
		do

				yyval20 := yytype20 (yyvs.item (yyvsp - 2))
				yyval20.extend (yytype6 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval20
		end

	yy_do_action_109 is
			--|#line 465
		local
			yyval6: ASSEMBLY_SD
		do

					-- name: "assembly_name"
				create yyval6.initialize (yytype8 (yyvs.item (yyvsp - 3)), yytype8 (yyvs.item (yyvsp - 1)), yytype8 (yyvs.item (yyvsp)), Void, Void, Void)
			
			yyval := yyval6
		end

	yy_do_action_110 is
			--|#line 470
		local
			yyval6: ASSEMBLY_SD
		do

					-- name: "assembly_name", "version", "culture", "public_key_token"
				create yyval6.initialize (yytype8 (yyvs.item (yyvsp - 9)), yytype8 (yyvs.item (yyvsp - 7)), yytype8 (yyvs.item (yyvsp)), yytype8 (yyvs.item (yyvsp - 5)), yytype8 (yyvs.item (yyvsp - 3)), yytype8 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval6
		end

	yy_do_action_112 is
			--|#line 479
		local
			yyval8: ID_SD
		do

yyval8 := yytype8 (yyvs.item (yyvsp - 1)) 
			yyval := yyval8
		end

	yy_do_action_114 is
			--|#line 485
		local
			yyval25: LACE_LIST [LANG_TRIB_SD]
		do

yyval25 := yytype25 (yyvs.item (yyvsp)) 
			yyval := yyval25
		end

	yy_do_action_116 is
			--|#line 491
		local
			yyval25: LACE_LIST [LANG_TRIB_SD]
		do

				create yyval25.make (10)
				yyval25.extend (yytype9 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval25
		end

	yy_do_action_117 is
			--|#line 496
		local
			yyval25: LACE_LIST [LANG_TRIB_SD]
		do

				yyval25 := yytype25 (yyvs.item (yyvsp - 2))
				yyval25.extend (yytype9 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval25
		end

	yy_do_action_118 is
			--|#line 503
		local
			yyval9: LANG_TRIB_SD
		do

create yyval9.initialize (yytype10 (yyvs.item (yyvsp - 2)), yytype22 (yyvs.item (yyvsp))) 
			yyval := yyval9
		end

	yy_do_action_119 is
			--|#line 507
		local
			yyval10: LANGUAGE_NAME_SD
		do

create yyval10.initialize (yytype8 (yyvs.item (yyvsp))) 
			yyval := yyval10
		end

	yy_do_action_123 is
			--|#line 520
		local

		do
			yyval := yyval_default;
--		create $$.make (10)
--		$$.extend ($1)
	

		end

	yy_do_action_124 is
			--|#line 525
		local

		do
			yyval := yyval_default;
--		$$ := $1
--		$$.extend ($2)
	

		end

	yy_do_action_131 is
			--|#line 550
		local
			yyval17: LACE_LIST [CLAS_VISI_SD]
		do

yyval17 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval17
		end

	yy_do_action_132 is
			--|#line 554
		local
			yyval17: LACE_LIST [CLAS_VISI_SD]
		do

yyval17 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval17
		end

	yy_do_action_134 is
			--|#line 560
		local
			yyval17: LACE_LIST [CLAS_VISI_SD]
		do

				create yyval17.make (10)
				yyval17.extend (yytype2 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval17
		end

	yy_do_action_135 is
			--|#line 565
		local
			yyval17: LACE_LIST [CLAS_VISI_SD]
		do

				yyval17 := yytype17 (yyvs.item (yyvsp - 2))
				yyval17.extend (yytype2 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval17
		end

	yy_do_action_136 is
			--|#line 572
		local
			yyval2: CLAS_VISI_SD
		do

create yyval2.initialize (yytype8 (yyvs.item (yyvsp)), Void, Void, Void, Void) 
			yyval := yyval2
		end

	yy_do_action_137 is
			--|#line 574
		local
			yyval2: CLAS_VISI_SD
		do

create yyval2.initialize (yytype8 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void) 
			yyval := yyval2
		end

	yy_do_action_138 is
			--|#line 576
		local
			yyval2: CLAS_VISI_SD
		do

create yyval2.initialize (yytype8 (yyvs.item (yyvsp - 2)), Void, Void, Void, yytype27 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_139 is
			--|#line 578
		local
			yyval2: CLAS_VISI_SD
		do

create yyval2.initialize (yytype8 (yyvs.item (yyvsp - 3)), Void, Void, yytype22 (yyvs.item (yyvsp - 2)), yytype27 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_140 is
			--|#line 580
		local
			yyval2: CLAS_VISI_SD
		do

create yyval2.initialize (yytype8 (yyvs.item (yyvsp - 4)), Void, yytype22 (yyvs.item (yyvsp - 3)), yytype22 (yyvs.item (yyvsp - 2)), yytype27 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_141 is
			--|#line 582
		local
			yyval2: CLAS_VISI_SD
		do

create yyval2.initialize (yytype8 (yyvs.item (yyvsp - 5)), yytype8 (yyvs.item (yyvsp - 4)), yytype22 (yyvs.item (yyvsp - 3)), yytype22 (yyvs.item (yyvsp - 2)), yytype27 (yyvs.item (yyvsp - 1))) 
			yyval := yyval2
		end

	yy_do_action_142 is
			--|#line 586
		local
			yyval8: ID_SD
		do

yyval8 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval8
		end

	yy_do_action_144 is
			--|#line 592
		local
			yyval22: LACE_LIST [ID_SD]
		do

yyval22 := yytype22 (yyvs.item (yyvsp)) 
			yyval := yyval22
		end

	yy_do_action_145 is
			--|#line 596
		local
			yyval22: LACE_LIST [ID_SD]
		do

yyval22 := yytype22 (yyvs.item (yyvsp)) 
			yyval := yyval22
		end

	yy_do_action_147 is
			--|#line 602
		local
			yyval22: LACE_LIST [ID_SD]
		do

yyval22 := yytype22 (yyvs.item (yyvsp)) 
			yyval := yyval22
		end

	yy_do_action_148 is
			--|#line 606
		local
			yyval22: LACE_LIST [ID_SD]
		do

yyval22 := yytype22 (yyvs.item (yyvsp)) 
			yyval := yyval22
		end

	yy_do_action_150 is
			--|#line 612
		local
			yyval22: LACE_LIST [ID_SD]
		do

				create yyval22.make (10)
				yyval22.extend (yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_151 is
			--|#line 617
		local
			yyval22: LACE_LIST [ID_SD]
		do

				yyval22 := yytype22 (yyvs.item (yyvsp - 2))
				yyval22.extend (yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_153 is
			--|#line 626
		local
			yyval27: LACE_LIST [TWO_NAME_SD]
		do

yyval27 := yytype27 (yyvs.item (yyvsp)) 
			yyval := yyval27
		end

	yy_do_action_154 is
			--|#line 630
		local
			yyval27: LACE_LIST [TWO_NAME_SD]
		do

yyval27 := yytype27 (yyvs.item (yyvsp)) 
			yyval := yyval27
		end

	yy_do_action_155 is
			--|#line 634
		local
			yyval27: LACE_LIST [TWO_NAME_SD]
		do

				create yyval27.make (10)
				yyval27.extend (yytype15 (yyvs.item (yyvsp)))
			
			yyval := yyval27
		end

	yy_do_action_156 is
			--|#line 639
		local
			yyval27: LACE_LIST [TWO_NAME_SD]
		do

				yyval27 := yytype27 (yyvs.item (yyvsp - 2))
				yyval27.extend (yytype15 (yyvs.item (yyvsp)))
			
			yyval := yyval27
		end

	yy_do_action_158 is
			--|#line 648
		local
			yyval15: TWO_NAME_SD
		do

create yyval15.initialize (yytype8 (yyvs.item (yyvsp - 2)), yytype8 (yyvs.item (yyvsp))) 
			yyval := yyval15
		end

	yy_do_action_159 is
			--|#line 652
		local
			yyval8: ID_SD
		do

yyval8 := new_id_sd (token_buffer, False) 
			yyval := yyval8
		end

	yy_do_action_160 is
			--|#line 654
		local
			yyval8: ID_SD
		do

yyval8 := new_id_sd (token_buffer, True) 
			yyval := yyval8
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
			    0,  113,  113,   46,   58,   70,  112,   59,   59,   60,
			   60,   80,   80,   81,   81,   50,   50,   50,   50,   50,
			   50,   57,   57,   48,   48,   48,   48,   48,   48,   48,
			   48,  111,  111,  110,  110,   73,   56,   56,   55,   99,
			   99,   98,   98,   96,   96,   95,   95,  100,  100,   97,
			   97,   94,   94,   78,   78,   77,   77,   79,   79,   49,
			   49,  109,  109,   72,   86,   86,   85,   85,  105,  105,
			  104,  104,   84,   84,   52,   52,   52,   52,   69,   69,
			   69,   69,   69,   69,  103,  103,   64,   92,   92,   93,
			   93,   65,   65,   66,   66,   66,   67,   67,   67,   68,

			   68,   68,   68,   68,   82,   82,   82,   83,   83,   51,
			   51,   61,   61,  101,  101,  101,  102,  102,   62,   63,
			  114,  114,  114,  116,  116,  117,  118,  118,  119,  119,
			   76,   76,   75,   75,   74,   74,   47,   47,   47,   47,
			   47,   47,   54,   91,   91,   90,   89,   89,   88,   87,
			   87,   87,  108,  108,  107,  106,  106,   71,   71,   53,
			   53,  115,  115>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,    1,    1,    8,    2,    4,    1,    0,    3,    0,
			    2,    2,    2,    2,    3,    4,    5,    5,    6,    7,
			    7,    0,    3,    8,    7,    6,    5,    4,    3,    2,
			    1,    2,    2,    2,    3,    3,    0,    1,    2,    0,
			    1,    2,    2,    0,    1,    2,    2,    2,    3,    2,
			    3,    1,    3,    0,    1,    2,    2,    2,    3,    3,
			    4,    1,    3,    3,    0,    1,    2,    2,    0,    1,
			    2,    2,    2,    3,    2,    3,    4,    2,    1,    1,
			    1,    1,    1,    1,    2,    3,    3,    0,    2,    1,
			    3,    0,    3,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    0,    2,    2,    2,    3,    4,
			   10,    0,    3,    0,    2,    2,    2,    3,    3,    1,
			    0,    2,    2,    2,    3,    4,    0,    3,    1,    1,
			    0,    1,    2,    2,    2,    3,    1,    2,    3,    4,
			    5,    6,    2,    0,    1,    2,    0,    1,    2,    0,
			    1,    3,    0,    1,    2,    1,    3,    0,    3,    1,
			    1,    0,    1>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  161,    0,    0,  161,  161,  161,  161,  161,  161,
			    1,    2,   39,    0,   30,   64,   68,   53,   43,  130,
			   36,  160,  162,  159,  161,  136,  132,  133,   38,    4,
			   82,   81,   80,   79,   78,   83,  161,   91,   70,   71,
			  161,   41,   42,   51,  161,    0,   31,   32,  161,   45,
			   46,   91,  161,   91,   66,   67,  161,    0,   55,   56,
			   40,   43,    0,   64,   65,   68,   69,  130,   54,   64,
			   44,   53,  131,   29,   37,   39,  134,  157,  149,  137,
			  149,    0,  143,  152,  146,    0,  161,   84,    0,   87,
			  161,   47,  161,   33,    0,    0,  161,   49,  161,   74,

			   72,   77,  161,   57,    0,  161,   53,    6,    7,    0,
			  130,   28,   68,   64,   43,    0,  155,  154,  150,  148,
			  145,  142,  144,  146,  153,    0,  147,  152,  138,  135,
			   96,   99,   97,  102,  101,  100,  103,   98,   95,    0,
			   93,   94,    0,   86,   85,   48,   52,   35,   34,   50,
			   75,    0,   73,    0,   59,   58,   64,    0,    9,  161,
			  104,   27,  130,   68,   53,    0,  157,    0,  152,  139,
			    0,   92,   89,   88,   76,    0,   61,   60,   68,    0,
			    0,    5,    0,    0,  161,   21,   11,   12,  161,  113,
			   26,  130,   64,  158,  156,  151,    0,  140,    0,    0,

			    0,  130,    8,   10,   21,   21,   13,    0,    0,  161,
			  161,    0,  105,  106,  161,  120,   25,   68,  141,   90,
			   63,   62,   24,    0,    0,    0,    0,   14,  107,    0,
			  161,  119,  161,    0,  114,  115,  161,    0,  130,    0,
			    0,   22,   15,  111,  108,  116,    0,  161,  126,  122,
			  121,  161,    3,   23,   17,   16,    0,    0,    0,  109,
			  118,  117,    0,    0,  161,  123,    0,    0,   18,    0,
			    0,  128,  129,    0,    0,  124,   20,   19,  112,    0,
			  127,  125,    0,    0,  111,  110,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   10,   24,   11,   56,  184,  210,   52,   35,   82,   12,
			   75,  208,   13,  158,  181,  259,  232,  233,   36,   89,
			  139,  140,  141,   37,   63,  116,  176,   44,   26,   72,
			   73,   15,   69,   58,  160,  186,  189,  212,   54,   64,
			   65,  119,  126,  127,   84,  123,  143,  173,   45,   17,
			   71,   49,   18,   61,   41,  215,  234,   38,   66,   67,
			  117,  124,  125,  177,   46,   20,  108,  286,  237,   27,
			  250,  251,  263,  273>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   92,   45,    4,    4,  132,   45,   45,   45,  154,   45,
			 -32768, -32768,  184,  185, -32768,  134,   90,  173,  182,   72,
			  168, -32768, -32768, -32768,   52,   18,    4, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,   52,  178,  284, -32768,
			   52,    4, -32768, -32768,   52,   78,    4, -32768,   52,    4,
			 -32768,  178,   52,  178,  262, -32768,   52,  198,    4, -32768,
			 -32768,  182,    4,  134, -32768,   90, -32768,   72, -32768,  134,
			 -32768,  173, -32768, -32768, -32768,  184, -32768,    4,    4, -32768,
			    4,    4,  195,  141,  169,  188,   52, -32768,   74,  193,
			   52, -32768,   52, -32768,    4,    4,   52, -32768,   52,    8,

			 -32768, -32768,   52, -32768,    5,   52,  173, -32768,  175,  192,
			   72, -32768,   90,  134,  182,  191, -32768,  183, -32768,  180,
			  180, -32768, -32768,  169, -32768,  174, -32768,  141, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  152,
			 -32768, -32768,    4, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  167, -32768,    4, -32768, -32768,  134,    4,  170,   24,
			  172, -32768,   72,   90,  173,    4,    4,    4,  141, -32768,
			  156, -32768, -32768,  157, -32768,  158, -32768,  138,   90,  124,
			    4, -32768,    4,    4,   52,  113,   28, -32768,   45,  125,
			 -32768,   72,  134, -32768, -32768, -32768,  127, -32768,    4,    4,

			    4,   72, -32768, -32768,  113,  113, -32768,    4,  123,   52,
			   52,  121,    4, -32768,   45,  106, -32768,   90, -32768, -32768,
			 -32768, -32768, -32768,  116,  114,   86,    4, -32768, -32768,    4,
			   52, -32768,   52,   91,    4, -32768,   45,  103,   72,    4,
			    4, -32768,  111,   11, -32768, -32768,    4,   52,   89, -32768,
			    4,   52, -32768, -32768,  111,  111,   88,    4,    4, -32768,
			   85, -32768,   -3,   82,   52, -32768,   70,   65, -32768,   58,
			   61, -32768, -32768,   34,    4, -32768, -32768, -32768, -32768,    4,
			 -32768, -32768,   47,    4,   20, -32768,   37,   35, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -32768,  218, -104,  189,   57,   30,  187,   -1, -32768,  220,
			 -32768, -149, -32768, -32768, -32768,  -53,    2, -200,  199,  -20,
			 -32768, -32768, -32768,   12, -32768,   64,   29,  186, -32768,   17,
			  -64,   -7,  -57, -32768, -32768, -32768, -32768, -32768, -32768,   13,
			  -48,  147,  201,  100,  142, -32768, -32768, -32768,  -25,   -2,
			  -43, -32768,    0,  145, -32768, -32768, -32768, -32768,    9,  -58,
			 -32768,  -14, -108, -32768, -32768, -32768, -32768, -32768, -32768,  210,
			 -32768,  -38, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   25,   28,   29,  111,   40,   43,   48,  110,   57,   19,
			   68,   85,   60,   16,  113,  109,   70,   14,  106,  170,
			   53,  112,  258,   81,  150,   25,  272,   23,  183,  154,
			   80,   99,  183,  101,   79,  288,  248,  287,   78,  153,
			   92,  271,   77,   21,  257,   43,  161,   23,   98,  156,
			  248,   23,   77,  257,  162,  223,  224,   57,  283,   70,
			  196,  107,   22,   21,   68,  163,   53,   21,   23,  182,
			  280,  164,  279,  182,  278,   60,  115,  118,  137,  118,
			  121,  277,  136,   22,   21,  151,  276,  138,   95,   94,
			   22,  135,  274,  146,  147,    9,   94,   23,  190,   68,

			  134,  246,  133,  132,  268,  191,    8,  192,  178,  131,
			    7,    6,   70,   21,    9,    1,  262,    5,  130,  252,
			  201,    4,  241,    4,  240,    8,  239,  216,  236,    7,
			    6,  229,    3,  226,    2,    1,    5,  222,  256,   34,
			  207,  172,    4,  218,  217,   33,  214,   32,    8,  200,
			  266,  267,  175,    2,    1,   23,  179,   68,  185,  238,
			  202,   34,   31,  199,  193,  115,  195,   33,  198,   32,
			   22,   21,  197,   30,  253,   77,    9,   23,  188,  203,
			  180,  204,  205,  174,   31,  185,   51,  211,  171,   78,
			  169,  167,   22,   21,  166,   30,  165,  219,  220,  175,

			    7,  159,  157,  142,  128,   88,  225,   80,  104,    5,
			    2,  211,  264,  231,   39,   42,   47,   50,   55,   59,
			  114,  260,   62,  168,  122,  242,   83,  120,  243,  221,
			  194,  285,   96,  231,   76,  231,  247,   90,  254,  255,
			   74,  102,  230,  209,   86,   43,   87,  105,    0,  231,
			   91,   19,    0,    0,   93,   16,  269,  270,   97,   14,
			    0,    0,  100,   19,   19,    0,  103,   16,   16,   34,
			    0,   14,   14,  281,    0,   33,    0,   32,  282,    0,
			    0,    0,  284,    0,    0,   23,    0,    0,    0,    0,
			    0,   34,   31,    0,   51,    0,  129,   33,    0,   32,

			  144,   21,  145,   30,    0,    0,  148,   23,  149,    0,
			    0,    0,  152,    0,   31,  155,    0,    0,    0,    0,
			    0,    0,    0,   21,    0,   30,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  187,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  206,    0,    0,    0,  213,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  227,
			  228,    0,    0,    0,  235,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  244,    0,  245,    0,    0,    0,  249,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  261,    0,    0,
			    0,  265,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  275>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,    2,    3,   67,    5,    6,    7,   65,    9,    0,
			   17,   25,   12,    0,   71,   63,   18,    0,   61,  127,
			    8,   69,   11,    5,   16,   26,   29,   23,    4,   24,
			   12,   51,    4,   53,   16,    0,  236,    0,   20,   34,
			   41,   44,   34,   39,   33,   46,  110,   23,   49,  106,
			  250,   23,   34,   33,  112,  204,  205,   58,   11,   61,
			  168,   62,   38,   39,   71,  113,   54,   39,   23,   45,
			   36,  114,   11,   45,   16,   75,   77,   78,    4,   80,
			   81,   16,    8,   38,   39,   99,   16,   88,   10,   11,
			   38,   17,   10,   94,   95,    3,   11,   23,  162,  106,

			   26,   10,   28,   29,   16,  163,   14,  164,  156,   35,
			   18,   19,  114,   39,    3,   43,   27,   25,   44,   16,
			  178,   31,   36,   31,   10,   14,   10,  191,   22,   18,
			   19,   10,   40,   10,   42,   43,   25,  201,  242,    7,
			   27,  142,   31,   16,  192,   13,   21,   15,   14,   11,
			  254,  255,  153,   42,   43,   23,  157,  164,  159,  217,
			   36,    7,   30,    5,  165,  166,  167,   13,   11,   15,
			   38,   39,   16,   41,  238,   34,    3,   23,    6,  180,
			   10,  182,  183,   16,   30,  186,   32,  188,   36,   20,
			   16,   11,   38,   39,   11,   41,    5,  198,  199,  200,

			   18,    9,   27,   10,   16,   27,  207,   12,   10,   25,
			   42,  212,  250,  214,    4,    5,    6,    7,    8,    9,
			   75,  246,   37,  123,   82,  226,   25,   80,  229,  200,
			  166,  284,   46,  234,   24,  236,  234,   38,  239,  240,
			   20,   54,  212,  186,   26,  246,   36,   58,   -1,  250,
			   40,  242,   -1,   -1,   44,  242,  257,  258,   48,  242,
			   -1,   -1,   52,  254,  255,   -1,   56,  254,  255,    7,
			   -1,  254,  255,  274,   -1,   13,   -1,   15,  279,   -1,
			   -1,   -1,  283,   -1,   -1,   23,   -1,   -1,   -1,   -1,
			   -1,    7,   30,   -1,   32,   -1,   86,   13,   -1,   15,

			   90,   39,   92,   41,   -1,   -1,   96,   23,   98,   -1,
			   -1,   -1,  102,   -1,   30,  105,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   39,   -1,   41,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  159,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  184,   -1,   -1,   -1,  188,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  209,
			  210,   -1,   -1,   -1,  214,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  230,   -1,  232,   -1,   -1,   -1,  236,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  247,   -1,   -1,
			   -1,  251,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  264>>)
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

	yytype6 (v: ANY): ASSEMBLY_SD is
		require
			valid_type: yyis_type6 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type6 (v: ANY): BOOLEAN is
		local
			u: ASSEMBLY_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype7 (v: ANY): D_OPTION_SD is
		require
			valid_type: yyis_type7 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type7 (v: ANY): BOOLEAN is
		local
			u: D_OPTION_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype8 (v: ANY): ID_SD is
		require
			valid_type: yyis_type8 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type8 (v: ANY): BOOLEAN is
		local
			u: ID_SD
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

	yytype16 (v: ANY): DEPEND_SD is
		require
			valid_type: yyis_type16 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type16 (v: ANY): BOOLEAN is
		local
			u: DEPEND_SD
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

	yytype20 (v: ANY): LACE_LIST [ASSEMBLY_SD] is
		require
			valid_type: yyis_type20 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type20 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [ASSEMBLY_SD]
		do
			u ?= v
			Result := (u = v)
		end

	yytype21 (v: ANY): LACE_LIST [D_OPTION_SD] is
		require
			valid_type: yyis_type21 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type21 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [D_OPTION_SD]
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

	yytype23 (v: ANY): FILE_NAME_SD is
		require
			valid_type: yyis_type23 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type23 (v: ANY): BOOLEAN is
		local
			u: FILE_NAME_SD
		do
			u ?= v
			Result := (u = v)
		end

	yytype24 (v: ANY): LACE_LIST [FILE_NAME_SD] is
		require
			valid_type: yyis_type24 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type24 (v: ANY): BOOLEAN is
		local
			u: LACE_LIST [FILE_NAME_SD]
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

	yyFinal: INTEGER is 288
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 46
			-- Number of tokens

	yyLast: INTEGER is 474
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 300
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 120
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
