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
--|#line 176 "eiffel.y"
	yy_do_action_1
when 2 then
--|#line 183 "eiffel.y"
	yy_do_action_2
when 3 then
--|#line 192 "eiffel.y"
	yy_do_action_3
when 4 then
--|#line 234 "eiffel.y"
	yy_do_action_4
when 5 then
--|#line 243 "eiffel.y"
	yy_do_action_5
when 6 then
--|#line 245 "eiffel.y"
	yy_do_action_6
when 7 then
--|#line 247 "eiffel.y"
	yy_do_action_7
when 8 then
--|#line 249 "eiffel.y"
	yy_do_action_8
when 9 then
--|#line 251 "eiffel.y"
	yy_do_action_9
when 10 then
--|#line 253 "eiffel.y"
	yy_do_action_10
when 11 then
--|#line 255 "eiffel.y"
	yy_do_action_11
when 12 then
--|#line 257 "eiffel.y"
	yy_do_action_12
when 13 then
--|#line 259 "eiffel.y"
	yy_do_action_13
when 14 then
--|#line 261 "eiffel.y"
	yy_do_action_14
when 15 then
--|#line 263 "eiffel.y"
	yy_do_action_15
when 16 then
--|#line 265 "eiffel.y"
	yy_do_action_16
when 17 then
--|#line 269 "eiffel.y"
	yy_do_action_17
when 18 then
--|#line 273 "eiffel.y"
	yy_do_action_18
when 19 then
--|#line 277 "eiffel.y"
	yy_do_action_19
when 20 then
--|#line 281 "eiffel.y"
	yy_do_action_20
when 21 then
--|#line 285 "eiffel.y"
	yy_do_action_21
when 22 then
--|#line 289 "eiffel.y"
	yy_do_action_22
when 23 then
--|#line 293 "eiffel.y"
	yy_do_action_23
when 24 then
--|#line 297 "eiffel.y"
	yy_do_action_24
when 25 then
--|#line 301 "eiffel.y"
	yy_do_action_25
when 26 then
--|#line 305 "eiffel.y"
	yy_do_action_26
when 27 then
--|#line 309 "eiffel.y"
	yy_do_action_27
when 28 then
--|#line 313 "eiffel.y"
	yy_do_action_28
when 29 then
--|#line 320 "eiffel.y"
	yy_do_action_29
when 30 then
--|#line 322 "eiffel.y"
	yy_do_action_30
when 31 then
--|#line 324 "eiffel.y"
	yy_do_action_31
when 32 then
--|#line 328 "eiffel.y"
	yy_do_action_32
when 33 then
--|#line 330 "eiffel.y"
	yy_do_action_33
when 34 then
--|#line 332 "eiffel.y"
	yy_do_action_34
when 35 then
--|#line 336 "eiffel.y"
	yy_do_action_35
when 36 then
--|#line 338 "eiffel.y"
	yy_do_action_36
when 37 then
--|#line 340 "eiffel.y"
	yy_do_action_37
when 38 then
--|#line 344 "eiffel.y"
	yy_do_action_38
when 39 then
--|#line 349 "eiffel.y"
	yy_do_action_39
when 40 then
--|#line 356 "eiffel.y"
	yy_do_action_40
when 41 then
--|#line 360 "eiffel.y"
	yy_do_action_41
when 42 then
--|#line 362 "eiffel.y"
	yy_do_action_42
when 43 then
--|#line 366 "eiffel.y"
	yy_do_action_43
when 44 then
--|#line 371 "eiffel.y"
	yy_do_action_44
when 45 then
--|#line 376 "eiffel.y"
	yy_do_action_45
when 46 then
--|#line 383 "eiffel.y"
	yy_do_action_46
when 47 then
--|#line 385 "eiffel.y"
	yy_do_action_47
when 48 then
--|#line 387 "eiffel.y"
	yy_do_action_48
when 49 then
--|#line 391 "eiffel.y"
	yy_do_action_49
when 50 then
--|#line 401 "eiffel.y"
	yy_do_action_50
when 51 then
--|#line 407 "eiffel.y"
	yy_do_action_51
when 52 then
--|#line 414 "eiffel.y"
	yy_do_action_52
when 53 then
--|#line 420 "eiffel.y"
	yy_do_action_53
when 54 then
--|#line 428 "eiffel.y"
	yy_do_action_54
when 55 then
--|#line 432 "eiffel.y"
	yy_do_action_55
when 56 then
--|#line 443 "eiffel.y"
	yy_do_action_56
when 57 then
--|#line 447 "eiffel.y"
	yy_do_action_57
when 58 then
--|#line 462 "eiffel.y"
	yy_do_action_58
when 59 then
--|#line 464 "eiffel.y"
	yy_do_action_59
when 60 then
--|#line 471 "eiffel.y"
	yy_do_action_60
when 61 then
--|#line 473 "eiffel.y"
	yy_do_action_61
when 62 then
--|#line 482 "eiffel.y"
	yy_do_action_62
when 63 then
--|#line 487 "eiffel.y"
	yy_do_action_63
when 64 then
--|#line 494 "eiffel.y"
	yy_do_action_64
when 65 then
--|#line 496 "eiffel.y"
	yy_do_action_65
when 66 then
--|#line 500 "eiffel.y"
	yy_do_action_66
when 67 then
--|#line 500 "eiffel.y"
	yy_do_action_67
when 68 then
--|#line 509 "eiffel.y"
	yy_do_action_68
when 69 then
--|#line 511 "eiffel.y"
	yy_do_action_69
when 70 then
--|#line 515 "eiffel.y"
	yy_do_action_70
when 71 then
--|#line 520 "eiffel.y"
	yy_do_action_71
when 72 then
--|#line 524 "eiffel.y"
	yy_do_action_72
when 73 then
--|#line 530 "eiffel.y"
	yy_do_action_73
when 74 then
--|#line 538 "eiffel.y"
	yy_do_action_74
when 75 then
--|#line 543 "eiffel.y"
	yy_do_action_75
when 76 then
--|#line 550 "eiffel.y"
	yy_do_action_76
when 77 then
--|#line 551 "eiffel.y"
	yy_do_action_77
when 78 then
--|#line 554 "eiffel.y"
	yy_do_action_78
when 79 then
--|#line 567 "eiffel.y"
	yy_do_action_79
when 80 then
--|#line 569 "eiffel.y"
	yy_do_action_80
when 81 then
--|#line 576 "eiffel.y"
	yy_do_action_81
when 82 then
--|#line 580 "eiffel.y"
	yy_do_action_82
when 83 then
--|#line 582 "eiffel.y"
	yy_do_action_83
when 84 then
--|#line 586 "eiffel.y"
	yy_do_action_84
when 85 then
--|#line 588 "eiffel.y"
	yy_do_action_85
when 86 then
--|#line 590 "eiffel.y"
	yy_do_action_86
when 87 then
--|#line 594 "eiffel.y"
	yy_do_action_87
when 88 then
--|#line 599 "eiffel.y"
	yy_do_action_88
when 89 then
--|#line 603 "eiffel.y"
	yy_do_action_89
when 90 then
--|#line 607 "eiffel.y"
	yy_do_action_90
when 91 then
--|#line 609 "eiffel.y"
	yy_do_action_91
when 92 then
--|#line 613 "eiffel.y"
	yy_do_action_92
when 93 then
--|#line 618 "eiffel.y"
	yy_do_action_93
when 94 then
--|#line 623 "eiffel.y"
	yy_do_action_94
when 95 then
--|#line 634 "eiffel.y"
	yy_do_action_95
when 96 then
--|#line 636 "eiffel.y"
	yy_do_action_96
when 97 then
--|#line 638 "eiffel.y"
	yy_do_action_97
when 98 then
--|#line 642 "eiffel.y"
	yy_do_action_98
when 99 then
--|#line 647 "eiffel.y"
	yy_do_action_99
when 100 then
--|#line 654 "eiffel.y"
	yy_do_action_100
when 101 then
--|#line 659 "eiffel.y"
	yy_do_action_101
when 102 then
--|#line 667 "eiffel.y"
	yy_do_action_102
when 103 then
--|#line 672 "eiffel.y"
	yy_do_action_103
when 104 then
--|#line 677 "eiffel.y"
	yy_do_action_104
when 105 then
--|#line 682 "eiffel.y"
	yy_do_action_105
when 106 then
--|#line 687 "eiffel.y"
	yy_do_action_106
when 107 then
--|#line 692 "eiffel.y"
	yy_do_action_107
when 108 then
--|#line 697 "eiffel.y"
	yy_do_action_108
when 109 then
--|#line 705 "eiffel.y"
	yy_do_action_109
when 110 then
--|#line 707 "eiffel.y"
	yy_do_action_110
when 111 then
--|#line 711 "eiffel.y"
	yy_do_action_111
when 112 then
--|#line 716 "eiffel.y"
	yy_do_action_112
when 113 then
--|#line 723 "eiffel.y"
	yy_do_action_113
when 114 then
--|#line 727 "eiffel.y"
	yy_do_action_114
when 115 then
--|#line 729 "eiffel.y"
	yy_do_action_115
when 116 then
--|#line 733 "eiffel.y"
	yy_do_action_116
when 117 then
--|#line 735 "eiffel.y"
	yy_do_action_117
when 118 then
--|#line 739 "eiffel.y"
	yy_do_action_118
when 119 then
--|#line 744 "eiffel.y"
	yy_do_action_119
when 120 then
--|#line 751 "eiffel.y"
	yy_do_action_120
when 121 then
--|#line 755 "eiffel.y"
	yy_do_action_121
when 122 then
--|#line 757 "eiffel.y"
	yy_do_action_122
when 123 then
--|#line 761 "eiffel.y"
	yy_do_action_123
when 124 then
--|#line 766 "eiffel.y"
	yy_do_action_124
when 125 then
--|#line 773 "eiffel.y"
	yy_do_action_125
when 126 then
--|#line 775 "eiffel.y"
	yy_do_action_126
when 127 then
--|#line 779 "eiffel.y"
	yy_do_action_127
when 128 then
--|#line 781 "eiffel.y"
	yy_do_action_128
when 129 then
--|#line 785 "eiffel.y"
	yy_do_action_129
when 130 then
--|#line 787 "eiffel.y"
	yy_do_action_130
when 131 then
--|#line 791 "eiffel.y"
	yy_do_action_131
when 132 then
--|#line 793 "eiffel.y"
	yy_do_action_132
when 133 then
--|#line 797 "eiffel.y"
	yy_do_action_133
when 134 then
--|#line 799 "eiffel.y"
	yy_do_action_134
when 135 then
--|#line 803 "eiffel.y"
	yy_do_action_135
when 136 then
--|#line 805 "eiffel.y"
	yy_do_action_136
when 137 then
--|#line 813 "eiffel.y"
	yy_do_action_137
when 138 then
--|#line 815 "eiffel.y"
	yy_do_action_138
when 139 then
--|#line 819 "eiffel.y"
	yy_do_action_139
when 140 then
--|#line 821 "eiffel.y"
	yy_do_action_140
when 141 then
--|#line 825 "eiffel.y"
	yy_do_action_141
when 142 then
--|#line 830 "eiffel.y"
	yy_do_action_142
when 143 then
--|#line 837 "eiffel.y"
	yy_do_action_143
when 144 then
--|#line 841 "eiffel.y"
	yy_do_action_144
when 145 then
--|#line 842 "eiffel.y"
	yy_do_action_145
when 146 then
--|#line 851 "eiffel.y"
	yy_do_action_146
when 147 then
--|#line 853 "eiffel.y"
	yy_do_action_147
when 148 then
--|#line 857 "eiffel.y"
	yy_do_action_148
when 149 then
--|#line 862 "eiffel.y"
	yy_do_action_149
when 150 then
--|#line 869 "eiffel.y"
	yy_do_action_150
when 151 then
--|#line 873 "eiffel.y"
	yy_do_action_151
when 152 then
--|#line 879 "eiffel.y"
	yy_do_action_152
when 153 then
--|#line 887 "eiffel.y"
	yy_do_action_153
when 154 then
--|#line 889 "eiffel.y"
	yy_do_action_154
when 155 then
--|#line 893 "eiffel.y"
	yy_do_action_155
when 156 then
--|#line 895 "eiffel.y"
	yy_do_action_156
when 157 then
--|#line 899 "eiffel.y"
	yy_do_action_157
when 158 then
--|#line 899 "eiffel.y"
	yy_do_action_158
when 159 then
--|#line 911 "eiffel.y"
	yy_do_action_159
when 160 then
--|#line 913 "eiffel.y"
	yy_do_action_160
when 161 then
--|#line 915 "eiffel.y"
	yy_do_action_161
when 162 then
--|#line 919 "eiffel.y"
	yy_do_action_162
when 163 then
--|#line 923 "eiffel.y"
	yy_do_action_163
when 164 then
--|#line 928 "eiffel.y"
	yy_do_action_164
when 165 then
--|#line 930 "eiffel.y"
	yy_do_action_165
when 166 then
--|#line 934 "eiffel.y"
	yy_do_action_166
when 167 then
--|#line 936 "eiffel.y"
	yy_do_action_167
when 168 then
--|#line 940 "eiffel.y"
	yy_do_action_168
when 169 then
--|#line 942 "eiffel.y"
	yy_do_action_169
when 170 then
--|#line 946 "eiffel.y"
	yy_do_action_170
when 171 then
--|#line 948 "eiffel.y"
	yy_do_action_171
when 172 then
--|#line 952 "eiffel.y"
	yy_do_action_172
when 173 then
--|#line 957 "eiffel.y"
	yy_do_action_173
when 174 then
--|#line 964 "eiffel.y"
	yy_do_action_174
when 175 then
--|#line 968 "eiffel.y"
	yy_do_action_175
when 176 then
--|#line 969 "eiffel.y"
	yy_do_action_176
when 177 then
--|#line 972 "eiffel.y"
	yy_do_action_177
when 178 then
--|#line 974 "eiffel.y"
	yy_do_action_178
when 179 then
--|#line 976 "eiffel.y"
	yy_do_action_179
when 180 then
--|#line 978 "eiffel.y"
	yy_do_action_180
when 181 then
--|#line 980 "eiffel.y"
	yy_do_action_181
when 182 then
--|#line 982 "eiffel.y"
	yy_do_action_182
when 183 then
--|#line 984 "eiffel.y"
	yy_do_action_183
when 184 then
--|#line 986 "eiffel.y"
	yy_do_action_184
when 185 then
--|#line 988 "eiffel.y"
	yy_do_action_185
when 186 then
--|#line 990 "eiffel.y"
	yy_do_action_186
when 187 then
--|#line 994 "eiffel.y"
	yy_do_action_187
when 188 then
--|#line 996 "eiffel.y"
	yy_do_action_188
when 189 then
--|#line 996 "eiffel.y"
	yy_do_action_189
when 190 then
--|#line 1003 "eiffel.y"
	yy_do_action_190
when 191 then
--|#line 1003 "eiffel.y"
	yy_do_action_191
when 192 then
--|#line 1012 "eiffel.y"
	yy_do_action_192
when 193 then
--|#line 1014 "eiffel.y"
	yy_do_action_193
when 194 then
--|#line 1014 "eiffel.y"
	yy_do_action_194
when 195 then
--|#line 1021 "eiffel.y"
	yy_do_action_195
when 196 then
--|#line 1021 "eiffel.y"
	yy_do_action_196
when 197 then
--|#line 1030 "eiffel.y"
	yy_do_action_197
when 198 then
--|#line 1032 "eiffel.y"
	yy_do_action_198
when 199 then
--|#line 1041 "eiffel.y"
	yy_do_action_199
when 200 then
--|#line 1046 "eiffel.y"
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
--|#line 1053 "eiffel.y"
	yy_do_action_201
when 202 then
--|#line 1057 "eiffel.y"
	yy_do_action_202
when 203 then
--|#line 1059 "eiffel.y"
	yy_do_action_203
when 204 then
--|#line 1061 "eiffel.y"
	yy_do_action_204
when 205 then
--|#line 1069 "eiffel.y"
	yy_do_action_205
when 206 then
--|#line 1071 "eiffel.y"
	yy_do_action_206
when 207 then
--|#line 1075 "eiffel.y"
	yy_do_action_207
when 208 then
--|#line 1077 "eiffel.y"
	yy_do_action_208
when 209 then
--|#line 1079 "eiffel.y"
	yy_do_action_209
when 210 then
--|#line 1081 "eiffel.y"
	yy_do_action_210
when 211 then
--|#line 1083 "eiffel.y"
	yy_do_action_211
when 212 then
--|#line 1085 "eiffel.y"
	yy_do_action_212
when 213 then
--|#line 1089 "eiffel.y"
	yy_do_action_213
when 214 then
--|#line 1091 "eiffel.y"
	yy_do_action_214
when 215 then
--|#line 1093 "eiffel.y"
	yy_do_action_215
when 216 then
--|#line 1095 "eiffel.y"
	yy_do_action_216
when 217 then
--|#line 1097 "eiffel.y"
	yy_do_action_217
when 218 then
--|#line 1099 "eiffel.y"
	yy_do_action_218
when 219 then
--|#line 1101 "eiffel.y"
	yy_do_action_219
when 220 then
--|#line 1103 "eiffel.y"
	yy_do_action_220
when 221 then
--|#line 1105 "eiffel.y"
	yy_do_action_221
when 222 then
--|#line 1107 "eiffel.y"
	yy_do_action_222
when 223 then
--|#line 1109 "eiffel.y"
	yy_do_action_223
when 224 then
--|#line 1111 "eiffel.y"
	yy_do_action_224
when 225 then
--|#line 1115 "eiffel.y"
	yy_do_action_225
when 226 then
--|#line 1117 "eiffel.y"
	yy_do_action_226
when 227 then
--|#line 1119 "eiffel.y"
	yy_do_action_227
when 228 then
--|#line 1123 "eiffel.y"
	yy_do_action_228
when 229 then
--|#line 1128 "eiffel.y"
	yy_do_action_229
when 230 then
--|#line 1139 "eiffel.y"
	yy_do_action_230
when 231 then
--|#line 1145 "eiffel.y"
	yy_do_action_231
when 232 then
--|#line 1153 "eiffel.y"
	yy_do_action_232
when 233 then
--|#line 1155 "eiffel.y"
	yy_do_action_233
when 234 then
--|#line 1159 "eiffel.y"
	yy_do_action_234
when 235 then
--|#line 1164 "eiffel.y"
	yy_do_action_235
when 236 then
--|#line 1171 "eiffel.y"
	yy_do_action_236
when 237 then
--|#line 1171 "eiffel.y"
	yy_do_action_237
when 238 then
--|#line 1181 "eiffel.y"
	yy_do_action_238
when 239 then
--|#line 1183 "eiffel.y"
	yy_do_action_239
when 240 then
--|#line 1191 "eiffel.y"
	yy_do_action_240
when 241 then
--|#line 1193 "eiffel.y"
	yy_do_action_241
when 242 then
--|#line 1201 "eiffel.y"
	yy_do_action_242
when 243 then
--|#line 1207 "eiffel.y"
	yy_do_action_243
when 244 then
--|#line 1209 "eiffel.y"
	yy_do_action_244
when 245 then
--|#line 1213 "eiffel.y"
	yy_do_action_245
when 246 then
--|#line 1218 "eiffel.y"
	yy_do_action_246
when 247 then
--|#line 1225 "eiffel.y"
	yy_do_action_247
when 248 then
--|#line 1229 "eiffel.y"
	yy_do_action_248
when 249 then
--|#line 1231 "eiffel.y"
	yy_do_action_249
when 250 then
--|#line 1235 "eiffel.y"
	yy_do_action_250
when 251 then
--|#line 1241 "eiffel.y"
	yy_do_action_251
when 252 then
--|#line 1243 "eiffel.y"
	yy_do_action_252
when 253 then
--|#line 1247 "eiffel.y"
	yy_do_action_253
when 254 then
--|#line 1252 "eiffel.y"
	yy_do_action_254
when 255 then
--|#line 1259 "eiffel.y"
	yy_do_action_255
when 256 then
--|#line 1263 "eiffel.y"
	yy_do_action_256
when 257 then
--|#line 1268 "eiffel.y"
	yy_do_action_257
when 258 then
--|#line 1275 "eiffel.y"
	yy_do_action_258
when 259 then
--|#line 1277 "eiffel.y"
	yy_do_action_259
when 260 then
--|#line 1279 "eiffel.y"
	yy_do_action_260
when 261 then
--|#line 1281 "eiffel.y"
	yy_do_action_261
when 262 then
--|#line 1283 "eiffel.y"
	yy_do_action_262
when 263 then
--|#line 1285 "eiffel.y"
	yy_do_action_263
when 264 then
--|#line 1287 "eiffel.y"
	yy_do_action_264
when 265 then
--|#line 1289 "eiffel.y"
	yy_do_action_265
when 266 then
--|#line 1291 "eiffel.y"
	yy_do_action_266
when 267 then
--|#line 1293 "eiffel.y"
	yy_do_action_267
when 268 then
--|#line 1295 "eiffel.y"
	yy_do_action_268
when 269 then
--|#line 1297 "eiffel.y"
	yy_do_action_269
when 270 then
--|#line 1299 "eiffel.y"
	yy_do_action_270
when 271 then
--|#line 1301 "eiffel.y"
	yy_do_action_271
when 272 then
--|#line 1303 "eiffel.y"
	yy_do_action_272
when 273 then
--|#line 1305 "eiffel.y"
	yy_do_action_273
when 274 then
--|#line 1307 "eiffel.y"
	yy_do_action_274
when 275 then
--|#line 1309 "eiffel.y"
	yy_do_action_275
when 276 then
--|#line 1314 "eiffel.y"
	yy_do_action_276
when 277 then
--|#line 1316 "eiffel.y"
	yy_do_action_277
when 278 then
--|#line 1325 "eiffel.y"
	yy_do_action_278
when 279 then
--|#line 1331 "eiffel.y"
	yy_do_action_279
when 280 then
--|#line 1333 "eiffel.y"
	yy_do_action_280
when 281 then
--|#line 1337 "eiffel.y"
	yy_do_action_281
when 282 then
--|#line 1339 "eiffel.y"
	yy_do_action_282
when 283 then
--|#line 1339 "eiffel.y"
	yy_do_action_283
when 284 then
--|#line 1349 "eiffel.y"
	yy_do_action_284
when 285 then
--|#line 1351 "eiffel.y"
	yy_do_action_285
when 286 then
--|#line 1353 "eiffel.y"
	yy_do_action_286
when 287 then
--|#line 1357 "eiffel.y"
	yy_do_action_287
when 288 then
--|#line 1363 "eiffel.y"
	yy_do_action_288
when 289 then
--|#line 1365 "eiffel.y"
	yy_do_action_289
when 290 then
--|#line 1367 "eiffel.y"
	yy_do_action_290
when 291 then
--|#line 1371 "eiffel.y"
	yy_do_action_291
when 292 then
--|#line 1376 "eiffel.y"
	yy_do_action_292
when 293 then
--|#line 1383 "eiffel.y"
	yy_do_action_293
when 294 then
--|#line 1387 "eiffel.y"
	yy_do_action_294
when 295 then
--|#line 1389 "eiffel.y"
	yy_do_action_295
when 296 then
--|#line 1398 "eiffel.y"
	yy_do_action_296
when 297 then
--|#line 1400 "eiffel.y"
	yy_do_action_297
when 298 then
--|#line 1404 "eiffel.y"
	yy_do_action_298
when 299 then
--|#line 1406 "eiffel.y"
	yy_do_action_299
when 300 then
--|#line 1410 "eiffel.y"
	yy_do_action_300
when 301 then
--|#line 1412 "eiffel.y"
	yy_do_action_301
when 302 then
--|#line 1416 "eiffel.y"
	yy_do_action_302
when 303 then
--|#line 1421 "eiffel.y"
	yy_do_action_303
when 304 then
--|#line 1428 "eiffel.y"
	yy_do_action_304
when 305 then
--|#line 1434 "eiffel.y"
	yy_do_action_305
when 306 then
--|#line 1439 "eiffel.y"
	yy_do_action_306
when 307 then
--|#line 1444 "eiffel.y"
	yy_do_action_307
when 308 then
--|#line 1454 "eiffel.y"
	yy_do_action_308
when 309 then
--|#line 1464 "eiffel.y"
	yy_do_action_309
when 310 then
--|#line 1476 "eiffel.y"
	yy_do_action_310
when 311 then
--|#line 1479 "eiffel.y"
	yy_do_action_311
when 312 then
--|#line 1481 "eiffel.y"
	yy_do_action_312
when 313 then
--|#line 1483 "eiffel.y"
	yy_do_action_313
when 314 then
--|#line 1485 "eiffel.y"
	yy_do_action_314
when 315 then
--|#line 1487 "eiffel.y"
	yy_do_action_315
when 316 then
--|#line 1489 "eiffel.y"
	yy_do_action_316
when 317 then
--|#line 1491 "eiffel.y"
	yy_do_action_317
when 318 then
--|#line 1500 "eiffel.y"
	yy_do_action_318
when 319 then
--|#line 1509 "eiffel.y"
	yy_do_action_319
when 320 then
--|#line 1519 "eiffel.y"
	yy_do_action_320
when 321 then
--|#line 1528 "eiffel.y"
	yy_do_action_321
when 322 then
--|#line 1537 "eiffel.y"
	yy_do_action_322
when 323 then
--|#line 1546 "eiffel.y"
	yy_do_action_323
when 324 then
--|#line 1557 "eiffel.y"
	yy_do_action_324
when 325 then
--|#line 1559 "eiffel.y"
	yy_do_action_325
when 326 then
--|#line 1563 "eiffel.y"
	yy_do_action_326
when 327 then
--|#line 1568 "eiffel.y"
	yy_do_action_327
when 328 then
--|#line 1575 "eiffel.y"
	yy_do_action_328
when 329 then
--|#line 1577 "eiffel.y"
	yy_do_action_329
when 330 then
--|#line 1579 "eiffel.y"
	yy_do_action_330
when 331 then
--|#line 1583 "eiffel.y"
	yy_do_action_331
when 332 then
--|#line 1592 "eiffel.y"
	yy_do_action_332
when 333 then
--|#line 1594 "eiffel.y"
	yy_do_action_333
when 334 then
--|#line 1598 "eiffel.y"
	yy_do_action_334
when 335 then
--|#line 1600 "eiffel.y"
	yy_do_action_335
when 336 then
--|#line 1611 "eiffel.y"
	yy_do_action_336
when 337 then
--|#line 1613 "eiffel.y"
	yy_do_action_337
when 338 then
--|#line 1617 "eiffel.y"
	yy_do_action_338
when 339 then
--|#line 1619 "eiffel.y"
	yy_do_action_339
when 340 then
--|#line 1623 "eiffel.y"
	yy_do_action_340
when 341 then
--|#line 1625 "eiffel.y"
	yy_do_action_341
when 342 then
--|#line 1633 "eiffel.y"
	yy_do_action_342
when 343 then
--|#line 1635 "eiffel.y"
	yy_do_action_343
when 344 then
--|#line 1637 "eiffel.y"
	yy_do_action_344
when 345 then
--|#line 1639 "eiffel.y"
	yy_do_action_345
when 346 then
--|#line 1641 "eiffel.y"
	yy_do_action_346
when 347 then
--|#line 1643 "eiffel.y"
	yy_do_action_347
when 348 then
--|#line 1645 "eiffel.y"
	yy_do_action_348
when 349 then
--|#line 1647 "eiffel.y"
	yy_do_action_349
when 350 then
--|#line 1649 "eiffel.y"
	yy_do_action_350
when 351 then
--|#line 1653 "eiffel.y"
	yy_do_action_351
when 352 then
--|#line 1661 "eiffel.y"
	yy_do_action_352
when 353 then
--|#line 1663 "eiffel.y"
	yy_do_action_353
when 354 then
--|#line 1665 "eiffel.y"
	yy_do_action_354
when 355 then
--|#line 1667 "eiffel.y"
	yy_do_action_355
when 356 then
--|#line 1669 "eiffel.y"
	yy_do_action_356
when 357 then
--|#line 1671 "eiffel.y"
	yy_do_action_357
when 358 then
--|#line 1673 "eiffel.y"
	yy_do_action_358
when 359 then
--|#line 1675 "eiffel.y"
	yy_do_action_359
when 360 then
--|#line 1677 "eiffel.y"
	yy_do_action_360
when 361 then
--|#line 1679 "eiffel.y"
	yy_do_action_361
when 362 then
--|#line 1681 "eiffel.y"
	yy_do_action_362
when 363 then
--|#line 1683 "eiffel.y"
	yy_do_action_363
when 364 then
--|#line 1685 "eiffel.y"
	yy_do_action_364
when 365 then
--|#line 1687 "eiffel.y"
	yy_do_action_365
when 366 then
--|#line 1689 "eiffel.y"
	yy_do_action_366
when 367 then
--|#line 1691 "eiffel.y"
	yy_do_action_367
when 368 then
--|#line 1693 "eiffel.y"
	yy_do_action_368
when 369 then
--|#line 1695 "eiffel.y"
	yy_do_action_369
when 370 then
--|#line 1697 "eiffel.y"
	yy_do_action_370
when 371 then
--|#line 1699 "eiffel.y"
	yy_do_action_371
when 372 then
--|#line 1701 "eiffel.y"
	yy_do_action_372
when 373 then
--|#line 1703 "eiffel.y"
	yy_do_action_373
when 374 then
--|#line 1705 "eiffel.y"
	yy_do_action_374
when 375 then
--|#line 1707 "eiffel.y"
	yy_do_action_375
when 376 then
--|#line 1709 "eiffel.y"
	yy_do_action_376
when 377 then
--|#line 1711 "eiffel.y"
	yy_do_action_377
when 378 then
--|#line 1713 "eiffel.y"
	yy_do_action_378
when 379 then
--|#line 1715 "eiffel.y"
	yy_do_action_379
when 380 then
--|#line 1717 "eiffel.y"
	yy_do_action_380
when 381 then
--|#line 1719 "eiffel.y"
	yy_do_action_381
when 382 then
--|#line 1721 "eiffel.y"
	yy_do_action_382
when 383 then
--|#line 1723 "eiffel.y"
	yy_do_action_383
when 384 then
--|#line 1725 "eiffel.y"
	yy_do_action_384
when 385 then
--|#line 1727 "eiffel.y"
	yy_do_action_385
when 386 then
--|#line 1729 "eiffel.y"
	yy_do_action_386
when 387 then
--|#line 1731 "eiffel.y"
	yy_do_action_387
when 388 then
--|#line 1735 "eiffel.y"
	yy_do_action_388
when 389 then
--|#line 1743 "eiffel.y"
	yy_do_action_389
when 390 then
--|#line 1745 "eiffel.y"
	yy_do_action_390
when 391 then
--|#line 1747 "eiffel.y"
	yy_do_action_391
when 392 then
--|#line 1749 "eiffel.y"
	yy_do_action_392
when 393 then
--|#line 1751 "eiffel.y"
	yy_do_action_393
when 394 then
--|#line 1753 "eiffel.y"
	yy_do_action_394
when 395 then
--|#line 1755 "eiffel.y"
	yy_do_action_395
when 396 then
--|#line 1757 "eiffel.y"
	yy_do_action_396
when 397 then
--|#line 1759 "eiffel.y"
	yy_do_action_397
when 398 then
--|#line 1761 "eiffel.y"
	yy_do_action_398
when 399 then
--|#line 1763 "eiffel.y"
	yy_do_action_399
when 400 then
--|#line 1765 "eiffel.y"
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
--|#line 1769 "eiffel.y"
	yy_do_action_401
when 402 then
--|#line 1773 "eiffel.y"
	yy_do_action_402
when 403 then
--|#line 1777 "eiffel.y"
	yy_do_action_403
when 404 then
--|#line 1781 "eiffel.y"
	yy_do_action_404
when 405 then
--|#line 1785 "eiffel.y"
	yy_do_action_405
when 406 then
--|#line 1789 "eiffel.y"
	yy_do_action_406
when 407 then
--|#line 1791 "eiffel.y"
	yy_do_action_407
when 408 then
--|#line 1793 "eiffel.y"
	yy_do_action_408
when 409 then
--|#line 1795 "eiffel.y"
	yy_do_action_409
when 410 then
--|#line 1797 "eiffel.y"
	yy_do_action_410
when 411 then
--|#line 1799 "eiffel.y"
	yy_do_action_411
when 412 then
--|#line 1801 "eiffel.y"
	yy_do_action_412
when 413 then
--|#line 1803 "eiffel.y"
	yy_do_action_413
when 414 then
--|#line 1805 "eiffel.y"
	yy_do_action_414
when 415 then
--|#line 1807 "eiffel.y"
	yy_do_action_415
when 416 then
--|#line 1809 "eiffel.y"
	yy_do_action_416
when 417 then
--|#line 1811 "eiffel.y"
	yy_do_action_417
when 418 then
--|#line 1813 "eiffel.y"
	yy_do_action_418
when 419 then
--|#line 1815 "eiffel.y"
	yy_do_action_419
when 420 then
--|#line 1817 "eiffel.y"
	yy_do_action_420
when 421 then
--|#line 1821 "eiffel.y"
	yy_do_action_421
when 422 then
--|#line 1825 "eiffel.y"
	yy_do_action_422
when 423 then
--|#line 1832 "eiffel.y"
	yy_do_action_423
when 424 then
--|#line 1840 "eiffel.y"
	yy_do_action_424
when 425 then
--|#line 1842 "eiffel.y"
	yy_do_action_425
when 426 then
--|#line 1846 "eiffel.y"
	yy_do_action_426
when 427 then
--|#line 1848 "eiffel.y"
	yy_do_action_427
when 428 then
--|#line 1852 "eiffel.y"
	yy_do_action_428
when 429 then
--|#line 1865 "eiffel.y"
	yy_do_action_429
when 430 then
--|#line 1869 "eiffel.y"
	yy_do_action_430
when 431 then
--|#line 1871 "eiffel.y"
	yy_do_action_431
when 432 then
--|#line 1873 "eiffel.y"
	yy_do_action_432
when 433 then
--|#line 1877 "eiffel.y"
	yy_do_action_433
when 434 then
--|#line 1882 "eiffel.y"
	yy_do_action_434
when 435 then
--|#line 1889 "eiffel.y"
	yy_do_action_435
when 436 then
--|#line 1891 "eiffel.y"
	yy_do_action_436
when 437 then
--|#line 1895 "eiffel.y"
	yy_do_action_437
when 438 then
--|#line 1900 "eiffel.y"
	yy_do_action_438
when 439 then
--|#line 1911 "eiffel.y"
	yy_do_action_439
when 440 then
--|#line 1913 "eiffel.y"
	yy_do_action_440
when 441 then
--|#line 1915 "eiffel.y"
	yy_do_action_441
when 442 then
--|#line 1917 "eiffel.y"
	yy_do_action_442
when 443 then
--|#line 1919 "eiffel.y"
	yy_do_action_443
when 444 then
--|#line 1921 "eiffel.y"
	yy_do_action_444
when 445 then
--|#line 1923 "eiffel.y"
	yy_do_action_445
when 446 then
--|#line 1925 "eiffel.y"
	yy_do_action_446
when 447 then
--|#line 1927 "eiffel.y"
	yy_do_action_447
when 448 then
--|#line 1929 "eiffel.y"
	yy_do_action_448
when 449 then
--|#line 1931 "eiffel.y"
	yy_do_action_449
when 450 then
--|#line 1933 "eiffel.y"
	yy_do_action_450
when 451 then
--|#line 1937 "eiffel.y"
	yy_do_action_451
when 452 then
--|#line 1939 "eiffel.y"
	yy_do_action_452
when 453 then
--|#line 1941 "eiffel.y"
	yy_do_action_453
when 454 then
--|#line 1943 "eiffel.y"
	yy_do_action_454
when 455 then
--|#line 1945 "eiffel.y"
	yy_do_action_455
when 456 then
--|#line 1947 "eiffel.y"
	yy_do_action_456
when 457 then
--|#line 1951 "eiffel.y"
	yy_do_action_457
when 458 then
--|#line 1953 "eiffel.y"
	yy_do_action_458
when 459 then
--|#line 1955 "eiffel.y"
	yy_do_action_459
when 460 then
--|#line 1970 "eiffel.y"
	yy_do_action_460
when 461 then
--|#line 1972 "eiffel.y"
	yy_do_action_461
when 462 then
--|#line 1974 "eiffel.y"
	yy_do_action_462
when 463 then
--|#line 1978 "eiffel.y"
	yy_do_action_463
when 464 then
--|#line 1980 "eiffel.y"
	yy_do_action_464
when 465 then
--|#line 1984 "eiffel.y"
	yy_do_action_465
when 466 then
--|#line 1991 "eiffel.y"
	yy_do_action_466
when 467 then
--|#line 2006 "eiffel.y"
	yy_do_action_467
when 468 then
--|#line 2021 "eiffel.y"
	yy_do_action_468
when 469 then
--|#line 2039 "eiffel.y"
	yy_do_action_469
when 470 then
--|#line 2041 "eiffel.y"
	yy_do_action_470
when 471 then
--|#line 2043 "eiffel.y"
	yy_do_action_471
when 472 then
--|#line 2050 "eiffel.y"
	yy_do_action_472
when 473 then
--|#line 2054 "eiffel.y"
	yy_do_action_473
when 474 then
--|#line 2056 "eiffel.y"
	yy_do_action_474
when 475 then
--|#line 2058 "eiffel.y"
	yy_do_action_475
when 476 then
--|#line 2062 "eiffel.y"
	yy_do_action_476
when 477 then
--|#line 2064 "eiffel.y"
	yy_do_action_477
when 478 then
--|#line 2066 "eiffel.y"
	yy_do_action_478
when 479 then
--|#line 2068 "eiffel.y"
	yy_do_action_479
when 480 then
--|#line 2070 "eiffel.y"
	yy_do_action_480
when 481 then
--|#line 2072 "eiffel.y"
	yy_do_action_481
when 482 then
--|#line 2074 "eiffel.y"
	yy_do_action_482
when 483 then
--|#line 2076 "eiffel.y"
	yy_do_action_483
when 484 then
--|#line 2078 "eiffel.y"
	yy_do_action_484
when 485 then
--|#line 2080 "eiffel.y"
	yy_do_action_485
when 486 then
--|#line 2082 "eiffel.y"
	yy_do_action_486
when 487 then
--|#line 2084 "eiffel.y"
	yy_do_action_487
when 488 then
--|#line 2086 "eiffel.y"
	yy_do_action_488
when 489 then
--|#line 2088 "eiffel.y"
	yy_do_action_489
when 490 then
--|#line 2090 "eiffel.y"
	yy_do_action_490
when 491 then
--|#line 2092 "eiffel.y"
	yy_do_action_491
when 492 then
--|#line 2094 "eiffel.y"
	yy_do_action_492
when 493 then
--|#line 2096 "eiffel.y"
	yy_do_action_493
when 494 then
--|#line 2098 "eiffel.y"
	yy_do_action_494
when 495 then
--|#line 2100 "eiffel.y"
	yy_do_action_495
when 496 then
--|#line 2102 "eiffel.y"
	yy_do_action_496
when 497 then
--|#line 2106 "eiffel.y"
	yy_do_action_497
when 498 then
--|#line 2108 "eiffel.y"
	yy_do_action_498
when 499 then
--|#line 2110 "eiffel.y"
	yy_do_action_499
when 500 then
--|#line 2112 "eiffel.y"
	yy_do_action_500
when 501 then
--|#line 2116 "eiffel.y"
	yy_do_action_501
when 502 then
--|#line 2118 "eiffel.y"
	yy_do_action_502
when 503 then
--|#line 2120 "eiffel.y"
	yy_do_action_503
when 504 then
--|#line 2122 "eiffel.y"
	yy_do_action_504
when 505 then
--|#line 2124 "eiffel.y"
	yy_do_action_505
when 506 then
--|#line 2126 "eiffel.y"
	yy_do_action_506
when 507 then
--|#line 2128 "eiffel.y"
	yy_do_action_507
when 508 then
--|#line 2130 "eiffel.y"
	yy_do_action_508
when 509 then
--|#line 2132 "eiffel.y"
	yy_do_action_509
when 510 then
--|#line 2134 "eiffel.y"
	yy_do_action_510
when 511 then
--|#line 2136 "eiffel.y"
	yy_do_action_511
when 512 then
--|#line 2138 "eiffel.y"
	yy_do_action_512
when 513 then
--|#line 2140 "eiffel.y"
	yy_do_action_513
when 514 then
--|#line 2142 "eiffel.y"
	yy_do_action_514
when 515 then
--|#line 2144 "eiffel.y"
	yy_do_action_515
when 516 then
--|#line 2146 "eiffel.y"
	yy_do_action_516
when 517 then
--|#line 2148 "eiffel.y"
	yy_do_action_517
when 518 then
--|#line 2150 "eiffel.y"
	yy_do_action_518
when 519 then
--|#line 2154 "eiffel.y"
	yy_do_action_519
when 520 then
--|#line 2158 "eiffel.y"
	yy_do_action_520
when 521 then
--|#line 2162 "eiffel.y"
	yy_do_action_521
when 522 then
--|#line 2166 "eiffel.y"
	yy_do_action_522
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 176 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 176")
end
			yyval := yyval_default;
				if type_parser then
					raise_error
				end
			

		end

	yy_do_action_2 is
			--|#line 183 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 183")
end
			yyval := yyval_default;
				if not type_parser then
					raise_error
				end
				type_node := yytype58 (yyvs.item (yyvsp))
			

		end

	yy_do_action_3 is
			--|#line 192 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 192")
end
			yyval := yyval_default;
				root_node := new_class_description (yytype86 (yyvs.item (yyvsp - 12)), yytype55 (yyvs.item (yyvsp - 10)),
					is_deferred, is_expanded, is_separate, is_frozen_class, is_external_class,
					yytype75 (yyvs.item (yyvsp - 15)), yytype75 (yyvs.item (yyvsp - 1)), yytype71 (yyvs.item (yyvsp - 11)), yytype79 (yyvs.item (yyvsp - 8)), yytype63 (yyvs.item (yyvsp - 6)), yytype68 (yyvs.item (yyvsp - 5)), yytype39 (yyvs.item (yyvsp - 3)), suppliers, yytype55 (yyvs.item (yyvsp - 9)), click_list
				)

				if real_class_end_position = 0 then
					root_node.set_text_positions (
						current_position.start_position,
						yytype91 (yyvs.item (yyvsp - 4)).start_position,
						yytype91 (yyvs.item (yyvsp - 7)).start_position,
						formal_generics_start_position,
						formal_generics_end_position,
						yytype91 (yyvs.item (yyvsp - 2)).start_position
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
			--|#line 234 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 234")
end
			yyval := yyval_default;
				if inherit_context then
					inherit_context := False
					real_class_end_position := 0
				end
			

		end

	yy_do_action_5 is
			--|#line 243 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 243")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_6 is
			--|#line 245 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 245")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_7 is
			--|#line 247 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 247")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_8 is
			--|#line 249 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 249")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_9 is
			--|#line 251 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 251")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_10 is
			--|#line 253 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 253")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_11 is
			--|#line 255 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 255")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_12 is
			--|#line 257 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 257")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_13 is
			--|#line 259 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 259")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_14 is
			--|#line 261 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 261")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_15 is
			--|#line 263 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 263")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_16 is
			--|#line 265 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 265")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_17 is
			--|#line 269 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 269")
end

yyval86 := new_clickable_id (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval86
		end

	yy_do_action_18 is
			--|#line 273 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 273")
end

yyval86 := new_clickable_id (new_boolean_id_as) 
			yyval := yyval86
		end

	yy_do_action_19 is
			--|#line 277 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 277")
end

yyval86 := new_clickable_id (new_character_id_as (False)) 
			yyval := yyval86
		end

	yy_do_action_20 is
			--|#line 281 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 281")
end

yyval86 := new_clickable_id (new_character_id_as (True)) 
			yyval := yyval86
		end

	yy_do_action_21 is
			--|#line 285 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 285")
end

yyval86 := new_clickable_id (new_double_id_as) 
			yyval := yyval86
		end

	yy_do_action_22 is
			--|#line 289 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 289")
end

yyval86 := new_clickable_id (new_integer_id_as (8)) 
			yyval := yyval86
		end

	yy_do_action_23 is
			--|#line 293 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 293")
end

yyval86 := new_clickable_id (new_integer_id_as (16)) 
			yyval := yyval86
		end

	yy_do_action_24 is
			--|#line 297 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 297")
end

yyval86 := new_clickable_id (new_integer_id_as (32)) 
			yyval := yyval86
		end

	yy_do_action_25 is
			--|#line 301 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 301")
end

yyval86 := new_clickable_id (new_integer_id_as (64)) 
			yyval := yyval86
		end

	yy_do_action_26 is
			--|#line 305 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 305")
end

yyval86 := new_clickable_id (new_none_id_as) 
			yyval := yyval86
		end

	yy_do_action_27 is
			--|#line 309 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 309")
end

yyval86 := new_clickable_id (new_pointer_id_as) 
			yyval := yyval86
		end

	yy_do_action_28 is
			--|#line 313 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 313")
end

yyval86 := new_clickable_id (new_real_id_as) 
			yyval := yyval86
		end

	yy_do_action_29 is
			--|#line 320 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 320")
end


			yyval := yyval75
		end

	yy_do_action_30 is
			--|#line 322 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 322")
end

yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
		end

	yy_do_action_31 is
			--|#line 324 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 324")
end


			yyval := yyval75
		end

	yy_do_action_32 is
			--|#line 328 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 328")
end


			yyval := yyval75
		end

	yy_do_action_33 is
			--|#line 330 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 330")
end

yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
		end

	yy_do_action_34 is
			--|#line 332 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 332")
end

yyval75 := Void 
			yyval := yyval75
		end

	yy_do_action_35 is
			--|#line 336 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 336")
end


			yyval := yyval75
		end

	yy_do_action_36 is
			--|#line 338 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 338")
end

yyval75 := yytype75 (yyvs.item (yyvsp - 1)) 
			yyval := yyval75
		end

	yy_do_action_37 is
			--|#line 340 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 340")
end

yyval75 := Void 
			yyval := yyval75
		end

	yy_do_action_38 is
			--|#line 344 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 344")
end

				yyval75 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval75.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_39 is
			--|#line 349 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 349")
end

				yyval75 := yytype75 (yyvs.item (yyvsp - 1))
				yyval75.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_40 is
			--|#line 356 "eiffel.y"
		local
			yyval32: INDEX_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 356")
end

yyval32 := new_index_as (yytype30 (yyvs.item (yyvsp - 2)), yytype61 (yyvs.item (yyvsp - 1))) 
			yyval := yyval32
		end

	yy_do_action_41 is
			--|#line 360 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 360")
end

yyval30 := yytype30 (yyvs.item (yyvsp - 1)) 
			yyval := yyval30
		end

	yy_do_action_42 is
			--|#line 362 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 362")
end


			yyval := yyval30
		end

	yy_do_action_43 is
			--|#line 366 "eiffel.y"
		local
			yyval61: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 366")
end

				yyval61 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval61.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_44 is
			--|#line 371 "eiffel.y"
		local
			yyval61: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 371")
end

				yyval61 := yytype61 (yyvs.item (yyvsp - 2))
				yyval61.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_45 is
			--|#line 376 "eiffel.y"
		local
			yyval61: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 376")
end

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval61 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval61
		end

	yy_do_action_46 is
			--|#line 383 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 383")
end

yyval6 := yytype30 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_47 is
			--|#line 385 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 385")
end

yyval6 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_48 is
			--|#line 387 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 387")
end

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype18 (yyvs.item (yyvsp - 1)), Void)
			
			yyval := yyval6
		end

	yy_do_action_49 is
			--|#line 391 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 391")
end

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype18 (yyvs.item (yyvsp - 2)), yytype57 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval6
		end

	yy_do_action_50 is
			--|#line 401 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 401")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_51 is
			--|#line 407 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 407")
end
			yyval := yyval_default;
				is_frozen_class := False
				is_deferred := True
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_52 is
			--|#line 414 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 414")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := True
				is_separate := False
			

		end

	yy_do_action_53 is
			--|#line 420 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 420")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := True
			

		end

	yy_do_action_54 is
			--|#line 428 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 428")
end
			yyval := yyval_default;
				is_frozen_class := False
			

		end

	yy_do_action_55 is
			--|#line 432 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 432")
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
			--|#line 443 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 443")
end
			yyval := yyval_default;
				is_external_class := False
			

		end

	yy_do_action_57 is
			--|#line 447 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 447")
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
			--|#line 462 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 462")
end


			yyval := yyval55
		end

	yy_do_action_59 is
			--|#line 464 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 464")
end

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_60 is
			--|#line 471 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 471")
end


			yyval := yyval68
		end

	yy_do_action_61 is
			--|#line 473 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 473")
end

				yyval68 := yytype68 (yyvs.item (yyvsp))
				if yyval68.is_empty then
					yyval68 := Void
				end
			
			yyval := yyval68
		end

	yy_do_action_62 is
			--|#line 482 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 482")
end

				yyval68 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval68, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_63 is
			--|#line 487 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 487")
end

				yyval68 := yytype68 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval68, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_64 is
			--|#line 494 "eiffel.y"
		local
			yyval27: FEATURE_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 494")
end

yyval27 := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) 
			yyval := yyval27
		end

	yy_do_action_65 is
			--|#line 496 "eiffel.y"
		local
			yyval27: FEATURE_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 496")
end

yyval27 := new_feature_clause_as (yytype14 (yyvs.item (yyvsp - 1)), yytype67 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval27
		end

	yy_do_action_66 is
			--|#line 500 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 500")
end

yyval14 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval14
		end

	yy_do_action_67 is
			--|#line 500 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 500")
end
			yyval := yyval_default;
				inherit_context := False
				fclause_pos := clone (current_position)
			

		end

	yy_do_action_68 is
			--|#line 509 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 509")
end


			yyval := yyval14
		end

	yy_do_action_69 is
			--|#line 511 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 511")
end

yyval14 := new_client_as (yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval14
		end

	yy_do_action_70 is
			--|#line 515 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 515")
end

				yyval72 := new_eiffel_list_id_as (1)
				yyval72.extend (new_none_id_as)
			
			yyval := yyval72
		end

	yy_do_action_71 is
			--|#line 520 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 520")
end

yyval72 := yytype72 (yyvs.item (yyvsp - 1)) 
			yyval := yyval72
		end

	yy_do_action_72 is
			--|#line 524 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 524")
end

				yyval72 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval72.extend (yytype86 (yyvs.item (yyvsp)).first)
				yytype86 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype86 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval72
		end

	yy_do_action_73 is
			--|#line 530 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 530")
end

				yyval72 := yytype72 (yyvs.item (yyvsp - 2))
				yyval72.extend (yytype86 (yyvs.item (yyvsp)).first)
				yytype86 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype86 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval72
		end

	yy_do_action_74 is
			--|#line 538 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [FEATURE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 538")
end

				yyval67 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval67.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_75 is
			--|#line 543 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [FEATURE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 543")
end

				yyval67 := yytype67 (yyvs.item (yyvsp - 1))
				yyval67.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_76 is
			--|#line 550 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 550")
end
			yyval := yyval_default;


		end

	yy_do_action_77 is
			--|#line 551 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 551")
end
			yyval := yyval_default;


		end

	yy_do_action_78 is
			--|#line 554 "eiffel.y"
		local
			yyval26: FEATURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 554")
end

					-- Generate a syntax error when `feature_indexes' is not
					-- Void and it applies to synonyms of the current feature
					-- declaration.
				if (il_parser and feature_indexes /= Void and yytype89 (yyvs.item (yyvsp - 2)).first.count /= 1) then
					raise_error
				end
				yyval26 := new_feature_declaration (yytype89 (yyvs.item (yyvsp - 2)), yytype8 (yyvs.item (yyvsp - 1)), feature_indexes)
				feature_indexes := Void
			
			yyval := yyval26
		end

	yy_do_action_79 is
			--|#line 567 "eiffel.y"
		local
			yyval89: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 567")
end

yyval89 := new_clickable_feature_name_list (yytype87 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval89
		end

	yy_do_action_80 is
			--|#line 569 "eiffel.y"
		local
			yyval89: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 569")
end

				yyval89 := yytype89 (yyvs.item (yyvsp - 2))
				yyval89.first.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval89
		end

	yy_do_action_81 is
			--|#line 576 "eiffel.y"
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 576")
end

yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
		end

	yy_do_action_82 is
			--|#line 580 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 580")
end
			yyval := yyval_default;
is_frozen := False 

		end

	yy_do_action_83 is
			--|#line 582 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 582")
end
			yyval := yyval_default;
is_frozen := True 

		end

	yy_do_action_84 is
			--|#line 586 "eiffel.y"
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 586")
end

yyval87 := new_clickable_feature_name (yytype86 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_85 is
			--|#line 588 "eiffel.y"
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 588")
end

yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
		end

	yy_do_action_86 is
			--|#line 590 "eiffel.y"
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 590")
end

yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
		end

	yy_do_action_87 is
			--|#line 594 "eiffel.y"
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 594")
end

yyval87 := new_clickable_infix (yytype88 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_88 is
			--|#line 599 "eiffel.y"
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 599")
end

yyval87 := new_clickable_prefix (yytype88 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_89 is
			--|#line 603 "eiffel.y"
		local
			yyval8: BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 603")
end

yyval8 := new_declaration_body (yytype84 (yyvs.item (yyvsp - 2)), yytype58 (yyvs.item (yyvsp - 1)), yytype15 (yyvs.item (yyvsp))) 
			yyval := yyval8
		end

	yy_do_action_90 is
			--|#line 607 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 607")
end

feature_indexes := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_91 is
			--|#line 609 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 609")
end

yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_92 is
			--|#line 613 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 613")
end

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (yytype6 (yyvs.item (yyvsp - 1))))
				feature_indexes := yytype75 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_93 is
			--|#line 618 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 618")
end

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (new_unique_as))
				feature_indexes := yytype75 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_94 is
			--|#line 623 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 623")
end

				yyval15 := yytype53 (yyvs.item (yyvsp))
				feature_indexes := yytype75 (yyvs.item (yyvsp - 1))
			
			yyval := yyval15
		end

	yy_do_action_95 is
			--|#line 634 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 634")
end


			yyval := yyval79
		end

	yy_do_action_96 is
			--|#line 636 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 636")
end

yyval79 := yytype79 (yyvs.item (yyvsp)) 
			yyval := yyval79
		end

	yy_do_action_97 is
			--|#line 638 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 638")
end

yyval79 := new_eiffel_list_parent_as (0) 
			yyval := yyval79
		end

	yy_do_action_98 is
			--|#line 642 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 642")
end

				yyval79 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval79.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_99 is
			--|#line 647 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 647")
end

				yyval79 := yytype79 (yyvs.item (yyvsp - 1))
				yyval79.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_100 is
			--|#line 654 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 654")
end

				yyval44 := yytype44 (yyvs.item (yyvsp))
				yytype44 (yyvs.item (yyvsp)).set_location (yytype91 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_101 is
			--|#line 659 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 659")
end

				inherit_context := False
				yyval44 := yytype44 (yyvs.item (yyvsp - 1))
				yytype44 (yyvs.item (yyvsp - 1)).set_location (yytype91 (yyvs.item (yyvsp - 2)))
			
			yyval := yyval44
		end

	yy_do_action_102 is
			--|#line 667 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 667")
end

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_103 is
			--|#line 672 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 672")
end

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 7)), yytype83 (yyvs.item (yyvsp - 6)), yytype80 (yyvs.item (yyvsp - 5)), yytype65 (yyvs.item (yyvsp - 4)), yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_104 is
			--|#line 677 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 677")
end

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 6)), yytype83 (yyvs.item (yyvsp - 5)), Void, yytype65 (yyvs.item (yyvsp - 4)), yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_105 is
			--|#line 682 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 682")
end

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 5)), yytype83 (yyvs.item (yyvsp - 4)), Void, Void, yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_106 is
			--|#line 687 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 687")
end

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 4)), yytype83 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_107 is
			--|#line 692 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 692")
end

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 3)), yytype83 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_108 is
			--|#line 697 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 697")
end

				inherit_context := True
				real_class_end_position := current_position.end_position - 3
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 2)), yytype83 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_109 is
			--|#line 705 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 705")
end


			yyval := yyval80
		end

	yy_do_action_110 is
			--|#line 707 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 707")
end

yyval80 := yytype80 (yyvs.item (yyvsp)) 
			yyval := yyval80
		end

	yy_do_action_111 is
			--|#line 711 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 711")
end

				yyval80 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval80.extend (yytype48 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_112 is
			--|#line 716 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 716")
end

				yyval80 := yytype80 (yyvs.item (yyvsp - 2))
				yyval80.extend (yytype48 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_113 is
			--|#line 723 "eiffel.y"
		local
			yyval48: RENAME_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 723")
end

yyval48 := new_rename_pair (yytype87 (yyvs.item (yyvsp - 2)), yytype87 (yyvs.item (yyvsp))) 
			yyval := yyval48
		end

	yy_do_action_114 is
			--|#line 727 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 727")
end


			yyval := yyval65
		end

	yy_do_action_115 is
			--|#line 729 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 729")
end

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_116 is
			--|#line 733 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 733")
end

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_117 is
			--|#line 735 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 735")
end


			yyval := yyval65
		end

	yy_do_action_118 is
			--|#line 739 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 739")
end

				yyval65 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				yyval65.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_119 is
			--|#line 744 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 744")
end

				yyval65 := yytype65 (yyvs.item (yyvsp - 1))
				yyval65.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_120 is
			--|#line 751 "eiffel.y"
		local
			yyval22: EXPORT_ITEM_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 751")
end

yyval22 := new_export_item_as (new_client_as (yytype72 (yyvs.item (yyvsp - 2))), yytype28 (yyvs.item (yyvsp - 1))) 
			yyval := yyval22
		end

	yy_do_action_121 is
			--|#line 755 "eiffel.y"
		local
			yyval28: FEATURE_SET_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 755")
end

yyval28 := new_all_as 
			yyval := yyval28
		end

	yy_do_action_122 is
			--|#line 757 "eiffel.y"
		local
			yyval28: FEATURE_SET_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 757")
end

yyval28 := new_feature_list_as (yytype70 (yyvs.item (yyvsp))) 
			yyval := yyval28
		end

	yy_do_action_123 is
			--|#line 761 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 761")
end

				yyval70 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval70.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval70
		end

	yy_do_action_124 is
			--|#line 766 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 766")
end

				yyval70 := yytype70 (yyvs.item (yyvsp - 2))
				yyval70.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval70
		end

	yy_do_action_125 is
			--|#line 773 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 773")
end


			yyval := yyval70
		end

	yy_do_action_126 is
			--|#line 775 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 775")
end

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_127 is
			--|#line 779 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 779")
end


			yyval := yyval70
		end

	yy_do_action_128 is
			--|#line 781 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 781")
end

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_129 is
			--|#line 785 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 785")
end


			yyval := yyval70
		end

	yy_do_action_130 is
			--|#line 787 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 787")
end

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_131 is
			--|#line 791 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 791")
end


			yyval := yyval70
		end

	yy_do_action_132 is
			--|#line 793 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 793")
end

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_133 is
			--|#line 797 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 797")
end


			yyval := yyval70
		end

	yy_do_action_134 is
			--|#line 799 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 799")
end

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_135 is
			--|#line 803 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 803")
end


			yyval := yyval70
		end

	yy_do_action_136 is
			--|#line 805 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 805")
end

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_137 is
			--|#line 813 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 813")
end


			yyval := yyval84
		end

	yy_do_action_138 is
			--|#line 815 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 815")
end

yyval84 := yytype84 (yyvs.item (yyvsp - 1)) 
			yyval := yyval84
		end

	yy_do_action_139 is
			--|#line 819 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 819")
end


			yyval := yyval84
		end

	yy_do_action_140 is
			--|#line 821 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 821")
end

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_141 is
			--|#line 825 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 825")
end

				yyval84 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_142 is
			--|#line 830 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 830")
end

				yyval84 := yytype84 (yyvs.item (yyvsp - 1))
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_143 is
			--|#line 837 "eiffel.y"
		local
			yyval59: TYPE_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 837")
end

yyval59 := new_type_dec_as (yytype74 (yyvs.item (yyvsp - 4)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval59
		end

	yy_do_action_144 is
			--|#line 841 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 841")
end
			yyval := yyval_default;


		end

	yy_do_action_145 is
			--|#line 842 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 842")
end
			yyval := yyval_default;
				if il_parser then
						-- Trigger a syntax error.
					raise_error
				end
			

		end

	yy_do_action_146 is
			--|#line 851 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 851")
end


			yyval := yyval84
		end

	yy_do_action_147 is
			--|#line 853 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 853")
end

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_148 is
			--|#line 857 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 857")
end

				yyval84 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_149 is
			--|#line 862 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 862")
end

				yyval84 := yytype84 (yyvs.item (yyvsp - 1))
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_150 is
			--|#line 869 "eiffel.y"
		local
			yyval59: TYPE_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 869")
end

yyval59 := new_type_dec_as (yytype74 (yyvs.item (yyvsp - 3)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval59
		end

	yy_do_action_151 is
			--|#line 873 "eiffel.y"
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 873")
end

				create yyval74.make (Initial_identifier_list_size)
				Names_heap.put (yytype30 (yyvs.item (yyvsp)))
				yyval74.extend (Names_heap.found_item)
			
			yyval := yyval74
		end

	yy_do_action_152 is
			--|#line 879 "eiffel.y"
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 879")
end

				yyval74 := yytype74 (yyvs.item (yyvsp - 2))
				Names_heap.put (yytype30 (yyvs.item (yyvsp)))
				yyval74.extend (Names_heap.found_item)
			
			yyval := yyval74
		end

	yy_do_action_153 is
			--|#line 887 "eiffel.y"
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 887")
end

create yyval74.make (0) 
			yyval := yyval74
		end

	yy_do_action_154 is
			--|#line 889 "eiffel.y"
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 889")
end

yyval74 := yytype74 (yyvs.item (yyvsp)) 
			yyval := yyval74
		end

	yy_do_action_155 is
			--|#line 893 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 893")
end


			yyval := yyval58
		end

	yy_do_action_156 is
			--|#line 895 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 895")
end

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_157 is
			--|#line 899 "eiffel.y"
		local
			yyval53: ROUTINE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 899")
end

yyval53 := new_routine_as (yytype55 (yyvs.item (yyvsp - 7)), yytype49 (yyvs.item (yyvsp - 5)), yytype84 (yyvs.item (yyvsp - 4)), yytype52 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), fbody_pos, current_position) 
			yyval := yyval53
		end

	yy_do_action_158 is
			--|#line 899 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 899")
end
			yyval := yyval_default;
fbody_pos := current_position.start_position 

		end

	yy_do_action_159 is
			--|#line 911 "eiffel.y"
		local
			yyval52: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 911")
end

yyval52 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval52
		end

	yy_do_action_160 is
			--|#line 913 "eiffel.y"
		local
			yyval52: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 913")
end

yyval52 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval52
		end

	yy_do_action_161 is
			--|#line 915 "eiffel.y"
		local
			yyval52: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 915")
end

yyval52 := new_deferred_as 
			yyval := yyval52
		end

	yy_do_action_162 is
			--|#line 919 "eiffel.y"
		local
			yyval24: EXTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 919")
end

yyval24 := new_external_as (yytype25 (yyvs.item (yyvsp - 1)), yytype55 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_163 is
			--|#line 923 "eiffel.y"
		local
			yyval25: EXTERNAL_LANG_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 923")
end

yyval25 := new_external_lang_as (yytype55 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
		end

	yy_do_action_164 is
			--|#line 928 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 928")
end


			yyval := yyval55
		end

	yy_do_action_165 is
			--|#line 930 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 930")
end

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_166 is
			--|#line 934 "eiffel.y"
		local
			yyval37: INTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 934")
end

yyval37 := new_do_as (yytype76 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_167 is
			--|#line 936 "eiffel.y"
		local
			yyval37: INTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 936")
end

yyval37 := new_once_as (yytype76 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_168 is
			--|#line 940 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 940")
end


			yyval := yyval84
		end

	yy_do_action_169 is
			--|#line 942 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 942")
end

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_170 is
			--|#line 946 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 946")
end


			yyval := yyval76
		end

	yy_do_action_171 is
			--|#line 948 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 948")
end

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_172 is
			--|#line 952 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 952")
end

				yyval76 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval76.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_173 is
			--|#line 957 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 957")
end

				yyval76 := yytype76 (yyvs.item (yyvsp - 1))
				yyval76.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_174 is
			--|#line 964 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 964")
end

yyval35 := yytype35 (yyvs.item (yyvsp - 1)) 
			yyval := yyval35
		end

	yy_do_action_175 is
			--|#line 968 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 968")
end
			yyval := yyval_default;


		end

	yy_do_action_176 is
			--|#line 969 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 969")
end
			yyval := yyval_default;


		end

	yy_do_action_177 is
			--|#line 972 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 972")
end

yyval35 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_178 is
			--|#line 974 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 974")
end

yyval35 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_179 is
			--|#line 976 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 976")
end

yyval35 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_180 is
			--|#line 978 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 978")
end

yyval35 := yytype51 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_181 is
			--|#line 980 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 980")
end

yyval35 := yytype31 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_182 is
			--|#line 982 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 982")
end

yyval35 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_183 is
			--|#line 984 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 984")
end

yyval35 := yytype40 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_184 is
			--|#line 986 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 986")
end

yyval35 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_185 is
			--|#line 988 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 988")
end

yyval35 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_186 is
			--|#line 990 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 990")
end

yyval35 := yytype50 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_187 is
			--|#line 994 "eiffel.y"
		local
			yyval49: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 994")
end


			yyval := yyval49
		end

	yy_do_action_188 is
			--|#line 996 "eiffel.y"
		local
			yyval49: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 996")
end

				id_level := Normal_level
				yyval49 := new_require_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval49
		end

	yy_do_action_189 is
			--|#line 996 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 996")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_190 is
			--|#line 1003 "eiffel.y"
		local
			yyval49: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1003")
end

				id_level := Normal_level
				yyval49 := new_require_else_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval49
		end

	yy_do_action_191 is
			--|#line 1003 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1003")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_192 is
			--|#line 1012 "eiffel.y"
		local
			yyval21: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1012")
end


			yyval := yyval21
		end

	yy_do_action_193 is
			--|#line 1014 "eiffel.y"
		local
			yyval21: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1014")
end

				id_level := Normal_level
				yyval21 := new_ensure_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_194 is
			--|#line 1014 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1014")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_195 is
			--|#line 1021 "eiffel.y"
		local
			yyval21: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1021")
end

				id_level := Normal_level
				yyval21 := new_ensure_then_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_196 is
			--|#line 1021 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1021")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_197 is
			--|#line 1030 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1030")
end


			yyval := yyval82
		end

	yy_do_action_198 is
			--|#line 1032 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1032")
end

				yyval82 := yytype82 (yyvs.item (yyvsp))
				if yyval82.is_empty then
					yyval82 := Void
				end
			
			yyval := yyval82
		end

	yy_do_action_199 is
			--|#line 1041 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1041")
end

				yyval82 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval82, yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_200 is
			--|#line 1046 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1046")
end

				yyval82 := yytype82 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval82, yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_201 is
			--|#line 1053 "eiffel.y"
		local
			yyval56: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1053")
end

yyval56 := yytype56 (yyvs.item (yyvsp - 1)) 
			yyval := yyval56
		end

	yy_do_action_202 is
			--|#line 1057 "eiffel.y"
		local
			yyval56: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1057")
end

yyval56 := new_tagged_as (Void, yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval56
		end

	yy_do_action_203 is
			--|#line 1059 "eiffel.y"
		local
			yyval56: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1059")
end

yyval56 := new_tagged_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval56
		end

	yy_do_action_204 is
			--|#line 1061 "eiffel.y"
		local
			yyval56: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1061")
end


			yyval := yyval56
		end

	yy_do_action_205 is
			--|#line 1069 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1069")
end

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_206 is
			--|#line 1071 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1071")
end

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_207 is
			--|#line 1075 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1075")
end

yyval58 := new_expanded_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_208 is
			--|#line 1077 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1077")
end

yyval58 := new_separate_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_209 is
			--|#line 1079 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1079")
end

yyval58 := new_bits_as (yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_210 is
			--|#line 1081 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1081")
end

yyval58 := new_bits_symbol_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_211 is
			--|#line 1083 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1083")
end

yyval58 := new_like_id_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_212 is
			--|#line 1085 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1085")
end

yyval58 := new_like_current_as 
			yyval := yyval58
		end

	yy_do_action_213 is
			--|#line 1089 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1089")
end

yyval58 := new_class_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_214 is
			--|#line 1091 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1091")
end

yyval58 := new_boolean_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_215 is
			--|#line 1093 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1093")
end

yyval58 := new_character_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, False) 
			yyval := yyval58
		end

	yy_do_action_216 is
			--|#line 1095 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1095")
end

yyval58 := new_character_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, True) 
			yyval := yyval58
		end

	yy_do_action_217 is
			--|#line 1097 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1097")
end

yyval58 := new_double_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_218 is
			--|#line 1099 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1099")
end

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 8) 
			yyval := yyval58
		end

	yy_do_action_219 is
			--|#line 1101 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1101")
end

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 16) 
			yyval := yyval58
		end

	yy_do_action_220 is
			--|#line 1103 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1103")
end

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 32) 
			yyval := yyval58
		end

	yy_do_action_221 is
			--|#line 1105 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1105")
end

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 64) 
			yyval := yyval58
		end

	yy_do_action_222 is
			--|#line 1107 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1107")
end

yyval58 := new_none_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_223 is
			--|#line 1109 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1109")
end

yyval58 := new_pointer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_224 is
			--|#line 1111 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1111")
end

yyval58 := new_real_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_225 is
			--|#line 1115 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1115")
end


			yyval := yyval83
		end

	yy_do_action_226 is
			--|#line 1117 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1117")
end


			yyval := yyval83
		end

	yy_do_action_227 is
			--|#line 1119 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1119")
end

yyval83 := yytype83 (yyvs.item (yyvsp - 1)) 
			yyval := yyval83
		end

	yy_do_action_228 is
			--|#line 1123 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1123")
end

				yyval83 := new_eiffel_list_type (Initial_type_list_size)
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_229 is
			--|#line 1128 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1128")
end

				yyval83 := yytype83 (yyvs.item (yyvsp - 2))
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_230 is
			--|#line 1139 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1139")
end

				-- $$ := Void
				formal_generics_start_position := current_position.start_position
				formal_generics_end_position := 0
			
			yyval := yyval71
		end

	yy_do_action_231 is
			--|#line 1145 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1145")
end

				yyval71 := yytype71 (yyvs.item (yyvsp - 1))
				formal_generics_start_position := yytype91 (yyvs.item (yyvsp - 3)).start_position
				formal_generics_end_position := current_position.start_position
			
			yyval := yyval71
		end

	yy_do_action_232 is
			--|#line 1153 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1153")
end


			yyval := yyval71
		end

	yy_do_action_233 is
			--|#line 1155 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1155")
end

yyval71 := yytype71 (yyvs.item (yyvsp)) 
			yyval := yyval71
		end

	yy_do_action_234 is
			--|#line 1159 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1159")
end

				yyval71 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval71.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_235 is
			--|#line 1164 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1164")
end

				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_236 is
			--|#line 1171 "eiffel.y"
		local
			yyval29: FORMAL_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1171")
end

				check formal_exists: not formal_parameters.is_empty end
				yyval29 := new_formal_dec_as (formal_parameters.last, yytype90 (yyvs.item (yyvsp)).first, yytype90 (yyvs.item (yyvsp)).second, formal_parameters.count)
			
			yyval := yyval29
		end

	yy_do_action_237 is
			--|#line 1171 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1171")
end
			yyval := yyval_default;
formal_parameters.extend (create {ID_AS}.initialize (token_buffer)) 

		end

	yy_do_action_238 is
			--|#line 1181 "eiffel.y"
		local
			yyval90: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1181")
end

create yyval90 
			yyval := yyval90
		end

	yy_do_action_239 is
			--|#line 1183 "eiffel.y"
		local
			yyval90: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1183")
end

				create yyval90
				yyval90.set_first (yytype58 (yyvs.item (yyvsp - 1)))
				yyval90.set_second (yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval90
		end

	yy_do_action_240 is
			--|#line 1191 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1191")
end


			yyval := yyval70
		end

	yy_do_action_241 is
			--|#line 1193 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1193")
end

yyval70 := yytype70 (yyvs.item (yyvsp - 1)) 
			yyval := yyval70
		end

	yy_do_action_242 is
			--|#line 1201 "eiffel.y"
		local
			yyval31: IF_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1201")
end

				yyval31 := new_if_as (yytype23 (yyvs.item (yyvsp - 5)), yytype76 (yyvs.item (yyvsp - 3)), yytype64 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 7)), current_position)
			
			yyval := yyval31
		end

	yy_do_action_243 is
			--|#line 1207 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1207")
end


			yyval := yyval64
		end

	yy_do_action_244 is
			--|#line 1209 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1209")
end

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_245 is
			--|#line 1213 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1213")
end

				yyval64 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval64.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_246 is
			--|#line 1218 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1218")
end

				yyval64 := yytype64 (yyvs.item (yyvsp - 1))
				yyval64.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_247 is
			--|#line 1225 "eiffel.y"
		local
			yyval20: ELSIF_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1225")
end

yyval20 := new_elseif_as (yytype23 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 4))) 
			yyval := yyval20
		end

	yy_do_action_248 is
			--|#line 1229 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1229")
end


			yyval := yyval76
		end

	yy_do_action_249 is
			--|#line 1231 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1231")
end

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_250 is
			--|#line 1235 "eiffel.y"
		local
			yyval33: INSPECT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1235")
end

				yyval33 := new_inspect_as (yytype23 (yyvs.item (yyvsp - 3)), yytype62 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval33
		end

	yy_do_action_251 is
			--|#line 1241 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1241")
end


			yyval := yyval62
		end

	yy_do_action_252 is
			--|#line 1243 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1243")
end

yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
		end

	yy_do_action_253 is
			--|#line 1247 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1247")
end

				yyval62 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval62.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_254 is
			--|#line 1252 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1252")
end

				yyval62 := yytype62 (yyvs.item (yyvsp - 1))
				yyval62.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_255 is
			--|#line 1259 "eiffel.y"
		local
			yyval11: CASE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1259")
end

yyval11 := new_case_as (yytype77 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval11
		end

	yy_do_action_256 is
			--|#line 1263 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [INTERVAL_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1263")
end

				yyval77 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval77.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_257 is
			--|#line 1268 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [INTERVAL_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1268")
end

				yyval77 := yytype77 (yyvs.item (yyvsp - 2))
				yyval77.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_258 is
			--|#line 1275 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1275")
end

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_259 is
			--|#line 1277 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1277")
end

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_260 is
			--|#line 1279 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1279")
end

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_261 is
			--|#line 1281 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1281")
end

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_262 is
			--|#line 1283 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1283")
end

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_263 is
			--|#line 1285 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1285")
end

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_264 is
			--|#line 1287 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1287")
end

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_265 is
			--|#line 1289 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1289")
end

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_266 is
			--|#line 1291 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1291")
end

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_267 is
			--|#line 1293 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1293")
end

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_268 is
			--|#line 1295 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1295")
end

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_269 is
			--|#line 1297 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1297")
end

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_270 is
			--|#line 1299 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1299")
end

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_271 is
			--|#line 1301 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1301")
end

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_272 is
			--|#line 1303 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1303")
end

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_273 is
			--|#line 1305 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1305")
end

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_274 is
			--|#line 1307 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1307")
end

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_275 is
			--|#line 1309 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1309")
end

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_276 is
			--|#line 1314 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1314")
end


			yyval := yyval76
		end

	yy_do_action_277 is
			--|#line 1316 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1316")
end

				yyval76 := yytype76 (yyvs.item (yyvsp))
				if yyval76 = Void then
					yyval76 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval76
		end

	yy_do_action_278 is
			--|#line 1325 "eiffel.y"
		local
			yyval40: LOOP_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1325")
end

				yyval40 := new_loop_as (yytype76 (yyvs.item (yyvsp - 8)), yytype82 (yyvs.item (yyvsp - 7)), yytype60 (yyvs.item (yyvsp - 6)), yytype23 (yyvs.item (yyvsp - 3)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval40
		end

	yy_do_action_279 is
			--|#line 1331 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1331")
end


			yyval := yyval82
		end

	yy_do_action_280 is
			--|#line 1333 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1333")
end

yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
		end

	yy_do_action_281 is
			--|#line 1337 "eiffel.y"
		local
			yyval39: INVARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1337")
end


			yyval := yyval39
		end

	yy_do_action_282 is
			--|#line 1339 "eiffel.y"
		local
			yyval39: INVARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1339")
end

				id_level := Normal_level
				inherit_context := False
				yyval39 := new_invariant_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval39
		end

	yy_do_action_283 is
			--|#line 1339 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1339")
end
			yyval := yyval_default;
id_level := Invariant_level 

		end

	yy_do_action_284 is
			--|#line 1349 "eiffel.y"
		local
			yyval60: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1349")
end


			yyval := yyval60
		end

	yy_do_action_285 is
			--|#line 1351 "eiffel.y"
		local
			yyval60: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1351")
end

yyval60 := new_variant_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval60
		end

	yy_do_action_286 is
			--|#line 1353 "eiffel.y"
		local
			yyval60: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1353")
end

yyval60 := new_variant_as (Void, yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval60
		end

	yy_do_action_287 is
			--|#line 1357 "eiffel.y"
		local
			yyval19: DEBUG_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1357")
end

				yyval19 := new_debug_as (yytype81 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval19
		end

	yy_do_action_288 is
			--|#line 1363 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1363")
end


			yyval := yyval81
		end

	yy_do_action_289 is
			--|#line 1365 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1365")
end


			yyval := yyval81
		end

	yy_do_action_290 is
			--|#line 1367 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1367")
end

yyval81 := yytype81 (yyvs.item (yyvsp - 1)) 
			yyval := yyval81
		end

	yy_do_action_291 is
			--|#line 1371 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1371")
end

				yyval81 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval81.extend (yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_292 is
			--|#line 1376 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1376")
end

				yyval81 := yytype81 (yyvs.item (yyvsp - 2))
				yyval81.extend (yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_293 is
			--|#line 1383 "eiffel.y"
		local
			yyval50: RETRY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1383")
end

yyval50 := new_retry_as (current_position) 
			yyval := yyval50
		end

	yy_do_action_294 is
			--|#line 1387 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1387")
end


			yyval := yyval76
		end

	yy_do_action_295 is
			--|#line 1389 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1389")
end

				yyval76 := yytype76 (yyvs.item (yyvsp))
				if yyval76 = Void then
					yyval76 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval76
		end

	yy_do_action_296 is
			--|#line 1398 "eiffel.y"
		local
			yyval5: ASSIGN_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1398")
end

yyval5 := new_assign_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_297 is
			--|#line 1400 "eiffel.y"
		local
			yyval5: ASSIGN_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1400")
end

yyval5 := new_assign_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_298 is
			--|#line 1404 "eiffel.y"
		local
			yyval51: REVERSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1404")
end

yyval51 := new_reverse_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval51
		end

	yy_do_action_299 is
			--|#line 1406 "eiffel.y"
		local
			yyval51: REVERSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1406")
end

yyval51 := new_reverse_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval51
		end

	yy_do_action_300 is
			--|#line 1410 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1410")
end


			yyval := yyval63
		end

	yy_do_action_301 is
			--|#line 1412 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1412")
end

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_302 is
			--|#line 1416 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1416")
end

				yyval63 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval63.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_303 is
			--|#line 1421 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1421")
end

				yyval63 := yytype63 (yyvs.item (yyvsp - 1))
				yyval63.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_304 is
			--|#line 1428 "eiffel.y"
		local
			yyval16: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1428")
end

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_305 is
			--|#line 1434 "eiffel.y"
		local
			yyval16: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1434")
end

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_306 is
			--|#line 1439 "eiffel.y"
		local
			yyval16: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1439")
end

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype72 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_307 is
			--|#line 1444 "eiffel.y"
		local
			yyval16: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1444")
end

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype91 (yyvs.item (yyvsp - 1)).start_position,
						yytype91 (yyvs.item (yyvsp - 1)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval16
		end

	yy_do_action_308 is
			--|#line 1454 "eiffel.y"
		local
			yyval16: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1454")
end

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype70 (yyvs.item (yyvsp)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype91 (yyvs.item (yyvsp - 3)).start_position,
						yytype91 (yyvs.item (yyvsp - 3)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval16
		end

	yy_do_action_309 is
			--|#line 1464 "eiffel.y"
		local
			yyval16: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1464")
end

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype72 (yyvs.item (yyvsp))), Void)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype91 (yyvs.item (yyvsp - 2)).start_position,
						yytype91 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval16
		end

	yy_do_action_310 is
			--|#line 1476 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1476")
end

yyval54 := new_routine_creation_as (new_result_operand_as, yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_311 is
			--|#line 1479 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1479")
end

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_312 is
			--|#line 1481 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1481")
end

yyval54 := new_routine_creation_as (new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 3)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_313 is
			--|#line 1483 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1483")
end

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 4))), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_314 is
			--|#line 1485 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1485")
end

yyval54 := new_routine_creation_as (new_operand_as (yytype58 (yyvs.item (yyvsp - 4)), Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_315 is
			--|#line 1487 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1487")
end

yyval54 := new_routine_creation_as (Void, yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_316 is
			--|#line 1489 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1489")
end

yyval54 := new_unqualified_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_317 is
			--|#line 1491 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1491")
end

			yyval54 := new_routine_creation_as (new_result_operand_as, yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype91 (yyvs.item (yyvsp - 2)).start_position,
					yytype91 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval54
		end

	yy_do_action_318 is
			--|#line 1500 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1500")
end

			yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype91 (yyvs.item (yyvsp - 2)).start_position,
					yytype91 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval54
		end

	yy_do_action_319 is
			--|#line 1509 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1509")
end

			yyval54 := new_routine_creation_as (new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 4)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype91 (yyvs.item (yyvsp - 2)).start_position,
					yytype91 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
			
		
			yyval := yyval54
		end

	yy_do_action_320 is
			--|#line 1519 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1519")
end

			yyval54 := new_routine_creation_As (new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 5))), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype91 (yyvs.item (yyvsp - 2)).start_position,
					yytype91 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval54
		end

	yy_do_action_321 is
			--|#line 1528 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1528")
end

			yyval54 := new_routine_creation_as (new_operand_as (yytype58 (yyvs.item (yyvsp - 4)), Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype91 (yyvs.item (yyvsp - 2)).start_position,
					yytype91 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval54
		end

	yy_do_action_322 is
			--|#line 1537 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1537")
end

			yyval54 := new_routine_creation_as (Void, yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype91 (yyvs.item (yyvsp - 2)).start_position,
					yytype91 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval54
		end

	yy_do_action_323 is
			--|#line 1546 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1546")
end

			yyval54 := new_unqualified_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype91 (yyvs.item (yyvsp - 2)).start_position,
					yytype91 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval54
		end

	yy_do_action_324 is
			--|#line 1557 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1557")
end


			yyval := yyval78
		end

	yy_do_action_325 is
			--|#line 1559 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1559")
end

yyval78 := yytype78 (yyvs.item (yyvsp - 1)) 
			yyval := yyval78
		end

	yy_do_action_326 is
			--|#line 1563 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1563")
end

				yyval78 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval78.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_327 is
			--|#line 1568 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1568")
end

				yyval78 := yytype78 (yyvs.item (yyvsp - 2))
				yyval78.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_328 is
			--|#line 1575 "eiffel.y"
		local
			yyval43: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1575")
end

yyval43 := new_operand_as (Void, Void, Void) 
			yyval := yyval43
		end

	yy_do_action_329 is
			--|#line 1577 "eiffel.y"
		local
			yyval43: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1577")
end

yyval43 := new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval43
		end

	yy_do_action_330 is
			--|#line 1579 "eiffel.y"
		local
			yyval43: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1579")
end

yyval43 := new_operand_as (yytype58 (yyvs.item (yyvsp - 1)), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_331 is
			--|#line 1583 "eiffel.y"
		local
			yyval17: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1583")
end

				yyval17 := new_creation_as (yytype58 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 5)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype91 (yyvs.item (yyvsp - 5)).start_position,
						yytype91 (yyvs.item (yyvsp - 5)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval17
		end

	yy_do_action_332 is
			--|#line 1592 "eiffel.y"
		local
			yyval17: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1592")
end

yyval17 := new_creation_as (Void, yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval17
		end

	yy_do_action_333 is
			--|#line 1594 "eiffel.y"
		local
			yyval17: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1594")
end

yyval17 := new_creation_as (yytype58 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 6))) 
			yyval := yyval17
		end

	yy_do_action_334 is
			--|#line 1598 "eiffel.y"
		local
			yyval18: CREATION_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1598")
end

yyval18 := new_creation_expr_as (yytype58 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval18
		end

	yy_do_action_335 is
			--|#line 1600 "eiffel.y"
		local
			yyval18: CREATION_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1600")
end

				yyval18 := new_creation_expr_as (yytype58 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype91 (yyvs.item (yyvsp - 1)).start_position,
						yytype91 (yyvs.item (yyvsp - 1)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval18
		end

	yy_do_action_336 is
			--|#line 1611 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1611")
end


			yyval := yyval58
		end

	yy_do_action_337 is
			--|#line 1613 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1613")
end

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_338 is
			--|#line 1617 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1617")
end

yyval1 := new_access_id_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval1
		end

	yy_do_action_339 is
			--|#line 1619 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1619")
end

yyval1 := new_result_as 
			yyval := yyval1
		end

	yy_do_action_340 is
			--|#line 1623 "eiffel.y"
		local
			yyval3: ACCESS_INV_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1623")
end


			yyval := yyval3
		end

	yy_do_action_341 is
			--|#line 1625 "eiffel.y"
		local
			yyval3: ACCESS_INV_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1625")
end

yyval3 := new_access_inv_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_342 is
			--|#line 1633 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1633")
end

yyval34 := new_instr_call_as (yytype1 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_343 is
			--|#line 1635 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1635")
end

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_344 is
			--|#line 1637 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1637")
end

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_345 is
			--|#line 1639 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1639")
end

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_346 is
			--|#line 1641 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1641")
end

yyval34 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_347 is
			--|#line 1643 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1643")
end

yyval34 := new_instr_call_as (yytype45 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_348 is
			--|#line 1645 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1645")
end

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_349 is
			--|#line 1647 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1647")
end

yyval34 := new_instr_call_as (yytype46 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_350 is
			--|#line 1649 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1649")
end

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_351 is
			--|#line 1653 "eiffel.y"
		local
			yyval13: CHECK_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1653")
end

yyval13 := new_check_as (yytype82 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 3)), current_position) 
			yyval := yyval13
		end

	yy_do_action_352 is
			--|#line 1661 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1661")
end

create {VALUE_AS} yyval23.initialize (yytype6 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_353 is
			--|#line 1663 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1663")
end

create {VALUE_AS} yyval23.initialize (yytype4 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_354 is
			--|#line 1665 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1665")
end

create {VALUE_AS} yyval23.initialize (yytype57 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_355 is
			--|#line 1667 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1667")
end

yyval23 := new_expr_call_as (yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_356 is
			--|#line 1669 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1669")
end

yyval23 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_357 is
			--|#line 1671 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1671")
end

yyval23 := new_paran_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_358 is
			--|#line 1673 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1673")
end

yyval23 := new_bin_plus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_359 is
			--|#line 1675 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1675")
end

yyval23 := new_bin_minus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_360 is
			--|#line 1677 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1677")
end

yyval23 := new_bin_star_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_361 is
			--|#line 1679 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1679")
end

yyval23 := new_bin_slash_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_362 is
			--|#line 1681 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1681")
end

yyval23 := new_bin_mod_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_363 is
			--|#line 1683 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1683")
end

yyval23 := new_bin_div_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_364 is
			--|#line 1685 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1685")
end

yyval23 := new_bin_power_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_365 is
			--|#line 1687 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1687")
end

yyval23 := new_bin_and_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_366 is
			--|#line 1689 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1689")
end

yyval23 := new_bin_and_then_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_367 is
			--|#line 1691 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1691")
end

yyval23 := new_bin_or_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_368 is
			--|#line 1693 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1693")
end

yyval23 := new_bin_or_else_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_369 is
			--|#line 1695 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1695")
end

yyval23 := new_bin_implies_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_370 is
			--|#line 1697 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1697")
end

yyval23 := new_bin_xor_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_371 is
			--|#line 1699 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1699")
end

yyval23 := new_bin_ge_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_372 is
			--|#line 1701 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1701")
end

yyval23 := new_bin_gt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_373 is
			--|#line 1703 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1703")
end

yyval23 := new_bin_le_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_374 is
			--|#line 1705 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1705")
end

yyval23 := new_bin_lt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_375 is
			--|#line 1707 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1707")
end

yyval23 := new_bin_eq_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_376 is
			--|#line 1709 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1709")
end

yyval23 := new_bin_ne_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_377 is
			--|#line 1711 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1711")
end

yyval23 := new_bin_free_as (yytype23 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_378 is
			--|#line 1713 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1713")
end

yyval23 := new_un_minus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_379 is
			--|#line 1715 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1715")
end

yyval23 := new_un_plus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_380 is
			--|#line 1717 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1717")
end

yyval23 := new_un_not_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_381 is
			--|#line 1719 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1719")
end

yyval23 := new_un_old_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_382 is
			--|#line 1721 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1721")
end

yyval23 := new_un_free_as (yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_383 is
			--|#line 1723 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1723")
end

yyval23 := new_un_strip_as (yytype74 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_384 is
			--|#line 1725 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1725")
end

yyval23 := new_address_as (yytype87 (yyvs.item (yyvsp)).first) 
			yyval := yyval23
		end

	yy_do_action_385 is
			--|#line 1727 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1727")
end

yyval23 := new_expr_address_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_386 is
			--|#line 1729 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1729")
end

yyval23 := new_address_current_as 
			yyval := yyval23
		end

	yy_do_action_387 is
			--|#line 1731 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1731")
end

yyval23 := new_address_result_as 
			yyval := yyval23
		end

	yy_do_action_388 is
			--|#line 1735 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1735")
end

create yyval30.initialize (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_389 is
			--|#line 1743 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1743")
end

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_390 is
			--|#line 1745 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1745")
end

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_391 is
			--|#line 1747 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1747")
end

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_392 is
			--|#line 1749 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1749")
end

yyval10 := new_current_as 
			yyval := yyval10
		end

	yy_do_action_393 is
			--|#line 1751 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1751")
end

yyval10 := new_result_as 
			yyval := yyval10
		end

	yy_do_action_394 is
			--|#line 1753 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1753")
end

yyval10 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_395 is
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

	yy_do_action_396 is
			--|#line 1757 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1757")
end

yyval10 := yytype45 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_397 is
			--|#line 1759 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1759")
end

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_398 is
			--|#line 1761 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1761")
end

yyval10 := yytype46 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_399 is
			--|#line 1763 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1763")
end

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_400 is
			--|#line 1765 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1765")
end

yyval10 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_401 is
			--|#line 1769 "eiffel.y"
		local
			yyval41: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1769")
end

yyval41 := new_nested_as (new_current_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_402 is
			--|#line 1773 "eiffel.y"
		local
			yyval41: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1773")
end

yyval41 := new_nested_as (new_result_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_403 is
			--|#line 1777 "eiffel.y"
		local
			yyval41: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1777")
end

yyval41 := new_nested_as (yytype1 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_404 is
			--|#line 1781 "eiffel.y"
		local
			yyval42: NESTED_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1781")
end

yyval42 := new_nested_expr_as (yytype23 (yyvs.item (yyvsp - 3)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_405 is
			--|#line 1785 "eiffel.y"
		local
			yyval41: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1785")
end

yyval41 := new_nested_as (yytype45 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_406 is
			--|#line 1789 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1789")
end

yyval45 := new_precursor_as (Void, yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_407 is
			--|#line 1791 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1791")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 2)), yytype66 (yyvs.item (yyvsp)), Void) 
			yyval := yyval45
		end

	yy_do_action_408 is
			--|#line 1793 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1793")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 5)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_409 is
			--|#line 1795 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1795")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_410 is
			--|#line 1797 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1797")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_411 is
			--|#line 1799 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1799")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_412 is
			--|#line 1801 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1801")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_413 is
			--|#line 1803 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1803")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_414 is
			--|#line 1805 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1805")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_415 is
			--|#line 1807 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1807")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_416 is
			--|#line 1809 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1809")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_417 is
			--|#line 1811 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1811")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_418 is
			--|#line 1813 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1813")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_419 is
			--|#line 1815 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1815")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_420 is
			--|#line 1817 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1817")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_421 is
			--|#line 1821 "eiffel.y"
		local
			yyval41: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1821")
end

yyval41 := new_nested_as (yytype46 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_422 is
			--|#line 1825 "eiffel.y"
		local
			yyval46: STATIC_ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1825")
end

				yyval46 := new_static_access_as (yytype58 (yyvs.item (yyvsp - 4)), yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp)));
			
			yyval := yyval46
		end

	yy_do_action_423 is
			--|#line 1832 "eiffel.y"
		local
			yyval46: STATIC_ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1832")
end

				yyval46 := new_static_access_as (yytype58 (yyvs.item (yyvsp - 3)), yytype30 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval46
		end

	yy_do_action_424 is
			--|#line 1840 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1840")
end

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_425 is
			--|#line 1842 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1842")
end

yyval10 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_426 is
			--|#line 1846 "eiffel.y"
		local
			yyval41: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1846")
end

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_427 is
			--|#line 1848 "eiffel.y"
		local
			yyval41: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1848")
end

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype41 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_428 is
			--|#line 1852 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1852")
end

				inspect id_level
				when Normal_level then
					yyval1 := new_access_id_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp)))
				when Assert_level then
					yyval1 := new_access_assert_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp)))
				when Invariant_level then
					yyval1 := new_access_inv_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval1
		end

	yy_do_action_429 is
			--|#line 1865 "eiffel.y"
		local
			yyval2: ACCESS_FEAT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1865")
end

yyval2 := new_access_feat_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval2
		end

	yy_do_action_430 is
			--|#line 1869 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1869")
end


			yyval := yyval66
		end

	yy_do_action_431 is
			--|#line 1871 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1871")
end


			yyval := yyval66
		end

	yy_do_action_432 is
			--|#line 1873 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1873")
end

yyval66 := yytype66 (yyvs.item (yyvsp - 1)) 
			yyval := yyval66
		end

	yy_do_action_433 is
			--|#line 1877 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1877")
end

				yyval66 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_434 is
			--|#line 1882 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1882")
end

				yyval66 := yytype66 (yyvs.item (yyvsp - 2))
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_435 is
			--|#line 1889 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1889")
end

yyval66 := new_eiffel_list_expr_as (0) 
			yyval := yyval66
		end

	yy_do_action_436 is
			--|#line 1891 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1891")
end

yyval66 := yytype66 (yyvs.item (yyvsp)) 
			yyval := yyval66
		end

	yy_do_action_437 is
			--|#line 1895 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1895")
end

				yyval66 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_438 is
			--|#line 1900 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1900")
end

				yyval66 := yytype66 (yyvs.item (yyvsp - 2))
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_439 is
			--|#line 1911 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1911")
end

create yyval30.initialize (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_440 is
			--|#line 1913 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1913")
end

yyval30 := new_boolean_id_as 
			yyval := yyval30
		end

	yy_do_action_441 is
			--|#line 1915 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1915")
end

yyval30 := new_character_id_as (False) 
			yyval := yyval30
		end

	yy_do_action_442 is
			--|#line 1917 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1917")
end

yyval30 := new_character_id_as (True) 
			yyval := yyval30
		end

	yy_do_action_443 is
			--|#line 1919 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1919")
end

yyval30 := new_double_id_as 
			yyval := yyval30
		end

	yy_do_action_444 is
			--|#line 1921 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1921")
end

yyval30 := new_integer_id_as (8) 
			yyval := yyval30
		end

	yy_do_action_445 is
			--|#line 1923 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1923")
end

yyval30 := new_integer_id_as (16) 
			yyval := yyval30
		end

	yy_do_action_446 is
			--|#line 1925 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1925")
end

yyval30 := new_integer_id_as (32) 
			yyval := yyval30
		end

	yy_do_action_447 is
			--|#line 1927 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1927")
end

yyval30 := new_integer_id_as (64) 
			yyval := yyval30
		end

	yy_do_action_448 is
			--|#line 1929 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1929")
end

yyval30 := new_none_id_as 
			yyval := yyval30
		end

	yy_do_action_449 is
			--|#line 1931 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1931")
end

yyval30 := new_pointer_id_as 
			yyval := yyval30
		end

	yy_do_action_450 is
			--|#line 1933 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1933")
end

yyval30 := new_real_id_as 
			yyval := yyval30
		end

	yy_do_action_451 is
			--|#line 1937 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1937")
end

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_452 is
			--|#line 1939 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1939")
end

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_453 is
			--|#line 1941 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1941")
end

yyval6 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_454 is
			--|#line 1943 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1943")
end

yyval6 := yytype47 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_455 is
			--|#line 1945 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1945")
end

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_456 is
			--|#line 1947 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1947")
end

yyval6 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_457 is
			--|#line 1951 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1951")
end

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_458 is
			--|#line 1953 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1953")
end

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_459 is
			--|#line 1955 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1955")
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

	yy_do_action_460 is
			--|#line 1970 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1970")
end

yyval6 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval6
		end

	yy_do_action_461 is
			--|#line 1972 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1972")
end

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_462 is
			--|#line 1974 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1974")
end

yyval6 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_463 is
			--|#line 1978 "eiffel.y"
		local
			yyval9: BOOL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1978")
end

yyval9 := new_boolean_as (False) 
			yyval := yyval9
		end

	yy_do_action_464 is
			--|#line 1980 "eiffel.y"
		local
			yyval9: BOOL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1980")
end

yyval9 := new_boolean_as (True) 
			yyval := yyval9
		end

	yy_do_action_465 is
			--|#line 1984 "eiffel.y"
		local
			yyval12: CHAR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1984")
end

				check is_character: not token_buffer.is_empty end
				yyval12 := new_character_as (token_buffer.item (1))
			
			yyval := yyval12
		end

	yy_do_action_466 is
			--|#line 1991 "eiffel.y"
		local
			yyval36: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1991")
end

				if token_buffer.is_integer then
					yyval36 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval36 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval36 := new_integer_as (False, "0")
				end
			
			yyval := yyval36
		end

	yy_do_action_467 is
			--|#line 2006 "eiffel.y"
		local
			yyval36: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2006")
end

				if token_buffer.is_integer then
					yyval36 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval36 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval36 := new_integer_as (False, "0")
				end
			
			yyval := yyval36
		end

	yy_do_action_468 is
			--|#line 2021 "eiffel.y"
		local
			yyval36: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2021")
end

				if token_buffer.is_integer then
					yyval36 := new_integer_as (True, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval36 := new_integer_as_from_hexa (token_buffer)	
				else
					token_buffer.precede ('-')
					report_integer_too_small_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval36 := new_integer_as (False, "0")
				end
			
			yyval := yyval36
		end

	yy_do_action_469 is
			--|#line 2039 "eiffel.y"
		local
			yyval47: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2039")
end

yyval47 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval47
		end

	yy_do_action_470 is
			--|#line 2041 "eiffel.y"
		local
			yyval47: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2041")
end

yyval47 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval47
		end

	yy_do_action_471 is
			--|#line 2043 "eiffel.y"
		local
			yyval47: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2043")
end

				token_buffer.precede ('-')
				yyval47 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval47
		end

	yy_do_action_472 is
			--|#line 2050 "eiffel.y"
		local
			yyval7: BIT_CONST_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2050")
end

yyval7 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval7
		end

	yy_do_action_473 is
			--|#line 2054 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2054")
end

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_474 is
			--|#line 2056 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2056")
end

yyval55 := new_empty_string_as 
			yyval := yyval55
		end

	yy_do_action_475 is
			--|#line 2058 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2058")
end

yyval55 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval55
		end

	yy_do_action_476 is
			--|#line 2062 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2062")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_477 is
			--|#line 2064 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2064")
end

yyval55 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval55
		end

	yy_do_action_478 is
			--|#line 2066 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2066")
end

yyval55 := new_lt_string_as 
			yyval := yyval55
		end

	yy_do_action_479 is
			--|#line 2068 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2068")
end

yyval55 := new_le_string_as 
			yyval := yyval55
		end

	yy_do_action_480 is
			--|#line 2070 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2070")
end

yyval55 := new_gt_string_as 
			yyval := yyval55
		end

	yy_do_action_481 is
			--|#line 2072 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2072")
end

yyval55 := new_ge_string_as 
			yyval := yyval55
		end

	yy_do_action_482 is
			--|#line 2074 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2074")
end

yyval55 := new_minus_string_as 
			yyval := yyval55
		end

	yy_do_action_483 is
			--|#line 2076 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2076")
end

yyval55 := new_plus_string_as 
			yyval := yyval55
		end

	yy_do_action_484 is
			--|#line 2078 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2078")
end

yyval55 := new_star_string_as 
			yyval := yyval55
		end

	yy_do_action_485 is
			--|#line 2080 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2080")
end

yyval55 := new_slash_string_as 
			yyval := yyval55
		end

	yy_do_action_486 is
			--|#line 2082 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2082")
end

yyval55 := new_mod_string_as 
			yyval := yyval55
		end

	yy_do_action_487 is
			--|#line 2084 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2084")
end

yyval55 := new_div_string_as 
			yyval := yyval55
		end

	yy_do_action_488 is
			--|#line 2086 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2086")
end

yyval55 := new_power_string_as 
			yyval := yyval55
		end

	yy_do_action_489 is
			--|#line 2088 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2088")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_490 is
			--|#line 2090 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2090")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_491 is
			--|#line 2092 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2092")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_492 is
			--|#line 2094 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2094")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_493 is
			--|#line 2096 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2096")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_494 is
			--|#line 2098 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2098")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_495 is
			--|#line 2100 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2100")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_496 is
			--|#line 2102 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2102")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_497 is
			--|#line 2106 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2106")
end

yyval88 := new_clickable_string (new_minus_string_as) 
			yyval := yyval88
		end

	yy_do_action_498 is
			--|#line 2108 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2108")
end

yyval88 := new_clickable_string (new_plus_string_as) 
			yyval := yyval88
		end

	yy_do_action_499 is
			--|#line 2110 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2110")
end

yyval88 := new_clickable_string (new_not_string_as) 
			yyval := yyval88
		end

	yy_do_action_500 is
			--|#line 2112 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2112")
end

yyval88 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval88
		end

	yy_do_action_501 is
			--|#line 2116 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2116")
end

yyval88 := new_clickable_string (new_lt_string_as) 
			yyval := yyval88
		end

	yy_do_action_502 is
			--|#line 2118 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2118")
end

yyval88 := new_clickable_string (new_le_string_as) 
			yyval := yyval88
		end

	yy_do_action_503 is
			--|#line 2120 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2120")
end

yyval88 := new_clickable_string (new_gt_string_as) 
			yyval := yyval88
		end

	yy_do_action_504 is
			--|#line 2122 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2122")
end

yyval88 := new_clickable_string (new_ge_string_as) 
			yyval := yyval88
		end

	yy_do_action_505 is
			--|#line 2124 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2124")
end

yyval88 := new_clickable_string (new_minus_string_as) 
			yyval := yyval88
		end

	yy_do_action_506 is
			--|#line 2126 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2126")
end

yyval88 := new_clickable_string (new_plus_string_as) 
			yyval := yyval88
		end

	yy_do_action_507 is
			--|#line 2128 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2128")
end

yyval88 := new_clickable_string (new_star_string_as) 
			yyval := yyval88
		end

	yy_do_action_508 is
			--|#line 2130 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2130")
end

yyval88 := new_clickable_string (new_slash_string_as) 
			yyval := yyval88
		end

	yy_do_action_509 is
			--|#line 2132 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2132")
end

yyval88 := new_clickable_string (new_mod_string_as) 
			yyval := yyval88
		end

	yy_do_action_510 is
			--|#line 2134 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2134")
end

yyval88 := new_clickable_string (new_div_string_as) 
			yyval := yyval88
		end

	yy_do_action_511 is
			--|#line 2136 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2136")
end

yyval88 := new_clickable_string (new_power_string_as) 
			yyval := yyval88
		end

	yy_do_action_512 is
			--|#line 2138 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2138")
end

yyval88 := new_clickable_string (new_and_string_as) 
			yyval := yyval88
		end

	yy_do_action_513 is
			--|#line 2140 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2140")
end

yyval88 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval88
		end

	yy_do_action_514 is
			--|#line 2142 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2142")
end

yyval88 := new_clickable_string (new_implies_string_as) 
			yyval := yyval88
		end

	yy_do_action_515 is
			--|#line 2144 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2144")
end

yyval88 := new_clickable_string (new_or_string_as) 
			yyval := yyval88
		end

	yy_do_action_516 is
			--|#line 2146 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2146")
end

yyval88 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval88
		end

	yy_do_action_517 is
			--|#line 2148 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2148")
end

yyval88 := new_clickable_string (new_xor_string_as) 
			yyval := yyval88
		end

	yy_do_action_518 is
			--|#line 2150 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2150")
end

yyval88 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval88
		end

	yy_do_action_519 is
			--|#line 2154 "eiffel.y"
		local
			yyval4: ARRAY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2154")
end

yyval4 := new_array_as (yytype66 (yyvs.item (yyvsp - 1))) 
			yyval := yyval4
		end

	yy_do_action_520 is
			--|#line 2158 "eiffel.y"
		local
			yyval57: TUPLE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2158")
end

yyval57 := new_tuple_as (yytype66 (yyvs.item (yyvsp - 1))) 
			yyval := yyval57
		end

	yy_do_action_521 is
			--|#line 2162 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2162")
end
			yyval := yyval_default;


		end

	yy_do_action_522 is
			--|#line 2166 "eiffel.y"
		local
			yyval91: TOKEN_LOCATION
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2166")
end

yyval91 := clone (current_position) 
			yyval := yyval91
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
			  135,  136>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  305,  305,  306,  308,  283,  283,  283,  283,  283,
			  283,  283,  283,  283,  283,  283,  283,  284,  285,  286,
			  292,  287,  289,  290,  288,  291,  293,  294,  295,  254,
			  254,  254,  256,  256,  256,  257,  257,  257,  255,  255,
			  176,  173,  173,  222,  222,  222,  143,  143,  143,  143,
			  307,  307,  307,  307,  310,  310,  311,  311,  207,  207,
			  237,  237,  238,  238,  169,  169,  155,  312,  154,  154,
			  250,  250,  251,  251,  236,  236,  309,  309,  168,  302,
			  302,  299,  314,  314,  298,  298,  298,  296,  297,  147,
			  156,  156,  157,  157,  157,  266,  266,  266,  267,  267,

			  194,  194,  195,  195,  195,  195,  195,  195,  195,  268,
			  268,  269,  269,  200,  230,  230,  229,  229,  231,  231,
			  164,  170,  170,  239,  239,  241,  241,  240,  240,  243,
			  243,  242,  242,  245,  245,  244,  244,  277,  277,  278,
			  278,  279,  279,  219,  315,  315,  281,  281,  282,  282,
			  220,  252,  252,  253,  253,  215,  215,  205,  316,  204,
			  204,  204,  166,  167,  209,  209,  182,  182,  280,  280,
			  259,  259,  260,  260,  179,  313,  313,  180,  180,  180,
			  180,  180,  180,  180,  180,  180,  180,  201,  201,  318,
			  201,  319,  163,  163,  320,  163,  321,  272,  272,  273,

			  273,  211,  212,  212,  212,  214,  214,  218,  218,  218,
			  218,  218,  218,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,  275,  275,  275,  276,  276,
			  247,  247,  248,  248,  249,  249,  171,  322,  303,  303,
			  246,  246,  175,  227,  227,  228,  228,  162,  261,  261,
			  177,  223,  223,  224,  224,  151,  263,  263,  183,  183,
			  183,  183,  183,  183,  183,  183,  183,  183,  183,  183,
			  183,  183,  183,  183,  183,  183,  262,  262,  185,  274,
			  274,  184,  184,  323,  221,  221,  221,  161,  270,  270,
			  270,  271,  271,  202,  258,  258,  142,  142,  203,  203,

			  225,  225,  226,  226,  158,  158,  158,  158,  158,  158,
			  206,  206,  206,  206,  206,  206,  206,  206,  206,  206,
			  206,  206,  206,  206,  264,  264,  265,  265,  193,  193,
			  193,  159,  159,  159,  160,  160,  217,  217,  137,  137,
			  140,  140,  178,  178,  178,  178,  178,  178,  178,  178,
			  178,  153,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  174,  150,
			  150,  150,  150,  150,  150,  150,  150,  150,  150,  150,

			  150,  190,  189,  188,  192,  187,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  196,  191,  197,  198,  149,  149,  186,  186,  138,  139,
			  232,  232,  232,  233,  233,  234,  234,  235,  235,  172,
			  172,  172,  172,  172,  172,  172,  172,  172,  172,  172,
			  172,  144,  144,  144,  144,  144,  144,  145,  145,  145,
			  145,  145,  145,  148,  148,  152,  181,  181,  181,  199,
			  199,  199,  146,  208,  208,  208,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  301,  301,  301,

			  301,  300,  300,  300,  300,  300,  300,  300,  300,  300,
			  300,  300,  300,  300,  300,  300,  300,  300,  300,  141,
			  213,  317,  304>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,    1,    2,   16,    1,    1,    1,    1,    1,    1,
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
			    3,    1,    1,    1,    3,    0,    1,    1,    2,    0,
			    1,    1,    2,    0,    1,    1,    2,    0,    3,    0,
			    1,    1,    2,    5,    0,    3,    0,    1,    1,    2,
			    4,    1,    3,    0,    1,    0,    2,    8,    0,    1,
			    1,    1,    3,    2,    0,    2,    2,    2,    0,    2,
			    1,    2,    1,    2,    3,    0,    2,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    0,    3,    0,
			    4,    0,    0,    3,    0,    4,    0,    0,    1,    1,

			    2,    3,    2,    4,    3,    1,    1,    3,    3,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    0,    2,    3,    1,    3,
			    0,    4,    0,    1,    1,    3,    3,    0,    0,    3,
			    0,    3,    8,    0,    1,    1,    2,    5,    0,    2,
			    6,    0,    1,    1,    2,    5,    1,    3,    1,    3,
			    1,    3,    1,    3,    3,    3,    3,    3,    1,    3,
			    3,    3,    3,    3,    3,    3,    0,    2,   10,    0,
			    2,    0,    3,    0,    0,    4,    2,    5,    0,    2,
			    3,    1,    3,    1,    0,    2,    4,    4,    4,    4,

			    0,    1,    1,    2,    1,    3,    2,    2,    4,    3,
			    5,    5,    5,    7,    7,    5,    3,    5,    5,    5,
			    7,    6,    5,    4,    0,    3,    1,    3,    1,    1,
			    3,    6,    4,    7,    6,    5,    0,    1,    1,    1,
			    0,    3,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    4,    1,    1,    1,    1,    1,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    4,    3,    4,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    2,    2,
			    2,    2,    2,    4,    2,    4,    2,    2,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    3,    3,    3,    5,    3,    2,    5,    8,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    3,    7,    6,    1,    1,    3,    3,    2,    2,
			    0,    2,    3,    1,    3,    0,    1,    1,    3,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    2,    2,    1,
			    2,    2,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    3,
			    3,    0,    0>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   29,  450,  449,  448,  442,  447,  445,  444,  446,  443,
			  441,  440,   42,  439,    0,   54,    1,    0,    0,   38,
			   42,   28,   27,   26,   20,   25,   23,   22,   24,   21,
			   19,   18,    0,    0,    0,    0,   17,    2,  205,  206,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,   55,   56,    0,   56,   41,  496,  495,  494,
			  493,  492,  491,  490,  489,  488,  487,  486,  485,  484,
			  483,  482,  481,  480,  479,  478,  475,  477,  474,  464,
			  463,    0,   45,    0,  472,  476,  469,  465,  466,    0,
			    0,   43,   47,  455,  451,  452,    0,   46,  453,  454,

			  456,  473,   76,   39,  225,    5,    6,    8,    9,   12,
			   10,   11,   13,    7,   14,   15,   16,  212,  211,  225,
			    0,    0,  210,  209,    0,  213,  214,  215,  217,  220,
			  218,  219,  221,  216,  222,  223,  224,   57,   51,    0,
			   56,   56,   50,    0,    0,  471,  468,  470,  467,   48,
			  435,    0,    0,   77,   40,  208,  207,  226,  228,    0,
			  522,   53,   52,    0,  522,    0,  393,    0,  430,    0,
			  392,    0,    0,  435,  522,  460,  459,    0,    0,    0,
			    0,  388,    0,    0,  394,  353,  352,  461,  457,  355,
			  458,  400,  437,  430,    0,  397,  391,  390,  389,  399,

			  395,  396,  398,  356,  462,  354,    0,  436,   49,   44,
			  227,    0,  164,    0,  522,  340,  522,  522,    0,    0,
			    0,    0,    0,    0,  324,    0,    0,  406,    0,  522,
			    0,  387,    0,    0,  386,    0,   84,   85,   86,  384,
			    0,    0,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,    0,    0,    0,  381,  153,  380,
			  378,  379,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  522,  428,  382,    0,    0,  520,    0,  229,    0,
			   58,  232,  340,    0,  335,    0,    0,  425,  402,  430,

			  424,    0,    0,    0,    0,    0,    0,    0,  316,    0,
			  431,  433,    0,    0,    0,  401,  500,  499,  498,  497,
			   88,  518,  517,  516,  515,  514,  513,  512,  511,  510,
			  509,  508,  507,  506,  505,  504,  503,  502,  501,   87,
			    0,    0,  522,  522,  522,  522,  522,  522,  522,  522,
			  522,  522,  522,  522,  522,  519,  324,  357,  151,  154,
			    0,  403,  364,  363,  362,  361,  360,  359,  358,  371,
			  373,  372,  374,  375,  376,    0,  365,  370,    0,  367,
			  369,  377,    0,  405,  421,  438,  165,    0,   95,  237,
			  234,    0,  233,  334,  430,  324,  324,    0,  429,  324,

			  324,  324,    0,    0,  328,    0,  329,  326,    0,  324,
			  430,  432,    0,    0,  324,  385,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  323,  522,    0,    0,  383,  366,  368,  324,   59,  522,
			  522,  238,  231,    0,  341,  322,  317,  426,  427,  315,
			  310,  311,    0,    0,    0,  325,    0,  312,  407,  434,
			    0,  318,  522,  324,  430,  430,  430,  430,  430,  430,
			  430,  430,  430,  430,  430,  430,    0,  404,  152,  319,
			   98,  522,    0,   97,  522,    0,  236,  235,  324,  324,
			  330,  327,  430,    0,  321,  409,  410,  411,  413,  416,

			  414,  415,  417,  412,  418,  419,  420,  324,   99,  100,
			  225,  304,  302,   60,  522,    0,  240,  314,  313,  422,
			  430,  320,  101,  102,    0,    0,  306,   67,   82,   62,
			  522,   61,  303,  307,    0,  239,  408,  127,  135,  109,
			  131,   76,  108,  125,  129,  133,    0,  114,   70,    0,
			   72,  305,  123,   68,   83,   74,   82,   79,  137,    0,
			  281,   63,    0,  309,    0,  128,  136,  111,  110,    0,
			  132,  118,  116,    0,  117,  126,  129,  130,  133,  134,
			    0,  107,  115,  125,   71,    0,    0,   66,   69,   75,
			   82,  139,  175,  155,   81,  283,  522,  308,  241,    0,

			    0,  119,  121,   76,  122,  133,    0,  106,  129,   73,
			  124,   80,  141,    0,    0,  140,   78,    0,   35,  521,
			   29,  112,  113,  120,    0,  105,  133,  144,  138,  142,
			  176,  156,   32,   42,   89,   90,  199,  282,  521,  522,
			    0,  104,    0,    0,    0,   35,   42,   35,   91,   58,
			   37,   42,  200,   76,    0,    4,    3,  103,    0,   76,
			   93,   42,   92,   94,  158,   36,  201,  202,  430,  145,
			  143,  187,  204,  189,  168,  203,  191,  521,  146,    0,
			  521,  188,  148,    0,  169,  147,  175,  522,  175,  161,
			  160,  159,  192,  190,    0,  149,  167,  521,  164,    0,

			  166,  194,  294,   76,  172,  521,  522,  162,  163,  196,
			  521,  175,    0,  150,  173,  293,  522,  175,  179,  185,
			  177,  184,  181,  182,  178,  175,  183,  186,  180,    0,
			  521,  193,  295,  157,    0,  279,  174,    0,    0,  288,
			    0,  521,    0,    0,  336,    0,  342,  430,  348,  344,
			  343,  345,  350,  346,  347,  349,  195,  251,  521,  284,
			    0,    0,    0,    0,  175,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  339,    0,
			  340,  338,  337,    0,    0,    0,    0,  522,  253,  276,
			  252,  280,    0,    0,  297,  299,  175,  289,  291,    0,

			    0,  351,    0,  332,    0,    0,  296,  298,    0,  175,
			    0,  254,  286,  430,  522,  522,  290,    0,  287,    0,
			  340,    0,  260,  262,  258,  256,  268,    0,  277,  250,
			    0,    0,  245,  248,  522,    0,  292,  340,  331,    0,
			    0,    0,    0,    0,  175,    0,  285,    0,  175,    0,
			  246,    0,  333,    0,  261,  267,  275,  266,  263,  264,
			  270,  265,  259,  273,  274,  269,  272,  271,  255,  257,
			  175,  249,  242,    0,    0,    0,  175,    0,  278,  247,
			  423,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  780,  184,  297,  294,  185,  718,   91,   92,  186,  187,
			  592,  188,  298,  189,  788,  190,  719,  525,  528,  634,
			  648,  512,  720,  191,  721,  832,  702,  571,  192,  690,
			  698,  555,  529,  603,  390,  193,   18,  194,  722,   19,
			  723,  724,  704,  725,   98,  691,  825,  596,  726,  300,
			  195,  196,  197,  198,  199,  200,  407,  480,  509,  201,
			  202,  826,   99,  567,  674,  727,  728,  692,  663,  203,
			  388,  204,  290,  101,  636,  653,  205,   37,  618,   38,
			  783,   39,  612,  682,  793,  102,  789,  790,  513,  514,
			  833,  834,  543,  583,  572,  282,  312,  206,  207,  556,

			  530,  531,  551,  575,  576,  577,  578,  579,  580,  535,
			  212,  391,  392,  573,  549,  613,  360,   15,   20,  649,
			  635,  712,  696,  705,  849,  810,  827,  308,  408,  440,
			  481,  547,  568,  764,  799,  637,  638,  759,  125,  159,
			  593,  614,  615,  679,  684,  685,  236,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,  237,
			  238,  552,  557,  339,  320,  558,  486,  482,  881,   16,
			   54,  656,  154,   55,  138,  553,  697,  559,  644,  671,
			  639,  677,  680,  710,  730,  441,  619>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 2823, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 2595, -32768, 2713,  126, -32768,  614, 1231, -32768,
			 2537, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 2854, 2807, 2854,  490, -32768, -32768, -32768, -32768,
			  498,  498,  498,  498,  498,  498,  498,  498,  498,  498,
			  498,  498, -32768,  575,  594,  -27, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  604, -32768, 2713, -32768, -32768, -32768, -32768, -32768,  268,
			  183, -32768, -32768, -32768, -32768, -32768,   48, -32768, -32768, -32768,

			 -32768, -32768,  233, -32768,  498, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  498,
			  620,  616, -32768, -32768, 2678, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2854,
			  575,  575, -32768, 2713,  607, -32768, -32768, -32768, -32768, -32768,
			 2056,  573, 1449, -32768, -32768, -32768, -32768, -32768, -32768,  110,
			   19, -32768, -32768,  592, -32768,  537,  156, 1021,   93,  590,
			  137, 2297, 2630, 2056, -32768, -32768, -32768, 2056, 2056,  608,
			 2056, -32768, 2056, 2056,  415, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 3105,   24, 2056, -32768, -32768, -32768, -32768, -32768,

			 -32768,  410,  308, -32768, -32768, -32768,  581,  586, -32768, -32768,
			 -32768, 2713,  447,  577, -32768,  170, -32768, -32768, 2834,  599,
			  595,  591, 2713, 2056,  328, 2854, 1933, -32768, 2854, -32768,
			 2834, -32768,  155, 2972, -32768, 2056, -32768, -32768, -32768, -32768,
			 2854,  515,  411,  407,  400,  395,  382,  379,  347,  344,
			  326,  314,  302,  292,  569, 2834, 3062, -32768, 2834, -32768,
			 -32768, -32768, 2834, 2056, 2056, 2056, 2056, 2056, 2056, 2056,
			 2056, 2056, 2056, 2056, 2056, 2056, 1810, 2056, 1687, 2056,
			 2056, -32768, -32768, -32768, 2834, 2834, -32768, 2056, -32768, 1391,
			  403,  532,  170, 2834, -32768, 2834, 2834,  527, -32768,  516,

			 -32768, 2834, 2834, 2834,  565, 3044, 2179, 2834, -32768,  564,
			 -32768, 3105,  226,  560, 2834, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 3001,  559, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  522,  103, -32768,  553,
			  545, -32768,  316,  316,  316,  316,  316,  519,  519,  494,
			  494,  494,  494,  494,  494, 2056, 1660, 2350, 2056, 1631,
			 3024, -32768, 2834, -32768, -32768, 3105, -32768, 1187,  513, -32768,
			 -32768,  539,  546, -32768,  516,  522,  522, 2834, -32768,  522,

			  522,  522,  558,  554,  537, 2630, 3105, -32768,  211,  522,
			  516, -32768, 2056,  541,  522, -32768,  526, 2834,  500,  499,
			  497,  495,  493,  492,  491,  489,  487,  485,  484,  483,
			 -32768, -32768, 2834, 2834, -32768, 1660, 1631,  522, -32768,  131,
			 -32768,  517, -32768,  532, -32768, -32768, -32768,  527, -32768, -32768,
			 -32768, -32768, 2834, 2834,  -21, -32768, 2179, -32768, -32768, 3105,
			 2834, -32768, -32768,  522,  516,  516,  516,  516,  516,  516,
			  516,  516,  516,  516,  516,  516, 2834, -32768, -32768, -32768,
			 -32768,  241, 2854, -32768,  306, 2854, -32768, -32768,  522,  522,
			 -32768, -32768,  516,  465, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  522, -32768,  510,
			  498, 1126, -32768,  471,  264,  503,  502, -32768, -32768, -32768,
			  516, -32768, -32768,   35, 2796, 2690, 2741, -32768,  334, -32768,
			 -32768,  471, -32768, 1126, 2690, -32768, -32768, 2690, 2690, 2690,
			 2690,   88, -32768,  428,  429,  399,  468,  462, -32768,  160,
			 -32768,  478, -32768,  480, -32768, -32768,  331, -32768,   52, 2690,
			  454, -32768, 2690, 2741,    8,  478,  478, -32768,  488,  472,
			  478, -32768,  480, 2424, -32768, -32768,  429, -32768,  399, -32768,
			  457, -32768, -32768,  428, -32768, 2854, 2690, -32768, -32768, -32768,
			  449, 2834, -32768,  481, -32768, -32768, -32768,  478, -32768, 2690,

			 2690, -32768, -32768,  433,  478,  399,  441, -32768,  429, -32768,
			 -32768, -32768, -32768,  286,  452, 2834,  425, 2713,  149,   53,
			  424, -32768, -32768, -32768,  430, -32768,  399,  442, -32768, -32768,
			 -32768, -32768, 2302, 2772, -32768, -32768, -32768, -32768, 1345, -32768,
			  426, -32768,  423, 2834, 2713,  413, 2513,  413, -32768,  403,
			 -32768, 2574, -32768,  433, 2056, -32768, -32768, -32768,  436,  433,
			 -32768, 2479, -32768, -32768, -32768, -32768, -32768, 3105,  153, -32768,
			 -32768,  394, 2056,  418,  396, 3105, -32768,  283, 2834,  109,
			  283, -32768, -32768,  195, -32768, 2834, -32768, -32768, -32768, -32768,
			 -32768, -32768,  414, -32768, 2713, -32768, -32768,  401,  447, 1391,

			 -32768,  376,  380,  433, -32768,  257,  -28, -32768, -32768, -32768,
			  -36, -32768,  404, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2413,
			  -36, -32768, -32768, -32768, 2056,  390,  425,   13, 2056,  435,
			  431,  384, 2445, 2233, 2713, 2056,  415,   21, -32768, -32768,
			 -32768, -32768, -32768, -32768,  410,  308, -32768, 1384,  -43,  281,
			 2056, 2056, 1679, 1064, -32768,  298,  377,  375,  368,  366,
			  353,  338,  336,  332,  330,  323,  318,  304, -32768, 2713,
			  170, -32768, -32768,  293, 2983, 2056, 2056, -32768, -32768,  249,
			  230, -32768, 2056,  210, 3105, 3105, -32768, -32768, -32768,   45,

			  239, -32768,  213, -32768,  978,  273, 3105, 3105,  880, -32768,
			  227, -32768, 3105,  138, -32768,  189, -32768, 1391, -32768,  978,
			  170,  174,  269,  261,  245, -32768,  221,  -17, -32768, -32768,
			 2056, 2056, -32768,  150,   23,  179, -32768,  170, -32768, 2854,
			  826,  880, 1519,  880, -32768,  880, 3105, 2965, -32768,  121,
			 -32768, 2056, -32768,  133, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, 1586,  141,   91, -32768, 2834, -32768, -32768,
			 -32768,  120,   28, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -674,  -19,  312, -286, -32768, -32768,  556,   75, -32768,   -5,
			 -32768,   -9, -226, -32768,  -87,  -15, -32768, -489, -32768, -32768,
			 -32768,  190, -32768,    1, -32768, -133, -32768,  128,  875, -32768,
			 -32768,  143,  167, -32768,  254,    0, -32768,  659, -32768,   -4,
			 -32768, -32768,  -10, -32768,  -30, -32768, -152, -32768, -32768,  289,
			  -33,  -35,  -37,  -39,  -40,  -45,  225,  199, -32768,  -50,
			  -52, -422, -32768,   77, -32768, -32768, -32768, -32768, -32768, -32768,
			   25,   -1,  -25, -288,   34, -32768,  572,  -73, -32768, -220,
			 -32768, -32768,   55,  -18, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  119, -32768, -32768,   89, -32768,  496, -32768, -32768,

			 -32768, -32768, -429,  142,   81,  140, -545,  136, -551, -32768,
			 -32768, -32768, -32768, -481, -32768, -244, -32768,   40, -449, -32768,
			 -337, -32768, -607, -32768, -32768, -32768, -32768, -120, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -643, -32768, -32768,  959, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,    7,  235,  217,  203,
			  144,  102,   39,   31,   18,   11,   -3,   -7,  -12, -32768,
			 -32768, -149,   68, -32768, -32768, -32768, -32768,  947, -32768, -32768,
			 -32768, -32768, -415, -32768,  -34, -32768, -577, -32768, -32768, -32768,
			 -614, -32768, -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		local
			an_array: ARRAY [INTEGER]
		once
			!! an_array.make (0, 3126)
			yytable_template_1 (an_array)
			yytable_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytable_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			   14,  386,   51,   95,  315,  123,  393,   50,  313,   94,
			  144,   49,   17,   93,  359,  616,  103,  100,   97,   96,
			   17,  142,  239,  845,  483,   48,  490,  606,  883, -197,
			  526,  605,   47,  118,  681,  122,  361,  693,  218,  104,
			  141,  119,  137,  717,  562,   46, -230,  226,  586,  716,
			  226,  158,  563,   45,  624, -197, -197, -197,  383,  384,
			 -230, -230,  281,  626,  587,  715,  761,  731,  140,  760,
			  163,   51,  588,  598,  786,  642,   50,  785,  591,  844,
			   49,  700,  342,  706, -230,  817, -244,  756, -244, -230,
			  816,  706,  590, -230,   48, -230,  150, -230,  765,  241,

			  542,   47, -230,  541,  732,  564,  161,  162,  565,  566,
			  735,  570,   51,  149,   46,  791,   44,   50, -197,  226,
			  882,   49,   45,  540,  539,  153,  574, -197,  432,  538,
			  820,   51,  537,  597,  524,   48,   50,   95,  288,  225,
			   49,  431,   47,   94,  604,  837,  160,   93,  736,  304,
			  211,  100,   97,   96,   48,   46,  878,  800,   43,  210,
			  253,   47,  230,   45,  226,  252,  877,  224,  153,  251,
			  689,  688,  -76,  -76,   46,  229,  281,  830,  687,  226,
			  874,  218,   45,  250,  651,   44,  872,   53,  623,  815,
			  249,  281,  672,  686,  217,  293,  -76,  661,   52,   51,

			  585,  -76,  828,  248,   50,  -76,  477,  584,   49,  -76,
			   51,  247,  148,  848,  147,   50,   51,   42,  299,   49,
			  839,   50,   48,  633,  843,   49,   44,   43,  632,   47,
			  299,   41,  309,   48,  694,  433,  430,  868,  666,   48,
			   47,  871,   46,  851,  670,   44,   47,  341,  842,   40,
			   45,  456, -243,   46, -243,  356,  455,  227,  358,   46,
			  819,   45,  299,  875,  841,  516,  412,   45,   43,  879,
			  153,  411,  840,  152,  246,  445,  446,  319,  318,  449,
			  450,  451,  -96,  -96,  299,  299,   42,   43,  713,  457,
			  317,  316,  829,  394,  461,  395,  396,  146,  432,  145,

			   41,  399,  400,  401,  818,  511,  -96,  409,  660,  814,
			  662,  -96,  809,   44,  414,  -96,  245,  479,   40,  -96,
			 -171, -171, -171, -171,   44,  627,  433,   42,  804, -301,
			   44,  787,  454,  285, -301, -171,  263,  181, -301,  354,
			  124,   41, -301,  494, -197, -197,   42,  511, -171,  353,
			  124,  354, -197,  307,  306,   43, -171, -171, -171,   40,
			   41,  352,  124,  801, -197,  353,   43, -197,  517,  518,
			  352, -300,   43,  351,  124,  244, -300,  351,   40,  350,
			 -300,  792,  437,  349, -300,  348,  438,  521,  398,  243,
			  569,  350,  124,  253,  349,  124,  -65,  299,  252,  -64,

			  347,  -65,  251,  554,  -64,  -65,  554,  242,  -64,  -65,
			  594,  708,  -64,  346,   42,  345,  250,  463,  856,  860,
			  863,  867,  344,  249,  343,   42,  348,  124,   41,  347,
			  124,   42,  299,  478,  683,  284,  248,  610,  630,   41,
			  262,  683,  346,  124,  247,   41,   40,  345,  124, -197,
			  569,  622,  488,  489,  344,  124,  230,   40,  343,  124,
			  492,  763,  630,   40, -170, -170, -170, -170,  758,  733,
			  153,  711,  709,   51,  289,  798,  507,  678,   50, -170,
			  701,  676,   49,  444,  673,  669,  387,  633,  657,  510,
			  643,  655, -170,  538,  803,  641,   48,  628,   12,  458,

			 -170, -170, -170,   47,  121,  120,  625,  246,  269,  268,
			  267,  266,  265,  264,  263,  181,   46,  540,  586,   88,
			  617,  554,  607,   13,   45,  537,  524,  600,  599,  836,
			  541,  550,  595,  581,  838,  267,  266,  265,  264,  263,
			  181,  527,  226,  534,  631,  533,  124,  522,  306,  245,
			  520,  852,  397,  495,  496,  497,  498,  499,  500,  501,
			  502,  503,  504,  505,  506,  389,  460,  485,  475,  474,
			  473,  659,  472,  462,  471,  216,  470,  469,  468,  453,
			  467,  519,  466,  452,  465,  464,  443,   44,  442,  439,
			  434,  358,  609,  433,   11,   10,    9,    8,    7,    6,

			    5,    4,    3,    2,    1,   51,  416,  413,  244,  536,
			   50,  410,  402,  355,   49,  358,  303,   95,  342,  853,
			  302,  703,  243,   94,  301,  291,  287,   93,   48,   43,
			  286,  100,   51,   17,  258,   47,  228,   50,  208,  214,
			  242,   49,  164,  658,  137,  148,   17,  103,   46,  146,
			  143,   17,  139,   56,  668,   48,   45,  103,  611,  546,
			  640,   17,   47,  545,  608,  544,  582,  695,  151,  254,
			  629,  782,  652,  707,  664,   46,  621,  755,  358,  754,
			  508,  491,   51,   45,  753,  358,  448,   50,   42,  752,
			  751,   49,  750,  869,  749,  714,  748,  487,  561,  589,

			  601,  850,   41,  811,  532,   48,  802,  647,  209,  447,
			  746,    0,   47,    0,    0,    0,    0,    0,    0,   44,
			   40,    0,    0,    0,    0,   46,    0,    0,    0,  747,
			  777,    0,   51,   45,    0,  776,    0,   50,    0,  775,
			    0,   49,    0,  781,    0,    0,   44,    0,    0,    0,
			    0,    0,    0,  774,    0,   48,    0,    0,    0,    0,
			  773,   43,   47,    0,    0,    0,    0,   51,    0,    0,
			    0,    0,   50,  772,    0,   46,   49,    0,  824,    0,
			    0,  771,    0,   45,    0,    0,    0,    0,   43,    0,
			   48,    0,  813,  822,    0,    0,   44,   47,    0,    0,

			    0,    0,    0,    0,  781,    0,    0,    0,  823,    0,
			   46,  859,  862,  866,    0,  824,    0,    0,   45,  781,
			   42,    0,    0,    0,    0,  854,  857,   51,  864,    0,
			  822,    0,   50,    0,   41,    0,   49,    0,   43,    0,
			  855,  858,  861,  865,  770,  823,   44,   42,    0,    0,
			   48,  280,   40,    0,    0,    0,   87,   47,    0,   13,
			    0,   41,    0,    0,    0,    0,    0,    0,    0,    0,
			   46,    0,    0,    0,    0,    0,    0,  880,   45,   40,
			    0,   44,    0,    0,    0,    0,  769,    0,   43,    0,
			    0,    0,    0,    0,  121,  120,  821,   42,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,   88,
			   87,   41,    0,   13,    0,  280,  280,    0,  280,  280,
			  280,    0,    0,   43,    0,    0,    0,    0,    0,   40,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,    2,
			    1,   44,  280,    0,    0,  768,    0,   42,    0,    0,
			  821,    0,    0,    0,    0,    0,    0,    0,    0,  767,
			    0,   41,    0,    0,  280,    0,    0,    0,    0,    0,
			  280,    0,    0,    0,    0,    0,    0,  766,    0,   40,
			    0,    0,   42,   43,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,    2,    1,    0,   41,    0,    0,  280,

			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,   13,    0,    0,   40,    0,    0,    0,    0,    0,
			    0,  280,  280,  280,  280,  280,  280,  280,  280,  280,
			  280,  280,  280,  280,    0,  280,  280,    0,  280,  280,
			  280,    0,   42,    0,  280,    0,    0,  223,    0,    0,
			    0,    0,  256,  257,   13,  259,   41,  260,  261,    0,
			    0,    0,    0,  155,    0,  280,    0,  222,    0,  283,
			  778,    0,    0,    0,   40,    0,    0,    0,  156,    0,
			  221,    0,   11,   10,    9,    8,    7,    6,    5,    4,
			    3,    2,    1,    0,  280,  280,   85,    0,  305,    0,

			    0,  311,    0,    0,    0,    0,    0,  213,    0,  797,
			  340,  215,    0,  220,    0,    0,    0,    0,  280,    0,
			    0,  255,    0,  219,    0,   11,   10,    9,    8,    7,
			    6,    5,    4,    3,    2,    1,    0,    0,  362,  363,
			  364,  365,  366,  367,  368,  369,  370,  371,  372,  373,
			  374,  376,  377,  379,  380,  381,    0,    0,    0,  -68,
			    0,  292,  385,  295,  296,    0,    0,    0,    0,    0,
			    0,    0,  524,    0,    0,    0,  314,    0,    0,    0,
			   77,  406,   75,   74,   73,   72,   71,   70,   69,   68,
			   67,   66,   65,   64,   63,   62,   61,   60,   59,   58,

			   57,  -68,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,  -68,    0,    0,    0,    0,    0,   85,
			    0,    0,    0,    0,    0,    0,    0,    0,  382,    0,
			  -68,  -68,  -68,  -68,  -68,  -68,  -68,  -68,  -68,  -68,
			  -68,    0,    0,    0,    0,   90,   89,    0,    0,    0,
			  435,    0,    0,  436,    0,    0,    0,    0,    0,    0,
			   88,   87,   86,   85,   13,   84,   83,    0,   82,    0,
			    0,    0,   81,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   80,   79,    0,    0,    0,  459,    0,  417,
			  418,  419,  420,  421,  422,  423,  424,  425,  426,  427,

			  428,  429,   78,   77,   76,   75,   74,   73,   72,   71,
			   70,   69,   68,   67,   66,   65,   64,   63,   62,   61,
			   60,   59,   58,   57,    0,    0,  280,    0,    0,    0,
			    0,  406,    0,    0,  280,   11,   10,    9,    8,    7,
			    6,    5,    4,    3,    2,    1,   78,   77,   76,   75,
			   74,   73,   72,   71,   70,   69,   68,   67,   66,   65,
			   64,   63,   62,   61,   60,   59,   58,   57,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  476,    0,
			    0,    0,    0,    0,    0,    0,    0,  484,  279,  278,
			  277,  276,  275,  274,  273,  272,  271,  270,  269,  268,

			  267,  266,  265,  264,  263,  181, -198, -198,    0,  493,
			 -198,    0,    0,    0, -198,    0,  280,    0,    0, -198,
			    0,  280,    0,   85,    0,    0, -198,    0,    0, -198,
			    0,  515,    0,    0,    0,    0, -198,    0,    0,    0,
			    0,    0,    0,  280, -198, -198,    0,    0,    0,    0,
			    0,    0,    0,  280,  280,    0,    0,    0,    0,    0,
			    0,  515,    0,   90,   89,  280,  280,    0,    0,  523,
			    0,  280,    0,    0,    0,    0,    0,  560,   88,   87,
			   86,   85,   13,   84,   83,  787,    0,    0,    0,    0,
			   81,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			   80,   79,    0,    0,    0,  280,  280,   77,    0,   75,
			   74,   73,   72,   71,   70,   69,   68,   67,   66,   65,
			   64,   63,   62,   61,   60,   59,   58,   57,    0,  667,
			    0,    0,  280,  121,  120,    0,    0,    0,    0,    0,
			    0,    0,    0,  620,    0,    0,    0,  675,   88,    0,
			    0,    0,   13,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,    2,    1,   78,   77,   76,   75,   74,   73,
			   72,   71,   70,   69,   68,   67,   66,   65,   64,   63,
			   62,   61,   60,   59,   58,   57,  654,    0,    0,  821,
			  279,  278,  277,  276,  275,  274,  273,  272,  271,  270,

			  269,  268,  267,  266,  265,  264,  263,  181,    0,  757,
			    0,    0,    0,  762,    0,    0,    0,    0,    0,    0,
			  784,    0,    0,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,    2,    1,  699,  794,  795,  277,  276,  275,
			  274,  273,  272,  271,  270,  269,  268,  267,  266,  265,
			  264,  263,  181,  729,    0,    0,    0,    0,    0,    0,
			  806,  807,    0,  734,    0,    0,    0,  812,  275,  274,
			  273,  272,  271,  270,  269,  268,  267,  266,  265,  264,
			  263,  181,  876,  279,  278,  277,  276,  275,  274,  273,
			  272,  271,  270,  269,  268,  267,  266,  265,  264,  263,

			  181,  183,  182,    0,    0,  846,  847,    0,  181,  180,
			  179,  178,    0,  177,    0,    0,  176,   87,  175,   85,
			   13,   84,   83,    0,    0,  174,  873,    0,   81,    0,
			  173,    0,    0,  172,  808,  150,    0,    0,   80,   79,
			    0,  171,    0,    0,    0,    0,  170,    0,    0,    0,
			  378,    0,    0,    0,    0,    0,    0,  169,    0,    0,
			    0,  831,  835,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  168,  167,    0,  796,    0,    0,    0,  166,
			    0,  835,    0,    0,    0,    0,    0,    0,    0,  165,
			    0,   11,   10,    9,    8,    7,    6,    5,    4,    3,

			    2,    1,   78,   77,   76,   75,   74,   73,   72,   71,
			   70,   69,   68,   67,   66,   65,   64,   63,   62,   61,
			   60,   59,   58,   57,  183,  182,    0,    0,    0,    0,
			    0,  181,  180,  179,  178,    0,  177,    0,    0,  176,
			   87,  175,   85,   13,   84,   83,    0,    0,  174,    0,
			    0,   81,    0,  173,    0,    0,  172,    0,  150,    0,
			    0,   80,   79,    0,  171,    0,    0,    0,    0,  170,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  169,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  168,  167,    0,    0,    0,

			    0,    0,  166,    0,    0,    0,  375,    0,    0,    0,
			    0,    0,  165,    0,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,    2,    1,   78,   77,   76,   75,   74,
			   73,   72,   71,   70,   69,   68,   67,   66,   65,   64,
			   63,   62,   61,   60,   59,   58,   57,  183,  182,    0,
			    0,    0,    0,    0,  181,  180,  179,  178,    0,  177,
			    0,    0,  176,   87,  175,   85,   13,   84,   83,    0,
			    0,  174,    0,    0,   81,    0,  173,    0,  310,  172,
			    0,  150,    0,    0,   80,   79,    0,  171,    0,    0,
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

			    0,    0,  172,    0,  150,    0,    0,   80,   79,    0,
			  171,    0,    0,    0,    0,  170,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  169,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  168,  167,    0,    0,    0,    0,    0,  166,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  165,    0,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,    2,
			    1,   78,   77,   76,   75,   74,   73,   72,   71,   70,
			   69,   68,   67,   66,   65,   64,   63,   62,   61,   60,
			   59,   58,   57,  183,  182,    0,    0,    0,    0,    0,

			  181,  180,  179,  178,    0,  177,    0,    0,  176,   87,
			  175,   85,   13,   84,   83,    0,    0,  174,    0,    0,
			   81,    0,  173,    0,    0,  405,    0,  150,    0,    0,
			   80,   79,    0,  171,    0,    0,    0,    0,  170,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  169,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  168,  167,   13,    0,    0,    0,
			    0,  166,    0,    0,    0,    0,    0,    0,    0,  779,
			    0,  404,    0,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,    2,    1,   78,   77,   76,   75,   74,   73,

			   72,   71,   70,   69,   68,   67,   66,   65,   64,   63,
			   62,   61,   60,   59,   58,   57,   90,   89,    0,    0,
			    0,    0,    0,  235,    0,  778,    0,    0,    0,    0,
			   36,   88,   87,   86,   85,    0,   84,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    2,    1,    0,    0,
			    0,    0,    0,   80,   79,    0,  234,  276,  275,  274,
			  273,  272,  271,  270,  269,  268,  267,  266,  265,  264,
			  263,  181,  233,    0,    0,    0,  646,    0,    0,    0,
			    0,    0,    0,    0,  232,    0,    0,    0,    0,  231,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			  645,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   22,   21,    0,    0,    0,    0,    0,   78,   77,   76,
			   75,   74,   73,   72,   71,   70,   69,   68,   67,   66,
			   65,   64,   63,   62,   61,   60,   59,   58,   57,  745,
			    0,    0,    0,    0,    0,    0,   13,    0,  744,    0,
			    0,    0,  602,    0,  743,    0,    0,   36,    0,  742,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  741,    0,  740,  739,    0,    0,    0,    0,   36,    0,
			    0,    0,    0,  169,    0,    0,  738,    0,    0,    0,
			    0,  240,    0,    0,    0,    0,    0,    0,  168,  233,

			    0,    0,    0,    0,    0,  737,    0,    0,    0,    0,
			    0,  232,   13,    0,    0,    0,    0,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    2,    1,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   22,   21,    0,
			  -33,  -33,    0,    0,    0,    0,   13,    0,  -33,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,
			  -33,    0,  -33,  -33,    0,    0,    0,    0,    0,  -33,
			   13,    0,    0,    0,  -34,  -34,    0,    0,    0,    0,
			    0,    0,  -34,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,    2,    1,  -34,  -30,  -34,  -34,  -30,    0,

			    0,    0,  -30,  -34,  -30,    0,  -30,   13,    0,  -30,
			    0,    0,    0,    0,    0,    0,    0,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    2,    1,   13,    0,
			    0,    0,  -30,    0,    0,    0,    0,    0,    0,  665,
			    0,   11,   10,    9,    8,    7,    6,    5,    4,    3,
			    2,    1,    0,  -31,    0,    0,  -31,    0,    0,    0,
			  -31,    0,  -31,   36,  -31,    0,   35,  -31,    0,    0,
			    0,    0,    0,    0,    0,    0,  240,    0,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,    2,    1,    0,
			  -31,    0,    0,    0,    0,    0,    0,   34,    0,   11,

			   10,    9,    8,    7,    6,    5,    4,    3,    2,    1,
			   33,   36,    0,    0,   35,    0,    0,    0,    0,    0,
			    0,    0,    0,   36,    0,   32,    0,  157,    0,    0,
			    0,    0,    0,    0,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,   22,   21,   34,   36,    0,    0,   35,
			    0,    0,    0,    0,    0,    0,    0,    0,   33,    0,
			    0,    0,    0,    0,    0,  233,    0,    0,    0,    0,
			    0,    0,    0,   32,  -69,    0,    0,  232,    0,    0,
			   34,    0,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,   33,   31,   30,   29,   28,   27,   26,

			   25,   24,   23,   22,   21,   13,    0,    0,   32,    0,
			    0,    0,    0,    0,    0,    0,  -69,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,   22,   21,  -69,   36,
			    0,    0,    0,    0,    0,    0,    0,  650,    0,    0,
			   13,    0,    0,  548,    0,  -69,  -69,  -69,  -69,  -69,
			  -69,  -69,  -69,  -69,  -69,  -69,   13,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  117,   13,    0,    0,
			    0,    0,    0,    0,    0,    0,   11,   10,    9,    8,
			    7,    6,    5,    4,    3,    2,    1,   36,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   12,    0,    0,

			   31,   30,   29,   28,   27,   26,   25,   24,   23,   22,
			   21,   11,   10,    9,    8,    7,    6,    5,    4,    3,
			    2,    1,    0,    0,    0,    0,    0,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    2,    1,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,    2,    1,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   22,   21,  279,
			  278,  277,  276,  275,  274,  273,  272,  271,  270,  269,
			  268,  267,  266,  265,  264,  263,  181,  279,  278,  277,
			  276,  275,  274,  273,  272,  271,  270,  269,  268,  267>>,
			1, 3000, 0)
		end

	yytable_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  266,  265,  264,  263,  181,  279,  278,  277,  276,  275,
			  274,  273,  272,  271,  270,  269,  268,  267,  266,  265,
			  264,  263,  181,    0,    0,    0,    0,    0,  805,  278,
			  277,  276,  275,  274,  273,  272,  271,  270,  269,  268,
			  267,  266,  265,  264,  263,  181,  415,  870,  279,  278,
			  277,  276,  275,  274,  273,  272,  271,  270,  269,  268,
			  267,  266,  265,  264,  263,  181,  279,  278,  277,  276,
			  275,  274,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,  264,  263,  181,    0,    0,    0,    0,    0,  403,
			  338,  337,  336,  335,  334,  333,  332,  331,  330,  329,

			  328,  327,  326,  325,  324,  323,  322,  357,  321,  279,
			  278,  277,  276,  275,  274,  273,  272,  271,  270,  269,
			  268,  267,  266,  265,  264,  263,  181>>,
			1, 127, 3000)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		local
			an_array: ARRAY [INTEGER]
		once
			!! an_array.make (0, 3126)
			yycheck_template_1 (an_array)
			yycheck_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yycheck_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,  289,   14,   18,  230,   35,  292,   14,  228,   18,
			   83,   14,   12,   18,  258,  592,   20,   18,   18,   18,
			   20,   55,  171,   40,  439,   14,   47,  578,    0,   65,
			  511,  576,   14,   33,  677,   35,  262,  680,   25,   32,
			   67,   34,   69,   71,  533,   14,   27,   26,   40,   77,
			   26,  124,  533,   14,  605,   91,   99,  100,  284,  285,
			   41,   42,   38,  608,  553,   93,   53,  710,   95,   56,
			  143,   83,  553,   65,   53,  626,   83,   56,   26,   96,
			   83,  688,  103,  697,   65,   40,   63,  730,   65,   70,
			   45,  705,   40,   74,   83,   76,   48,   78,  741,  172,

			   65,   83,   83,   68,  711,  534,  140,  141,  537,  538,
			  717,  540,  124,   65,   83,  758,   14,  124,   65,   26,
			    0,  124,   83,   88,   89,   37,  541,   74,   25,   94,
			  804,  143,   97,  562,   46,  124,  143,  152,  211,   46,
			  143,   38,  124,  152,  573,  819,  139,  152,  725,  222,
			   40,  152,  152,  152,  143,  124,   65,  764,   14,   49,
			  172,  143,   25,  124,   26,  172,   25,  167,   37,  172,
			   61,   62,   41,   42,  143,   38,   38,   39,   69,   26,
			   47,   25,  143,  172,  633,   83,   65,   61,  603,  796,
			  172,   38,   39,   84,   38,   25,   65,  646,   72,  211,

			   40,   70,  809,  172,  211,   74,  432,   47,  211,   78,
			  222,  172,   29,   63,   31,  222,  228,   14,  218,  222,
			   46,  228,  211,   74,    3,  228,  124,   83,   79,  211,
			  230,   14,  225,  222,   39,   40,  356,  844,  653,  228,
			  222,  848,  211,   64,  659,  143,  228,  240,    3,   14,
			  211,   40,   63,  222,   65,  255,   45,  168,  258,  228,
			   47,  222,  262,  870,    3,  485,   40,  228,  124,  876,
			   37,   45,    3,   40,  172,  395,  396,  122,  123,  399,
			  400,  401,   41,   42,  284,  285,   83,  143,  703,  409,
			  135,  136,   65,  293,  414,  295,  296,   29,   25,   31,

			   83,  301,  302,  303,   65,   41,   65,  307,  645,   99,
			  647,   70,   63,  211,  314,   74,  172,  437,   83,   78,
			   63,   64,   65,   66,  222,   39,   40,  124,   35,   65,
			  228,  101,  405,   25,   70,   78,   20,   21,   74,   47,
			   48,  124,   78,  463,   61,   62,  143,   41,   91,   47,
			   48,   47,   69,   25,   26,  211,   99,  100,  101,  124,
			  143,   47,   48,   65,   81,   47,  222,   84,  488,  489,
			   47,   65,  228,   47,   48,  172,   70,   47,  143,   47,
			   74,  100,  382,   47,   78,   47,  387,  507,  299,  172,
			  539,   47,   48,  405,   47,   48,   65,  397,  405,   65,

			   47,   70,  405,   72,   70,   74,   72,  172,   74,   78,
			  559,  699,   78,   47,  211,   47,  405,  417,  840,  841,
			  842,  843,   47,  405,   47,  222,   47,   48,  211,   47,
			   48,  228,  432,  433,  678,   25,  405,  586,   37,  222,
			   25,  685,   47,   48,  405,  228,  211,   47,   48,   65,
			  599,  600,  452,  453,   47,   48,   25,  222,   47,   48,
			  460,   26,   37,  228,   63,   64,   65,   66,   78,   65,
			   37,   91,   96,  485,   27,  763,  476,   81,  485,   78,
			   66,   63,  485,  394,   90,   49,   83,   74,   65,  482,
			   48,   65,   91,   94,  780,   65,  485,   45,   74,  410,

			   99,  100,  101,  485,   14,   15,   65,  405,   14,   15,
			   16,   17,   18,   19,   20,   21,  485,   88,   40,   29,
			   39,   72,   65,   33,  485,   97,   46,   55,   40,  817,
			   68,  524,   78,   65,  820,   16,   17,   18,   19,   20,
			   21,   70,   26,   41,  617,   42,   48,   37,   26,  405,
			   85,  837,   25,  464,  465,  466,  467,  468,  469,  470,
			  471,  472,  473,  474,  475,   33,   25,   50,   85,   85,
			   85,  644,   85,   47,   85,   38,   85,   85,   85,   25,
			   85,  492,   85,   25,   85,   85,   40,  485,   49,   76,
			   45,  591,  585,   40,  104,  105,  106,  107,  108,  109,

			  110,  111,  112,  113,  114,  617,   47,   47,  405,  520,
			  617,   47,   47,   44,  617,  615,   25,  632,  103,  839,
			   25,  694,  405,  632,   25,   48,   40,  632,  617,  485,
			   49,  632,  644,  633,   26,  617,   46,  644,   65,   47,
			  405,  644,   35,  643,   69,   29,  646,  651,  617,   29,
			   46,  651,   58,   39,  654,  644,  617,  661,  590,  523,
			  620,  661,  644,  523,  583,  523,  547,  685,   96,  173,
			  615,  744,  638,  698,  649,  644,  599,  729,  678,  729,
			  481,  456,  694,  644,  729,  685,  397,  694,  485,  729,
			  729,  694,  729,  845,  729,  705,  729,  443,  531,  556,

			  572,  834,  485,  790,  514,  694,  779,  632,  152,  397,
			  729,   -1,  694,   -1,   -1,   -1,   -1,   -1,   -1,  617,
			  485,   -1,   -1,   -1,   -1,  694,   -1,   -1,   -1,  729,
			  742,   -1,  744,  694,   -1,  742,   -1,  744,   -1,  742,
			   -1,  744,   -1,  743,   -1,   -1,  644,   -1,   -1,   -1,
			   -1,   -1,   -1,  742,   -1,  744,   -1,   -1,   -1,   -1,
			  742,  617,  744,   -1,   -1,   -1,   -1,  779,   -1,   -1,
			   -1,   -1,  779,  742,   -1,  744,  779,   -1,  808,   -1,
			   -1,  742,   -1,  744,   -1,   -1,   -1,   -1,  644,   -1,
			  779,   -1,  792,  808,   -1,   -1,  694,  779,   -1,   -1,

			   -1,   -1,   -1,   -1,  804,   -1,   -1,   -1,  808,   -1,
			  779,  841,  842,  843,   -1,  845,   -1,   -1,  779,  819,
			  617,   -1,   -1,   -1,   -1,  840,  841,  839,  843,   -1,
			  845,   -1,  839,   -1,  617,   -1,  839,   -1,  694,   -1,
			  840,  841,  842,  843,  742,  845,  744,  644,   -1,   -1,
			  839,  192,  617,   -1,   -1,   -1,   30,  839,   -1,   33,
			   -1,  644,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  839,   -1,   -1,   -1,   -1,   -1,   -1,  877,  839,  644,
			   -1,  779,   -1,   -1,   -1,   -1,  742,   -1,  744,   -1,
			   -1,   -1,   -1,   -1,   14,   15,   70,  694,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   29,
			   30,  694,   -1,   33,   -1,  256,  257,   -1,  259,  260,
			  261,   -1,   -1,  779,   -1,   -1,   -1,   -1,   -1,  694,
			  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  839,  283,   -1,   -1,  742,   -1,  744,   -1,   -1,
			   70,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  742,
			   -1,  744,   -1,   -1,  305,   -1,   -1,   -1,   -1,   -1,
			  311,   -1,   -1,   -1,   -1,   -1,   -1,  742,   -1,  744,
			   -1,   -1,  779,  839,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,   -1,  779,   -1,   -1,  340,

			   41,   42,   43,   44,   45,   46,   47,   48,   49,   50,
			   51,   33,   -1,   -1,  779,   -1,   -1,   -1,   -1,   -1,
			   -1,  362,  363,  364,  365,  366,  367,  368,  369,  370,
			  371,  372,  373,  374,   -1,  376,  377,   -1,  379,  380,
			  381,   -1,  839,   -1,  385,   -1,   -1,   26,   -1,   -1,
			   -1,   -1,  177,  178,   33,  180,  839,  182,  183,   -1,
			   -1,   -1,   -1,  104,   -1,  406,   -1,   46,   -1,  194,
			   92,   -1,   -1,   -1,  839,   -1,   -1,   -1,  119,   -1,
			   59,   -1,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   -1,  435,  436,   32,   -1,  223,   -1,

			   -1,  226,   -1,   -1,   -1,   -1,   -1,  160,   -1,   45,
			  235,  164,   -1,   92,   -1,   -1,   -1,   -1,  459,   -1,
			   -1,  174,   -1,  102,   -1,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,   -1,   -1,  263,  264,
			  265,  266,  267,  268,  269,  270,  271,  272,  273,  274,
			  275,  276,  277,  278,  279,  280,   -1,   -1,   -1,   33,
			   -1,  214,  287,  216,  217,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   46,   -1,   -1,   -1,  229,   -1,   -1,   -1,
			  116,  306,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,

			  136,   75,  243,  244,  245,  246,  247,  248,  249,  250,
			  251,  252,  253,   87,   -1,   -1,   -1,   -1,   -1,   32,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  281,   -1,
			  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,   -1,   -1,   -1,   -1,   14,   15,   -1,   -1,   -1,
			  375,   -1,   -1,  378,   -1,   -1,   -1,   -1,   -1,   -1,
			   29,   30,   31,   32,   33,   34,   35,   -1,   37,   -1,
			   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   51,   52,   -1,   -1,   -1,  412,   -1,  342,
			  343,  344,  345,  346,  347,  348,  349,  350,  351,  352,

			  353,  354,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,   -1,   -1,  667,   -1,   -1,   -1,
			   -1,  456,   -1,   -1,  675,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  431,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  440,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,

			   16,   17,   18,   19,   20,   21,   61,   62,   -1,  462,
			   65,   -1,   -1,   -1,   69,   -1,  757,   -1,   -1,   74,
			   -1,  762,   -1,   32,   -1,   -1,   81,   -1,   -1,   84,
			   -1,  484,   -1,   -1,   -1,   -1,   91,   -1,   -1,   -1,
			   -1,   -1,   -1,  784,   99,  100,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  794,  795,   -1,   -1,   -1,   -1,   -1,
			   -1,  514,   -1,   14,   15,  806,  807,   -1,   -1,  510,
			   -1,  812,   -1,   -1,   -1,   -1,   -1,  530,   29,   30,
			   31,   32,   33,   34,   35,  101,   -1,   -1,   -1,   -1,
			   41,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   51,   52,   -1,   -1,   -1,  846,  847,  116,   -1,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,   -1,  654,
			   -1,   -1,  873,   14,   15,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  596,   -1,   -1,   -1,  672,   29,   -1,
			   -1,   -1,   33,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,  639,   -1,   -1,   70,
			    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,

			   14,   15,   16,   17,   18,   19,   20,   21,   -1,  734,
			   -1,   -1,   -1,  738,   -1,   -1,   -1,   -1,   -1,   -1,
			  745,   -1,   -1,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  687,  760,  761,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,  706,   -1,   -1,   -1,   -1,   -1,   -1,
			  785,  786,   -1,  716,   -1,   -1,   -1,  792,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   96,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,

			   21,   14,   15,   -1,   -1,  830,  831,   -1,   21,   22,
			   23,   24,   -1,   26,   -1,   -1,   29,   30,   31,   32,
			   33,   34,   35,   -1,   -1,   38,  851,   -1,   41,   -1,
			   43,   -1,   -1,   46,  787,   48,   -1,   -1,   51,   52,
			   -1,   54,   -1,   -1,   -1,   -1,   59,   -1,   -1,   -1,
			   63,   -1,   -1,   -1,   -1,   -1,   -1,   70,   -1,   -1,
			   -1,  814,  815,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   85,   86,   -1,   96,   -1,   -1,   -1,   92,
			   -1,  834,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  102,
			   -1,  104,  105,  106,  107,  108,  109,  110,  111,  112,

			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,   14,   15,   -1,   -1,   -1,   -1,
			   -1,   21,   22,   23,   24,   -1,   26,   -1,   -1,   29,
			   30,   31,   32,   33,   34,   35,   -1,   -1,   38,   -1,
			   -1,   41,   -1,   43,   -1,   -1,   46,   -1,   48,   -1,
			   -1,   51,   52,   -1,   54,   -1,   -1,   -1,   -1,   59,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   70,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   85,   86,   -1,   -1,   -1,

			   -1,   -1,   92,   -1,   -1,   -1,   96,   -1,   -1,   -1,
			   -1,   -1,  102,   -1,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,  132,  133,  134,  135,  136,   14,   15,   -1,
			   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,   26,
			   -1,   -1,   29,   30,   31,   32,   33,   34,   35,   -1,
			   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   45,   46,
			   -1,   48,   -1,   -1,   51,   52,   -1,   54,   -1,   -1,
			   -1,   -1,   59,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   70,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   85,   86,
			   -1,   -1,   -1,   -1,   -1,   92,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  102,   -1,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			   14,   15,   -1,   -1,   -1,   -1,   -1,   21,   22,   23,
			   24,   -1,   26,   -1,   -1,   29,   30,   31,   32,   33,
			   34,   35,   -1,   -1,   38,   -1,   -1,   41,   -1,   43,

			   -1,   -1,   46,   -1,   48,   -1,   -1,   51,   52,   -1,
			   54,   -1,   -1,   -1,   -1,   59,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   70,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   85,   86,   -1,   -1,   -1,   -1,   -1,   92,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  102,   -1,
			  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,   14,   15,   -1,   -1,   -1,   -1,   -1,

			   21,   22,   23,   24,   -1,   26,   -1,   -1,   29,   30,
			   31,   32,   33,   34,   35,   -1,   -1,   38,   -1,   -1,
			   41,   -1,   43,   -1,   -1,   46,   -1,   48,   -1,   -1,
			   51,   52,   -1,   54,   -1,   -1,   -1,   -1,   59,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   70,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   85,   86,   33,   -1,   -1,   -1,
			   -1,   92,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   46,
			   -1,  102,   -1,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,

			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,   14,   15,   -1,   -1,
			   -1,   -1,   -1,   26,   -1,   92,   -1,   -1,   -1,   -1,
			   33,   29,   30,   31,   32,   -1,   34,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,   -1,   -1,
			   -1,   -1,   -1,   51,   52,   -1,   59,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   75,   -1,   -1,   -1,   74,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   87,   -1,   -1,   -1,   -1,   92,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   98,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   -1,   -1,   -1,   -1,   -1,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,  131,  132,  133,  134,  135,  136,   26,
			   -1,   -1,   -1,   -1,   -1,   -1,   33,   -1,   35,   -1,
			   -1,   -1,   28,   -1,   41,   -1,   -1,   33,   -1,   46,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   57,   -1,   59,   60,   -1,   -1,   -1,   -1,   33,   -1,
			   -1,   -1,   -1,   70,   -1,   -1,   73,   -1,   -1,   -1,
			   -1,   46,   -1,   -1,   -1,   -1,   -1,   -1,   85,   75,

			   -1,   -1,   -1,   -1,   -1,   92,   -1,   -1,   -1,   -1,
			   -1,   87,   33,   -1,   -1,   -1,   -1,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   -1,
			   61,   62,   -1,   -1,   -1,   -1,   33,   -1,   69,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			   81,   -1,   83,   84,   -1,   -1,   -1,   -1,   -1,   90,
			   33,   -1,   -1,   -1,   61,   62,   -1,   -1,   -1,   -1,
			   -1,   -1,   69,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,   81,   58,   83,   84,   61,   -1,

			   -1,   -1,   65,   90,   67,   -1,   69,   33,   -1,   72,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,   33,   -1,
			   -1,   -1,   95,   -1,   -1,   -1,   -1,   -1,   -1,   65,
			   -1,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   -1,   58,   -1,   -1,   61,   -1,   -1,   -1,
			   65,   -1,   67,   33,   69,   -1,   36,   72,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   46,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   -1,
			   95,   -1,   -1,   -1,   -1,   -1,   -1,   67,   -1,  104,

			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			   80,   33,   -1,   -1,   36,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   33,   -1,   95,   -1,   49,   -1,   -1,
			   -1,   -1,   -1,   -1,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,   67,   33,   -1,   -1,   36,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   80,   -1,
			   -1,   -1,   -1,   -1,   -1,   75,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   95,   33,   -1,   -1,   87,   -1,   -1,
			   67,   -1,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   80,  104,  105,  106,  107,  108,  109,

			  110,  111,  112,  113,  114,   33,   -1,   -1,   95,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   75,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,   87,   33,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   65,   -1,   -1,
			   33,   -1,   -1,   47,   -1,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,   33,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   59,   33,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   33,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   74,   -1,   -1,

			  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   -1,   -1,   -1,   -1,   -1,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,    4,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16>>,
			1, 3000, 0)
		end

	yycheck_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			   17,   18,   19,   20,   21,    4,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   -1,   -1,   -1,   -1,   -1,   45,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   45,   82,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   -1,   -1,   -1,   -1,   -1,   45,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,

			  128,  129,  130,  131,  132,  133,  134,   45,  136,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21>>,
			1, 127, 3000)
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

	yytype16 (v: ANY): CREATE_AS is
		require
			valid_type: yyis_type16 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type16 (v: ANY): BOOLEAN is
		local
			u: CREATE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype17 (v: ANY): CREATION_AS is
		require
			valid_type: yyis_type17 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type17 (v: ANY): BOOLEAN is
		local
			u: CREATION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype18 (v: ANY): CREATION_EXPR_AS is
		require
			valid_type: yyis_type18 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type18 (v: ANY): BOOLEAN is
		local
			u: CREATION_EXPR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype19 (v: ANY): DEBUG_AS is
		require
			valid_type: yyis_type19 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type19 (v: ANY): BOOLEAN is
		local
			u: DEBUG_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype20 (v: ANY): ELSIF_AS is
		require
			valid_type: yyis_type20 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type20 (v: ANY): BOOLEAN is
		local
			u: ELSIF_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype21 (v: ANY): ENSURE_AS is
		require
			valid_type: yyis_type21 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type21 (v: ANY): BOOLEAN is
		local
			u: ENSURE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype22 (v: ANY): EXPORT_ITEM_AS is
		require
			valid_type: yyis_type22 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type22 (v: ANY): BOOLEAN is
		local
			u: EXPORT_ITEM_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype23 (v: ANY): EXPR_AS is
		require
			valid_type: yyis_type23 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type23 (v: ANY): BOOLEAN is
		local
			u: EXPR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype24 (v: ANY): EXTERNAL_AS is
		require
			valid_type: yyis_type24 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type24 (v: ANY): BOOLEAN is
		local
			u: EXTERNAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype25 (v: ANY): EXTERNAL_LANG_AS is
		require
			valid_type: yyis_type25 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type25 (v: ANY): BOOLEAN is
		local
			u: EXTERNAL_LANG_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype26 (v: ANY): FEATURE_AS is
		require
			valid_type: yyis_type26 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type26 (v: ANY): BOOLEAN is
		local
			u: FEATURE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype27 (v: ANY): FEATURE_CLAUSE_AS is
		require
			valid_type: yyis_type27 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type27 (v: ANY): BOOLEAN is
		local
			u: FEATURE_CLAUSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype28 (v: ANY): FEATURE_SET_AS is
		require
			valid_type: yyis_type28 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type28 (v: ANY): BOOLEAN is
		local
			u: FEATURE_SET_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype29 (v: ANY): FORMAL_DEC_AS is
		require
			valid_type: yyis_type29 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type29 (v: ANY): BOOLEAN is
		local
			u: FORMAL_DEC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype30 (v: ANY): ID_AS is
		require
			valid_type: yyis_type30 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type30 (v: ANY): BOOLEAN is
		local
			u: ID_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype31 (v: ANY): IF_AS is
		require
			valid_type: yyis_type31 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type31 (v: ANY): BOOLEAN is
		local
			u: IF_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype32 (v: ANY): INDEX_AS is
		require
			valid_type: yyis_type32 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type32 (v: ANY): BOOLEAN is
		local
			u: INDEX_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype33 (v: ANY): INSPECT_AS is
		require
			valid_type: yyis_type33 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type33 (v: ANY): BOOLEAN is
		local
			u: INSPECT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype34 (v: ANY): INSTR_CALL_AS is
		require
			valid_type: yyis_type34 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type34 (v: ANY): BOOLEAN is
		local
			u: INSTR_CALL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype35 (v: ANY): INSTRUCTION_AS is
		require
			valid_type: yyis_type35 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type35 (v: ANY): BOOLEAN is
		local
			u: INSTRUCTION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype36 (v: ANY): INTEGER_CONSTANT is
		require
			valid_type: yyis_type36 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type36 (v: ANY): BOOLEAN is
		local
			u: INTEGER_CONSTANT
		do
			u ?= v
			Result := (u = v)
		end

	yytype37 (v: ANY): INTERNAL_AS is
		require
			valid_type: yyis_type37 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type37 (v: ANY): BOOLEAN is
		local
			u: INTERNAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype38 (v: ANY): INTERVAL_AS is
		require
			valid_type: yyis_type38 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type38 (v: ANY): BOOLEAN is
		local
			u: INTERVAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype39 (v: ANY): INVARIANT_AS is
		require
			valid_type: yyis_type39 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type39 (v: ANY): BOOLEAN is
		local
			u: INVARIANT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype40 (v: ANY): LOOP_AS is
		require
			valid_type: yyis_type40 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type40 (v: ANY): BOOLEAN is
		local
			u: LOOP_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype41 (v: ANY): NESTED_AS is
		require
			valid_type: yyis_type41 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type41 (v: ANY): BOOLEAN is
		local
			u: NESTED_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype42 (v: ANY): NESTED_EXPR_AS is
		require
			valid_type: yyis_type42 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type42 (v: ANY): BOOLEAN is
		local
			u: NESTED_EXPR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype43 (v: ANY): OPERAND_AS is
		require
			valid_type: yyis_type43 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type43 (v: ANY): BOOLEAN is
		local
			u: OPERAND_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype44 (v: ANY): PARENT_AS is
		require
			valid_type: yyis_type44 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type44 (v: ANY): BOOLEAN is
		local
			u: PARENT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype45 (v: ANY): PRECURSOR_AS is
		require
			valid_type: yyis_type45 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type45 (v: ANY): BOOLEAN is
		local
			u: PRECURSOR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype46 (v: ANY): STATIC_ACCESS_AS is
		require
			valid_type: yyis_type46 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type46 (v: ANY): BOOLEAN is
		local
			u: STATIC_ACCESS_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype47 (v: ANY): REAL_AS is
		require
			valid_type: yyis_type47 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type47 (v: ANY): BOOLEAN is
		local
			u: REAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype48 (v: ANY): RENAME_AS is
		require
			valid_type: yyis_type48 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type48 (v: ANY): BOOLEAN is
		local
			u: RENAME_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype49 (v: ANY): REQUIRE_AS is
		require
			valid_type: yyis_type49 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type49 (v: ANY): BOOLEAN is
		local
			u: REQUIRE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype50 (v: ANY): RETRY_AS is
		require
			valid_type: yyis_type50 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type50 (v: ANY): BOOLEAN is
		local
			u: RETRY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype51 (v: ANY): REVERSE_AS is
		require
			valid_type: yyis_type51 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type51 (v: ANY): BOOLEAN is
		local
			u: REVERSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype52 (v: ANY): ROUT_BODY_AS is
		require
			valid_type: yyis_type52 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type52 (v: ANY): BOOLEAN is
		local
			u: ROUT_BODY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype53 (v: ANY): ROUTINE_AS is
		require
			valid_type: yyis_type53 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type53 (v: ANY): BOOLEAN is
		local
			u: ROUTINE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype54 (v: ANY): ROUTINE_CREATION_AS is
		require
			valid_type: yyis_type54 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type54 (v: ANY): BOOLEAN is
		local
			u: ROUTINE_CREATION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype55 (v: ANY): STRING_AS is
		require
			valid_type: yyis_type55 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type55 (v: ANY): BOOLEAN is
		local
			u: STRING_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype56 (v: ANY): TAGGED_AS is
		require
			valid_type: yyis_type56 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type56 (v: ANY): BOOLEAN is
		local
			u: TAGGED_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype57 (v: ANY): TUPLE_AS is
		require
			valid_type: yyis_type57 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type57 (v: ANY): BOOLEAN is
		local
			u: TUPLE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype58 (v: ANY): TYPE is
		require
			valid_type: yyis_type58 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type58 (v: ANY): BOOLEAN is
		local
			u: TYPE
		do
			u ?= v
			Result := (u = v)
		end

	yytype59 (v: ANY): TYPE_DEC_AS is
		require
			valid_type: yyis_type59 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type59 (v: ANY): BOOLEAN is
		local
			u: TYPE_DEC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype60 (v: ANY): VARIANT_AS is
		require
			valid_type: yyis_type60 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type60 (v: ANY): BOOLEAN is
		local
			u: VARIANT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype61 (v: ANY): EIFFEL_LIST [ATOMIC_AS] is
		require
			valid_type: yyis_type61 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type61 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ATOMIC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype62 (v: ANY): EIFFEL_LIST [CASE_AS] is
		require
			valid_type: yyis_type62 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type62 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CASE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype63 (v: ANY): EIFFEL_LIST [CREATE_AS] is
		require
			valid_type: yyis_type63 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type63 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CREATE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype64 (v: ANY): EIFFEL_LIST [ELSIF_AS] is
		require
			valid_type: yyis_type64 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type64 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ELSIF_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype65 (v: ANY): EIFFEL_LIST [EXPORT_ITEM_AS] is
		require
			valid_type: yyis_type65 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type65 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype66 (v: ANY): EIFFEL_LIST [EXPR_AS] is
		require
			valid_type: yyis_type66 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type66 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXPR_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype67 (v: ANY): EIFFEL_LIST [FEATURE_AS] is
		require
			valid_type: yyis_type67 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type67 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype68 (v: ANY): EIFFEL_LIST [FEATURE_CLAUSE_AS] is
		require
			valid_type: yyis_type68 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type68 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype70 (v: ANY): EIFFEL_LIST [FEATURE_NAME] is
		require
			valid_type: yyis_type70 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type70 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_NAME]
		do
			u ?= v
			Result := (u = v)
		end

	yytype71 (v: ANY): EIFFEL_LIST [FORMAL_DEC_AS] is
		require
			valid_type: yyis_type71 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type71 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FORMAL_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype72 (v: ANY): EIFFEL_LIST [ID_AS] is
		require
			valid_type: yyis_type72 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type72 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ID_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype74 (v: ANY): ARRAYED_LIST [INTEGER] is
		require
			valid_type: yyis_type74 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type74 (v: ANY): BOOLEAN is
		local
			u: ARRAYED_LIST [INTEGER]
		do
			u ?= v
			Result := (u = v)
		end

	yytype75 (v: ANY): INDEXING_CLAUSE_AS is
		require
			valid_type: yyis_type75 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type75 (v: ANY): BOOLEAN is
		local
			u: INDEXING_CLAUSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype76 (v: ANY): EIFFEL_LIST [INSTRUCTION_AS] is
		require
			valid_type: yyis_type76 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type76 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INSTRUCTION_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype77 (v: ANY): EIFFEL_LIST [INTERVAL_AS] is
		require
			valid_type: yyis_type77 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type77 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INTERVAL_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype78 (v: ANY): EIFFEL_LIST [OPERAND_AS] is
		require
			valid_type: yyis_type78 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type78 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [OPERAND_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype79 (v: ANY): EIFFEL_LIST [PARENT_AS] is
		require
			valid_type: yyis_type79 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type79 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [PARENT_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype80 (v: ANY): EIFFEL_LIST [RENAME_AS] is
		require
			valid_type: yyis_type80 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type80 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [RENAME_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype81 (v: ANY): EIFFEL_LIST [STRING_AS] is
		require
			valid_type: yyis_type81 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type81 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [STRING_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype82 (v: ANY): EIFFEL_LIST [TAGGED_AS] is
		require
			valid_type: yyis_type82 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type82 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TAGGED_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype83 (v: ANY): EIFFEL_LIST [TYPE] is
		require
			valid_type: yyis_type83 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type83 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE]
		do
			u ?= v
			Result := (u = v)
		end

	yytype84 (v: ANY): EIFFEL_LIST [TYPE_DEC_AS] is
		require
			valid_type: yyis_type84 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type84 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype86 (v: ANY): PAIR [ID_AS, CLICK_AST] is
		require
			valid_type: yyis_type86 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type86 (v: ANY): BOOLEAN is
		local
			u: PAIR [ID_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype87 (v: ANY): PAIR [FEATURE_NAME, CLICK_AST] is
		require
			valid_type: yyis_type87 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type87 (v: ANY): BOOLEAN is
		local
			u: PAIR [FEATURE_NAME, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype88 (v: ANY): PAIR [STRING_AS, CLICK_AST] is
		require
			valid_type: yyis_type88 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type88 (v: ANY): BOOLEAN is
		local
			u: PAIR [STRING_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype89 (v: ANY): PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST] is
		require
			valid_type: yyis_type89 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type89 (v: ANY): BOOLEAN is
		local
			u: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype90 (v: ANY): PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]] is
		require
			valid_type: yyis_type90 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type90 (v: ANY): BOOLEAN is
		local
			u: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
			u ?= v
			Result := (u = v)
		end

	yytype91 (v: ANY): TOKEN_LOCATION is
		require
			valid_type: yyis_type91 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type91 (v: ANY): BOOLEAN is
		local
			u: TOKEN_LOCATION
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 883
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 137
			-- Number of tokens

	yyLast: INTEGER is 3126
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 391
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 324
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
