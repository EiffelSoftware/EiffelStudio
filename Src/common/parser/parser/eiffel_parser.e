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
--|#line 179 "eiffel.y"
	yy_do_action_1
when 2 then
--|#line 186 "eiffel.y"
	yy_do_action_2
when 3 then
--|#line 195 "eiffel.y"
	yy_do_action_3
when 4 then
--|#line 238 "eiffel.y"
	yy_do_action_4
when 5 then
--|#line 247 "eiffel.y"
	yy_do_action_5
when 6 then
--|#line 249 "eiffel.y"
	yy_do_action_6
when 7 then
--|#line 251 "eiffel.y"
	yy_do_action_7
when 8 then
--|#line 253 "eiffel.y"
	yy_do_action_8
when 9 then
--|#line 255 "eiffel.y"
	yy_do_action_9
when 10 then
--|#line 257 "eiffel.y"
	yy_do_action_10
when 11 then
--|#line 259 "eiffel.y"
	yy_do_action_11
when 12 then
--|#line 261 "eiffel.y"
	yy_do_action_12
when 13 then
--|#line 263 "eiffel.y"
	yy_do_action_13
when 14 then
--|#line 265 "eiffel.y"
	yy_do_action_14
when 15 then
--|#line 267 "eiffel.y"
	yy_do_action_15
when 16 then
--|#line 269 "eiffel.y"
	yy_do_action_16
when 17 then
--|#line 273 "eiffel.y"
	yy_do_action_17
when 18 then
--|#line 277 "eiffel.y"
	yy_do_action_18
when 19 then
--|#line 281 "eiffel.y"
	yy_do_action_19
when 20 then
--|#line 285 "eiffel.y"
	yy_do_action_20
when 21 then
--|#line 289 "eiffel.y"
	yy_do_action_21
when 22 then
--|#line 293 "eiffel.y"
	yy_do_action_22
when 23 then
--|#line 297 "eiffel.y"
	yy_do_action_23
when 24 then
--|#line 301 "eiffel.y"
	yy_do_action_24
when 25 then
--|#line 305 "eiffel.y"
	yy_do_action_25
when 26 then
--|#line 309 "eiffel.y"
	yy_do_action_26
when 27 then
--|#line 313 "eiffel.y"
	yy_do_action_27
when 28 then
--|#line 317 "eiffel.y"
	yy_do_action_28
when 29 then
--|#line 324 "eiffel.y"
	yy_do_action_29
when 30 then
--|#line 326 "eiffel.y"
	yy_do_action_30
when 31 then
--|#line 328 "eiffel.y"
	yy_do_action_31
when 32 then
--|#line 332 "eiffel.y"
	yy_do_action_32
when 33 then
--|#line 334 "eiffel.y"
	yy_do_action_33
when 34 then
--|#line 336 "eiffel.y"
	yy_do_action_34
when 35 then
--|#line 340 "eiffel.y"
	yy_do_action_35
when 36 then
--|#line 342 "eiffel.y"
	yy_do_action_36
when 37 then
--|#line 344 "eiffel.y"
	yy_do_action_37
when 38 then
--|#line 348 "eiffel.y"
	yy_do_action_38
when 39 then
--|#line 353 "eiffel.y"
	yy_do_action_39
when 40 then
--|#line 360 "eiffel.y"
	yy_do_action_40
when 41 then
--|#line 364 "eiffel.y"
	yy_do_action_41
when 42 then
--|#line 366 "eiffel.y"
	yy_do_action_42
when 43 then
--|#line 370 "eiffel.y"
	yy_do_action_43
when 44 then
--|#line 375 "eiffel.y"
	yy_do_action_44
when 45 then
--|#line 380 "eiffel.y"
	yy_do_action_45
when 46 then
--|#line 387 "eiffel.y"
	yy_do_action_46
when 47 then
--|#line 389 "eiffel.y"
	yy_do_action_47
when 48 then
--|#line 391 "eiffel.y"
	yy_do_action_48
when 49 then
--|#line 395 "eiffel.y"
	yy_do_action_49
when 50 then
--|#line 405 "eiffel.y"
	yy_do_action_50
when 51 then
--|#line 411 "eiffel.y"
	yy_do_action_51
when 52 then
--|#line 418 "eiffel.y"
	yy_do_action_52
when 53 then
--|#line 424 "eiffel.y"
	yy_do_action_53
when 54 then
--|#line 432 "eiffel.y"
	yy_do_action_54
when 55 then
--|#line 436 "eiffel.y"
	yy_do_action_55
when 56 then
--|#line 447 "eiffel.y"
	yy_do_action_56
when 57 then
--|#line 451 "eiffel.y"
	yy_do_action_57
when 58 then
--|#line 466 "eiffel.y"
	yy_do_action_58
when 59 then
--|#line 468 "eiffel.y"
	yy_do_action_59
when 60 then
--|#line 475 "eiffel.y"
	yy_do_action_60
when 61 then
--|#line 477 "eiffel.y"
	yy_do_action_61
when 62 then
--|#line 486 "eiffel.y"
	yy_do_action_62
when 63 then
--|#line 491 "eiffel.y"
	yy_do_action_63
when 64 then
--|#line 498 "eiffel.y"
	yy_do_action_64
when 65 then
--|#line 500 "eiffel.y"
	yy_do_action_65
when 66 then
--|#line 504 "eiffel.y"
	yy_do_action_66
when 67 then
--|#line 504 "eiffel.y"
	yy_do_action_67
when 68 then
--|#line 513 "eiffel.y"
	yy_do_action_68
when 69 then
--|#line 515 "eiffel.y"
	yy_do_action_69
when 70 then
--|#line 519 "eiffel.y"
	yy_do_action_70
when 71 then
--|#line 524 "eiffel.y"
	yy_do_action_71
when 72 then
--|#line 528 "eiffel.y"
	yy_do_action_72
when 73 then
--|#line 534 "eiffel.y"
	yy_do_action_73
when 74 then
--|#line 542 "eiffel.y"
	yy_do_action_74
when 75 then
--|#line 547 "eiffel.y"
	yy_do_action_75
when 76 then
--|#line 554 "eiffel.y"
	yy_do_action_76
when 77 then
--|#line 555 "eiffel.y"
	yy_do_action_77
when 78 then
--|#line 558 "eiffel.y"
	yy_do_action_78
when 79 then
--|#line 571 "eiffel.y"
	yy_do_action_79
when 80 then
--|#line 573 "eiffel.y"
	yy_do_action_80
when 81 then
--|#line 580 "eiffel.y"
	yy_do_action_81
when 82 then
--|#line 584 "eiffel.y"
	yy_do_action_82
when 83 then
--|#line 586 "eiffel.y"
	yy_do_action_83
when 84 then
--|#line 590 "eiffel.y"
	yy_do_action_84
when 85 then
--|#line 592 "eiffel.y"
	yy_do_action_85
when 86 then
--|#line 594 "eiffel.y"
	yy_do_action_86
when 87 then
--|#line 598 "eiffel.y"
	yy_do_action_87
when 88 then
--|#line 603 "eiffel.y"
	yy_do_action_88
when 89 then
--|#line 607 "eiffel.y"
	yy_do_action_89
when 90 then
--|#line 611 "eiffel.y"
	yy_do_action_90
when 91 then
--|#line 613 "eiffel.y"
	yy_do_action_91
when 92 then
--|#line 617 "eiffel.y"
	yy_do_action_92
when 93 then
--|#line 622 "eiffel.y"
	yy_do_action_93
when 94 then
--|#line 627 "eiffel.y"
	yy_do_action_94
when 95 then
--|#line 638 "eiffel.y"
	yy_do_action_95
when 96 then
--|#line 640 "eiffel.y"
	yy_do_action_96
when 97 then
--|#line 642 "eiffel.y"
	yy_do_action_97
when 98 then
--|#line 646 "eiffel.y"
	yy_do_action_98
when 99 then
--|#line 651 "eiffel.y"
	yy_do_action_99
when 100 then
--|#line 658 "eiffel.y"
	yy_do_action_100
when 101 then
--|#line 663 "eiffel.y"
	yy_do_action_101
when 102 then
--|#line 671 "eiffel.y"
	yy_do_action_102
when 103 then
--|#line 676 "eiffel.y"
	yy_do_action_103
when 104 then
--|#line 681 "eiffel.y"
	yy_do_action_104
when 105 then
--|#line 686 "eiffel.y"
	yy_do_action_105
when 106 then
--|#line 691 "eiffel.y"
	yy_do_action_106
when 107 then
--|#line 696 "eiffel.y"
	yy_do_action_107
when 108 then
--|#line 701 "eiffel.y"
	yy_do_action_108
when 109 then
--|#line 709 "eiffel.y"
	yy_do_action_109
when 110 then
--|#line 711 "eiffel.y"
	yy_do_action_110
when 111 then
--|#line 715 "eiffel.y"
	yy_do_action_111
when 112 then
--|#line 720 "eiffel.y"
	yy_do_action_112
when 113 then
--|#line 727 "eiffel.y"
	yy_do_action_113
when 114 then
--|#line 731 "eiffel.y"
	yy_do_action_114
when 115 then
--|#line 733 "eiffel.y"
	yy_do_action_115
when 116 then
--|#line 737 "eiffel.y"
	yy_do_action_116
when 117 then
--|#line 739 "eiffel.y"
	yy_do_action_117
when 118 then
--|#line 743 "eiffel.y"
	yy_do_action_118
when 119 then
--|#line 748 "eiffel.y"
	yy_do_action_119
when 120 then
--|#line 755 "eiffel.y"
	yy_do_action_120
when 121 then
--|#line 759 "eiffel.y"
	yy_do_action_121
when 122 then
--|#line 761 "eiffel.y"
	yy_do_action_122
when 123 then
--|#line 765 "eiffel.y"
	yy_do_action_123
when 124 then
--|#line 767 "eiffel.y"
	yy_do_action_124
when 125 then
--|#line 773 "eiffel.y"
	yy_do_action_125
when 126 then
--|#line 778 "eiffel.y"
	yy_do_action_126
when 127 then
--|#line 786 "eiffel.y"
	yy_do_action_127
when 128 then
--|#line 792 "eiffel.y"
	yy_do_action_128
when 129 then
--|#line 800 "eiffel.y"
	yy_do_action_129
when 130 then
--|#line 805 "eiffel.y"
	yy_do_action_130
when 131 then
--|#line 812 "eiffel.y"
	yy_do_action_131
when 132 then
--|#line 814 "eiffel.y"
	yy_do_action_132
when 133 then
--|#line 818 "eiffel.y"
	yy_do_action_133
when 134 then
--|#line 820 "eiffel.y"
	yy_do_action_134
when 135 then
--|#line 824 "eiffel.y"
	yy_do_action_135
when 136 then
--|#line 826 "eiffel.y"
	yy_do_action_136
when 137 then
--|#line 830 "eiffel.y"
	yy_do_action_137
when 138 then
--|#line 832 "eiffel.y"
	yy_do_action_138
when 139 then
--|#line 836 "eiffel.y"
	yy_do_action_139
when 140 then
--|#line 838 "eiffel.y"
	yy_do_action_140
when 141 then
--|#line 842 "eiffel.y"
	yy_do_action_141
when 142 then
--|#line 844 "eiffel.y"
	yy_do_action_142
when 143 then
--|#line 852 "eiffel.y"
	yy_do_action_143
when 144 then
--|#line 854 "eiffel.y"
	yy_do_action_144
when 145 then
--|#line 858 "eiffel.y"
	yy_do_action_145
when 146 then
--|#line 860 "eiffel.y"
	yy_do_action_146
when 147 then
--|#line 864 "eiffel.y"
	yy_do_action_147
when 148 then
--|#line 869 "eiffel.y"
	yy_do_action_148
when 149 then
--|#line 876 "eiffel.y"
	yy_do_action_149
when 150 then
--|#line 880 "eiffel.y"
	yy_do_action_150
when 151 then
--|#line 881 "eiffel.y"
	yy_do_action_151
when 152 then
--|#line 890 "eiffel.y"
	yy_do_action_152
when 153 then
--|#line 892 "eiffel.y"
	yy_do_action_153
when 154 then
--|#line 896 "eiffel.y"
	yy_do_action_154
when 155 then
--|#line 901 "eiffel.y"
	yy_do_action_155
when 156 then
--|#line 908 "eiffel.y"
	yy_do_action_156
when 157 then
--|#line 912 "eiffel.y"
	yy_do_action_157
when 158 then
--|#line 918 "eiffel.y"
	yy_do_action_158
when 159 then
--|#line 926 "eiffel.y"
	yy_do_action_159
when 160 then
--|#line 928 "eiffel.y"
	yy_do_action_160
when 161 then
--|#line 932 "eiffel.y"
	yy_do_action_161
when 162 then
--|#line 934 "eiffel.y"
	yy_do_action_162
when 163 then
--|#line 938 "eiffel.y"
	yy_do_action_163
when 164 then
--|#line 938 "eiffel.y"
	yy_do_action_164
when 165 then
--|#line 950 "eiffel.y"
	yy_do_action_165
when 166 then
--|#line 952 "eiffel.y"
	yy_do_action_166
when 167 then
--|#line 954 "eiffel.y"
	yy_do_action_167
when 168 then
--|#line 958 "eiffel.y"
	yy_do_action_168
when 169 then
--|#line 962 "eiffel.y"
	yy_do_action_169
when 170 then
--|#line 967 "eiffel.y"
	yy_do_action_170
when 171 then
--|#line 969 "eiffel.y"
	yy_do_action_171
when 172 then
--|#line 973 "eiffel.y"
	yy_do_action_172
when 173 then
--|#line 975 "eiffel.y"
	yy_do_action_173
when 174 then
--|#line 979 "eiffel.y"
	yy_do_action_174
when 175 then
--|#line 981 "eiffel.y"
	yy_do_action_175
when 176 then
--|#line 985 "eiffel.y"
	yy_do_action_176
when 177 then
--|#line 987 "eiffel.y"
	yy_do_action_177
when 178 then
--|#line 991 "eiffel.y"
	yy_do_action_178
when 179 then
--|#line 996 "eiffel.y"
	yy_do_action_179
when 180 then
--|#line 1003 "eiffel.y"
	yy_do_action_180
when 181 then
--|#line 1007 "eiffel.y"
	yy_do_action_181
when 182 then
--|#line 1008 "eiffel.y"
	yy_do_action_182
when 183 then
--|#line 1011 "eiffel.y"
	yy_do_action_183
when 184 then
--|#line 1013 "eiffel.y"
	yy_do_action_184
when 185 then
--|#line 1015 "eiffel.y"
	yy_do_action_185
when 186 then
--|#line 1017 "eiffel.y"
	yy_do_action_186
when 187 then
--|#line 1019 "eiffel.y"
	yy_do_action_187
when 188 then
--|#line 1021 "eiffel.y"
	yy_do_action_188
when 189 then
--|#line 1023 "eiffel.y"
	yy_do_action_189
when 190 then
--|#line 1025 "eiffel.y"
	yy_do_action_190
when 191 then
--|#line 1027 "eiffel.y"
	yy_do_action_191
when 192 then
--|#line 1029 "eiffel.y"
	yy_do_action_192
when 193 then
--|#line 1033 "eiffel.y"
	yy_do_action_193
when 194 then
--|#line 1035 "eiffel.y"
	yy_do_action_194
when 195 then
--|#line 1035 "eiffel.y"
	yy_do_action_195
when 196 then
--|#line 1042 "eiffel.y"
	yy_do_action_196
when 197 then
--|#line 1042 "eiffel.y"
	yy_do_action_197
when 198 then
--|#line 1051 "eiffel.y"
	yy_do_action_198
when 199 then
--|#line 1053 "eiffel.y"
	yy_do_action_199
when 200 then
--|#line 1053 "eiffel.y"
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
--|#line 1060 "eiffel.y"
	yy_do_action_201
when 202 then
--|#line 1060 "eiffel.y"
	yy_do_action_202
when 203 then
--|#line 1069 "eiffel.y"
	yy_do_action_203
when 204 then
--|#line 1071 "eiffel.y"
	yy_do_action_204
when 205 then
--|#line 1080 "eiffel.y"
	yy_do_action_205
when 206 then
--|#line 1085 "eiffel.y"
	yy_do_action_206
when 207 then
--|#line 1092 "eiffel.y"
	yy_do_action_207
when 208 then
--|#line 1096 "eiffel.y"
	yy_do_action_208
when 209 then
--|#line 1098 "eiffel.y"
	yy_do_action_209
when 210 then
--|#line 1100 "eiffel.y"
	yy_do_action_210
when 211 then
--|#line 1108 "eiffel.y"
	yy_do_action_211
when 212 then
--|#line 1110 "eiffel.y"
	yy_do_action_212
when 213 then
--|#line 1114 "eiffel.y"
	yy_do_action_213
when 214 then
--|#line 1116 "eiffel.y"
	yy_do_action_214
when 215 then
--|#line 1118 "eiffel.y"
	yy_do_action_215
when 216 then
--|#line 1120 "eiffel.y"
	yy_do_action_216
when 217 then
--|#line 1122 "eiffel.y"
	yy_do_action_217
when 218 then
--|#line 1124 "eiffel.y"
	yy_do_action_218
when 219 then
--|#line 1128 "eiffel.y"
	yy_do_action_219
when 220 then
--|#line 1130 "eiffel.y"
	yy_do_action_220
when 221 then
--|#line 1132 "eiffel.y"
	yy_do_action_221
when 222 then
--|#line 1134 "eiffel.y"
	yy_do_action_222
when 223 then
--|#line 1136 "eiffel.y"
	yy_do_action_223
when 224 then
--|#line 1138 "eiffel.y"
	yy_do_action_224
when 225 then
--|#line 1140 "eiffel.y"
	yy_do_action_225
when 226 then
--|#line 1142 "eiffel.y"
	yy_do_action_226
when 227 then
--|#line 1144 "eiffel.y"
	yy_do_action_227
when 228 then
--|#line 1146 "eiffel.y"
	yy_do_action_228
when 229 then
--|#line 1148 "eiffel.y"
	yy_do_action_229
when 230 then
--|#line 1150 "eiffel.y"
	yy_do_action_230
when 231 then
--|#line 1154 "eiffel.y"
	yy_do_action_231
when 232 then
--|#line 1156 "eiffel.y"
	yy_do_action_232
when 233 then
--|#line 1158 "eiffel.y"
	yy_do_action_233
when 234 then
--|#line 1162 "eiffel.y"
	yy_do_action_234
when 235 then
--|#line 1167 "eiffel.y"
	yy_do_action_235
when 236 then
--|#line 1178 "eiffel.y"
	yy_do_action_236
when 237 then
--|#line 1184 "eiffel.y"
	yy_do_action_237
when 238 then
--|#line 1192 "eiffel.y"
	yy_do_action_238
when 239 then
--|#line 1194 "eiffel.y"
	yy_do_action_239
when 240 then
--|#line 1198 "eiffel.y"
	yy_do_action_240
when 241 then
--|#line 1203 "eiffel.y"
	yy_do_action_241
when 242 then
--|#line 1210 "eiffel.y"
	yy_do_action_242
when 243 then
--|#line 1210 "eiffel.y"
	yy_do_action_243
when 244 then
--|#line 1220 "eiffel.y"
	yy_do_action_244
when 245 then
--|#line 1222 "eiffel.y"
	yy_do_action_245
when 246 then
--|#line 1230 "eiffel.y"
	yy_do_action_246
when 247 then
--|#line 1232 "eiffel.y"
	yy_do_action_247
when 248 then
--|#line 1240 "eiffel.y"
	yy_do_action_248
when 249 then
--|#line 1246 "eiffel.y"
	yy_do_action_249
when 250 then
--|#line 1248 "eiffel.y"
	yy_do_action_250
when 251 then
--|#line 1252 "eiffel.y"
	yy_do_action_251
when 252 then
--|#line 1257 "eiffel.y"
	yy_do_action_252
when 253 then
--|#line 1264 "eiffel.y"
	yy_do_action_253
when 254 then
--|#line 1268 "eiffel.y"
	yy_do_action_254
when 255 then
--|#line 1270 "eiffel.y"
	yy_do_action_255
when 256 then
--|#line 1274 "eiffel.y"
	yy_do_action_256
when 257 then
--|#line 1280 "eiffel.y"
	yy_do_action_257
when 258 then
--|#line 1282 "eiffel.y"
	yy_do_action_258
when 259 then
--|#line 1286 "eiffel.y"
	yy_do_action_259
when 260 then
--|#line 1291 "eiffel.y"
	yy_do_action_260
when 261 then
--|#line 1298 "eiffel.y"
	yy_do_action_261
when 262 then
--|#line 1302 "eiffel.y"
	yy_do_action_262
when 263 then
--|#line 1307 "eiffel.y"
	yy_do_action_263
when 264 then
--|#line 1314 "eiffel.y"
	yy_do_action_264
when 265 then
--|#line 1316 "eiffel.y"
	yy_do_action_265
when 266 then
--|#line 1318 "eiffel.y"
	yy_do_action_266
when 267 then
--|#line 1320 "eiffel.y"
	yy_do_action_267
when 268 then
--|#line 1322 "eiffel.y"
	yy_do_action_268
when 269 then
--|#line 1324 "eiffel.y"
	yy_do_action_269
when 270 then
--|#line 1326 "eiffel.y"
	yy_do_action_270
when 271 then
--|#line 1328 "eiffel.y"
	yy_do_action_271
when 272 then
--|#line 1330 "eiffel.y"
	yy_do_action_272
when 273 then
--|#line 1332 "eiffel.y"
	yy_do_action_273
when 274 then
--|#line 1334 "eiffel.y"
	yy_do_action_274
when 275 then
--|#line 1336 "eiffel.y"
	yy_do_action_275
when 276 then
--|#line 1338 "eiffel.y"
	yy_do_action_276
when 277 then
--|#line 1340 "eiffel.y"
	yy_do_action_277
when 278 then
--|#line 1342 "eiffel.y"
	yy_do_action_278
when 279 then
--|#line 1344 "eiffel.y"
	yy_do_action_279
when 280 then
--|#line 1346 "eiffel.y"
	yy_do_action_280
when 281 then
--|#line 1348 "eiffel.y"
	yy_do_action_281
when 282 then
--|#line 1353 "eiffel.y"
	yy_do_action_282
when 283 then
--|#line 1355 "eiffel.y"
	yy_do_action_283
when 284 then
--|#line 1364 "eiffel.y"
	yy_do_action_284
when 285 then
--|#line 1370 "eiffel.y"
	yy_do_action_285
when 286 then
--|#line 1372 "eiffel.y"
	yy_do_action_286
when 287 then
--|#line 1376 "eiffel.y"
	yy_do_action_287
when 288 then
--|#line 1378 "eiffel.y"
	yy_do_action_288
when 289 then
--|#line 1378 "eiffel.y"
	yy_do_action_289
when 290 then
--|#line 1388 "eiffel.y"
	yy_do_action_290
when 291 then
--|#line 1390 "eiffel.y"
	yy_do_action_291
when 292 then
--|#line 1392 "eiffel.y"
	yy_do_action_292
when 293 then
--|#line 1396 "eiffel.y"
	yy_do_action_293
when 294 then
--|#line 1402 "eiffel.y"
	yy_do_action_294
when 295 then
--|#line 1404 "eiffel.y"
	yy_do_action_295
when 296 then
--|#line 1406 "eiffel.y"
	yy_do_action_296
when 297 then
--|#line 1410 "eiffel.y"
	yy_do_action_297
when 298 then
--|#line 1415 "eiffel.y"
	yy_do_action_298
when 299 then
--|#line 1422 "eiffel.y"
	yy_do_action_299
when 300 then
--|#line 1426 "eiffel.y"
	yy_do_action_300
when 301 then
--|#line 1428 "eiffel.y"
	yy_do_action_301
when 302 then
--|#line 1437 "eiffel.y"
	yy_do_action_302
when 303 then
--|#line 1439 "eiffel.y"
	yy_do_action_303
when 304 then
--|#line 1443 "eiffel.y"
	yy_do_action_304
when 305 then
--|#line 1445 "eiffel.y"
	yy_do_action_305
when 306 then
--|#line 1449 "eiffel.y"
	yy_do_action_306
when 307 then
--|#line 1451 "eiffel.y"
	yy_do_action_307
when 308 then
--|#line 1455 "eiffel.y"
	yy_do_action_308
when 309 then
--|#line 1460 "eiffel.y"
	yy_do_action_309
when 310 then
--|#line 1467 "eiffel.y"
	yy_do_action_310
when 311 then
--|#line 1473 "eiffel.y"
	yy_do_action_311
when 312 then
--|#line 1478 "eiffel.y"
	yy_do_action_312
when 313 then
--|#line 1483 "eiffel.y"
	yy_do_action_313
when 314 then
--|#line 1493 "eiffel.y"
	yy_do_action_314
when 315 then
--|#line 1503 "eiffel.y"
	yy_do_action_315
when 316 then
--|#line 1515 "eiffel.y"
	yy_do_action_316
when 317 then
--|#line 1518 "eiffel.y"
	yy_do_action_317
when 318 then
--|#line 1520 "eiffel.y"
	yy_do_action_318
when 319 then
--|#line 1522 "eiffel.y"
	yy_do_action_319
when 320 then
--|#line 1524 "eiffel.y"
	yy_do_action_320
when 321 then
--|#line 1526 "eiffel.y"
	yy_do_action_321
when 322 then
--|#line 1528 "eiffel.y"
	yy_do_action_322
when 323 then
--|#line 1530 "eiffel.y"
	yy_do_action_323
when 324 then
--|#line 1539 "eiffel.y"
	yy_do_action_324
when 325 then
--|#line 1548 "eiffel.y"
	yy_do_action_325
when 326 then
--|#line 1558 "eiffel.y"
	yy_do_action_326
when 327 then
--|#line 1567 "eiffel.y"
	yy_do_action_327
when 328 then
--|#line 1576 "eiffel.y"
	yy_do_action_328
when 329 then
--|#line 1585 "eiffel.y"
	yy_do_action_329
when 330 then
--|#line 1596 "eiffel.y"
	yy_do_action_330
when 331 then
--|#line 1598 "eiffel.y"
	yy_do_action_331
when 332 then
--|#line 1602 "eiffel.y"
	yy_do_action_332
when 333 then
--|#line 1607 "eiffel.y"
	yy_do_action_333
when 334 then
--|#line 1614 "eiffel.y"
	yy_do_action_334
when 335 then
--|#line 1616 "eiffel.y"
	yy_do_action_335
when 336 then
--|#line 1618 "eiffel.y"
	yy_do_action_336
when 337 then
--|#line 1622 "eiffel.y"
	yy_do_action_337
when 338 then
--|#line 1631 "eiffel.y"
	yy_do_action_338
when 339 then
--|#line 1633 "eiffel.y"
	yy_do_action_339
when 340 then
--|#line 1637 "eiffel.y"
	yy_do_action_340
when 341 then
--|#line 1639 "eiffel.y"
	yy_do_action_341
when 342 then
--|#line 1650 "eiffel.y"
	yy_do_action_342
when 343 then
--|#line 1652 "eiffel.y"
	yy_do_action_343
when 344 then
--|#line 1656 "eiffel.y"
	yy_do_action_344
when 345 then
--|#line 1658 "eiffel.y"
	yy_do_action_345
when 346 then
--|#line 1662 "eiffel.y"
	yy_do_action_346
when 347 then
--|#line 1664 "eiffel.y"
	yy_do_action_347
when 348 then
--|#line 1672 "eiffel.y"
	yy_do_action_348
when 349 then
--|#line 1674 "eiffel.y"
	yy_do_action_349
when 350 then
--|#line 1676 "eiffel.y"
	yy_do_action_350
when 351 then
--|#line 1678 "eiffel.y"
	yy_do_action_351
when 352 then
--|#line 1680 "eiffel.y"
	yy_do_action_352
when 353 then
--|#line 1682 "eiffel.y"
	yy_do_action_353
when 354 then
--|#line 1684 "eiffel.y"
	yy_do_action_354
when 355 then
--|#line 1686 "eiffel.y"
	yy_do_action_355
when 356 then
--|#line 1688 "eiffel.y"
	yy_do_action_356
when 357 then
--|#line 1692 "eiffel.y"
	yy_do_action_357
when 358 then
--|#line 1700 "eiffel.y"
	yy_do_action_358
when 359 then
--|#line 1702 "eiffel.y"
	yy_do_action_359
when 360 then
--|#line 1704 "eiffel.y"
	yy_do_action_360
when 361 then
--|#line 1706 "eiffel.y"
	yy_do_action_361
when 362 then
--|#line 1708 "eiffel.y"
	yy_do_action_362
when 363 then
--|#line 1710 "eiffel.y"
	yy_do_action_363
when 364 then
--|#line 1712 "eiffel.y"
	yy_do_action_364
when 365 then
--|#line 1714 "eiffel.y"
	yy_do_action_365
when 366 then
--|#line 1716 "eiffel.y"
	yy_do_action_366
when 367 then
--|#line 1718 "eiffel.y"
	yy_do_action_367
when 368 then
--|#line 1720 "eiffel.y"
	yy_do_action_368
when 369 then
--|#line 1722 "eiffel.y"
	yy_do_action_369
when 370 then
--|#line 1724 "eiffel.y"
	yy_do_action_370
when 371 then
--|#line 1726 "eiffel.y"
	yy_do_action_371
when 372 then
--|#line 1728 "eiffel.y"
	yy_do_action_372
when 373 then
--|#line 1730 "eiffel.y"
	yy_do_action_373
when 374 then
--|#line 1732 "eiffel.y"
	yy_do_action_374
when 375 then
--|#line 1734 "eiffel.y"
	yy_do_action_375
when 376 then
--|#line 1736 "eiffel.y"
	yy_do_action_376
when 377 then
--|#line 1738 "eiffel.y"
	yy_do_action_377
when 378 then
--|#line 1740 "eiffel.y"
	yy_do_action_378
when 379 then
--|#line 1742 "eiffel.y"
	yy_do_action_379
when 380 then
--|#line 1744 "eiffel.y"
	yy_do_action_380
when 381 then
--|#line 1746 "eiffel.y"
	yy_do_action_381
when 382 then
--|#line 1748 "eiffel.y"
	yy_do_action_382
when 383 then
--|#line 1750 "eiffel.y"
	yy_do_action_383
when 384 then
--|#line 1752 "eiffel.y"
	yy_do_action_384
when 385 then
--|#line 1754 "eiffel.y"
	yy_do_action_385
when 386 then
--|#line 1756 "eiffel.y"
	yy_do_action_386
when 387 then
--|#line 1758 "eiffel.y"
	yy_do_action_387
when 388 then
--|#line 1760 "eiffel.y"
	yy_do_action_388
when 389 then
--|#line 1762 "eiffel.y"
	yy_do_action_389
when 390 then
--|#line 1764 "eiffel.y"
	yy_do_action_390
when 391 then
--|#line 1766 "eiffel.y"
	yy_do_action_391
when 392 then
--|#line 1768 "eiffel.y"
	yy_do_action_392
when 393 then
--|#line 1770 "eiffel.y"
	yy_do_action_393
when 394 then
--|#line 1774 "eiffel.y"
	yy_do_action_394
when 395 then
--|#line 1782 "eiffel.y"
	yy_do_action_395
when 396 then
--|#line 1784 "eiffel.y"
	yy_do_action_396
when 397 then
--|#line 1786 "eiffel.y"
	yy_do_action_397
when 398 then
--|#line 1788 "eiffel.y"
	yy_do_action_398
when 399 then
--|#line 1790 "eiffel.y"
	yy_do_action_399
when 400 then
--|#line 1792 "eiffel.y"
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
--|#line 1794 "eiffel.y"
	yy_do_action_401
when 402 then
--|#line 1796 "eiffel.y"
	yy_do_action_402
when 403 then
--|#line 1798 "eiffel.y"
	yy_do_action_403
when 404 then
--|#line 1800 "eiffel.y"
	yy_do_action_404
when 405 then
--|#line 1802 "eiffel.y"
	yy_do_action_405
when 406 then
--|#line 1804 "eiffel.y"
	yy_do_action_406
when 407 then
--|#line 1808 "eiffel.y"
	yy_do_action_407
when 408 then
--|#line 1812 "eiffel.y"
	yy_do_action_408
when 409 then
--|#line 1816 "eiffel.y"
	yy_do_action_409
when 410 then
--|#line 1820 "eiffel.y"
	yy_do_action_410
when 411 then
--|#line 1824 "eiffel.y"
	yy_do_action_411
when 412 then
--|#line 1828 "eiffel.y"
	yy_do_action_412
when 413 then
--|#line 1830 "eiffel.y"
	yy_do_action_413
when 414 then
--|#line 1832 "eiffel.y"
	yy_do_action_414
when 415 then
--|#line 1834 "eiffel.y"
	yy_do_action_415
when 416 then
--|#line 1836 "eiffel.y"
	yy_do_action_416
when 417 then
--|#line 1838 "eiffel.y"
	yy_do_action_417
when 418 then
--|#line 1840 "eiffel.y"
	yy_do_action_418
when 419 then
--|#line 1842 "eiffel.y"
	yy_do_action_419
when 420 then
--|#line 1844 "eiffel.y"
	yy_do_action_420
when 421 then
--|#line 1846 "eiffel.y"
	yy_do_action_421
when 422 then
--|#line 1848 "eiffel.y"
	yy_do_action_422
when 423 then
--|#line 1850 "eiffel.y"
	yy_do_action_423
when 424 then
--|#line 1852 "eiffel.y"
	yy_do_action_424
when 425 then
--|#line 1854 "eiffel.y"
	yy_do_action_425
when 426 then
--|#line 1856 "eiffel.y"
	yy_do_action_426
when 427 then
--|#line 1860 "eiffel.y"
	yy_do_action_427
when 428 then
--|#line 1864 "eiffel.y"
	yy_do_action_428
when 429 then
--|#line 1871 "eiffel.y"
	yy_do_action_429
when 430 then
--|#line 1879 "eiffel.y"
	yy_do_action_430
when 431 then
--|#line 1881 "eiffel.y"
	yy_do_action_431
when 432 then
--|#line 1885 "eiffel.y"
	yy_do_action_432
when 433 then
--|#line 1887 "eiffel.y"
	yy_do_action_433
when 434 then
--|#line 1891 "eiffel.y"
	yy_do_action_434
when 435 then
--|#line 1904 "eiffel.y"
	yy_do_action_435
when 436 then
--|#line 1908 "eiffel.y"
	yy_do_action_436
when 437 then
--|#line 1910 "eiffel.y"
	yy_do_action_437
when 438 then
--|#line 1912 "eiffel.y"
	yy_do_action_438
when 439 then
--|#line 1916 "eiffel.y"
	yy_do_action_439
when 440 then
--|#line 1921 "eiffel.y"
	yy_do_action_440
when 441 then
--|#line 1928 "eiffel.y"
	yy_do_action_441
when 442 then
--|#line 1930 "eiffel.y"
	yy_do_action_442
when 443 then
--|#line 1934 "eiffel.y"
	yy_do_action_443
when 444 then
--|#line 1939 "eiffel.y"
	yy_do_action_444
when 445 then
--|#line 1950 "eiffel.y"
	yy_do_action_445
when 446 then
--|#line 1952 "eiffel.y"
	yy_do_action_446
when 447 then
--|#line 1954 "eiffel.y"
	yy_do_action_447
when 448 then
--|#line 1956 "eiffel.y"
	yy_do_action_448
when 449 then
--|#line 1958 "eiffel.y"
	yy_do_action_449
when 450 then
--|#line 1960 "eiffel.y"
	yy_do_action_450
when 451 then
--|#line 1962 "eiffel.y"
	yy_do_action_451
when 452 then
--|#line 1964 "eiffel.y"
	yy_do_action_452
when 453 then
--|#line 1966 "eiffel.y"
	yy_do_action_453
when 454 then
--|#line 1968 "eiffel.y"
	yy_do_action_454
when 455 then
--|#line 1970 "eiffel.y"
	yy_do_action_455
when 456 then
--|#line 1972 "eiffel.y"
	yy_do_action_456
when 457 then
--|#line 1976 "eiffel.y"
	yy_do_action_457
when 458 then
--|#line 1978 "eiffel.y"
	yy_do_action_458
when 459 then
--|#line 1980 "eiffel.y"
	yy_do_action_459
when 460 then
--|#line 1982 "eiffel.y"
	yy_do_action_460
when 461 then
--|#line 1984 "eiffel.y"
	yy_do_action_461
when 462 then
--|#line 1986 "eiffel.y"
	yy_do_action_462
when 463 then
--|#line 1990 "eiffel.y"
	yy_do_action_463
when 464 then
--|#line 1992 "eiffel.y"
	yy_do_action_464
when 465 then
--|#line 1994 "eiffel.y"
	yy_do_action_465
when 466 then
--|#line 2009 "eiffel.y"
	yy_do_action_466
when 467 then
--|#line 2011 "eiffel.y"
	yy_do_action_467
when 468 then
--|#line 2013 "eiffel.y"
	yy_do_action_468
when 469 then
--|#line 2017 "eiffel.y"
	yy_do_action_469
when 470 then
--|#line 2019 "eiffel.y"
	yy_do_action_470
when 471 then
--|#line 2023 "eiffel.y"
	yy_do_action_471
when 472 then
--|#line 2030 "eiffel.y"
	yy_do_action_472
when 473 then
--|#line 2045 "eiffel.y"
	yy_do_action_473
when 474 then
--|#line 2060 "eiffel.y"
	yy_do_action_474
when 475 then
--|#line 2078 "eiffel.y"
	yy_do_action_475
when 476 then
--|#line 2080 "eiffel.y"
	yy_do_action_476
when 477 then
--|#line 2082 "eiffel.y"
	yy_do_action_477
when 478 then
--|#line 2089 "eiffel.y"
	yy_do_action_478
when 479 then
--|#line 2093 "eiffel.y"
	yy_do_action_479
when 480 then
--|#line 2095 "eiffel.y"
	yy_do_action_480
when 481 then
--|#line 2097 "eiffel.y"
	yy_do_action_481
when 482 then
--|#line 2101 "eiffel.y"
	yy_do_action_482
when 483 then
--|#line 2103 "eiffel.y"
	yy_do_action_483
when 484 then
--|#line 2105 "eiffel.y"
	yy_do_action_484
when 485 then
--|#line 2107 "eiffel.y"
	yy_do_action_485
when 486 then
--|#line 2109 "eiffel.y"
	yy_do_action_486
when 487 then
--|#line 2111 "eiffel.y"
	yy_do_action_487
when 488 then
--|#line 2113 "eiffel.y"
	yy_do_action_488
when 489 then
--|#line 2115 "eiffel.y"
	yy_do_action_489
when 490 then
--|#line 2117 "eiffel.y"
	yy_do_action_490
when 491 then
--|#line 2119 "eiffel.y"
	yy_do_action_491
when 492 then
--|#line 2121 "eiffel.y"
	yy_do_action_492
when 493 then
--|#line 2123 "eiffel.y"
	yy_do_action_493
when 494 then
--|#line 2125 "eiffel.y"
	yy_do_action_494
when 495 then
--|#line 2127 "eiffel.y"
	yy_do_action_495
when 496 then
--|#line 2129 "eiffel.y"
	yy_do_action_496
when 497 then
--|#line 2131 "eiffel.y"
	yy_do_action_497
when 498 then
--|#line 2133 "eiffel.y"
	yy_do_action_498
when 499 then
--|#line 2135 "eiffel.y"
	yy_do_action_499
when 500 then
--|#line 2137 "eiffel.y"
	yy_do_action_500
when 501 then
--|#line 2139 "eiffel.y"
	yy_do_action_501
when 502 then
--|#line 2141 "eiffel.y"
	yy_do_action_502
when 503 then
--|#line 2145 "eiffel.y"
	yy_do_action_503
when 504 then
--|#line 2147 "eiffel.y"
	yy_do_action_504
when 505 then
--|#line 2149 "eiffel.y"
	yy_do_action_505
when 506 then
--|#line 2151 "eiffel.y"
	yy_do_action_506
when 507 then
--|#line 2155 "eiffel.y"
	yy_do_action_507
when 508 then
--|#line 2157 "eiffel.y"
	yy_do_action_508
when 509 then
--|#line 2159 "eiffel.y"
	yy_do_action_509
when 510 then
--|#line 2161 "eiffel.y"
	yy_do_action_510
when 511 then
--|#line 2163 "eiffel.y"
	yy_do_action_511
when 512 then
--|#line 2165 "eiffel.y"
	yy_do_action_512
when 513 then
--|#line 2167 "eiffel.y"
	yy_do_action_513
when 514 then
--|#line 2169 "eiffel.y"
	yy_do_action_514
when 515 then
--|#line 2171 "eiffel.y"
	yy_do_action_515
when 516 then
--|#line 2173 "eiffel.y"
	yy_do_action_516
when 517 then
--|#line 2175 "eiffel.y"
	yy_do_action_517
when 518 then
--|#line 2177 "eiffel.y"
	yy_do_action_518
when 519 then
--|#line 2179 "eiffel.y"
	yy_do_action_519
when 520 then
--|#line 2181 "eiffel.y"
	yy_do_action_520
when 521 then
--|#line 2183 "eiffel.y"
	yy_do_action_521
when 522 then
--|#line 2185 "eiffel.y"
	yy_do_action_522
when 523 then
--|#line 2187 "eiffel.y"
	yy_do_action_523
when 524 then
--|#line 2189 "eiffel.y"
	yy_do_action_524
when 525 then
--|#line 2193 "eiffel.y"
	yy_do_action_525
when 526 then
--|#line 2197 "eiffel.y"
	yy_do_action_526
when 527 then
--|#line 2201 "eiffel.y"
	yy_do_action_527
when 528 then
--|#line 2205 "eiffel.y"
	yy_do_action_528
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 179 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 179")
end
			yyval := yyval_default;
				if type_parser then
					raise_error
				end
			

		end

	yy_do_action_2 is
			--|#line 186 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 186")
end
			yyval := yyval_default;
				if not type_parser then
					raise_error
				end
				type_node := yytype59 (yyvs.item (yyvsp))
			

		end

	yy_do_action_3 is
			--|#line 195 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 195")
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
			--|#line 238 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 238")
end
			yyval := yyval_default;
				if inherit_context then
					inherit_context := False
					real_class_end_position := 0
				end
			

		end

	yy_do_action_5 is
			--|#line 247 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 247")
end

yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
		end

	yy_do_action_6 is
			--|#line 249 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 249")
end

yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
		end

	yy_do_action_7 is
			--|#line 251 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 251")
end

yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
		end

	yy_do_action_8 is
			--|#line 253 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 253")
end

yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
		end

	yy_do_action_9 is
			--|#line 255 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 255")
end

yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
		end

	yy_do_action_10 is
			--|#line 257 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 257")
end

yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
		end

	yy_do_action_11 is
			--|#line 259 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 259")
end

yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
		end

	yy_do_action_12 is
			--|#line 261 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 261")
end

yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
		end

	yy_do_action_13 is
			--|#line 263 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 263")
end

yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
		end

	yy_do_action_14 is
			--|#line 265 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 265")
end

yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
		end

	yy_do_action_15 is
			--|#line 267 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 267")
end

yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
		end

	yy_do_action_16 is
			--|#line 269 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 269")
end

yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
		end

	yy_do_action_17 is
			--|#line 273 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 273")
end

yyval88 := new_clickable_id (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval88
		end

	yy_do_action_18 is
			--|#line 277 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 277")
end

yyval88 := new_clickable_id (new_boolean_id_as) 
			yyval := yyval88
		end

	yy_do_action_19 is
			--|#line 281 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 281")
end

yyval88 := new_clickable_id (new_character_id_as (False)) 
			yyval := yyval88
		end

	yy_do_action_20 is
			--|#line 285 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 285")
end

yyval88 := new_clickable_id (new_character_id_as (True)) 
			yyval := yyval88
		end

	yy_do_action_21 is
			--|#line 289 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 289")
end

yyval88 := new_clickable_id (new_double_id_as) 
			yyval := yyval88
		end

	yy_do_action_22 is
			--|#line 293 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 293")
end

yyval88 := new_clickable_id (new_integer_id_as (8)) 
			yyval := yyval88
		end

	yy_do_action_23 is
			--|#line 297 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 297")
end

yyval88 := new_clickable_id (new_integer_id_as (16)) 
			yyval := yyval88
		end

	yy_do_action_24 is
			--|#line 301 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 301")
end

yyval88 := new_clickable_id (new_integer_id_as (32)) 
			yyval := yyval88
		end

	yy_do_action_25 is
			--|#line 305 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 305")
end

yyval88 := new_clickable_id (new_integer_id_as (64)) 
			yyval := yyval88
		end

	yy_do_action_26 is
			--|#line 309 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 309")
end

yyval88 := new_clickable_id (new_none_id_as) 
			yyval := yyval88
		end

	yy_do_action_27 is
			--|#line 313 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 313")
end

yyval88 := new_clickable_id (new_pointer_id_as) 
			yyval := yyval88
		end

	yy_do_action_28 is
			--|#line 317 "eiffel.y"
		local
			yyval88: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 317")
end

yyval88 := new_clickable_id (new_real_id_as) 
			yyval := yyval88
		end

	yy_do_action_29 is
			--|#line 324 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 324")
end


			yyval := yyval77
		end

	yy_do_action_30 is
			--|#line 326 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 326")
end

yyval77 := yytype77 (yyvs.item (yyvsp)) 
			yyval := yyval77
		end

	yy_do_action_31 is
			--|#line 328 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 328")
end


			yyval := yyval77
		end

	yy_do_action_32 is
			--|#line 332 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 332")
end


			yyval := yyval77
		end

	yy_do_action_33 is
			--|#line 334 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 334")
end

yyval77 := yytype77 (yyvs.item (yyvsp)) 
			yyval := yyval77
		end

	yy_do_action_34 is
			--|#line 336 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 336")
end

yyval77 := Void 
			yyval := yyval77
		end

	yy_do_action_35 is
			--|#line 340 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 340")
end


			yyval := yyval77
		end

	yy_do_action_36 is
			--|#line 342 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 342")
end

yyval77 := yytype77 (yyvs.item (yyvsp - 1)) 
			yyval := yyval77
		end

	yy_do_action_37 is
			--|#line 344 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 344")
end

yyval77 := Void 
			yyval := yyval77
		end

	yy_do_action_38 is
			--|#line 348 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 348")
end

				yyval77 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval77.extend (yytype33 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_39 is
			--|#line 353 "eiffel.y"
		local
			yyval77: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 353")
end

				yyval77 := yytype77 (yyvs.item (yyvsp - 1))
				yyval77.extend (yytype33 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_40 is
			--|#line 360 "eiffel.y"
		local
			yyval33: INDEX_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 360")
end

yyval33 := new_index_as (yytype31 (yyvs.item (yyvsp - 2)), yytype62 (yyvs.item (yyvsp - 1))) 
			yyval := yyval33
		end

	yy_do_action_41 is
			--|#line 364 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 364")
end

yyval31 := yytype31 (yyvs.item (yyvsp - 1)) 
			yyval := yyval31
		end

	yy_do_action_42 is
			--|#line 366 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 366")
end


			yyval := yyval31
		end

	yy_do_action_43 is
			--|#line 370 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 370")
end

				yyval62 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval62.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_44 is
			--|#line 375 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 375")
end

				yyval62 := yytype62 (yyvs.item (yyvsp - 2))
				yyval62.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_45 is
			--|#line 380 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 380")
end

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval62 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval62
		end

	yy_do_action_46 is
			--|#line 387 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 387")
end

yyval6 := yytype31 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_47 is
			--|#line 389 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 389")
end

yyval6 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_48 is
			--|#line 391 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 391")
end

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype19 (yyvs.item (yyvsp - 1)), Void)
			
			yyval := yyval6
		end

	yy_do_action_49 is
			--|#line 395 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 395")
end

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype19 (yyvs.item (yyvsp - 2)), yytype58 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval6
		end

	yy_do_action_50 is
			--|#line 405 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 405")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_51 is
			--|#line 411 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 411")
end
			yyval := yyval_default;
				is_frozen_class := False
				is_deferred := True
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_52 is
			--|#line 418 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 418")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := True
				is_separate := False
			

		end

	yy_do_action_53 is
			--|#line 424 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 424")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := True
			

		end

	yy_do_action_54 is
			--|#line 432 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 432")
end
			yyval := yyval_default;
				is_frozen_class := False
			

		end

	yy_do_action_55 is
			--|#line 436 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 436")
end
			yyval := yyval_default;
				if il_parser then
					is_frozen_class := True
				else
						-- Trigger a syntax error.
					raise_error
				end
			

		end

	yy_do_action_56 is
			--|#line 447 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 447")
end
			yyval := yyval_default;
				is_external_class := False
			

		end

	yy_do_action_57 is
			--|#line 451 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 451")
end
			yyval := yyval_default;
				if il_parser then
					is_external_class := True
				else
						-- Trigger a syntax error.
					raise_error
				end
			

		end

	yy_do_action_58 is
			--|#line 466 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 466")
end


			yyval := yyval56
		end

	yy_do_action_59 is
			--|#line 468 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 468")
end

yyval56 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval56
		end

	yy_do_action_60 is
			--|#line 475 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 475")
end


			yyval := yyval70
		end

	yy_do_action_61 is
			--|#line 477 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 477")
end

				yyval70 := yytype70 (yyvs.item (yyvsp))
				if yyval70.is_empty then
					yyval70 := Void
				end
			
			yyval := yyval70
		end

	yy_do_action_62 is
			--|#line 486 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 486")
end

				yyval70 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval70, yytype28 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_63 is
			--|#line 491 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 491")
end

				yyval70 := yytype70 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval70, yytype28 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_64 is
			--|#line 498 "eiffel.y"
		local
			yyval28: FEATURE_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 498")
end

yyval28 := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) 
			yyval := yyval28
		end

	yy_do_action_65 is
			--|#line 500 "eiffel.y"
		local
			yyval28: FEATURE_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 500")
end

yyval28 := new_feature_clause_as (yytype14 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval28
		end

	yy_do_action_66 is
			--|#line 504 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 504")
end

yyval14 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval14
		end

	yy_do_action_67 is
			--|#line 504 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 504")
end
			yyval := yyval_default;
				inherit_context := False
				fclause_pos := clone (current_position)
			

		end

	yy_do_action_68 is
			--|#line 513 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 513")
end


			yyval := yyval14
		end

	yy_do_action_69 is
			--|#line 515 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 515")
end

yyval14 := new_client_as (yytype74 (yyvs.item (yyvsp))) 
			yyval := yyval14
		end

	yy_do_action_70 is
			--|#line 519 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 519")
end

				yyval74 := new_eiffel_list_id_as (1)
				yyval74.extend (new_none_id_as)
			
			yyval := yyval74
		end

	yy_do_action_71 is
			--|#line 524 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 524")
end

yyval74 := yytype74 (yyvs.item (yyvsp - 1)) 
			yyval := yyval74
		end

	yy_do_action_72 is
			--|#line 528 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 528")
end

				yyval74 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval74.extend (yytype88 (yyvs.item (yyvsp)).first)
				yytype88 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype88 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval74
		end

	yy_do_action_73 is
			--|#line 534 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 534")
end

				yyval74 := yytype74 (yyvs.item (yyvsp - 2))
				yyval74.extend (yytype88 (yyvs.item (yyvsp)).first)
				yytype88 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype88 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval74
		end

	yy_do_action_74 is
			--|#line 542 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [FEATURE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 542")
end

				yyval69 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval69.extend (yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval69
		end

	yy_do_action_75 is
			--|#line 547 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [FEATURE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 547")
end

				yyval69 := yytype69 (yyvs.item (yyvsp - 1))
				yyval69.extend (yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval69
		end

	yy_do_action_76 is
			--|#line 554 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 554")
end
			yyval := yyval_default;


		end

	yy_do_action_77 is
			--|#line 555 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 555")
end
			yyval := yyval_default;


		end

	yy_do_action_78 is
			--|#line 558 "eiffel.y"
		local
			yyval27: FEATURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 558")
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

	yy_do_action_79 is
			--|#line 571 "eiffel.y"
		local
			yyval91: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 571")
end

yyval91 := new_clickable_feature_name_list (yytype89 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval91
		end

	yy_do_action_80 is
			--|#line 573 "eiffel.y"
		local
			yyval91: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 573")
end

				yyval91 := yytype91 (yyvs.item (yyvsp - 2))
				yyval91.first.extend (yytype89 (yyvs.item (yyvsp)).first)
			
			yyval := yyval91
		end

	yy_do_action_81 is
			--|#line 580 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 580")
end

yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
		end

	yy_do_action_82 is
			--|#line 584 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 584")
end
			yyval := yyval_default;
is_frozen := False 

		end

	yy_do_action_83 is
			--|#line 586 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 586")
end
			yyval := yyval_default;
is_frozen := True 

		end

	yy_do_action_84 is
			--|#line 590 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 590")
end

yyval89 := new_clickable_feature_name (yytype88 (yyvs.item (yyvsp))) 
			yyval := yyval89
		end

	yy_do_action_85 is
			--|#line 592 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 592")
end

yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
		end

	yy_do_action_86 is
			--|#line 594 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 594")
end

yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
		end

	yy_do_action_87 is
			--|#line 598 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 598")
end

yyval89 := new_clickable_infix (yytype90 (yyvs.item (yyvsp))) 
			yyval := yyval89
		end

	yy_do_action_88 is
			--|#line 603 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 603")
end

yyval89 := new_clickable_prefix (yytype90 (yyvs.item (yyvsp))) 
			yyval := yyval89
		end

	yy_do_action_89 is
			--|#line 607 "eiffel.y"
		local
			yyval8: BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 607")
end

yyval8 := new_declaration_body (yytype86 (yyvs.item (yyvsp - 2)), yytype59 (yyvs.item (yyvsp - 1)), yytype15 (yyvs.item (yyvsp))) 
			yyval := yyval8
		end

	yy_do_action_90 is
			--|#line 611 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 611")
end

feature_indexes := yytype77 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_91 is
			--|#line 613 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 613")
end

yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_92 is
			--|#line 617 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 617")
end

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (yytype6 (yyvs.item (yyvsp - 1))))
				feature_indexes := yytype77 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_93 is
			--|#line 622 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 622")
end

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (new_unique_as))
				feature_indexes := yytype77 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_94 is
			--|#line 627 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 627")
end

				yyval15 := yytype54 (yyvs.item (yyvsp))
				feature_indexes := yytype77 (yyvs.item (yyvsp - 1))
			
			yyval := yyval15
		end

	yy_do_action_95 is
			--|#line 638 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 638")
end


			yyval := yyval81
		end

	yy_do_action_96 is
			--|#line 640 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 640")
end

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_97 is
			--|#line 642 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 642")
end

yyval81 := new_eiffel_list_parent_as (0) 
			yyval := yyval81
		end

	yy_do_action_98 is
			--|#line 646 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 646")
end

				yyval81 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval81.extend (yytype45 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_99 is
			--|#line 651 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 651")
end

				yyval81 := yytype81 (yyvs.item (yyvsp - 1))
				yyval81.extend (yytype45 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_100 is
			--|#line 658 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 658")
end

				yyval45 := yytype45 (yyvs.item (yyvsp))
				yytype45 (yyvs.item (yyvsp)).set_location (yytype93 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_101 is
			--|#line 663 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 663")
end

				inherit_context := False
				yyval45 := yytype45 (yyvs.item (yyvsp - 1))
				yytype45 (yyvs.item (yyvsp - 1)).set_location (yytype93 (yyvs.item (yyvsp - 2)))
			
			yyval := yyval45
		end

	yy_do_action_102 is
			--|#line 671 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 671")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 1)), yytype85 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval45
		end

	yy_do_action_103 is
			--|#line 676 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 676")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 7)), yytype85 (yyvs.item (yyvsp - 6)), yytype82 (yyvs.item (yyvsp - 5)), yytype67 (yyvs.item (yyvsp - 4)), yytype72 (yyvs.item (yyvsp - 3)), yytype72 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_104 is
			--|#line 681 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 681")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 6)), yytype85 (yyvs.item (yyvsp - 5)), Void, yytype67 (yyvs.item (yyvsp - 4)), yytype72 (yyvs.item (yyvsp - 3)), yytype72 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_105 is
			--|#line 686 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 686")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 5)), yytype85 (yyvs.item (yyvsp - 4)), Void, Void, yytype72 (yyvs.item (yyvsp - 3)), yytype72 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_106 is
			--|#line 691 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 691")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 4)), yytype85 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype72 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_107 is
			--|#line 696 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 696")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 3)), yytype85 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_108 is
			--|#line 701 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 701")
end

				inherit_context := True
				real_class_end_position := current_position.end_position - 3
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 2)), yytype85 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval45
		end

	yy_do_action_109 is
			--|#line 709 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 709")
end


			yyval := yyval82
		end

	yy_do_action_110 is
			--|#line 711 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 711")
end

yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
		end

	yy_do_action_111 is
			--|#line 715 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 715")
end

				yyval82 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval82.extend (yytype49 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_112 is
			--|#line 720 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 720")
end

				yyval82 := yytype82 (yyvs.item (yyvsp - 2))
				yyval82.extend (yytype49 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_113 is
			--|#line 727 "eiffel.y"
		local
			yyval49: RENAME_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 727")
end

yyval49 := new_rename_pair (yytype89 (yyvs.item (yyvsp - 2)), yytype89 (yyvs.item (yyvsp))) 
			yyval := yyval49
		end

	yy_do_action_114 is
			--|#line 731 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 731")
end


			yyval := yyval67
		end

	yy_do_action_115 is
			--|#line 733 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 733")
end

yyval67 := yytype67 (yyvs.item (yyvsp)) 
			yyval := yyval67
		end

	yy_do_action_116 is
			--|#line 737 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 737")
end

yyval67 := yytype67 (yyvs.item (yyvsp)) 
			yyval := yyval67
		end

	yy_do_action_117 is
			--|#line 739 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 739")
end


			yyval := yyval67
		end

	yy_do_action_118 is
			--|#line 743 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 743")
end

				yyval67 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				yyval67.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_119 is
			--|#line 748 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 748")
end

				yyval67 := yytype67 (yyvs.item (yyvsp - 1))
				yyval67.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_120 is
			--|#line 755 "eiffel.y"
		local
			yyval23: EXPORT_ITEM_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 755")
end

yyval23 := new_export_item_as (new_client_as (yytype74 (yyvs.item (yyvsp - 2))), yytype29 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_121 is
			--|#line 759 "eiffel.y"
		local
			yyval29: FEATURE_SET_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 759")
end

yyval29 := new_all_as 
			yyval := yyval29
		end

	yy_do_action_122 is
			--|#line 761 "eiffel.y"
		local
			yyval29: FEATURE_SET_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 761")
end

yyval29 := new_feature_list_as (yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval29
		end

	yy_do_action_123 is
			--|#line 765 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 765")
end


			yyval := yyval64
		end

	yy_do_action_124 is
			--|#line 767 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 767")
end

			yyval64 := yytype64 (yyvs.item (yyvsp))
		
			yyval := yyval64
		end

	yy_do_action_125 is
			--|#line 773 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 773")
end

			yyval64 := new_eiffel_list_convert (Initial_convert_list_size)
			yyval64.extend (yytype16 (yyvs.item (yyvsp)))
		
			yyval := yyval64
		end

	yy_do_action_126 is
			--|#line 778 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 778")
end

			yyval64 := yytype64 (yyvs.item (yyvsp - 2))
			yyval64.extend (yytype16 (yyvs.item (yyvsp)))
		
			yyval := yyval64
		end

	yy_do_action_127 is
			--|#line 786 "eiffel.y"
		local
			yyval16: CONVERT_FEAT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 786")
end

				-- True because this is a conversion feature used as a creation
				-- procedure in current class.
			yyval16 := new_convert_feat_as (True, yytype89 (yyvs.item (yyvsp - 5)).first, yytype85 (yyvs.item (yyvsp - 2)))
		
			yyval := yyval16
		end

	yy_do_action_128 is
			--|#line 792 "eiffel.y"
		local
			yyval16: CONVERT_FEAT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 792")
end

				-- False because this is not a conversion feature used as a creation
				-- procedure.
			yyval16 := new_convert_feat_as (False, yytype89 (yyvs.item (yyvsp - 4)).first, yytype85 (yyvs.item (yyvsp - 1)))
		
			yyval := yyval16
		end

	yy_do_action_129 is
			--|#line 800 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 800")
end

				yyval72 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval72.extend (yytype89 (yyvs.item (yyvsp)).first)
			
			yyval := yyval72
		end

	yy_do_action_130 is
			--|#line 805 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 805")
end

				yyval72 := yytype72 (yyvs.item (yyvsp - 2))
				yyval72.extend (yytype89 (yyvs.item (yyvsp)).first)
			
			yyval := yyval72
		end

	yy_do_action_131 is
			--|#line 812 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 812")
end


			yyval := yyval72
		end

	yy_do_action_132 is
			--|#line 814 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 814")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_133 is
			--|#line 818 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 818")
end


			yyval := yyval72
		end

	yy_do_action_134 is
			--|#line 820 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 820")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_135 is
			--|#line 824 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 824")
end


			yyval := yyval72
		end

	yy_do_action_136 is
			--|#line 826 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 826")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_137 is
			--|#line 830 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 830")
end


			yyval := yyval72
		end

	yy_do_action_138 is
			--|#line 832 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 832")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_139 is
			--|#line 836 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 836")
end


			yyval := yyval72
		end

	yy_do_action_140 is
			--|#line 838 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 838")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_141 is
			--|#line 842 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 842")
end


			yyval := yyval72
		end

	yy_do_action_142 is
			--|#line 844 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 844")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_143 is
			--|#line 852 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 852")
end


			yyval := yyval86
		end

	yy_do_action_144 is
			--|#line 854 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 854")
end

yyval86 := yytype86 (yyvs.item (yyvsp - 1)) 
			yyval := yyval86
		end

	yy_do_action_145 is
			--|#line 858 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 858")
end


			yyval := yyval86
		end

	yy_do_action_146 is
			--|#line 860 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 860")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_147 is
			--|#line 864 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 864")
end

				yyval86 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval86.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval86
		end

	yy_do_action_148 is
			--|#line 869 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 869")
end

				yyval86 := yytype86 (yyvs.item (yyvsp - 1))
				yyval86.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval86
		end

	yy_do_action_149 is
			--|#line 876 "eiffel.y"
		local
			yyval60: TYPE_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 876")
end

yyval60 := new_type_dec_as (yytype76 (yyvs.item (yyvsp - 5)), yytype59 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 4))) 
			yyval := yyval60
		end

	yy_do_action_150 is
			--|#line 880 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 880")
end
			yyval := yyval_default;


		end

	yy_do_action_151 is
			--|#line 881 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 881")
end
			yyval := yyval_default;
				if il_parser then
						-- Trigger a syntax error.
					raise_error
				end
			

		end

	yy_do_action_152 is
			--|#line 890 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 890")
end


			yyval := yyval86
		end

	yy_do_action_153 is
			--|#line 892 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 892")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_154 is
			--|#line 896 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 896")
end

				yyval86 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval86.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval86
		end

	yy_do_action_155 is
			--|#line 901 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 901")
end

				yyval86 := yytype86 (yyvs.item (yyvsp - 1))
				yyval86.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval86
		end

	yy_do_action_156 is
			--|#line 908 "eiffel.y"
		local
			yyval60: TYPE_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 908")
end

yyval60 := new_type_dec_as (yytype76 (yyvs.item (yyvsp - 4)), yytype59 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval60
		end

	yy_do_action_157 is
			--|#line 912 "eiffel.y"
		local
			yyval76: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 912")
end

				create yyval76.make (Initial_identifier_list_size)
				Names_heap.put (yytype31 (yyvs.item (yyvsp)))
				yyval76.extend (Names_heap.found_item)
			
			yyval := yyval76
		end

	yy_do_action_158 is
			--|#line 918 "eiffel.y"
		local
			yyval76: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 918")
end

				yyval76 := yytype76 (yyvs.item (yyvsp - 2))
				Names_heap.put (yytype31 (yyvs.item (yyvsp)))
				yyval76.extend (Names_heap.found_item)
			
			yyval := yyval76
		end

	yy_do_action_159 is
			--|#line 926 "eiffel.y"
		local
			yyval76: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 926")
end

create yyval76.make (0) 
			yyval := yyval76
		end

	yy_do_action_160 is
			--|#line 928 "eiffel.y"
		local
			yyval76: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 928")
end

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_161 is
			--|#line 932 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 932")
end


			yyval := yyval59
		end

	yy_do_action_162 is
			--|#line 934 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 934")
end

yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
		end

	yy_do_action_163 is
			--|#line 938 "eiffel.y"
		local
			yyval54: ROUTINE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 938")
end

yyval54 := new_routine_as (yytype56 (yyvs.item (yyvsp - 7)), yytype50 (yyvs.item (yyvsp - 5)), yytype86 (yyvs.item (yyvsp - 4)), yytype53 (yyvs.item (yyvsp - 3)), yytype22 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp - 1)), fbody_pos, current_position) 
			yyval := yyval54
		end

	yy_do_action_164 is
			--|#line 938 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 938")
end
			yyval := yyval_default;
fbody_pos := current_position.start_position 

		end

	yy_do_action_165 is
			--|#line 950 "eiffel.y"
		local
			yyval53: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 950")
end

yyval53 := yytype38 (yyvs.item (yyvsp)) 
			yyval := yyval53
		end

	yy_do_action_166 is
			--|#line 952 "eiffel.y"
		local
			yyval53: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 952")
end

yyval53 := yytype25 (yyvs.item (yyvsp)) 
			yyval := yyval53
		end

	yy_do_action_167 is
			--|#line 954 "eiffel.y"
		local
			yyval53: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 954")
end

yyval53 := new_deferred_as 
			yyval := yyval53
		end

	yy_do_action_168 is
			--|#line 958 "eiffel.y"
		local
			yyval25: EXTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 958")
end

yyval25 := new_external_as (yytype26 (yyvs.item (yyvsp - 1)), yytype56 (yyvs.item (yyvsp))) 
			yyval := yyval25
		end

	yy_do_action_169 is
			--|#line 962 "eiffel.y"
		local
			yyval26: EXTERNAL_LANG_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 962")
end

yyval26 := new_external_lang_as (yytype56 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval26
		end

	yy_do_action_170 is
			--|#line 967 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 967")
end


			yyval := yyval56
		end

	yy_do_action_171 is
			--|#line 969 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 969")
end

yyval56 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval56
		end

	yy_do_action_172 is
			--|#line 973 "eiffel.y"
		local
			yyval38: INTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 973")
end

yyval38 := new_do_as (yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_173 is
			--|#line 975 "eiffel.y"
		local
			yyval38: INTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 975")
end

yyval38 := new_once_as (yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_174 is
			--|#line 979 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 979")
end


			yyval := yyval86
		end

	yy_do_action_175 is
			--|#line 981 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 981")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_176 is
			--|#line 985 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 985")
end


			yyval := yyval78
		end

	yy_do_action_177 is
			--|#line 987 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 987")
end

yyval78 := yytype78 (yyvs.item (yyvsp)) 
			yyval := yyval78
		end

	yy_do_action_178 is
			--|#line 991 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 991")
end

				yyval78 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval78.extend (yytype36 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_179 is
			--|#line 996 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 996")
end

				yyval78 := yytype78 (yyvs.item (yyvsp - 1))
				yyval78.extend (yytype36 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_180 is
			--|#line 1003 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1003")
end

yyval36 := yytype36 (yyvs.item (yyvsp - 1)) 
			yyval := yyval36
		end

	yy_do_action_181 is
			--|#line 1007 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1007")
end
			yyval := yyval_default;


		end

	yy_do_action_182 is
			--|#line 1008 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1008")
end
			yyval := yyval_default;


		end

	yy_do_action_183 is
			--|#line 1011 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1011")
end

yyval36 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_184 is
			--|#line 1013 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1013")
end

yyval36 := yytype35 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_185 is
			--|#line 1015 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1015")
end

yyval36 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_186 is
			--|#line 1017 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1017")
end

yyval36 := yytype52 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_187 is
			--|#line 1019 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1019")
end

yyval36 := yytype32 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_188 is
			--|#line 1021 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1021")
end

yyval36 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_189 is
			--|#line 1023 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1023")
end

yyval36 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_190 is
			--|#line 1025 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1025")
end

yyval36 := yytype20 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_191 is
			--|#line 1027 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1027")
end

yyval36 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_192 is
			--|#line 1029 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1029")
end

yyval36 := yytype51 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_193 is
			--|#line 1033 "eiffel.y"
		local
			yyval50: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1033")
end


			yyval := yyval50
		end

	yy_do_action_194 is
			--|#line 1035 "eiffel.y"
		local
			yyval50: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1035")
end

				id_level := Normal_level
				yyval50 := new_require_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval50
		end

	yy_do_action_195 is
			--|#line 1035 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1035")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_196 is
			--|#line 1042 "eiffel.y"
		local
			yyval50: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1042")
end

				id_level := Normal_level
				yyval50 := new_require_else_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval50
		end

	yy_do_action_197 is
			--|#line 1042 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1042")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_198 is
			--|#line 1051 "eiffel.y"
		local
			yyval22: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1051")
end


			yyval := yyval22
		end

	yy_do_action_199 is
			--|#line 1053 "eiffel.y"
		local
			yyval22: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1053")
end

				id_level := Normal_level
				yyval22 := new_ensure_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_200 is
			--|#line 1053 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1053")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_201 is
			--|#line 1060 "eiffel.y"
		local
			yyval22: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1060")
end

				id_level := Normal_level
				yyval22 := new_ensure_then_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_202 is
			--|#line 1060 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1060")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_203 is
			--|#line 1069 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1069")
end


			yyval := yyval84
		end

	yy_do_action_204 is
			--|#line 1071 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1071")
end

				yyval84 := yytype84 (yyvs.item (yyvsp))
				if yyval84.is_empty then
					yyval84 := Void
				end
			
			yyval := yyval84
		end

	yy_do_action_205 is
			--|#line 1080 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1080")
end

				yyval84 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval84, yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_206 is
			--|#line 1085 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1085")
end

				yyval84 := yytype84 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval84, yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_207 is
			--|#line 1092 "eiffel.y"
		local
			yyval57: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1092")
end

yyval57 := yytype57 (yyvs.item (yyvsp - 1)) 
			yyval := yyval57
		end

	yy_do_action_208 is
			--|#line 1096 "eiffel.y"
		local
			yyval57: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1096")
end

yyval57 := new_tagged_as (Void, yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval57
		end

	yy_do_action_209 is
			--|#line 1098 "eiffel.y"
		local
			yyval57: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1098")
end

yyval57 := new_tagged_as (yytype31 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval57
		end

	yy_do_action_210 is
			--|#line 1100 "eiffel.y"
		local
			yyval57: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1100")
end


			yyval := yyval57
		end

	yy_do_action_211 is
			--|#line 1108 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1108")
end

yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
		end

	yy_do_action_212 is
			--|#line 1110 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1110")
end

yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
		end

	yy_do_action_213 is
			--|#line 1114 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1114")
end

yyval59 := new_expanded_type (yytype88 (yyvs.item (yyvsp - 1)), yytype85 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_214 is
			--|#line 1116 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1116")
end

yyval59 := new_separate_type (yytype88 (yyvs.item (yyvsp - 1)), yytype85 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_215 is
			--|#line 1118 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1118")
end

yyval59 := new_bits_as (yytype37 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_216 is
			--|#line 1120 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1120")
end

yyval59 := new_bits_symbol_as (yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_217 is
			--|#line 1122 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1122")
end

yyval59 := new_like_id_as (yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_218 is
			--|#line 1124 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1124")
end

yyval59 := new_like_current_as 
			yyval := yyval59
		end

	yy_do_action_219 is
			--|#line 1128 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1128")
end

yyval59 := new_class_type (yytype88 (yyvs.item (yyvsp - 1)), yytype85 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_220 is
			--|#line 1130 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1130")
end

yyval59 := new_boolean_type (yytype88 (yyvs.item (yyvsp - 1)).second, yytype85 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval59
		end

	yy_do_action_221 is
			--|#line 1132 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1132")
end

yyval59 := new_character_type (yytype88 (yyvs.item (yyvsp - 1)).second, yytype85 (yyvs.item (yyvsp)) /= Void, False) 
			yyval := yyval59
		end

	yy_do_action_222 is
			--|#line 1134 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1134")
end

yyval59 := new_character_type (yytype88 (yyvs.item (yyvsp - 1)).second, yytype85 (yyvs.item (yyvsp)) /= Void, True) 
			yyval := yyval59
		end

	yy_do_action_223 is
			--|#line 1136 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1136")
end

yyval59 := new_double_type (yytype88 (yyvs.item (yyvsp - 1)).second, yytype85 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval59
		end

	yy_do_action_224 is
			--|#line 1138 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1138")
end

yyval59 := new_integer_type (yytype88 (yyvs.item (yyvsp - 1)).second, yytype85 (yyvs.item (yyvsp)) /= Void, 8) 
			yyval := yyval59
		end

	yy_do_action_225 is
			--|#line 1140 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1140")
end

yyval59 := new_integer_type (yytype88 (yyvs.item (yyvsp - 1)).second, yytype85 (yyvs.item (yyvsp)) /= Void, 16) 
			yyval := yyval59
		end

	yy_do_action_226 is
			--|#line 1142 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1142")
end

yyval59 := new_integer_type (yytype88 (yyvs.item (yyvsp - 1)).second, yytype85 (yyvs.item (yyvsp)) /= Void, 32) 
			yyval := yyval59
		end

	yy_do_action_227 is
			--|#line 1144 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1144")
end

yyval59 := new_integer_type (yytype88 (yyvs.item (yyvsp - 1)).second, yytype85 (yyvs.item (yyvsp)) /= Void, 64) 
			yyval := yyval59
		end

	yy_do_action_228 is
			--|#line 1146 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1146")
end

yyval59 := new_none_type (yytype88 (yyvs.item (yyvsp - 1)).second, yytype85 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval59
		end

	yy_do_action_229 is
			--|#line 1148 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1148")
end

yyval59 := new_pointer_type (yytype88 (yyvs.item (yyvsp - 1)).second, yytype85 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval59
		end

	yy_do_action_230 is
			--|#line 1150 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1150")
end

yyval59 := new_real_type (yytype88 (yyvs.item (yyvsp - 1)).second, yytype85 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval59
		end

	yy_do_action_231 is
			--|#line 1154 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1154")
end


			yyval := yyval85
		end

	yy_do_action_232 is
			--|#line 1156 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1156")
end


			yyval := yyval85
		end

	yy_do_action_233 is
			--|#line 1158 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1158")
end

yyval85 := yytype85 (yyvs.item (yyvsp - 1)) 
			yyval := yyval85
		end

	yy_do_action_234 is
			--|#line 1162 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1162")
end

				yyval85 := new_eiffel_list_type (Initial_type_list_size)
				yyval85.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval85
		end

	yy_do_action_235 is
			--|#line 1167 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1167")
end

				yyval85 := yytype85 (yyvs.item (yyvsp - 2))
				yyval85.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval85
		end

	yy_do_action_236 is
			--|#line 1178 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1178")
end

				-- $$ := Void
				formal_generics_start_position := current_position.start_position
				formal_generics_end_position := 0
			
			yyval := yyval73
		end

	yy_do_action_237 is
			--|#line 1184 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1184")
end

				yyval73 := yytype73 (yyvs.item (yyvsp - 1))
				formal_generics_start_position := yytype93 (yyvs.item (yyvsp - 3)).start_position
				formal_generics_end_position := current_position.start_position
			
			yyval := yyval73
		end

	yy_do_action_238 is
			--|#line 1192 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1192")
end


			yyval := yyval73
		end

	yy_do_action_239 is
			--|#line 1194 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1194")
end

yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
		end

	yy_do_action_240 is
			--|#line 1198 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1198")
end

				yyval73 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval73.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval73
		end

	yy_do_action_241 is
			--|#line 1203 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1203")
end

				yyval73 := yytype73 (yyvs.item (yyvsp - 2))
				yyval73.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval73
		end

	yy_do_action_242 is
			--|#line 1210 "eiffel.y"
		local
			yyval30: FORMAL_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1210")
end

				check formal_exists: not formal_parameters.is_empty end
				yyval30 := new_formal_dec_as (formal_parameters.last, yytype92 (yyvs.item (yyvsp)).first, yytype92 (yyvs.item (yyvsp)).second, formal_parameters.count)
			
			yyval := yyval30
		end

	yy_do_action_243 is
			--|#line 1210 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1210")
end
			yyval := yyval_default;
formal_parameters.extend (create {ID_AS}.initialize (token_buffer)) 

		end

	yy_do_action_244 is
			--|#line 1220 "eiffel.y"
		local
			yyval92: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1220")
end

create yyval92 
			yyval := yyval92
		end

	yy_do_action_245 is
			--|#line 1222 "eiffel.y"
		local
			yyval92: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1222")
end

				create yyval92
				yyval92.set_first (yytype59 (yyvs.item (yyvsp - 1)))
				yyval92.set_second (yytype72 (yyvs.item (yyvsp)))
			
			yyval := yyval92
		end

	yy_do_action_246 is
			--|#line 1230 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1230")
end


			yyval := yyval72
		end

	yy_do_action_247 is
			--|#line 1232 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1232")
end

yyval72 := yytype72 (yyvs.item (yyvsp - 1)) 
			yyval := yyval72
		end

	yy_do_action_248 is
			--|#line 1240 "eiffel.y"
		local
			yyval32: IF_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1240")
end

				yyval32 := new_if_as (yytype24 (yyvs.item (yyvsp - 5)), yytype78 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 7)), current_position)
			
			yyval := yyval32
		end

	yy_do_action_249 is
			--|#line 1246 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1246")
end


			yyval := yyval66
		end

	yy_do_action_250 is
			--|#line 1248 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1248")
end

yyval66 := yytype66 (yyvs.item (yyvsp)) 
			yyval := yyval66
		end

	yy_do_action_251 is
			--|#line 1252 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1252")
end

				yyval66 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval66.extend (yytype21 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_252 is
			--|#line 1257 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1257")
end

				yyval66 := yytype66 (yyvs.item (yyvsp - 1))
				yyval66.extend (yytype21 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_253 is
			--|#line 1264 "eiffel.y"
		local
			yyval21: ELSIF_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1264")
end

yyval21 := new_elseif_as (yytype24 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 4))) 
			yyval := yyval21
		end

	yy_do_action_254 is
			--|#line 1268 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1268")
end


			yyval := yyval78
		end

	yy_do_action_255 is
			--|#line 1270 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1270")
end

yyval78 := yytype78 (yyvs.item (yyvsp)) 
			yyval := yyval78
		end

	yy_do_action_256 is
			--|#line 1274 "eiffel.y"
		local
			yyval34: INSPECT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1274")
end

				yyval34 := new_inspect_as (yytype24 (yyvs.item (yyvsp - 3)), yytype63 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval34
		end

	yy_do_action_257 is
			--|#line 1280 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1280")
end


			yyval := yyval63
		end

	yy_do_action_258 is
			--|#line 1282 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1282")
end

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_259 is
			--|#line 1286 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1286")
end

				yyval63 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval63.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_260 is
			--|#line 1291 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1291")
end

				yyval63 := yytype63 (yyvs.item (yyvsp - 1))
				yyval63.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_261 is
			--|#line 1298 "eiffel.y"
		local
			yyval11: CASE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1298")
end

yyval11 := new_case_as (yytype79 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval11
		end

	yy_do_action_262 is
			--|#line 1302 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INTERVAL_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1302")
end

				yyval79 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval79.extend (yytype39 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_263 is
			--|#line 1307 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INTERVAL_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1307")
end

				yyval79 := yytype79 (yyvs.item (yyvsp - 2))
				yyval79.extend (yytype39 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_264 is
			--|#line 1314 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1314")
end

yyval39 := new_interval_as (yytype37 (yyvs.item (yyvsp)), Void) 
			yyval := yyval39
		end

	yy_do_action_265 is
			--|#line 1316 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1316")
end

yyval39 := new_interval_as (yytype37 (yyvs.item (yyvsp - 2)), yytype37 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_266 is
			--|#line 1318 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1318")
end

yyval39 := new_interval_as (yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval39
		end

	yy_do_action_267 is
			--|#line 1320 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1320")
end

yyval39 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_268 is
			--|#line 1322 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1322")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp)), Void) 
			yyval := yyval39
		end

	yy_do_action_269 is
			--|#line 1324 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1324")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_270 is
			--|#line 1326 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1326")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp - 2)), yytype37 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_271 is
			--|#line 1328 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1328")
end

yyval39 := new_interval_as (yytype37 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_272 is
			--|#line 1330 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1330")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_273 is
			--|#line 1332 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1332")
end

yyval39 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_274 is
			--|#line 1334 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1334")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp)), Void) 
			yyval := yyval39
		end

	yy_do_action_275 is
			--|#line 1336 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1336")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_276 is
			--|#line 1338 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1338")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp - 2)), yytype47 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_277 is
			--|#line 1340 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1340")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp - 2)), yytype47 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_278 is
			--|#line 1342 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1342")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp - 2)), yytype37 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_279 is
			--|#line 1344 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1344")
end

yyval39 := new_interval_as (yytype37 (yyvs.item (yyvsp - 2)), yytype47 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_280 is
			--|#line 1346 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1346")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_281 is
			--|#line 1348 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1348")
end

yyval39 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype47 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_282 is
			--|#line 1353 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1353")
end


			yyval := yyval78
		end

	yy_do_action_283 is
			--|#line 1355 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1355")
end

				yyval78 := yytype78 (yyvs.item (yyvsp))
				if yyval78 = Void then
					yyval78 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval78
		end

	yy_do_action_284 is
			--|#line 1364 "eiffel.y"
		local
			yyval41: LOOP_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1364")
end

				yyval41 := new_loop_as (yytype78 (yyvs.item (yyvsp - 8)), yytype84 (yyvs.item (yyvsp - 7)), yytype61 (yyvs.item (yyvsp - 6)), yytype24 (yyvs.item (yyvsp - 3)), yytype78 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval41
		end

	yy_do_action_285 is
			--|#line 1370 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1370")
end


			yyval := yyval84
		end

	yy_do_action_286 is
			--|#line 1372 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1372")
end

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_287 is
			--|#line 1376 "eiffel.y"
		local
			yyval40: INVARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1376")
end


			yyval := yyval40
		end

	yy_do_action_288 is
			--|#line 1378 "eiffel.y"
		local
			yyval40: INVARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1378")
end

				id_level := Normal_level
				inherit_context := False
				yyval40 := new_invariant_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval40
		end

	yy_do_action_289 is
			--|#line 1378 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1378")
end
			yyval := yyval_default;
id_level := Invariant_level 

		end

	yy_do_action_290 is
			--|#line 1388 "eiffel.y"
		local
			yyval61: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1388")
end


			yyval := yyval61
		end

	yy_do_action_291 is
			--|#line 1390 "eiffel.y"
		local
			yyval61: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1390")
end

yyval61 := new_variant_as (yytype31 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval61
		end

	yy_do_action_292 is
			--|#line 1392 "eiffel.y"
		local
			yyval61: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1392")
end

yyval61 := new_variant_as (Void, yytype24 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval61
		end

	yy_do_action_293 is
			--|#line 1396 "eiffel.y"
		local
			yyval20: DEBUG_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1396")
end

				yyval20 := new_debug_as (yytype83 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval20
		end

	yy_do_action_294 is
			--|#line 1402 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1402")
end


			yyval := yyval83
		end

	yy_do_action_295 is
			--|#line 1404 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1404")
end


			yyval := yyval83
		end

	yy_do_action_296 is
			--|#line 1406 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1406")
end

yyval83 := yytype83 (yyvs.item (yyvsp - 1)) 
			yyval := yyval83
		end

	yy_do_action_297 is
			--|#line 1410 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1410")
end

				yyval83 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval83.extend (yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_298 is
			--|#line 1415 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1415")
end

				yyval83 := yytype83 (yyvs.item (yyvsp - 2))
				yyval83.extend (yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_299 is
			--|#line 1422 "eiffel.y"
		local
			yyval51: RETRY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1422")
end

yyval51 := new_retry_as (current_position) 
			yyval := yyval51
		end

	yy_do_action_300 is
			--|#line 1426 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1426")
end


			yyval := yyval78
		end

	yy_do_action_301 is
			--|#line 1428 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1428")
end

				yyval78 := yytype78 (yyvs.item (yyvsp))
				if yyval78 = Void then
					yyval78 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval78
		end

	yy_do_action_302 is
			--|#line 1437 "eiffel.y"
		local
			yyval5: ASSIGN_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1437")
end

yyval5 := new_assign_as (new_access_id_as (yytype31 (yyvs.item (yyvsp - 2)), Void), yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_303 is
			--|#line 1439 "eiffel.y"
		local
			yyval5: ASSIGN_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1439")
end

yyval5 := new_assign_as (new_result_as, yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_304 is
			--|#line 1443 "eiffel.y"
		local
			yyval52: REVERSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1443")
end

yyval52 := new_reverse_as (new_access_id_as (yytype31 (yyvs.item (yyvsp - 2)), Void), yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval52
		end

	yy_do_action_305 is
			--|#line 1445 "eiffel.y"
		local
			yyval52: REVERSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1445")
end

yyval52 := new_reverse_as (new_result_as, yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval52
		end

	yy_do_action_306 is
			--|#line 1449 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1449")
end


			yyval := yyval65
		end

	yy_do_action_307 is
			--|#line 1451 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1451")
end

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_308 is
			--|#line 1455 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1455")
end

				yyval65 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval65.extend (yytype17 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_309 is
			--|#line 1460 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1460")
end

				yyval65 := yytype65 (yyvs.item (yyvsp - 1))
				yyval65.extend (yytype17 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_310 is
			--|#line 1467 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1467")
end

				inherit_context := False
				yyval17 := new_create_as (Void, Void)
			
			yyval := yyval17
		end

	yy_do_action_311 is
			--|#line 1473 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1473")
end

				inherit_context := False
				yyval17 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp)))
			
			yyval := yyval17
		end

	yy_do_action_312 is
			--|#line 1478 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1478")
end

				inherit_context := False
				yyval17 := new_create_as (new_client_as (yytype74 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval17
		end

	yy_do_action_313 is
			--|#line 1483 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1483")
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

	yy_do_action_314 is
			--|#line 1493 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1493")
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

	yy_do_action_315 is
			--|#line 1503 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1503")
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

	yy_do_action_316 is
			--|#line 1515 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1515")
end

yyval55 := new_routine_creation_as (new_result_operand_as, yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_317 is
			--|#line 1518 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1518")
end

yyval55 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_318 is
			--|#line 1520 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1520")
end

yyval55 := new_routine_creation_as (new_operand_as (Void, yytype31 (yyvs.item (yyvsp - 3)), Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_319 is
			--|#line 1522 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1522")
end

yyval55 := new_routine_creation_as (new_operand_as (Void, Void, yytype24 (yyvs.item (yyvsp - 4))), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_320 is
			--|#line 1524 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1524")
end

yyval55 := new_routine_creation_as (new_operand_as (yytype59 (yyvs.item (yyvsp - 4)), Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_321 is
			--|#line 1526 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1526")
end

yyval55 := new_routine_creation_as (Void, yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_322 is
			--|#line 1528 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1528")
end

yyval55 := new_unqualified_routine_creation_as (new_operand_as (Void, Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_323 is
			--|#line 1530 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1530")
end

			yyval55 := new_routine_creation_as (new_result_operand_as, yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_324 is
			--|#line 1539 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1539")
end

			yyval55 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_325 is
			--|#line 1548 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1548")
end

			yyval55 := new_routine_creation_as (new_operand_as (Void, yytype31 (yyvs.item (yyvsp - 4)), Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
			
		
			yyval := yyval55
		end

	yy_do_action_326 is
			--|#line 1558 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1558")
end

			yyval55 := new_routine_creation_As (new_operand_as (Void, Void, yytype24 (yyvs.item (yyvsp - 5))), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_327 is
			--|#line 1567 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1567")
end

			yyval55 := new_routine_creation_as (new_operand_as (yytype59 (yyvs.item (yyvsp - 4)), Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_328 is
			--|#line 1576 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1576")
end

			yyval55 := new_routine_creation_as (Void, yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_329 is
			--|#line 1585 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1585")
end

			yyval55 := new_unqualified_routine_creation_as (new_operand_as (Void, Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_330 is
			--|#line 1596 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1596")
end


			yyval := yyval80
		end

	yy_do_action_331 is
			--|#line 1598 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1598")
end

yyval80 := yytype80 (yyvs.item (yyvsp - 1)) 
			yyval := yyval80
		end

	yy_do_action_332 is
			--|#line 1602 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1602")
end

				yyval80 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval80.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_333 is
			--|#line 1607 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1607")
end

				yyval80 := yytype80 (yyvs.item (yyvsp - 2))
				yyval80.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_334 is
			--|#line 1614 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1614")
end

yyval44 := new_operand_as (Void, Void, Void) 
			yyval := yyval44
		end

	yy_do_action_335 is
			--|#line 1616 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1616")
end

yyval44 := new_operand_as (Void, Void, yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval44
		end

	yy_do_action_336 is
			--|#line 1618 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1618")
end

yyval44 := new_operand_as (yytype59 (yyvs.item (yyvsp - 1)), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_337 is
			--|#line 1622 "eiffel.y"
		local
			yyval18: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1622")
end

				yyval18 := new_creation_as (yytype59 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 5)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 5)).start_position,
						yytype93 (yyvs.item (yyvsp - 5)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval18
		end

	yy_do_action_338 is
			--|#line 1631 "eiffel.y"
		local
			yyval18: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1631")
end

yyval18 := new_creation_as (Void, yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval18
		end

	yy_do_action_339 is
			--|#line 1633 "eiffel.y"
		local
			yyval18: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1633")
end

yyval18 := new_creation_as (yytype59 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 6))) 
			yyval := yyval18
		end

	yy_do_action_340 is
			--|#line 1637 "eiffel.y"
		local
			yyval19: CREATION_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1637")
end

yyval19 := new_creation_expr_as (yytype59 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval19
		end

	yy_do_action_341 is
			--|#line 1639 "eiffel.y"
		local
			yyval19: CREATION_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1639")
end

				yyval19 := new_creation_expr_as (yytype59 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 1)).start_position,
						yytype93 (yyvs.item (yyvsp - 1)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval19
		end

	yy_do_action_342 is
			--|#line 1650 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1650")
end


			yyval := yyval59
		end

	yy_do_action_343 is
			--|#line 1652 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1652")
end

yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
		end

	yy_do_action_344 is
			--|#line 1656 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1656")
end

yyval1 := new_access_id_as (yytype31 (yyvs.item (yyvsp)), Void) 
			yyval := yyval1
		end

	yy_do_action_345 is
			--|#line 1658 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1658")
end

yyval1 := new_result_as 
			yyval := yyval1
		end

	yy_do_action_346 is
			--|#line 1662 "eiffel.y"
		local
			yyval3: ACCESS_INV_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1662")
end


			yyval := yyval3
		end

	yy_do_action_347 is
			--|#line 1664 "eiffel.y"
		local
			yyval3: ACCESS_INV_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1664")
end

yyval3 := new_access_inv_as (yytype31 (yyvs.item (yyvsp - 1)), yytype68 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_348 is
			--|#line 1672 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1672")
end

yyval35 := new_instr_call_as (yytype1 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_349 is
			--|#line 1674 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1674")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_350 is
			--|#line 1676 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1676")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_351 is
			--|#line 1678 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1678")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_352 is
			--|#line 1680 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1680")
end

yyval35 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_353 is
			--|#line 1682 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1682")
end

yyval35 := new_instr_call_as (yytype46 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_354 is
			--|#line 1684 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1684")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_355 is
			--|#line 1686 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1686")
end

yyval35 := new_instr_call_as (yytype47 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_356 is
			--|#line 1688 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1688")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_357 is
			--|#line 1692 "eiffel.y"
		local
			yyval13: CHECK_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1692")
end

yyval13 := new_check_as (yytype84 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 3)), current_position) 
			yyval := yyval13
		end

	yy_do_action_358 is
			--|#line 1700 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1700")
end

create {VALUE_AS} yyval24.initialize (yytype6 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_359 is
			--|#line 1702 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1702")
end

create {VALUE_AS} yyval24.initialize (yytype4 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_360 is
			--|#line 1704 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1704")
end

create {VALUE_AS} yyval24.initialize (yytype58 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_361 is
			--|#line 1706 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1706")
end

yyval24 := new_expr_call_as (yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_362 is
			--|#line 1708 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1708")
end

yyval24 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval24
		end

	yy_do_action_363 is
			--|#line 1710 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1710")
end

yyval24 := new_paran_as (yytype24 (yyvs.item (yyvsp - 1))) 
			yyval := yyval24
		end

	yy_do_action_364 is
			--|#line 1712 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1712")
end

yyval24 := new_bin_plus_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_365 is
			--|#line 1714 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1714")
end

yyval24 := new_bin_minus_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_366 is
			--|#line 1716 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1716")
end

yyval24 := new_bin_star_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_367 is
			--|#line 1718 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1718")
end

yyval24 := new_bin_slash_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_368 is
			--|#line 1720 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1720")
end

yyval24 := new_bin_mod_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_369 is
			--|#line 1722 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1722")
end

yyval24 := new_bin_div_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_370 is
			--|#line 1724 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1724")
end

yyval24 := new_bin_power_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_371 is
			--|#line 1726 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1726")
end

yyval24 := new_bin_and_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_372 is
			--|#line 1728 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1728")
end

yyval24 := new_bin_and_then_as (yytype24 (yyvs.item (yyvsp - 3)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_373 is
			--|#line 1730 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1730")
end

yyval24 := new_bin_or_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_374 is
			--|#line 1732 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1732")
end

yyval24 := new_bin_or_else_as (yytype24 (yyvs.item (yyvsp - 3)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_375 is
			--|#line 1734 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1734")
end

yyval24 := new_bin_implies_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_376 is
			--|#line 1736 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1736")
end

yyval24 := new_bin_xor_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_377 is
			--|#line 1738 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1738")
end

yyval24 := new_bin_ge_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_378 is
			--|#line 1740 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1740")
end

yyval24 := new_bin_gt_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_379 is
			--|#line 1742 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1742")
end

yyval24 := new_bin_le_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_380 is
			--|#line 1744 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1744")
end

yyval24 := new_bin_lt_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_381 is
			--|#line 1746 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1746")
end

yyval24 := new_bin_eq_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_382 is
			--|#line 1748 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1748")
end

yyval24 := new_bin_ne_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_383 is
			--|#line 1750 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1750")
end

yyval24 := new_bin_free_as (yytype24 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp - 1)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_384 is
			--|#line 1752 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1752")
end

yyval24 := new_un_minus_as (yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_385 is
			--|#line 1754 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1754")
end

yyval24 := new_un_plus_as (yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_386 is
			--|#line 1756 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1756")
end

yyval24 := new_un_not_as (yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_387 is
			--|#line 1758 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1758")
end

yyval24 := new_un_old_as (yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_388 is
			--|#line 1760 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1760")
end

yyval24 := new_un_free_as (yytype31 (yyvs.item (yyvsp - 1)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_389 is
			--|#line 1762 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1762")
end

yyval24 := new_un_strip_as (yytype76 (yyvs.item (yyvsp - 1))) 
			yyval := yyval24
		end

	yy_do_action_390 is
			--|#line 1764 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1764")
end

yyval24 := new_address_as (yytype89 (yyvs.item (yyvsp)).first) 
			yyval := yyval24
		end

	yy_do_action_391 is
			--|#line 1766 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1766")
end

yyval24 := new_expr_address_as (yytype24 (yyvs.item (yyvsp - 1))) 
			yyval := yyval24
		end

	yy_do_action_392 is
			--|#line 1768 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1768")
end

yyval24 := new_address_current_as 
			yyval := yyval24
		end

	yy_do_action_393 is
			--|#line 1770 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1770")
end

yyval24 := new_address_result_as 
			yyval := yyval24
		end

	yy_do_action_394 is
			--|#line 1774 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1774")
end

create yyval31.initialize (token_buffer) 
			yyval := yyval31
		end

	yy_do_action_395 is
			--|#line 1782 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1782")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_396 is
			--|#line 1784 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1784")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_397 is
			--|#line 1786 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1786")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_398 is
			--|#line 1788 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1788")
end

yyval10 := new_current_as 
			yyval := yyval10
		end

	yy_do_action_399 is
			--|#line 1790 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1790")
end

yyval10 := new_result_as 
			yyval := yyval10
		end

	yy_do_action_400 is
			--|#line 1792 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1792")
end

yyval10 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_401 is
			--|#line 1794 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1794")
end

yyval10 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_402 is
			--|#line 1796 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1796")
end

yyval10 := yytype46 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_403 is
			--|#line 1798 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1798")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_404 is
			--|#line 1800 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1800")
end

yyval10 := yytype47 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_405 is
			--|#line 1802 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1802")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_406 is
			--|#line 1804 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1804")
end

yyval10 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_407 is
			--|#line 1808 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1808")
end

yyval42 := new_nested_as (new_current_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_408 is
			--|#line 1812 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1812")
end

yyval42 := new_nested_as (new_result_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_409 is
			--|#line 1816 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1816")
end

yyval42 := new_nested_as (yytype1 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_410 is
			--|#line 1820 "eiffel.y"
		local
			yyval43: NESTED_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1820")
end

yyval43 := new_nested_expr_as (yytype24 (yyvs.item (yyvsp - 3)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval43
		end

	yy_do_action_411 is
			--|#line 1824 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1824")
end

yyval42 := new_nested_as (yytype46 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_412 is
			--|#line 1828 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1828")
end

yyval46 := new_precursor_as (Void, yytype68 (yyvs.item (yyvsp))) 
			yyval := yyval46
		end

	yy_do_action_413 is
			--|#line 1830 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1830")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 2)), yytype68 (yyvs.item (yyvsp)), Void) 
			yyval := yyval46
		end

	yy_do_action_414 is
			--|#line 1832 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1832")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 5)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_415 is
			--|#line 1834 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1834")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_416 is
			--|#line 1836 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1836")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_417 is
			--|#line 1838 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1838")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_418 is
			--|#line 1840 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1840")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_419 is
			--|#line 1842 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1842")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_420 is
			--|#line 1844 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1844")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_421 is
			--|#line 1846 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1846")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_422 is
			--|#line 1848 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1848")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_423 is
			--|#line 1850 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1850")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_424 is
			--|#line 1852 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1852")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_425 is
			--|#line 1854 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1854")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_426 is
			--|#line 1856 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1856")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_427 is
			--|#line 1860 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1860")
end

yyval42 := new_nested_as (yytype47 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_428 is
			--|#line 1864 "eiffel.y"
		local
			yyval47: STATIC_ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1864")
end

				yyval47 := new_static_access_as (yytype59 (yyvs.item (yyvsp - 4)), yytype31 (yyvs.item (yyvsp - 1)), yytype68 (yyvs.item (yyvsp)));
			
			yyval := yyval47
		end

	yy_do_action_429 is
			--|#line 1871 "eiffel.y"
		local
			yyval47: STATIC_ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1871")
end

				yyval47 := new_static_access_as (yytype59 (yyvs.item (yyvsp - 3)), yytype31 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval47
		end

	yy_do_action_430 is
			--|#line 1879 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1879")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_431 is
			--|#line 1881 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1881")
end

yyval10 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_432 is
			--|#line 1885 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1885")
end

yyval42 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_433 is
			--|#line 1887 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1887")
end

yyval42 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype42 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_434 is
			--|#line 1891 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1891")
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

	yy_do_action_435 is
			--|#line 1904 "eiffel.y"
		local
			yyval2: ACCESS_FEAT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1904")
end

yyval2 := new_access_feat_as (yytype31 (yyvs.item (yyvsp - 1)), yytype68 (yyvs.item (yyvsp))) 
			yyval := yyval2
		end

	yy_do_action_436 is
			--|#line 1908 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1908")
end


			yyval := yyval68
		end

	yy_do_action_437 is
			--|#line 1910 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1910")
end


			yyval := yyval68
		end

	yy_do_action_438 is
			--|#line 1912 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1912")
end

yyval68 := yytype68 (yyvs.item (yyvsp - 1)) 
			yyval := yyval68
		end

	yy_do_action_439 is
			--|#line 1916 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1916")
end

				yyval68 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval68.extend (yytype24 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_440 is
			--|#line 1921 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1921")
end

				yyval68 := yytype68 (yyvs.item (yyvsp - 2))
				yyval68.extend (yytype24 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_441 is
			--|#line 1928 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1928")
end

yyval68 := new_eiffel_list_expr_as (0) 
			yyval := yyval68
		end

	yy_do_action_442 is
			--|#line 1930 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1930")
end

yyval68 := yytype68 (yyvs.item (yyvsp)) 
			yyval := yyval68
		end

	yy_do_action_443 is
			--|#line 1934 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1934")
end

				yyval68 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval68.extend (yytype24 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_444 is
			--|#line 1939 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1939")
end

				yyval68 := yytype68 (yyvs.item (yyvsp - 2))
				yyval68.extend (yytype24 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_445 is
			--|#line 1950 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1950")
end

create yyval31.initialize (token_buffer) 
			yyval := yyval31
		end

	yy_do_action_446 is
			--|#line 1952 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1952")
end

yyval31 := new_boolean_id_as 
			yyval := yyval31
		end

	yy_do_action_447 is
			--|#line 1954 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1954")
end

yyval31 := new_character_id_as (False) 
			yyval := yyval31
		end

	yy_do_action_448 is
			--|#line 1956 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1956")
end

yyval31 := new_character_id_as (True) 
			yyval := yyval31
		end

	yy_do_action_449 is
			--|#line 1958 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1958")
end

yyval31 := new_double_id_as 
			yyval := yyval31
		end

	yy_do_action_450 is
			--|#line 1960 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1960")
end

yyval31 := new_integer_id_as (8) 
			yyval := yyval31
		end

	yy_do_action_451 is
			--|#line 1962 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1962")
end

yyval31 := new_integer_id_as (16) 
			yyval := yyval31
		end

	yy_do_action_452 is
			--|#line 1964 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1964")
end

yyval31 := new_integer_id_as (32) 
			yyval := yyval31
		end

	yy_do_action_453 is
			--|#line 1966 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1966")
end

yyval31 := new_integer_id_as (64) 
			yyval := yyval31
		end

	yy_do_action_454 is
			--|#line 1968 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1968")
end

yyval31 := new_none_id_as 
			yyval := yyval31
		end

	yy_do_action_455 is
			--|#line 1970 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1970")
end

yyval31 := new_pointer_id_as 
			yyval := yyval31
		end

	yy_do_action_456 is
			--|#line 1972 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1972")
end

yyval31 := new_real_id_as 
			yyval := yyval31
		end

	yy_do_action_457 is
			--|#line 1976 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1976")
end

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_458 is
			--|#line 1978 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1978")
end

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_459 is
			--|#line 1980 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1980")
end

yyval6 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_460 is
			--|#line 1982 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1982")
end

yyval6 := yytype48 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_461 is
			--|#line 1984 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1984")
end

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_462 is
			--|#line 1986 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1986")
end

yyval6 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_463 is
			--|#line 1990 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1990")
end

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_464 is
			--|#line 1992 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1992")
end

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_465 is
			--|#line 1994 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1994")
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

	yy_do_action_466 is
			--|#line 2009 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2009")
end

yyval6 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval6
		end

	yy_do_action_467 is
			--|#line 2011 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2011")
end

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_468 is
			--|#line 2013 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2013")
end

yyval6 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_469 is
			--|#line 2017 "eiffel.y"
		local
			yyval9: BOOL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2017")
end

yyval9 := new_boolean_as (False) 
			yyval := yyval9
		end

	yy_do_action_470 is
			--|#line 2019 "eiffel.y"
		local
			yyval9: BOOL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2019")
end

yyval9 := new_boolean_as (True) 
			yyval := yyval9
		end

	yy_do_action_471 is
			--|#line 2023 "eiffel.y"
		local
			yyval12: CHAR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2023")
end

				check is_character: not token_buffer.is_empty end
				yyval12 := new_character_as (token_buffer.item (1))
			
			yyval := yyval12
		end

	yy_do_action_472 is
			--|#line 2030 "eiffel.y"
		local
			yyval37: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2030")
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

	yy_do_action_473 is
			--|#line 2045 "eiffel.y"
		local
			yyval37: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2045")
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

	yy_do_action_474 is
			--|#line 2060 "eiffel.y"
		local
			yyval37: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2060")
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

	yy_do_action_475 is
			--|#line 2078 "eiffel.y"
		local
			yyval48: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2078")
end

yyval48 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval48
		end

	yy_do_action_476 is
			--|#line 2080 "eiffel.y"
		local
			yyval48: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2080")
end

yyval48 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval48
		end

	yy_do_action_477 is
			--|#line 2082 "eiffel.y"
		local
			yyval48: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2082")
end

				token_buffer.precede ('-')
				yyval48 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval48
		end

	yy_do_action_478 is
			--|#line 2089 "eiffel.y"
		local
			yyval7: BIT_CONST_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2089")
end

yyval7 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval7
		end

	yy_do_action_479 is
			--|#line 2093 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2093")
end

yyval56 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval56
		end

	yy_do_action_480 is
			--|#line 2095 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2095")
end

yyval56 := new_empty_string_as 
			yyval := yyval56
		end

	yy_do_action_481 is
			--|#line 2097 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2097")
end

yyval56 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval56
		end

	yy_do_action_482 is
			--|#line 2101 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2101")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_483 is
			--|#line 2103 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2103")
end

yyval56 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval56
		end

	yy_do_action_484 is
			--|#line 2105 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2105")
end

yyval56 := new_lt_string_as 
			yyval := yyval56
		end

	yy_do_action_485 is
			--|#line 2107 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2107")
end

yyval56 := new_le_string_as 
			yyval := yyval56
		end

	yy_do_action_486 is
			--|#line 2109 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2109")
end

yyval56 := new_gt_string_as 
			yyval := yyval56
		end

	yy_do_action_487 is
			--|#line 2111 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2111")
end

yyval56 := new_ge_string_as 
			yyval := yyval56
		end

	yy_do_action_488 is
			--|#line 2113 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2113")
end

yyval56 := new_minus_string_as 
			yyval := yyval56
		end

	yy_do_action_489 is
			--|#line 2115 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2115")
end

yyval56 := new_plus_string_as 
			yyval := yyval56
		end

	yy_do_action_490 is
			--|#line 2117 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2117")
end

yyval56 := new_star_string_as 
			yyval := yyval56
		end

	yy_do_action_491 is
			--|#line 2119 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2119")
end

yyval56 := new_slash_string_as 
			yyval := yyval56
		end

	yy_do_action_492 is
			--|#line 2121 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2121")
end

yyval56 := new_mod_string_as 
			yyval := yyval56
		end

	yy_do_action_493 is
			--|#line 2123 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2123")
end

yyval56 := new_div_string_as 
			yyval := yyval56
		end

	yy_do_action_494 is
			--|#line 2125 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2125")
end

yyval56 := new_power_string_as 
			yyval := yyval56
		end

	yy_do_action_495 is
			--|#line 2127 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2127")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_496 is
			--|#line 2129 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2129")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_497 is
			--|#line 2131 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2131")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_498 is
			--|#line 2133 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2133")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_499 is
			--|#line 2135 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2135")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_500 is
			--|#line 2137 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2137")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_501 is
			--|#line 2139 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2139")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_502 is
			--|#line 2141 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2141")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_503 is
			--|#line 2145 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2145")
end

yyval90 := new_clickable_string (new_minus_string_as) 
			yyval := yyval90
		end

	yy_do_action_504 is
			--|#line 2147 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2147")
end

yyval90 := new_clickable_string (new_plus_string_as) 
			yyval := yyval90
		end

	yy_do_action_505 is
			--|#line 2149 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2149")
end

yyval90 := new_clickable_string (new_not_string_as) 
			yyval := yyval90
		end

	yy_do_action_506 is
			--|#line 2151 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2151")
end

yyval90 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval90
		end

	yy_do_action_507 is
			--|#line 2155 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2155")
end

yyval90 := new_clickable_string (new_lt_string_as) 
			yyval := yyval90
		end

	yy_do_action_508 is
			--|#line 2157 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2157")
end

yyval90 := new_clickable_string (new_le_string_as) 
			yyval := yyval90
		end

	yy_do_action_509 is
			--|#line 2159 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2159")
end

yyval90 := new_clickable_string (new_gt_string_as) 
			yyval := yyval90
		end

	yy_do_action_510 is
			--|#line 2161 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2161")
end

yyval90 := new_clickable_string (new_ge_string_as) 
			yyval := yyval90
		end

	yy_do_action_511 is
			--|#line 2163 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2163")
end

yyval90 := new_clickable_string (new_minus_string_as) 
			yyval := yyval90
		end

	yy_do_action_512 is
			--|#line 2165 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2165")
end

yyval90 := new_clickable_string (new_plus_string_as) 
			yyval := yyval90
		end

	yy_do_action_513 is
			--|#line 2167 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2167")
end

yyval90 := new_clickable_string (new_star_string_as) 
			yyval := yyval90
		end

	yy_do_action_514 is
			--|#line 2169 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2169")
end

yyval90 := new_clickable_string (new_slash_string_as) 
			yyval := yyval90
		end

	yy_do_action_515 is
			--|#line 2171 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2171")
end

yyval90 := new_clickable_string (new_mod_string_as) 
			yyval := yyval90
		end

	yy_do_action_516 is
			--|#line 2173 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2173")
end

yyval90 := new_clickable_string (new_div_string_as) 
			yyval := yyval90
		end

	yy_do_action_517 is
			--|#line 2175 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2175")
end

yyval90 := new_clickable_string (new_power_string_as) 
			yyval := yyval90
		end

	yy_do_action_518 is
			--|#line 2177 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2177")
end

yyval90 := new_clickable_string (new_and_string_as) 
			yyval := yyval90
		end

	yy_do_action_519 is
			--|#line 2179 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2179")
end

yyval90 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval90
		end

	yy_do_action_520 is
			--|#line 2181 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2181")
end

yyval90 := new_clickable_string (new_implies_string_as) 
			yyval := yyval90
		end

	yy_do_action_521 is
			--|#line 2183 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2183")
end

yyval90 := new_clickable_string (new_or_string_as) 
			yyval := yyval90
		end

	yy_do_action_522 is
			--|#line 2185 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2185")
end

yyval90 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval90
		end

	yy_do_action_523 is
			--|#line 2187 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2187")
end

yyval90 := new_clickable_string (new_xor_string_as) 
			yyval := yyval90
		end

	yy_do_action_524 is
			--|#line 2189 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2189")
end

yyval90 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval90
		end

	yy_do_action_525 is
			--|#line 2193 "eiffel.y"
		local
			yyval4: ARRAY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2193")
end

yyval4 := new_array_as (yytype68 (yyvs.item (yyvsp - 1))) 
			yyval := yyval4
		end

	yy_do_action_526 is
			--|#line 2197 "eiffel.y"
		local
			yyval58: TUPLE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2197")
end

yyval58 := new_tuple_as (yytype68 (yyvs.item (yyvsp - 1))) 
			yyval := yyval58
		end

	yy_do_action_527 is
			--|#line 2201 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2201")
end
			yyval := yyval_default;


		end

	yy_do_action_528 is
			--|#line 2205 "eiffel.y"
		local
			yyval93: TOKEN_LOCATION
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2205")
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
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  309,  309,  310,  312,  287,  287,  287,  287,  287,
			  287,  287,  287,  287,  287,  287,  287,  288,  289,  290,
			  296,  291,  293,  294,  292,  295,  297,  298,  299,  258,
			  258,  258,  260,  260,  260,  261,  261,  261,  259,  259,
			  178,  175,  175,  224,  224,  224,  144,  144,  144,  144,
			  311,  311,  311,  311,  314,  314,  315,  315,  209,  209,
			  241,  241,  242,  242,  171,  171,  156,  316,  155,  155,
			  254,  254,  255,  255,  240,  240,  313,  313,  170,  306,
			  306,  303,  318,  318,  302,  302,  302,  300,  301,  148,
			  157,  157,  158,  158,  158,  270,  270,  270,  271,  271,

			  196,  196,  197,  197,  197,  197,  197,  197,  197,  272,
			  272,  273,  273,  202,  234,  234,  233,  233,  235,  235,
			  166,  172,  172,  228,  228,  227,  227,  159,  159,  243,
			  243,  245,  245,  244,  244,  247,  247,  246,  246,  249,
			  249,  248,  248,  281,  281,  282,  282,  283,  283,  221,
			  319,  319,  285,  285,  286,  286,  222,  256,  256,  257,
			  257,  217,  217,  207,  320,  206,  206,  206,  168,  169,
			  211,  211,  184,  184,  284,  284,  263,  263,  264,  264,
			  181,  317,  317,  182,  182,  182,  182,  182,  182,  182,
			  182,  182,  182,  203,  203,  322,  203,  323,  165,  165,

			  324,  165,  325,  276,  276,  277,  277,  213,  214,  214,
			  214,  216,  216,  220,  220,  220,  220,  220,  220,  218,
			  218,  218,  218,  218,  218,  218,  218,  218,  218,  218,
			  218,  279,  279,  279,  280,  280,  251,  251,  252,  252,
			  253,  253,  173,  326,  307,  307,  250,  250,  177,  231,
			  231,  232,  232,  164,  265,  265,  179,  225,  225,  226,
			  226,  152,  267,  267,  185,  185,  185,  185,  185,  185,
			  185,  185,  185,  185,  185,  185,  185,  185,  185,  185,
			  185,  185,  266,  266,  187,  278,  278,  186,  186,  327,
			  223,  223,  223,  163,  274,  274,  274,  275,  275,  204,

			  262,  262,  143,  143,  205,  205,  229,  229,  230,  230,
			  160,  160,  160,  160,  160,  160,  208,  208,  208,  208,
			  208,  208,  208,  208,  208,  208,  208,  208,  208,  208,
			  268,  268,  269,  269,  195,  195,  195,  161,  161,  161,
			  162,  162,  219,  219,  138,  138,  141,  141,  180,  180,
			  180,  180,  180,  180,  180,  180,  180,  154,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  176,  151,  151,  151,  151,  151,

			  151,  151,  151,  151,  151,  151,  151,  192,  191,  190,
			  194,  189,  198,  198,  198,  198,  198,  198,  198,  198,
			  198,  198,  198,  198,  198,  198,  198,  193,  199,  200,
			  150,  150,  188,  188,  139,  140,  236,  236,  236,  237,
			  237,  238,  238,  239,  239,  174,  174,  174,  174,  174,
			  174,  174,  174,  174,  174,  174,  174,  145,  145,  145,
			  145,  145,  145,  146,  146,  146,  146,  146,  146,  149,
			  149,  153,  183,  183,  183,  201,  201,  201,  147,  210,
			  210,  210,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,

			  212,  212,  212,  305,  305,  305,  305,  304,  304,  304,
			  304,  304,  304,  304,  304,  304,  304,  304,  304,  304,
			  304,  304,  304,  304,  304,  142,  215,  321,  308>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,    1,    2,   17,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    0,
			    2,    1,    0,    2,    1,    0,    3,    2,    1,    2,
			    3,    2,    0,    1,    3,    1,    1,    1,    2,    3,
			    2,    2,    3,    3,    0,    1,    0,    1,    0,    2,
			    0,    1,    1,    2,    1,    2,    3,    0,    0,    1,
			    2,    3,    1,    3,    1,    2,    0,    1,    3,    1,
			    3,    2,    0,    1,    1,    1,    1,    2,    2,    3,
			    1,    2,    2,    2,    2,    0,    2,    2,    1,    2,

			    2,    3,    2,    8,    7,    6,    5,    4,    3,    1,
			    2,    1,    3,    3,    0,    1,    2,    2,    1,    2,
			    3,    1,    1,    0,    2,    1,    3,    6,    5,    1,
			    3,    0,    1,    1,    2,    0,    1,    1,    2,    0,
			    1,    1,    2,    0,    3,    0,    1,    1,    2,    6,
			    0,    3,    0,    1,    1,    2,    5,    1,    3,    0,
			    1,    0,    2,    8,    0,    1,    1,    1,    3,    2,
			    0,    2,    2,    2,    0,    2,    1,    2,    1,    2,
			    3,    0,    2,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    0,    3,    0,    4,    0,    0,    3,

			    0,    4,    0,    0,    1,    1,    2,    3,    2,    4,
			    3,    1,    1,    3,    3,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    0,    2,    3,    1,    3,    0,    4,    0,    1,
			    1,    3,    3,    0,    0,    3,    0,    3,    8,    0,
			    1,    1,    2,    5,    0,    2,    6,    0,    1,    1,
			    2,    5,    1,    3,    1,    3,    1,    3,    1,    3,
			    3,    3,    3,    3,    1,    3,    3,    3,    3,    3,
			    3,    3,    0,    2,   10,    0,    2,    0,    3,    0,
			    0,    4,    2,    5,    0,    2,    3,    1,    3,    1,

			    0,    2,    4,    4,    4,    4,    0,    1,    1,    2,
			    1,    3,    2,    2,    4,    3,    5,    5,    5,    7,
			    7,    5,    3,    5,    5,    5,    7,    6,    5,    4,
			    0,    3,    1,    3,    1,    1,    3,    6,    4,    7,
			    6,    5,    0,    1,    1,    1,    0,    3,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    4,    1,    1,
			    1,    1,    1,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    4,    3,    4,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    2,    2,    2,    2,    2,    4,
			    2,    4,    2,    2,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    3,    3,    3,
			    5,    3,    2,    5,    8,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    3,    7,    6,
			    1,    1,    3,    3,    2,    2,    0,    2,    3,    1,
			    3,    0,    1,    1,    3,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    2,    2,    1,    2,    2,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    3,    3,    0,    0>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   29,  456,  455,  454,  448,  453,  451,  450,  452,  449,
			  447,  446,   42,  445,    0,   54,    1,    0,    0,   38,
			   42,   28,   27,   26,   20,   25,   23,   22,   24,   21,
			   19,   18,    0,    0,    0,    0,   17,    2,  211,  212,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,   55,   56,    0,   56,   41,  502,  501,  500,
			  499,  498,  497,  496,  495,  494,  493,  492,  491,  490,
			  489,  488,  487,  486,  485,  484,  481,  483,  480,  470,
			  469,    0,   45,    0,  478,  482,  475,  471,  472,    0,
			    0,   43,   47,  461,  457,  458,    0,   46,  459,  460,

			  462,  479,   76,   39,  231,    5,    6,    8,    9,   12,
			   10,   11,   13,    7,   14,   15,   16,  218,  217,  231,
			    0,    0,  216,  215,    0,  219,  220,  221,  223,  226,
			  224,  225,  227,  222,  228,  229,  230,   57,   51,    0,
			   56,   56,   50,    0,    0,  477,  474,  476,  473,   48,
			  441,    0,    0,   77,   40,  214,  213,  232,  234,    0,
			  528,   53,   52,    0,  528,    0,  399,    0,  436,    0,
			  398,    0,    0,  441,  528,  466,  465,    0,    0,    0,
			    0,  394,    0,    0,  400,  359,  358,  467,  463,  361,
			  464,  406,  443,  436,    0,  403,  397,  396,  395,  405,

			  401,  402,  404,  362,  468,  360,    0,  442,   49,   44,
			  233,    0,  170,    0,  528,  346,  528,  528,    0,    0,
			    0,    0,    0,    0,  330,    0,    0,  412,    0,  528,
			    0,  393,    0,    0,  392,    0,   84,   85,   86,  390,
			    0,    0,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,    0,    0,    0,  387,  159,  386,
			  384,  385,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  528,  434,  388,    0,    0,  526,    0,  235,    0,
			   58,  238,  346,    0,  341,    0,    0,  431,  408,  436,

			  430,    0,    0,    0,    0,    0,    0,    0,  322,    0,
			  437,  439,    0,    0,    0,  407,  506,  505,  504,  503,
			   88,  524,  523,  522,  521,  520,  519,  518,  517,  516,
			  515,  514,  513,  512,  511,  510,  509,  508,  507,   87,
			    0,    0,  528,  528,  528,  528,  528,  528,  528,  528,
			  528,  528,  528,  528,  528,  525,  330,  363,  157,  160,
			    0,  409,  370,  369,  368,  367,  366,  365,  364,  377,
			  379,  378,  380,  381,  382,    0,  371,  376,    0,  373,
			  375,  383,    0,  411,  427,  444,  171,    0,   95,  243,
			  240,    0,  239,  340,  436,  330,  330,    0,  435,  330,

			  330,  330,    0,    0,  334,    0,  335,  332,    0,  330,
			  436,  438,    0,    0,  330,  391,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  329,  528,    0,    0,  389,  372,  374,  330,   59,  528,
			  528,  244,  237,    0,  347,  328,  323,  432,  433,  321,
			  316,  317,    0,    0,    0,  331,    0,  318,  413,  440,
			    0,  324,  528,  330,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,    0,  410,  158,  325,
			   98,  528,    0,   97,  528,    0,  242,  241,  330,  330,
			  336,  333,  436,    0,  327,  415,  416,  417,  419,  422,

			  420,  421,  423,  418,  424,  425,  426,  330,   99,  100,
			  231,  310,  308,  123,  528,    0,  246,  320,  319,  428,
			  436,  326,  101,  102,    0,    0,  312,    0,   60,  309,
			  313,    0,  245,  414,  133,  141,  109,  137,   76,  108,
			  131,  135,  139,    0,  114,   70,    0,   72,  311,  129,
			  125,  124,    0,   67,   82,   62,  528,   61,    0,  315,
			    0,  134,  142,  111,  110,    0,  138,  118,  116,    0,
			  117,  132,  135,  136,  139,  140,    0,  107,  115,  131,
			   71,    0,    0,    0,    0,    0,   68,   83,   74,   82,
			   79,  143,    0,  287,   63,  314,  247,    0,    0,  119,

			  121,   76,  122,  139,    0,  106,  135,   73,  130,  126,
			    0,    0,   66,   69,   75,   82,  145,  181,  161,   81,
			  289,  528,  112,  113,  120,    0,  105,  139,    0,    0,
			   80,  147,  528,    0,  146,   78,    0,   35,  527,   29,
			  104,    0,  128,    0,    0,  144,  148,  182,  162,   32,
			   42,   89,   90,  205,  288,  527,  528,    0,  103,  127,
			  150,   35,   42,   35,   91,   58,   37,   42,  206,   76,
			    0,    4,    3,    0,    0,   93,   42,   92,   94,  164,
			   36,  207,  208,  436,    0,   76,  193,  210,  151,  149,
			  195,  174,  209,  197,  527,  152,    0,  527,  194,  154,

			  528,  175,  153,  181,  528,  181,  167,  166,  165,  198,
			  196,    0,  155,  173,  527,  170,    0,  172,  200,  300,
			    0,  178,  527,  528,  168,  169,  202,  527,  181,    0,
			   76,  179,  299,  528,  181,  185,  191,  183,  190,  187,
			  188,  184,  181,  189,  192,  186,    0,  527,  199,  301,
			  163,  156,    0,  285,  180,    0,    0,  294,    0,  527,
			    0,    0,  342,    0,  348,  436,  354,  350,  349,  351,
			  356,  352,  353,  355,  201,  257,  527,  290,    0,    0,
			    0,    0,  181,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  345,    0,  346,  344,

			  343,    0,    0,    0,    0,  528,  259,  282,  258,  286,
			    0,    0,  303,  305,  181,  295,  297,    0,    0,  357,
			    0,  338,    0,    0,  302,  304,    0,  181,    0,  260,
			  292,  436,  528,  528,  296,    0,  293,    0,  346,    0,
			  266,  268,  264,  262,  274,    0,  283,  256,    0,    0,
			  251,  254,  528,    0,  298,  346,  337,    0,    0,    0,
			    0,    0,  181,    0,  291,    0,  181,    0,  252,    0,
			  339,    0,  267,  273,  281,  272,  269,  270,  276,  271,
			  265,  279,  280,  275,  278,  277,  261,  263,  181,  255,
			  248,    0,    0,    0,  181,    0,  284,  253,  429,    0,

			    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  798,  184,  297,  294,  185,  735,   91,   92,  186,  187,
			  617,  188,  298,  189,  806,  190,  736,  525,  554,  651,
			  664,  550,  512,  737,  191,  738,  850,  719,  567,  192,
			  707,  715,  588,  555,  601,  390,  193,   18,  194,  739,
			   19,  740,  741,  721,  742,   98,  708,  843,  621,  743,
			  300,  195,  196,  197,  198,  199,  200,  407,  480,  509,
			  201,  202,  844,   99,  563,  691,  744,  745,  709,  678,
			  203,  388,  204,  290,  101,  653,  669,  205,  158,  637,
			   38,  801,   39,  631,  699,  811,  102,  807,  808,  551,
			  528,  513,  514,  851,  852,  540,  579,  568,  282,  312,

			  206,  207,  589,  556,  557,  548,  571,  572,  573,  574,
			  575,  576,  532,  212,  391,  392,  569,  546,  632,  360,
			   15,   20,  665,  652,  729,  713,  722,  867,  828,  845,
			  308,  408,  440,  481,  544,  564,  782,  817,  654,  655,
			  777,  125,  159,  618,  633,  634,  696,  701,  702,  236,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  237,  238,  549,  590,  339,  320,  591,  486,
			  482,  899,   16,   54,  672,  154,   55,  138,  586,  714,
			  592,  674,  686,  656,  694,  697,  727,  747,  441,  638>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 2849, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 2602, -32768, 2741,  102, -32768,  668, 2279, -32768,
			 2578, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 2910, 2863, 2910, 1379, -32768, -32768, -32768, -32768,
			  567,  567,  567,  567,  567,  567,  567,  567,  567,  567,
			  567,  567, -32768,  626,  647,   36, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  660, -32768, 2741, -32768, -32768, -32768, -32768, -32768,  243,
			  239, -32768, -32768, -32768, -32768, -32768,   97, -32768, -32768, -32768,

			 -32768, -32768,   48, -32768,  567, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  567,
			  672,  671, -32768, -32768, 2705, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2910,
			  626,  626, -32768, 2741,  659, -32768, -32768, -32768, -32768, -32768,
			 2112,  631, 2403, -32768, -32768, -32768, -32768, -32768, -32768,  164,
			  837, -32768, -32768,  646, -32768,  619,  158, 1082,    4,  644,
			  132,  279, 2685, 2112, -32768, -32768, -32768, 2112, 2112,  661,
			 2112, -32768, 2112, 2112,  370, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 3166,  218, 2112, -32768, -32768, -32768, -32768, -32768,

			 -32768,  358,  351, -32768, -32768, -32768,  637,  645, -32768, -32768,
			 -32768, 2741,  437,  635, -32768,  181, -32768, -32768, 2892,  657,
			  656,  655, 2741, 2112,  410, 2910, 1988, -32768, 2910, -32768,
			 2892, -32768,   57, 3027, -32768, 2112, -32768, -32768, -32768, -32768,
			 2910,  575,  491,  489,  484,  449,  442,  439,  397,  381,
			  371,  357,  327,  315,  634, 2892, 3124, -32768, 2892, -32768,
			 -32768, -32768, 2892, 2112, 2112, 2112, 2112, 2112, 2112, 2112,
			 2112, 2112, 2112, 2112, 2112, 2112, 1864, 2112, 1740, 2112,
			 2112, -32768, -32768, -32768, 2892, 2892, -32768, 2112, -32768, 1385,
			  456,  591,  181, 2892, -32768, 2892, 2892,  598, -32768,  585,

			 -32768, 2892, 2892, 2892,  630, 3082, 2236, 2892, -32768,  628,
			 -32768, 3166,  169,  625, 2892, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 3064,  622, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  592,  111, -32768,  438,
			  629, -32768,  297,  297,  297,  297,  297,  452,  452,  581,
			  581,  581,  581,  581,  581, 2112, 1928, 3181, 2112, 3104,
			 1267, -32768, 2892, -32768, -32768, 3166, -32768, 1238,  589, -32768,
			 -32768,  616,  624, -32768,  585,  592,  592, 2892, -32768,  592,

			  592,  592,  638,  636,  619, 2685, 3166, -32768,   79,  592,
			  585, -32768, 2112,  627,  592, -32768,  584, 2892,  573,  570,
			  569,  562,  561,  559,  558,  557,  556,  555,  551,  550,
			 -32768, -32768, 2892, 2892, -32768, 1928, 3104,  592, -32768,  136,
			 -32768,  577, -32768,  591, -32768, -32768, -32768,  598, -32768, -32768,
			 -32768, -32768, 2892, 2892,  -21, -32768, 2236, -32768, -32768, 3166,
			 2892, -32768, -32768,  592,  585,  585,  585,  585,  585,  585,
			  585,  585,  585,  585,  585,  585, 2892, -32768, -32768, -32768,
			 -32768,  200, 2910, -32768,  433, 2910, -32768, -32768,  592,  592,
			 -32768, -32768,  585,  533, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  592, -32768,  580,
			  567, 2756, -32768,  554,  372,  572,  571, -32768, -32768, -32768,
			  585, -32768, -32768,  311, 2827, 1596, 2796, 1596,  532, -32768,
			 2756, 1596, -32768, -32768, 1596, 1596, 1596, 1596,  119, -32768,
			  476,  481,  469,  544,  540, -32768,  242, -32768,  531, -32768,
			 -32768,  566,   87, -32768,  388, -32768, -32768,  532, 1596, 2796,
			   54,  531,  531, -32768,  553,  537,  531, -32768,  526,  474,
			 -32768, -32768,  481, -32768,  469, -32768,  511, -32768, -32768,  476,
			 -32768, 2910, 1596, 1596,  545,  530,  526, -32768, -32768,  337,
			 -32768,   11, 1596,  496, -32768,  531, -32768, 1596, 1596, -32768,

			 -32768,  411,  531,  469,  503, -32768,  481, -32768, -32768, -32768,
			 2741, 2741, -32768, -32768, -32768,  495, 2892, -32768,  528, -32768,
			 -32768, -32768, -32768, -32768, -32768,  499, -32768,  469,  236,  210,
			 -32768, -32768,  438,  518, 2892,  384, 2741,  -35,   80,  486,
			 -32768,  493, -32768,  513,  515, -32768, -32768, -32768, -32768, 1601,
			 2807, -32768, -32768, -32768, -32768,  260, -32768,  482, -32768, -32768,
			  498,  448, 2519,  448, -32768,  456, -32768, 2387, -32768,  411,
			 2112, -32768, -32768, 2892, 2741, -32768, 2508, -32768, -32768, -32768,
			 -32768, -32768, 3166,  162,  480,  411,  422, 2112, -32768, -32768,
			  446,  419, 3166, -32768,  271, 2892,  395,  271, -32768, -32768,

			  438, -32768, 2892, -32768, -32768, -32768, -32768, -32768, -32768,  414,
			 -32768,  445, -32768, -32768,  451,  437, 1385, -32768,  353,  383,
			 2741, -32768,  455,   53, -32768, -32768, -32768,  -38, -32768,  396,
			  411, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, 1531,  -38, -32768, -32768,
			 -32768, -32768, 2112,  367,  384,   59, 2112,  404,  389,  345,
			 1549, 1710, 2741, 2112,  370,   61, -32768, -32768, -32768, -32768,
			 -32768, -32768,  358,  351, -32768,   52,  191,  257, 2112, 2112,
			 2470, 1345, -32768,  278,  324,  321,  317,  307,  303,  293,
			  289,  285,  281,  277,  272,  266, -32768, 2741,  181, -32768,

			 -32768,  265, 3022, 2112, 2112, -32768, -32768,  247,  196, -32768,
			 2112,  206, 3166, 3166, -32768, -32768, -32768,   -1,  228, -32768,
			  240, -32768, 1125,  253, 3166, 3166, 1153, -32768,  198, -32768,
			 3166,  160, -32768,  187, -32768, 1385, -32768, 1125,  181,  227,
			  251,  245,  232, -32768,  221,  -15, -32768, -32768, 2112, 2112,
			 -32768,  163,  108,  145, -32768,  181, -32768, 2910, 1313, 1153,
			  957, 1153, -32768, 1153, 3166, 2975, -32768,   96, -32768, 2112,
			 -32768,   82, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, 2452,   64,   20, -32768, 2892, -32768, -32768, -32768,   55,

			   38, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -795,   30,  374, -289, -32768, -32768,  617,  117, -32768,   -9,
			 -32768,  -11, -209, -32768,  -44,  -17, -32768, -508, -32768, -32768,
			 -32768,  182,  249, -32768,   -2, -32768,  -92, -32768,  185,  936,
			 -32768, -32768,  166,  201, -32768,  309,    0, -32768,  721, -32768,
			  -18, -32768, -32768,   28, -32768,  -29, -32768, -119, -32768, -32768,
			  346,    5,    3,   -4,   -5,   -7,  -10,  276,  250, -32768,
			  -12,  -13, -333, -32768,  129, -32768, -32768, -32768, -32768, -32768,
			 -32768,   60,  -14,   12, -275,   67, -32768,  632,   17, -32768,
			 -218, -32768, -32768,   89,   19, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  172, -32768, -32768,  861, -32768,

			  542, -32768, -32768, -32768, -32768, -188,  190,  131,  189, -525,
			  188, -500, -32768, -32768, -32768, -32768, -496, -32768, -253, -32768,
			   69, -614, -32768, -375, -32768, -537, -32768, -32768, -32768, -32768,
			 -304, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -648, -32768,
			 -32768, 1202,  -66, -32768, -32768, -32768, -32768, -32768, -32768,    9,
			  313,  283,  255,  137,  109,   93,   88,   18,   15,   10,
			   -3,   -6, -32768, -32768, -158,   94, -32768, -32768, -32768, -32768,
			  947, -32768, -32768, -32768, -32768, -422, -32768,  -32, -32768, -598,
			 -32768, -32768, -32768, -592, -32768, -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		local
			an_array: ARRAY [INTEGER]
		once
			!! an_array.make (0, 3202)
			yytable_template_1 (an_array)
			yytable_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytable_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			   14,   95,  103,  393,  100,  359,  123,   94,   51,   93,
			  313,   50,   17,  239,  386,  526,   96,  483,   97,  635,
			   17,  315,  558,  142,   49,  863,  490,  838, -203,   48,
			  226,   37,   47,  118,  559,  122,  667,  616,  901,  835,
			  650,  104,  855,  119,  834,  649,  698,  603,  676,  710,
			  225,  615,  430,  361, -203,  900,  279,  278,  277,  276,
			  275,  274,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,  264,  263,  181,  604,  383,  384,   51,  612,  748,
			   50,  627,  862,  342,  218,  153,  896,  226,  152,  895,
			  613,  445,  446,   49,  582,  449,  450,  451,   48,  774,

			  144,   47,   46,  625,  141,  457,  137,   45,  161,  162,
			  461,  783,  779,  585,  804,  778,  570,  803,   51,  456,
			  596,   50,  723,   44,  455,  734,  584,  641,  809,  892,
			  723,  733,  140,  479,   49,   95,  432,   51,  100,   48,
			   50,   94,   47,   93,  754,  150, -203,  732,  160,  431,
			   96,   43,   97,   49,  805, -203,  153,  230,   48,  494,
			  163,   47,  890,  149,   53,  524,  253,  224,  717,  252,
			  229,   46, -250,  153, -250,   52,   45,  -76,  -76,  624,
			  319,  318,  251,  218,  517,  518,  226,  250,  226,  241,
			  249,  749,   44,  317,  316,  -76,  217,  753,  281,  848,

			  281,  687,  -76,  521,  211,   51,  293,  -76,   50,  412,
			  869,  -76,   46,  210,  411,  -76,   51,   45,  299,   50,
			   43,   49,   51,  477,  861,   50,   48,  866,  288,   47,
			  299,   46,   49,   44,  309,  860,   45,   48,   49,  304,
			   47,  -96,  -96,   48,  226,  818,   47,  681,  859,  341,
			  211, -249,   44, -249,  858,  356,  281,  643,  358,  -96,
			  248,   43,  299,  689,  847,  247,  -96,  516,  148,   42,
			  147,  -96,  146,  857,  145,  -96,  211,  833,  432,  -96,
			   43,  246,  581,  642,  299,  299,  675,  837,  677,  580,
			  846, -203, -203,  394,  836,  395,  396,   41,  805,   46,

			  822,  399,  400,  401,   45,  235,  832,  409,  751,  245,
			   46,  827,   36,  354,  414,   45,   46,  263,  181,  353,
			   44,   45, -204, -204,  352,  886, -204,   40,  351,  889,
			 -204,   44,  350, -203, -203, -204,  349,   44,   42,  234,
			  348, -203, -204,  560,  819, -204,  561,  562,   43,  566,
			  347,  893, -204, -203,  346,  233, -203,  897,  810,   43,
			 -204, -204,  354,  124,  345,   43,   41,  232,  344,  552,
			  595,  343,  231,  438,  353,  124,  285,  539,  565,   42,
			  538,  602,  437,  284,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,   22,   21,  262,   40,  299,   42,  253,

			  537,  536,  252,  -65,  352,  124,  535,   41,  -65,  534,
			  587, -203,  -65,  511,  230,  251,  -65,  463,  351,  124,
			  250,  647,  454,  249,  608,  552,   41,  244,  350,  124,
			  781, -307,  299,  478,  619,  307,  306,   40, -307,  565,
			  623,  725,  700, -307,  349,  124,  776, -307,  153,  700,
			  726, -307,  488,  489,  -64,  243,   40,  706,  705,  -64,
			  492,  587,  750,  -64,  289,  704,   42,  -64,  267,  266,
			  265,  264,  263,  181,  511,  728,  507,   42,  433,   51,
			  703,  718,   50,   42,  720,  242,  348,  124,  647,  347,
			  124,  510, -306,  248,   41,   49,  346,  124,  247, -306,

			   48,  695,  600,   47, -306,   41,  816,   36, -306,  821,
			  693,   41, -306,  690,  246, -176, -176, -176, -176, -177,
			 -177, -177, -177,  650,   40,  874,  878,  881,  885,  688,
			 -176,  345,  124,  547, -177,   40,  344,  124,  343,  124,
			  387,   40,  245, -176,  628,  629,  673, -177,  671,  856,
			  233, -176, -176, -176,  660, -177, -177, -177,  659,  658,
			  854,   12,  232,  645,  535,  640,  870,  636,  587,  626,
			  537,  582,  524,   46,  534,  620,  611,  605,   45,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,
			  607,  610,  598,  597,   44,  269,  268,  267,  266,  265,

			  264,  263,  181,  553,   51,   51,  583,   50,   50,  538,
			  577,  226,  531,  527,  530,  124,  358,  522,  306,  520,
			   49,   49,   43,  397,  389,   48,   48,  485,   47,   47,
			   51,  462,   95,   50,  358,  100,  475,  474,   94,  871,
			   93,  473,  472,  471,  470,  469,   49,  468,  467,  103,
			   17,   48,  460,  648,   47,  466,  465,  216,  103,  464,
			  244,  453,   17,  452,  443,  442,  439,   17,   51,  416,
			  683,   50,  413,  684,  434,  410,   17,  402,  355,  342,
			  303,  302,  301,  291,   49,  287,  286,  258,  243,   48,
			  228,  685,   47,  214,  164,  358,  137,  208,   46,   46,

			  148,  146,  358,   45,   45,  139,  143,   56,  657,  630,
			  606,  543,  542,  541,   51,  254,  578,   50,  242,   44,
			   44,  712,  668,  646,   46,  679,  622,  724,  151,   45,
			   49,  508,  491,  773,  772,   48,  771,  730,   47,  770,
			   42,  769,  768,  448,  887,   44,  765,   43,   43,  767,
			  731,  766,  487,  599,  795,  614,   51,  794,  594,   50,
			  868,  799,   46,  529,  829,  609,  663,   45,   41,  209,
			  793,  447,   49,   43,    0,  792,  764,   48,  791,  800,
			   47,    0,    0,   44,    0,    0,    0,    0,    0,    0,
			    0,   51,    0,    0,   50,    0,    0,  842,   40,    0,

			    0,    0,    0,    0,    0,    0,    0,   49,   46,  840,
			  831,   43,   48,   45,  820,   47,    0,    0,    0,    0,
			    0,    0,  799,    0,    0,    0,  841,    0,    0,   44,
			  877,  880,  884,    0,  842,    0,    0,  799,    0,    0,
			    0,  872,  875,    0,  882,    0,  840,    0,  790,    0,
			   46,   51,    0,  789,   50,   45,    0,   43,  873,  876,
			  879,  883,    0,  841, -236,   42,   42,   49,    0,  788,
			    0,   44,   48,    0,    0,   47,    0,    0, -236, -236,
			    0,    0,    0,    0,    0,   46,    0,    0,    0,    0,
			   45,   42,    0,   41,   41,  898, -236,  787,    0,   43,

			    0,    0,    0, -236,    0,    0,   44,    0, -236,    0,
			    0,    0, -236,  280, -236,    0, -236,    0,    0,   41,
			    0, -236,    0,   40,   40,    0,    0,    0,    0,   42,
			    0,    0,    0,    0,   43,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   46,    0,    0,    0,   40,
			   45,    0,    0,    0,    0,    0,    0,   41,    0,    0,
			    0,    0,    0,    0,    0,    0,   44,    0,    0,    0,
			    0,  121,  120,    0,    0,   42,    0,  280,  280,    0,
			  280,  280,  280,    0,    0,    0,   88,   40,    0,    0,
			   13,    0,    0,    0,   43,    0,    0,    0,    0,    0,

			    0,    0,    0,   41,  280,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  786,    0,   42,    0,    0,
			    0,    0,    0,    0,    0,    0,  280,    0,  839,  227,
			    0,    0,  280,   40,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  785,    0,   41,    0,    0,    0,    0,
			    0,    0,   42,    0,    0,    0,    0,    0,    0,    0,
			    0,  280,   11,   10,    9,    8,    7,    6,    5,    4,
			    3,    2,    1,  784,    0,   40,    0,    0,    0,    0,
			   41,    0,    0,  280,  280,  280,  280,  280,  280,  280,
			  280,  280,  280,  280,  280,  280,    0,  280,  280,    0,

			  280,  280,  280,    0,    0,    0,  280,  213,  223,    0,
			   40,  215,   42,  256,  257,   13,  259,    0,  260,  261,
			    0,  255,    0,    0,    0,    0,    0,  280,  222,    0,
			  283,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			   41,    0,  221,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  280,  280,   13,  305,
			  398,  292,  311,  295,  296,    0,    0,  121,  120,    0,
			   40,  340,    0,    0,    0,  220,  314,    0,    0,    0,
			  280,    0,   88,   87,    0,  219,   13,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    2,    1,    0,  362,

			  363,  364,  365,  366,  367,  368,  369,  370,  371,  372,
			  373,  374,  376,  377,  379,  380,  381,    0,  796,    0,
			    0,    0,    0,  385,  839,    0,    0,    0,  382,    0,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,    2,
			    1,    0,  406,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,    0,  444,    0,    0,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,    2,    1,    0,
			   85,  458,  278,  277,  276,  275,  274,  273,  272,  271,
			  270,  269,  268,  267,  266,  265,  264,  263,  181,  417,
			  418,  419,  420,  421,  422,  423,  424,  425,  426,  427,

			  428,  429,    0,    0,    0,    0,  155,    0,    0,    0,
			    0,  435,    0,    0,  436,    0,    0,    0,    0,    0,
			    0,  156,    0,    0,    0,  495,  496,  497,  498,  499,
			  500,  501,  502,  503,  504,  505,  506,    0,    0,    0,
			    0,    0,    0,   87,    0,    0,   13,    0,  459,    0,
			    0,    0,    0,  519,   78,   77,   76,   75,   74,   73,
			   72,   71,   70,   69,   68,   67,   66,   65,   64,   63,
			   62,   61,   60,   59,   58,   57,    0,   85,  476,    0,
			    0,  533,    0,    0,  839,    0,    0,  484,    0,    0,
			  815,    0,  406,  121,  120,    0,    0,    0,    0,    0,

			    0,    0,    0,  280,    0,    0,    0,    0,   88,  493,
			    0,    0,   13,  280,    0,    0,    0,   85,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,    2,    1,    0,
			    0,  515,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,    0,    0,    0,    0,
			    0,  515,   77,    0,   75,   74,   73,   72,   71,   70,
			   69,   68,   67,   66,   65,   64,   63,   62,   61,   60,
			   59,   58,   57,    0,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,    2,    1,    0,  280,    0,    0,    0,

			    0,  280,   77,  593,   75,   74,   73,   72,   71,   70,
			   69,   68,   67,   66,   65,   64,   63,   62,   61,   60,
			   59,   58,   57,  280,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  280,  280,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  280,  280,    0,    0,    0,
			    0,  280,    0,    0,    0,    0,    0,  763,    0,    0,
			    0,    0,    0,    0,   13,    0,  762,    0,  639,    0,
			    0,    0,  761,    0,    0,    0,    0,  760,    0,  644,
			    0,    0,   36,    0,    0,  280,  280,    0,  759,    0,
			    0,  758,  757,    0,    0,  240,    0,    0,    0,    0,

			    0,    0,  169,  670,    0,  756,  682,    0,    0,    0,
			    0,    0,  280,    0,    0,   90,   89,  168,    0,    0,
			    0,    0,    0,  692,  755,    0,    0,    0,    0,   36,
			   88,   87,   86,   85,    0,   84,   11,   10,    9,    8,
			    7,    6,    5,    4,    3,    2,    1,  711,    0,    0,
			    0,  716,   80,   79,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,   22,   21,    0,    0,    0,    0,    0,
			  746,    0,  233,    0,    0,    0,  662,    0,    0,    0,
			  752,    0,    0,    0,  232,    0,    0,    0,  775,    0,
			    0,    0,  780,    0,    0,    0,    0,    0,    0,  802,

			  661,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   22,   21,  523,    0,  812,  813,    0,   78,   77,   76,
			   75,   74,   73,   72,   71,   70,   69,   68,   67,   66,
			   65,   64,   63,   62,   61,   60,   59,   58,   57,  824,
			  825,    0,    0,   13,    0,    0,  830,    0,    0,    0,
			    0,    0,  826,    0,  183,  182,  797,    0,    0,    0,
			    0,  181,  180,  179,  178,    0,  177,    0,    0,  176,
			   87,  175,   85,   13,   84,   83,    0,    0,  174,  849,
			  853,   81,    0,  173,  864,  865,  172,    0,  150,    0,
			    0,   80,   79,    0,  171,    0,    0,    0,    0,  853,

			  170,    0,    0,  796,  378,  891,    0,    0,    0,    0,
			    0,  169,    0,    0,    0,   11,   10,    9,    8,    7,
			    6,    5,    4,    3,    2,    1,  168,  167,    0,    0,
			    0,    0,    0,  166,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  165,    0,   11,   10,    9,    8,    7,
			    6,    5,    4,    3,    2,    1,   78,   77,   76,   75,
			   74,   73,   72,   71,   70,   69,   68,   67,   66,   65,
			   64,   63,   62,   61,   60,   59,   58,   57,  183,  182,
			    0,    0,    0,    0,    0,  181,  180,  179,  178,    0,
			  177,    0,    0,  176,   87,  175,   85,   13,   84,   83,

			    0,    0,  174,    0,    0,   81,    0,  173,    0,    0,
			  172,    0,  150,    0,    0,   80,   79,    0,  171,    0,
			    0,    0,    0,    0,  170,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  169,  275,  274,  273,  272,
			  271,  270,  269,  268,  267,  266,  265,  264,  263,  181,
			  168,  167,    0,    0,    0,    0,    0,  166,    0,    0,
			    0,  375,    0,    0,    0,    0,    0,  165,    0,   11,
			   10,    9,    8,    7,    6,    5,    4,    3,    2,    1,
			   78,   77,   76,   75,   74,   73,   72,   71,   70,   69,
			   68,   67,   66,   65,   64,   63,   62,   61,   60,   59,

			   58,   57,  183,  182,    0,    0,    0,    0,    0,  181,
			  180,  179,  178,    0,  177,    0,    0,  176,   87,  175,
			   85,   13,   84,   83,    0,    0,  174,    0,    0,   81,
			    0,  173,    0,  310,  172,    0,  150,    0,    0,   80,
			   79,    0,  171,    0,    0,    0,    0,    0,  170,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  169,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  168,  167,    0,    0,    0,    0,
			    0,  166,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  165,    0,   11,   10,    9,    8,    7,    6,    5,

			    4,    3,    2,    1,   78,   77,   76,   75,   74,   73,
			   72,   71,   70,   69,   68,   67,   66,   65,   64,   63,
			   62,   61,   60,   59,   58,   57,  183,  182,    0,    0,
			    0,    0,    0,  181,  180,  179,  178,    0,  177,    0,
			    0,  176,   87,  175,   85,   13,   84,   83,    0,    0,
			  174,    0,    0,   81,    0,  173,    0,    0,  172,    0,
			  150,    0,    0,   80,   79,    0,  171,    0,    0,    0,
			    0,    0,  170,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  169,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  168,  167,

			    0,    0,    0,    0,    0,  166,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  165,    0,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    2,    1,   78,   77,
			   76,   75,   74,   73,   72,   71,   70,   69,   68,   67,
			   66,   65,   64,   63,   62,   61,   60,   59,   58,   57,
			  183,  182,    0,    0,    0,    0,    0,  181,  180,  179,
			  178,    0,  177,    0,    0,  176,   87,  175,   85,   13,
			   84,   83,    0,    0,  174,    0,    0,   81,    0,  173,
			    0,    0,  405,    0,  150,    0,    0,   80,   79,    0,
			  171,    0,    0,   90,   89,    0,  170,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,  169,   88,   87,
			   86,   85,   13,   84,   83,    0,   82,    0,    0,    0,
			   81,    0,  168,  167,    0,    0,    0,    0,    0,  166,
			   80,   79,    0,    0,    0,    0,    0,    0,    0,  404,
			    0,   11,   10,    9,    8,    7,    6,    5,    4,    3,
			    2,    1,   78,   77,   76,   75,   74,   73,   72,   71,
			   70,   69,   68,   67,   66,   65,   64,   63,   62,   61,
			   60,   59,   58,   57,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,    2,    1,   78,   77,   76,   75,   74,

			   73,   72,   71,   70,   69,   68,   67,   66,   65,   64,
			   63,   62,   61,   60,   59,   58,   57,   90,   89,    0,
			   13,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   88,   87,   86,   85,   13,   84,   83,    0,
			    0,    0,    0,    0,   81,    0,    0,    0,    0,    0,
			    0,    0,    0,  680,   80,   79,  279,  278,  277,  276,
			  275,  274,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,  264,  263,  181,  279,  278,  277,  276,  275,  274,
			  273,  272,  271,  270,  269,  268,  267,  266,  265,  264,
			  263,  181,   11,   10,    9,    8,    7,    6,    5,    4,

			    3,    2,    1,    0,    0,    0,    0,    0,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,    2,    1,   78,
			   77,   76,   75,   74,   73,   72,   71,   70,   69,   68,
			   67,   66,   65,   64,   63,   62,   61,   60,   59,   58,
			   57,   13,    0,    0,    0,    0,    0,    0,    0,  894,
			    0,    0,   13,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  814,    0,    0,
			  -33,  -33,    0,    0,    0,    0,    0,    0,  -33,    0,
			    0,  -34,  -34,    0,    0,    0,    0,    0,    0,  -34,
			  -33,    0,  -33,  -33,    0,    0,    0,    0,    0,  -33,

			    0,  -34,    0,  -34,  -34,    0,    0,    0,    0,    0,
			  -34,   13,    0,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,    2,    1,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,    2,    1,   13,  -30,    0,    0,    0,
			  -30,    0,    0,    0,  -30,    0,  -30,    0,  -30,    0,
			    0,  -30,    0,    0,    0,    0,    0,    0,    0,    0,
			  -31,    0,    0,    0,  -31,    0,    0,    0,  -31,    0,
			  -31,    0,  -31,    0,  -30,  -31,    0,    0,    0,    0,
			    0,    0,    0,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,    2,    1,    0,    0,    0,    0,  -31,    0,

			    0,    0,    0,    0,    0,    0,    0,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    2,    1,   36,    0,
			    0,   35,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  240,    0,    0,    0,    0,    0,    0,   36,    0,
			    0,   35,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   34,  157,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   33,    0,    0,    0,
			    0,    0,    0,   34,   36,    0,    0,   35,    0,    0,
			    0,   32,    0,    0,    0,    0,   33,    0,    0,  -68,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   22,

			   21,   32,  524,    0,    0,    0,    0,    0,    0,   34,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   22,
			   21,    0,   33,    0,    0,    0,    0,    0,    0,  -69,
			    0,    0,  -68,    0,    0,    0,    0,   32,    0,    0,
			   13,    0,    0,    0,  -68,    0,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,    0,    0,    0,
			   36,  -68,  -68,  -68,  -68,  -68,  -68,  -68,  -68,  -68,
			  -68,  -68,  -69,  666,  545,    0,    0,    0,    0,    0,
			    0,    0,   13,    0,  -69,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   13,    0,    0,    0,

			    0,  -69,  -69,  -69,  -69,  -69,  -69,  -69,  -69,  -69,
			  -69,  -69,   11,   10,    9,    8,    7,    6,    5,    4,
			    3,    2,    1,  117,   12,   13,    0,    0,    0,    0,
			    0,    0,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,   36,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,    2,    1,    0,    0,    0,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,    2,    1,  279,
			  278,  277,  276,  275,  274,  273,  272,  271,  270,  269,
			  268,  267,  266,  265,  264,  263,  181,   11,   10,    9>>,
			1, 3000, 0)
		end

	yytable_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    8,    7,    6,    5,    4,    3,    2,    1,    0,    0,
			    0,    0,    0,    0,    0,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   22,   21,  279,  278,  277,  276,
			  275,  274,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,  264,  263,  181,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  888,    0,
			    0,    0,    0,    0,    0,    0,    0,  823,  279,  278,
			  277,  276,  275,  274,  273,  272,  271,  270,  269,  268,
			  267,  266,  265,  264,  263,  181,  279,  278,  277,  276,
			  275,  274,  273,  272,  271,  270,  269,  268,  267,  266,

			  265,  264,  263,  181,    0,    0,    0,    0,    0,  415,
			  277,  276,  275,  274,  273,  272,  271,  270,  269,  268,
			  267,  266,  265,  264,  263,  181,    0,  403,  279,  278,
			  277,  276,  275,  274,  273,  272,  271,  270,  269,  268,
			  267,  266,  265,  264,  263,  181,  338,  337,  336,  335,
			  334,  333,  332,  331,  330,  329,  328,  327,  326,  325,
			  324,  323,  322,    0,  321,    0,    0,    0,    0,  357,
			  279,  278,  277,  276,  275,  274,  273,  272,  271,  270,
			  269,  268,  267,  266,  265,  264,  263,  181,  276,  275,
			  274,  273,  272,  271,  270,  269,  268,  267,  266,  265,

			  264,  263,  181>>,
			1, 203, 3000)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		local
			an_array: ARRAY [INTEGER]
		once
			!! an_array.make (0, 3202)
			yycheck_template_1 (an_array)
			yycheck_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yycheck_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,   18,   20,  292,   18,  258,   35,   18,   14,   18,
			  228,   14,   12,  171,  289,  511,   18,  439,   18,  617,
			   20,  230,  530,   55,   14,   40,   47,  822,   66,   14,
			   26,   14,   14,   33,  530,   35,  650,   26,    0,   40,
			   75,   32,  837,   34,   45,   80,  694,  572,  662,  697,
			   46,   40,  356,  262,   92,    0,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,  574,  284,  285,   83,  586,  727,
			   83,  606,   97,  104,   25,   37,   66,   26,   40,   25,
			  586,  395,  396,   83,   40,  399,  400,  401,   83,  747,

			   83,   83,   14,  603,   68,  409,   70,   14,  140,  141,
			  414,  759,   53,   26,   53,   56,  538,   56,  124,   40,
			   66,  124,  714,   14,   45,   72,   39,  627,  776,   47,
			  722,   78,   96,  437,  124,  152,   25,  143,  152,  124,
			  143,  152,  124,  152,  742,   48,   66,   94,  139,   38,
			  152,   14,  152,  143,  102,   75,   37,   25,  143,  463,
			  143,  143,   66,   66,   62,   46,  172,  167,  705,  172,
			   38,   83,   64,   37,   66,   73,   83,   41,   42,  601,
			  123,  124,  172,   25,  488,  489,   26,  172,   26,  172,
			  172,  728,   83,  136,  137,   59,   38,  734,   38,   39,

			   38,   39,   66,  507,   40,  211,   25,   71,  211,   40,
			   65,   75,  124,   49,   45,   79,  222,  124,  218,  222,
			   83,  211,  228,  432,    3,  228,  211,   64,  211,  211,
			  230,  143,  222,  124,  225,    3,  143,  222,  228,  222,
			  222,   41,   42,  228,   26,  782,  228,  669,    3,  240,
			   40,   64,  143,   66,    3,  255,   38,   47,  258,   59,
			  172,  124,  262,  685,   66,  172,   66,  485,   29,   14,
			   31,   71,   29,   46,   31,   75,   40,  814,   25,   79,
			  143,  172,   40,   47,  284,  285,  661,   47,  663,   47,
			  827,  100,  101,  293,   66,  295,  296,   14,  102,  211,

			   35,  301,  302,  303,  211,   26,  100,  307,  730,  172,
			  222,   64,   33,   47,  314,  222,  228,   20,   21,   47,
			  211,  228,   62,   63,   47,  862,   66,   14,   47,  866,
			   70,  222,   47,   62,   63,   75,   47,  228,   83,   60,
			   47,   70,   82,  531,   66,   85,  534,  535,  211,  537,
			   47,  888,   92,   82,   47,   76,   85,  894,  101,  222,
			  100,  101,   47,   48,   47,  228,   83,   88,   47,  527,
			  558,   47,   93,  387,   47,   48,   25,   66,  536,  124,
			   69,  569,  382,   25,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,   25,   83,  397,  143,  405,

			   89,   90,  405,   66,   47,   48,   95,  124,   71,   98,
			   73,   66,   75,   41,   25,  405,   79,  417,   47,   48,
			  405,   37,  405,  405,  582,  583,  143,  172,   47,   48,
			   26,   59,  432,  433,  592,   25,   26,  124,   66,  597,
			  598,  716,  695,   71,   47,   48,   79,   75,   37,  702,
			   97,   79,  452,  453,   66,  172,  143,   62,   63,   71,
			  460,   73,   66,   75,   27,   70,  211,   79,   16,   17,
			   18,   19,   20,   21,   41,   92,  476,  222,   40,  485,
			   85,   67,  485,  228,   39,  172,   47,   48,   37,   47,
			   48,  482,   59,  405,  211,  485,   47,   48,  405,   66,

			  485,   82,   28,  485,   71,  222,  781,   33,   75,  798,
			   64,  228,   79,   91,  405,   64,   65,   66,   67,   64,
			   65,   66,   67,   75,  211,  858,  859,  860,  861,   49,
			   79,   47,   48,  524,   79,  222,   47,   48,   47,   48,
			   84,  228,  405,   92,  610,  611,   48,   92,   66,  838,
			   76,  100,  101,  102,   39,  100,  101,  102,   45,   66,
			  835,   75,   88,   45,   95,   66,  855,   39,   73,   66,
			   89,   40,   46,  485,   98,   79,   46,   66,  485,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  581,   46,   55,   40,  485,   14,   15,   16,   17,   18,

			   19,   20,   21,   71,  610,  611,   40,  610,  611,   69,
			   66,   26,   41,   59,   42,   48,  616,   37,   26,   86,
			  610,  611,  485,   25,   33,  610,  611,   50,  610,  611,
			  636,   47,  649,  636,  634,  649,   86,   86,  649,  857,
			  649,   86,   86,   86,   86,   86,  636,   86,   86,  667,
			  650,  636,   25,  636,  636,   86,   86,   38,  676,   86,
			  405,   25,  662,   25,   40,   49,   77,  667,  674,   47,
			  670,  674,   47,  673,   45,   47,  676,   47,   44,  104,
			   25,   25,   25,   48,  674,   40,   49,   26,  405,  674,
			   46,  674,  674,   47,   35,  695,   70,   66,  610,  611,

			   29,   29,  702,  610,  611,   58,   46,   39,  639,  615,
			  579,  523,  523,  523,  720,  173,  544,  720,  405,  610,
			  611,  702,  655,  634,  636,  665,  597,  715,   96,  636,
			  720,  481,  456,  746,  746,  720,  746,  720,  720,  746,
			  485,  746,  746,  397,  863,  636,  746,  610,  611,  746,
			  722,  746,  443,  568,  760,  589,  762,  760,  557,  762,
			  852,  761,  674,  514,  808,  583,  649,  674,  485,  152,
			  760,  397,  762,  636,   -1,  760,  746,  762,  760,  762,
			  762,   -1,   -1,  674,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  797,   -1,   -1,  797,   -1,   -1,  826,  485,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  797,  720,  826,
			  810,  674,  797,  720,  797,  797,   -1,   -1,   -1,   -1,
			   -1,   -1,  822,   -1,   -1,   -1,  826,   -1,   -1,  720,
			  859,  860,  861,   -1,  863,   -1,   -1,  837,   -1,   -1,
			   -1,  858,  859,   -1,  861,   -1,  863,   -1,  760,   -1,
			  762,  857,   -1,  760,  857,  762,   -1,  720,  858,  859,
			  860,  861,   -1,  863,   27,  610,  611,  857,   -1,  760,
			   -1,  762,  857,   -1,   -1,  857,   -1,   -1,   41,   42,
			   -1,   -1,   -1,   -1,   -1,  797,   -1,   -1,   -1,   -1,
			  797,  636,   -1,  610,  611,  895,   59,  760,   -1,  762,

			   -1,   -1,   -1,   66,   -1,   -1,  797,   -1,   71,   -1,
			   -1,   -1,   75,  192,   77,   -1,   79,   -1,   -1,  636,
			   -1,   84,   -1,  610,  611,   -1,   -1,   -1,   -1,  674,
			   -1,   -1,   -1,   -1,  797,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  857,   -1,   -1,   -1,  636,
			  857,   -1,   -1,   -1,   -1,   -1,   -1,  674,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  857,   -1,   -1,   -1,
			   -1,   14,   15,   -1,   -1,  720,   -1,  256,  257,   -1,
			  259,  260,  261,   -1,   -1,   -1,   29,  674,   -1,   -1,
			   33,   -1,   -1,   -1,  857,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,  720,  283,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  760,   -1,  762,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  305,   -1,   71,  168,
			   -1,   -1,  311,  720,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  760,   -1,  762,   -1,   -1,   -1,   -1,
			   -1,   -1,  797,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  340,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  760,   -1,  762,   -1,   -1,   -1,   -1,
			  797,   -1,   -1,  362,  363,  364,  365,  366,  367,  368,
			  369,  370,  371,  372,  373,  374,   -1,  376,  377,   -1,

			  379,  380,  381,   -1,   -1,   -1,  385,  160,   26,   -1,
			  797,  164,  857,  177,  178,   33,  180,   -1,  182,  183,
			   -1,  174,   -1,   -1,   -1,   -1,   -1,  406,   46,   -1,
			  194,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  857,   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  435,  436,   33,  223,
			  299,  214,  226,  216,  217,   -1,   -1,   14,   15,   -1,
			  857,  235,   -1,   -1,   -1,   93,  229,   -1,   -1,   -1,
			  459,   -1,   29,   30,   -1,  103,   33,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  115,   -1,  263,

			  264,  265,  266,  267,  268,  269,  270,  271,  272,  273,
			  274,  275,  276,  277,  278,  279,  280,   -1,   93,   -1,
			   -1,   -1,   -1,  287,   71,   -1,   -1,   -1,  281,   -1,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,   -1,  306,   41,   42,   43,   44,   45,   46,   47,
			   48,   49,   50,   51,   -1,  394,   -1,   -1,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,   -1,
			   32,  410,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,  342,
			  343,  344,  345,  346,  347,  348,  349,  350,  351,  352,

			  353,  354,   -1,   -1,   -1,   -1,  104,   -1,   -1,   -1,
			   -1,  375,   -1,   -1,  378,   -1,   -1,   -1,   -1,   -1,
			   -1,  119,   -1,   -1,   -1,  464,  465,  466,  467,  468,
			  469,  470,  471,  472,  473,  474,  475,   -1,   -1,   -1,
			   -1,   -1,   -1,   30,   -1,   -1,   33,   -1,  412,   -1,
			   -1,   -1,   -1,  492,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,
			  132,  133,  134,  135,  136,  137,   -1,   32,  431,   -1,
			   -1,  520,   -1,   -1,   71,   -1,   -1,  440,   -1,   -1,
			   45,   -1,  456,   14,   15,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,  682,   -1,   -1,   -1,   -1,   29,  462,
			   -1,   -1,   33,  692,   -1,   -1,   -1,   32,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,   -1,
			   -1,  484,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  243,  244,  245,  246,  247,
			  248,  249,  250,  251,  252,  253,   -1,   -1,   -1,   -1,
			   -1,  514,  117,   -1,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137,   -1,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,   -1,  775,   -1,   -1,   -1,

			   -1,  780,  117,  556,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137,  802,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  812,  813,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  824,  825,   -1,   -1,   -1,
			   -1,  830,   -1,   -1,   -1,   -1,   -1,   26,   -1,   -1,
			   -1,   -1,   -1,   -1,   33,   -1,   35,   -1,  621,   -1,
			   -1,   -1,   41,   -1,   -1,   -1,   -1,   46,   -1,  632,
			   -1,   -1,   33,   -1,   -1,  864,  865,   -1,   57,   -1,
			   -1,   60,   61,   -1,   -1,   46,   -1,   -1,   -1,   -1,

			   -1,   -1,   71,  656,   -1,   74,  670,   -1,   -1,   -1,
			   -1,   -1,  891,   -1,   -1,   14,   15,   86,   -1,   -1,
			   -1,   -1,   -1,  687,   93,   -1,   -1,   -1,   -1,   33,
			   29,   30,   31,   32,   -1,   34,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,  115,  700,   -1,   -1,
			   -1,  704,   51,   52,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,   -1,   -1,   -1,   -1,   -1,
			  723,   -1,   76,   -1,   -1,   -1,   75,   -1,   -1,   -1,
			  733,   -1,   -1,   -1,   88,   -1,   -1,   -1,  752,   -1,
			   -1,   -1,  756,   -1,   -1,   -1,   -1,   -1,   -1,  763,

			   99,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,  510,   -1,  778,  779,   -1,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,  137,  803,
			  804,   -1,   -1,   33,   -1,   -1,  810,   -1,   -1,   -1,
			   -1,   -1,  805,   -1,   14,   15,   46,   -1,   -1,   -1,
			   -1,   21,   22,   23,   24,   -1,   26,   -1,   -1,   29,
			   30,   31,   32,   33,   34,   35,   -1,   -1,   38,  832,
			  833,   41,   -1,   43,  848,  849,   46,   -1,   48,   -1,
			   -1,   51,   52,   -1,   54,   -1,   -1,   -1,   -1,  852,

			   60,   -1,   -1,   93,   64,  869,   -1,   -1,   -1,   -1,
			   -1,   71,   -1,   -1,   -1,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,   86,   87,   -1,   -1,
			   -1,   -1,   -1,   93,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  103,   -1,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,  132,  133,  134,  135,  136,  137,   14,   15,
			   -1,   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,
			   26,   -1,   -1,   29,   30,   31,   32,   33,   34,   35,

			   -1,   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   -1,
			   46,   -1,   48,   -1,   -1,   51,   52,   -1,   54,   -1,
			   -1,   -1,   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   71,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   86,   87,   -1,   -1,   -1,   -1,   -1,   93,   -1,   -1,
			   -1,   97,   -1,   -1,   -1,   -1,   -1,  103,   -1,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,

			  136,  137,   14,   15,   -1,   -1,   -1,   -1,   -1,   21,
			   22,   23,   24,   -1,   26,   -1,   -1,   29,   30,   31,
			   32,   33,   34,   35,   -1,   -1,   38,   -1,   -1,   41,
			   -1,   43,   -1,   45,   46,   -1,   48,   -1,   -1,   51,
			   52,   -1,   54,   -1,   -1,   -1,   -1,   -1,   60,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   71,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   86,   87,   -1,   -1,   -1,   -1,
			   -1,   93,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  103,   -1,  105,  106,  107,  108,  109,  110,  111,

			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,
			  132,  133,  134,  135,  136,  137,   14,   15,   -1,   -1,
			   -1,   -1,   -1,   21,   22,   23,   24,   -1,   26,   -1,
			   -1,   29,   30,   31,   32,   33,   34,   35,   -1,   -1,
			   38,   -1,   -1,   41,   -1,   43,   -1,   -1,   46,   -1,
			   48,   -1,   -1,   51,   52,   -1,   54,   -1,   -1,   -1,
			   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   71,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   86,   87,

			   -1,   -1,   -1,   -1,   -1,   93,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  103,   -1,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,  131,  132,  133,  134,  135,  136,  137,
			   14,   15,   -1,   -1,   -1,   -1,   -1,   21,   22,   23,
			   24,   -1,   26,   -1,   -1,   29,   30,   31,   32,   33,
			   34,   35,   -1,   -1,   38,   -1,   -1,   41,   -1,   43,
			   -1,   -1,   46,   -1,   48,   -1,   -1,   51,   52,   -1,
			   54,   -1,   -1,   14,   15,   -1,   60,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   71,   29,   30,
			   31,   32,   33,   34,   35,   -1,   37,   -1,   -1,   -1,
			   41,   -1,   86,   87,   -1,   -1,   -1,   -1,   -1,   93,
			   51,   52,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  103,
			   -1,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,  137,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,

			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,  137,   14,   15,   -1,
			   33,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   29,   30,   31,   32,   33,   34,   35,   -1,
			   -1,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   66,   51,   52,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,  105,  106,  107,  108,  109,  110,  111,  112,

			  113,  114,  115,   -1,   -1,   -1,   -1,   -1,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			  137,   33,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   97,
			   -1,   -1,   33,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   97,   -1,   -1,
			   62,   63,   -1,   -1,   -1,   -1,   -1,   -1,   70,   -1,
			   -1,   62,   63,   -1,   -1,   -1,   -1,   -1,   -1,   70,
			   82,   -1,   84,   85,   -1,   -1,   -1,   -1,   -1,   91,

			   -1,   82,   -1,   84,   85,   -1,   -1,   -1,   -1,   -1,
			   91,   33,   -1,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  115,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,   33,   58,   -1,   -1,   -1,
			   62,   -1,   -1,   -1,   66,   -1,   68,   -1,   70,   -1,
			   -1,   73,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   58,   -1,   -1,   -1,   62,   -1,   -1,   -1,   66,   -1,
			   68,   -1,   70,   -1,   96,   73,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  115,   -1,   -1,   -1,   -1,   96,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  115,   33,   -1,
			   -1,   36,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   46,   -1,   -1,   -1,   -1,   -1,   -1,   33,   -1,
			   -1,   36,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   68,   49,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   81,   -1,   -1,   -1,
			   -1,   -1,   -1,   68,   33,   -1,   -1,   36,   -1,   -1,
			   -1,   96,   -1,   -1,   -1,   -1,   81,   -1,   -1,   33,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,

			  115,   96,   46,   -1,   -1,   -1,   -1,   -1,   -1,   68,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,   -1,   81,   -1,   -1,   -1,   -1,   -1,   -1,   33,
			   -1,   -1,   76,   -1,   -1,   -1,   -1,   96,   -1,   -1,
			   33,   -1,   -1,   -1,   88,   -1,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,  115,   -1,   -1,   -1,
			   33,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,   76,   66,   47,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   33,   -1,   88,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   33,   -1,   -1,   -1,

			   -1,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,   60,   75,   33,   -1,   -1,   -1,   -1,
			   -1,   -1,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,   33,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,   -1,   -1,   -1,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,  105,  106,  107>>,
			1, 3000, 0)
		end

	yycheck_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  108,  109,  110,  111,  112,  113,  114,  115,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   83,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   45,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,

			   18,   19,   20,   21,   -1,   -1,   -1,   -1,   -1,   45,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   -1,   45,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,   -1,  137,   -1,   -1,   -1,   -1,   45,
			    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,

			   19,   20,   21>>,
			1, 203, 3000)
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

	yyFinal: INTEGER is 901
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 138
			-- Number of tokens

	yyLast: INTEGER is 3202
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 392
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 328
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
