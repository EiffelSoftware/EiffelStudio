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
			if yy_act <= 200 then
				yy_do_action_1_200 (yy_act)
			elseif yy_act <= 400 then
				yy_do_action_201_400 (yy_act)
			elseif yy_act <= 600 then
				yy_do_action_401_600 (yy_act)
			else
					-- No action
				yyval := yyval_default
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
					-- No action
				yyval := yyval_default
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
--|#line 1553 "eiffel.y"
	yy_do_action_302
when 303 then
--|#line 1558 "eiffel.y"
	yy_do_action_303
when 304 then
--|#line 1565 "eiffel.y"
	yy_do_action_304
when 305 then
--|#line 1571 "eiffel.y"
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
--|#line 1591 "eiffel.y"
	yy_do_action_314
when 315 then
--|#line 1600 "eiffel.y"
	yy_do_action_315
when 316 then
--|#line 1602 "eiffel.y"
	yy_do_action_316
when 317 then
--|#line 1606 "eiffel.y"
	yy_do_action_317
when 318 then
--|#line 1608 "eiffel.y"
	yy_do_action_318
when 319 then
--|#line 1619 "eiffel.y"
	yy_do_action_319
when 320 then
--|#line 1621 "eiffel.y"
	yy_do_action_320
when 321 then
--|#line 1625 "eiffel.y"
	yy_do_action_321
when 322 then
--|#line 1627 "eiffel.y"
	yy_do_action_322
when 323 then
--|#line 1631 "eiffel.y"
	yy_do_action_323
when 324 then
--|#line 1633 "eiffel.y"
	yy_do_action_324
when 325 then
--|#line 1641 "eiffel.y"
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
--|#line 1661 "eiffel.y"
	yy_do_action_334
when 335 then
--|#line 1669 "eiffel.y"
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
--|#line 1743 "eiffel.y"
	yy_do_action_371
when 372 then
--|#line 1751 "eiffel.y"
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
--|#line 1777 "eiffel.y"
	yy_do_action_384
when 385 then
--|#line 1781 "eiffel.y"
	yy_do_action_385
when 386 then
--|#line 1785 "eiffel.y"
	yy_do_action_386
when 387 then
--|#line 1789 "eiffel.y"
	yy_do_action_387
when 388 then
--|#line 1793 "eiffel.y"
	yy_do_action_388
when 389 then
--|#line 1797 "eiffel.y"
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
--|#line 1807 "eiffel.y"
	yy_do_action_393
when 394 then
--|#line 1811 "eiffel.y"
	yy_do_action_394
when 395 then
--|#line 1818 "eiffel.y"
	yy_do_action_395
when 396 then
--|#line 1826 "eiffel.y"
	yy_do_action_396
when 397 then
--|#line 1828 "eiffel.y"
	yy_do_action_397
when 398 then
--|#line 1832 "eiffel.y"
	yy_do_action_398
when 399 then
--|#line 1834 "eiffel.y"
	yy_do_action_399
when 400 then
--|#line 1838 "eiffel.y"
	yy_do_action_400
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_401_600 (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
when 401 then
--|#line 1851 "eiffel.y"
	yy_do_action_401
when 402 then
--|#line 1855 "eiffel.y"
	yy_do_action_402
when 403 then
--|#line 1857 "eiffel.y"
	yy_do_action_403
when 404 then
--|#line 1859 "eiffel.y"
	yy_do_action_404
when 405 then
--|#line 1863 "eiffel.y"
	yy_do_action_405
when 406 then
--|#line 1868 "eiffel.y"
	yy_do_action_406
when 407 then
--|#line 1875 "eiffel.y"
	yy_do_action_407
when 408 then
--|#line 1877 "eiffel.y"
	yy_do_action_408
when 409 then
--|#line 1881 "eiffel.y"
	yy_do_action_409
when 410 then
--|#line 1886 "eiffel.y"
	yy_do_action_410
when 411 then
--|#line 1897 "eiffel.y"
	yy_do_action_411
when 412 then
--|#line 1901 "eiffel.y"
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
--|#line 1915 "eiffel.y"
	yy_do_action_418
when 419 then
--|#line 1917 "eiffel.y"
	yy_do_action_419
when 420 then
--|#line 1919 "eiffel.y"
	yy_do_action_420
when 421 then
--|#line 1934 "eiffel.y"
	yy_do_action_421
when 422 then
--|#line 1936 "eiffel.y"
	yy_do_action_422
when 423 then
--|#line 1938 "eiffel.y"
	yy_do_action_423
when 424 then
--|#line 1942 "eiffel.y"
	yy_do_action_424
when 425 then
--|#line 1944 "eiffel.y"
	yy_do_action_425
when 426 then
--|#line 1948 "eiffel.y"
	yy_do_action_426
when 427 then
--|#line 1955 "eiffel.y"
	yy_do_action_427
when 428 then
--|#line 1970 "eiffel.y"
	yy_do_action_428
when 429 then
--|#line 1985 "eiffel.y"
	yy_do_action_429
when 430 then
--|#line 2003 "eiffel.y"
	yy_do_action_430
when 431 then
--|#line 2005 "eiffel.y"
	yy_do_action_431
when 432 then
--|#line 2007 "eiffel.y"
	yy_do_action_432
when 433 then
--|#line 2014 "eiffel.y"
	yy_do_action_433
when 434 then
--|#line 2018 "eiffel.y"
	yy_do_action_434
when 435 then
--|#line 2020 "eiffel.y"
	yy_do_action_435
when 436 then
--|#line 2022 "eiffel.y"
	yy_do_action_436
when 437 then
--|#line 2026 "eiffel.y"
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
--|#line 2070 "eiffel.y"
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
--|#line 2080 "eiffel.y"
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
--|#line 2118 "eiffel.y"
	yy_do_action_480
when 481 then
--|#line 2122 "eiffel.y"
	yy_do_action_481
when 482 then
--|#line 2126 "eiffel.y"
	yy_do_action_482
when 483 then
--|#line 2130 "eiffel.y"
	yy_do_action_483
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 173 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 173")
end
			yyval := yyval_default;
				if type_parser then
					raise_error
				end
			

		end

	yy_do_action_2 is
			--|#line 180 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 180")
end
			yyval := yyval_default;
				if not type_parser then
					raise_error
				end
				type_node := yytype59 (yyvs.item (yyvsp))
			

		end

	yy_do_action_3 is
			--|#line 189 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 189")
end
			yyval := yyval_default;
				root_node := new_class_description (yytype88 (yyvs.item (yyvsp - 13)), yytype56 (yyvs.item (yyvsp - 11)),
					is_deferred, is_expanded, is_separate, is_frozen_class, is_external_class,
					yytype77 (yyvs.item (yyvsp - 16)), yytype77 (yyvs.item (yyvsp - 1)), yytype73 (yyvs.item (yyvsp - 12)), yytype81 (yyvs.item (yyvsp - 9)), yytype65 (yyvs.item (yyvsp - 7)), yytype64 (yyvs.item (yyvsp - 6)), yytype70 (yyvs.item (yyvsp - 5)), yytype40 (yyvs.item (yyvsp - 3)), suppliers, yytype56 (yyvs.item (yyvsp - 10)), click_list
				)

				if real_class_end_position = 0 then
					root_node.set_text_positions (
						current_position.start_position,
						yytype93 (yyvs.item (yyvsp - 4)).start_position,
						yytype93 (yyvs.item (yyvsp - 8)).start_position,
						formal_generics_start_position,
						formal_generics_end_position,
						yytype93 (yyvs.item (yyvsp - 2)).start_position
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
			

		end

	yy_do_action_4 is
			--|#line 232 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 232")
end
			yyval := yyval_default;
				if inherit_context then
					inherit_context := False
					real_class_end_position := 0
				end
			

		end

	yy_do_action_5 is
			--|#line 241 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 241")
end

yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
		end

	yy_do_action_6 is
			--|#line 245 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 245")
end

yyval88 := new_clickable_id (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval88
		end

	yy_do_action_7 is
			--|#line 252 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 252")
end


			yyval := yyval77
		end

	yy_do_action_8 is
			--|#line 254 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 254")
end

yyval77 := yytype77 (yyvs.item (yyvsp)) 
			yyval := yyval77
		end

	yy_do_action_9 is
			--|#line 256 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 256")
end


			yyval := yyval77
		end

	yy_do_action_10 is
			--|#line 260 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 260")
end


			yyval := yyval77
		end

	yy_do_action_11 is
			--|#line 262 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 262")
end

yyval77 := yytype77 (yyvs.item (yyvsp)) 
			yyval := yyval77
		end

	yy_do_action_12 is
			--|#line 264 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 264")
end

yyval77 := Void 
			yyval := yyval77
		end

	yy_do_action_13 is
			--|#line 268 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 268")
end


			yyval := yyval77
		end

	yy_do_action_14 is
			--|#line 270 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 270")
end

yyval77 := yytype77 (yyvs.item (yyvsp - 1)) 
			yyval := yyval77
		end

	yy_do_action_15 is
			--|#line 272 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 272")
end

yyval77 := Void 
			yyval := yyval77
		end

	yy_do_action_16 is
			--|#line 276 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 276")
end

				yyval77 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval77.extend (yytype33 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_17 is
			--|#line 281 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 281")
end

				yyval77 := yytype77 (yyvs.item (yyvsp - 1))
				yyval77.extend (yytype33 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_18 is
			--|#line 288 "eiffel.y"
		local
			yyval33: INDEX_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 288")
end

yyval33 := new_index_as (yytype31 (yyvs.item (yyvsp - 2)), yytype62 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval33
		end

	yy_do_action_19 is
			--|#line 292 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 292")
end

yyval31 := yytype31 (yyvs.item (yyvsp - 1)) 
			yyval := yyval31
		end

	yy_do_action_20 is
			--|#line 294 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 294")
end

				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (current_position.start_position,
						current_position.end_position, filename, 0,
						"Missing `Index' part of `Index_clause'."))
				end
				yyval31 := Void
			
			yyval := yyval31
		end

	yy_do_action_21 is
			--|#line 306 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 306")
end

				yyval62 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval62.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_22 is
			--|#line 311 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 311")
end

				yyval62 := yytype62 (yyvs.item (yyvsp - 2))
				yyval62.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_23 is
			--|#line 316 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 316")
end

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval62 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval62
		end

	yy_do_action_24 is
			--|#line 323 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 323")
end

yyval6 := yytype31 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_25 is
			--|#line 325 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 325")
end

yyval6 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_26 is
			--|#line 327 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 327")
end

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype19 (yyvs.item (yyvsp - 1)), Void)
			
			yyval := yyval6
		end

	yy_do_action_27 is
			--|#line 331 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 331")
end

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype19 (yyvs.item (yyvsp - 2)), yytype58 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval6
		end

	yy_do_action_28 is
			--|#line 341 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 341")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_29 is
			--|#line 347 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 347")
end
			yyval := yyval_default;
				is_frozen_class := False
				is_deferred := True
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_30 is
			--|#line 354 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 354")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := True
				is_separate := False
			

		end

	yy_do_action_31 is
			--|#line 360 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 360")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := True
			

		end

	yy_do_action_32 is
			--|#line 368 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 368")
end
			yyval := yyval_default;
				is_frozen_class := False
			

		end

	yy_do_action_33 is
			--|#line 372 "eiffel.y"
		local

		do
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
			

		end

	yy_do_action_34 is
			--|#line 383 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 383")
end
			yyval := yyval_default;
				is_external_class := False
			

		end

	yy_do_action_35 is
			--|#line 387 "eiffel.y"
		local

		do
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
			

		end

	yy_do_action_36 is
			--|#line 402 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 402")
end


			yyval := yyval56
		end

	yy_do_action_37 is
			--|#line 404 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 404")
end

yyval56 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval56
		end

	yy_do_action_38 is
			--|#line 411 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 411")
end


			yyval := yyval70
		end

	yy_do_action_39 is
			--|#line 413 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 413")
end

				yyval70 := yytype70 (yyvs.item (yyvsp))
				if yyval70.is_empty then
					yyval70 := Void
				end
			
			yyval := yyval70
		end

	yy_do_action_40 is
			--|#line 422 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 422")
end

				yyval70 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval70, yytype28 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_41 is
			--|#line 427 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 427")
end

				yyval70 := yytype70 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval70, yytype28 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_42 is
			--|#line 434 "eiffel.y"
		local
			yyval28: FEATURE_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 434")
end

yyval28 := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) 
			yyval := yyval28
		end

	yy_do_action_43 is
			--|#line 436 "eiffel.y"
		local
			yyval28: FEATURE_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 436")
end

yyval28 := new_feature_clause_as (yytype14 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval28
		end

	yy_do_action_44 is
			--|#line 440 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 440")
end

yyval14 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval14
		end

	yy_do_action_45 is
			--|#line 440 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 440")
end
			yyval := yyval_default;
				inherit_context := False
				fclause_pos := clone (current_position)
			

		end

	yy_do_action_46 is
			--|#line 449 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 449")
end


			yyval := yyval14
		end

	yy_do_action_47 is
			--|#line 451 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 451")
end

yyval14 := new_client_as (yytype74 (yyvs.item (yyvsp))) 
			yyval := yyval14
		end

	yy_do_action_48 is
			--|#line 455 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 455")
end

				yyval74 := new_eiffel_list_id_as (1)
				yyval74.extend (new_none_id_as)
			
			yyval := yyval74
		end

	yy_do_action_49 is
			--|#line 460 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 460")
end

yyval74 := yytype74 (yyvs.item (yyvsp - 1)) 
			yyval := yyval74
		end

	yy_do_action_50 is
			--|#line 464 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 464")
end

				yyval74 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval74.extend (yytype88 (yyvs.item (yyvsp)).first)
				yytype88 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype88 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval74
		end

	yy_do_action_51 is
			--|#line 470 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 470")
end

				yyval74 := yytype74 (yyvs.item (yyvsp - 2))
				yyval74.extend (yytype88 (yyvs.item (yyvsp)).first)
				yytype88 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype88 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval74
		end

	yy_do_action_52 is
			--|#line 478 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [FEATURE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 478")
end

				yyval69 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval69.extend (yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval69
		end

	yy_do_action_53 is
			--|#line 483 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [FEATURE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 483")
end

				yyval69 := yytype69 (yyvs.item (yyvsp - 1))
				yyval69.extend (yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval69
		end

	yy_do_action_54 is
			--|#line 490 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 490")
end
			yyval := yyval_default;


		end

	yy_do_action_55 is
			--|#line 491 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 491")
end
			yyval := yyval_default;


		end

	yy_do_action_56 is
			--|#line 494 "eiffel.y"
		local
			yyval27: FEATURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 494")
end

					-- Generate a syntax error when `feature_indexes' is not
					-- Void and it applies to synonyms of the current feature
					-- declaration.
				if (il_parser and feature_indexes /= Void and yytype91 (yyvs.item (yyvsp - 2)).first.count /= 1) then
					raise_error
				end
				yyval27 := new_feature_declaration (yytype91 (yyvs.item (yyvsp - 2)), yytype8 (yyvs.item (yyvsp - 1)), feature_indexes)
				feature_indexes := Void
			
			yyval := yyval27
		end

	yy_do_action_57 is
			--|#line 507 "eiffel.y"
		local
			yyval91: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 507")
end

yyval91 := new_clickable_feature_name_list (yytype89 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval91
		end

	yy_do_action_58 is
			--|#line 509 "eiffel.y"
		local
			yyval91: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 509")
end

				yyval91 := yytype91 (yyvs.item (yyvsp - 2))
				yyval91.first.extend (yytype89 (yyvs.item (yyvsp)).first)
			
			yyval := yyval91
		end

	yy_do_action_59 is
			--|#line 516 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 516")
end

yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
		end

	yy_do_action_60 is
			--|#line 520 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 520")
end
			yyval := yyval_default;
is_frozen := False 

		end

	yy_do_action_61 is
			--|#line 522 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 522")
end
			yyval := yyval_default;
is_frozen := True 

		end

	yy_do_action_62 is
			--|#line 526 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 526")
end

yyval89 := new_clickable_feature_name (yytype88 (yyvs.item (yyvsp))) 
			yyval := yyval89
		end

	yy_do_action_63 is
			--|#line 528 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 528")
end

yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
		end

	yy_do_action_64 is
			--|#line 530 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 530")
end

yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
		end

	yy_do_action_65 is
			--|#line 534 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 534")
end

yyval89 := new_clickable_infix (yytype90 (yyvs.item (yyvsp))) 
			yyval := yyval89
		end

	yy_do_action_66 is
			--|#line 539 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 539")
end

yyval89 := new_clickable_prefix (yytype90 (yyvs.item (yyvsp))) 
			yyval := yyval89
		end

	yy_do_action_67 is
			--|#line 543 "eiffel.y"
		local
			yyval8: BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 543")
end

yyval8 := new_declaration_body (yytype86 (yyvs.item (yyvsp - 2)), yytype59 (yyvs.item (yyvsp - 1)), yytype15 (yyvs.item (yyvsp))) 
			yyval := yyval8
		end

	yy_do_action_68 is
			--|#line 547 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 547")
end

feature_indexes := yytype77 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_69 is
			--|#line 549 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 549")
end

yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_70 is
			--|#line 553 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 553")
end

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (yytype6 (yyvs.item (yyvsp - 1))))
				feature_indexes := yytype77 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_71 is
			--|#line 558 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 558")
end

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (new_unique_as))
				feature_indexes := yytype77 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_72 is
			--|#line 563 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 563")
end

				yyval15 := yytype54 (yyvs.item (yyvsp))
				feature_indexes := yytype77 (yyvs.item (yyvsp - 1))
			
			yyval := yyval15
		end

	yy_do_action_73 is
			--|#line 574 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 574")
end


			yyval := yyval81
		end

	yy_do_action_74 is
			--|#line 576 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 576")
end

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_75 is
			--|#line 578 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 578")
end

yyval81 := new_eiffel_list_parent_as (0) 
			yyval := yyval81
		end

	yy_do_action_76 is
			--|#line 582 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 582")
end

				yyval81 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval81.extend (yytype45 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_77 is
			--|#line 587 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 587")
end

				yyval81 := yytype81 (yyvs.item (yyvsp - 1))
				yyval81.extend (yytype45 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_78 is
			--|#line 594 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 594")
end

				yyval45 := yytype45 (yyvs.item (yyvsp))
				yytype45 (yyvs.item (yyvsp)).set_location (yytype93 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_79 is
			--|#line 599 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 599")
end

				inherit_context := False
				yyval45 := yytype45 (yyvs.item (yyvsp - 1))
				yytype45 (yyvs.item (yyvsp - 1)).set_location (yytype93 (yyvs.item (yyvsp - 2)))
			
			yyval := yyval45
		end

	yy_do_action_80 is
			--|#line 607 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 607")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 1)), yytype85 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval45
		end

	yy_do_action_81 is
			--|#line 612 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 612")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 7)), yytype85 (yyvs.item (yyvsp - 6)), yytype82 (yyvs.item (yyvsp - 5)), yytype67 (yyvs.item (yyvsp - 4)), yytype72 (yyvs.item (yyvsp - 3)), yytype72 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_82 is
			--|#line 617 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 617")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 6)), yytype85 (yyvs.item (yyvsp - 5)), Void, yytype67 (yyvs.item (yyvsp - 4)), yytype72 (yyvs.item (yyvsp - 3)), yytype72 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_83 is
			--|#line 622 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 622")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 5)), yytype85 (yyvs.item (yyvsp - 4)), Void, Void, yytype72 (yyvs.item (yyvsp - 3)), yytype72 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_84 is
			--|#line 627 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 627")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 4)), yytype85 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype72 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_85 is
			--|#line 632 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 632")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 3)), yytype85 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_86 is
			--|#line 637 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 637")
end

				inherit_context := True
				real_class_end_position := current_position.end_position - 3
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 2)), yytype85 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval45
		end

	yy_do_action_87 is
			--|#line 645 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 645")
end


			yyval := yyval82
		end

	yy_do_action_88 is
			--|#line 647 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 647")
end

yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
		end

	yy_do_action_89 is
			--|#line 651 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 651")
end

				yyval82 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval82.extend (yytype49 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_90 is
			--|#line 656 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 656")
end

				yyval82 := yytype82 (yyvs.item (yyvsp - 2))
				yyval82.extend (yytype49 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_91 is
			--|#line 663 "eiffel.y"
		local
			yyval49: RENAME_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 663")
end

yyval49 := new_rename_pair (yytype89 (yyvs.item (yyvsp - 2)), yytype89 (yyvs.item (yyvsp))) 
			yyval := yyval49
		end

	yy_do_action_92 is
			--|#line 667 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 667")
end


			yyval := yyval67
		end

	yy_do_action_93 is
			--|#line 669 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 669")
end

yyval67 := yytype67 (yyvs.item (yyvsp)) 
			yyval := yyval67
		end

	yy_do_action_94 is
			--|#line 673 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 673")
end

				if yytype67 (yyvs.item (yyvsp)).is_empty then
					yyval67 := Void
				else
					yyval67 := yytype67 (yyvs.item (yyvsp))
				end
			
			yyval := yyval67
		end

	yy_do_action_95 is
			--|#line 681 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 681")
end


			yyval := yyval67
		end

	yy_do_action_96 is
			--|#line 685 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 685")
end

				yyval67 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				if yytype23 (yyvs.item (yyvsp)) /= Void then
					yyval67.extend (yytype23 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval67
		end

	yy_do_action_97 is
			--|#line 692 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 692")
end

				yyval67 := yytype67 (yyvs.item (yyvsp - 1))
				if yytype23 (yyvs.item (yyvsp)) /= Void then
					yyval67.extend (yytype23 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval67
		end

	yy_do_action_98 is
			--|#line 701 "eiffel.y"
		local
			yyval23: EXPORT_ITEM_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 701")
end

				if yytype29 (yyvs.item (yyvsp - 1)) /= Void then
					yyval23 := new_export_item_as (new_client_as (yytype74 (yyvs.item (yyvsp - 2))), yytype29 (yyvs.item (yyvsp - 1)))
				end
			
			yyval := yyval23
		end

	yy_do_action_99 is
			--|#line 709 "eiffel.y"
		local
			yyval29: FEATURE_SET_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 709")
end


			yyval := yyval29
		end

	yy_do_action_100 is
			--|#line 711 "eiffel.y"
		local
			yyval29: FEATURE_SET_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 711")
end

yyval29 := new_all_as 
			yyval := yyval29
		end

	yy_do_action_101 is
			--|#line 713 "eiffel.y"
		local
			yyval29: FEATURE_SET_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 713")
end

yyval29 := new_feature_list_as (yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval29
		end

	yy_do_action_102 is
			--|#line 717 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 717")
end


			yyval := yyval64
		end

	yy_do_action_103 is
			--|#line 719 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 719")
end

			yyval64 := yytype64 (yyvs.item (yyvsp))
		
			yyval := yyval64
		end

	yy_do_action_104 is
			--|#line 725 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 725")
end

			yyval64 := new_eiffel_list_convert (Initial_convert_list_size)
			yyval64.extend (yytype16 (yyvs.item (yyvsp)))
		
			yyval := yyval64
		end

	yy_do_action_105 is
			--|#line 730 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 730")
end

			yyval64 := yytype64 (yyvs.item (yyvsp - 2))
			yyval64.extend (yytype16 (yyvs.item (yyvsp)))
		
			yyval := yyval64
		end

	yy_do_action_106 is
			--|#line 738 "eiffel.y"
		local
			yyval16: CONVERT_FEAT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 738")
end

				-- True because this is a conversion feature used as a creation
				-- procedure in current class.
			yyval16 := new_convert_feat_as (True, yytype89 (yyvs.item (yyvsp - 5)).first, yytype85 (yyvs.item (yyvsp - 2)))
		
			yyval := yyval16
		end

	yy_do_action_107 is
			--|#line 744 "eiffel.y"
		local
			yyval16: CONVERT_FEAT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 744")
end

				-- False because this is not a conversion feature used as a creation
				-- procedure.
			yyval16 := new_convert_feat_as (False, yytype89 (yyvs.item (yyvsp - 4)).first, yytype85 (yyvs.item (yyvsp - 1)))
		
			yyval := yyval16
		end

	yy_do_action_108 is
			--|#line 752 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 752")
end

				yyval72 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval72.extend (yytype89 (yyvs.item (yyvsp)).first)
			
			yyval := yyval72
		end

	yy_do_action_109 is
			--|#line 757 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 757")
end

				yyval72 := yytype72 (yyvs.item (yyvsp - 2))
				yyval72.extend (yytype89 (yyvs.item (yyvsp)).first)
			
			yyval := yyval72
		end

	yy_do_action_110 is
			--|#line 764 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 764")
end


			yyval := yyval72
		end

	yy_do_action_111 is
			--|#line 766 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 766")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_112 is
			--|#line 770 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 770")
end


			yyval := yyval72
		end

	yy_do_action_113 is
			--|#line 772 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 772")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_114 is
			--|#line 776 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 776")
end


			yyval := yyval72
		end

	yy_do_action_115 is
			--|#line 778 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 778")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_116 is
			--|#line 782 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 782")
end


			yyval := yyval72
		end

	yy_do_action_117 is
			--|#line 784 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 784")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_118 is
			--|#line 788 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 788")
end


			yyval := yyval72
		end

	yy_do_action_119 is
			--|#line 790 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 790")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_120 is
			--|#line 794 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 794")
end


			yyval := yyval72
		end

	yy_do_action_121 is
			--|#line 796 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 796")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_122 is
			--|#line 804 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 804")
end


			yyval := yyval86
		end

	yy_do_action_123 is
			--|#line 806 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 806")
end

yyval86 := yytype86 (yyvs.item (yyvsp - 1)) 
			yyval := yyval86
		end

	yy_do_action_124 is
			--|#line 810 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 810")
end


			yyval := yyval86
		end

	yy_do_action_125 is
			--|#line 812 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 812")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_126 is
			--|#line 816 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 816")
end

				yyval86 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval86.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval86
		end

	yy_do_action_127 is
			--|#line 821 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 821")
end

				yyval86 := yytype86 (yyvs.item (yyvsp - 1))
				yyval86.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval86
		end

	yy_do_action_128 is
			--|#line 828 "eiffel.y"
		local
			yyval60: TYPE_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 828")
end

yyval60 := new_type_dec_as (yytype76 (yyvs.item (yyvsp - 5)), yytype59 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 4))) 
			yyval := yyval60
		end

	yy_do_action_129 is
			--|#line 832 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 832")
end
			yyval := yyval_default;


		end

	yy_do_action_130 is
			--|#line 833 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 833")
end
			yyval := yyval_default;
				if il_parser then
						-- Trigger a syntax error.
					raise_error
				end
			

		end

	yy_do_action_131 is
			--|#line 842 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 842")
end


			yyval := yyval86
		end

	yy_do_action_132 is
			--|#line 844 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 844")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_133 is
			--|#line 848 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 848")
end

				yyval86 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval86.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval86
		end

	yy_do_action_134 is
			--|#line 853 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 853")
end

				yyval86 := yytype86 (yyvs.item (yyvsp - 1))
				yyval86.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval86
		end

	yy_do_action_135 is
			--|#line 860 "eiffel.y"
		local
			yyval60: TYPE_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 860")
end

yyval60 := new_type_dec_as (yytype76 (yyvs.item (yyvsp - 4)), yytype59 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval60
		end

	yy_do_action_136 is
			--|#line 864 "eiffel.y"
		local
			yyval76: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 864")
end

				create yyval76.make (Initial_identifier_list_size)
				Names_heap.put (yytype31 (yyvs.item (yyvsp)))
				yyval76.extend (Names_heap.found_item)
			
			yyval := yyval76
		end

	yy_do_action_137 is
			--|#line 870 "eiffel.y"
		local
			yyval76: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 870")
end

				yyval76 := yytype76 (yyvs.item (yyvsp - 2))
				Names_heap.put (yytype31 (yyvs.item (yyvsp)))
				yyval76.extend (Names_heap.found_item)
			
			yyval := yyval76
		end

	yy_do_action_138 is
			--|#line 878 "eiffel.y"
		local
			yyval76: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 878")
end

create yyval76.make (0) 
			yyval := yyval76
		end

	yy_do_action_139 is
			--|#line 880 "eiffel.y"
		local
			yyval76: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 880")
end

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_140 is
			--|#line 884 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 884")
end


			yyval := yyval59
		end

	yy_do_action_141 is
			--|#line 886 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 886")
end

yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
		end

	yy_do_action_142 is
			--|#line 890 "eiffel.y"
		local
			yyval54: ROUTINE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 890")
end

yyval54 := new_routine_as (yytype56 (yyvs.item (yyvsp - 7)), yytype50 (yyvs.item (yyvsp - 5)), yytype86 (yyvs.item (yyvsp - 4)), yytype53 (yyvs.item (yyvsp - 3)), yytype22 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp - 1)), fbody_pos, current_position) 
			yyval := yyval54
		end

	yy_do_action_143 is
			--|#line 890 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 890")
end
			yyval := yyval_default;
fbody_pos := current_position.start_position 

		end

	yy_do_action_144 is
			--|#line 902 "eiffel.y"
		local
			yyval53: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 902")
end

yyval53 := yytype38 (yyvs.item (yyvsp)) 
			yyval := yyval53
		end

	yy_do_action_145 is
			--|#line 904 "eiffel.y"
		local
			yyval53: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 904")
end

yyval53 := yytype25 (yyvs.item (yyvsp)) 
			yyval := yyval53
		end

	yy_do_action_146 is
			--|#line 906 "eiffel.y"
		local
			yyval53: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 906")
end

yyval53 := new_deferred_as 
			yyval := yyval53
		end

	yy_do_action_147 is
			--|#line 910 "eiffel.y"
		local
			yyval25: EXTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 910")
end

				yyval25 := new_external_as (yytype26 (yyvs.item (yyvsp - 1)), yytype56 (yyvs.item (yyvsp)))
				has_externals := True
			
			yyval := yyval25
		end

	yy_do_action_148 is
			--|#line 917 "eiffel.y"
		local
			yyval26: EXTERNAL_LANG_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 917")
end

yyval26 := new_external_lang_as (yytype56 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval26
		end

	yy_do_action_149 is
			--|#line 922 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 922")
end


			yyval := yyval56
		end

	yy_do_action_150 is
			--|#line 924 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 924")
end

yyval56 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval56
		end

	yy_do_action_151 is
			--|#line 928 "eiffel.y"
		local
			yyval38: INTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 928")
end

yyval38 := new_do_as (yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_152 is
			--|#line 930 "eiffel.y"
		local
			yyval38: INTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 930")
end

yyval38 := new_once_as (yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_153 is
			--|#line 934 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 934")
end


			yyval := yyval86
		end

	yy_do_action_154 is
			--|#line 936 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 936")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_155 is
			--|#line 940 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 940")
end


			yyval := yyval78
		end

	yy_do_action_156 is
			--|#line 942 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 942")
end

yyval78 := yytype78 (yyvs.item (yyvsp)) 
			yyval := yyval78
		end

	yy_do_action_157 is
			--|#line 946 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 946")
end

				yyval78 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval78.extend (yytype36 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_158 is
			--|#line 951 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 951")
end

				yyval78 := yytype78 (yyvs.item (yyvsp - 1))
				yyval78.extend (yytype36 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_159 is
			--|#line 958 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 958")
end

yyval36 := yytype36 (yyvs.item (yyvsp - 1)) 
			yyval := yyval36
		end

	yy_do_action_160 is
			--|#line 962 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 962")
end
			yyval := yyval_default;


		end

	yy_do_action_161 is
			--|#line 963 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 963")
end
			yyval := yyval_default;


		end

	yy_do_action_162 is
			--|#line 966 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 966")
end

yyval36 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_163 is
			--|#line 968 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 968")
end

yyval36 := yytype35 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_164 is
			--|#line 970 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 970")
end

yyval36 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_165 is
			--|#line 972 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 972")
end

yyval36 := yytype52 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_166 is
			--|#line 974 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 974")
end

yyval36 := yytype32 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_167 is
			--|#line 976 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 976")
end

yyval36 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_168 is
			--|#line 978 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 978")
end

yyval36 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_169 is
			--|#line 980 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 980")
end

yyval36 := yytype20 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_170 is
			--|#line 982 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 982")
end

yyval36 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_171 is
			--|#line 984 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 984")
end

yyval36 := yytype51 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_172 is
			--|#line 988 "eiffel.y"
		local
			yyval50: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 988")
end


			yyval := yyval50
		end

	yy_do_action_173 is
			--|#line 990 "eiffel.y"
		local
			yyval50: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 990")
end

				id_level := Normal_level
				yyval50 := new_require_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval50
		end

	yy_do_action_174 is
			--|#line 990 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 990")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_175 is
			--|#line 997 "eiffel.y"
		local
			yyval50: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 997")
end

				id_level := Normal_level
				yyval50 := new_require_else_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval50
		end

	yy_do_action_176 is
			--|#line 997 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 997")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_177 is
			--|#line 1006 "eiffel.y"
		local
			yyval22: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1006")
end


			yyval := yyval22
		end

	yy_do_action_178 is
			--|#line 1008 "eiffel.y"
		local
			yyval22: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1008")
end

				id_level := Normal_level
				yyval22 := new_ensure_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_179 is
			--|#line 1008 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1008")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_180 is
			--|#line 1015 "eiffel.y"
		local
			yyval22: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1015")
end

				id_level := Normal_level
				yyval22 := new_ensure_then_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_181 is
			--|#line 1015 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1015")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_182 is
			--|#line 1024 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1024")
end


			yyval := yyval84
		end

	yy_do_action_183 is
			--|#line 1026 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1026")
end

				yyval84 := yytype84 (yyvs.item (yyvsp))
				if yyval84.is_empty then
					yyval84 := Void
				end
			
			yyval := yyval84
		end

	yy_do_action_184 is
			--|#line 1035 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1035")
end

				yyval84 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval84, yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_185 is
			--|#line 1040 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1040")
end

				yyval84 := yytype84 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval84, yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_186 is
			--|#line 1047 "eiffel.y"
		local
			yyval57: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1047")
end

yyval57 := yytype57 (yyvs.item (yyvsp - 1)) 
			yyval := yyval57
		end

	yy_do_action_187 is
			--|#line 1051 "eiffel.y"
		local
			yyval57: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1051")
end

yyval57 := new_tagged_as (Void, yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval57
		end

	yy_do_action_188 is
			--|#line 1053 "eiffel.y"
		local
			yyval57: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1053")
end

yyval57 := new_tagged_as (yytype31 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval57
		end

	yy_do_action_189 is
			--|#line 1055 "eiffel.y"
		local
			yyval57: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1055")
end


			yyval := yyval57
		end

	yy_do_action_190 is
			--|#line 1063 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1063")
end

yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
		end

	yy_do_action_191 is
			--|#line 1065 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1065")
end

yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
		end

	yy_do_action_192 is
			--|#line 1069 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1069")
end

yyval59 := new_expanded_type (yytype88 (yyvs.item (yyvsp - 1)), yytype85 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_193 is
			--|#line 1071 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1071")
end

yyval59 := new_separate_type (yytype88 (yyvs.item (yyvsp - 1)), yytype85 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_194 is
			--|#line 1073 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1073")
end

yyval59 := new_bits_as (yytype37 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_195 is
			--|#line 1075 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1075")
end

yyval59 := new_bits_symbol_as (yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_196 is
			--|#line 1077 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1077")
end

yyval59 := new_like_id_as (yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_197 is
			--|#line 1079 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1079")
end

yyval59 := new_like_current_as 
			yyval := yyval59
		end

	yy_do_action_198 is
			--|#line 1083 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1083")
end

yyval59 := new_class_type (yytype88 (yyvs.item (yyvsp - 1)), yytype85 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_199 is
			--|#line 1087 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1087")
end


			yyval := yyval85
		end

	yy_do_action_200 is
			--|#line 1089 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1089")
end


			yyval := yyval85
		end

	yy_do_action_201 is
			--|#line 1091 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1091")
end

yyval85 := yytype85 (yyvs.item (yyvsp - 1)) 
			yyval := yyval85
		end

	yy_do_action_202 is
			--|#line 1095 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1095")
end


			yyval := yyval85
		end

	yy_do_action_203 is
			--|#line 1097 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1097")
end

yyval85 := yytype85 (yyvs.item (yyvsp - 1)) 
			yyval := yyval85
		end

	yy_do_action_204 is
			--|#line 1101 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1101")
end

				yyval85 := new_eiffel_list_type (Initial_type_list_size)
				yyval85.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval85
		end

	yy_do_action_205 is
			--|#line 1106 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1106")
end

				yyval85 := yytype85 (yyvs.item (yyvsp - 2))
				yyval85.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval85
		end

	yy_do_action_206 is
			--|#line 1117 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1117")
end

				-- $$ := Void
				formal_generics_start_position := current_position.start_position
				formal_generics_end_position := 0
			
			yyval := yyval73
		end

	yy_do_action_207 is
			--|#line 1123 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1123")
end

				yyval73 := yytype73 (yyvs.item (yyvsp - 1))
				formal_generics_start_position := yytype93 (yyvs.item (yyvsp - 3)).start_position
				formal_generics_end_position := current_position.start_position
			
			yyval := yyval73
		end

	yy_do_action_208 is
			--|#line 1131 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1131")
end


			yyval := yyval73
		end

	yy_do_action_209 is
			--|#line 1133 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1133")
end

yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
		end

	yy_do_action_210 is
			--|#line 1137 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1137")
end

				yyval73 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval73.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval73
		end

	yy_do_action_211 is
			--|#line 1142 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1142")
end

				yyval73 := yytype73 (yyvs.item (yyvsp - 2))
				yyval73.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval73
		end

	yy_do_action_212 is
			--|#line 1149 "eiffel.y"
		local
			yyval30: FORMAL_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1149")
end

				check formal_exists: not formal_parameters.is_empty end
				yyval30 := new_formal_dec_as (formal_parameters.last, yytype92 (yyvs.item (yyvsp)).first, yytype92 (yyvs.item (yyvsp)).second, formal_parameters.count)
			
			yyval := yyval30
		end

	yy_do_action_213 is
			--|#line 1149 "eiffel.y"
		local

		do
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
			

		end

	yy_do_action_214 is
			--|#line 1171 "eiffel.y"
		local
			yyval92: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1171")
end

create yyval92 
			yyval := yyval92
		end

	yy_do_action_215 is
			--|#line 1173 "eiffel.y"
		local
			yyval92: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1173")
end

				create yyval92
				yyval92.set_first (yytype59 (yyvs.item (yyvsp - 1)))
				yyval92.set_second (yytype72 (yyvs.item (yyvsp)))
			
			yyval := yyval92
		end

	yy_do_action_216 is
			--|#line 1181 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1181")
end


			yyval := yyval72
		end

	yy_do_action_217 is
			--|#line 1183 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1183")
end

yyval72 := yytype72 (yyvs.item (yyvsp - 1)) 
			yyval := yyval72
		end

	yy_do_action_218 is
			--|#line 1191 "eiffel.y"
		local
			yyval32: IF_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1191")
end

				yyval32 := new_if_as (yytype24 (yyvs.item (yyvsp - 5)), yytype78 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 7)), current_position)
			
			yyval := yyval32
		end

	yy_do_action_219 is
			--|#line 1197 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1197")
end


			yyval := yyval66
		end

	yy_do_action_220 is
			--|#line 1199 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1199")
end

yyval66 := yytype66 (yyvs.item (yyvsp)) 
			yyval := yyval66
		end

	yy_do_action_221 is
			--|#line 1203 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1203")
end

				yyval66 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval66.extend (yytype21 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_222 is
			--|#line 1208 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1208")
end

				yyval66 := yytype66 (yyvs.item (yyvsp - 1))
				yyval66.extend (yytype21 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_223 is
			--|#line 1215 "eiffel.y"
		local
			yyval21: ELSIF_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1215")
end

yyval21 := new_elseif_as (yytype24 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 4))) 
			yyval := yyval21
		end

	yy_do_action_224 is
			--|#line 1219 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1219")
end


			yyval := yyval78
		end

	yy_do_action_225 is
			--|#line 1221 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1221")
end

yyval78 := yytype78 (yyvs.item (yyvsp)) 
			yyval := yyval78
		end

	yy_do_action_226 is
			--|#line 1225 "eiffel.y"
		local
			yyval34: INSPECT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1225")
end

				yyval34 := new_inspect_as (yytype24 (yyvs.item (yyvsp - 3)), yytype63 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval34
		end

	yy_do_action_227 is
			--|#line 1231 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1231")
end


			yyval := yyval63
		end

	yy_do_action_228 is
			--|#line 1233 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1233")
end

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_229 is
			--|#line 1237 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1237")
end

				yyval63 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval63.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_230 is
			--|#line 1242 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1242")
end

				yyval63 := yytype63 (yyvs.item (yyvsp - 1))
				yyval63.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_231 is
			--|#line 1249 "eiffel.y"
		local
			yyval11: CASE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1249")
end

yyval11 := new_case_as (yytype79 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval11
		end

	yy_do_action_232 is
			--|#line 1253 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INTERVAL_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1253")
end

				yyval79 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval79.extend (yytype39 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_233 is
			--|#line 1258 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INTERVAL_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1258")
end

				yyval79 := yytype79 (yyvs.item (yyvsp - 2))
				yyval79.extend (yytype39 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_234 is
			--|#line 1265 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1265")
end

yyval39 := new_interval_as (yytype37 (yyvs.item (yyvsp)), Void) 
			yyval := yyval39
		end

	yy_do_action_235 is
			--|#line 1267 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1267")
end

yyval39 := new_interval_as (yytype37 (yyvs.item (yyvsp - 2)), yytype37 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_236 is
			--|#line 1269 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1269")
end

yyval39 := new_interval_as (yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval39
		end

	yy_do_action_237 is
			--|#line 1271 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1271")
end

yyval39 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_238 is
			--|#line 1273 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1273")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp)), Void) 
			yyval := yyval39
		end

	yy_do_action_239 is
			--|#line 1275 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1275")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_240 is
			--|#line 1277 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1277")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp - 2)), yytype37 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_241 is
			--|#line 1279 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1279")
end

yyval39 := new_interval_as (yytype37 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_242 is
			--|#line 1281 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1281")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_243 is
			--|#line 1283 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1283")
end

yyval39 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_244 is
			--|#line 1285 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1285")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp)), Void) 
			yyval := yyval39
		end

	yy_do_action_245 is
			--|#line 1287 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1287")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_246 is
			--|#line 1289 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1289")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp - 2)), yytype47 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_247 is
			--|#line 1291 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1291")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp - 2)), yytype47 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_248 is
			--|#line 1293 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1293")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp - 2)), yytype37 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_249 is
			--|#line 1295 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1295")
end

yyval39 := new_interval_as (yytype37 (yyvs.item (yyvsp - 2)), yytype47 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_250 is
			--|#line 1297 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1297")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_251 is
			--|#line 1299 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1299")
end

yyval39 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype47 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_252 is
			--|#line 1304 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1304")
end


			yyval := yyval78
		end

	yy_do_action_253 is
			--|#line 1306 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1306")
end

				yyval78 := yytype78 (yyvs.item (yyvsp))
				if yyval78 = Void then
					yyval78 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval78
		end

	yy_do_action_254 is
			--|#line 1315 "eiffel.y"
		local
			yyval41: LOOP_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1315")
end

				yyval41 := new_loop_as (yytype78 (yyvs.item (yyvsp - 8)), yytype84 (yyvs.item (yyvsp - 7)), yytype61 (yyvs.item (yyvsp - 6)), yytype24 (yyvs.item (yyvsp - 3)), yytype78 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval41
		end

	yy_do_action_255 is
			--|#line 1321 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1321")
end


			yyval := yyval84
		end

	yy_do_action_256 is
			--|#line 1323 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1323")
end

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_257 is
			--|#line 1327 "eiffel.y"
		local
			yyval40: INVARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1327")
end


			yyval := yyval40
		end

	yy_do_action_258 is
			--|#line 1329 "eiffel.y"
		local
			yyval40: INVARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1329")
end

				id_level := Normal_level
				inherit_context := False
				yyval40 := new_invariant_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval40
		end

	yy_do_action_259 is
			--|#line 1329 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1329")
end
			yyval := yyval_default;
id_level := Invariant_level 

		end

	yy_do_action_260 is
			--|#line 1339 "eiffel.y"
		local
			yyval61: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1339")
end


			yyval := yyval61
		end

	yy_do_action_261 is
			--|#line 1341 "eiffel.y"
		local
			yyval61: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1341")
end

yyval61 := new_variant_as (yytype31 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval61
		end

	yy_do_action_262 is
			--|#line 1343 "eiffel.y"
		local
			yyval61: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1343")
end

yyval61 := new_variant_as (Void, yytype24 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval61
		end

	yy_do_action_263 is
			--|#line 1347 "eiffel.y"
		local
			yyval20: DEBUG_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1347")
end

				yyval20 := new_debug_as (yytype83 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval20
		end

	yy_do_action_264 is
			--|#line 1353 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1353")
end


			yyval := yyval83
		end

	yy_do_action_265 is
			--|#line 1355 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1355")
end


			yyval := yyval83
		end

	yy_do_action_266 is
			--|#line 1357 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1357")
end

yyval83 := yytype83 (yyvs.item (yyvsp - 1)) 
			yyval := yyval83
		end

	yy_do_action_267 is
			--|#line 1361 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1361")
end

				yyval83 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval83.extend (yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_268 is
			--|#line 1366 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1366")
end

				yyval83 := yytype83 (yyvs.item (yyvsp - 2))
				yyval83.extend (yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_269 is
			--|#line 1373 "eiffel.y"
		local
			yyval51: RETRY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1373")
end

yyval51 := new_retry_as (current_position) 
			yyval := yyval51
		end

	yy_do_action_270 is
			--|#line 1377 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1377")
end


			yyval := yyval78
		end

	yy_do_action_271 is
			--|#line 1379 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1379")
end

				yyval78 := yytype78 (yyvs.item (yyvsp))
				if yyval78 = Void then
					yyval78 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval78
		end

	yy_do_action_272 is
			--|#line 1388 "eiffel.y"
		local
			yyval5: ASSIGN_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1388")
end

yyval5 := new_assign_as (new_access_id_as (yytype31 (yyvs.item (yyvsp - 2)), Void), yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_273 is
			--|#line 1390 "eiffel.y"
		local
			yyval5: ASSIGN_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1390")
end

yyval5 := new_assign_as (new_result_as, yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_274 is
			--|#line 1394 "eiffel.y"
		local
			yyval52: REVERSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1394")
end

yyval52 := new_reverse_as (new_access_id_as (yytype31 (yyvs.item (yyvsp - 2)), Void), yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval52
		end

	yy_do_action_275 is
			--|#line 1396 "eiffel.y"
		local
			yyval52: REVERSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1396")
end

yyval52 := new_reverse_as (new_result_as, yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval52
		end

	yy_do_action_276 is
			--|#line 1400 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1400")
end


			yyval := yyval65
		end

	yy_do_action_277 is
			--|#line 1402 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1402")
end

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_278 is
			--|#line 1406 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1406")
end

				yyval65 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval65.extend (yytype17 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_279 is
			--|#line 1411 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1411")
end

				yyval65 := yytype65 (yyvs.item (yyvsp - 1))
				yyval65.extend (yytype17 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_280 is
			--|#line 1418 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1418")
end

				inherit_context := False
				yyval17 := new_create_as (Void, Void)
			
			yyval := yyval17
		end

	yy_do_action_281 is
			--|#line 1424 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1424")
end

				inherit_context := False
				yyval17 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp)))
			
			yyval := yyval17
		end

	yy_do_action_282 is
			--|#line 1429 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1429")
end

				inherit_context := False
				yyval17 := new_create_as (new_client_as (yytype74 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval17
		end

	yy_do_action_283 is
			--|#line 1434 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1434")
end

				inherit_context := False
				yyval17 := new_create_as (Void, Void)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 1)).start_position,
						yytype93 (yyvs.item (yyvsp - 1)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval17
		end

	yy_do_action_284 is
			--|#line 1444 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1444")
end

				inherit_context := False
				yyval17 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 3)).start_position,
						yytype93 (yyvs.item (yyvsp - 3)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval17
		end

	yy_do_action_285 is
			--|#line 1454 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1454")
end

				inherit_context := False
				yyval17 := new_create_as (new_client_as (yytype74 (yyvs.item (yyvsp))), Void)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
						yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval17
		end

	yy_do_action_286 is
			--|#line 1466 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1466")
end

yyval55 := new_routine_creation_as (new_result_operand_as, yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_287 is
			--|#line 1469 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1469")
end

yyval55 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_288 is
			--|#line 1471 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1471")
end

yyval55 := new_routine_creation_as (new_operand_as (Void, yytype31 (yyvs.item (yyvsp - 3)), Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_289 is
			--|#line 1473 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1473")
end

yyval55 := new_routine_creation_as (new_operand_as (Void, Void, yytype24 (yyvs.item (yyvsp - 4))), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_290 is
			--|#line 1475 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1475")
end

yyval55 := new_routine_creation_as (new_operand_as (yytype59 (yyvs.item (yyvsp - 4)), Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_291 is
			--|#line 1477 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1477")
end

yyval55 := new_routine_creation_as (Void, yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_292 is
			--|#line 1479 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1479")
end

yyval55 := new_unqualified_routine_creation_as (new_operand_as (Void, Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_293 is
			--|#line 1481 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1481")
end

			yyval55 := new_routine_creation_as (new_result_operand_as, yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_294 is
			--|#line 1490 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1490")
end

			yyval55 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_295 is
			--|#line 1499 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1499")
end

			yyval55 := new_routine_creation_as (new_operand_as (Void, yytype31 (yyvs.item (yyvsp - 4)), Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
			
		
			yyval := yyval55
		end

	yy_do_action_296 is
			--|#line 1509 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1509")
end

			yyval55 := new_routine_creation_As (new_operand_as (Void, Void, yytype24 (yyvs.item (yyvsp - 5))), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_297 is
			--|#line 1518 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1518")
end

			yyval55 := new_routine_creation_as (new_operand_as (yytype59 (yyvs.item (yyvsp - 4)), Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_298 is
			--|#line 1527 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1527")
end

			yyval55 := new_routine_creation_as (Void, yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_299 is
			--|#line 1536 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1536")
end

			yyval55 := new_unqualified_routine_creation_as (new_operand_as (Void, Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_300 is
			--|#line 1547 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1547")
end


			yyval := yyval80
		end

	yy_do_action_301 is
			--|#line 1549 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1549")
end

yyval80 := yytype80 (yyvs.item (yyvsp - 1)) 
			yyval := yyval80
		end

	yy_do_action_302 is
			--|#line 1553 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1553")
end

				yyval80 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval80.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_303 is
			--|#line 1558 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1558")
end

				yyval80 := yytype80 (yyvs.item (yyvsp - 2))
				yyval80.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_304 is
			--|#line 1565 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1565")
end

yyval44 := new_operand_as (Void, Void, Void) 
			yyval := yyval44
		end

	yy_do_action_305 is
			--|#line 1571 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1571")
end

yyval44 := new_operand_as (new_class_type (yytype88 (yyvs.item (yyvsp - 1)), Void), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_306 is
			--|#line 1573 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1573")
end

yyval44 := new_operand_as (new_class_type (yytype88 (yyvs.item (yyvsp - 2)), yytype85 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_307 is
			--|#line 1575 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1575")
end

yyval44 := new_operand_as (new_expanded_type (yytype88 (yyvs.item (yyvsp - 2)), yytype85 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_308 is
			--|#line 1577 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1577")
end

yyval44 := new_operand_as (new_separate_type (yytype88 (yyvs.item (yyvsp - 2)), yytype85 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_309 is
			--|#line 1579 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1579")
end

yyval44 := new_operand_as (new_bits_as (yytype37 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_310 is
			--|#line 1581 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1581")
end

yyval44 := new_operand_as (new_bits_symbol_as (yytype31 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_311 is
			--|#line 1583 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1583")
end

yyval44 := new_operand_as (new_like_id_as (yytype31 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_312 is
			--|#line 1585 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1585")
end

yyval44 := new_operand_as (new_like_current_as, Void, Void) 
			yyval := yyval44
		end

	yy_do_action_313 is
			--|#line 1587 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1587")
end

yyval44 := new_operand_as (Void, Void, yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval44
		end

	yy_do_action_314 is
			--|#line 1591 "eiffel.y"
		local
			yyval18: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1591")
end

				yyval18 := new_creation_as (yytype59 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 5)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 5)).start_position,
						yytype93 (yyvs.item (yyvsp - 5)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval18
		end

	yy_do_action_315 is
			--|#line 1600 "eiffel.y"
		local
			yyval18: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1600")
end

yyval18 := new_creation_as (Void, yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval18
		end

	yy_do_action_316 is
			--|#line 1602 "eiffel.y"
		local
			yyval18: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1602")
end

yyval18 := new_creation_as (yytype59 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 6))) 
			yyval := yyval18
		end

	yy_do_action_317 is
			--|#line 1606 "eiffel.y"
		local
			yyval19: CREATION_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1606")
end

yyval19 := new_creation_expr_as (yytype59 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval19
		end

	yy_do_action_318 is
			--|#line 1608 "eiffel.y"
		local
			yyval19: CREATION_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1608")
end

				yyval19 := new_creation_expr_as (yytype59 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 1)).start_position,
						yytype93 (yyvs.item (yyvsp - 1)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval19
		end

	yy_do_action_319 is
			--|#line 1619 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1619")
end


			yyval := yyval59
		end

	yy_do_action_320 is
			--|#line 1621 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1621")
end

yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
		end

	yy_do_action_321 is
			--|#line 1625 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1625")
end

yyval1 := new_access_id_as (yytype31 (yyvs.item (yyvsp)), Void) 
			yyval := yyval1
		end

	yy_do_action_322 is
			--|#line 1627 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1627")
end

yyval1 := new_result_as 
			yyval := yyval1
		end

	yy_do_action_323 is
			--|#line 1631 "eiffel.y"
		local
			yyval3: ACCESS_INV_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1631")
end


			yyval := yyval3
		end

	yy_do_action_324 is
			--|#line 1633 "eiffel.y"
		local
			yyval3: ACCESS_INV_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1633")
end

yyval3 := new_access_inv_as (yytype31 (yyvs.item (yyvsp - 1)), yytype68 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_325 is
			--|#line 1641 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1641")
end

yyval35 := new_instr_call_as (yytype1 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_326 is
			--|#line 1643 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1643")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_327 is
			--|#line 1645 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1645")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_328 is
			--|#line 1647 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1647")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_329 is
			--|#line 1649 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1649")
end

yyval35 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_330 is
			--|#line 1651 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1651")
end

yyval35 := new_instr_call_as (yytype46 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_331 is
			--|#line 1653 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1653")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_332 is
			--|#line 1655 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1655")
end

yyval35 := new_instr_call_as (yytype47 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_333 is
			--|#line 1657 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1657")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_334 is
			--|#line 1661 "eiffel.y"
		local
			yyval13: CHECK_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1661")
end

yyval13 := new_check_as (yytype84 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 3)), current_position) 
			yyval := yyval13
		end

	yy_do_action_335 is
			--|#line 1669 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1669")
end

create {VALUE_AS} yyval24.initialize (yytype6 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_336 is
			--|#line 1671 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1671")
end

create {VALUE_AS} yyval24.initialize (yytype4 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_337 is
			--|#line 1673 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1673")
end

create {VALUE_AS} yyval24.initialize (yytype58 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_338 is
			--|#line 1675 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1675")
end

yyval24 := new_expr_call_as (yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_339 is
			--|#line 1677 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1677")
end

yyval24 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval24
		end

	yy_do_action_340 is
			--|#line 1679 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1679")
end

yyval24 := new_paran_as (yytype24 (yyvs.item (yyvsp - 1))) 
			yyval := yyval24
		end

	yy_do_action_341 is
			--|#line 1681 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1681")
end

yyval24 := new_bin_plus_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_342 is
			--|#line 1683 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1683")
end

yyval24 := new_bin_minus_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_343 is
			--|#line 1685 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1685")
end

yyval24 := new_bin_star_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_344 is
			--|#line 1687 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1687")
end

yyval24 := new_bin_slash_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_345 is
			--|#line 1689 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1689")
end

yyval24 := new_bin_mod_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_346 is
			--|#line 1691 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1691")
end

yyval24 := new_bin_div_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_347 is
			--|#line 1693 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1693")
end

yyval24 := new_bin_power_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_348 is
			--|#line 1695 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1695")
end

yyval24 := new_bin_and_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_349 is
			--|#line 1697 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1697")
end

yyval24 := new_bin_and_then_as (yytype24 (yyvs.item (yyvsp - 3)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_350 is
			--|#line 1699 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1699")
end

yyval24 := new_bin_or_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_351 is
			--|#line 1701 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1701")
end

yyval24 := new_bin_or_else_as (yytype24 (yyvs.item (yyvsp - 3)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_352 is
			--|#line 1703 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1703")
end

yyval24 := new_bin_implies_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_353 is
			--|#line 1705 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1705")
end

yyval24 := new_bin_xor_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_354 is
			--|#line 1707 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1707")
end

yyval24 := new_bin_ge_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_355 is
			--|#line 1709 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1709")
end

yyval24 := new_bin_gt_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_356 is
			--|#line 1711 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1711")
end

yyval24 := new_bin_le_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_357 is
			--|#line 1713 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1713")
end

yyval24 := new_bin_lt_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_358 is
			--|#line 1715 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1715")
end

yyval24 := new_bin_eq_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_359 is
			--|#line 1717 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1717")
end

yyval24 := new_bin_ne_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_360 is
			--|#line 1719 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1719")
end

yyval24 := new_bin_free_as (yytype24 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp - 1)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_361 is
			--|#line 1721 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1721")
end

yyval24 := new_un_minus_as (yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_362 is
			--|#line 1723 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1723")
end

yyval24 := new_un_plus_as (yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_363 is
			--|#line 1725 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1725")
end

yyval24 := new_un_not_as (yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_364 is
			--|#line 1727 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1727")
end

yyval24 := new_un_old_as (yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_365 is
			--|#line 1729 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1729")
end

yyval24 := new_un_free_as (yytype31 (yyvs.item (yyvsp - 1)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_366 is
			--|#line 1731 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1731")
end

yyval24 := new_un_strip_as (yytype76 (yyvs.item (yyvsp - 1))) 
			yyval := yyval24
		end

	yy_do_action_367 is
			--|#line 1733 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1733")
end

yyval24 := new_address_as (yytype89 (yyvs.item (yyvsp)).first) 
			yyval := yyval24
		end

	yy_do_action_368 is
			--|#line 1735 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1735")
end

yyval24 := new_expr_address_as (yytype24 (yyvs.item (yyvsp - 1))) 
			yyval := yyval24
		end

	yy_do_action_369 is
			--|#line 1737 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1737")
end

yyval24 := new_address_current_as 
			yyval := yyval24
		end

	yy_do_action_370 is
			--|#line 1739 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1739")
end

yyval24 := new_address_result_as 
			yyval := yyval24
		end

	yy_do_action_371 is
			--|#line 1743 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1743")
end

create yyval31.initialize (token_buffer) 
			yyval := yyval31
		end

	yy_do_action_372 is
			--|#line 1751 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1751")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_373 is
			--|#line 1753 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1753")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_374 is
			--|#line 1755 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1755")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_375 is
			--|#line 1757 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1757")
end

yyval10 := new_current_as 
			yyval := yyval10
		end

	yy_do_action_376 is
			--|#line 1759 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1759")
end

yyval10 := new_result_as 
			yyval := yyval10
		end

	yy_do_action_377 is
			--|#line 1761 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1761")
end

yyval10 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_378 is
			--|#line 1763 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1763")
end

yyval10 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_379 is
			--|#line 1765 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1765")
end

yyval10 := yytype46 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_380 is
			--|#line 1767 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1767")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_381 is
			--|#line 1769 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1769")
end

yyval10 := yytype47 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_382 is
			--|#line 1771 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1771")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_383 is
			--|#line 1773 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1773")
end

yyval10 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_384 is
			--|#line 1777 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1777")
end

yyval42 := new_nested_as (new_current_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_385 is
			--|#line 1781 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1781")
end

yyval42 := new_nested_as (new_result_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_386 is
			--|#line 1785 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1785")
end

yyval42 := new_nested_as (yytype1 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_387 is
			--|#line 1789 "eiffel.y"
		local
			yyval43: NESTED_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1789")
end

yyval43 := new_nested_expr_as (yytype24 (yyvs.item (yyvsp - 3)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval43
		end

	yy_do_action_388 is
			--|#line 1793 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1793")
end

yyval42 := new_nested_as (yytype46 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_389 is
			--|#line 1797 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1797")
end

yyval46 := new_precursor_as (Void, yytype68 (yyvs.item (yyvsp))) 
			yyval := yyval46
		end

	yy_do_action_390 is
			--|#line 1799 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1799")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 2)), yytype68 (yyvs.item (yyvsp)), Void) 
			yyval := yyval46
		end

	yy_do_action_391 is
			--|#line 1801 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1801")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 5)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_392 is
			--|#line 1803 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1803")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_393 is
			--|#line 1807 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1807")
end

yyval42 := new_nested_as (yytype47 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_394 is
			--|#line 1811 "eiffel.y"
		local
			yyval47: STATIC_ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1811")
end

				yyval47 := new_static_access_as (yytype59 (yyvs.item (yyvsp - 4)), yytype31 (yyvs.item (yyvsp - 1)), yytype68 (yyvs.item (yyvsp)));
			
			yyval := yyval47
		end

	yy_do_action_395 is
			--|#line 1818 "eiffel.y"
		local
			yyval47: STATIC_ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1818")
end

				yyval47 := new_static_access_as (yytype59 (yyvs.item (yyvsp - 3)), yytype31 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval47
		end

	yy_do_action_396 is
			--|#line 1826 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1826")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_397 is
			--|#line 1828 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1828")
end

yyval10 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_398 is
			--|#line 1832 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1832")
end

yyval42 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_399 is
			--|#line 1834 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1834")
end

yyval42 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype42 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_400 is
			--|#line 1838 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1838")
end

				inspect id_level
				when Normal_level then
					yyval1 := new_access_id_as (yytype31 (yyvs.item (yyvsp - 1)), yytype68 (yyvs.item (yyvsp)))
				when Assert_level then
					yyval1 := new_access_assert_as (yytype31 (yyvs.item (yyvsp - 1)), yytype68 (yyvs.item (yyvsp)))
				when Invariant_level then
					yyval1 := new_access_inv_as (yytype31 (yyvs.item (yyvsp - 1)), yytype68 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval1
		end

	yy_do_action_401 is
			--|#line 1851 "eiffel.y"
		local
			yyval2: ACCESS_FEAT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1851")
end

yyval2 := new_access_feat_as (yytype31 (yyvs.item (yyvsp - 1)), yytype68 (yyvs.item (yyvsp))) 
			yyval := yyval2
		end

	yy_do_action_402 is
			--|#line 1855 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1855")
end


			yyval := yyval68
		end

	yy_do_action_403 is
			--|#line 1857 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1857")
end


			yyval := yyval68
		end

	yy_do_action_404 is
			--|#line 1859 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1859")
end

yyval68 := yytype68 (yyvs.item (yyvsp - 1)) 
			yyval := yyval68
		end

	yy_do_action_405 is
			--|#line 1863 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1863")
end

				yyval68 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval68.extend (yytype24 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_406 is
			--|#line 1868 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1868")
end

				yyval68 := yytype68 (yyvs.item (yyvsp - 2))
				yyval68.extend (yytype24 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_407 is
			--|#line 1875 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1875")
end

yyval68 := new_eiffel_list_expr_as (0) 
			yyval := yyval68
		end

	yy_do_action_408 is
			--|#line 1877 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1877")
end

yyval68 := yytype68 (yyvs.item (yyvsp)) 
			yyval := yyval68
		end

	yy_do_action_409 is
			--|#line 1881 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1881")
end

				yyval68 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval68.extend (yytype24 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_410 is
			--|#line 1886 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1886")
end

				yyval68 := yytype68 (yyvs.item (yyvsp - 2))
				yyval68.extend (yytype24 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_411 is
			--|#line 1897 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1897")
end

create yyval31.initialize (token_buffer) 
			yyval := yyval31
		end

	yy_do_action_412 is
			--|#line 1901 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1901")
end

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_413 is
			--|#line 1903 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1903")
end

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_414 is
			--|#line 1905 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1905")
end

yyval6 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_415 is
			--|#line 1907 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1907")
end

yyval6 := yytype48 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_416 is
			--|#line 1909 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1909")
end

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_417 is
			--|#line 1911 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1911")
end

yyval6 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_418 is
			--|#line 1915 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1915")
end

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_419 is
			--|#line 1917 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1917")
end

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_420 is
			--|#line 1919 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1919")
end

				if token_buffer.is_integer then
					yyval6 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval6 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval6 := new_integer_as (False, "0")
				end
			
			yyval := yyval6
		end

	yy_do_action_421 is
			--|#line 1934 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1934")
end

yyval6 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval6
		end

	yy_do_action_422 is
			--|#line 1936 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1936")
end

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_423 is
			--|#line 1938 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1938")
end

yyval6 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_424 is
			--|#line 1942 "eiffel.y"
		local
			yyval9: BOOL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1942")
end

yyval9 := new_boolean_as (False) 
			yyval := yyval9
		end

	yy_do_action_425 is
			--|#line 1944 "eiffel.y"
		local
			yyval9: BOOL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1944")
end

yyval9 := new_boolean_as (True) 
			yyval := yyval9
		end

	yy_do_action_426 is
			--|#line 1948 "eiffel.y"
		local
			yyval12: CHAR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1948")
end

				check is_character: not token_buffer.is_empty end
				yyval12 := new_character_as (token_buffer.item (1))
			
			yyval := yyval12
		end

	yy_do_action_427 is
			--|#line 1955 "eiffel.y"
		local
			yyval37: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1955")
end

				if token_buffer.is_integer then
					yyval37 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval37 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval37 := new_integer_as (False, "0")
				end
			
			yyval := yyval37
		end

	yy_do_action_428 is
			--|#line 1970 "eiffel.y"
		local
			yyval37: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1970")
end

				if token_buffer.is_integer then
					yyval37 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval37 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval37 := new_integer_as (False, "0")
				end
			
			yyval := yyval37
		end

	yy_do_action_429 is
			--|#line 1985 "eiffel.y"
		local
			yyval37: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1985")
end

				if token_buffer.is_integer then
					yyval37 := new_integer_as (True, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval37 := new_integer_as_from_hexa (token_buffer)	
				else
					token_buffer.precede ('-')
					report_integer_too_small_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval37 := new_integer_as (False, "0")
				end
			
			yyval := yyval37
		end

	yy_do_action_430 is
			--|#line 2003 "eiffel.y"
		local
			yyval48: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2003")
end

yyval48 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval48
		end

	yy_do_action_431 is
			--|#line 2005 "eiffel.y"
		local
			yyval48: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2005")
end

yyval48 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval48
		end

	yy_do_action_432 is
			--|#line 2007 "eiffel.y"
		local
			yyval48: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2007")
end

				token_buffer.precede ('-')
				yyval48 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval48
		end

	yy_do_action_433 is
			--|#line 2014 "eiffel.y"
		local
			yyval7: BIT_CONST_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2014")
end

yyval7 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval7
		end

	yy_do_action_434 is
			--|#line 2018 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2018")
end

yyval56 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval56
		end

	yy_do_action_435 is
			--|#line 2020 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2020")
end

yyval56 := new_empty_string_as 
			yyval := yyval56
		end

	yy_do_action_436 is
			--|#line 2022 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2022")
end

yyval56 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval56
		end

	yy_do_action_437 is
			--|#line 2026 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2026")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_438 is
			--|#line 2028 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2028")
end

yyval56 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval56
		end

	yy_do_action_439 is
			--|#line 2030 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2030")
end

yyval56 := new_lt_string_as 
			yyval := yyval56
		end

	yy_do_action_440 is
			--|#line 2032 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2032")
end

yyval56 := new_le_string_as 
			yyval := yyval56
		end

	yy_do_action_441 is
			--|#line 2034 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2034")
end

yyval56 := new_gt_string_as 
			yyval := yyval56
		end

	yy_do_action_442 is
			--|#line 2036 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2036")
end

yyval56 := new_ge_string_as 
			yyval := yyval56
		end

	yy_do_action_443 is
			--|#line 2038 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2038")
end

yyval56 := new_minus_string_as 
			yyval := yyval56
		end

	yy_do_action_444 is
			--|#line 2040 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2040")
end

yyval56 := new_plus_string_as 
			yyval := yyval56
		end

	yy_do_action_445 is
			--|#line 2042 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2042")
end

yyval56 := new_star_string_as 
			yyval := yyval56
		end

	yy_do_action_446 is
			--|#line 2044 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2044")
end

yyval56 := new_slash_string_as 
			yyval := yyval56
		end

	yy_do_action_447 is
			--|#line 2046 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2046")
end

yyval56 := new_mod_string_as 
			yyval := yyval56
		end

	yy_do_action_448 is
			--|#line 2048 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2048")
end

yyval56 := new_div_string_as 
			yyval := yyval56
		end

	yy_do_action_449 is
			--|#line 2050 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2050")
end

yyval56 := new_power_string_as 
			yyval := yyval56
		end

	yy_do_action_450 is
			--|#line 2052 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2052")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_451 is
			--|#line 2054 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2054")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_452 is
			--|#line 2056 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2056")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_453 is
			--|#line 2058 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2058")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_454 is
			--|#line 2060 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2060")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_455 is
			--|#line 2062 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2062")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_456 is
			--|#line 2064 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2064")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_457 is
			--|#line 2066 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2066")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_458 is
			--|#line 2070 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2070")
end

yyval90 := new_clickable_string (new_minus_string_as) 
			yyval := yyval90
		end

	yy_do_action_459 is
			--|#line 2072 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2072")
end

yyval90 := new_clickable_string (new_plus_string_as) 
			yyval := yyval90
		end

	yy_do_action_460 is
			--|#line 2074 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2074")
end

yyval90 := new_clickable_string (new_not_string_as) 
			yyval := yyval90
		end

	yy_do_action_461 is
			--|#line 2076 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2076")
end

yyval90 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval90
		end

	yy_do_action_462 is
			--|#line 2080 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2080")
end

yyval90 := new_clickable_string (new_lt_string_as) 
			yyval := yyval90
		end

	yy_do_action_463 is
			--|#line 2082 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2082")
end

yyval90 := new_clickable_string (new_le_string_as) 
			yyval := yyval90
		end

	yy_do_action_464 is
			--|#line 2084 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2084")
end

yyval90 := new_clickable_string (new_gt_string_as) 
			yyval := yyval90
		end

	yy_do_action_465 is
			--|#line 2086 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2086")
end

yyval90 := new_clickable_string (new_ge_string_as) 
			yyval := yyval90
		end

	yy_do_action_466 is
			--|#line 2088 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2088")
end

yyval90 := new_clickable_string (new_minus_string_as) 
			yyval := yyval90
		end

	yy_do_action_467 is
			--|#line 2090 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2090")
end

yyval90 := new_clickable_string (new_plus_string_as) 
			yyval := yyval90
		end

	yy_do_action_468 is
			--|#line 2092 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2092")
end

yyval90 := new_clickable_string (new_star_string_as) 
			yyval := yyval90
		end

	yy_do_action_469 is
			--|#line 2094 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2094")
end

yyval90 := new_clickable_string (new_slash_string_as) 
			yyval := yyval90
		end

	yy_do_action_470 is
			--|#line 2096 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2096")
end

yyval90 := new_clickable_string (new_mod_string_as) 
			yyval := yyval90
		end

	yy_do_action_471 is
			--|#line 2098 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2098")
end

yyval90 := new_clickable_string (new_div_string_as) 
			yyval := yyval90
		end

	yy_do_action_472 is
			--|#line 2100 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2100")
end

yyval90 := new_clickable_string (new_power_string_as) 
			yyval := yyval90
		end

	yy_do_action_473 is
			--|#line 2102 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2102")
end

yyval90 := new_clickable_string (new_and_string_as) 
			yyval := yyval90
		end

	yy_do_action_474 is
			--|#line 2104 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2104")
end

yyval90 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval90
		end

	yy_do_action_475 is
			--|#line 2106 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2106")
end

yyval90 := new_clickable_string (new_implies_string_as) 
			yyval := yyval90
		end

	yy_do_action_476 is
			--|#line 2108 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2108")
end

yyval90 := new_clickable_string (new_or_string_as) 
			yyval := yyval90
		end

	yy_do_action_477 is
			--|#line 2110 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2110")
end

yyval90 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval90
		end

	yy_do_action_478 is
			--|#line 2112 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2112")
end

yyval90 := new_clickable_string (new_xor_string_as) 
			yyval := yyval90
		end

	yy_do_action_479 is
			--|#line 2114 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2114")
end

yyval90 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval90
		end

	yy_do_action_480 is
			--|#line 2118 "eiffel.y"
		local
			yyval4: ARRAY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2118")
end

yyval4 := new_array_as (yytype68 (yyvs.item (yyvsp - 1))) 
			yyval := yyval4
		end

	yy_do_action_481 is
			--|#line 2122 "eiffel.y"
		local
			yyval58: TUPLE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2122")
end

yyval58 := new_tuple_as (yytype68 (yyvs.item (yyvsp - 1))) 
			yyval := yyval58
		end

	yy_do_action_482 is
			--|#line 2126 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2126")
end
			yyval := yyval_default;


		end

	yy_do_action_483 is
			--|#line 2130 "eiffel.y"
		local
			yyval93: TOKEN_LOCATION
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2130")
end

yyval93 := clone (current_position) 
			yyval := yyval93
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

			  257,  257,  258,  258,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  150,  150,  150,  151,  151,  208,
			  208,  127,  127,  130,  130,  169,  169,  169,  169,  169,
			  169,  169,  169,  169,  143,  156,  156,  156,  156,  156,
			  156,  156,  156,  156,  156,  156,  156,  156,  156,  156,
			  156,  156,  156,  156,  156,  156,  156,  156,  156,  156,
			  156,  156,  156,  156,  156,  156,  156,  156,  156,  156,
			  156,  165,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  181,  180,  179,  183,  178,  187,
			  187,  187,  187,  182,  188,  189,  139,  139,  177,  177,

			  128,  129,  225,  225,  225,  226,  226,  227,  227,  228,
			  228,  163,  134,  134,  134,  134,  134,  134,  135,  135,
			  135,  135,  135,  135,  138,  138,  142,  172,  172,  172,
			  190,  190,  190,  136,  199,  199,  199,  201,  201,  201,
			  201,  201,  201,  201,  201,  201,  201,  201,  201,  201,
			  201,  201,  201,  201,  201,  201,  201,  201,  284,  284,
			  284,  284,  283,  283,  283,  283,  283,  283,  283,  283,
			  283,  283,  283,  283,  283,  283,  283,  283,  283,  283,
			  131,  204,  300,  287>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,    1,    2,   17,    1,    1,    1,    0,    2,    1,
			    0,    2,    1,    0,    3,    2,    1,    2,    4,    2,
			    0,    1,    3,    1,    1,    1,    2,    3,    2,    2,
			    3,    3,    0,    1,    0,    1,    0,    2,    0,    1,
			    1,    2,    1,    2,    3,    0,    0,    1,    2,    3,
			    1,    3,    1,    2,    0,    1,    3,    1,    3,    2,
			    0,    1,    1,    1,    1,    2,    2,    3,    1,    2,
			    2,    2,    2,    0,    2,    2,    1,    2,    2,    3,
			    2,    8,    7,    6,    5,    4,    3,    1,    2,    1,
			    3,    3,    0,    1,    2,    2,    1,    2,    3,    0,

			    1,    1,    0,    2,    1,    3,    6,    5,    1,    3,
			    0,    1,    1,    2,    0,    1,    1,    2,    0,    1,
			    1,    2,    0,    3,    0,    1,    1,    2,    6,    0,
			    3,    0,    1,    1,    2,    5,    1,    3,    0,    1,
			    0,    2,    8,    0,    1,    1,    1,    3,    2,    0,
			    2,    2,    2,    0,    2,    1,    2,    1,    2,    3,
			    0,    2,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    0,    3,    0,    4,    0,    0,    3,    0,
			    4,    0,    0,    1,    1,    2,    3,    2,    4,    3,
			    1,    1,    3,    3,    2,    2,    2,    2,    2,    0,

			    2,    3,    2,    3,    1,    3,    0,    4,    0,    1,
			    1,    3,    3,    0,    0,    3,    0,    3,    8,    0,
			    1,    1,    2,    5,    0,    2,    6,    0,    1,    1,
			    2,    5,    1,    3,    1,    3,    1,    3,    1,    3,
			    3,    3,    3,    3,    1,    3,    3,    3,    3,    3,
			    3,    3,    0,    2,   10,    0,    2,    0,    3,    0,
			    0,    4,    2,    5,    0,    2,    3,    1,    3,    1,
			    0,    2,    4,    4,    4,    4,    0,    1,    1,    2,
			    1,    3,    2,    2,    4,    3,    5,    5,    5,    7,
			    7,    5,    3,    5,    5,    5,    7,    6,    5,    4,

			    0,    3,    1,    3,    1,    3,    4,    5,    5,    4,
			    4,    4,    4,    1,    6,    4,    7,    6,    5,    0,
			    1,    1,    1,    0,    3,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    4,    1,    1,    1,    1,    1,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    4,
			    3,    4,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    2,    2,    2,    2,    2,    4,    2,    4,    2,
			    2,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    3,    3,    3,    5,    3,    2,
			    5,    8,    6,    3,    7,    6,    1,    1,    3,    3,

			    2,    2,    0,    2,    3,    1,    3,    0,    1,    1,
			    3,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    2,    2,
			    1,    2,    2,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    3,    3,    0,    0>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    7,  483,  411,    0,   32,    1,   16,  483,   20,    0,
			    0,    0,    0,    6,    2,  190,  191,  199,   33,   34,
			    0,   34,   17,    0,    0,  199,    5,  197,  196,  199,
			  427,    0,    0,  195,  194,    0,  198,   35,   29,    0,
			   34,   34,   28,   19,  457,  456,  455,  454,  453,  452,
			  451,  450,  449,  448,  447,  446,  445,  444,  443,  442,
			  441,  440,  439,  436,  438,  435,  425,  424,    0,   23,
			    0,  433,  437,  430,  426,    0,    0,   21,   25,  416,
			  412,  413,    0,   24,  414,  415,  417,  434,   54,  193,
			  192,  429,  428,  200,  204,    0,  483,   31,   30,    0,

			    0,  432,  431,   26,  407,    0,    0,   55,   18,  201,
			    0,  149,    0,    0,  483,    0,  376,    0,  402,    0,
			  375,    0,    0,  407,  483,  421,  420,    0,    0,    0,
			    0,  371,    0,    0,  377,  336,  335,  422,  418,  338,
			  419,  383,  409,  402,    0,  380,  374,  373,  372,  382,
			  378,  379,  381,  339,  423,  337,    0,  408,   27,   22,
			  205,    0,   36,  208,  483,  323,  483,  483,    0,    0,
			    0,    0,    0,    0,  300,    0,    0,  389,    0,  483,
			    0,  370,    0,    0,  369,    0,   62,   63,   64,  367,
			    0,    0,  199,    0,    0,    0,  364,  138,  363,  361,

			  362,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  483,  400,  365,    0,    0,  481,    0,  150,    0,   73,
			  213,  210,    0,  209,  323,    0,  318,    0,    0,  397,
			  385,  402,  396,    0,    0,    0,    0,    0,    0,    0,
			  292,    0,  403,  405,    0,    0,    0,  384,  461,  460,
			  459,  458,   66,  479,  478,  477,  476,  475,  474,  473,
			  472,  471,  470,  469,  468,  467,  466,  465,  464,  463,
			  462,   65,    0,    0,  483,  483,  480,  300,  340,  136,
			  139,    0,  386,  347,  346,  345,  344,  343,  342,  341,

			  354,  356,  355,  357,  358,  359,    0,  348,  353,    0,
			  350,  352,  360,    0,  388,  393,  410,   37,  483,  483,
			  214,  207,    0,  317,  402,  300,  300,    0,  401,  300,
			  300,  300,    0,    0,  304,    0,  313,  302,    0,  300,
			  402,  404,    0,    0,  300,  368,    0,    0,    0,  299,
			  483,    0,    0,  366,  349,  351,  300,   76,  483,    0,
			   75,  483,    0,  212,  211,  324,  298,  293,  398,  399,
			  291,  286,  287,    0,    0,    0,    0,    0,    0,  199,
			  301,    0,  288,  390,  406,    0,  294,  483,  300,  402,
			    0,  387,  137,  295,   77,   78,  199,  280,  278,  102,

			  483,    0,  216,  300,  300,  199,  197,  196,  199,  195,
			  194,    0,  483,    0,  303,  402,    0,  297,  392,  300,
			   79,   80,    0,    0,  282,    0,   38,  279,  283,    0,
			  215,  290,  289,  193,  312,  311,  192,  310,  309,  202,
			    0,  306,  394,  402,  296,  112,  120,   87,  116,   54,
			   86,  110,  114,  118,    0,   92,   48,    0,   50,  281,
			  108,  104,  103,    0,   45,   60,   40,  483,   39,    0,
			  285,    0,  308,  307,  203,  391,  113,  121,   89,   88,
			    0,  117,   96,   94,   99,   95,  111,  114,  115,  118,
			  119,    0,   85,   93,  110,   49,    0,    0,    0,    0,

			    0,   46,   61,   52,   60,   57,  122,    0,  257,   41,
			  284,  217,    0,    0,   97,  100,   54,  101,  118,    0,
			   84,  114,   51,  109,  105,    0,    0,   44,   47,   53,
			   60,  124,  160,  140,   59,  259,  483,   90,   91,   98,
			    0,   83,  118,    0,    0,   58,  126,  483,    0,  125,
			   56,    0,   13,  482,    7,   82,    0,  107,    0,    0,
			  123,  127,  161,  141,   10,  483,   67,   68,  184,  258,
			  482,  483,    0,   81,  106,  129,   13,  483,   13,   69,
			   36,   15,  483,  185,   54,    0,    4,    3,    0,    0,
			   71,  483,   70,   72,  143,   14,  186,  187,  402,    0,

			   54,  172,  189,  130,  128,  174,  153,  188,  176,  482,
			  131,    0,  482,  173,  133,  483,  154,  132,  160,  483,
			  160,  146,  145,  144,  177,  175,    0,  134,  152,  482,
			  149,    0,  151,  179,  270,    0,  157,  482,  483,  147,
			  148,  181,  482,  160,    0,   54,  158,  269,  483,  160,
			  164,  170,  162,  169,  166,  167,  163,  160,  168,  171,
			  165,    0,  482,  178,  271,  142,  135,    0,  255,  159,
			    0,    0,  264,    0,  482,    0,    0,  319,    0,  325,
			  402,  331,  327,  326,  328,  333,  329,  330,  332,  180,
			  227,  482,  260,    0,    0,    0,    0,  160,    0,    0,

			  322,    0,  323,  321,  320,    0,    0,    0,    0,  483,
			  229,  252,  228,  256,    0,    0,  273,  275,  160,  265,
			  267,    0,    0,  334,    0,  315,    0,    0,  272,  274,
			    0,  160,    0,  230,  262,  402,  483,  483,  266,    0,
			  263,    0,  323,    0,  236,  238,  234,  232,  244,    0,
			  253,  226,    0,    0,  221,  224,  483,    0,  268,  323,
			  314,    0,    0,    0,    0,    0,  160,    0,  261,    0,
			  160,    0,  222,    0,  316,    0,  237,  243,  251,  242,
			  239,  240,  246,  241,  235,  249,  250,  245,  248,  247,
			  231,  233,  160,  225,  218,    0,    0,    0,  160,    0,

			  254,  223,  395,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  702,  134,  239,  236,  135,  650,   77,   78,  136,  137,
			  532,  138,  240,  139,  710,  140,  651,  423,  465,  566,
			  579,  461,  398,  652,  141,  653,  754,  634,  482,  142,
			  622,  630,  503,  466,  516,  231,  143,   24,  144,  654,
			    6,  655,  656,  636,  657,   84,  623,  747,  536,  658,
			  242,  145,  146,  147,  148,  149,  150,  337,  357,  395,
			  151,  152,  748,   85,  478,  606,  659,  660,  624,  593,
			  153,  229,  154,  162,   87,  568,  584,  155,   94,  552,
			   15,  705,   16,  546,  614,  715,   88,  711,  712,  462,
			  426,  399,  400,  755,  756,  451,  494,  483,  221,  254,

			  156,  157,  504,  467,  468,  459,  486,  487,  488,  489,
			  490,  491,  430,  111,  232,  233,  484,  457,  547,  291,
			    4,    7,  580,  567,  644,  628,  637,  771,  732,  749,
			  250,  338,  319,  358,  455,  479,  697,  721,  569,  570,
			  692,  413,   36,   95,  533,  548,  549,  611,  616,  617,
			  186,   26,  187,  188,  460,  505,  281,  262,  506,  363,
			    8,  803,    5,   20,  587,  108,   21,   38,  501,  629,
			  507,  589,  601,  571,  609,  612,  642,  662,  320,  553>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   17,  543, -32768,   35,  103, -32768, -32768,  380,   94,  275,
			  146,  275,  307, -32768, -32768, -32768, -32768,  635, -32768,  687,
			  708,  -13, -32768,  716, 1450,  635, -32768, -32768, -32768,  635,
			 -32768,  722,  721, -32768, -32768,  124, -32768, -32768, -32768,  275,
			  687,  687, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  694, -32768,
			   35, -32768, -32768, -32768, -32768,  414,  404, -32768, -32768, -32768,
			 -32768, -32768,  105, -32768, -32768, -32768, -32768, -32768,  313, -32768,
			 -32768, -32768, -32768, -32768, -32768,  290,  226, -32768, -32768,   35,

			  713, -32768, -32768, -32768, 1294,  680, 1563, -32768, -32768, -32768,
			   35,  525,  696,  692, -32768,  667,  310,   44,   36,  690,
			  291,   62,  123, 1294, -32768, -32768, -32768, 1294, 1294,  705,
			 1294, -32768, 1294, 1294,  488, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 1890,  260, 1294, -32768, -32768, -32768, -32768, -32768,
			 -32768,  486,  485, -32768, -32768, -32768,  685,  689, -32768, -32768,
			 -32768, 1612,  497,  675, -32768,  264, -32768, -32768,   94,  703,
			  702,  700,   35, 1294,  481,  275, 1122, -32768,  275, -32768,
			   94, -32768,  243, 1692, -32768, 1294, -32768, -32768, -32768, -32768,
			  275,  620,  433,  677,   94, 1848, -32768,   94, -32768, -32768,

			 -32768,   94, 1294, 1294, 1294, 1294, 1294, 1294, 1294, 1294,
			 1294, 1294, 1294, 1294, 1294, 1007, 1294,  894, 1294, 1294,
			 -32768, -32768, -32768,   94,   94, -32768, 1294, -32768, 1145,  645,
			 -32768, -32768,  666,  683,  264,   94, -32768,   94,   94,  674,
			 -32768,  641, -32768,   94,   94,   94,  673, 1830, 1407,   94,
			 -32768,  671, -32768, 1890,  407,  670,   94, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 1772,  665, -32768, -32768, -32768,  655,  256, -32768,
			  515,  668, -32768,  416,  416,  416,  416,  416,  636,  636,

			  768,  768,  768,  768,  768,  768, 1294,  958, 1905, 1294,
			 1620, 1871, -32768,   94, -32768, -32768, 1890, -32768,  459, -32768,
			  659, -32768,  675, -32768,  641,  655,  655,   94, -32768,  655,
			  655,  655,  682,  681,  667,  115, 1890, -32768,  385,  655,
			  641, -32768, 1294,  679,  655, -32768,  653,   94,  616, -32768,
			 -32768,   94,   94, -32768,  958, 1620,  655, -32768,  353,  275,
			 -32768,  599,  275, -32768, -32768, -32768, -32768, -32768,  674, -32768,
			 -32768, -32768, -32768,   94,   94,  275,  129,  275,  307,  349,
			 -32768, 1407, -32768, -32768, 1890,   94, -32768, -32768,  655,  641,
			   94, -32768, -32768, -32768, -32768,  661,  635,    3, -32768,  638,

			  236,  654,  652,  655,  655,  635,  644,  643,  635,  642,
			  639,   -7,  371,  637, -32768,  641,  596, -32768, -32768,  655,
			 -32768,  476,  152,   42,  139,   42,  589, -32768,    3,   42,
			 -32768, -32768, -32768,  630, -32768, -32768,  628, -32768, -32768,  567,
			  251, -32768, -32768,  641, -32768,   42,   42,   42,   42,   41,
			 -32768,  538,  514,  499,  598,  594, -32768,  351, -32768,  566,
			 -32768, -32768,  622,  169, -32768,  418, -32768, -32768,  589,   42,
			  139,    7, -32768, -32768,  546, -32768,  566,  566, -32768,  619,
			  587,  566, -32768,  562,   82, -32768, -32768,  514, -32768,  499,
			 -32768,  572, -32768, -32768,  538, -32768,  275,   42,   42,  569,

			  568,  562, -32768, -32768,  304, -32768,   93,   42,  533, -32768,
			  566, -32768,   42,   42, -32768, -32768,  500,  566,  499,  541,
			 -32768,  514, -32768, -32768, -32768,   35,   35, -32768, -32768, -32768,
			  529,   94, -32768,  561, -32768, -32768, -32768, -32768, -32768, -32768,
			  530, -32768,  499,  341,  186, -32768, -32768,  515,  545,   94,
			  487,   35,  208,  -31,  517, -32768,  521, -32768,  539,  540,
			 -32768, -32768, -32768, -32768, 1591,  516, -32768, -32768, -32768, -32768,
			  420, -32768,  512, -32768, -32768,  524,  498,  610,  498, -32768,
			  497, -32768,  503, -32768,  500, 1294, -32768, -32768,   94,   35,
			 -32768,  513, -32768, -32768, -32768, -32768, -32768, 1890,  388,  518,

			  500,  477, 1294, -32768, -32768,  495,  475, 1890, -32768,  261,
			   94,  581,  261, -32768, -32768,  515, -32768,   94, -32768, -32768,
			 -32768, -32768, -32768, -32768,  489, -32768,  501, -32768, -32768,  462,
			  525, 1612, -32768,  442,  456,   35, -32768,  339,  106, -32768,
			 -32768, -32768,  -28, -32768,  467,  500, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  213,  -28, -32768, -32768, -32768, -32768, 1294,  444,  487,
			  209, 1294,  496,  494,  448,  225,   30,   35, 1294,  488,
			  216, -32768, -32768, -32768, -32768, -32768, -32768,  486,  485, -32768,
			  614,  233,  408, 1294, 1294, 1736, 1428, -32768,  438,  447,

			 -32768,   35,  264, -32768, -32768,  457, 1754, 1294, 1294, -32768,
			 -32768,  387,  386, -32768, 1294,  354, 1890, 1890, -32768, -32768,
			 -32768,  314,  421, -32768,  430, -32768,   20,  392, 1890, 1890,
			  246, -32768,  405, -32768, 1890,  192, -32768,  299, -32768, 1612,
			 -32768,   20,  264,  377,  446,  417,  397, -32768,  383,   -3,
			 -32768, -32768, 1294, 1294, -32768,  254,  191,  249, -32768,  264,
			 -32768,  275,  195,  246,  207,  246, -32768,  246, 1890,  829,
			 -32768,  166, -32768, 1294, -32768,  194, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, 1642,  185,  120, -32768,   94,

			 -32768, -32768, -32768,   52,   27, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -598,  197,  528, -227, -32768, -32768,  748,  287, -32768,   -4,
			 -32768,   -6, -158, -32768,  144,  -20, -32768, -396, -32768, -32768,
			 -32768,  332,  432, -32768,    1, -32768,   73, -32768,  345,  605,
			 -32768, -32768,  323,  358, -32768,  484,    0, -32768,  162, -32768,
			   -5, -32768, -32768,  188, -32768,  -11, -32768,   38, -32768, -32768,
			  473,  143,  142,  141,  140,  137,  136,  415,  437, -32768,
			  133,  132, -116, -32768,  280, -32768, -32768, -32768, -32768, -32768,
			 -32768,  211,  -21,  149, -146,  210, -32768,  695,    2, -32768,
			 -172, -32768, -32768,  227,  158, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  319, -32768, -32768,  -77, -32768,

			  649, -32768, -32768, -32768, -32768, -120,  352,  276,  347, -454,
			  340, -449, -32768, -32768, -32768, -32768, -380, -32768, -188, -32768,
			  206, -313, -32768, -196, -32768, -589, -32768, -32768, -32768, -32768,
			 -190, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -528, -32768,
			 -32768, -32768,    5, -400, -32768, -32768, -32768, -32768, -32768, -32768,
			   12,   10, -32768, -32768, -105,  228, -32768, -32768, -32768, -32768,
			  -68, -32768, -32768, -32768, -32768, -304, -32768,   18, -32768, -513,
			 -32768, -32768, -32768, -462, -32768, -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    3,   34,   22,   86,   81,   14,  255,  323,   23,  290,
			   28,  440,   33,   17,  360,  227,  189,  424,   80,  550,
			   79,   25,  257,   29,   83,   82,   13,  805,  112,   12,
			   89,  632,  469,  518,   90, -182,  -46,  767, -182,   42,
			  519,  177,  439,  292, -182,   17,  165,  497,  470,  422,
			    2,   96,  804,    2,  664,   41,  194,   37,   97,   98,
			  668,   11,  176,    2, -182,  314,  315,  542,   13,  540,
			  173,   12,  100,  511,   10,   13,  701,    2,  107,  -46,
			   17,  613,  175,   40,  625,   86,   81,  422,  185,    9,
			  172,  -46,    1,  556,  766,   13,  234,  349,  237,  238,

			   80,  113,   79,   11,  171,  527,   83,   82,  722,   17,
			  515,  256,  160,  700,  663,   13,   10,  174,  183,  531,
			   17,  528,  184,  700,  191,  543,  544,    2,  742,  737,
			  182,    9,  192,  530,  689,  366,  367,  170,  183,  370,
			  371,  372,  750,  759,  669,  485,  698,  169,   13,  382,
			  182,  378,  313,  104,  386,  181,   13,   13,  183,   12,
			   12,  190,    2,  713,  328,   19,  393,  638,  241,  190,
			  182,  103,  -47,   93,  246,  638,   18,  790,  649,    2,
			  241,  793,   17,  377,  648,   13,  800,  251,   17,  406,
			  402,   11,   11,  391,  287,  500,  376,  289,  417,  456,

			  647,  241,  283,  797,   10,   10,   27,  317,  499,  801,
			  799,  375,  539,  431,  432,  -47,  347,  348,  176,    9,
			    9,   32,   31,  241,  241,   74,  110,  -47,    2,  444,
			  220,  752,  794,  558,  168,  324,   30,  325,  326,  678,
			    2,  796,  176,  329,  330,  331,    2,  365,  677,  339,
			  359,  361,  582, -206,  676, -220,  344, -220,   13,  675,
			   32,   31,  694,  383,  591,  693,  743, -206, -206,  708,
			  674,  190,  707,  673,  672,   30,   74,  397,  743,    2,
			  596,  351,  390,  565,  119, -206,  176,  671,  564,  235,
			  359,  110, -206,  401,  350, -277,  604, -206,  220,  118,

			  474, -206, -277, -206,  219, -206,  670, -277,   13,  471,
			 -206, -277,  418,  356,  773, -277,  180,  743,  770,  416,
			  463,   32,   31, -182, -182,  476,  477,  241,  481,  179,
			  110, -182,  401, -182, -182,  168,   30,  191,  442,  109,
			    2,  666,  480, -182,  348,  379, -182,  388,  167,  510,
			  107,  241,  392,  106,  739,  261,  260,  219,  219,  738,
			  219,  219,  219, -219,  517, -219,  475,  410,  259,  258,
			  -43,  396,   17,  403,  404,  -43,  407,  502,  409,  -43,
			  590,  110,  592,  -43,  219,  415,  765,  405,  557,  408,
			  419,  496,  523,  463,  -74,  -74,  412,  411,  495,  508,

			  764,  421,  534, -156, -156, -156, -156,  480,  538,  219,
			  433, -305,  -74,  436,  176,  219, -305,  351, -156,  -74,
			  763,   17,  615,  761,  -74,  381,  220,  602,  -74,  615,
			  380, -156,  -74,   92,  458,  102,  202,  131,   -8, -156,
			 -156, -156,   -8,   91,  219,  101,   -8,  342,   -8,  762,
			   -8,  731,  341,   -8,  736,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  554,  219,
			  219,  751,  219,  219,  219,  725,   -8,  741,  219,  559,
			  285,   35, -183, -183,  -42,  640, -183,  740,  709,  -42,
			 -183,  502,  726,  -42,  285, -183,  107,  -42,  219,  562,

			  -54,  -54, -183,  585,  723, -183,  249,  248,  522,  714,
			  224,  223, -183,  201, -182,  760,  219,  219,  -54,  180,
			 -183, -183,  696,  691,  562,  -54, -155, -155, -155, -155,
			  -54,  289,  774,  665,  -54,   17,   17,  107,  -54,  641,
			  635, -155,  450,   86,   81,  449,  219,  626,  643,  289,
			  720,  631,  161,  563, -155,  352,  633,  610,   80,  608,
			   79,   17, -155, -155, -155,  448,  447,  603,  605,  595,
			  661,  446,  588,  565,  445,  -11,  -11,   22,  586,  575,
			  667,  228,  581,  -11,  574,  598,   22,  573,  599,  775,
			  560,  600,    1,  758,  446,  -11,  555,  -11,  -11,   17,

			  551,   -9,  502,  448,  -11,   -9,  497,  541,  422,   -9,
			  289,   -9,  535,   -9,  526,  525,   -9,  289,  218,  217,
			  216,  215,  214,  213,  212,  211,  210,  209,  208,  207,
			  206,  205,  204,  203,  202,  131,  445,  645,  520,   -9,
			  397,  730,  513,  621,  620,   17,  778,  782,  785,  789,
			 -201,  619,  206,  205,  204,  203,  202,  131, -276,  512,
			  464,  680,  498,  449,  492, -276,  618,  176,  753,  757,
			 -276, -200,  -12,  -12, -276,  473,  703,  472, -276,  704,
			  -12,  248,  443,   35,  441,  699,  438,   17,  757,  437,
			  435,  434,  -12,  429,  -12,  -12,  428,  425,  420,  327,

			  387,  -12,  389,  724,  385,  166,  374,  373,  230,  362,
			  744,   17,  346,  353,  735,  321,  709,  343,  340,  746,
			  332,  286,  318,  322,  284,  245,  703,  244,  243,  226,
			  745,  197,  195,  196,  225,  198,  178,  199,  200,  164,
			   99,  703,  776,  779,  163,  786,  158,  744,  114,  222,
			   92,   91,  781,  784,  788,   43,  746,   37,  545,  219,
			  572,  454,  777,  780,  783,  787,   39,  745,  453,  219,
			  521,   17,  193,  452,  493,  627,  561,  105,  247,  639,
			  583,  253,  208,  207,  206,  205,  204,  203,  202,  131,
			  282,  594,  537,  688,  687,  394,  414,  686,  685,  802,

			  369,  684,  683,  682,  681,  791,  364,  293,  294,  295,
			  296,  297,  298,  299,  300,  301,  302,  303,  304,  305,
			  307,  308,  310,  311,  312,  646,  509,  529,  514,  772,
			  524,  316,  427,  218,  217,  216,  215,  214,  213,  212,
			  211,  210,  209,  208,  207,  206,  205,  204,  203,  202,
			  131,  578,  219,  336,  159,  368,  733,  219,  679,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  219,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  219,  219,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  219,  219,    0,    0,    0,    0,  219,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,  133,  132,
			    0,  354,  792,    0,  355,  131,  130,  129,  128,    0,
			  127,    0,    0,  126,   74,  125,   72,    2,   71,   70,
			  219,  219,  124,    0,    0,   68,    0,  123,    0,    0,
			  122,    0,  104,    0,    0,   67,   66,  384,  121,    0,
			    0,    0,    0,    0,  120,    0,    0,  219,  309,    0,
			    0,    0,    0,    0,    0,  119,  214,  213,  212,  211,
			  210,  209,  208,  207,  206,  205,  204,  203,  202,  131,
			  118,  117,    0,    0,    0,    0,  336,  116,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  115,    0,   65,

			   64,   63,   62,   61,   60,   59,   58,   57,   56,   55,
			   54,   53,   52,   51,   50,   49,   48,   47,   46,   45,
			   44,  133,  132,    0,    0,    0,    0,    0,  131,  130,
			  129,  128,    0,  127,    0,    0,  126,   74,  125,   72,
			    2,   71,   70,    0,    0,  124,    0,    0,   68,    0,
			  123,    0,    0,  122,    0,  104,    0,    0,   67,   66,
			    0,  121,    0,    0,    0,    0,    0,  120,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  119,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  118,  117,    0,    0,    0,    0,    0,

			  116,    0,    0,    0,  306,    0,    0,    0,    0,    0,
			  115,    0,   65,   64,   63,   62,   61,   60,   59,   58,
			   57,   56,   55,   54,   53,   52,   51,   50,   49,   48,
			   47,   46,   45,   44,    0,    0,  133,  132,    0,    0,
			    0,    0,    0,  131,  130,  129,  128,    0,  127,    0,
			    0,  126,   74,  125,   72,    2,   71,   70,    0,    0,
			  124,    0,    0,   68,    0,  123,    0,  252,  122,    0,
			  104,    0,    0,   67,   66,    0,  121,   72,    0,    0,
			    0,    0,  120,    0,    0,    0,    0,    0,    0,    0,
			  597,    0,    0,  119,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,  607,  118,  117,
			    0,    0,    0,    0,    0,  116,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  115,    0,   65,   64,   63,
			   62,   61,   60,   59,   58,   57,   56,   55,   54,   53,
			   52,   51,   50,   49,   48,   47,   46,   45,   44,    0,
			   65,   64,   63,   62,   61,   60,   59,   58,   57,   56,
			   55,   54,   53,   52,   51,   50,   49,   48,   47,   46,
			   45,   44,  690,    0,    0,    0,  695,    0,    0,    0,
			    0,    0,    0,  706,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  716,  717,

			    0,    0,    0,    0,    0,    0,    0,    0,  133,  132,
			    0,    0,  728,  729,    0,  131,  130,  129,  128,  734,
			  127,    0,    0,  126,   74,  125,   72,    2,   71,   70,
			    0,    0,  124,    0,    0,   68,    0,  123,    0,    0,
			  122,    0,  104,    0,    0,   67,   66,    0,  121,    0,
			    0,    0,    0,    0,  120,    0,    0,  768,  769,    0,
			    0,    0,    0,    0,    0,  119,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  795,    0,
			  118,  117,    0,    0,    0,    0,    0,  116,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  115,    0,   65,

			   64,   63,   62,   61,   60,   59,   58,   57,   56,   55,
			   54,   53,   52,   51,   50,   49,   48,   47,   46,   45,
			   44,  133,  132,    0,    0,    0,    0,    0,  131,  130,
			  129,  128,    0,  127,    0,    0,  126,   74,  125,   72,
			    2,   71,   70,    0,    0,  124,    0,    0,   68,    0,
			  123,    0,    0,  335,    0,  104,    0,    0,   67,   66,
			   72,  121,    0,    0,   76,   75,    0,  120,    0,    0,
			    0,    0,    0,  719,    0,    0,    0,    0,  119,   30,
			   74,   73,   72,    2,   71,   70,    0,   69,    0,    0,
			    0,   68,    0,  118,  117,    0,    0,    0,    0,    0,

			  116,   67,   66,    0,    0,    0,    0,    0,    0,    0,
			  334,    0,   65,   64,   63,   62,   61,   60,   59,   58,
			   57,   56,   55,   54,   53,   52,   51,   50,   49,   48,
			   47,   46,   45,   44,   64,    0,   62,   61,   60,   59,
			   58,   57,   56,   55,   54,   53,   52,   51,   50,   49,
			   48,   47,   46,   45,   44,   65,   64,   63,   62,   61,
			   60,   59,   58,   57,   56,   55,   54,   53,   52,   51,
			   50,   49,   48,   47,   46,   45,   44,   76,   75,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   30,   74,   73,   72,    2,   71,   70,    0,

			    0,    0,    0,    0,   68,   76,   75,    0,    0,    0,
			    0,    0,    0,    0,   67,   66,    0,    0,    0,    0,
			   30,   74,   73,   72,    0,   71,  216,  215,  214,  213,
			  212,  211,  210,  209,  208,  207,  206,  205,  204,  203,
			  202,  131,   67,   66,   72,    0,  218,  217,  216,  215,
			  214,  213,  212,  211,  210,  209,  208,  207,  206,  205,
			  204,  203,  202,  131,    0,    0,  577,    0,   65,   64,
			   63,   62,   61,   60,   59,   58,   57,   56,   55,   54,
			   53,   52,   51,   50,   49,   48,   47,   46,   45,   44,
			  576,    0,    0,    0,    0,    0,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,   45,   44,   64,    0,
			   62,   61,   60,   59,   58,   57,   56,   55,   54,   53,
			   52,   51,   50,   49,   48,   47,   46,   45,   44,  798,
			  218,  217,  216,  215,  214,  213,  212,  211,  210,  209,
			  208,  207,  206,  205,  204,  203,  202,  131,  218,  217,
			  216,  215,  214,  213,  212,  211,  210,  209,  208,  207,
			  206,  205,  204,  203,  202,  131,  218,  217,  216,  215,
			  214,  213,  212,  211,  210,  209,  208,  207,  206,  205,
			  204,  203,  202,  131,    0,    0,    0,    0,    0,  727,

			  280,  279,  278,  277,  276,  275,  274,  273,  272,  271,
			  270,  269,  268,  267,  266,  265,  264,  345,  263,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  718,  218,  217,  216,  215,  214,  213,
			  212,  211,  210,  209,  208,  207,  206,  205,  204,  203,
			  202,  131,  218,  217,  216,  215,  214,  213,  212,  211,
			  210,  209,  208,  207,  206,  205,  204,  203,  202,  131,
			    0,    0,    0,    0,    0,  333,  217,  216,  215,  214,
			  213,  212,  211,  210,  209,  208,  207,  206,  205,  204,
			  203,  202,  131,  288,  218,  217,  216,  215,  214,  213,

			  212,  211,  210,  209,  208,  207,  206,  205,  204,  203,
			  202,  131,  215,  214,  213,  212,  211,  210,  209,  208,
			  207,  206,  205,  204,  203,  202,  131>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   12,    7,   24,   24,    3,  178,  234,    8,  197,
			   10,  411,   12,    3,  318,  161,  121,  397,   24,  532,
			   24,    9,  180,   11,   24,   24,   33,    0,   96,   36,
			   25,  620,  428,  487,   29,   66,   33,   40,   66,   21,
			  489,  118,   49,  201,   75,   35,  114,   40,  428,   46,
			   33,   39,    0,   33,  643,   68,  124,   70,   40,   41,
			  649,   68,   26,   33,   92,  223,  224,  521,   33,  518,
			   26,   36,   70,   66,   81,   33,   46,   33,   37,   76,
			   70,  609,   46,   96,  612,  106,  106,   46,   26,   96,
			   46,   88,   75,  542,   97,   33,  164,  287,  166,  167,

			  106,   99,  106,   68,   60,  501,  106,  106,  697,   99,
			   28,  179,  110,   93,  642,   33,   81,  117,   76,   26,
			  110,  501,   60,   93,  122,  525,  526,   33,  726,  718,
			   88,   96,  122,   40,  662,  325,  326,   93,   76,  329,
			  330,  331,  731,  741,  657,  449,  674,  103,   33,  339,
			   88,   36,  220,   48,  344,   93,   33,   33,   76,   36,
			   36,   46,   33,  691,  241,   62,  356,  629,  168,   46,
			   88,   66,   33,   49,  172,  637,   73,  766,   72,   33,
			  180,  770,  172,   68,   78,   33,   66,  175,  178,   60,
			  362,   68,   68,  351,  194,   26,   81,  197,  388,   47,

			   94,  201,  190,  792,   81,   81,   60,  228,   39,  798,
			   25,   96,  516,  403,  404,   76,  284,  285,   26,   96,
			   96,   14,   15,  223,  224,   30,   40,   88,   33,  419,
			   38,   39,   66,   47,   25,  235,   29,  237,  238,   26,
			   33,   47,   26,  243,  244,  245,   33,  324,   35,  249,
			  318,  319,  565,   27,   41,   64,  256,   66,   33,   46,
			   14,   15,   53,  340,  577,   56,   71,   41,   42,   53,
			   57,   46,   56,   60,   61,   29,   30,   41,   71,   33,
			  584,   25,  350,   75,   71,   59,   26,   74,   80,   25,
			  358,   40,   66,  361,   38,   59,  600,   71,   38,   86,

			   49,   75,   66,   77,  142,   79,   93,   71,   33,  429,
			   84,   75,  389,  313,   65,   79,   25,   71,   64,  387,
			  425,   14,   15,   62,   63,  445,  446,  327,  448,   38,
			   40,   70,  400,  100,  101,   25,   29,  335,  415,   49,
			   33,  645,  447,   82,  412,  335,   85,  347,   38,  469,
			   37,  351,  352,   40,   40,  112,  113,  195,  196,   45,
			  198,  199,  200,   64,  484,   66,  443,  378,  125,  126,
			   66,  359,  362,  373,  374,   71,  376,   73,  378,   75,
			  576,   40,  578,   79,  222,  385,    3,  375,   47,  377,
			  390,   40,  497,  498,   41,   42,   47,   48,   47,  467,

			    3,  396,  507,   64,   65,   66,   67,  512,  513,  247,
			  405,   40,   59,  408,   26,  253,   45,   25,   79,   66,
			    3,  411,  610,   46,   71,   40,   38,   39,   75,  617,
			   45,   92,   79,   29,  422,   31,   20,   21,   58,  100,
			  101,  102,   62,   29,  282,   31,   66,   40,   68,    3,
			   70,   64,   45,   73,  100,  293,  294,  295,  296,  297,
			  298,  299,  300,  301,  302,  303,  304,  305,  536,  307,
			  308,   66,  310,  311,  312,  702,   96,   47,  316,  547,
			   47,   48,   62,   63,   66,  631,   66,   66,  102,   71,
			   70,   73,   35,   75,   47,   75,   37,   79,  336,   37,

			   41,   42,   82,  571,   66,   85,   25,   26,  496,  101,
			   25,   25,   92,   25,   66,  742,  354,  355,   59,   25,
			  100,  101,   26,   79,   37,   66,   64,   65,   66,   67,
			   71,  531,  759,   66,   75,  525,  526,   37,   79,   97,
			   39,   79,   66,  564,  564,   69,  384,  615,   92,  549,
			  696,  619,   27,  551,   92,   40,   67,   82,  564,   64,
			  564,  551,  100,  101,  102,   89,   90,   49,   91,   66,
			  638,   95,   48,   75,   98,   62,   63,  582,   66,   39,
			  648,   84,   66,   70,   45,  585,  591,   66,  588,  761,
			   45,  589,   75,  739,   95,   82,   66,   84,   85,  589,

			   39,   58,   73,   89,   91,   62,   40,   66,   46,   66,
			  610,   68,   79,   70,   46,   46,   73,  617,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   98,  635,   66,   96,
			   41,  709,   55,   62,   63,  635,  762,  763,  764,  765,
			  104,   70,   16,   17,   18,   19,   20,   21,   59,   40,
			   71,  661,   40,   69,   66,   66,   85,   26,  736,  737,
			   71,  104,   62,   63,   75,   47,  676,   47,   79,  677,
			   70,   26,   86,   48,   47,  675,   47,  677,  756,   47,
			   47,   47,   82,   41,   84,   85,   42,   59,   37,   25,

			   47,   91,   86,  701,   25,   38,   25,   25,   33,   50,
			  730,  701,   47,   45,  714,   49,  102,   47,   47,  730,
			   47,   44,   77,   40,  104,   25,  726,   25,   25,   40,
			  730,   26,  127,  128,   49,  130,   46,  132,  133,   47,
			   46,  741,  762,  763,   48,  765,   66,  767,   35,  144,
			   29,   29,  763,  764,  765,   39,  767,   70,  530,  597,
			  554,  421,  762,  763,  764,  765,   58,  767,  421,  607,
			  494,  761,  123,  421,  455,  617,  549,   82,  173,  630,
			  570,  176,   14,   15,   16,   17,   18,   19,   20,   21,
			  185,  580,  512,  661,  661,  358,  381,  661,  661,  799,

			  327,  661,  661,  661,  661,  767,  322,  202,  203,  204,
			  205,  206,  207,  208,  209,  210,  211,  212,  213,  214,
			  215,  216,  217,  218,  219,  637,  468,  504,  483,  756,
			  498,  226,  400,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,  564,  690,  248,  106,  327,  712,  695,  661,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  706,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  716,  717,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  728,  729,   -1,   -1,   -1,   -1,  734,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   14,   15,
			   -1,  306,   83,   -1,  309,   21,   22,   23,   24,   -1,
			   26,   -1,   -1,   29,   30,   31,   32,   33,   34,   35,
			  768,  769,   38,   -1,   -1,   41,   -1,   43,   -1,   -1,
			   46,   -1,   48,   -1,   -1,   51,   52,  342,   54,   -1,
			   -1,   -1,   -1,   -1,   60,   -1,   -1,  795,   64,   -1,
			   -1,   -1,   -1,   -1,   -1,   71,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   86,   87,   -1,   -1,   -1,   -1,  381,   93,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  103,   -1,  105,

			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,   14,   15,   -1,   -1,   -1,   -1,   -1,   21,   22,
			   23,   24,   -1,   26,   -1,   -1,   29,   30,   31,   32,
			   33,   34,   35,   -1,   -1,   38,   -1,   -1,   41,   -1,
			   43,   -1,   -1,   46,   -1,   48,   -1,   -1,   51,   52,
			   -1,   54,   -1,   -1,   -1,   -1,   -1,   60,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   71,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   86,   87,   -1,   -1,   -1,   -1,   -1,

			   93,   -1,   -1,   -1,   97,   -1,   -1,   -1,   -1,   -1,
			  103,   -1,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,   -1,   -1,   14,   15,   -1,   -1,
			   -1,   -1,   -1,   21,   22,   23,   24,   -1,   26,   -1,
			   -1,   29,   30,   31,   32,   33,   34,   35,   -1,   -1,
			   38,   -1,   -1,   41,   -1,   43,   -1,   45,   46,   -1,
			   48,   -1,   -1,   51,   52,   -1,   54,   32,   -1,   -1,
			   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  585,   -1,   -1,   71,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  602,   86,   87,
			   -1,   -1,   -1,   -1,   -1,   93,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  103,   -1,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,   -1,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  667,   -1,   -1,   -1,  671,   -1,   -1,   -1,
			   -1,   -1,   -1,  678,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  693,  694,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   14,   15,
			   -1,   -1,  707,  708,   -1,   21,   22,   23,   24,  714,
			   26,   -1,   -1,   29,   30,   31,   32,   33,   34,   35,
			   -1,   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   -1,
			   46,   -1,   48,   -1,   -1,   51,   52,   -1,   54,   -1,
			   -1,   -1,   -1,   -1,   60,   -1,   -1,  752,  753,   -1,
			   -1,   -1,   -1,   -1,   -1,   71,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  773,   -1,
			   86,   87,   -1,   -1,   -1,   -1,   -1,   93,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  103,   -1,  105,

			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,   14,   15,   -1,   -1,   -1,   -1,   -1,   21,   22,
			   23,   24,   -1,   26,   -1,   -1,   29,   30,   31,   32,
			   33,   34,   35,   -1,   -1,   38,   -1,   -1,   41,   -1,
			   43,   -1,   -1,   46,   -1,   48,   -1,   -1,   51,   52,
			   32,   54,   -1,   -1,   14,   15,   -1,   60,   -1,   -1,
			   -1,   -1,   -1,   45,   -1,   -1,   -1,   -1,   71,   29,
			   30,   31,   32,   33,   34,   35,   -1,   37,   -1,   -1,
			   -1,   41,   -1,   86,   87,   -1,   -1,   -1,   -1,   -1,

			   93,   51,   52,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  103,   -1,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  106,   -1,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,   14,   15,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   29,   30,   31,   32,   33,   34,   35,   -1,

			   -1,   -1,   -1,   -1,   41,   14,   15,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   51,   52,   -1,   -1,   -1,   -1,
			   29,   30,   31,   32,   -1,   34,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   51,   52,   32,   -1,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   -1,   -1,   75,   -1,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			   99,   -1,   -1,   -1,   -1,   -1,  105,  106,  107,  108,

			  109,  110,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  106,   -1,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,   97,
			    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   -1,   -1,   -1,   -1,   -1,   45,

			  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,   45,  126,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   97,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   -1,   -1,   -1,   -1,   -1,   45,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   45,    4,    5,    6,    7,    8,    9,

			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21>>)
		end

feature {NONE} -- Conversion

	yytype1 (v: ANY): ACCESS_AS is
		require
			valid_type: yyis_type1 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type1 (v: ANY): BOOLEAN is
		local
			u: ACCESS_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype2 (v: ANY): ACCESS_FEAT_AS is
		require
			valid_type: yyis_type2 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type2 (v: ANY): BOOLEAN is
		local
			u: ACCESS_FEAT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype3 (v: ANY): ACCESS_INV_AS is
		require
			valid_type: yyis_type3 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type3 (v: ANY): BOOLEAN is
		local
			u: ACCESS_INV_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype4 (v: ANY): ARRAY_AS is
		require
			valid_type: yyis_type4 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type4 (v: ANY): BOOLEAN is
		local
			u: ARRAY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype5 (v: ANY): ASSIGN_AS is
		require
			valid_type: yyis_type5 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type5 (v: ANY): BOOLEAN is
		local
			u: ASSIGN_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype6 (v: ANY): ATOMIC_AS is
		require
			valid_type: yyis_type6 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type6 (v: ANY): BOOLEAN is
		local
			u: ATOMIC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype7 (v: ANY): BIT_CONST_AS is
		require
			valid_type: yyis_type7 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type7 (v: ANY): BOOLEAN is
		local
			u: BIT_CONST_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype8 (v: ANY): BODY_AS is
		require
			valid_type: yyis_type8 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type8 (v: ANY): BOOLEAN is
		local
			u: BODY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype9 (v: ANY): BOOL_AS is
		require
			valid_type: yyis_type9 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type9 (v: ANY): BOOLEAN is
		local
			u: BOOL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype10 (v: ANY): CALL_AS is
		require
			valid_type: yyis_type10 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type10 (v: ANY): BOOLEAN is
		local
			u: CALL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype11 (v: ANY): CASE_AS is
		require
			valid_type: yyis_type11 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type11 (v: ANY): BOOLEAN is
		local
			u: CASE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype12 (v: ANY): CHAR_AS is
		require
			valid_type: yyis_type12 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type12 (v: ANY): BOOLEAN is
		local
			u: CHAR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype13 (v: ANY): CHECK_AS is
		require
			valid_type: yyis_type13 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type13 (v: ANY): BOOLEAN is
		local
			u: CHECK_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype14 (v: ANY): CLIENT_AS is
		require
			valid_type: yyis_type14 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type14 (v: ANY): BOOLEAN is
		local
			u: CLIENT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype15 (v: ANY): CONTENT_AS is
		require
			valid_type: yyis_type15 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type15 (v: ANY): BOOLEAN is
		local
			u: CONTENT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype16 (v: ANY): CONVERT_FEAT_AS is
		require
			valid_type: yyis_type16 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type16 (v: ANY): BOOLEAN is
		local
			u: CONVERT_FEAT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype17 (v: ANY): CREATE_AS is
		require
			valid_type: yyis_type17 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type17 (v: ANY): BOOLEAN is
		local
			u: CREATE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype18 (v: ANY): CREATION_AS is
		require
			valid_type: yyis_type18 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type18 (v: ANY): BOOLEAN is
		local
			u: CREATION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype19 (v: ANY): CREATION_EXPR_AS is
		require
			valid_type: yyis_type19 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type19 (v: ANY): BOOLEAN is
		local
			u: CREATION_EXPR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype20 (v: ANY): DEBUG_AS is
		require
			valid_type: yyis_type20 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type20 (v: ANY): BOOLEAN is
		local
			u: DEBUG_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype21 (v: ANY): ELSIF_AS is
		require
			valid_type: yyis_type21 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type21 (v: ANY): BOOLEAN is
		local
			u: ELSIF_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype22 (v: ANY): ENSURE_AS is
		require
			valid_type: yyis_type22 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type22 (v: ANY): BOOLEAN is
		local
			u: ENSURE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype23 (v: ANY): EXPORT_ITEM_AS is
		require
			valid_type: yyis_type23 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type23 (v: ANY): BOOLEAN is
		local
			u: EXPORT_ITEM_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype24 (v: ANY): EXPR_AS is
		require
			valid_type: yyis_type24 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type24 (v: ANY): BOOLEAN is
		local
			u: EXPR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype25 (v: ANY): EXTERNAL_AS is
		require
			valid_type: yyis_type25 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type25 (v: ANY): BOOLEAN is
		local
			u: EXTERNAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype26 (v: ANY): EXTERNAL_LANG_AS is
		require
			valid_type: yyis_type26 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type26 (v: ANY): BOOLEAN is
		local
			u: EXTERNAL_LANG_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype27 (v: ANY): FEATURE_AS is
		require
			valid_type: yyis_type27 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type27 (v: ANY): BOOLEAN is
		local
			u: FEATURE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype28 (v: ANY): FEATURE_CLAUSE_AS is
		require
			valid_type: yyis_type28 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type28 (v: ANY): BOOLEAN is
		local
			u: FEATURE_CLAUSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype29 (v: ANY): FEATURE_SET_AS is
		require
			valid_type: yyis_type29 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type29 (v: ANY): BOOLEAN is
		local
			u: FEATURE_SET_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype30 (v: ANY): FORMAL_DEC_AS is
		require
			valid_type: yyis_type30 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type30 (v: ANY): BOOLEAN is
		local
			u: FORMAL_DEC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype31 (v: ANY): ID_AS is
		require
			valid_type: yyis_type31 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type31 (v: ANY): BOOLEAN is
		local
			u: ID_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype32 (v: ANY): IF_AS is
		require
			valid_type: yyis_type32 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type32 (v: ANY): BOOLEAN is
		local
			u: IF_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype33 (v: ANY): INDEX_AS is
		require
			valid_type: yyis_type33 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type33 (v: ANY): BOOLEAN is
		local
			u: INDEX_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype34 (v: ANY): INSPECT_AS is
		require
			valid_type: yyis_type34 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type34 (v: ANY): BOOLEAN is
		local
			u: INSPECT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype35 (v: ANY): INSTR_CALL_AS is
		require
			valid_type: yyis_type35 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type35 (v: ANY): BOOLEAN is
		local
			u: INSTR_CALL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype36 (v: ANY): INSTRUCTION_AS is
		require
			valid_type: yyis_type36 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type36 (v: ANY): BOOLEAN is
		local
			u: INSTRUCTION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype37 (v: ANY): INTEGER_CONSTANT is
		require
			valid_type: yyis_type37 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type37 (v: ANY): BOOLEAN is
		local
			u: INTEGER_CONSTANT
		do
			u ?= v
			Result := (u = v)
		end

	yytype38 (v: ANY): INTERNAL_AS is
		require
			valid_type: yyis_type38 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type38 (v: ANY): BOOLEAN is
		local
			u: INTERNAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype39 (v: ANY): INTERVAL_AS is
		require
			valid_type: yyis_type39 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type39 (v: ANY): BOOLEAN is
		local
			u: INTERVAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype40 (v: ANY): INVARIANT_AS is
		require
			valid_type: yyis_type40 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type40 (v: ANY): BOOLEAN is
		local
			u: INVARIANT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype41 (v: ANY): LOOP_AS is
		require
			valid_type: yyis_type41 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type41 (v: ANY): BOOLEAN is
		local
			u: LOOP_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype42 (v: ANY): NESTED_AS is
		require
			valid_type: yyis_type42 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type42 (v: ANY): BOOLEAN is
		local
			u: NESTED_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype43 (v: ANY): NESTED_EXPR_AS is
		require
			valid_type: yyis_type43 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type43 (v: ANY): BOOLEAN is
		local
			u: NESTED_EXPR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype44 (v: ANY): OPERAND_AS is
		require
			valid_type: yyis_type44 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type44 (v: ANY): BOOLEAN is
		local
			u: OPERAND_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype45 (v: ANY): PARENT_AS is
		require
			valid_type: yyis_type45 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type45 (v: ANY): BOOLEAN is
		local
			u: PARENT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype46 (v: ANY): PRECURSOR_AS is
		require
			valid_type: yyis_type46 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type46 (v: ANY): BOOLEAN is
		local
			u: PRECURSOR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype47 (v: ANY): STATIC_ACCESS_AS is
		require
			valid_type: yyis_type47 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type47 (v: ANY): BOOLEAN is
		local
			u: STATIC_ACCESS_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype48 (v: ANY): REAL_AS is
		require
			valid_type: yyis_type48 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type48 (v: ANY): BOOLEAN is
		local
			u: REAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype49 (v: ANY): RENAME_AS is
		require
			valid_type: yyis_type49 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type49 (v: ANY): BOOLEAN is
		local
			u: RENAME_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype50 (v: ANY): REQUIRE_AS is
		require
			valid_type: yyis_type50 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type50 (v: ANY): BOOLEAN is
		local
			u: REQUIRE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype51 (v: ANY): RETRY_AS is
		require
			valid_type: yyis_type51 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type51 (v: ANY): BOOLEAN is
		local
			u: RETRY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype52 (v: ANY): REVERSE_AS is
		require
			valid_type: yyis_type52 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type52 (v: ANY): BOOLEAN is
		local
			u: REVERSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype53 (v: ANY): ROUT_BODY_AS is
		require
			valid_type: yyis_type53 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type53 (v: ANY): BOOLEAN is
		local
			u: ROUT_BODY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype54 (v: ANY): ROUTINE_AS is
		require
			valid_type: yyis_type54 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type54 (v: ANY): BOOLEAN is
		local
			u: ROUTINE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype55 (v: ANY): ROUTINE_CREATION_AS is
		require
			valid_type: yyis_type55 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type55 (v: ANY): BOOLEAN is
		local
			u: ROUTINE_CREATION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype56 (v: ANY): STRING_AS is
		require
			valid_type: yyis_type56 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type56 (v: ANY): BOOLEAN is
		local
			u: STRING_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype57 (v: ANY): TAGGED_AS is
		require
			valid_type: yyis_type57 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type57 (v: ANY): BOOLEAN is
		local
			u: TAGGED_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype58 (v: ANY): TUPLE_AS is
		require
			valid_type: yyis_type58 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type58 (v: ANY): BOOLEAN is
		local
			u: TUPLE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype59 (v: ANY): TYPE is
		require
			valid_type: yyis_type59 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type59 (v: ANY): BOOLEAN is
		local
			u: TYPE
		do
			u ?= v
			Result := (u = v)
		end

	yytype60 (v: ANY): TYPE_DEC_AS is
		require
			valid_type: yyis_type60 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type60 (v: ANY): BOOLEAN is
		local
			u: TYPE_DEC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype61 (v: ANY): VARIANT_AS is
		require
			valid_type: yyis_type61 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type61 (v: ANY): BOOLEAN is
		local
			u: VARIANT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype62 (v: ANY): EIFFEL_LIST [ATOMIC_AS] is
		require
			valid_type: yyis_type62 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type62 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ATOMIC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype63 (v: ANY): EIFFEL_LIST [CASE_AS] is
		require
			valid_type: yyis_type63 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type63 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CASE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype64 (v: ANY): EIFFEL_LIST [CONVERT_FEAT_AS] is
		require
			valid_type: yyis_type64 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type64 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype65 (v: ANY): EIFFEL_LIST [CREATE_AS] is
		require
			valid_type: yyis_type65 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type65 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CREATE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype66 (v: ANY): EIFFEL_LIST [ELSIF_AS] is
		require
			valid_type: yyis_type66 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type66 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ELSIF_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype67 (v: ANY): EIFFEL_LIST [EXPORT_ITEM_AS] is
		require
			valid_type: yyis_type67 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type67 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype68 (v: ANY): EIFFEL_LIST [EXPR_AS] is
		require
			valid_type: yyis_type68 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type68 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXPR_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype69 (v: ANY): EIFFEL_LIST [FEATURE_AS] is
		require
			valid_type: yyis_type69 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type69 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype70 (v: ANY): EIFFEL_LIST [FEATURE_CLAUSE_AS] is
		require
			valid_type: yyis_type70 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type70 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype72 (v: ANY): EIFFEL_LIST [FEATURE_NAME] is
		require
			valid_type: yyis_type72 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type72 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_NAME]
		do
			u ?= v
			Result := (u = v)
		end

	yytype73 (v: ANY): EIFFEL_LIST [FORMAL_DEC_AS] is
		require
			valid_type: yyis_type73 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type73 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FORMAL_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype74 (v: ANY): EIFFEL_LIST [ID_AS] is
		require
			valid_type: yyis_type74 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type74 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ID_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype76 (v: ANY): ARRAYED_LIST [INTEGER] is
		require
			valid_type: yyis_type76 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type76 (v: ANY): BOOLEAN is
		local
			u: ARRAYED_LIST [INTEGER]
		do
			u ?= v
			Result := (u = v)
		end

	yytype77 (v: ANY): INDEXING_CLAUSE_AS is
		require
			valid_type: yyis_type77 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type77 (v: ANY): BOOLEAN is
		local
			u: INDEXING_CLAUSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype78 (v: ANY): EIFFEL_LIST [INSTRUCTION_AS] is
		require
			valid_type: yyis_type78 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type78 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INSTRUCTION_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype79 (v: ANY): EIFFEL_LIST [INTERVAL_AS] is
		require
			valid_type: yyis_type79 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type79 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INTERVAL_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype80 (v: ANY): EIFFEL_LIST [OPERAND_AS] is
		require
			valid_type: yyis_type80 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type80 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [OPERAND_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype81 (v: ANY): EIFFEL_LIST [PARENT_AS] is
		require
			valid_type: yyis_type81 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type81 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [PARENT_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype82 (v: ANY): EIFFEL_LIST [RENAME_AS] is
		require
			valid_type: yyis_type82 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type82 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [RENAME_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype83 (v: ANY): EIFFEL_LIST [STRING_AS] is
		require
			valid_type: yyis_type83 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type83 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [STRING_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype84 (v: ANY): EIFFEL_LIST [TAGGED_AS] is
		require
			valid_type: yyis_type84 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type84 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TAGGED_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype85 (v: ANY): EIFFEL_LIST [TYPE] is
		require
			valid_type: yyis_type85 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type85 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE]
		do
			u ?= v
			Result := (u = v)
		end

	yytype86 (v: ANY): EIFFEL_LIST [TYPE_DEC_AS] is
		require
			valid_type: yyis_type86 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type86 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype88 (v: ANY): PAIR [ID_AS, CLICK_AST] is
		require
			valid_type: yyis_type88 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type88 (v: ANY): BOOLEAN is
		local
			u: PAIR [ID_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype89 (v: ANY): PAIR [FEATURE_NAME, CLICK_AST] is
		require
			valid_type: yyis_type89 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type89 (v: ANY): BOOLEAN is
		local
			u: PAIR [FEATURE_NAME, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype90 (v: ANY): PAIR [STRING_AS, CLICK_AST] is
		require
			valid_type: yyis_type90 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type90 (v: ANY): BOOLEAN is
		local
			u: PAIR [STRING_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype91 (v: ANY): PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST] is
		require
			valid_type: yyis_type91 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type91 (v: ANY): BOOLEAN is
		local
			u: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype92 (v: ANY): PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]] is
		require
			valid_type: yyis_type92 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type92 (v: ANY): BOOLEAN is
		local
			u: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
			u ?= v
			Result := (u = v)
		end

	yytype93 (v: ANY): TOKEN_LOCATION is
		require
			valid_type: yyis_type93 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type93 (v: ANY): BOOLEAN is
		local
			u: TOKEN_LOCATION
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 805
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 127
			-- Number of tokens

	yyLast: INTEGER is 1926
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
