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
	make, make_il_parser, make_type_parser

feature {NONE} -- Implementation

	yy_build_parser_tables is
			-- Build parser tables.
		do
			yytranslate ?= yytranslate_template
			yyr1 ?= yyr1_template
			yytypes1 ?= yytypes1_template
			yytypes2 ?= yytypes2_template
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
					--|#line 173 "eiffel.y"
				yy_do_action_1
			when 2 then
					--|#line 180 "eiffel.y"
				yy_do_action_2
			when 3 then
					--|#line 189 "eiffel.y"
				yy_do_action_3
			when 4 then
					--|#line 232 "eiffel.y"
				yy_do_action_4
			when 5 then
					--|#line 241 "eiffel.y"
				yy_do_action_5
			when 6 then
					--|#line 245 "eiffel.y"
				yy_do_action_6
			when 7 then
					--|#line 252 "eiffel.y"
				yy_do_action_7
			when 8 then
					--|#line 254 "eiffel.y"
				yy_do_action_8
			when 9 then
					--|#line 256 "eiffel.y"
				yy_do_action_9
			when 10 then
					--|#line 260 "eiffel.y"
				yy_do_action_10
			when 11 then
					--|#line 262 "eiffel.y"
				yy_do_action_11
			when 12 then
					--|#line 264 "eiffel.y"
				yy_do_action_12
			when 13 then
					--|#line 268 "eiffel.y"
				yy_do_action_13
			when 14 then
					--|#line 270 "eiffel.y"
				yy_do_action_14
			when 15 then
					--|#line 272 "eiffel.y"
				yy_do_action_15
			when 16 then
					--|#line 276 "eiffel.y"
				yy_do_action_16
			when 17 then
					--|#line 281 "eiffel.y"
				yy_do_action_17
			when 18 then
					--|#line 288 "eiffel.y"
				yy_do_action_18
			when 19 then
					--|#line 292 "eiffel.y"
				yy_do_action_19
			when 20 then
					--|#line 294 "eiffel.y"
				yy_do_action_20
			when 21 then
					--|#line 306 "eiffel.y"
				yy_do_action_21
			when 22 then
					--|#line 311 "eiffel.y"
				yy_do_action_22
			when 23 then
					--|#line 316 "eiffel.y"
				yy_do_action_23
			when 24 then
					--|#line 323 "eiffel.y"
				yy_do_action_24
			when 25 then
					--|#line 325 "eiffel.y"
				yy_do_action_25
			when 26 then
					--|#line 327 "eiffel.y"
				yy_do_action_26
			when 27 then
					--|#line 331 "eiffel.y"
				yy_do_action_27
			when 28 then
					--|#line 341 "eiffel.y"
				yy_do_action_28
			when 29 then
					--|#line 347 "eiffel.y"
				yy_do_action_29
			when 30 then
					--|#line 354 "eiffel.y"
				yy_do_action_30
			when 31 then
					--|#line 360 "eiffel.y"
				yy_do_action_31
			when 32 then
					--|#line 368 "eiffel.y"
				yy_do_action_32
			when 33 then
					--|#line 372 "eiffel.y"
				yy_do_action_33
			when 34 then
					--|#line 383 "eiffel.y"
				yy_do_action_34
			when 35 then
					--|#line 387 "eiffel.y"
				yy_do_action_35
			when 36 then
					--|#line 402 "eiffel.y"
				yy_do_action_36
			when 37 then
					--|#line 404 "eiffel.y"
				yy_do_action_37
			when 38 then
					--|#line 411 "eiffel.y"
				yy_do_action_38
			when 39 then
					--|#line 413 "eiffel.y"
				yy_do_action_39
			when 40 then
					--|#line 422 "eiffel.y"
				yy_do_action_40
			when 41 then
					--|#line 427 "eiffel.y"
				yy_do_action_41
			when 42 then
					--|#line 434 "eiffel.y"
				yy_do_action_42
			when 43 then
					--|#line 436 "eiffel.y"
				yy_do_action_43
			when 44 then
					--|#line 440 "eiffel.y"
				yy_do_action_44
			when 45 then
					--|#line 440 "eiffel.y"
				yy_do_action_45
			when 46 then
					--|#line 449 "eiffel.y"
				yy_do_action_46
			when 47 then
					--|#line 451 "eiffel.y"
				yy_do_action_47
			when 48 then
					--|#line 455 "eiffel.y"
				yy_do_action_48
			when 49 then
					--|#line 460 "eiffel.y"
				yy_do_action_49
			when 50 then
					--|#line 464 "eiffel.y"
				yy_do_action_50
			when 51 then
					--|#line 470 "eiffel.y"
				yy_do_action_51
			when 52 then
					--|#line 478 "eiffel.y"
				yy_do_action_52
			when 53 then
					--|#line 483 "eiffel.y"
				yy_do_action_53
			when 54 then
					--|#line 490 "eiffel.y"
				yy_do_action_54
			when 55 then
					--|#line 491 "eiffel.y"
				yy_do_action_55
			when 56 then
					--|#line 494 "eiffel.y"
				yy_do_action_56
			when 57 then
					--|#line 507 "eiffel.y"
				yy_do_action_57
			when 58 then
					--|#line 509 "eiffel.y"
				yy_do_action_58
			when 59 then
					--|#line 516 "eiffel.y"
				yy_do_action_59
			when 60 then
					--|#line 520 "eiffel.y"
				yy_do_action_60
			when 61 then
					--|#line 522 "eiffel.y"
				yy_do_action_61
			when 62 then
					--|#line 526 "eiffel.y"
				yy_do_action_62
			when 63 then
					--|#line 528 "eiffel.y"
				yy_do_action_63
			when 64 then
					--|#line 530 "eiffel.y"
				yy_do_action_64
			when 65 then
					--|#line 534 "eiffel.y"
				yy_do_action_65
			when 66 then
					--|#line 539 "eiffel.y"
				yy_do_action_66
			when 67 then
					--|#line 543 "eiffel.y"
				yy_do_action_67
			when 68 then
					--|#line 547 "eiffel.y"
				yy_do_action_68
			when 69 then
					--|#line 549 "eiffel.y"
				yy_do_action_69
			when 70 then
					--|#line 553 "eiffel.y"
				yy_do_action_70
			when 71 then
					--|#line 558 "eiffel.y"
				yy_do_action_71
			when 72 then
					--|#line 563 "eiffel.y"
				yy_do_action_72
			when 73 then
					--|#line 574 "eiffel.y"
				yy_do_action_73
			when 74 then
					--|#line 576 "eiffel.y"
				yy_do_action_74
			when 75 then
					--|#line 578 "eiffel.y"
				yy_do_action_75
			when 76 then
					--|#line 582 "eiffel.y"
				yy_do_action_76
			when 77 then
					--|#line 587 "eiffel.y"
				yy_do_action_77
			when 78 then
					--|#line 594 "eiffel.y"
				yy_do_action_78
			when 79 then
					--|#line 599 "eiffel.y"
				yy_do_action_79
			when 80 then
					--|#line 607 "eiffel.y"
				yy_do_action_80
			when 81 then
					--|#line 612 "eiffel.y"
				yy_do_action_81
			when 82 then
					--|#line 617 "eiffel.y"
				yy_do_action_82
			when 83 then
					--|#line 622 "eiffel.y"
				yy_do_action_83
			when 84 then
					--|#line 627 "eiffel.y"
				yy_do_action_84
			when 85 then
					--|#line 632 "eiffel.y"
				yy_do_action_85
			when 86 then
					--|#line 637 "eiffel.y"
				yy_do_action_86
			when 87 then
					--|#line 645 "eiffel.y"
				yy_do_action_87
			when 88 then
					--|#line 647 "eiffel.y"
				yy_do_action_88
			when 89 then
					--|#line 651 "eiffel.y"
				yy_do_action_89
			when 90 then
					--|#line 656 "eiffel.y"
				yy_do_action_90
			when 91 then
					--|#line 663 "eiffel.y"
				yy_do_action_91
			when 92 then
					--|#line 667 "eiffel.y"
				yy_do_action_92
			when 93 then
					--|#line 669 "eiffel.y"
				yy_do_action_93
			when 94 then
					--|#line 673 "eiffel.y"
				yy_do_action_94
			when 95 then
					--|#line 681 "eiffel.y"
				yy_do_action_95
			when 96 then
					--|#line 685 "eiffel.y"
				yy_do_action_96
			when 97 then
					--|#line 692 "eiffel.y"
				yy_do_action_97
			when 98 then
					--|#line 701 "eiffel.y"
				yy_do_action_98
			when 99 then
					--|#line 709 "eiffel.y"
				yy_do_action_99
			when 100 then
					--|#line 711 "eiffel.y"
				yy_do_action_100
			when 101 then
					--|#line 713 "eiffel.y"
				yy_do_action_101
			when 102 then
					--|#line 717 "eiffel.y"
				yy_do_action_102
			when 103 then
					--|#line 719 "eiffel.y"
				yy_do_action_103
			when 104 then
					--|#line 725 "eiffel.y"
				yy_do_action_104
			when 105 then
					--|#line 730 "eiffel.y"
				yy_do_action_105
			when 106 then
					--|#line 738 "eiffel.y"
				yy_do_action_106
			when 107 then
					--|#line 744 "eiffel.y"
				yy_do_action_107
			when 108 then
					--|#line 752 "eiffel.y"
				yy_do_action_108
			when 109 then
					--|#line 757 "eiffel.y"
				yy_do_action_109
			when 110 then
					--|#line 764 "eiffel.y"
				yy_do_action_110
			when 111 then
					--|#line 766 "eiffel.y"
				yy_do_action_111
			when 112 then
					--|#line 770 "eiffel.y"
				yy_do_action_112
			when 113 then
					--|#line 772 "eiffel.y"
				yy_do_action_113
			when 114 then
					--|#line 776 "eiffel.y"
				yy_do_action_114
			when 115 then
					--|#line 778 "eiffel.y"
				yy_do_action_115
			when 116 then
					--|#line 782 "eiffel.y"
				yy_do_action_116
			when 117 then
					--|#line 784 "eiffel.y"
				yy_do_action_117
			when 118 then
					--|#line 788 "eiffel.y"
				yy_do_action_118
			when 119 then
					--|#line 790 "eiffel.y"
				yy_do_action_119
			when 120 then
					--|#line 794 "eiffel.y"
				yy_do_action_120
			when 121 then
					--|#line 796 "eiffel.y"
				yy_do_action_121
			when 122 then
					--|#line 804 "eiffel.y"
				yy_do_action_122
			when 123 then
					--|#line 806 "eiffel.y"
				yy_do_action_123
			when 124 then
					--|#line 810 "eiffel.y"
				yy_do_action_124
			when 125 then
					--|#line 812 "eiffel.y"
				yy_do_action_125
			when 126 then
					--|#line 816 "eiffel.y"
				yy_do_action_126
			when 127 then
					--|#line 821 "eiffel.y"
				yy_do_action_127
			when 128 then
					--|#line 828 "eiffel.y"
				yy_do_action_128
			when 129 then
					--|#line 832 "eiffel.y"
				yy_do_action_129
			when 130 then
					--|#line 833 "eiffel.y"
				yy_do_action_130
			when 131 then
					--|#line 842 "eiffel.y"
				yy_do_action_131
			when 132 then
					--|#line 844 "eiffel.y"
				yy_do_action_132
			when 133 then
					--|#line 848 "eiffel.y"
				yy_do_action_133
			when 134 then
					--|#line 853 "eiffel.y"
				yy_do_action_134
			when 135 then
					--|#line 860 "eiffel.y"
				yy_do_action_135
			when 136 then
					--|#line 864 "eiffel.y"
				yy_do_action_136
			when 137 then
					--|#line 870 "eiffel.y"
				yy_do_action_137
			when 138 then
					--|#line 878 "eiffel.y"
				yy_do_action_138
			when 139 then
					--|#line 880 "eiffel.y"
				yy_do_action_139
			when 140 then
					--|#line 884 "eiffel.y"
				yy_do_action_140
			when 141 then
					--|#line 886 "eiffel.y"
				yy_do_action_141
			when 142 then
					--|#line 890 "eiffel.y"
				yy_do_action_142
			when 143 then
					--|#line 890 "eiffel.y"
				yy_do_action_143
			when 144 then
					--|#line 902 "eiffel.y"
				yy_do_action_144
			when 145 then
					--|#line 904 "eiffel.y"
				yy_do_action_145
			when 146 then
					--|#line 906 "eiffel.y"
				yy_do_action_146
			when 147 then
					--|#line 910 "eiffel.y"
				yy_do_action_147
			when 148 then
					--|#line 917 "eiffel.y"
				yy_do_action_148
			when 149 then
					--|#line 922 "eiffel.y"
				yy_do_action_149
			when 150 then
					--|#line 924 "eiffel.y"
				yy_do_action_150
			when 151 then
					--|#line 928 "eiffel.y"
				yy_do_action_151
			when 152 then
					--|#line 930 "eiffel.y"
				yy_do_action_152
			when 153 then
					--|#line 934 "eiffel.y"
				yy_do_action_153
			when 154 then
					--|#line 936 "eiffel.y"
				yy_do_action_154
			when 155 then
					--|#line 940 "eiffel.y"
				yy_do_action_155
			when 156 then
					--|#line 942 "eiffel.y"
				yy_do_action_156
			when 157 then
					--|#line 946 "eiffel.y"
				yy_do_action_157
			when 158 then
					--|#line 951 "eiffel.y"
				yy_do_action_158
			when 159 then
					--|#line 958 "eiffel.y"
				yy_do_action_159
			when 160 then
					--|#line 962 "eiffel.y"
				yy_do_action_160
			when 161 then
					--|#line 963 "eiffel.y"
				yy_do_action_161
			when 162 then
					--|#line 966 "eiffel.y"
				yy_do_action_162
			when 163 then
					--|#line 968 "eiffel.y"
				yy_do_action_163
			when 164 then
					--|#line 970 "eiffel.y"
				yy_do_action_164
			when 165 then
					--|#line 972 "eiffel.y"
				yy_do_action_165
			when 166 then
					--|#line 974 "eiffel.y"
				yy_do_action_166
			when 167 then
					--|#line 976 "eiffel.y"
				yy_do_action_167
			when 168 then
					--|#line 978 "eiffel.y"
				yy_do_action_168
			when 169 then
					--|#line 980 "eiffel.y"
				yy_do_action_169
			when 170 then
					--|#line 982 "eiffel.y"
				yy_do_action_170
			when 171 then
					--|#line 984 "eiffel.y"
				yy_do_action_171
			when 172 then
					--|#line 988 "eiffel.y"
				yy_do_action_172
			when 173 then
					--|#line 990 "eiffel.y"
				yy_do_action_173
			when 174 then
					--|#line 990 "eiffel.y"
				yy_do_action_174
			when 175 then
					--|#line 997 "eiffel.y"
				yy_do_action_175
			when 176 then
					--|#line 997 "eiffel.y"
				yy_do_action_176
			when 177 then
					--|#line 1006 "eiffel.y"
				yy_do_action_177
			when 178 then
					--|#line 1008 "eiffel.y"
				yy_do_action_178
			when 179 then
					--|#line 1008 "eiffel.y"
				yy_do_action_179
			when 180 then
					--|#line 1015 "eiffel.y"
				yy_do_action_180
			when 181 then
					--|#line 1015 "eiffel.y"
				yy_do_action_181
			when 182 then
					--|#line 1024 "eiffel.y"
				yy_do_action_182
			when 183 then
					--|#line 1026 "eiffel.y"
				yy_do_action_183
			when 184 then
					--|#line 1035 "eiffel.y"
				yy_do_action_184
			when 185 then
					--|#line 1040 "eiffel.y"
				yy_do_action_185
			when 186 then
					--|#line 1047 "eiffel.y"
				yy_do_action_186
			when 187 then
					--|#line 1051 "eiffel.y"
				yy_do_action_187
			when 188 then
					--|#line 1053 "eiffel.y"
				yy_do_action_188
			when 189 then
					--|#line 1055 "eiffel.y"
				yy_do_action_189
			when 190 then
					--|#line 1063 "eiffel.y"
				yy_do_action_190
			when 191 then
					--|#line 1065 "eiffel.y"
				yy_do_action_191
			when 192 then
					--|#line 1069 "eiffel.y"
				yy_do_action_192
			when 193 then
					--|#line 1071 "eiffel.y"
				yy_do_action_193
			when 194 then
					--|#line 1073 "eiffel.y"
				yy_do_action_194
			when 195 then
					--|#line 1075 "eiffel.y"
				yy_do_action_195
			when 196 then
					--|#line 1077 "eiffel.y"
				yy_do_action_196
			when 197 then
					--|#line 1079 "eiffel.y"
				yy_do_action_197
			when 198 then
					--|#line 1083 "eiffel.y"
				yy_do_action_198
			when 199 then
					--|#line 1087 "eiffel.y"
				yy_do_action_199
			when 200 then
					--|#line 1089 "eiffel.y"
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
					--|#line 1091 "eiffel.y"
				yy_do_action_201
			when 202 then
					--|#line 1095 "eiffel.y"
				yy_do_action_202
			when 203 then
					--|#line 1097 "eiffel.y"
				yy_do_action_203
			when 204 then
					--|#line 1101 "eiffel.y"
				yy_do_action_204
			when 205 then
					--|#line 1106 "eiffel.y"
				yy_do_action_205
			when 206 then
					--|#line 1117 "eiffel.y"
				yy_do_action_206
			when 207 then
					--|#line 1123 "eiffel.y"
				yy_do_action_207
			when 208 then
					--|#line 1131 "eiffel.y"
				yy_do_action_208
			when 209 then
					--|#line 1133 "eiffel.y"
				yy_do_action_209
			when 210 then
					--|#line 1137 "eiffel.y"
				yy_do_action_210
			when 211 then
					--|#line 1142 "eiffel.y"
				yy_do_action_211
			when 212 then
					--|#line 1149 "eiffel.y"
				yy_do_action_212
			when 213 then
					--|#line 1149 "eiffel.y"
				yy_do_action_213
			when 214 then
					--|#line 1171 "eiffel.y"
				yy_do_action_214
			when 215 then
					--|#line 1173 "eiffel.y"
				yy_do_action_215
			when 216 then
					--|#line 1181 "eiffel.y"
				yy_do_action_216
			when 217 then
					--|#line 1183 "eiffel.y"
				yy_do_action_217
			when 218 then
					--|#line 1191 "eiffel.y"
				yy_do_action_218
			when 219 then
					--|#line 1197 "eiffel.y"
				yy_do_action_219
			when 220 then
					--|#line 1199 "eiffel.y"
				yy_do_action_220
			when 221 then
					--|#line 1203 "eiffel.y"
				yy_do_action_221
			when 222 then
					--|#line 1208 "eiffel.y"
				yy_do_action_222
			when 223 then
					--|#line 1215 "eiffel.y"
				yy_do_action_223
			when 224 then
					--|#line 1219 "eiffel.y"
				yy_do_action_224
			when 225 then
					--|#line 1221 "eiffel.y"
				yy_do_action_225
			when 226 then
					--|#line 1225 "eiffel.y"
				yy_do_action_226
			when 227 then
					--|#line 1231 "eiffel.y"
				yy_do_action_227
			when 228 then
					--|#line 1233 "eiffel.y"
				yy_do_action_228
			when 229 then
					--|#line 1237 "eiffel.y"
				yy_do_action_229
			when 230 then
					--|#line 1242 "eiffel.y"
				yy_do_action_230
			when 231 then
					--|#line 1249 "eiffel.y"
				yy_do_action_231
			when 232 then
					--|#line 1253 "eiffel.y"
				yy_do_action_232
			when 233 then
					--|#line 1258 "eiffel.y"
				yy_do_action_233
			when 234 then
					--|#line 1265 "eiffel.y"
				yy_do_action_234
			when 235 then
					--|#line 1267 "eiffel.y"
				yy_do_action_235
			when 236 then
					--|#line 1269 "eiffel.y"
				yy_do_action_236
			when 237 then
					--|#line 1271 "eiffel.y"
				yy_do_action_237
			when 238 then
					--|#line 1273 "eiffel.y"
				yy_do_action_238
			when 239 then
					--|#line 1275 "eiffel.y"
				yy_do_action_239
			when 240 then
					--|#line 1277 "eiffel.y"
				yy_do_action_240
			when 241 then
					--|#line 1279 "eiffel.y"
				yy_do_action_241
			when 242 then
					--|#line 1281 "eiffel.y"
				yy_do_action_242
			when 243 then
					--|#line 1283 "eiffel.y"
				yy_do_action_243
			when 244 then
					--|#line 1285 "eiffel.y"
				yy_do_action_244
			when 245 then
					--|#line 1287 "eiffel.y"
				yy_do_action_245
			when 246 then
					--|#line 1289 "eiffel.y"
				yy_do_action_246
			when 247 then
					--|#line 1291 "eiffel.y"
				yy_do_action_247
			when 248 then
					--|#line 1293 "eiffel.y"
				yy_do_action_248
			when 249 then
					--|#line 1295 "eiffel.y"
				yy_do_action_249
			when 250 then
					--|#line 1297 "eiffel.y"
				yy_do_action_250
			when 251 then
					--|#line 1299 "eiffel.y"
				yy_do_action_251
			when 252 then
					--|#line 1304 "eiffel.y"
				yy_do_action_252
			when 253 then
					--|#line 1306 "eiffel.y"
				yy_do_action_253
			when 254 then
					--|#line 1315 "eiffel.y"
				yy_do_action_254
			when 255 then
					--|#line 1321 "eiffel.y"
				yy_do_action_255
			when 256 then
					--|#line 1323 "eiffel.y"
				yy_do_action_256
			when 257 then
					--|#line 1327 "eiffel.y"
				yy_do_action_257
			when 258 then
					--|#line 1329 "eiffel.y"
				yy_do_action_258
			when 259 then
					--|#line 1329 "eiffel.y"
				yy_do_action_259
			when 260 then
					--|#line 1339 "eiffel.y"
				yy_do_action_260
			when 261 then
					--|#line 1341 "eiffel.y"
				yy_do_action_261
			when 262 then
					--|#line 1343 "eiffel.y"
				yy_do_action_262
			when 263 then
					--|#line 1347 "eiffel.y"
				yy_do_action_263
			when 264 then
					--|#line 1353 "eiffel.y"
				yy_do_action_264
			when 265 then
					--|#line 1355 "eiffel.y"
				yy_do_action_265
			when 266 then
					--|#line 1357 "eiffel.y"
				yy_do_action_266
			when 267 then
					--|#line 1361 "eiffel.y"
				yy_do_action_267
			when 268 then
					--|#line 1366 "eiffel.y"
				yy_do_action_268
			when 269 then
					--|#line 1373 "eiffel.y"
				yy_do_action_269
			when 270 then
					--|#line 1377 "eiffel.y"
				yy_do_action_270
			when 271 then
					--|#line 1379 "eiffel.y"
				yy_do_action_271
			when 272 then
					--|#line 1388 "eiffel.y"
				yy_do_action_272
			when 273 then
					--|#line 1390 "eiffel.y"
				yy_do_action_273
			when 274 then
					--|#line 1394 "eiffel.y"
				yy_do_action_274
			when 275 then
					--|#line 1396 "eiffel.y"
				yy_do_action_275
			when 276 then
					--|#line 1400 "eiffel.y"
				yy_do_action_276
			when 277 then
					--|#line 1402 "eiffel.y"
				yy_do_action_277
			when 278 then
					--|#line 1406 "eiffel.y"
				yy_do_action_278
			when 279 then
					--|#line 1411 "eiffel.y"
				yy_do_action_279
			when 280 then
					--|#line 1418 "eiffel.y"
				yy_do_action_280
			when 281 then
					--|#line 1424 "eiffel.y"
				yy_do_action_281
			when 282 then
					--|#line 1429 "eiffel.y"
				yy_do_action_282
			when 283 then
					--|#line 1434 "eiffel.y"
				yy_do_action_283
			when 284 then
					--|#line 1444 "eiffel.y"
				yy_do_action_284
			when 285 then
					--|#line 1454 "eiffel.y"
				yy_do_action_285
			when 286 then
					--|#line 1466 "eiffel.y"
				yy_do_action_286
			when 287 then
					--|#line 1469 "eiffel.y"
				yy_do_action_287
			when 288 then
					--|#line 1471 "eiffel.y"
				yy_do_action_288
			when 289 then
					--|#line 1473 "eiffel.y"
				yy_do_action_289
			when 290 then
					--|#line 1475 "eiffel.y"
				yy_do_action_290
			when 291 then
					--|#line 1477 "eiffel.y"
				yy_do_action_291
			when 292 then
					--|#line 1479 "eiffel.y"
				yy_do_action_292
			when 293 then
					--|#line 1481 "eiffel.y"
				yy_do_action_293
			when 294 then
					--|#line 1490 "eiffel.y"
				yy_do_action_294
			when 295 then
					--|#line 1499 "eiffel.y"
				yy_do_action_295
			when 296 then
					--|#line 1509 "eiffel.y"
				yy_do_action_296
			when 297 then
					--|#line 1518 "eiffel.y"
				yy_do_action_297
			when 298 then
					--|#line 1527 "eiffel.y"
				yy_do_action_298
			when 299 then
					--|#line 1536 "eiffel.y"
				yy_do_action_299
			when 300 then
					--|#line 1547 "eiffel.y"
				yy_do_action_300
			when 301 then
					--|#line 1549 "eiffel.y"
				yy_do_action_301
			when 302 then
					--|#line 1551 "eiffel.y"
				yy_do_action_302
			when 303 then
					--|#line 1555 "eiffel.y"
				yy_do_action_303
			when 304 then
					--|#line 1560 "eiffel.y"
				yy_do_action_304
			when 305 then
					--|#line 1567 "eiffel.y"
				yy_do_action_305
			when 306 then
					--|#line 1573 "eiffel.y"
				yy_do_action_306
			when 307 then
					--|#line 1575 "eiffel.y"
				yy_do_action_307
			when 308 then
					--|#line 1577 "eiffel.y"
				yy_do_action_308
			when 309 then
					--|#line 1579 "eiffel.y"
				yy_do_action_309
			when 310 then
					--|#line 1581 "eiffel.y"
				yy_do_action_310
			when 311 then
					--|#line 1583 "eiffel.y"
				yy_do_action_311
			when 312 then
					--|#line 1585 "eiffel.y"
				yy_do_action_312
			when 313 then
					--|#line 1587 "eiffel.y"
				yy_do_action_313
			when 314 then
					--|#line 1589 "eiffel.y"
				yy_do_action_314
			when 315 then
					--|#line 1593 "eiffel.y"
				yy_do_action_315
			when 316 then
					--|#line 1602 "eiffel.y"
				yy_do_action_316
			when 317 then
					--|#line 1604 "eiffel.y"
				yy_do_action_317
			when 318 then
					--|#line 1608 "eiffel.y"
				yy_do_action_318
			when 319 then
					--|#line 1610 "eiffel.y"
				yy_do_action_319
			when 320 then
					--|#line 1621 "eiffel.y"
				yy_do_action_320
			when 321 then
					--|#line 1623 "eiffel.y"
				yy_do_action_321
			when 322 then
					--|#line 1627 "eiffel.y"
				yy_do_action_322
			when 323 then
					--|#line 1629 "eiffel.y"
				yy_do_action_323
			when 324 then
					--|#line 1633 "eiffel.y"
				yy_do_action_324
			when 325 then
					--|#line 1635 "eiffel.y"
				yy_do_action_325
			when 326 then
					--|#line 1643 "eiffel.y"
				yy_do_action_326
			when 327 then
					--|#line 1645 "eiffel.y"
				yy_do_action_327
			when 328 then
					--|#line 1647 "eiffel.y"
				yy_do_action_328
			when 329 then
					--|#line 1649 "eiffel.y"
				yy_do_action_329
			when 330 then
					--|#line 1651 "eiffel.y"
				yy_do_action_330
			when 331 then
					--|#line 1653 "eiffel.y"
				yy_do_action_331
			when 332 then
					--|#line 1655 "eiffel.y"
				yy_do_action_332
			when 333 then
					--|#line 1657 "eiffel.y"
				yy_do_action_333
			when 334 then
					--|#line 1659 "eiffel.y"
				yy_do_action_334
			when 335 then
					--|#line 1663 "eiffel.y"
				yy_do_action_335
			when 336 then
					--|#line 1671 "eiffel.y"
				yy_do_action_336
			when 337 then
					--|#line 1673 "eiffel.y"
				yy_do_action_337
			when 338 then
					--|#line 1675 "eiffel.y"
				yy_do_action_338
			when 339 then
					--|#line 1677 "eiffel.y"
				yy_do_action_339
			when 340 then
					--|#line 1679 "eiffel.y"
				yy_do_action_340
			when 341 then
					--|#line 1681 "eiffel.y"
				yy_do_action_341
			when 342 then
					--|#line 1683 "eiffel.y"
				yy_do_action_342
			when 343 then
					--|#line 1685 "eiffel.y"
				yy_do_action_343
			when 344 then
					--|#line 1687 "eiffel.y"
				yy_do_action_344
			when 345 then
					--|#line 1689 "eiffel.y"
				yy_do_action_345
			when 346 then
					--|#line 1691 "eiffel.y"
				yy_do_action_346
			when 347 then
					--|#line 1693 "eiffel.y"
				yy_do_action_347
			when 348 then
					--|#line 1695 "eiffel.y"
				yy_do_action_348
			when 349 then
					--|#line 1697 "eiffel.y"
				yy_do_action_349
			when 350 then
					--|#line 1699 "eiffel.y"
				yy_do_action_350
			when 351 then
					--|#line 1701 "eiffel.y"
				yy_do_action_351
			when 352 then
					--|#line 1703 "eiffel.y"
				yy_do_action_352
			when 353 then
					--|#line 1705 "eiffel.y"
				yy_do_action_353
			when 354 then
					--|#line 1707 "eiffel.y"
				yy_do_action_354
			when 355 then
					--|#line 1709 "eiffel.y"
				yy_do_action_355
			when 356 then
					--|#line 1711 "eiffel.y"
				yy_do_action_356
			when 357 then
					--|#line 1713 "eiffel.y"
				yy_do_action_357
			when 358 then
					--|#line 1715 "eiffel.y"
				yy_do_action_358
			when 359 then
					--|#line 1717 "eiffel.y"
				yy_do_action_359
			when 360 then
					--|#line 1719 "eiffel.y"
				yy_do_action_360
			when 361 then
					--|#line 1721 "eiffel.y"
				yy_do_action_361
			when 362 then
					--|#line 1723 "eiffel.y"
				yy_do_action_362
			when 363 then
					--|#line 1725 "eiffel.y"
				yy_do_action_363
			when 364 then
					--|#line 1727 "eiffel.y"
				yy_do_action_364
			when 365 then
					--|#line 1729 "eiffel.y"
				yy_do_action_365
			when 366 then
					--|#line 1731 "eiffel.y"
				yy_do_action_366
			when 367 then
					--|#line 1733 "eiffel.y"
				yy_do_action_367
			when 368 then
					--|#line 1735 "eiffel.y"
				yy_do_action_368
			when 369 then
					--|#line 1737 "eiffel.y"
				yy_do_action_369
			when 370 then
					--|#line 1739 "eiffel.y"
				yy_do_action_370
			when 371 then
					--|#line 1741 "eiffel.y"
				yy_do_action_371
			when 372 then
					--|#line 1745 "eiffel.y"
				yy_do_action_372
			when 373 then
					--|#line 1753 "eiffel.y"
				yy_do_action_373
			when 374 then
					--|#line 1755 "eiffel.y"
				yy_do_action_374
			when 375 then
					--|#line 1757 "eiffel.y"
				yy_do_action_375
			when 376 then
					--|#line 1759 "eiffel.y"
				yy_do_action_376
			when 377 then
					--|#line 1761 "eiffel.y"
				yy_do_action_377
			when 378 then
					--|#line 1763 "eiffel.y"
				yy_do_action_378
			when 379 then
					--|#line 1765 "eiffel.y"
				yy_do_action_379
			when 380 then
					--|#line 1767 "eiffel.y"
				yy_do_action_380
			when 381 then
					--|#line 1769 "eiffel.y"
				yy_do_action_381
			when 382 then
					--|#line 1771 "eiffel.y"
				yy_do_action_382
			when 383 then
					--|#line 1773 "eiffel.y"
				yy_do_action_383
			when 384 then
					--|#line 1775 "eiffel.y"
				yy_do_action_384
			when 385 then
					--|#line 1779 "eiffel.y"
				yy_do_action_385
			when 386 then
					--|#line 1783 "eiffel.y"
				yy_do_action_386
			when 387 then
					--|#line 1787 "eiffel.y"
				yy_do_action_387
			when 388 then
					--|#line 1791 "eiffel.y"
				yy_do_action_388
			when 389 then
					--|#line 1795 "eiffel.y"
				yy_do_action_389
			when 390 then
					--|#line 1799 "eiffel.y"
				yy_do_action_390
			when 391 then
					--|#line 1801 "eiffel.y"
				yy_do_action_391
			when 392 then
					--|#line 1803 "eiffel.y"
				yy_do_action_392
			when 393 then
					--|#line 1805 "eiffel.y"
				yy_do_action_393
			when 394 then
					--|#line 1809 "eiffel.y"
				yy_do_action_394
			when 395 then
					--|#line 1813 "eiffel.y"
				yy_do_action_395
			when 396 then
					--|#line 1820 "eiffel.y"
				yy_do_action_396
			when 397 then
					--|#line 1828 "eiffel.y"
				yy_do_action_397
			when 398 then
					--|#line 1830 "eiffel.y"
				yy_do_action_398
			when 399 then
					--|#line 1834 "eiffel.y"
				yy_do_action_399
			when 400 then
					--|#line 1836 "eiffel.y"
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
					--|#line 1840 "eiffel.y"
				yy_do_action_401
			when 402 then
					--|#line 1853 "eiffel.y"
				yy_do_action_402
			when 403 then
					--|#line 1857 "eiffel.y"
				yy_do_action_403
			when 404 then
					--|#line 1859 "eiffel.y"
				yy_do_action_404
			when 405 then
					--|#line 1861 "eiffel.y"
				yy_do_action_405
			when 406 then
					--|#line 1865 "eiffel.y"
				yy_do_action_406
			when 407 then
					--|#line 1870 "eiffel.y"
				yy_do_action_407
			when 408 then
					--|#line 1877 "eiffel.y"
				yy_do_action_408
			when 409 then
					--|#line 1879 "eiffel.y"
				yy_do_action_409
			when 410 then
					--|#line 1883 "eiffel.y"
				yy_do_action_410
			when 411 then
					--|#line 1888 "eiffel.y"
				yy_do_action_411
			when 412 then
					--|#line 1899 "eiffel.y"
				yy_do_action_412
			when 413 then
					--|#line 1903 "eiffel.y"
				yy_do_action_413
			when 414 then
					--|#line 1905 "eiffel.y"
				yy_do_action_414
			when 415 then
					--|#line 1907 "eiffel.y"
				yy_do_action_415
			when 416 then
					--|#line 1909 "eiffel.y"
				yy_do_action_416
			when 417 then
					--|#line 1911 "eiffel.y"
				yy_do_action_417
			when 418 then
					--|#line 1913 "eiffel.y"
				yy_do_action_418
			when 419 then
					--|#line 1917 "eiffel.y"
				yy_do_action_419
			when 420 then
					--|#line 1919 "eiffel.y"
				yy_do_action_420
			when 421 then
					--|#line 1921 "eiffel.y"
				yy_do_action_421
			when 422 then
					--|#line 1936 "eiffel.y"
				yy_do_action_422
			when 423 then
					--|#line 1938 "eiffel.y"
				yy_do_action_423
			when 424 then
					--|#line 1940 "eiffel.y"
				yy_do_action_424
			when 425 then
					--|#line 1944 "eiffel.y"
				yy_do_action_425
			when 426 then
					--|#line 1946 "eiffel.y"
				yy_do_action_426
			when 427 then
					--|#line 1950 "eiffel.y"
				yy_do_action_427
			when 428 then
					--|#line 1957 "eiffel.y"
				yy_do_action_428
			when 429 then
					--|#line 1972 "eiffel.y"
				yy_do_action_429
			when 430 then
					--|#line 1987 "eiffel.y"
				yy_do_action_430
			when 431 then
					--|#line 2005 "eiffel.y"
				yy_do_action_431
			when 432 then
					--|#line 2007 "eiffel.y"
				yy_do_action_432
			when 433 then
					--|#line 2009 "eiffel.y"
				yy_do_action_433
			when 434 then
					--|#line 2016 "eiffel.y"
				yy_do_action_434
			when 435 then
					--|#line 2020 "eiffel.y"
				yy_do_action_435
			when 436 then
					--|#line 2022 "eiffel.y"
				yy_do_action_436
			when 437 then
					--|#line 2024 "eiffel.y"
				yy_do_action_437
			when 438 then
					--|#line 2028 "eiffel.y"
				yy_do_action_438
			when 439 then
					--|#line 2030 "eiffel.y"
				yy_do_action_439
			when 440 then
					--|#line 2032 "eiffel.y"
				yy_do_action_440
			when 441 then
					--|#line 2034 "eiffel.y"
				yy_do_action_441
			when 442 then
					--|#line 2036 "eiffel.y"
				yy_do_action_442
			when 443 then
					--|#line 2038 "eiffel.y"
				yy_do_action_443
			when 444 then
					--|#line 2040 "eiffel.y"
				yy_do_action_444
			when 445 then
					--|#line 2042 "eiffel.y"
				yy_do_action_445
			when 446 then
					--|#line 2044 "eiffel.y"
				yy_do_action_446
			when 447 then
					--|#line 2046 "eiffel.y"
				yy_do_action_447
			when 448 then
					--|#line 2048 "eiffel.y"
				yy_do_action_448
			when 449 then
					--|#line 2050 "eiffel.y"
				yy_do_action_449
			when 450 then
					--|#line 2052 "eiffel.y"
				yy_do_action_450
			when 451 then
					--|#line 2054 "eiffel.y"
				yy_do_action_451
			when 452 then
					--|#line 2056 "eiffel.y"
				yy_do_action_452
			when 453 then
					--|#line 2058 "eiffel.y"
				yy_do_action_453
			when 454 then
					--|#line 2060 "eiffel.y"
				yy_do_action_454
			when 455 then
					--|#line 2062 "eiffel.y"
				yy_do_action_455
			when 456 then
					--|#line 2064 "eiffel.y"
				yy_do_action_456
			when 457 then
					--|#line 2066 "eiffel.y"
				yy_do_action_457
			when 458 then
					--|#line 2068 "eiffel.y"
				yy_do_action_458
			when 459 then
					--|#line 2072 "eiffel.y"
				yy_do_action_459
			when 460 then
					--|#line 2074 "eiffel.y"
				yy_do_action_460
			when 461 then
					--|#line 2076 "eiffel.y"
				yy_do_action_461
			when 462 then
					--|#line 2078 "eiffel.y"
				yy_do_action_462
			when 463 then
					--|#line 2082 "eiffel.y"
				yy_do_action_463
			when 464 then
					--|#line 2084 "eiffel.y"
				yy_do_action_464
			when 465 then
					--|#line 2086 "eiffel.y"
				yy_do_action_465
			when 466 then
					--|#line 2088 "eiffel.y"
				yy_do_action_466
			when 467 then
					--|#line 2090 "eiffel.y"
				yy_do_action_467
			when 468 then
					--|#line 2092 "eiffel.y"
				yy_do_action_468
			when 469 then
					--|#line 2094 "eiffel.y"
				yy_do_action_469
			when 470 then
					--|#line 2096 "eiffel.y"
				yy_do_action_470
			when 471 then
					--|#line 2098 "eiffel.y"
				yy_do_action_471
			when 472 then
					--|#line 2100 "eiffel.y"
				yy_do_action_472
			when 473 then
					--|#line 2102 "eiffel.y"
				yy_do_action_473
			when 474 then
					--|#line 2104 "eiffel.y"
				yy_do_action_474
			when 475 then
					--|#line 2106 "eiffel.y"
				yy_do_action_475
			when 476 then
					--|#line 2108 "eiffel.y"
				yy_do_action_476
			when 477 then
					--|#line 2110 "eiffel.y"
				yy_do_action_477
			when 478 then
					--|#line 2112 "eiffel.y"
				yy_do_action_478
			when 479 then
					--|#line 2114 "eiffel.y"
				yy_do_action_479
			when 480 then
					--|#line 2116 "eiffel.y"
				yy_do_action_480
			when 481 then
					--|#line 2120 "eiffel.y"
				yy_do_action_481
			when 482 then
					--|#line 2124 "eiffel.y"
				yy_do_action_482
			when 483 then
					--|#line 2128 "eiffel.y"
				yy_do_action_483
			when 484 then
					--|#line 2132 "eiffel.y"
				yy_do_action_484
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
			--|#line 173 "eiffel.y"
		do
--|#line 173 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 173")
end

			yyval := yyval_default;
				if type_parser then
					raise_error
				end
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_2 is
			--|#line 180 "eiffel.y"
		do
--|#line 180 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 180")
end

			yyval := yyval_default;
				if not type_parser then
					raise_error
				end
				type_node := yytype60 (yyvs.item (yyvsp))
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_3 is
			--|#line 189 "eiffel.y"
		do
--|#line 189 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 189")
end

			yyval := yyval_default;
				root_node := new_class_description (yytype89 (yyvs.item (yyvsp - 13)), yytype57 (yyvs.item (yyvsp - 11)),
					is_deferred, is_expanded, is_separate, is_frozen_class, is_external_class,
					yytype78 (yyvs.item (yyvsp - 16)), yytype78 (yyvs.item (yyvsp - 1)), yytype74 (yyvs.item (yyvsp - 12)), yytype82 (yyvs.item (yyvsp - 9)), yytype66 (yyvs.item (yyvsp - 7)), yytype65 (yyvs.item (yyvsp - 6)), yytype71 (yyvs.item (yyvsp - 5)), yytype41 (yyvs.item (yyvsp - 3)), suppliers, yytype57 (yyvs.item (yyvsp - 10)), click_list
				)

				if real_class_end_position = 0 then
					root_node.set_text_positions (
						current_position.start_position,
						yytype94 (yyvs.item (yyvsp - 4)).start_position,
						yytype94 (yyvs.item (yyvsp - 8)).start_position,
						formal_generics_start_position,
						formal_generics_end_position,
						yytype94 (yyvs.item (yyvsp - 2)).start_position
					)
				else
					root_node.set_text_positions (
						real_class_end_position,
						real_class_end_position,
						real_class_end_position,
						formal_generics_start_position,
						formal_generics_end_position,
						real_class_end_position
					)
				end
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 17
	yyvsp := yyvsp - 16
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_4 is
			--|#line 232 "eiffel.y"
		do
--|#line 232 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 232")
end

			yyval := yyval_default;
				if inherit_context then
					inherit_context := False
					real_class_end_position := 0
				end
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_5 is
			--|#line 241 "eiffel.y"
		local
			yyval89: PAIR [ID_AS, CLICK_AST]
		do
--|#line 241 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 241")
end


yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_6 is
			--|#line 245 "eiffel.y"
		local
			yyval89: PAIR [ID_AS, CLICK_AST]
		do
--|#line 245 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 245")
end


yyval89 := new_clickable_id (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_7 is
			--|#line 252 "eiffel.y"
		local
			yyval78: INDEXING_CLAUSE_AS
		do
--|#line 252 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 252")
end



			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_8 is
			--|#line 254 "eiffel.y"
		local
			yyval78: INDEXING_CLAUSE_AS
		do
--|#line 254 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 254")
end


yyval78 := yytype78 (yyvs.item (yyvsp)) 
			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_9 is
			--|#line 256 "eiffel.y"
		local
			yyval78: INDEXING_CLAUSE_AS
		do
--|#line 256 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 256")
end



			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_10 is
			--|#line 260 "eiffel.y"
		local
			yyval78: INDEXING_CLAUSE_AS
		do
--|#line 260 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 260")
end



			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_11 is
			--|#line 262 "eiffel.y"
		local
			yyval78: INDEXING_CLAUSE_AS
		do
--|#line 262 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 262")
end


yyval78 := yytype78 (yyvs.item (yyvsp)) 
			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_12 is
			--|#line 264 "eiffel.y"
		local
			yyval78: INDEXING_CLAUSE_AS
		do
--|#line 264 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 264")
end


yyval78 := Void 
			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_13 is
			--|#line 268 "eiffel.y"
		local
			yyval78: INDEXING_CLAUSE_AS
		do
--|#line 268 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 268")
end



			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_14 is
			--|#line 270 "eiffel.y"
		local
			yyval78: INDEXING_CLAUSE_AS
		do
--|#line 270 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 270")
end


yyval78 := yytype78 (yyvs.item (yyvsp - 1)) 
			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_15 is
			--|#line 272 "eiffel.y"
		local
			yyval78: INDEXING_CLAUSE_AS
		do
--|#line 272 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 272")
end


yyval78 := Void 
			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_16 is
			--|#line 276 "eiffel.y"
		local
			yyval78: INDEXING_CLAUSE_AS
		do
--|#line 276 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 276")
end


				yyval78 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval78.extend (yytype34 (yyvs.item (yyvsp)))
			
			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_17 is
			--|#line 281 "eiffel.y"
		local
			yyval78: INDEXING_CLAUSE_AS
		do
--|#line 281 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 281")
end


				yyval78 := yytype78 (yyvs.item (yyvsp - 1))
				yyval78.extend (yytype34 (yyvs.item (yyvsp)))
			
			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_18 is
			--|#line 288 "eiffel.y"
		local
			yyval34: INDEX_AS
		do
--|#line 288 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 288")
end


yyval34 := new_index_as (yytype32 (yyvs.item (yyvsp - 2)), yytype63 (yyvs.item (yyvsp - 1)), yytype94 (yyvs.item (yyvsp - 3))) 
			yyval := yyval34
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_19 is
			--|#line 292 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 292 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 292")
end


yyval32 := yytype32 (yyvs.item (yyvsp - 1)) 
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_20 is
			--|#line 294 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 294 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 294")
end


				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (current_position.start_position,
						current_position.end_position, filename, 0,
						"Missing `Index' part of `Index_clause'."))
				end
				yyval32 := Void
			
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_21 is
			--|#line 306 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 306 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 306")
end


				yyval63 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval63.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_22 is
			--|#line 311 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 311 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 311")
end


				yyval63 := yytype63 (yyvs.item (yyvsp - 2))
				yyval63.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_23 is
			--|#line 316 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 316 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 316")
end


-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval63 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_24 is
			--|#line 323 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 323 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 323")
end


yyval7 := yytype32 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_25 is
			--|#line 325 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 325 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 325")
end


yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_26 is
			--|#line 327 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 327 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 327")
end


				create {CUSTOM_ATTRIBUTE_AS} yyval7.initialize (yytype20 (yyvs.item (yyvsp - 1)), Void)
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_27 is
			--|#line 331 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 331 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 331")
end


				create {CUSTOM_ATTRIBUTE_AS} yyval7.initialize (yytype20 (yyvs.item (yyvsp - 2)), yytype59 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_28 is
			--|#line 341 "eiffel.y"
		do
--|#line 341 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 341")
end

			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := False
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_29 is
			--|#line 347 "eiffel.y"
		do
--|#line 347 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 347")
end

			yyval := yyval_default;
				is_frozen_class := False
				is_deferred := True
				is_expanded := False
				is_separate := False
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_30 is
			--|#line 354 "eiffel.y"
		do
--|#line 354 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 354")
end

			yyval := yyval_default;
				is_deferred := False
				is_expanded := True
				is_separate := False
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_31 is
			--|#line 360 "eiffel.y"
		do
--|#line 360 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 360")
end

			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := True
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_32 is
			--|#line 368 "eiffel.y"
		do
--|#line 368 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 368")
end

			yyval := yyval_default;
				is_frozen_class := False
			

if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_33 is
			--|#line 372 "eiffel.y"
		do
--|#line 372 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 372")
end

			yyval := yyval_default;
				if il_parser then
					is_frozen_class := True
				else
						-- Trigger a syntax error.
					raise_error
				end
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_34 is
			--|#line 383 "eiffel.y"
		do
--|#line 383 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 383")
end

			yyval := yyval_default;
				is_external_class := False
			

if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_35 is
			--|#line 387 "eiffel.y"
		do
--|#line 387 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 387")
end

			yyval := yyval_default;
				if il_parser then
					is_external_class := True
				else
						-- Trigger a syntax error.
					raise_error
				end
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_36 is
			--|#line 402 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 402 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 402")
end



			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_37 is
			--|#line 404 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 404 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 404")
end


yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_38 is
			--|#line 411 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 411 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 411")
end



			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_39 is
			--|#line 413 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 413 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 413")
end


				yyval71 := yytype71 (yyvs.item (yyvsp))
				if yyval71.is_empty then
					yyval71 := Void
				end
			
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_40 is
			--|#line 422 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 422 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 422")
end


				yyval71 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval71, yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_41 is
			--|#line 427 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 427 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 427")
end


				yyval71 := yytype71 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval71, yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_42 is
			--|#line 434 "eiffel.y"
		local
			yyval29: FEATURE_CLAUSE_AS
		do
--|#line 434 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 434")
end


yyval29 := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) 
			yyval := yyval29
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_43 is
			--|#line 436 "eiffel.y"
		local
			yyval29: FEATURE_CLAUSE_AS
		do
--|#line 436 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 436")
end


yyval29 := new_feature_clause_as (yytype15 (yyvs.item (yyvsp - 1)), yytype70 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval29
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_44 is
			--|#line 440 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 440 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 440")
end


yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_45 is
			--|#line 440 "eiffel.y"
		do
--|#line 440 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 440")
end

			yyval := yyval_default;
				inherit_context := False
				fclause_pos := clone (current_position)
			

if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_46 is
			--|#line 449 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 449 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 449")
end



			yyval := yyval15
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_47 is
			--|#line 451 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 451 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 451")
end


yyval15 := new_client_as (yytype75 (yyvs.item (yyvsp))) 
			yyval := yyval15
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_48 is
			--|#line 455 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [ID_AS]
		do
--|#line 455 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 455")
end


				yyval75 := new_eiffel_list_id_as (1)
				yyval75.extend (new_none_id_as)
			
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_49 is
			--|#line 460 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [ID_AS]
		do
--|#line 460 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 460")
end


yyval75 := yytype75 (yyvs.item (yyvsp - 1)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_50 is
			--|#line 464 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [ID_AS]
		do
--|#line 464 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 464")
end


				yyval75 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval75.extend (yytype89 (yyvs.item (yyvsp)).first)
				yytype89 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype89 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_51 is
			--|#line 470 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [ID_AS]
		do
--|#line 470 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 470")
end


				yyval75 := yytype75 (yyvs.item (yyvsp - 2))
				yyval75.extend (yytype89 (yyvs.item (yyvsp)).first)
				yytype89 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype89 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_52 is
			--|#line 478 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_AS]
		do
--|#line 478 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 478")
end


				yyval70 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval70.extend (yytype28 (yyvs.item (yyvsp)))
			
			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_53 is
			--|#line 483 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_AS]
		do
--|#line 483 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 483")
end


				yyval70 := yytype70 (yyvs.item (yyvsp - 1))
				yyval70.extend (yytype28 (yyvs.item (yyvsp)))
			
			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_54 is
			--|#line 490 "eiffel.y"
		do
--|#line 490 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 490")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_55 is
			--|#line 491 "eiffel.y"
		do
--|#line 491 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 491")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_56 is
			--|#line 494 "eiffel.y"
		local
			yyval28: FEATURE_AS
		do
--|#line 494 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 494")
end


					-- Generate a syntax error when `feature_indexes' is not
					-- Void and it applies to synonyms of the current feature
					-- declaration.
				if (il_parser and feature_indexes /= Void and yytype92 (yyvs.item (yyvsp - 2)).first.count /= 1) then
					raise_error
				end
				yyval28 := new_feature_declaration (yytype92 (yyvs.item (yyvsp - 2)), yytype9 (yyvs.item (yyvsp - 1)), feature_indexes)
				feature_indexes := Void
			
			yyval := yyval28
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_57 is
			--|#line 507 "eiffel.y"
		local
			yyval92: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
--|#line 507 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 507")
end


yyval92 := new_clickable_feature_name_list (yytype90 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_58 is
			--|#line 509 "eiffel.y"
		local
			yyval92: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
--|#line 509 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 509")
end


				yyval92 := yytype92 (yyvs.item (yyvsp - 2))
				yyval92.first.extend (yytype90 (yyvs.item (yyvsp)).first)
			
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_59 is
			--|#line 516 "eiffel.y"
		local
			yyval90: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 516 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 516")
end


yyval90 := yytype90 (yyvs.item (yyvsp)) 
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_60 is
			--|#line 520 "eiffel.y"
		do
--|#line 520 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 520")
end

			yyval := yyval_default;
is_frozen := False 

if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_61 is
			--|#line 522 "eiffel.y"
		do
--|#line 522 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 522")
end

			yyval := yyval_default;
is_frozen := True 

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_62 is
			--|#line 526 "eiffel.y"
		local
			yyval90: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 526 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 526")
end


yyval90 := new_clickable_feature_name (yytype89 (yyvs.item (yyvsp))) 
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_63 is
			--|#line 528 "eiffel.y"
		local
			yyval90: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 528 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 528")
end


yyval90 := yytype90 (yyvs.item (yyvsp)) 
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_64 is
			--|#line 530 "eiffel.y"
		local
			yyval90: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 530 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 530")
end


yyval90 := yytype90 (yyvs.item (yyvsp)) 
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_65 is
			--|#line 534 "eiffel.y"
		local
			yyval90: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 534 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 534")
end


yyval90 := new_clickable_infix (yytype91 (yyvs.item (yyvsp))) 
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_66 is
			--|#line 539 "eiffel.y"
		local
			yyval90: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 539 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 539")
end


yyval90 := new_clickable_prefix (yytype91 (yyvs.item (yyvsp))) 
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_67 is
			--|#line 543 "eiffel.y"
		local
			yyval9: BODY_AS
		do
--|#line 543 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 543")
end


yyval9 := new_declaration_body (yytype87 (yyvs.item (yyvsp - 2)), yytype60 (yyvs.item (yyvsp - 1)), yytype16 (yyvs.item (yyvsp))) 
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_68 is
			--|#line 547 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 547 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 547")
end


feature_indexes := yytype78 (yyvs.item (yyvsp)) 
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_69 is
			--|#line 549 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 549 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 549")
end


yyval16 := yytype16 (yyvs.item (yyvsp)) 
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_70 is
			--|#line 553 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 553 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 553")
end


				yyval16 := new_constant_as (create {VALUE_AS}.initialize (yytype7 (yyvs.item (yyvsp - 1))))
				feature_indexes := yytype78 (yyvs.item (yyvsp))
			
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_71 is
			--|#line 558 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 558 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 558")
end


				yyval16 := new_constant_as (create {VALUE_AS}.initialize (new_unique_as))
				feature_indexes := yytype78 (yyvs.item (yyvsp))
			
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_72 is
			--|#line 563 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 563 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 563")
end


				yyval16 := yytype55 (yyvs.item (yyvsp))
				feature_indexes := yytype78 (yyvs.item (yyvsp - 1))
			
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_73 is
			--|#line 574 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [PARENT_AS]
		do
--|#line 574 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 574")
end



			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_74 is
			--|#line 576 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [PARENT_AS]
		do
--|#line 576 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 576")
end


yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_75 is
			--|#line 578 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [PARENT_AS]
		do
--|#line 578 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 578")
end


yyval82 := new_eiffel_list_parent_as (0) 
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_76 is
			--|#line 582 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [PARENT_AS]
		do
--|#line 582 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 582")
end


				yyval82 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval82.extend (yytype46 (yyvs.item (yyvsp)))
			
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_77 is
			--|#line 587 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [PARENT_AS]
		do
--|#line 587 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 587")
end


				yyval82 := yytype82 (yyvs.item (yyvsp - 1))
				yyval82.extend (yytype46 (yyvs.item (yyvsp)))
			
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_78 is
			--|#line 594 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 594 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 594")
end


				yyval46 := yytype46 (yyvs.item (yyvsp))
				yytype46 (yyvs.item (yyvsp)).set_location (yytype94 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_79 is
			--|#line 599 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 599 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 599")
end


				inherit_context := False
				yyval46 := yytype46 (yyvs.item (yyvsp - 1))
				yytype46 (yyvs.item (yyvsp - 1)).set_location (yytype94 (yyvs.item (yyvsp - 2)))
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_80 is
			--|#line 607 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 607 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 607")
end


				inherit_context := False
				yyval46 := new_parent_clause (yytype89 (yyvs.item (yyvsp - 1)), yytype86 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_81 is
			--|#line 612 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 612 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 612")
end


				inherit_context := False
				yyval46 := new_parent_clause (yytype89 (yyvs.item (yyvsp - 7)), yytype86 (yyvs.item (yyvsp - 6)), yytype83 (yyvs.item (yyvsp - 5)), yytype68 (yyvs.item (yyvsp - 4)), yytype73 (yyvs.item (yyvsp - 3)), yytype73 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_82 is
			--|#line 617 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 617 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 617")
end


				inherit_context := False
				yyval46 := new_parent_clause (yytype89 (yyvs.item (yyvsp - 6)), yytype86 (yyvs.item (yyvsp - 5)), Void, yytype68 (yyvs.item (yyvsp - 4)), yytype73 (yyvs.item (yyvsp - 3)), yytype73 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_83 is
			--|#line 622 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 622 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 622")
end


				inherit_context := False
				yyval46 := new_parent_clause (yytype89 (yyvs.item (yyvsp - 5)), yytype86 (yyvs.item (yyvsp - 4)), Void, Void, yytype73 (yyvs.item (yyvsp - 3)), yytype73 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_84 is
			--|#line 627 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 627 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 627")
end


				inherit_context := False
				yyval46 := new_parent_clause (yytype89 (yyvs.item (yyvsp - 4)), yytype86 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype73 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_85 is
			--|#line 632 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 632 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 632")
end


				inherit_context := False
				yyval46 := new_parent_clause (yytype89 (yyvs.item (yyvsp - 3)), yytype86 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype73 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_86 is
			--|#line 637 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 637 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 637")
end


				inherit_context := True
				real_class_end_position := current_position.end_position - 3
				yyval46 := new_parent_clause (yytype89 (yyvs.item (yyvsp - 2)), yytype86 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_87 is
			--|#line 645 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [RENAME_AS]
		do
--|#line 645 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 645")
end



			yyval := yyval83
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_88 is
			--|#line 647 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [RENAME_AS]
		do
--|#line 647 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 647")
end


yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_89 is
			--|#line 651 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [RENAME_AS]
		do
--|#line 651 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 651")
end


				yyval83 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval83.extend (yytype50 (yyvs.item (yyvsp)))
			
			yyval := yyval83
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_90 is
			--|#line 656 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [RENAME_AS]
		do
--|#line 656 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 656")
end


				yyval83 := yytype83 (yyvs.item (yyvsp - 2))
				yyval83.extend (yytype50 (yyvs.item (yyvsp)))
			
			yyval := yyval83
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_91 is
			--|#line 663 "eiffel.y"
		local
			yyval50: RENAME_AS
		do
--|#line 663 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 663")
end


yyval50 := new_rename_pair (yytype90 (yyvs.item (yyvsp - 2)), yytype90 (yyvs.item (yyvsp))) 
			yyval := yyval50
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_92 is
			--|#line 667 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 667 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 667")
end



			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_93 is
			--|#line 669 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 669 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 669")
end


yyval68 := yytype68 (yyvs.item (yyvsp)) 
			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_94 is
			--|#line 673 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 673 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 673")
end


				if yytype68 (yyvs.item (yyvsp)).is_empty then
					yyval68 := Void
				else
					yyval68 := yytype68 (yyvs.item (yyvsp))
				end
			
			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_95 is
			--|#line 681 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 681 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 681")
end



			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_96 is
			--|#line 685 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 685 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 685")
end


				yyval68 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				if yytype24 (yyvs.item (yyvsp)) /= Void then
					yyval68.extend (yytype24 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_97 is
			--|#line 692 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 692 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 692")
end


				yyval68 := yytype68 (yyvs.item (yyvsp - 1))
				if yytype24 (yyvs.item (yyvsp)) /= Void then
					yyval68.extend (yytype24 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_98 is
			--|#line 701 "eiffel.y"
		local
			yyval24: EXPORT_ITEM_AS
		do
--|#line 701 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 701")
end


				if yytype30 (yyvs.item (yyvsp - 1)) /= Void then
					yyval24 := new_export_item_as (new_client_as (yytype75 (yyvs.item (yyvsp - 2))), yytype30 (yyvs.item (yyvsp - 1)))
				end
			
			yyval := yyval24
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_99 is
			--|#line 709 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 709 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 709")
end



			yyval := yyval30
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_100 is
			--|#line 711 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 711 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 711")
end


yyval30 := new_all_as 
			yyval := yyval30
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_101 is
			--|#line 713 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 713 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 713")
end


yyval30 := new_feature_list_as (yytype73 (yyvs.item (yyvsp))) 
			yyval := yyval30
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_102 is
			--|#line 717 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 717 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 717")
end



			yyval := yyval65
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_103 is
			--|#line 719 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 719 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 719")
end


			yyval65 := yytype65 (yyvs.item (yyvsp))
		
			yyval := yyval65
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_104 is
			--|#line 725 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 725 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 725")
end


			yyval65 := new_eiffel_list_convert (Initial_convert_list_size)
			yyval65.extend (yytype17 (yyvs.item (yyvsp)))
		
			yyval := yyval65
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_105 is
			--|#line 730 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 730 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 730")
end


			yyval65 := yytype65 (yyvs.item (yyvsp - 2))
			yyval65.extend (yytype17 (yyvs.item (yyvsp)))
		
			yyval := yyval65
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_106 is
			--|#line 738 "eiffel.y"
		local
			yyval17: CONVERT_FEAT_AS
		do
--|#line 738 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 738")
end


				-- True because this is a conversion feature used as a creation
				-- procedure in current class.
			yyval17 := new_convert_feat_as (True, yytype90 (yyvs.item (yyvsp - 5)).first, yytype86 (yyvs.item (yyvsp - 2)))
		
			yyval := yyval17
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_107 is
			--|#line 744 "eiffel.y"
		local
			yyval17: CONVERT_FEAT_AS
		do
--|#line 744 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 744")
end


				-- False because this is not a conversion feature used as a creation
				-- procedure.
			yyval17 := new_convert_feat_as (False, yytype90 (yyvs.item (yyvsp - 4)).first, yytype86 (yyvs.item (yyvsp - 1)))
		
			yyval := yyval17
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_108 is
			--|#line 752 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 752 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 752")
end


				yyval73 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval73.extend (yytype90 (yyvs.item (yyvsp)).first)
			
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_109 is
			--|#line 757 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 757 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 757")
end


				yyval73 := yytype73 (yyvs.item (yyvsp - 2))
				yyval73.extend (yytype90 (yyvs.item (yyvsp)).first)
			
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_110 is
			--|#line 764 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 764 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 764")
end



			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_111 is
			--|#line 766 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 766 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 766")
end


yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_112 is
			--|#line 770 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 770 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 770")
end



			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_113 is
			--|#line 772 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 772 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 772")
end


yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_114 is
			--|#line 776 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 776 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 776")
end



			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_115 is
			--|#line 778 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 778 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 778")
end


yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_116 is
			--|#line 782 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 782 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 782")
end



			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_117 is
			--|#line 784 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 784 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 784")
end


yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_118 is
			--|#line 788 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 788 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 788")
end



			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_119 is
			--|#line 790 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 790 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 790")
end


yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_120 is
			--|#line 794 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 794 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 794")
end



			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_121 is
			--|#line 796 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 796 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 796")
end


yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_122 is
			--|#line 804 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 804 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 804")
end



			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_123 is
			--|#line 806 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 806 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 806")
end


yyval87 := yytype87 (yyvs.item (yyvsp - 1)) 
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_124 is
			--|#line 810 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 810 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 810")
end



			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_125 is
			--|#line 812 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 812 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 812")
end


yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_126 is
			--|#line 816 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 816 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 816")
end


				yyval87 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval87.extend (yytype61 (yyvs.item (yyvsp)))
			
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_127 is
			--|#line 821 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 821 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 821")
end


				yyval87 := yytype87 (yyvs.item (yyvsp - 1))
				yyval87.extend (yytype61 (yyvs.item (yyvsp)))
			
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_128 is
			--|#line 828 "eiffel.y"
		local
			yyval61: TYPE_DEC_AS
		do
--|#line 828 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 828")
end


yyval61 := new_type_dec_as (yytype77 (yyvs.item (yyvsp - 5)), yytype60 (yyvs.item (yyvsp - 1)), yytype94 (yyvs.item (yyvsp - 4))) 
			yyval := yyval61
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_129 is
			--|#line 832 "eiffel.y"
		do
--|#line 832 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 832")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_130 is
			--|#line 833 "eiffel.y"
		do
--|#line 833 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 833")
end

			yyval := yyval_default;
				if il_parser then
						-- Trigger a syntax error.
					raise_error
				end
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_131 is
			--|#line 842 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 842 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 842")
end



			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_132 is
			--|#line 844 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 844 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 844")
end


yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_133 is
			--|#line 848 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 848 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 848")
end


				yyval87 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval87.extend (yytype61 (yyvs.item (yyvsp)))
			
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_134 is
			--|#line 853 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 853 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 853")
end


				yyval87 := yytype87 (yyvs.item (yyvsp - 1))
				yyval87.extend (yytype61 (yyvs.item (yyvsp)))
			
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_135 is
			--|#line 860 "eiffel.y"
		local
			yyval61: TYPE_DEC_AS
		do
--|#line 860 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 860")
end


yyval61 := new_type_dec_as (yytype77 (yyvs.item (yyvsp - 4)), yytype60 (yyvs.item (yyvsp - 1)), yytype94 (yyvs.item (yyvsp - 3))) 
			yyval := yyval61
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_136 is
			--|#line 864 "eiffel.y"
		local
			yyval77: ARRAYED_LIST [INTEGER]
		do
--|#line 864 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 864")
end


				create yyval77.make (Initial_identifier_list_size)
				Names_heap.put (yytype32 (yyvs.item (yyvsp)))
				yyval77.extend (Names_heap.found_item)
			
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_137 is
			--|#line 870 "eiffel.y"
		local
			yyval77: ARRAYED_LIST [INTEGER]
		do
--|#line 870 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 870")
end


				yyval77 := yytype77 (yyvs.item (yyvsp - 2))
				Names_heap.put (yytype32 (yyvs.item (yyvsp)))
				yyval77.extend (Names_heap.found_item)
			
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_138 is
			--|#line 878 "eiffel.y"
		local
			yyval77: ARRAYED_LIST [INTEGER]
		do
--|#line 878 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 878")
end


create yyval77.make (0) 
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_139 is
			--|#line 880 "eiffel.y"
		local
			yyval77: ARRAYED_LIST [INTEGER]
		do
--|#line 880 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 880")
end


yyval77 := yytype77 (yyvs.item (yyvsp)) 
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_140 is
			--|#line 884 "eiffel.y"
		local
			yyval60: EIFFEL_TYPE
		do
--|#line 884 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 884")
end



			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_141 is
			--|#line 886 "eiffel.y"
		local
			yyval60: EIFFEL_TYPE
		do
--|#line 886 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 886")
end


yyval60 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_142 is
			--|#line 890 "eiffel.y"
		local
			yyval55: ROUTINE_AS
		do
--|#line 890 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 890")
end


yyval55 := new_routine_as (yytype57 (yyvs.item (yyvsp - 7)), yytype51 (yyvs.item (yyvsp - 5)), yytype87 (yyvs.item (yyvsp - 4)), yytype54 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp - 2)), yytype79 (yyvs.item (yyvsp - 1)), fbody_pos, current_position) 
			yyval := yyval55
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_143 is
			--|#line 890 "eiffel.y"
		do
--|#line 890 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 890")
end

			yyval := yyval_default;
fbody_pos := current_position.start_position 

if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_144 is
			--|#line 902 "eiffel.y"
		local
			yyval54: ROUT_BODY_AS
		do
--|#line 902 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 902")
end


yyval54 := yytype39 (yyvs.item (yyvsp)) 
			yyval := yyval54
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_145 is
			--|#line 904 "eiffel.y"
		local
			yyval54: ROUT_BODY_AS
		do
--|#line 904 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 904")
end


yyval54 := yytype26 (yyvs.item (yyvsp)) 
			yyval := yyval54
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_146 is
			--|#line 906 "eiffel.y"
		local
			yyval54: ROUT_BODY_AS
		do
--|#line 906 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 906")
end


yyval54 := new_deferred_as 
			yyval := yyval54
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_147 is
			--|#line 910 "eiffel.y"
		local
			yyval26: EXTERNAL_AS
		do
--|#line 910 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 910")
end


				yyval26 := new_external_as (yytype27 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp)))
				has_externals := True
			
			yyval := yyval26
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_148 is
			--|#line 917 "eiffel.y"
		local
			yyval27: EXTERNAL_LANG_AS
		do
--|#line 917 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 917")
end


yyval27 := new_external_lang_as (yytype57 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 1))) 
			yyval := yyval27
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_149 is
			--|#line 922 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 922 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 922")
end



			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_150 is
			--|#line 924 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 924 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 924")
end


yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_151 is
			--|#line 928 "eiffel.y"
		local
			yyval39: INTERNAL_AS
		do
--|#line 928 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 928")
end


yyval39 := new_do_as (yytype79 (yyvs.item (yyvsp))) 
			yyval := yyval39
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_152 is
			--|#line 930 "eiffel.y"
		local
			yyval39: INTERNAL_AS
		do
--|#line 930 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 930")
end


yyval39 := new_once_as (yytype79 (yyvs.item (yyvsp))) 
			yyval := yyval39
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_153 is
			--|#line 934 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 934 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 934")
end



			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_154 is
			--|#line 936 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 936 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 936")
end


yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_155 is
			--|#line 940 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 940 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 940")
end



			yyval := yyval79
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_156 is
			--|#line 942 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 942 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 942")
end


yyval79 := yytype79 (yyvs.item (yyvsp)) 
			yyval := yyval79
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_157 is
			--|#line 946 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 946 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 946")
end


				yyval79 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval79.extend (yytype37 (yyvs.item (yyvsp)))
			
			yyval := yyval79
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_158 is
			--|#line 951 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 951 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 951")
end


				yyval79 := yytype79 (yyvs.item (yyvsp - 1))
				yyval79.extend (yytype37 (yyvs.item (yyvsp)))
			
			yyval := yyval79
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_159 is
			--|#line 958 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 958 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 958")
end


yyval37 := yytype37 (yyvs.item (yyvsp - 1)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_160 is
			--|#line 962 "eiffel.y"
		do
--|#line 962 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 962")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_161 is
			--|#line 963 "eiffel.y"
		do
--|#line 963 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 963")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_162 is
			--|#line 966 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 966 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 966")
end


yyval37 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_163 is
			--|#line 968 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 968 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 968")
end


yyval37 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_164 is
			--|#line 970 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 970 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 970")
end


yyval37 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_165 is
			--|#line 972 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 972 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 972")
end


yyval37 := yytype53 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_166 is
			--|#line 974 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 974 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 974")
end


yyval37 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_167 is
			--|#line 976 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 976 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 976")
end


yyval37 := yytype35 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_168 is
			--|#line 978 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 978 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 978")
end


yyval37 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_169 is
			--|#line 980 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 980 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 980")
end


yyval37 := yytype21 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_170 is
			--|#line 982 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 982 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 982")
end


yyval37 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_171 is
			--|#line 984 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 984 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 984")
end


yyval37 := yytype52 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_172 is
			--|#line 988 "eiffel.y"
		local
			yyval51: REQUIRE_AS
		do
--|#line 988 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 988")
end



			yyval := yyval51
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_173 is
			--|#line 990 "eiffel.y"
		local
			yyval51: REQUIRE_AS
		do
--|#line 990 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 990")
end


				id_level := Normal_level
				yyval51 := new_require_as (yytype85 (yyvs.item (yyvsp)))
			
			yyval := yyval51
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_174 is
			--|#line 990 "eiffel.y"
		do
--|#line 990 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 990")
end

			yyval := yyval_default;
id_level := Assert_level 

if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_175 is
			--|#line 997 "eiffel.y"
		local
			yyval51: REQUIRE_AS
		do
--|#line 997 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 997")
end


				id_level := Normal_level
				yyval51 := new_require_else_as (yytype85 (yyvs.item (yyvsp)))
			
			yyval := yyval51
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_176 is
			--|#line 997 "eiffel.y"
		do
--|#line 997 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 997")
end

			yyval := yyval_default;
id_level := Assert_level 

if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_177 is
			--|#line 1006 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1006 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1006")
end



			yyval := yyval23
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_178 is
			--|#line 1008 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1008 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1008")
end


				id_level := Normal_level
				yyval23 := new_ensure_as (yytype85 (yyvs.item (yyvsp)))
			
			yyval := yyval23
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_179 is
			--|#line 1008 "eiffel.y"
		do
--|#line 1008 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1008")
end

			yyval := yyval_default;
id_level := Assert_level 

if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_180 is
			--|#line 1015 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1015 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1015")
end


				id_level := Normal_level
				yyval23 := new_ensure_then_as (yytype85 (yyvs.item (yyvsp)))
			
			yyval := yyval23
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_181 is
			--|#line 1015 "eiffel.y"
		do
--|#line 1015 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1015")
end

			yyval := yyval_default;
id_level := Assert_level 

if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_182 is
			--|#line 1024 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1024 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1024")
end



			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_183 is
			--|#line 1026 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1026 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1026")
end


				yyval85 := yytype85 (yyvs.item (yyvsp))
				if yyval85.is_empty then
					yyval85 := Void
				end
			
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_184 is
			--|#line 1035 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1035 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1035")
end


				yyval85 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval85, yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_185 is
			--|#line 1040 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1040 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1040")
end


				yyval85 := yytype85 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval85, yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_186 is
			--|#line 1047 "eiffel.y"
		local
			yyval58: TAGGED_AS
		do
--|#line 1047 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1047")
end


yyval58 := yytype58 (yyvs.item (yyvsp - 1)) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_187 is
			--|#line 1051 "eiffel.y"
		local
			yyval58: TAGGED_AS
		do
--|#line 1051 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1051")
end


yyval58 := new_tagged_as (Void, yytype25 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 1))) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_188 is
			--|#line 1053 "eiffel.y"
		local
			yyval58: TAGGED_AS
		do
--|#line 1053 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1053")
end


yyval58 := new_tagged_as (yytype32 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 3))) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_189 is
			--|#line 1055 "eiffel.y"
		local
			yyval58: TAGGED_AS
		do
--|#line 1055 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1055")
end



			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_190 is
			--|#line 1063 "eiffel.y"
		local
			yyval60: EIFFEL_TYPE
		do
--|#line 1063 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1063")
end


yyval60 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_191 is
			--|#line 1065 "eiffel.y"
		local
			yyval60: EIFFEL_TYPE
		do
--|#line 1065 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1065")
end


yyval60 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_192 is
			--|#line 1069 "eiffel.y"
		local
			yyval60: EIFFEL_TYPE
		do
--|#line 1069 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1069")
end


yyval60 := new_expanded_type (yytype89 (yyvs.item (yyvsp - 1)), yytype86 (yyvs.item (yyvsp))) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_193 is
			--|#line 1071 "eiffel.y"
		local
			yyval60: EIFFEL_TYPE
		do
--|#line 1071 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1071")
end


yyval60 := new_separate_type (yytype89 (yyvs.item (yyvsp - 1)), yytype86 (yyvs.item (yyvsp))) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_194 is
			--|#line 1073 "eiffel.y"
		local
			yyval60: EIFFEL_TYPE
		do
--|#line 1073 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1073")
end


yyval60 := new_bits_as (yytype38 (yyvs.item (yyvsp))) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_195 is
			--|#line 1075 "eiffel.y"
		local
			yyval60: EIFFEL_TYPE
		do
--|#line 1075 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1075")
end


yyval60 := new_bits_symbol_as (yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_196 is
			--|#line 1077 "eiffel.y"
		local
			yyval60: EIFFEL_TYPE
		do
--|#line 1077 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1077")
end


yyval60 := new_like_id_as (yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_197 is
			--|#line 1079 "eiffel.y"
		local
			yyval60: EIFFEL_TYPE
		do
--|#line 1079 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1079")
end


yyval60 := new_like_current_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_198 is
			--|#line 1083 "eiffel.y"
		local
			yyval60: EIFFEL_TYPE
		do
--|#line 1083 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1083")
end


yyval60 := new_class_type (yytype89 (yyvs.item (yyvsp - 1)), yytype86 (yyvs.item (yyvsp))) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_199 is
			--|#line 1087 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [EIFFEL_TYPE]
		do
--|#line 1087 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1087")
end



			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_200 is
			--|#line 1089 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [EIFFEL_TYPE]
		do
--|#line 1089 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1089")
end



			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_201 is
			--|#line 1091 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [EIFFEL_TYPE]
		do
--|#line 1091 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1091")
end


yyval86 := yytype86 (yyvs.item (yyvsp - 1)) 
			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_202 is
			--|#line 1095 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [EIFFEL_TYPE]
		do
--|#line 1095 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1095")
end



			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_203 is
			--|#line 1097 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [EIFFEL_TYPE]
		do
--|#line 1097 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1097")
end


yyval86 := yytype86 (yyvs.item (yyvsp - 1)) 
			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_204 is
			--|#line 1101 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [EIFFEL_TYPE]
		do
--|#line 1101 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1101")
end


				yyval86 := new_eiffel_list_type (Initial_type_list_size)
				yyval86.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_205 is
			--|#line 1106 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [EIFFEL_TYPE]
		do
--|#line 1106 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1106")
end


				yyval86 := yytype86 (yyvs.item (yyvsp - 2))
				yyval86.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_206 is
			--|#line 1117 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1117 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1117")
end


				-- $$ := Void
				formal_generics_start_position := current_position.start_position
				formal_generics_end_position := 0
			
			yyval := yyval74
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_207 is
			--|#line 1123 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1123 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1123")
end


				yyval74 := yytype74 (yyvs.item (yyvsp - 1))
				formal_generics_start_position := yytype94 (yyvs.item (yyvsp - 3)).start_position
				formal_generics_end_position := current_position.start_position
			
			yyval := yyval74
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_208 is
			--|#line 1131 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1131 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1131")
end



			yyval := yyval74
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_209 is
			--|#line 1133 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1133 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1133")
end


yyval74 := yytype74 (yyvs.item (yyvsp)) 
			yyval := yyval74
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_210 is
			--|#line 1137 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1137 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1137")
end


				yyval74 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval74.extend (yytype31 (yyvs.item (yyvsp)))
			
			yyval := yyval74
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_211 is
			--|#line 1142 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1142 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1142")
end


				yyval74 := yytype74 (yyvs.item (yyvsp - 2))
				yyval74.extend (yytype31 (yyvs.item (yyvsp)))
			
			yyval := yyval74
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_212 is
			--|#line 1149 "eiffel.y"
		local
			yyval31: FORMAL_DEC_AS
		do
--|#line 1149 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1149")
end


				check formal_exists: not formal_parameters.is_empty end
				yyval31 := new_formal_dec_as (formal_parameters.last, yytype93 (yyvs.item (yyvsp)).first, yytype93 (yyvs.item (yyvsp)).second, formal_parameters.count)
			
			yyval := yyval31
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_213 is
			--|#line 1149 "eiffel.y"
		do
--|#line 1149 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1149")
end

			yyval := yyval_default;
				if None_classname.is_equal (token_buffer) then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `token_buffer' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					formal_parameters.extend (create {ID_AS}.initialize (token_buffer))
				end
			

if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_214 is
			--|#line 1171 "eiffel.y"
		local
			yyval93: PAIR [EIFFEL_TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
--|#line 1171 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1171")
end


create yyval93 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_215 is
			--|#line 1173 "eiffel.y"
		local
			yyval93: PAIR [EIFFEL_TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
--|#line 1173 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1173")
end


				create yyval93
				yyval93.set_first (yytype60 (yyvs.item (yyvsp - 1)))
				yyval93.set_second (yytype73 (yyvs.item (yyvsp)))
			
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_216 is
			--|#line 1181 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 1181 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1181")
end



			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_217 is
			--|#line 1183 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 1183 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1183")
end


yyval73 := yytype73 (yyvs.item (yyvsp - 1)) 
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_218 is
			--|#line 1191 "eiffel.y"
		local
			yyval33: IF_AS
		do
--|#line 1191 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1191")
end


				yyval33 := new_if_as (yytype25 (yyvs.item (yyvsp - 5)), yytype79 (yyvs.item (yyvsp - 3)), yytype67 (yyvs.item (yyvsp - 2)), yytype79 (yyvs.item (yyvsp - 1)), yytype94 (yyvs.item (yyvsp - 7)), current_position)
			
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_219 is
			--|#line 1197 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1197 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1197")
end



			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_220 is
			--|#line 1199 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1199 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1199")
end


yyval67 := yytype67 (yyvs.item (yyvsp)) 
			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_221 is
			--|#line 1203 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1203 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1203")
end


				yyval67 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval67.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_222 is
			--|#line 1208 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1208 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1208")
end


				yyval67 := yytype67 (yyvs.item (yyvsp - 1))
				yyval67.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_223 is
			--|#line 1215 "eiffel.y"
		local
			yyval22: ELSIF_AS
		do
--|#line 1215 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1215")
end


yyval22 := new_elseif_as (yytype25 (yyvs.item (yyvsp - 2)), yytype79 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 4))) 
			yyval := yyval22
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_224 is
			--|#line 1219 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1219 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1219")
end



			yyval := yyval79
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_225 is
			--|#line 1221 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1221 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1221")
end


yyval79 := yytype79 (yyvs.item (yyvsp)) 
			yyval := yyval79
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_226 is
			--|#line 1225 "eiffel.y"
		local
			yyval35: INSPECT_AS
		do
--|#line 1225 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1225")
end


				yyval35 := new_inspect_as (yytype25 (yyvs.item (yyvsp - 3)), yytype64 (yyvs.item (yyvsp - 2)), yytype79 (yyvs.item (yyvsp - 1)), yytype94 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval35
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_227 is
			--|#line 1231 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CASE_AS]
		do
--|#line 1231 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1231")
end



			yyval := yyval64
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_228 is
			--|#line 1233 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CASE_AS]
		do
--|#line 1233 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1233")
end


yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_229 is
			--|#line 1237 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CASE_AS]
		do
--|#line 1237 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1237")
end


				yyval64 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval64.extend (yytype12 (yyvs.item (yyvsp)))
			
			yyval := yyval64
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_230 is
			--|#line 1242 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CASE_AS]
		do
--|#line 1242 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1242")
end


				yyval64 := yytype64 (yyvs.item (yyvsp - 1))
				yyval64.extend (yytype12 (yyvs.item (yyvsp)))
			
			yyval := yyval64
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_231 is
			--|#line 1249 "eiffel.y"
		local
			yyval12: CASE_AS
		do
--|#line 1249 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1249")
end


yyval12 := new_case_as (yytype80 (yyvs.item (yyvsp - 2)), yytype79 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 3))) 
			yyval := yyval12
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_232 is
			--|#line 1253 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line 1253 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1253")
end


				yyval80 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval80.extend (yytype40 (yyvs.item (yyvsp)))
			
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_233 is
			--|#line 1258 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line 1258 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1258")
end


				yyval80 := yytype80 (yyvs.item (yyvsp - 2))
				yyval80.extend (yytype40 (yyvs.item (yyvsp)))
			
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_234 is
			--|#line 1265 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1265 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1265")
end


yyval40 := new_interval_as (yytype38 (yyvs.item (yyvsp)), Void) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_235 is
			--|#line 1267 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1267 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1267")
end


yyval40 := new_interval_as (yytype38 (yyvs.item (yyvsp - 2)), yytype38 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_236 is
			--|#line 1269 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1269 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1269")
end


yyval40 := new_interval_as (yytype13 (yyvs.item (yyvsp)), Void) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_237 is
			--|#line 1271 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1271 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1271")
end


yyval40 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_238 is
			--|#line 1273 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1273 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1273")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp)), Void) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_239 is
			--|#line 1275 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1275 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1275")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_240 is
			--|#line 1277 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1277 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1277")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp - 2)), yytype38 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_241 is
			--|#line 1279 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1279 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1279")
end


yyval40 := new_interval_as (yytype38 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_242 is
			--|#line 1281 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1281 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1281")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_243 is
			--|#line 1283 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1283 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1283")
end


yyval40 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_244 is
			--|#line 1285 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1285 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1285")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp)), Void) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_245 is
			--|#line 1287 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1287 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1287")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_246 is
			--|#line 1289 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1289 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1289")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp - 2)), yytype48 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_247 is
			--|#line 1291 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1291 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1291")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp - 2)), yytype48 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_248 is
			--|#line 1293 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1293 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1293")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp - 2)), yytype38 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_249 is
			--|#line 1295 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1295 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1295")
end


yyval40 := new_interval_as (yytype38 (yyvs.item (yyvsp - 2)), yytype48 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_250 is
			--|#line 1297 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1297 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1297")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_251 is
			--|#line 1299 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1299 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1299")
end


yyval40 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype48 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_252 is
			--|#line 1304 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1304 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1304")
end



			yyval := yyval79
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_253 is
			--|#line 1306 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1306 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1306")
end


				yyval79 := yytype79 (yyvs.item (yyvsp))
				if yyval79 = Void then
					yyval79 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval79
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_254 is
			--|#line 1315 "eiffel.y"
		local
			yyval42: LOOP_AS
		do
--|#line 1315 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1315")
end


				yyval42 := new_loop_as (yytype79 (yyvs.item (yyvsp - 8)), yytype85 (yyvs.item (yyvsp - 7)), yytype62 (yyvs.item (yyvsp - 6)), yytype25 (yyvs.item (yyvsp - 3)), yytype79 (yyvs.item (yyvsp - 1)), yytype94 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval42
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 10
	yyvsp := yyvsp - 9
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_255 is
			--|#line 1321 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1321 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1321")
end



			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_256 is
			--|#line 1323 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1323 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1323")
end


yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_257 is
			--|#line 1327 "eiffel.y"
		local
			yyval41: INVARIANT_AS
		do
--|#line 1327 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1327")
end



			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_258 is
			--|#line 1329 "eiffel.y"
		local
			yyval41: INVARIANT_AS
		do
--|#line 1329 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1329")
end


				id_level := Normal_level
				inherit_context := False
				yyval41 := new_invariant_as (yytype85 (yyvs.item (yyvsp)))
			
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_259 is
			--|#line 1329 "eiffel.y"
		do
--|#line 1329 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1329")
end

			yyval := yyval_default;
id_level := Invariant_level 

if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_260 is
			--|#line 1339 "eiffel.y"
		local
			yyval62: VARIANT_AS
		do
--|#line 1339 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1339")
end



			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_261 is
			--|#line 1341 "eiffel.y"
		local
			yyval62: VARIANT_AS
		do
--|#line 1341 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1341")
end


yyval62 := new_variant_as (yytype32 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_262 is
			--|#line 1343 "eiffel.y"
		local
			yyval62: VARIANT_AS
		do
--|#line 1343 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1343")
end


yyval62 := new_variant_as (Void, yytype25 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_263 is
			--|#line 1347 "eiffel.y"
		local
			yyval21: DEBUG_AS
		do
--|#line 1347 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1347")
end


				yyval21 := new_debug_as (yytype84 (yyvs.item (yyvsp - 2)), yytype79 (yyvs.item (yyvsp - 1)), yytype94 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval21
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_264 is
			--|#line 1353 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [STRING_AS]
		do
--|#line 1353 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1353")
end



			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_265 is
			--|#line 1355 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [STRING_AS]
		do
--|#line 1355 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1355")
end



			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_266 is
			--|#line 1357 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [STRING_AS]
		do
--|#line 1357 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1357")
end


yyval84 := yytype84 (yyvs.item (yyvsp - 1)) 
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_267 is
			--|#line 1361 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [STRING_AS]
		do
--|#line 1361 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1361")
end


				yyval84 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval84.extend (yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_268 is
			--|#line 1366 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [STRING_AS]
		do
--|#line 1366 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1366")
end


				yyval84 := yytype84 (yyvs.item (yyvsp - 2))
				yyval84.extend (yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_269 is
			--|#line 1373 "eiffel.y"
		local
			yyval52: RETRY_AS
		do
--|#line 1373 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1373")
end


yyval52 := new_retry_as (current_position) 
			yyval := yyval52
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_270 is
			--|#line 1377 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1377 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1377")
end



			yyval := yyval79
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_271 is
			--|#line 1379 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1379 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1379")
end


				yyval79 := yytype79 (yyvs.item (yyvsp))
				if yyval79 = Void then
					yyval79 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval79
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_272 is
			--|#line 1388 "eiffel.y"
		local
			yyval6: ASSIGN_AS
		do
--|#line 1388 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1388")
end


yyval6 := new_assign_as (new_access_id_as (yytype32 (yyvs.item (yyvsp - 2)), Void), yytype25 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 3))) 
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_273 is
			--|#line 1390 "eiffel.y"
		local
			yyval6: ASSIGN_AS
		do
--|#line 1390 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1390")
end


yyval6 := new_assign_as (new_result_as, yytype25 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 3))) 
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_274 is
			--|#line 1394 "eiffel.y"
		local
			yyval53: REVERSE_AS
		do
--|#line 1394 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1394")
end


yyval53 := new_reverse_as (new_access_id_as (yytype32 (yyvs.item (yyvsp - 2)), Void), yytype25 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 3))) 
			yyval := yyval53
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_275 is
			--|#line 1396 "eiffel.y"
		local
			yyval53: REVERSE_AS
		do
--|#line 1396 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1396")
end


yyval53 := new_reverse_as (new_result_as, yytype25 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 3))) 
			yyval := yyval53
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_276 is
			--|#line 1400 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1400 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1400")
end



			yyval := yyval66
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_277 is
			--|#line 1402 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1402 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1402")
end


yyval66 := yytype66 (yyvs.item (yyvsp)) 
			yyval := yyval66
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_278 is
			--|#line 1406 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1406 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1406")
end


				yyval66 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval66.extend (yytype18 (yyvs.item (yyvsp)))
			
			yyval := yyval66
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_279 is
			--|#line 1411 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1411 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1411")
end


				yyval66 := yytype66 (yyvs.item (yyvsp - 1))
				yyval66.extend (yytype18 (yyvs.item (yyvsp)))
			
			yyval := yyval66
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_280 is
			--|#line 1418 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1418 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1418")
end


				inherit_context := False
				yyval18 := new_create_as (Void, Void)
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_281 is
			--|#line 1424 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1424 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1424")
end


				inherit_context := False
				yyval18 := new_create_as (yytype15 (yyvs.item (yyvsp - 1)), yytype73 (yyvs.item (yyvsp)))
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_282 is
			--|#line 1429 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1429 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1429")
end


				inherit_context := False
				yyval18 := new_create_as (new_client_as (yytype75 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_283 is
			--|#line 1434 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1434 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1434")
end


				inherit_context := False
				yyval18 := new_create_as (Void, Void)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype94 (yyvs.item (yyvsp - 1)).start_position,
						yytype94 (yyvs.item (yyvsp - 1)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_284 is
			--|#line 1444 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1444 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1444")
end


				inherit_context := False
				yyval18 := new_create_as (yytype15 (yyvs.item (yyvsp - 1)), yytype73 (yyvs.item (yyvsp)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype94 (yyvs.item (yyvsp - 3)).start_position,
						yytype94 (yyvs.item (yyvsp - 3)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_285 is
			--|#line 1454 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1454 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1454")
end


				inherit_context := False
				yyval18 := new_create_as (new_client_as (yytype75 (yyvs.item (yyvsp))), Void)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype94 (yyvs.item (yyvsp - 2)).start_position,
						yytype94 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_286 is
			--|#line 1466 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1466 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1466")
end


yyval56 := new_routine_creation_as (new_result_operand_as, yytype32 (yyvs.item (yyvsp - 1)), yytype81 (yyvs.item (yyvsp))) 
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_287 is
			--|#line 1469 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1469 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1469")
end


yyval56 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype32 (yyvs.item (yyvsp - 1)), yytype81 (yyvs.item (yyvsp))) 
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_288 is
			--|#line 1471 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1471 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1471")
end


yyval56 := new_routine_creation_as (new_operand_as (Void, yytype32 (yyvs.item (yyvsp - 3)), Void), yytype32 (yyvs.item (yyvsp - 1)), yytype81 (yyvs.item (yyvsp))) 
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_289 is
			--|#line 1473 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1473 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1473")
end


yyval56 := new_routine_creation_as (new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp - 4))), yytype32 (yyvs.item (yyvsp - 1)), yytype81 (yyvs.item (yyvsp))) 
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_290 is
			--|#line 1475 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1475 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1475")
end


yyval56 := new_routine_creation_as (new_operand_as (yytype60 (yyvs.item (yyvsp - 4)), Void, Void), yytype32 (yyvs.item (yyvsp - 1)), yytype81 (yyvs.item (yyvsp))) 
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_291 is
			--|#line 1477 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1477 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1477")
end


yyval56 := new_routine_creation_as (Void, yytype32 (yyvs.item (yyvsp - 1)), yytype81 (yyvs.item (yyvsp))) 
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_292 is
			--|#line 1479 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1479 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1479")
end


yyval56 := new_unqualified_routine_creation_as (new_operand_as (Void, Void, Void), yytype32 (yyvs.item (yyvsp - 1)), yytype81 (yyvs.item (yyvsp))) 
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_293 is
			--|#line 1481 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1481 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1481")
end


			yyval56 := new_routine_creation_as (new_result_operand_as, yytype32 (yyvs.item (yyvsp - 1)), yytype81 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype94 (yyvs.item (yyvsp - 2)).start_position,
					yytype94 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_294 is
			--|#line 1490 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1490 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1490")
end


			yyval56 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype32 (yyvs.item (yyvsp - 1)), yytype81 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype94 (yyvs.item (yyvsp - 2)).start_position,
					yytype94 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_295 is
			--|#line 1499 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1499 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1499")
end


			yyval56 := new_routine_creation_as (new_operand_as (Void, yytype32 (yyvs.item (yyvsp - 4)), Void), yytype32 (yyvs.item (yyvsp - 1)), yytype81 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype94 (yyvs.item (yyvsp - 2)).start_position,
					yytype94 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
			
		
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_296 is
			--|#line 1509 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1509 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1509")
end


			yyval56 := new_routine_creation_As (new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp - 5))), yytype32 (yyvs.item (yyvsp - 1)), yytype81 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype94 (yyvs.item (yyvsp - 2)).start_position,
					yytype94 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_297 is
			--|#line 1518 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1518 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1518")
end


			yyval56 := new_routine_creation_as (new_operand_as (yytype60 (yyvs.item (yyvsp - 4)), Void, Void), yytype32 (yyvs.item (yyvsp - 1)), yytype81 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype94 (yyvs.item (yyvsp - 2)).start_position,
					yytype94 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_298 is
			--|#line 1527 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1527 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1527")
end


			yyval56 := new_routine_creation_as (Void, yytype32 (yyvs.item (yyvsp - 1)), yytype81 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype94 (yyvs.item (yyvsp - 2)).start_position,
					yytype94 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_299 is
			--|#line 1536 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1536 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1536")
end


			yyval56 := new_unqualified_routine_creation_as (new_operand_as (Void, Void, Void), yytype32 (yyvs.item (yyvsp - 1)), yytype81 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype94 (yyvs.item (yyvsp - 2)).start_position,
					yytype94 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_300 is
			--|#line 1547 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1547 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1547")
end



			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_301 is
			--|#line 1549 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1549 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1549")
end



			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_302 is
			--|#line 1551 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1551 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1551")
end


yyval81 := yytype81 (yyvs.item (yyvsp - 1)) 
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_303 is
			--|#line 1555 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1555 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1555")
end


				yyval81 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval81.extend (yytype45 (yyvs.item (yyvsp)))
			
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_304 is
			--|#line 1560 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1560 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1560")
end


				yyval81 := yytype81 (yyvs.item (yyvsp - 2))
				yyval81.extend (yytype45 (yyvs.item (yyvsp)))
			
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_305 is
			--|#line 1567 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1567 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1567")
end


yyval45 := new_operand_as (Void, Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_306 is
			--|#line 1573 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1573 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1573")
end


yyval45 := new_operand_as (new_class_type (yytype89 (yyvs.item (yyvsp - 1)), Void), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_307 is
			--|#line 1575 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1575 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1575")
end


yyval45 := new_operand_as (new_class_type (yytype89 (yyvs.item (yyvsp - 2)), yytype86 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_308 is
			--|#line 1577 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1577 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1577")
end


yyval45 := new_operand_as (new_expanded_type (yytype89 (yyvs.item (yyvsp - 2)), yytype86 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_309 is
			--|#line 1579 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1579 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1579")
end


yyval45 := new_operand_as (new_separate_type (yytype89 (yyvs.item (yyvsp - 2)), yytype86 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_310 is
			--|#line 1581 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1581 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1581")
end


yyval45 := new_operand_as (new_bits_as (yytype38 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_311 is
			--|#line 1583 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1583 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1583")
end


yyval45 := new_operand_as (new_bits_symbol_as (yytype32 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_312 is
			--|#line 1585 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1585 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1585")
end


yyval45 := new_operand_as (new_like_id_as (yytype32 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_313 is
			--|#line 1587 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1587 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1587")
end


yyval45 := new_operand_as (new_like_current_as, Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_314 is
			--|#line 1589 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1589 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1589")
end


yyval45 := new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_315 is
			--|#line 1593 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1593 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1593")
end


				yyval19 := new_creation_as (yytype60 (yyvs.item (yyvsp - 3)), yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 5)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype94 (yyvs.item (yyvsp - 5)).start_position,
						yytype94 (yyvs.item (yyvsp - 5)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_316 is
			--|#line 1602 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1602 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1602")
end


yyval19 := new_creation_as (Void, yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 3))) 
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_317 is
			--|#line 1604 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1604 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1604")
end


yyval19 := new_creation_as (yytype60 (yyvs.item (yyvsp - 3)), yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 6))) 
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_318 is
			--|#line 1608 "eiffel.y"
		local
			yyval20: CREATION_EXPR_AS
		do
--|#line 1608 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1608")
end


yyval20 := new_creation_expr_as (yytype60 (yyvs.item (yyvsp - 3)), yytype4 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 1))) 
			yyval := yyval20
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_319 is
			--|#line 1610 "eiffel.y"
		local
			yyval20: CREATION_EXPR_AS
		do
--|#line 1610 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1610")
end


				yyval20 := new_creation_expr_as (yytype60 (yyvs.item (yyvsp - 3)), yytype4 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 1)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype94 (yyvs.item (yyvsp - 1)).start_position,
						yytype94 (yyvs.item (yyvsp - 1)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval20
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_320 is
			--|#line 1621 "eiffel.y"
		local
			yyval60: EIFFEL_TYPE
		do
--|#line 1621 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1621")
end



			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_321 is
			--|#line 1623 "eiffel.y"
		local
			yyval60: EIFFEL_TYPE
		do
--|#line 1623 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1623")
end


yyval60 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_322 is
			--|#line 1627 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1627 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1627")
end


yyval2 := new_access_id_as (yytype32 (yyvs.item (yyvsp)), Void) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_323 is
			--|#line 1629 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1629 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1629")
end


yyval2 := new_result_as 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_324 is
			--|#line 1633 "eiffel.y"
		local
			yyval4: ACCESS_INV_AS
		do
--|#line 1633 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1633")
end



			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_325 is
			--|#line 1635 "eiffel.y"
		local
			yyval4: ACCESS_INV_AS
		do
--|#line 1635 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1635")
end


yyval4 := new_access_inv_as (yytype32 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp))) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_326 is
			--|#line 1643 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1643 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1643")
end


yyval36 := new_instr_call_as (yytype2 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_327 is
			--|#line 1645 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1645 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1645")
end


yyval36 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_328 is
			--|#line 1647 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1647 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1647")
end


yyval36 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_329 is
			--|#line 1649 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1649 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1649")
end


yyval36 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_330 is
			--|#line 1651 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1651 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1651")
end


yyval36 := new_instr_call_as (yytype44 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_331 is
			--|#line 1653 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1653 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1653")
end


yyval36 := new_instr_call_as (yytype47 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_332 is
			--|#line 1655 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1655 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1655")
end


yyval36 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_333 is
			--|#line 1657 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1657 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1657")
end


yyval36 := new_instr_call_as (yytype48 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_334 is
			--|#line 1659 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1659 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1659")
end


yyval36 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_335 is
			--|#line 1663 "eiffel.y"
		local
			yyval14: CHECK_AS
		do
--|#line 1663 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1663")
end


yyval14 := new_check_as (yytype85 (yyvs.item (yyvsp - 1)), yytype94 (yyvs.item (yyvsp - 3)), current_position) 
			yyval := yyval14
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_336 is
			--|#line 1671 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1671 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1671")
end


create {VALUE_AS} yyval25.initialize (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_337 is
			--|#line 1673 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1673 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1673")
end


create {VALUE_AS} yyval25.initialize (yytype5 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_338 is
			--|#line 1675 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1675 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1675")
end


create {VALUE_AS} yyval25.initialize (yytype59 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_339 is
			--|#line 1677 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1677 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1677")
end


yyval25 := new_expr_call_as (yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_340 is
			--|#line 1679 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1679 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1679")
end


yyval25 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_341 is
			--|#line 1681 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1681 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1681")
end


yyval25 := new_paran_as (yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_342 is
			--|#line 1683 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1683 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1683")
end


yyval25 := new_bin_plus_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_343 is
			--|#line 1685 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1685 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1685")
end


yyval25 := new_bin_minus_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_344 is
			--|#line 1687 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1687 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1687")
end


yyval25 := new_bin_star_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_345 is
			--|#line 1689 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1689 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1689")
end


yyval25 := new_bin_slash_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_346 is
			--|#line 1691 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1691 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1691")
end


yyval25 := new_bin_mod_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_347 is
			--|#line 1693 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1693 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1693")
end


yyval25 := new_bin_div_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_348 is
			--|#line 1695 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1695 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1695")
end


yyval25 := new_bin_power_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_349 is
			--|#line 1697 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1697 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1697")
end


yyval25 := new_bin_and_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_350 is
			--|#line 1699 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1699 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1699")
end


yyval25 := new_bin_and_then_as (yytype25 (yyvs.item (yyvsp - 3)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_351 is
			--|#line 1701 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1701 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1701")
end


yyval25 := new_bin_or_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_352 is
			--|#line 1703 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1703 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1703")
end


yyval25 := new_bin_or_else_as (yytype25 (yyvs.item (yyvsp - 3)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_353 is
			--|#line 1705 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1705 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1705")
end


yyval25 := new_bin_implies_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_354 is
			--|#line 1707 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1707 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1707")
end


yyval25 := new_bin_xor_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_355 is
			--|#line 1709 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1709 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1709")
end


yyval25 := new_bin_ge_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_356 is
			--|#line 1711 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1711 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1711")
end


yyval25 := new_bin_gt_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_357 is
			--|#line 1713 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1713 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1713")
end


yyval25 := new_bin_le_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_358 is
			--|#line 1715 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1715 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1715")
end


yyval25 := new_bin_lt_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_359 is
			--|#line 1717 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1717 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1717")
end


yyval25 := new_bin_eq_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_360 is
			--|#line 1719 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1719 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1719")
end


yyval25 := new_bin_ne_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_361 is
			--|#line 1721 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1721 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1721")
end


yyval25 := new_bin_free_as (yytype25 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp - 1)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_362 is
			--|#line 1723 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1723 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1723")
end


yyval25 := new_un_minus_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_363 is
			--|#line 1725 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1725 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1725")
end


yyval25 := new_un_plus_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_364 is
			--|#line 1727 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1727 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1727")
end


yyval25 := new_un_not_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_365 is
			--|#line 1729 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1729 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1729")
end


yyval25 := new_un_old_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_366 is
			--|#line 1731 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1731 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1731")
end


yyval25 := new_un_free_as (yytype32 (yyvs.item (yyvsp - 1)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_367 is
			--|#line 1733 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1733 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1733")
end


yyval25 := new_un_strip_as (yytype77 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_368 is
			--|#line 1735 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1735 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1735")
end


yyval25 := new_address_as (yytype90 (yyvs.item (yyvsp)).first) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_369 is
			--|#line 1737 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1737 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1737")
end


yyval25 := new_expr_address_as (yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_370 is
			--|#line 1739 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1739 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1739")
end


yyval25 := new_address_current_as 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_371 is
			--|#line 1741 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1741 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1741")
end


yyval25 := new_address_result_as 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_372 is
			--|#line 1745 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 1745 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1745")
end


create yyval32.initialize (token_buffer) 
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_373 is
			--|#line 1753 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1753 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1753")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_374 is
			--|#line 1755 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1755 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1755")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_375 is
			--|#line 1757 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1757 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1757")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_376 is
			--|#line 1759 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1759 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1759")
end


yyval11 := new_current_as 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_377 is
			--|#line 1761 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1761 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1761")
end


yyval11 := new_result_as 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_378 is
			--|#line 1763 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1763 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1763")
end


yyval11 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_379 is
			--|#line 1765 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1765 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1765")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_380 is
			--|#line 1767 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1767 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1767")
end


yyval11 := yytype47 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_381 is
			--|#line 1769 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1769 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1769")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_382 is
			--|#line 1771 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1771 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1771")
end


yyval11 := yytype48 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_383 is
			--|#line 1773 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1773 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1773")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_384 is
			--|#line 1775 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1775 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1775")
end


yyval11 := yytype20 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_385 is
			--|#line 1779 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1779 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1779")
end


yyval43 := new_nested_as (new_current_as, yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_386 is
			--|#line 1783 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1783 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1783")
end


yyval43 := new_nested_as (new_result_as, yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_387 is
			--|#line 1787 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1787 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1787")
end


yyval43 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_388 is
			--|#line 1791 "eiffel.y"
		local
			yyval44: NESTED_EXPR_AS
		do
--|#line 1791 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1791")
end


yyval44 := new_nested_expr_as (yytype25 (yyvs.item (yyvsp - 3)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_389 is
			--|#line 1795 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1795 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1795")
end


yyval43 := new_nested_as (yytype47 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_390 is
			--|#line 1799 "eiffel.y"
		local
			yyval47: PRECURSOR_AS
		do
--|#line 1799 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1799")
end


yyval47 := new_precursor_as (Void, yytype69 (yyvs.item (yyvsp))) 
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_391 is
			--|#line 1801 "eiffel.y"
		local
			yyval47: PRECURSOR_AS
		do
--|#line 1801 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1801")
end


yyval47 := new_precursor (yytype89 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp)), Void) 
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_392 is
			--|#line 1803 "eiffel.y"
		local
			yyval47: PRECURSOR_AS
		do
--|#line 1803 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1803")
end


yyval47 := new_precursor (yytype89 (yyvs.item (yyvsp - 5)), yytype69 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 2))) 
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_393 is
			--|#line 1805 "eiffel.y"
		local
			yyval47: PRECURSOR_AS
		do
--|#line 1805 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1805")
end


yyval47 := new_precursor (yytype89 (yyvs.item (yyvsp - 4)), yytype69 (yyvs.item (yyvsp)), yytype94 (yyvs.item (yyvsp - 2))) 
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_394 is
			--|#line 1809 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1809 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1809")
end


yyval43 := new_nested_as (yytype48 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_395 is
			--|#line 1813 "eiffel.y"
		local
			yyval48: STATIC_ACCESS_AS
		do
--|#line 1813 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1813")
end


				yyval48 := new_static_access_as (yytype60 (yyvs.item (yyvsp - 4)), yytype32 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)));
			
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_396 is
			--|#line 1820 "eiffel.y"
		local
			yyval48: STATIC_ACCESS_AS
		do
--|#line 1820 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1820")
end


				yyval48 := new_static_access_as (yytype60 (yyvs.item (yyvsp - 3)), yytype32 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_397 is
			--|#line 1828 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1828 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1828")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_398 is
			--|#line 1830 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1830 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1830")
end


yyval11 := yytype3 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_399 is
			--|#line 1834 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1834 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1834")
end


yyval43 := new_nested_as (yytype3 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_400 is
			--|#line 1836 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1836 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1836")
end


yyval43 := new_nested_as (yytype3 (yyvs.item (yyvsp - 2)), yytype43 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_401 is
			--|#line 1840 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1840 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1840")
end


				inspect id_level
				when Normal_level then
					yyval2 := new_access_id_as (yytype32 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)))
				when Assert_level then
					yyval2 := new_access_assert_as (yytype32 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)))
				when Invariant_level then
					yyval2 := new_access_inv_as (yytype32 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_402 is
			--|#line 1853 "eiffel.y"
		local
			yyval3: ACCESS_FEAT_AS
		do
--|#line 1853 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1853")
end


yyval3 := new_access_feat_as (yytype32 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp))) 
			yyval := yyval3
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_403 is
			--|#line 1857 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1857 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1857")
end



			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_404 is
			--|#line 1859 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1859 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1859")
end



			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_405 is
			--|#line 1861 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1861 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1861")
end


yyval69 := yytype69 (yyvs.item (yyvsp - 1)) 
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_406 is
			--|#line 1865 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1865 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1865")
end


				yyval69 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval69.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_407 is
			--|#line 1870 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1870 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1870")
end


				yyval69 := yytype69 (yyvs.item (yyvsp - 2))
				yyval69.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_408 is
			--|#line 1877 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1877 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1877")
end


yyval69 := new_eiffel_list_expr_as (0) 
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_409 is
			--|#line 1879 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1879 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1879")
end


yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_410 is
			--|#line 1883 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1883 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1883")
end


				yyval69 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval69.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_411 is
			--|#line 1888 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1888 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1888")
end


				yyval69 := yytype69 (yyvs.item (yyvsp - 2))
				yyval69.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_412 is
			--|#line 1899 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 1899 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1899")
end


create yyval32.initialize (token_buffer) 
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_413 is
			--|#line 1903 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1903 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1903")
end


yyval7 := yytype10 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_414 is
			--|#line 1905 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1905 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1905")
end


yyval7 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_415 is
			--|#line 1907 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1907 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1907")
end


yyval7 := yytype38 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_416 is
			--|#line 1909 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1909 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1909")
end


yyval7 := yytype49 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_417 is
			--|#line 1911 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1911 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1911")
end


yyval7 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_418 is
			--|#line 1913 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1913 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1913")
end


yyval7 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_419 is
			--|#line 1917 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1917 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1917")
end


yyval7 := yytype10 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_420 is
			--|#line 1919 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1919 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1919")
end


yyval7 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_421 is
			--|#line 1921 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1921 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1921")
end


				if token_buffer.is_integer then
					yyval7 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval7 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval7 := new_integer_as (False, "0")
				end
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_422 is
			--|#line 1936 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1936 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1936")
end


yyval7 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_423 is
			--|#line 1938 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1938 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1938")
end


yyval7 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_424 is
			--|#line 1940 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1940 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1940")
end


yyval7 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_425 is
			--|#line 1944 "eiffel.y"
		local
			yyval10: BOOL_AS
		do
--|#line 1944 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1944")
end


yyval10 := new_boolean_as (False) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_426 is
			--|#line 1946 "eiffel.y"
		local
			yyval10: BOOL_AS
		do
--|#line 1946 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1946")
end


yyval10 := new_boolean_as (True) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_427 is
			--|#line 1950 "eiffel.y"
		local
			yyval13: CHAR_AS
		do
--|#line 1950 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1950")
end


				check is_character: not token_buffer.is_empty end
				yyval13 := new_character_as (token_buffer.item (1))
			
			yyval := yyval13
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_428 is
			--|#line 1957 "eiffel.y"
		local
			yyval38: INTEGER_CONSTANT
		do
--|#line 1957 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1957")
end


				if token_buffer.is_integer then
					yyval38 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval38 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval38 := new_integer_as (False, "0")
				end
			
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_429 is
			--|#line 1972 "eiffel.y"
		local
			yyval38: INTEGER_CONSTANT
		do
--|#line 1972 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1972")
end


				if token_buffer.is_integer then
					yyval38 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval38 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval38 := new_integer_as (False, "0")
				end
			
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_430 is
			--|#line 1987 "eiffel.y"
		local
			yyval38: INTEGER_CONSTANT
		do
--|#line 1987 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1987")
end


				if token_buffer.is_integer then
					yyval38 := new_integer_as (True, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval38 := new_integer_as_from_hexa (token_buffer)	
				else
					token_buffer.precede ('-')
					report_integer_too_small_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval38 := new_integer_as (False, "0")
				end
			
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_431 is
			--|#line 2005 "eiffel.y"
		local
			yyval49: REAL_AS
		do
--|#line 2005 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2005")
end


yyval49 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval49
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_432 is
			--|#line 2007 "eiffel.y"
		local
			yyval49: REAL_AS
		do
--|#line 2007 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2007")
end


yyval49 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval49
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_433 is
			--|#line 2009 "eiffel.y"
		local
			yyval49: REAL_AS
		do
--|#line 2009 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2009")
end


				token_buffer.precede ('-')
				yyval49 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval49
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_434 is
			--|#line 2016 "eiffel.y"
		local
			yyval8: BIT_CONST_AS
		do
--|#line 2016 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2016")
end


yyval8 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval8
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_435 is
			--|#line 2020 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2020 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2020")
end


yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_436 is
			--|#line 2022 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2022 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2022")
end


yyval57 := new_empty_string_as 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_437 is
			--|#line 2024 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2024 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2024")
end


yyval57 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_438 is
			--|#line 2028 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2028 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2028")
end


yyval57 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_439 is
			--|#line 2030 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2030 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2030")
end


yyval57 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_440 is
			--|#line 2032 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2032 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2032")
end


yyval57 := new_lt_string_as 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_441 is
			--|#line 2034 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2034 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2034")
end


yyval57 := new_le_string_as 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_442 is
			--|#line 2036 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2036 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2036")
end


yyval57 := new_gt_string_as 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_443 is
			--|#line 2038 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2038 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2038")
end


yyval57 := new_ge_string_as 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_444 is
			--|#line 2040 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2040 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2040")
end


yyval57 := new_minus_string_as 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_445 is
			--|#line 2042 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2042 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2042")
end


yyval57 := new_plus_string_as 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_446 is
			--|#line 2044 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2044 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2044")
end


yyval57 := new_star_string_as 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_447 is
			--|#line 2046 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2046 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2046")
end


yyval57 := new_slash_string_as 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_448 is
			--|#line 2048 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2048 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2048")
end


yyval57 := new_mod_string_as 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_449 is
			--|#line 2050 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2050 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2050")
end


yyval57 := new_div_string_as 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_450 is
			--|#line 2052 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2052 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2052")
end


yyval57 := new_power_string_as 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_451 is
			--|#line 2054 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2054 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2054")
end


yyval57 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_452 is
			--|#line 2056 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2056 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2056")
end


yyval57 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_453 is
			--|#line 2058 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2058 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2058")
end


yyval57 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_454 is
			--|#line 2060 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2060 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2060")
end


yyval57 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_455 is
			--|#line 2062 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2062 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2062")
end


yyval57 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_456 is
			--|#line 2064 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2064 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2064")
end


yyval57 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_457 is
			--|#line 2066 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2066 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2066")
end


yyval57 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_458 is
			--|#line 2068 "eiffel.y"
		local
			yyval57: STRING_AS
		do
--|#line 2068 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2068")
end


yyval57 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_459 is
			--|#line 2072 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2072 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2072")
end


yyval91 := new_clickable_string (new_minus_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_460 is
			--|#line 2074 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2074 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2074")
end


yyval91 := new_clickable_string (new_plus_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_461 is
			--|#line 2076 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2076 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2076")
end


yyval91 := new_clickable_string (new_not_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_462 is
			--|#line 2078 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2078 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2078")
end


yyval91 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_463 is
			--|#line 2082 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2082 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2082")
end


yyval91 := new_clickable_string (new_lt_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_464 is
			--|#line 2084 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2084 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2084")
end


yyval91 := new_clickable_string (new_le_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_465 is
			--|#line 2086 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2086 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2086")
end


yyval91 := new_clickable_string (new_gt_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_466 is
			--|#line 2088 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2088 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2088")
end


yyval91 := new_clickable_string (new_ge_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_467 is
			--|#line 2090 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2090 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2090")
end


yyval91 := new_clickable_string (new_minus_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_468 is
			--|#line 2092 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2092 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2092")
end


yyval91 := new_clickable_string (new_plus_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_469 is
			--|#line 2094 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2094 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2094")
end


yyval91 := new_clickable_string (new_star_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_470 is
			--|#line 2096 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2096 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2096")
end


yyval91 := new_clickable_string (new_slash_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_471 is
			--|#line 2098 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2098 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2098")
end


yyval91 := new_clickable_string (new_mod_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_472 is
			--|#line 2100 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2100 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2100")
end


yyval91 := new_clickable_string (new_div_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_473 is
			--|#line 2102 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2102 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2102")
end


yyval91 := new_clickable_string (new_power_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_474 is
			--|#line 2104 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2104 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2104")
end


yyval91 := new_clickable_string (new_and_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_475 is
			--|#line 2106 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2106 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2106")
end


yyval91 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_476 is
			--|#line 2108 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2108 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2108")
end


yyval91 := new_clickable_string (new_implies_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_477 is
			--|#line 2110 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2110 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2110")
end


yyval91 := new_clickable_string (new_or_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_478 is
			--|#line 2112 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2112 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2112")
end


yyval91 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_479 is
			--|#line 2114 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2114 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2114")
end


yyval91 := new_clickable_string (new_xor_string_as) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_480 is
			--|#line 2116 "eiffel.y"
		local
			yyval91: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2116 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2116")
end


yyval91 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_481 is
			--|#line 2120 "eiffel.y"
		local
			yyval5: ARRAY_AS
		do
--|#line 2120 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2120")
end


yyval5 := new_array_as (yytype69 (yyvs.item (yyvsp - 1))) 
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_482 is
			--|#line 2124 "eiffel.y"
		local
			yyval59: TUPLE_AS
		do
--|#line 2124 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2124")
end


yyval59 := new_tuple_as (yytype69 (yyvs.item (yyvsp - 1))) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_483 is
			--|#line 2128 "eiffel.y"
		do
--|#line 2128 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2128")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_484 is
			--|#line 2132 "eiffel.y"
		local
			yyval94: TOKEN_LOCATION
		do
--|#line 2132 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2132")
end


yyval94 := clone (current_position) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
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
			when 804 then
					-- End-of-file expected action.
				report_eof_expected_error
			else
					-- Default action.
				report_error ("parse error")
			end
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

			   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,
			   55,   56,   57,   58,   59,   60,   61,   62,   63,   64,
			   65,   66,   67,   68,   69,   70,   71,   72,   73,   74,
			   75,   76,   77,   78,   79,   80,   81,   82,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  288,  288,  289,  291,  277,  278,  247,  247,  247,
			  249,  249,  249,  250,  250,  250,  248,  248,  167,  164,
			  164,  213,  213,  213,  133,  133,  133,  133,  290,  290,
			  290,  290,  293,  293,  294,  294,  198,  198,  230,  230,
			  231,  231,  160,  160,  145,  295,  144,  144,  243,  243,
			  244,  244,  229,  229,  292,  292,  159,  285,  285,  282,
			  297,  297,  281,  281,  281,  279,  280,  137,  146,  146,
			  147,  147,  147,  259,  259,  259,  260,  260,  185,  185,
			  186,  186,  186,  186,  186,  186,  186,  261,  261,  262,
			  262,  191,  223,  223,  222,  222,  224,  224,  155,  161,

			  161,  161,  217,  217,  216,  216,  148,  148,  232,  232,
			  234,  234,  233,  233,  236,  236,  235,  235,  238,  238,
			  237,  237,  271,  271,  272,  272,  273,  273,  210,  298,
			  298,  275,  275,  276,  276,  211,  245,  245,  246,  246,
			  206,  206,  196,  299,  195,  195,  195,  157,  158,  200,
			  200,  173,  173,  274,  274,  252,  252,  253,  253,  170,
			  296,  296,  171,  171,  171,  171,  171,  171,  171,  171,
			  171,  171,  192,  192,  301,  192,  302,  154,  154,  303,
			  154,  304,  265,  265,  266,  266,  202,  203,  203,  203,
			  205,  205,  209,  209,  209,  209,  209,  209,  207,  269,

			  269,  269,  268,  268,  270,  270,  240,  240,  241,  241,
			  242,  242,  162,  305,  286,  286,  239,  239,  166,  220,
			  220,  221,  221,  153,  254,  254,  168,  214,  214,  215,
			  215,  141,  256,  256,  174,  174,  174,  174,  174,  174,
			  174,  174,  174,  174,  174,  174,  174,  174,  174,  174,
			  174,  174,  255,  255,  176,  267,  267,  175,  175,  306,
			  212,  212,  212,  152,  263,  263,  263,  264,  264,  193,
			  251,  251,  132,  132,  194,  194,  218,  218,  219,  219,
			  149,  149,  149,  149,  149,  149,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,

			  257,  257,  257,  258,  258,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  150,  150,  150,  151,  151,
			  208,  208,  127,  127,  130,  130,  169,  169,  169,  169,
			  169,  169,  169,  169,  169,  143,  156,  156,  156,  156,
			  156,  156,  156,  156,  156,  156,  156,  156,  156,  156,
			  156,  156,  156,  156,  156,  156,  156,  156,  156,  156,
			  156,  156,  156,  156,  156,  156,  156,  156,  156,  156,
			  156,  156,  165,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  181,  180,  179,  183,  178,
			  187,  187,  187,  187,  182,  188,  189,  139,  139,  177,

			  177,  128,  129,  225,  225,  225,  226,  226,  227,  227,
			  228,  228,  163,  134,  134,  134,  134,  134,  134,  135,
			  135,  135,  135,  135,  135,  138,  138,  142,  172,  172,
			  172,  190,  190,  190,  136,  199,  199,  199,  201,  201,
			  201,  201,  201,  201,  201,  201,  201,  201,  201,  201,
			  201,  201,  201,  201,  201,  201,  201,  201,  201,  284,
			  284,  284,  284,  283,  283,  283,  283,  283,  283,  283,
			  283,  283,  283,  283,  283,  283,  283,  283,  283,  283,
			  283,  131,  204,  300,  287>>)
		end

	yytypes1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,    1,    1,   32,   78,    1,   34,   78,   94,    1,
			    1,    1,    1,    1,   60,   60,   60,   89,    1,    1,
			    1,    1,   34,   32,   32,   89,   89,    1,   32,   89,
			    1,    1,    1,   32,   38,    1,   86,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    7,    7,    8,
			   10,   13,   20,   32,   38,   49,   57,   57,   63,   86,
			   86,    1,    1,    1,   60,   86,   89,    1,    1,    1,

			   60,    1,    1,    1,    1,   59,    1,    1,    1,    1,
			    1,   74,   94,   60,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    2,    5,    7,    8,   10,   11,
			   13,   20,   25,   32,   32,   43,   43,   43,   43,   43,
			   44,   47,   48,   56,   57,   59,   69,   69,    1,    7,
			   60,    1,   57,    1,    1,   94,    1,    1,    1,    1,
			    1,    1,    1,    1,   32,    1,    1,   69,    1,    1,
			    1,    1,    1,    1,    1,    1,   89,   90,   90,   90,
			    1,   60,   89,   69,   94,   25,   25,    1,   25,   25,

			   25,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,   32,
			    1,   69,   25,    1,    1,    1,    1,   57,    1,   57,
			    1,   31,   74,   74,   94,    1,    4,   94,   94,    3,
			   11,   32,   43,    1,    1,    1,   60,   25,    1,    1,
			   81,   89,    1,   25,   69,   60,   94,   11,    1,    1,
			    1,    1,   91,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,   91,   25,   89,    1,    1,    1,   32,    1,   32,
			   77,   77,   11,   25,   25,   25,   25,   25,   25,   25,

			   25,   25,   25,   25,   25,   25,    1,   25,   25,    1,
			   25,   25,   25,   94,   11,   11,   25,   57,    1,   82,
			    1,    1,    1,    4,   32,   32,   32,    1,   69,   32,
			   32,   32,    1,    1,    1,    1,    1,   25,   45,   81,
			   32,    1,    1,    1,    1,   32,    1,    1,   94,   94,
			   81,    1,    1,    1,    1,   25,   25,   32,   46,   82,
			   94,    1,   94,    1,   93,   31,   69,   81,   81,    3,
			   43,   81,   81,   81,    1,    1,    1,    1,    1,    1,
			   89,    1,    1,   81,   69,   25,    1,   81,    1,   32,
			    1,   94,   11,   32,   81,   46,   46,   89,    1,   18,

			   66,   66,   94,   60,   32,   32,   89,    1,   32,   89,
			   32,   38,    1,    1,   86,   45,   32,   94,   81,   69,
			   32,    1,   86,    1,   15,   75,    1,   65,   18,    1,
			    1,   73,   81,   81,   86,    1,    1,   86,    1,    1,
			    1,   86,    1,   69,    1,   81,    1,    1,    1,    1,
			    1,    1,   68,   73,   73,   73,   83,    1,   75,   89,
			   73,   90,   17,   65,   90,    1,   15,   29,   71,   71,
			   15,   75,   73,    1,    1,    1,   69,   73,   73,   50,
			   83,   90,   73,   24,   68,   75,    1,   73,   73,   73,
			   73,   73,   73,    1,   68,   68,    1,    1,    1,    1,

			    1,    1,    1,    1,   28,   70,   90,   92,    1,   94,
			   29,   73,    1,    1,    1,   24,    1,   30,   73,   73,
			   73,    1,   73,   89,   90,   17,    1,    1,   15,   75,
			   28,    1,    1,    9,   87,   90,    1,   41,   50,   90,
			    1,   73,    1,   73,   86,   86,   90,   61,   77,   87,
			   87,    1,    1,   60,    1,   94,    1,   73,    1,    1,
			   94,    1,   61,    1,   60,    1,    1,   16,   78,   58,
			   85,   85,    1,   78,    1,    1,    1,    1,    1,    7,
			   16,   78,    1,   78,   58,   58,   94,    1,    1,    1,
			    1,   78,   78,   78,   55,   57,    1,    1,   25,   32,

			   32,   60,    1,    1,    1,    1,    1,   51,   25,    1,
			    1,    1,   87,    1,   85,   61,   77,   87,   87,    1,
			    1,    1,    1,   26,   39,   54,   85,   94,   61,   79,
			    1,   27,   94,   79,    1,   23,    1,   37,   79,    1,
			   57,   57,    1,    1,    1,   79,   60,   37,    1,    1,
			    1,    6,   14,   19,   21,   33,   35,   36,   37,   42,
			   52,   53,   94,    1,   85,   79,    1,    1,   94,   79,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    2,   32,   43,   43,   43,   43,   43,   44,   47,   48,
			   85,   25,    1,   85,    1,    1,   25,    1,   84,   85,

			   89,    1,    1,    2,   32,   60,   60,   25,    1,    1,
			    1,   12,   64,   64,   85,    1,   62,   25,   25,    1,
			    1,   57,   84,   79,    1,   60,    4,    1,    1,   25,
			   25,   94,    1,   79,   12,   25,   32,    1,   79,    1,
			    1,    1,    1,    2,    1,   13,   32,   38,   40,   48,
			   80,   79,    1,    1,   94,   22,   67,   67,   94,   57,
			    2,    4,    1,    1,    1,    1,    1,    1,    1,   25,
			   25,    1,   79,   22,    1,    4,   60,   13,   32,   48,
			   13,   32,   38,   48,   32,   38,   48,   13,   32,   38,
			   48,   79,   40,    1,   79,    1,   25,    1,   79,    1,

			    1,    1,   79,   32,    1,    1,    1>>)
		end

	yytypes2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    7,  484,  412,    0,   32,    1,   16,  484,   20,    0,
			    0,    0,    0,    6,    2,  190,  191,  199,   33,   34,
			    0,   34,   17,    0,    0,  199,    5,  197,  196,  199,
			  428,    0,    0,  195,  194,    0,  198,   35,   29,    0,
			   34,   34,   28,   19,  458,  457,  456,  455,  454,  453,
			  452,  451,  450,  449,  448,  447,  446,  445,  444,  443,
			  442,  441,  440,  437,  439,  436,  426,  425,    0,   23,
			    0,  434,  438,  431,  427,    0,    0,   21,   25,  417,
			  413,  414,    0,   24,  415,  416,  418,  435,   54,  193,
			  192,  430,  429,  200,  204,    0,  484,   31,   30,    0,

			    0,  433,  432,   26,  408,    0,    0,   55,   18,  201,
			    0,  149,    0,    0,  484,    0,  377,    0,  403,    0,
			  376,    0,    0,  408,  484,  422,  421,    0,    0,    0,
			    0,  372,    0,    0,  378,  337,  336,  423,  419,  339,
			  420,  384,  410,  403,    0,  381,  375,  374,  373,  383,
			  379,  380,  382,  340,  424,  338,    0,  409,   27,   22,
			  205,    0,   36,  208,  484,  324,  484,  484,    0,    0,
			    0,    0,    0,    0,  300,    0,    0,  390,    0,  484,
			    0,  371,    0,    0,  370,    0,   62,   63,   64,  368,
			    0,    0,  199,    0,    0,    0,  365,  138,  364,  362,

			  363,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  484,  401,  366,    0,    0,  482,    0,  150,    0,   73,
			  213,  210,    0,  209,  324,    0,  319,    0,    0,  398,
			  386,  403,  397,    0,    0,    0,    0,    0,    0,    0,
			  292,    0,  404,  406,    0,    0,    0,  385,  462,  461,
			  460,  459,   66,  480,  479,  478,  477,  476,  475,  474,
			  473,  472,  471,  470,  469,  468,  467,  466,  465,  464,
			  463,   65,    0,    0,  484,  484,  481,  300,  341,  136,
			  139,    0,  387,  348,  347,  346,  345,  344,  343,  342,

			  355,  357,  356,  358,  359,  360,    0,  349,  354,    0,
			  351,  353,  361,    0,  389,  394,  411,   37,  484,  484,
			  214,  207,    0,  318,  403,  300,  300,    0,  402,  300,
			  300,  300,    0,    0,  305,    0,  301,  314,  303,    0,
			  300,  403,  405,    0,    0,  300,  369,    0,    0,    0,
			  299,  484,    0,    0,  367,  350,  352,  300,   76,  484,
			    0,   75,  484,    0,  212,  211,  325,  298,  293,  399,
			  400,  291,  286,  287,    0,    0,    0,    0,    0,    0,
			  199,  302,    0,  288,  391,  407,    0,  294,  484,  300,
			  403,    0,  388,  137,  295,   77,   78,  199,  280,  278,

			  102,  484,    0,  216,  300,  300,  199,  197,  196,  199,
			  195,  194,    0,  484,    0,  304,  403,    0,  297,  393,
			  300,   79,   80,    0,    0,  282,    0,   38,  279,  283,
			    0,  215,  290,  289,  193,  313,  312,  192,  311,  310,
			  202,    0,  307,  395,  403,  296,  112,  120,   87,  116,
			   54,   86,  110,  114,  118,    0,   92,   48,    0,   50,
			  281,  108,  104,  103,    0,   45,   60,   40,  484,   39,
			    0,  285,    0,  309,  308,  203,  392,  113,  121,   89,
			   88,    0,  117,   96,   94,   99,   95,  111,  114,  115,
			  118,  119,    0,   85,   93,  110,   49,    0,    0,    0,

			    0,    0,   46,   61,   52,   60,   57,  122,    0,  257,
			   41,  284,  217,    0,    0,   97,  100,   54,  101,  118,
			    0,   84,  114,   51,  109,  105,    0,    0,   44,   47,
			   53,   60,  124,  160,  140,   59,  259,  484,   90,   91,
			   98,    0,   83,  118,    0,    0,   58,  126,  484,    0,
			  125,   56,    0,   13,  483,    7,   82,    0,  107,    0,
			    0,  123,  127,  161,  141,   10,  484,   67,   68,  184,
			  258,  483,  484,    0,   81,  106,  129,   13,  484,   13,
			   69,   36,   15,  484,  185,   54,    0,    4,    3,    0,
			    0,   71,  484,   70,   72,  143,   14,  186,  187,  403,

			    0,   54,  172,  189,  130,  128,  174,  153,  188,  176,
			  483,  131,    0,  483,  173,  133,  484,  154,  132,  160,
			  484,  160,  146,  145,  144,  177,  175,    0,  134,  152,
			  483,  149,    0,  151,  179,  270,    0,  157,  483,  484,
			  147,  148,  181,  483,  160,    0,   54,  158,  269,  484,
			  160,  164,  170,  162,  169,  166,  167,  163,  160,  168,
			  171,  165,    0,  483,  178,  271,  142,  135,    0,  255,
			  159,    0,    0,  264,    0,  483,    0,    0,  320,    0,
			  326,  403,  332,  328,  327,  329,  334,  330,  331,  333,
			  180,  227,  483,  260,    0,    0,    0,    0,  160,    0,

			    0,  323,    0,  324,  322,  321,    0,    0,    0,    0,
			  484,  229,  252,  228,  256,    0,    0,  273,  275,  160,
			  265,  267,    0,    0,  335,    0,  316,    0,    0,  272,
			  274,    0,  160,    0,  230,  262,  403,  484,  484,  266,
			    0,  263,    0,  324,    0,  236,  238,  234,  232,  244,
			    0,  253,  226,    0,    0,  221,  224,  484,    0,  268,
			  324,  315,    0,    0,    0,    0,    0,  160,    0,  261,
			    0,  160,    0,  222,    0,  317,    0,  237,  243,  251,
			  242,  239,  240,  246,  241,  235,  249,  250,  245,  248,
			  247,  231,  233,  160,  225,  218,    0,    0,    0,  160,

			    0,  254,  223,  396,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  703,  134,  239,  236,  135,  651,   77,   78,  136,  137,
			  533,  138,  240,  139,  711,  140,  652,  424,  466,  567,
			  580,  462,  399,  653,  141,  654,  755,  635,  483,  142,
			  623,  631,  504,  467,  517,  231,  143,   24,  144,  655,
			    6,  656,  657,  637,  658,   84,  624,  748,  537,  659,
			  242,  145,  146,  147,  148,  149,  150,  338,  358,  396,
			  151,  152,  749,   85,  479,  607,  660,  661,  625,  594,
			  153,  229,  154,  162,   87,  569,  585,  155,   94,  553,
			   15,  706,   16,  547,  615,  716,   88,  712,  713,  463,
			  427,  400,  401,  756,  757,  452,  495,  484,  221,  254,

			  156,  157,  505,  468,  469,  460,  487,  488,  489,  490,
			  491,  492,  431,  111,  232,  233,  485,  458,  548,  291,
			    4,    7,  581,  568,  645,  629,  638,  772,  733,  750,
			  250,  339,  319,  359,  456,  480,  698,  722,  570,  571,
			  693,  414,   36,   95,  534,  549,  550,  612,  617,  618,
			  186,   26,  187,  188,  461,  506,  281,  262,  507,  364,
			    8,  804,    5,   20,  588,  108,   21,   38,  502,  630,
			  508,  590,  602,  572,  610,  613,  643,  663,  320,  554>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   38,  539, -32768,   90,  163, -32768, -32768,  439,   45,  255,
			   96,  255,  328, -32768, -32768, -32768, -32768,  615, -32768,  675,
			  667,  143, -32768,  685, 1564,  615, -32768, -32768, -32768,  615,
			 -32768,  694,  693, -32768, -32768,   89, -32768, -32768, -32768,  255,
			  675,  675, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  672, -32768,
			   90, -32768, -32768, -32768, -32768,  422,  383, -32768, -32768, -32768,
			 -32768, -32768,   86, -32768, -32768, -32768, -32768, -32768,  355, -32768,
			 -32768, -32768, -32768, -32768, -32768,  323,  379, -32768, -32768,   90,

			  686, -32768, -32768, -32768, 1408,  650, 1677, -32768, -32768, -32768,
			   90,  501,  671,  670, -32768,  651,  265,    4,   27,  668,
			  234,   23,   85, 1408, -32768, -32768, -32768, 1408, 1408,  684,
			 1408, -32768, 1408, 1408,  478, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 2050,  190, 1408, -32768, -32768, -32768, -32768, -32768,
			 -32768,  475,  471, -32768, -32768, -32768,  664,  669, -32768, -32768,
			 -32768, 1749,  493,  660, -32768,  248, -32768, -32768,   45,  683,
			  681,  678,   90, 1408,  449,  255, 1295, -32768,  255, -32768,
			   45, -32768,  205, 1927, -32768, 1408, -32768, -32768, -32768, -32768,
			  255,  598,  425,  661,   45, 1988, -32768,   45, -32768, -32768,

			 -32768,   45, 1408, 1408, 1408, 1408, 1408, 1408, 1408, 1408,
			 1408, 1408, 1408, 1408, 1408, 1114, 1408, 1001, 1408, 1408,
			 -32768, -32768, -32768,   45,   45, -32768, 1408, -32768, 1727,  621,
			 -32768, -32768,  658,  656,  248,   45, -32768,   45,   45,  657,
			 -32768,  626, -32768,   45,   45,   45,  654, 1970,  813,   45,
			 -32768,  653, -32768, 2050,  325,  652,   45, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 1926,  648, -32768, -32768, -32768,  628,  232, -32768,
			  498,  649, -32768,  414,  414,  414,  414,  414,  540,  540,

			  655,  655,  655,  655,  655,  655, 1408,  877, 1947, 1408,
			 1734, 2011, -32768,   45, -32768, -32768, 2050, -32768,  423, -32768,
			  642, -32768,  660, -32768,  626,  628,  628,   45, -32768,  628,
			  628,  628,  666,  665,  651,   59, -32768, 2050, -32768,  269,
			  628,  626, -32768, 1408,  659,  628, -32768,  638,   45,  597,
			 -32768, -32768,   45,   45, -32768,  877, 1734,  628, -32768,  562,
			  255, -32768,  285,  255, -32768, -32768, -32768, -32768, -32768,  657,
			 -32768, -32768, -32768, -32768,   45,   45,  255,   43,  255,  328,
			  368, -32768, 1521, -32768, -32768, 2050,   45, -32768, -32768,  628,
			  626,   45, -32768, -32768, -32768, -32768,  644,  615,  131, -32768,

			  620,  240,  625,  637,  628,  628,  615,  619,  618,  615,
			  614,  613,    6,  207,  611, -32768,  626,  573, -32768, -32768,
			  628, -32768,  189,  103,    1,  115,    1,  572, -32768,  131,
			    1, -32768, -32768, -32768,  610, -32768, -32768,  608, -32768, -32768,
			  549,  322, -32768, -32768,  626, -32768,    1,    1,    1,    1,
			  304, -32768,  538,  528,  518,  582,  581, -32768,  350, -32768,
			  579, -32768, -32768,  607,  228, -32768,  373, -32768, -32768,  572,
			    1,  115,   79, -32768, -32768,  545, -32768,  579,  579, -32768,
			  600,  584,  579, -32768,  583,  102, -32768, -32768,  528, -32768,
			  518, -32768,  568, -32768, -32768,  538, -32768,  255,    1,    1,

			  586,  585,  583, -32768, -32768,  358, -32768,   28,    1,  546,
			 -32768,  579, -32768,    1,    1, -32768, -32768,  482,  579,  518,
			  558, -32768,  528, -32768, -32768, -32768,   90,   90, -32768, -32768,
			 -32768,  543,   45, -32768,  576, -32768, -32768, -32768, -32768, -32768,
			 -32768,  548, -32768,  518,  288,  129, -32768, -32768,  498,  557,
			   45,  480,   90,  130,  259,  531, -32768,  544, -32768,  553,
			  556, -32768, -32768, -32768, -32768, 1705,  527, -32768, -32768, -32768,
			 -32768,  429, -32768,  522, -32768, -32768,  536,  505,  560,  505,
			 -32768,  493, -32768,  497, -32768,  482, 1408, -32768, -32768,   45,
			   90, -32768,  464, -32768, -32768, -32768, -32768, -32768, 2050,  320,

			  503,  482,  450, 1408, -32768, -32768,  476,  457, 2050, -32768,
			  238,   45,  178,  238, -32768, -32768,  498, -32768,   45, -32768,
			 -32768, -32768, -32768, -32768, -32768,  466, -32768,  492, -32768, -32768,
			  317,  501, 1749, -32768,  426,  430,   90, -32768,  376,   65,
			 -32768, -32768, -32768,   -1, -32768,  454,  482, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  236,   -1, -32768, -32768, -32768, -32768, 1408,  436,
			  480,  140, 1408,  487,  485,  442,  154,    5,   90, 1408,
			  478,   26, -32768, -32768, -32768, -32768, -32768, -32768,  475,  471,
			 -32768, 1237,  300,  389, 1408, 1408, 1872, 1542, -32768,  418,

			  441, -32768,   90,  248, -32768, -32768,  452, 1908, 1408, 1408,
			 -32768, -32768,  417,  381, -32768, 1408,  380, 2050, 2050, -32768,
			 -32768, -32768,  164,  413, -32768,  400, -32768,    3,  437, 2050,
			 2050,   29, -32768,  345, -32768, 2050,  182, -32768,  312, -32768,
			 1749, -32768,    3,  248,  362,  391,  377,  309, -32768,  295,
			   -7, -32768, -32768, 1408, 1408, -32768,  272,  167,  229, -32768,
			  248, -32768,  255,   33,   29,  146,   29, -32768,   29, 2050,
			 1890, -32768,  210, -32768, 1408, -32768,  185, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, 1757,  158,   83, -32768,

			   45, -32768, -32768, -32768,   67,   57, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -588,  133,  467, -218, -32768, -32768,  687,  227, -32768,  -18,
			 -32768,  -21, -154, -32768,   71,  -20, -32768, -394, -32768, -32768,
			 -32768,  292,  388, -32768,    8, -32768,   31, -32768,  303,  605,
			 -32768, -32768,  278,  313, -32768,  455,    0, -32768,  271, -32768,
			    7, -32768, -32768,  138, -32768,  -11, -32768,   11, -32768, -32768,
			  453,  113,  112,  111,  109,  108,  107,  385,  403, -32768,
			   99,   98, -338, -32768,  246, -32768, -32768, -32768, -32768, -32768,
			 -32768,  171,  -22,  120, -146,  179, -32768,  674,    2, -32768,
			 -171, -32768, -32768,  197,  123, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  284, -32768, -32768,  -95, -32768,

			  616, -32768, -32768, -32768, -32768, -196,  314,  239,  308, -447,
			  307, -317, -32768, -32768, -32768, -32768, -369, -32768, -188, -32768,
			  173, -336, -32768, -120, -32768, -604, -32768, -32768, -32768, -32768,
			  -65, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -582, -32768,
			 -32768, -32768,   -4, -385, -32768, -32768, -32768, -32768, -32768, -32768,
			    9,   10, -32768, -32768, -110,  195, -32768, -32768, -32768, -32768,
			   48, -32768, -32768, -32768, -32768, -299, -32768,  264, -32768, -511,
			 -32768, -32768, -32768, -347, -32768, -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    3,   34,   86,   80,   81,   14,   79,  255,   23,  290,
			   28,  189,   33,   17,   22,  227,  323,  633,   25,  361,
			   29,   89,  551,  177,   83,   90,  257,  441,  614,  425,
			  173,  626,   82,  768,   13,  470,    2,    2,    2,   13,
			  665,  519,   12,   32,   31,   17,  669,  292,   96,  185,
			  172,  702,  176,  176,  532,  440,   13,  806,   30,   74,
			  471,  664,    2,   74,  171, -182,    2,  805,  531,  314,
			  315,    2,  100,  175,   11,  543,    2,  183,    2,  709,
			   17,  690,  708,  184,   86,   80,   81,   10,   79,  182,
			  767, -182,   13,  699,  723,  379,  701,  170,  701,  183,

			  744,  113,    9,  407,  744,  190,   83,  169,  528,   17,
			  714,  182,  160,    1,   82,  738,  181,  174,   13,  498,
			   17,   12,   13,   13,  191,   12,   12,  378,  751,    2,
			  516,  190,  192,  529,  104,   13,   13,  650,   93,  743,
			  377,  544,  545,  649,  112,  512,  328,  670,  -47,  801,
			  457,  486,  103,   11,  760,  376,   27,   11,   11,  648,
			   32,   31,  165,  791,  -46,  168,   10,  794,  241,  110,
			   10,   10,  194,  520,  246,   30,  559,  423,  183,    2,
			  241,    9,   17,  800,  251,    9,    9,   13,   17,  798,
			  182,  -47,  403,  695,  287,  802,  694,  289,  392,  283,

			  190,  241,  541,  -47,  740,  566,  317,  -46,  176,  739,
			  565,   41,  234,   37,  237,  238,  176,  744,  540,  -46,
			  220,  753,  350,  241,  241,   19,  557,  256,  220,  366,
			  583, -220,  797, -220,  472,  324,   18,  325,  326,   40,
			  622,  621,  592,  329,  330,  331,  384, -306,  620,  340,
			  477,  478, -306,  482,  501,  451,  345,  352,  450,  180,
			  367,  368,  679,  619,  371,  372,  373,  500,  313,    2,
			  351,  678,  179,  235,  511,  383,  795,  677,  449,  448,
			  387,  398,  676,  639,  447,   42,  597,  446,   13,  518,
			  168,  639,  394,  675,  774,  419,  674,  673,  766, -277,

			 -182, -182,  605,  167,   97,   98, -277,  119, -182,  382,
			  672, -277,  765,  357,  381, -277,  464,  261,  260, -277,
			 -182,  443,  118, -182,  418, -182,  398,  241,  110,  671,
			  259,  258,  348,  349, -182,  558,  771,  191,  481,  432,
			  433,  107,   32,   31, -276,  380,  176,  667,  389,  476,
			  423, -276,  241,  393,  563,  445, -276,   30,  220,  603,
			 -276,    2,  110,  110, -276,  343,  360,  362,  411,  397,
			  342,  475,  109,   17,  404,  405, -219,  408, -219,  410,
			  764, -155, -155, -155, -155,  406,  416,  409,  524,  464,
			  497,  420,  107,  422,  763,  106, -155,  496,  535,  391,

			 -182, -182,  434,  481,  539,  437, -206,  360,  762, -155,
			  402,  752,   92,  219,  102,  413,  412, -155, -155, -155,
			 -206, -206,   17,  616,  -43,  779,  783,  786,  790,  -43,
			  616,  503,  459,  -43,  202,  131,  417,  -43, -206,  -42,
			 -156, -156, -156, -156,  -42, -206,  503,  742,  -42,  402,
			 -206,   91,  -42,  101, -206, -156, -206,  591, -206,  593,
			  107,  349,  352, -206,  -54,  -54,  219,  219, -156,  219,
			  219,  219,  285,   35,  249,  248, -156, -156, -156,  741,
			  737,  732,  -54,  710,  724,  726,  641,  727,  285,  -54,
			  715, -183, -183,  219,  -54, -183,  224,   -8,  -54, -183,

			  223,   -8,  -54,  201, -183,   -8,  523,   -8, -182,   -8,
			  180, -183,   -8,  697, -183,  692,  509,  563,  219,  107,
			  666, -183,  644,  642,  219,  761,  -11,  -11,  161, -183,
			 -183,  636,  289,  634,  -11,   -8,   17,   17,  353,  611,
			  609,  606,  775,   86,   80,   81,  -11,   79,  -11,  -11,
			  289,  721,  604,  219,  564,  -11,  206,  205,  204,  203,
			  202,  131,   17,  596,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  228,  219,  219,
			  566,  219,  219,  219,  589,  555,  599,  219,  587,  600,
			   22,  776,  601,  582,  759,  576,  560,   -9,  575,   22,

			   17,   -9,  561,  -74,  -74,   -9,    1,   -9,  219,   -9,
			  574,  289,   -9,  447,  556,  552,  503,  449,  289,  498,
			  586,  -74,  -12,  -12,  542,  536,  219,  219,  -74,  423,
			  -12,  527,  526,  -74,  521,   -9,  446,  -74,  646,  514,
			  513,  -74,  -12,  465,  -12,  -12,   17,  499,  493, -201,
			  450,  -12,  176, -200,  248,  474,  219,  473,  442,  444,
			  439,  438,  681,   35,  627,  436,  435,  429,  632,  208,
			  207,  206,  205,  204,  203,  202,  131,  704,  430,  426,
			  705,  421,  327,  390,  386,  388,  700,  662,   17,  166,
			  375,  374,  363,  230,  354,  347,  322,  668,  318,  344,

			  341,  332,  284,  245,  725,  286,  244,  321,  243,  226,
			  197,  745,   17,  225,  178,  736,  158,  164,   99,  163,
			  747,  114,   92,   91,   43,   39,  546,  704,  573,  455,
			  454,  746,  195,  196,  522,  198,  453,  199,  200,  193,
			  494,  628,  704,  777,  780,   37,  787,  562,  745,  222,
			  584,  640,  595,  782,  785,  789,  105,  747,  731,  538,
			  689,  688,  395,  778,  781,  784,  788,  415,  746,  687,
			  686,  685,   17,  684,  683,  682,  647,  365,  247,  792,
			  370,  253,  510,  530,  734,  754,  758,  515,  773,  428,
			  282,  525,  579,  159,  369,  680,    0,    0,    0,    0,

			  803,    0,    0,    0,    0,  758,    0,  293,  294,  295,
			  296,  297,  298,  299,  300,  301,  302,  303,  304,  305,
			  307,  308,  310,  311,  312,    0,    0,  133,  132,    0,
			    0,  316,    0,    0,  131,  130,  129,  128,    0,  127,
			    0,    0,  126,   74,  125,   72,    2,   71,   70,    0,
			    0,  124,    0,  337,   68,    0,  123,    0,  336,  335,
			    0,  104,    0,    0,   67,   66,    0,  121,    0,  219,
			    0,    0,    0,  120,    0,    0,    0,    0,    0,  219,
			    0,    0,    0,    0,  119,  214,  213,  212,  211,  210,
			  209,  208,  207,  206,  205,  204,  203,  202,  131,  118,

			  117,    0,    0,    0,    0,    0,  116,    0,    0,    0,
			    0,  355,    0,    0,  356,    0,  334,    0,   65,   64,
			   63,   62,   61,   60,   59,   58,   57,   56,   55,   54,
			   53,   52,   51,   50,   49,   48,   47,   46,   45,   44,
			    0,    0,    0,    0,    0,    0,    0,    0,  385,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  219,    0,    0,    0,    0,  219,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  219,    0,
			    0,    0,    0,    0,    0,    0,    0,  337,  219,  219,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			  219,  219,    0,    0,    0,    0,  219,    0,    0,    0,
			    0,    0,    0,    0,    0,  133,  132,    0,    0,    0,
			    0,    0,  131,  130,  129,  128,    0,  127,    0,    0,
			  126,   74,  125,   72,    2,   71,   70,    0,    0,  124,
			  219,  219,   68,    0,  123,    0,    0,  122,    0,  104,
			    0,    0,   67,   66,    0,  121,    0,    0,    0,    0,
			    0,  120,    0,    0,    0,  309,    0,  219,    0,    0,
			    0,    0,  119,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  118,  117,    0,
			    0,    0,    0,    0,  116,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,  115,    0,   65,   64,   63,   62,
			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,   45,   44,  133,  132,
			    0,    0,    0,    0,    0,  131,  130,  129,  128,    0,
			  127,    0,    0,  126,   74,  125,   72,    2,   71,   70,
			    0,    0,  124,    0,    0,   68,    0,  123,    0,    0,
			  122,    0,  104,    0,    0,   67,   66,    0,  121,    0,
			    0,    0,    0,    0,  120,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  119,    0,    0,    0,    0,
			    0,  598,    0,    0,    0,    0,    0,    0,    0,    0,

			  118,  117,    0,    0,    0,    0,    0,  116,  608,    0,
			    0,  306,    0,    0,    0,    0,    0,  115,    0,   65,
			   64,   63,   62,   61,   60,   59,   58,   57,   56,   55,
			   54,   53,   52,   51,   50,   49,   48,   47,   46,   45,
			   44,  218,  217,  216,  215,  214,  213,  212,  211,  210,
			  209,  208,  207,  206,  205,  204,  203,  202,  131,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  691,    0,    0,    0,  696,    0,    0,
			    0,    0,    0,    0,  707,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  717,

			  718,    0,    0,    0,    0,    0,    0,    0,    0,  133,
			  132,    0,    0,  729,  730,    0,  131,  130,  129,  128,
			  735,  127,    0,    0,  126,   74,  125,   72,    2,   71,
			   70,    0,    0,  124,    0,    0,   68,    0,  123,  710,
			  252,  122,    0,  104,    0,    0,   67,   66,    0,  121,
			    0,    0,    0,    0,    0,  120,    0,    0,  769,  770,
			    0,    0,    0,    0,    0,    0,  119,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  796,
			    0,  118,  117,    0,    0,    0,    0,    0,  116,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  115,    0,

			   65,   64,   63,   62,   61,   60,   59,   58,   57,   56,
			   55,   54,   53,   52,   51,   50,   49,   48,   47,   46,
			   45,   44,  133,  132,    0,    0,    0,    0,    0,  131,
			  130,  129,  128,    0,  127,    0,    0,  126,   74,  125,
			   72,    2,   71,   70,    0,    0,  124,    0,    0,   68,
			    0,  123,    0,    0,  122,    0,  104,    0,    0,   67,
			   66,    0,  121,    0,    0,    0,    0,    0,  120,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  119,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  118,  117,    0,    0,    0,    0,

			    0,  116,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  115,    0,   65,   64,   63,   62,   61,   60,   59,
			   58,   57,   56,   55,   54,   53,   52,   51,   50,   49,
			   48,   47,   46,   45,   44,  133,  132,    0,    0,    0,
			    0,    0,  131,  130,  129,  128,    0,  127,    0,    0,
			  126,   74,  125,   72,    2,   71,   70,    0,    0,  124,
			    0,    0,   68,    0,  123,    0,    0,  335,    0,  104,
			    0,    0,   67,   66,   72,  121,    0,    0,   76,   75,
			    0,  120,    0,    0,    0,    0,    0,  720,    0,    0,
			    0,    0,  119,   30,   74,   73,   72,    2,   71,   70,

			    0,   69,    0,    0,    0,   68,    0,  118,  117,    0,
			    0,    0,    0,    0,  116,   67,   66,    0,    0,    0,
			    0,    0,    0,    0,  334,    0,   65,   64,   63,   62,
			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,   45,   44,   64,    0,
			   62,   61,   60,   59,   58,   57,   56,   55,   54,   53,
			   52,   51,   50,   49,   48,   47,   46,   45,   44,   65,
			   64,   63,   62,   61,   60,   59,   58,   57,   56,   55,
			   54,   53,   52,   51,   50,   49,   48,   47,   46,   45,
			   44,   76,   75,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,   30,   74,   73,   72,
			    2,   71,   70,    0,    0,    0,    0,    0,   68,   76,
			   75,    0,    0,    0,    0,    0,    0,    0,   67,   66,
			    0,    0,    0,    0,   30,   74,   73,   72,    0,   71,
			  216,  215,  214,  213,  212,  211,  210,  209,  208,  207,
			  206,  205,  204,  203,  202,  131,   67,   66,    0,   72,
			    0,  218,  217,  216,  215,  214,  213,  212,  211,  210,
			  209,  208,  207,  206,  205,  204,  203,  202,  131,    0,
			  578,   72,   65,   64,   63,   62,   61,   60,   59,   58,
			   57,   56,   55,   54,   53,   52,   51,   50,   49,   48,

			   47,   46,   45,   44,  577,    0,    0,    0,    0,    0,
			   65,   64,   63,   62,   61,   60,   59,   58,   57,   56,
			   55,   54,   53,   52,   51,   50,   49,   48,   47,   46,
			   45,   44,   65,   64,   63,   62,   61,   60,   59,   58,
			   57,   56,   55,   54,   53,   52,   51,   50,   49,   48,
			   47,   46,   45,   44,  799,   64,    0,   62,   61,   60,
			   59,   58,   57,   56,   55,   54,   53,   52,   51,   50,
			   49,   48,   47,   46,   45,   44,  218,  217,  216,  215,
			  214,  213,  212,  211,  210,  209,  208,  207,  206,  205,
			  204,  203,  202,  131,  218,  217,  216,  215,  214,  213,

			  212,  211,  210,  209,  208,  207,  206,  205,  204,  203,
			  202,  131,  218,  217,  216,  215,  214,  213,  212,  211,
			  210,  209,  208,  207,  206,  205,  204,  203,  202,  131,
			  218,  217,  216,  215,  214,  213,  212,  211,  210,  209,
			  208,  207,  206,  205,  204,  203,  202,  131,    0,    0,
			    0,    0,    0,  728,  215,  214,  213,  212,  211,  210,
			  209,  208,  207,  206,  205,  204,  203,  202,  131,  719,
			    0,  346,    0,  793,  218,  217,  216,  215,  214,  213,
			  212,  211,  210,  209,  208,  207,  206,  205,  204,  203,
			  202,  131,  218,  217,  216,  215,  214,  213,  212,  211,

			  210,  209,  208,  207,  206,  205,  204,  203,  202,  131,
			    0,    0,    0,    0,    0,  333,  217,  216,  215,  214,
			  213,  212,  211,  210,  209,  208,  207,  206,  205,  204,
			  203,  202,  131,  288,    0,  280,  279,  278,  277,  276,
			  275,  274,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,  264,    0,  263,  218,  217,  216,  215,  214,  213,
			  212,  211,  210,  209,  208,  207,  206,  205,  204,  203,
			  202,  131>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   12,   24,   24,   24,    3,   24,  178,    8,  197,
			   10,  121,   12,    3,    7,  161,  234,  621,    9,  318,
			   11,   25,  533,  118,   24,   29,  180,  412,  610,  398,
			   26,  613,   24,   40,   33,  429,   33,   33,   33,   33,
			  644,  488,   36,   14,   15,   35,  650,  201,   39,   26,
			   46,   46,   26,   26,   26,   49,   33,    0,   29,   30,
			  429,  643,   33,   30,   60,   66,   33,    0,   40,  223,
			  224,   33,   70,   46,   68,  522,   33,   76,   33,   53,
			   70,  663,   56,   60,  106,  106,  106,   81,  106,   88,
			   97,   92,   33,  675,  698,   36,   93,   93,   93,   76,

			   71,   99,   96,   60,   71,   46,  106,  103,  502,   99,
			  692,   88,  110,   75,  106,  719,   93,  117,   33,   40,
			  110,   36,   33,   33,  122,   36,   36,   68,  732,   33,
			   28,   46,  122,  502,   48,   33,   33,   72,   49,  727,
			   81,  526,  527,   78,   96,   66,  241,  658,   33,   66,
			   47,  450,   66,   68,  742,   96,   60,   68,   68,   94,
			   14,   15,  114,  767,   33,   25,   81,  771,  168,   40,
			   81,   81,  124,  490,  172,   29,   47,   46,   76,   33,
			  180,   96,  172,   25,  175,   96,   96,   33,  178,  793,
			   88,   76,  363,   53,  194,  799,   56,  197,  352,  190,

			   46,  201,  519,   88,   40,   75,  228,   76,   26,   45,
			   80,   68,  164,   70,  166,  167,   26,   71,  517,   88,
			   38,   39,  287,  223,  224,   62,  543,  179,   38,  324,
			  566,   64,   47,   66,  430,  235,   73,  237,  238,   96,
			   62,   63,  578,  243,  244,  245,  341,   40,   70,  249,
			  446,  447,   45,  449,   26,   66,  256,   25,   69,   25,
			  325,  326,   26,   85,  329,  330,  331,   39,  220,   33,
			   38,   35,   38,   25,  470,  340,   66,   41,   89,   90,
			  345,   41,   46,  630,   95,   21,  585,   98,   33,  485,
			   25,  638,  357,   57,   65,  390,   60,   61,    3,   59,

			   62,   63,  601,   38,   40,   41,   66,   71,   70,   40,
			   74,   71,    3,  313,   45,   75,  426,  112,  113,   79,
			   82,  416,   86,   85,  389,   66,   41,  327,   40,   93,
			  125,  126,  284,  285,   75,   47,   64,  335,  448,  404,
			  405,   37,   14,   15,   59,  335,   26,  646,  348,  444,
			   46,   66,  352,  353,   37,  420,   71,   29,   38,   39,
			   75,   33,   40,   40,   79,   40,  318,  319,  379,  360,
			   45,   49,   49,  363,  374,  375,   64,  377,   66,  379,
			    3,   64,   65,   66,   67,  376,  386,  378,  498,  499,
			   40,  391,   37,  397,    3,   40,   79,   47,  508,  351,

			  100,  101,  406,  513,  514,  409,   27,  359,   46,   92,
			  362,   66,   29,  142,   31,   47,   48,  100,  101,  102,
			   41,   42,  412,  611,   66,  763,  764,  765,  766,   71,
			  618,   73,  423,   75,   20,   21,  388,   79,   59,   66,
			   64,   65,   66,   67,   71,   66,   73,   47,   75,  401,
			   71,   29,   79,   31,   75,   79,   77,  577,   79,  579,
			   37,  413,   25,   84,   41,   42,  195,  196,   92,  198,
			  199,  200,   47,   48,   25,   26,  100,  101,  102,   66,
			  100,   64,   59,  102,   66,  703,  632,   35,   47,   66,
			  101,   62,   63,  222,   71,   66,   25,   58,   75,   70,

			   25,   62,   79,   25,   75,   66,  497,   68,   66,   70,
			   25,   82,   73,   26,   85,   79,  468,   37,  247,   37,
			   66,   92,   92,   97,  253,  743,   62,   63,   27,  100,
			  101,   39,  532,   67,   70,   96,  526,  527,   40,   82,
			   64,   91,  760,  565,  565,  565,   82,  565,   84,   85,
			  550,  697,   49,  282,  552,   91,   16,   17,   18,   19,
			   20,   21,  552,   66,  293,  294,  295,  296,  297,  298,
			  299,  300,  301,  302,  303,  304,  305,   84,  307,  308,
			   75,  310,  311,  312,   48,  537,  586,  316,   66,  589,
			  583,  762,  590,   66,  740,   39,  548,   58,   45,  592,

			  590,   62,   45,   41,   42,   66,   75,   68,  337,   70,
			   66,  611,   73,   95,   66,   39,   73,   89,  618,   40,
			  572,   59,   62,   63,   66,   79,  355,  356,   66,   46,
			   70,   46,   46,   71,   66,   96,   98,   75,  636,   55,
			   40,   79,   82,   71,   84,   85,  636,   40,   66,  104,
			   69,   91,   26,  104,   26,   47,  385,   47,   47,   86,
			   47,   47,  662,   48,  616,   47,   47,   42,  620,   14,
			   15,   16,   17,   18,   19,   20,   21,  677,   41,   59,
			  678,   37,   25,   86,   25,   47,  676,  639,  678,   38,
			   25,   25,   50,   33,   45,   47,   40,  649,   77,   47,

			   47,   47,  104,   25,  702,   44,   25,   49,   25,   40,
			   26,  731,  702,   49,   46,  715,   66,   47,   46,   48,
			  731,   35,   29,   29,   39,   58,  531,  727,  555,  422,
			  422,  731,  127,  128,  495,  130,  422,  132,  133,  123,
			  456,  618,  742,  763,  764,   70,  766,  550,  768,  144,
			  571,  631,  581,  764,  765,  766,   82,  768,  710,  513,
			  662,  662,  359,  763,  764,  765,  766,  382,  768,  662,
			  662,  662,  762,  662,  662,  662,  638,  322,  173,  768,
			  327,  176,  469,  505,  713,  737,  738,  484,  757,  401,
			  185,  499,  565,  106,  327,  662,   -1,   -1,   -1,   -1,

			  800,   -1,   -1,   -1,   -1,  757,   -1,  202,  203,  204,
			  205,  206,  207,  208,  209,  210,  211,  212,  213,  214,
			  215,  216,  217,  218,  219,   -1,   -1,   14,   15,   -1,
			   -1,  226,   -1,   -1,   21,   22,   23,   24,   -1,   26,
			   -1,   -1,   29,   30,   31,   32,   33,   34,   35,   -1,
			   -1,   38,   -1,  248,   41,   -1,   43,   -1,   45,   46,
			   -1,   48,   -1,   -1,   51,   52,   -1,   54,   -1,  598,
			   -1,   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,  608,
			   -1,   -1,   -1,   -1,   71,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   86,

			   87,   -1,   -1,   -1,   -1,   -1,   93,   -1,   -1,   -1,
			   -1,  306,   -1,   -1,  309,   -1,  103,   -1,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  343,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  691,   -1,   -1,   -1,   -1,  696,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  707,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  382,  717,  718,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			  729,  730,   -1,   -1,   -1,   -1,  735,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   14,   15,   -1,   -1,   -1,
			   -1,   -1,   21,   22,   23,   24,   -1,   26,   -1,   -1,
			   29,   30,   31,   32,   33,   34,   35,   -1,   -1,   38,
			  769,  770,   41,   -1,   43,   -1,   -1,   46,   -1,   48,
			   -1,   -1,   51,   52,   -1,   54,   -1,   -1,   -1,   -1,
			   -1,   60,   -1,   -1,   -1,   64,   -1,  796,   -1,   -1,
			   -1,   -1,   71,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   86,   87,   -1,
			   -1,   -1,   -1,   -1,   93,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,  103,   -1,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,   14,   15,
			   -1,   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,
			   26,   -1,   -1,   29,   30,   31,   32,   33,   34,   35,
			   -1,   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   -1,
			   46,   -1,   48,   -1,   -1,   51,   52,   -1,   54,   -1,
			   -1,   -1,   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   71,   -1,   -1,   -1,   -1,
			   -1,  586,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   86,   87,   -1,   -1,   -1,   -1,   -1,   93,  603,   -1,
			   -1,   97,   -1,   -1,   -1,   -1,   -1,  103,   -1,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  668,   -1,   -1,   -1,  672,   -1,   -1,
			   -1,   -1,   -1,   -1,  679,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  694,

			  695,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   14,
			   15,   -1,   -1,  708,  709,   -1,   21,   22,   23,   24,
			  715,   26,   -1,   -1,   29,   30,   31,   32,   33,   34,
			   35,   -1,   -1,   38,   -1,   -1,   41,   -1,   43,  102,
			   45,   46,   -1,   48,   -1,   -1,   51,   52,   -1,   54,
			   -1,   -1,   -1,   -1,   -1,   60,   -1,   -1,  753,  754,
			   -1,   -1,   -1,   -1,   -1,   -1,   71,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  774,
			   -1,   86,   87,   -1,   -1,   -1,   -1,   -1,   93,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  103,   -1,

			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,   14,   15,   -1,   -1,   -1,   -1,   -1,   21,
			   22,   23,   24,   -1,   26,   -1,   -1,   29,   30,   31,
			   32,   33,   34,   35,   -1,   -1,   38,   -1,   -1,   41,
			   -1,   43,   -1,   -1,   46,   -1,   48,   -1,   -1,   51,
			   52,   -1,   54,   -1,   -1,   -1,   -1,   -1,   60,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   71,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   86,   87,   -1,   -1,   -1,   -1,

			   -1,   93,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  103,   -1,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,   14,   15,   -1,   -1,   -1,
			   -1,   -1,   21,   22,   23,   24,   -1,   26,   -1,   -1,
			   29,   30,   31,   32,   33,   34,   35,   -1,   -1,   38,
			   -1,   -1,   41,   -1,   43,   -1,   -1,   46,   -1,   48,
			   -1,   -1,   51,   52,   32,   54,   -1,   -1,   14,   15,
			   -1,   60,   -1,   -1,   -1,   -1,   -1,   45,   -1,   -1,
			   -1,   -1,   71,   29,   30,   31,   32,   33,   34,   35,

			   -1,   37,   -1,   -1,   -1,   41,   -1,   86,   87,   -1,
			   -1,   -1,   -1,   -1,   93,   51,   52,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  103,   -1,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  106,   -1,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,   14,   15,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   29,   30,   31,   32,
			   33,   34,   35,   -1,   -1,   -1,   -1,   -1,   41,   14,
			   15,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   51,   52,
			   -1,   -1,   -1,   -1,   29,   30,   31,   32,   -1,   34,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   51,   52,   -1,   32,
			   -1,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   -1,
			   75,   32,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,

			  123,  124,  125,  126,   99,   -1,   -1,   -1,   -1,   -1,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,   97,  106,   -1,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,    4,    5,    6,    7,    8,    9,

			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   -1,   -1,
			   -1,   -1,   -1,   45,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   97,
			   -1,   45,   -1,   83,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,    4,    5,    6,    7,    8,    9,   10,   11,

			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   -1,   -1,   -1,   -1,   -1,   45,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   45,   -1,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,   -1,  126,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21>>)
		end

feature {NONE} -- Conversion

	yytype2 (v: ANY): ACCESS_AS is
		require
			valid_type: yyis_type2 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type2 (v: ANY): BOOLEAN is
		local
			u: ACCESS_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype3 (v: ANY): ACCESS_FEAT_AS is
		require
			valid_type: yyis_type3 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type3 (v: ANY): BOOLEAN is
		local
			u: ACCESS_FEAT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype4 (v: ANY): ACCESS_INV_AS is
		require
			valid_type: yyis_type4 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type4 (v: ANY): BOOLEAN is
		local
			u: ACCESS_INV_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype5 (v: ANY): ARRAY_AS is
		require
			valid_type: yyis_type5 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type5 (v: ANY): BOOLEAN is
		local
			u: ARRAY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype6 (v: ANY): ASSIGN_AS is
		require
			valid_type: yyis_type6 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type6 (v: ANY): BOOLEAN is
		local
			u: ASSIGN_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype7 (v: ANY): ATOMIC_AS is
		require
			valid_type: yyis_type7 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type7 (v: ANY): BOOLEAN is
		local
			u: ATOMIC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype8 (v: ANY): BIT_CONST_AS is
		require
			valid_type: yyis_type8 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type8 (v: ANY): BOOLEAN is
		local
			u: BIT_CONST_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype9 (v: ANY): BODY_AS is
		require
			valid_type: yyis_type9 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type9 (v: ANY): BOOLEAN is
		local
			u: BODY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype10 (v: ANY): BOOL_AS is
		require
			valid_type: yyis_type10 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type10 (v: ANY): BOOLEAN is
		local
			u: BOOL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype11 (v: ANY): CALL_AS is
		require
			valid_type: yyis_type11 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type11 (v: ANY): BOOLEAN is
		local
			u: CALL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype12 (v: ANY): CASE_AS is
		require
			valid_type: yyis_type12 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type12 (v: ANY): BOOLEAN is
		local
			u: CASE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype13 (v: ANY): CHAR_AS is
		require
			valid_type: yyis_type13 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type13 (v: ANY): BOOLEAN is
		local
			u: CHAR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype14 (v: ANY): CHECK_AS is
		require
			valid_type: yyis_type14 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type14 (v: ANY): BOOLEAN is
		local
			u: CHECK_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype15 (v: ANY): CLIENT_AS is
		require
			valid_type: yyis_type15 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type15 (v: ANY): BOOLEAN is
		local
			u: CLIENT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype16 (v: ANY): CONTENT_AS is
		require
			valid_type: yyis_type16 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type16 (v: ANY): BOOLEAN is
		local
			u: CONTENT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype17 (v: ANY): CONVERT_FEAT_AS is
		require
			valid_type: yyis_type17 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type17 (v: ANY): BOOLEAN is
		local
			u: CONVERT_FEAT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype18 (v: ANY): CREATE_AS is
		require
			valid_type: yyis_type18 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type18 (v: ANY): BOOLEAN is
		local
			u: CREATE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype19 (v: ANY): CREATION_AS is
		require
			valid_type: yyis_type19 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type19 (v: ANY): BOOLEAN is
		local
			u: CREATION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype20 (v: ANY): CREATION_EXPR_AS is
		require
			valid_type: yyis_type20 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type20 (v: ANY): BOOLEAN is
		local
			u: CREATION_EXPR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype21 (v: ANY): DEBUG_AS is
		require
			valid_type: yyis_type21 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type21 (v: ANY): BOOLEAN is
		local
			u: DEBUG_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype22 (v: ANY): ELSIF_AS is
		require
			valid_type: yyis_type22 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type22 (v: ANY): BOOLEAN is
		local
			u: ELSIF_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype23 (v: ANY): ENSURE_AS is
		require
			valid_type: yyis_type23 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type23 (v: ANY): BOOLEAN is
		local
			u: ENSURE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype24 (v: ANY): EXPORT_ITEM_AS is
		require
			valid_type: yyis_type24 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type24 (v: ANY): BOOLEAN is
		local
			u: EXPORT_ITEM_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype25 (v: ANY): EXPR_AS is
		require
			valid_type: yyis_type25 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type25 (v: ANY): BOOLEAN is
		local
			u: EXPR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype26 (v: ANY): EXTERNAL_AS is
		require
			valid_type: yyis_type26 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type26 (v: ANY): BOOLEAN is
		local
			u: EXTERNAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype27 (v: ANY): EXTERNAL_LANG_AS is
		require
			valid_type: yyis_type27 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type27 (v: ANY): BOOLEAN is
		local
			u: EXTERNAL_LANG_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype28 (v: ANY): FEATURE_AS is
		require
			valid_type: yyis_type28 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type28 (v: ANY): BOOLEAN is
		local
			u: FEATURE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype29 (v: ANY): FEATURE_CLAUSE_AS is
		require
			valid_type: yyis_type29 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type29 (v: ANY): BOOLEAN is
		local
			u: FEATURE_CLAUSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype30 (v: ANY): FEATURE_SET_AS is
		require
			valid_type: yyis_type30 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type30 (v: ANY): BOOLEAN is
		local
			u: FEATURE_SET_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype31 (v: ANY): FORMAL_DEC_AS is
		require
			valid_type: yyis_type31 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type31 (v: ANY): BOOLEAN is
		local
			u: FORMAL_DEC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype32 (v: ANY): ID_AS is
		require
			valid_type: yyis_type32 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type32 (v: ANY): BOOLEAN is
		local
			u: ID_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype33 (v: ANY): IF_AS is
		require
			valid_type: yyis_type33 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type33 (v: ANY): BOOLEAN is
		local
			u: IF_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype34 (v: ANY): INDEX_AS is
		require
			valid_type: yyis_type34 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type34 (v: ANY): BOOLEAN is
		local
			u: INDEX_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype35 (v: ANY): INSPECT_AS is
		require
			valid_type: yyis_type35 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type35 (v: ANY): BOOLEAN is
		local
			u: INSPECT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype36 (v: ANY): INSTR_CALL_AS is
		require
			valid_type: yyis_type36 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type36 (v: ANY): BOOLEAN is
		local
			u: INSTR_CALL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype37 (v: ANY): INSTRUCTION_AS is
		require
			valid_type: yyis_type37 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type37 (v: ANY): BOOLEAN is
		local
			u: INSTRUCTION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype38 (v: ANY): INTEGER_CONSTANT is
		require
			valid_type: yyis_type38 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type38 (v: ANY): BOOLEAN is
		local
			u: INTEGER_CONSTANT
		do
			u ?= v
			Result := (u = v)
		end

	yytype39 (v: ANY): INTERNAL_AS is
		require
			valid_type: yyis_type39 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type39 (v: ANY): BOOLEAN is
		local
			u: INTERNAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype40 (v: ANY): INTERVAL_AS is
		require
			valid_type: yyis_type40 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type40 (v: ANY): BOOLEAN is
		local
			u: INTERVAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype41 (v: ANY): INVARIANT_AS is
		require
			valid_type: yyis_type41 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type41 (v: ANY): BOOLEAN is
		local
			u: INVARIANT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype42 (v: ANY): LOOP_AS is
		require
			valid_type: yyis_type42 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type42 (v: ANY): BOOLEAN is
		local
			u: LOOP_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype43 (v: ANY): NESTED_AS is
		require
			valid_type: yyis_type43 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type43 (v: ANY): BOOLEAN is
		local
			u: NESTED_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype44 (v: ANY): NESTED_EXPR_AS is
		require
			valid_type: yyis_type44 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type44 (v: ANY): BOOLEAN is
		local
			u: NESTED_EXPR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype45 (v: ANY): OPERAND_AS is
		require
			valid_type: yyis_type45 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type45 (v: ANY): BOOLEAN is
		local
			u: OPERAND_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype46 (v: ANY): PARENT_AS is
		require
			valid_type: yyis_type46 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type46 (v: ANY): BOOLEAN is
		local
			u: PARENT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype47 (v: ANY): PRECURSOR_AS is
		require
			valid_type: yyis_type47 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type47 (v: ANY): BOOLEAN is
		local
			u: PRECURSOR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype48 (v: ANY): STATIC_ACCESS_AS is
		require
			valid_type: yyis_type48 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type48 (v: ANY): BOOLEAN is
		local
			u: STATIC_ACCESS_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype49 (v: ANY): REAL_AS is
		require
			valid_type: yyis_type49 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type49 (v: ANY): BOOLEAN is
		local
			u: REAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype50 (v: ANY): RENAME_AS is
		require
			valid_type: yyis_type50 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type50 (v: ANY): BOOLEAN is
		local
			u: RENAME_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype51 (v: ANY): REQUIRE_AS is
		require
			valid_type: yyis_type51 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type51 (v: ANY): BOOLEAN is
		local
			u: REQUIRE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype52 (v: ANY): RETRY_AS is
		require
			valid_type: yyis_type52 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type52 (v: ANY): BOOLEAN is
		local
			u: RETRY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype53 (v: ANY): REVERSE_AS is
		require
			valid_type: yyis_type53 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type53 (v: ANY): BOOLEAN is
		local
			u: REVERSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype54 (v: ANY): ROUT_BODY_AS is
		require
			valid_type: yyis_type54 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type54 (v: ANY): BOOLEAN is
		local
			u: ROUT_BODY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype55 (v: ANY): ROUTINE_AS is
		require
			valid_type: yyis_type55 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type55 (v: ANY): BOOLEAN is
		local
			u: ROUTINE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype56 (v: ANY): ROUTINE_CREATION_AS is
		require
			valid_type: yyis_type56 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type56 (v: ANY): BOOLEAN is
		local
			u: ROUTINE_CREATION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype57 (v: ANY): STRING_AS is
		require
			valid_type: yyis_type57 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type57 (v: ANY): BOOLEAN is
		local
			u: STRING_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype58 (v: ANY): TAGGED_AS is
		require
			valid_type: yyis_type58 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type58 (v: ANY): BOOLEAN is
		local
			u: TAGGED_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype59 (v: ANY): TUPLE_AS is
		require
			valid_type: yyis_type59 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type59 (v: ANY): BOOLEAN is
		local
			u: TUPLE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype60 (v: ANY): EIFFEL_TYPE is
		require
			valid_type: yyis_type60 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type60 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_TYPE
		do
			u ?= v
			Result := (u = v)
		end

	yytype61 (v: ANY): TYPE_DEC_AS is
		require
			valid_type: yyis_type61 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type61 (v: ANY): BOOLEAN is
		local
			u: TYPE_DEC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype62 (v: ANY): VARIANT_AS is
		require
			valid_type: yyis_type62 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type62 (v: ANY): BOOLEAN is
		local
			u: VARIANT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype63 (v: ANY): EIFFEL_LIST [ATOMIC_AS] is
		require
			valid_type: yyis_type63 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type63 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ATOMIC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype64 (v: ANY): EIFFEL_LIST [CASE_AS] is
		require
			valid_type: yyis_type64 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type64 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CASE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype65 (v: ANY): EIFFEL_LIST [CONVERT_FEAT_AS] is
		require
			valid_type: yyis_type65 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type65 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype66 (v: ANY): EIFFEL_LIST [CREATE_AS] is
		require
			valid_type: yyis_type66 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type66 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CREATE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype67 (v: ANY): EIFFEL_LIST [ELSIF_AS] is
		require
			valid_type: yyis_type67 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type67 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ELSIF_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype68 (v: ANY): EIFFEL_LIST [EXPORT_ITEM_AS] is
		require
			valid_type: yyis_type68 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type68 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype69 (v: ANY): EIFFEL_LIST [EXPR_AS] is
		require
			valid_type: yyis_type69 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type69 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXPR_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype70 (v: ANY): EIFFEL_LIST [FEATURE_AS] is
		require
			valid_type: yyis_type70 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type70 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype71 (v: ANY): EIFFEL_LIST [FEATURE_CLAUSE_AS] is
		require
			valid_type: yyis_type71 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type71 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype73 (v: ANY): EIFFEL_LIST [FEATURE_NAME] is
		require
			valid_type: yyis_type73 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type73 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_NAME]
		do
			u ?= v
			Result := (u = v)
		end

	yytype74 (v: ANY): EIFFEL_LIST [FORMAL_DEC_AS] is
		require
			valid_type: yyis_type74 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type74 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FORMAL_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype75 (v: ANY): EIFFEL_LIST [ID_AS] is
		require
			valid_type: yyis_type75 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type75 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ID_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype77 (v: ANY): ARRAYED_LIST [INTEGER] is
		require
			valid_type: yyis_type77 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type77 (v: ANY): BOOLEAN is
		local
			u: ARRAYED_LIST [INTEGER]
		do
			u ?= v
			Result := (u = v)
		end

	yytype78 (v: ANY): INDEXING_CLAUSE_AS is
		require
			valid_type: yyis_type78 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type78 (v: ANY): BOOLEAN is
		local
			u: INDEXING_CLAUSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype79 (v: ANY): EIFFEL_LIST [INSTRUCTION_AS] is
		require
			valid_type: yyis_type79 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type79 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INSTRUCTION_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype80 (v: ANY): EIFFEL_LIST [INTERVAL_AS] is
		require
			valid_type: yyis_type80 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type80 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INTERVAL_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype81 (v: ANY): EIFFEL_LIST [OPERAND_AS] is
		require
			valid_type: yyis_type81 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type81 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [OPERAND_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype82 (v: ANY): EIFFEL_LIST [PARENT_AS] is
		require
			valid_type: yyis_type82 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type82 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [PARENT_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype83 (v: ANY): EIFFEL_LIST [RENAME_AS] is
		require
			valid_type: yyis_type83 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type83 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [RENAME_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype84 (v: ANY): EIFFEL_LIST [STRING_AS] is
		require
			valid_type: yyis_type84 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type84 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [STRING_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype85 (v: ANY): EIFFEL_LIST [TAGGED_AS] is
		require
			valid_type: yyis_type85 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type85 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TAGGED_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype86 (v: ANY): EIFFEL_LIST [EIFFEL_TYPE] is
		require
			valid_type: yyis_type86 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type86 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EIFFEL_TYPE]
		do
			u ?= v
			Result := (u = v)
		end

	yytype87 (v: ANY): EIFFEL_LIST [TYPE_DEC_AS] is
		require
			valid_type: yyis_type87 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type87 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype89 (v: ANY): PAIR [ID_AS, CLICK_AST] is
		require
			valid_type: yyis_type89 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type89 (v: ANY): BOOLEAN is
		local
			u: PAIR [ID_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype90 (v: ANY): PAIR [FEATURE_NAME, CLICK_AST] is
		require
			valid_type: yyis_type90 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type90 (v: ANY): BOOLEAN is
		local
			u: PAIR [FEATURE_NAME, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype91 (v: ANY): PAIR [STRING_AS, CLICK_AST] is
		require
			valid_type: yyis_type91 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type91 (v: ANY): BOOLEAN is
		local
			u: PAIR [STRING_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype92 (v: ANY): PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST] is
		require
			valid_type: yyis_type92 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type92 (v: ANY): BOOLEAN is
		local
			u: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype93 (v: ANY): PAIR [EIFFEL_TYPE, EIFFEL_LIST [FEATURE_NAME]] is
		require
			valid_type: yyis_type93 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type93 (v: ANY): BOOLEAN is
		local
			u: PAIR [EIFFEL_TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
			u ?= v
			Result := (u = v)
		end

	yytype94 (v: ANY): TOKEN_LOCATION is
		require
			valid_type: yyis_type94 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type94 (v: ANY): BOOLEAN is
		local
			u: TOKEN_LOCATION
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 806
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 127
			-- Number of tokens

	yyLast: INTEGER is 2071
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 381
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 307
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
