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
--|#line 298 "eiffel.y"
	yy_do_action_21
when 22 then
--|#line 303 "eiffel.y"
	yy_do_action_22
when 23 then
--|#line 308 "eiffel.y"
	yy_do_action_23
when 24 then
--|#line 315 "eiffel.y"
	yy_do_action_24
when 25 then
--|#line 317 "eiffel.y"
	yy_do_action_25
when 26 then
--|#line 319 "eiffel.y"
	yy_do_action_26
when 27 then
--|#line 323 "eiffel.y"
	yy_do_action_27
when 28 then
--|#line 333 "eiffel.y"
	yy_do_action_28
when 29 then
--|#line 339 "eiffel.y"
	yy_do_action_29
when 30 then
--|#line 346 "eiffel.y"
	yy_do_action_30
when 31 then
--|#line 352 "eiffel.y"
	yy_do_action_31
when 32 then
--|#line 360 "eiffel.y"
	yy_do_action_32
when 33 then
--|#line 364 "eiffel.y"
	yy_do_action_33
when 34 then
--|#line 375 "eiffel.y"
	yy_do_action_34
when 35 then
--|#line 379 "eiffel.y"
	yy_do_action_35
when 36 then
--|#line 394 "eiffel.y"
	yy_do_action_36
when 37 then
--|#line 396 "eiffel.y"
	yy_do_action_37
when 38 then
--|#line 403 "eiffel.y"
	yy_do_action_38
when 39 then
--|#line 405 "eiffel.y"
	yy_do_action_39
when 40 then
--|#line 414 "eiffel.y"
	yy_do_action_40
when 41 then
--|#line 419 "eiffel.y"
	yy_do_action_41
when 42 then
--|#line 426 "eiffel.y"
	yy_do_action_42
when 43 then
--|#line 428 "eiffel.y"
	yy_do_action_43
when 44 then
--|#line 432 "eiffel.y"
	yy_do_action_44
when 45 then
--|#line 432 "eiffel.y"
	yy_do_action_45
when 46 then
--|#line 441 "eiffel.y"
	yy_do_action_46
when 47 then
--|#line 443 "eiffel.y"
	yy_do_action_47
when 48 then
--|#line 447 "eiffel.y"
	yy_do_action_48
when 49 then
--|#line 452 "eiffel.y"
	yy_do_action_49
when 50 then
--|#line 456 "eiffel.y"
	yy_do_action_50
when 51 then
--|#line 462 "eiffel.y"
	yy_do_action_51
when 52 then
--|#line 470 "eiffel.y"
	yy_do_action_52
when 53 then
--|#line 475 "eiffel.y"
	yy_do_action_53
when 54 then
--|#line 482 "eiffel.y"
	yy_do_action_54
when 55 then
--|#line 483 "eiffel.y"
	yy_do_action_55
when 56 then
--|#line 486 "eiffel.y"
	yy_do_action_56
when 57 then
--|#line 499 "eiffel.y"
	yy_do_action_57
when 58 then
--|#line 501 "eiffel.y"
	yy_do_action_58
when 59 then
--|#line 508 "eiffel.y"
	yy_do_action_59
when 60 then
--|#line 512 "eiffel.y"
	yy_do_action_60
when 61 then
--|#line 514 "eiffel.y"
	yy_do_action_61
when 62 then
--|#line 518 "eiffel.y"
	yy_do_action_62
when 63 then
--|#line 520 "eiffel.y"
	yy_do_action_63
when 64 then
--|#line 522 "eiffel.y"
	yy_do_action_64
when 65 then
--|#line 526 "eiffel.y"
	yy_do_action_65
when 66 then
--|#line 531 "eiffel.y"
	yy_do_action_66
when 67 then
--|#line 535 "eiffel.y"
	yy_do_action_67
when 68 then
--|#line 539 "eiffel.y"
	yy_do_action_68
when 69 then
--|#line 541 "eiffel.y"
	yy_do_action_69
when 70 then
--|#line 545 "eiffel.y"
	yy_do_action_70
when 71 then
--|#line 550 "eiffel.y"
	yy_do_action_71
when 72 then
--|#line 555 "eiffel.y"
	yy_do_action_72
when 73 then
--|#line 566 "eiffel.y"
	yy_do_action_73
when 74 then
--|#line 568 "eiffel.y"
	yy_do_action_74
when 75 then
--|#line 570 "eiffel.y"
	yy_do_action_75
when 76 then
--|#line 574 "eiffel.y"
	yy_do_action_76
when 77 then
--|#line 579 "eiffel.y"
	yy_do_action_77
when 78 then
--|#line 586 "eiffel.y"
	yy_do_action_78
when 79 then
--|#line 591 "eiffel.y"
	yy_do_action_79
when 80 then
--|#line 599 "eiffel.y"
	yy_do_action_80
when 81 then
--|#line 604 "eiffel.y"
	yy_do_action_81
when 82 then
--|#line 609 "eiffel.y"
	yy_do_action_82
when 83 then
--|#line 614 "eiffel.y"
	yy_do_action_83
when 84 then
--|#line 619 "eiffel.y"
	yy_do_action_84
when 85 then
--|#line 624 "eiffel.y"
	yy_do_action_85
when 86 then
--|#line 629 "eiffel.y"
	yy_do_action_86
when 87 then
--|#line 637 "eiffel.y"
	yy_do_action_87
when 88 then
--|#line 639 "eiffel.y"
	yy_do_action_88
when 89 then
--|#line 643 "eiffel.y"
	yy_do_action_89
when 90 then
--|#line 648 "eiffel.y"
	yy_do_action_90
when 91 then
--|#line 655 "eiffel.y"
	yy_do_action_91
when 92 then
--|#line 659 "eiffel.y"
	yy_do_action_92
when 93 then
--|#line 661 "eiffel.y"
	yy_do_action_93
when 94 then
--|#line 665 "eiffel.y"
	yy_do_action_94
when 95 then
--|#line 667 "eiffel.y"
	yy_do_action_95
when 96 then
--|#line 671 "eiffel.y"
	yy_do_action_96
when 97 then
--|#line 676 "eiffel.y"
	yy_do_action_97
when 98 then
--|#line 683 "eiffel.y"
	yy_do_action_98
when 99 then
--|#line 687 "eiffel.y"
	yy_do_action_99
when 100 then
--|#line 689 "eiffel.y"
	yy_do_action_100
when 101 then
--|#line 693 "eiffel.y"
	yy_do_action_101
when 102 then
--|#line 695 "eiffel.y"
	yy_do_action_102
when 103 then
--|#line 701 "eiffel.y"
	yy_do_action_103
when 104 then
--|#line 706 "eiffel.y"
	yy_do_action_104
when 105 then
--|#line 714 "eiffel.y"
	yy_do_action_105
when 106 then
--|#line 720 "eiffel.y"
	yy_do_action_106
when 107 then
--|#line 728 "eiffel.y"
	yy_do_action_107
when 108 then
--|#line 733 "eiffel.y"
	yy_do_action_108
when 109 then
--|#line 740 "eiffel.y"
	yy_do_action_109
when 110 then
--|#line 742 "eiffel.y"
	yy_do_action_110
when 111 then
--|#line 746 "eiffel.y"
	yy_do_action_111
when 112 then
--|#line 748 "eiffel.y"
	yy_do_action_112
when 113 then
--|#line 752 "eiffel.y"
	yy_do_action_113
when 114 then
--|#line 754 "eiffel.y"
	yy_do_action_114
when 115 then
--|#line 758 "eiffel.y"
	yy_do_action_115
when 116 then
--|#line 760 "eiffel.y"
	yy_do_action_116
when 117 then
--|#line 764 "eiffel.y"
	yy_do_action_117
when 118 then
--|#line 766 "eiffel.y"
	yy_do_action_118
when 119 then
--|#line 770 "eiffel.y"
	yy_do_action_119
when 120 then
--|#line 772 "eiffel.y"
	yy_do_action_120
when 121 then
--|#line 780 "eiffel.y"
	yy_do_action_121
when 122 then
--|#line 782 "eiffel.y"
	yy_do_action_122
when 123 then
--|#line 786 "eiffel.y"
	yy_do_action_123
when 124 then
--|#line 788 "eiffel.y"
	yy_do_action_124
when 125 then
--|#line 792 "eiffel.y"
	yy_do_action_125
when 126 then
--|#line 797 "eiffel.y"
	yy_do_action_126
when 127 then
--|#line 804 "eiffel.y"
	yy_do_action_127
when 128 then
--|#line 808 "eiffel.y"
	yy_do_action_128
when 129 then
--|#line 809 "eiffel.y"
	yy_do_action_129
when 130 then
--|#line 818 "eiffel.y"
	yy_do_action_130
when 131 then
--|#line 820 "eiffel.y"
	yy_do_action_131
when 132 then
--|#line 824 "eiffel.y"
	yy_do_action_132
when 133 then
--|#line 829 "eiffel.y"
	yy_do_action_133
when 134 then
--|#line 836 "eiffel.y"
	yy_do_action_134
when 135 then
--|#line 840 "eiffel.y"
	yy_do_action_135
when 136 then
--|#line 846 "eiffel.y"
	yy_do_action_136
when 137 then
--|#line 854 "eiffel.y"
	yy_do_action_137
when 138 then
--|#line 856 "eiffel.y"
	yy_do_action_138
when 139 then
--|#line 860 "eiffel.y"
	yy_do_action_139
when 140 then
--|#line 862 "eiffel.y"
	yy_do_action_140
when 141 then
--|#line 866 "eiffel.y"
	yy_do_action_141
when 142 then
--|#line 866 "eiffel.y"
	yy_do_action_142
when 143 then
--|#line 878 "eiffel.y"
	yy_do_action_143
when 144 then
--|#line 880 "eiffel.y"
	yy_do_action_144
when 145 then
--|#line 882 "eiffel.y"
	yy_do_action_145
when 146 then
--|#line 886 "eiffel.y"
	yy_do_action_146
when 147 then
--|#line 890 "eiffel.y"
	yy_do_action_147
when 148 then
--|#line 895 "eiffel.y"
	yy_do_action_148
when 149 then
--|#line 897 "eiffel.y"
	yy_do_action_149
when 150 then
--|#line 901 "eiffel.y"
	yy_do_action_150
when 151 then
--|#line 903 "eiffel.y"
	yy_do_action_151
when 152 then
--|#line 907 "eiffel.y"
	yy_do_action_152
when 153 then
--|#line 909 "eiffel.y"
	yy_do_action_153
when 154 then
--|#line 913 "eiffel.y"
	yy_do_action_154
when 155 then
--|#line 915 "eiffel.y"
	yy_do_action_155
when 156 then
--|#line 919 "eiffel.y"
	yy_do_action_156
when 157 then
--|#line 924 "eiffel.y"
	yy_do_action_157
when 158 then
--|#line 931 "eiffel.y"
	yy_do_action_158
when 159 then
--|#line 935 "eiffel.y"
	yy_do_action_159
when 160 then
--|#line 936 "eiffel.y"
	yy_do_action_160
when 161 then
--|#line 939 "eiffel.y"
	yy_do_action_161
when 162 then
--|#line 941 "eiffel.y"
	yy_do_action_162
when 163 then
--|#line 943 "eiffel.y"
	yy_do_action_163
when 164 then
--|#line 945 "eiffel.y"
	yy_do_action_164
when 165 then
--|#line 947 "eiffel.y"
	yy_do_action_165
when 166 then
--|#line 949 "eiffel.y"
	yy_do_action_166
when 167 then
--|#line 951 "eiffel.y"
	yy_do_action_167
when 168 then
--|#line 953 "eiffel.y"
	yy_do_action_168
when 169 then
--|#line 955 "eiffel.y"
	yy_do_action_169
when 170 then
--|#line 957 "eiffel.y"
	yy_do_action_170
when 171 then
--|#line 961 "eiffel.y"
	yy_do_action_171
when 172 then
--|#line 963 "eiffel.y"
	yy_do_action_172
when 173 then
--|#line 963 "eiffel.y"
	yy_do_action_173
when 174 then
--|#line 970 "eiffel.y"
	yy_do_action_174
when 175 then
--|#line 970 "eiffel.y"
	yy_do_action_175
when 176 then
--|#line 979 "eiffel.y"
	yy_do_action_176
when 177 then
--|#line 981 "eiffel.y"
	yy_do_action_177
when 178 then
--|#line 981 "eiffel.y"
	yy_do_action_178
when 179 then
--|#line 988 "eiffel.y"
	yy_do_action_179
when 180 then
--|#line 988 "eiffel.y"
	yy_do_action_180
when 181 then
--|#line 997 "eiffel.y"
	yy_do_action_181
when 182 then
--|#line 999 "eiffel.y"
	yy_do_action_182
when 183 then
--|#line 1008 "eiffel.y"
	yy_do_action_183
when 184 then
--|#line 1013 "eiffel.y"
	yy_do_action_184
when 185 then
--|#line 1020 "eiffel.y"
	yy_do_action_185
when 186 then
--|#line 1024 "eiffel.y"
	yy_do_action_186
when 187 then
--|#line 1026 "eiffel.y"
	yy_do_action_187
when 188 then
--|#line 1028 "eiffel.y"
	yy_do_action_188
when 189 then
--|#line 1036 "eiffel.y"
	yy_do_action_189
when 190 then
--|#line 1038 "eiffel.y"
	yy_do_action_190
when 191 then
--|#line 1042 "eiffel.y"
	yy_do_action_191
when 192 then
--|#line 1044 "eiffel.y"
	yy_do_action_192
when 193 then
--|#line 1046 "eiffel.y"
	yy_do_action_193
when 194 then
--|#line 1048 "eiffel.y"
	yy_do_action_194
when 195 then
--|#line 1050 "eiffel.y"
	yy_do_action_195
when 196 then
--|#line 1052 "eiffel.y"
	yy_do_action_196
when 197 then
--|#line 1056 "eiffel.y"
	yy_do_action_197
when 198 then
--|#line 1060 "eiffel.y"
	yy_do_action_198
when 199 then
--|#line 1062 "eiffel.y"
	yy_do_action_199
when 200 then
--|#line 1064 "eiffel.y"
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
--|#line 1068 "eiffel.y"
	yy_do_action_201
when 202 then
--|#line 1070 "eiffel.y"
	yy_do_action_202
when 203 then
--|#line 1074 "eiffel.y"
	yy_do_action_203
when 204 then
--|#line 1079 "eiffel.y"
	yy_do_action_204
when 205 then
--|#line 1090 "eiffel.y"
	yy_do_action_205
when 206 then
--|#line 1096 "eiffel.y"
	yy_do_action_206
when 207 then
--|#line 1104 "eiffel.y"
	yy_do_action_207
when 208 then
--|#line 1106 "eiffel.y"
	yy_do_action_208
when 209 then
--|#line 1110 "eiffel.y"
	yy_do_action_209
when 210 then
--|#line 1115 "eiffel.y"
	yy_do_action_210
when 211 then
--|#line 1122 "eiffel.y"
	yy_do_action_211
when 212 then
--|#line 1122 "eiffel.y"
	yy_do_action_212
when 213 then
--|#line 1132 "eiffel.y"
	yy_do_action_213
when 214 then
--|#line 1134 "eiffel.y"
	yy_do_action_214
when 215 then
--|#line 1142 "eiffel.y"
	yy_do_action_215
when 216 then
--|#line 1144 "eiffel.y"
	yy_do_action_216
when 217 then
--|#line 1152 "eiffel.y"
	yy_do_action_217
when 218 then
--|#line 1158 "eiffel.y"
	yy_do_action_218
when 219 then
--|#line 1160 "eiffel.y"
	yy_do_action_219
when 220 then
--|#line 1164 "eiffel.y"
	yy_do_action_220
when 221 then
--|#line 1169 "eiffel.y"
	yy_do_action_221
when 222 then
--|#line 1176 "eiffel.y"
	yy_do_action_222
when 223 then
--|#line 1180 "eiffel.y"
	yy_do_action_223
when 224 then
--|#line 1182 "eiffel.y"
	yy_do_action_224
when 225 then
--|#line 1186 "eiffel.y"
	yy_do_action_225
when 226 then
--|#line 1192 "eiffel.y"
	yy_do_action_226
when 227 then
--|#line 1194 "eiffel.y"
	yy_do_action_227
when 228 then
--|#line 1198 "eiffel.y"
	yy_do_action_228
when 229 then
--|#line 1203 "eiffel.y"
	yy_do_action_229
when 230 then
--|#line 1210 "eiffel.y"
	yy_do_action_230
when 231 then
--|#line 1214 "eiffel.y"
	yy_do_action_231
when 232 then
--|#line 1219 "eiffel.y"
	yy_do_action_232
when 233 then
--|#line 1226 "eiffel.y"
	yy_do_action_233
when 234 then
--|#line 1228 "eiffel.y"
	yy_do_action_234
when 235 then
--|#line 1230 "eiffel.y"
	yy_do_action_235
when 236 then
--|#line 1232 "eiffel.y"
	yy_do_action_236
when 237 then
--|#line 1234 "eiffel.y"
	yy_do_action_237
when 238 then
--|#line 1236 "eiffel.y"
	yy_do_action_238
when 239 then
--|#line 1238 "eiffel.y"
	yy_do_action_239
when 240 then
--|#line 1240 "eiffel.y"
	yy_do_action_240
when 241 then
--|#line 1242 "eiffel.y"
	yy_do_action_241
when 242 then
--|#line 1244 "eiffel.y"
	yy_do_action_242
when 243 then
--|#line 1246 "eiffel.y"
	yy_do_action_243
when 244 then
--|#line 1248 "eiffel.y"
	yy_do_action_244
when 245 then
--|#line 1250 "eiffel.y"
	yy_do_action_245
when 246 then
--|#line 1252 "eiffel.y"
	yy_do_action_246
when 247 then
--|#line 1254 "eiffel.y"
	yy_do_action_247
when 248 then
--|#line 1256 "eiffel.y"
	yy_do_action_248
when 249 then
--|#line 1258 "eiffel.y"
	yy_do_action_249
when 250 then
--|#line 1260 "eiffel.y"
	yy_do_action_250
when 251 then
--|#line 1265 "eiffel.y"
	yy_do_action_251
when 252 then
--|#line 1267 "eiffel.y"
	yy_do_action_252
when 253 then
--|#line 1276 "eiffel.y"
	yy_do_action_253
when 254 then
--|#line 1282 "eiffel.y"
	yy_do_action_254
when 255 then
--|#line 1284 "eiffel.y"
	yy_do_action_255
when 256 then
--|#line 1288 "eiffel.y"
	yy_do_action_256
when 257 then
--|#line 1290 "eiffel.y"
	yy_do_action_257
when 258 then
--|#line 1290 "eiffel.y"
	yy_do_action_258
when 259 then
--|#line 1300 "eiffel.y"
	yy_do_action_259
when 260 then
--|#line 1302 "eiffel.y"
	yy_do_action_260
when 261 then
--|#line 1304 "eiffel.y"
	yy_do_action_261
when 262 then
--|#line 1308 "eiffel.y"
	yy_do_action_262
when 263 then
--|#line 1314 "eiffel.y"
	yy_do_action_263
when 264 then
--|#line 1316 "eiffel.y"
	yy_do_action_264
when 265 then
--|#line 1318 "eiffel.y"
	yy_do_action_265
when 266 then
--|#line 1322 "eiffel.y"
	yy_do_action_266
when 267 then
--|#line 1327 "eiffel.y"
	yy_do_action_267
when 268 then
--|#line 1334 "eiffel.y"
	yy_do_action_268
when 269 then
--|#line 1338 "eiffel.y"
	yy_do_action_269
when 270 then
--|#line 1340 "eiffel.y"
	yy_do_action_270
when 271 then
--|#line 1349 "eiffel.y"
	yy_do_action_271
when 272 then
--|#line 1351 "eiffel.y"
	yy_do_action_272
when 273 then
--|#line 1355 "eiffel.y"
	yy_do_action_273
when 274 then
--|#line 1357 "eiffel.y"
	yy_do_action_274
when 275 then
--|#line 1361 "eiffel.y"
	yy_do_action_275
when 276 then
--|#line 1363 "eiffel.y"
	yy_do_action_276
when 277 then
--|#line 1367 "eiffel.y"
	yy_do_action_277
when 278 then
--|#line 1372 "eiffel.y"
	yy_do_action_278
when 279 then
--|#line 1379 "eiffel.y"
	yy_do_action_279
when 280 then
--|#line 1385 "eiffel.y"
	yy_do_action_280
when 281 then
--|#line 1390 "eiffel.y"
	yy_do_action_281
when 282 then
--|#line 1395 "eiffel.y"
	yy_do_action_282
when 283 then
--|#line 1405 "eiffel.y"
	yy_do_action_283
when 284 then
--|#line 1415 "eiffel.y"
	yy_do_action_284
when 285 then
--|#line 1427 "eiffel.y"
	yy_do_action_285
when 286 then
--|#line 1430 "eiffel.y"
	yy_do_action_286
when 287 then
--|#line 1432 "eiffel.y"
	yy_do_action_287
when 288 then
--|#line 1434 "eiffel.y"
	yy_do_action_288
when 289 then
--|#line 1436 "eiffel.y"
	yy_do_action_289
when 290 then
--|#line 1438 "eiffel.y"
	yy_do_action_290
when 291 then
--|#line 1440 "eiffel.y"
	yy_do_action_291
when 292 then
--|#line 1442 "eiffel.y"
	yy_do_action_292
when 293 then
--|#line 1451 "eiffel.y"
	yy_do_action_293
when 294 then
--|#line 1460 "eiffel.y"
	yy_do_action_294
when 295 then
--|#line 1470 "eiffel.y"
	yy_do_action_295
when 296 then
--|#line 1479 "eiffel.y"
	yy_do_action_296
when 297 then
--|#line 1488 "eiffel.y"
	yy_do_action_297
when 298 then
--|#line 1497 "eiffel.y"
	yy_do_action_298
when 299 then
--|#line 1508 "eiffel.y"
	yy_do_action_299
when 300 then
--|#line 1510 "eiffel.y"
	yy_do_action_300
when 301 then
--|#line 1514 "eiffel.y"
	yy_do_action_301
when 302 then
--|#line 1519 "eiffel.y"
	yy_do_action_302
when 303 then
--|#line 1526 "eiffel.y"
	yy_do_action_303
when 304 then
--|#line 1532 "eiffel.y"
	yy_do_action_304
when 305 then
--|#line 1534 "eiffel.y"
	yy_do_action_305
when 306 then
--|#line 1536 "eiffel.y"
	yy_do_action_306
when 307 then
--|#line 1538 "eiffel.y"
	yy_do_action_307
when 308 then
--|#line 1540 "eiffel.y"
	yy_do_action_308
when 309 then
--|#line 1542 "eiffel.y"
	yy_do_action_309
when 310 then
--|#line 1544 "eiffel.y"
	yy_do_action_310
when 311 then
--|#line 1546 "eiffel.y"
	yy_do_action_311
when 312 then
--|#line 1548 "eiffel.y"
	yy_do_action_312
when 313 then
--|#line 1552 "eiffel.y"
	yy_do_action_313
when 314 then
--|#line 1561 "eiffel.y"
	yy_do_action_314
when 315 then
--|#line 1563 "eiffel.y"
	yy_do_action_315
when 316 then
--|#line 1567 "eiffel.y"
	yy_do_action_316
when 317 then
--|#line 1569 "eiffel.y"
	yy_do_action_317
when 318 then
--|#line 1580 "eiffel.y"
	yy_do_action_318
when 319 then
--|#line 1582 "eiffel.y"
	yy_do_action_319
when 320 then
--|#line 1586 "eiffel.y"
	yy_do_action_320
when 321 then
--|#line 1588 "eiffel.y"
	yy_do_action_321
when 322 then
--|#line 1592 "eiffel.y"
	yy_do_action_322
when 323 then
--|#line 1594 "eiffel.y"
	yy_do_action_323
when 324 then
--|#line 1602 "eiffel.y"
	yy_do_action_324
when 325 then
--|#line 1604 "eiffel.y"
	yy_do_action_325
when 326 then
--|#line 1606 "eiffel.y"
	yy_do_action_326
when 327 then
--|#line 1608 "eiffel.y"
	yy_do_action_327
when 328 then
--|#line 1610 "eiffel.y"
	yy_do_action_328
when 329 then
--|#line 1612 "eiffel.y"
	yy_do_action_329
when 330 then
--|#line 1614 "eiffel.y"
	yy_do_action_330
when 331 then
--|#line 1616 "eiffel.y"
	yy_do_action_331
when 332 then
--|#line 1618 "eiffel.y"
	yy_do_action_332
when 333 then
--|#line 1622 "eiffel.y"
	yy_do_action_333
when 334 then
--|#line 1630 "eiffel.y"
	yy_do_action_334
when 335 then
--|#line 1632 "eiffel.y"
	yy_do_action_335
when 336 then
--|#line 1634 "eiffel.y"
	yy_do_action_336
when 337 then
--|#line 1636 "eiffel.y"
	yy_do_action_337
when 338 then
--|#line 1638 "eiffel.y"
	yy_do_action_338
when 339 then
--|#line 1640 "eiffel.y"
	yy_do_action_339
when 340 then
--|#line 1642 "eiffel.y"
	yy_do_action_340
when 341 then
--|#line 1644 "eiffel.y"
	yy_do_action_341
when 342 then
--|#line 1646 "eiffel.y"
	yy_do_action_342
when 343 then
--|#line 1648 "eiffel.y"
	yy_do_action_343
when 344 then
--|#line 1650 "eiffel.y"
	yy_do_action_344
when 345 then
--|#line 1652 "eiffel.y"
	yy_do_action_345
when 346 then
--|#line 1654 "eiffel.y"
	yy_do_action_346
when 347 then
--|#line 1656 "eiffel.y"
	yy_do_action_347
when 348 then
--|#line 1658 "eiffel.y"
	yy_do_action_348
when 349 then
--|#line 1660 "eiffel.y"
	yy_do_action_349
when 350 then
--|#line 1662 "eiffel.y"
	yy_do_action_350
when 351 then
--|#line 1664 "eiffel.y"
	yy_do_action_351
when 352 then
--|#line 1666 "eiffel.y"
	yy_do_action_352
when 353 then
--|#line 1668 "eiffel.y"
	yy_do_action_353
when 354 then
--|#line 1670 "eiffel.y"
	yy_do_action_354
when 355 then
--|#line 1672 "eiffel.y"
	yy_do_action_355
when 356 then
--|#line 1674 "eiffel.y"
	yy_do_action_356
when 357 then
--|#line 1676 "eiffel.y"
	yy_do_action_357
when 358 then
--|#line 1678 "eiffel.y"
	yy_do_action_358
when 359 then
--|#line 1680 "eiffel.y"
	yy_do_action_359
when 360 then
--|#line 1682 "eiffel.y"
	yy_do_action_360
when 361 then
--|#line 1684 "eiffel.y"
	yy_do_action_361
when 362 then
--|#line 1686 "eiffel.y"
	yy_do_action_362
when 363 then
--|#line 1688 "eiffel.y"
	yy_do_action_363
when 364 then
--|#line 1690 "eiffel.y"
	yy_do_action_364
when 365 then
--|#line 1692 "eiffel.y"
	yy_do_action_365
when 366 then
--|#line 1694 "eiffel.y"
	yy_do_action_366
when 367 then
--|#line 1696 "eiffel.y"
	yy_do_action_367
when 368 then
--|#line 1698 "eiffel.y"
	yy_do_action_368
when 369 then
--|#line 1700 "eiffel.y"
	yy_do_action_369
when 370 then
--|#line 1704 "eiffel.y"
	yy_do_action_370
when 371 then
--|#line 1712 "eiffel.y"
	yy_do_action_371
when 372 then
--|#line 1714 "eiffel.y"
	yy_do_action_372
when 373 then
--|#line 1716 "eiffel.y"
	yy_do_action_373
when 374 then
--|#line 1718 "eiffel.y"
	yy_do_action_374
when 375 then
--|#line 1720 "eiffel.y"
	yy_do_action_375
when 376 then
--|#line 1722 "eiffel.y"
	yy_do_action_376
when 377 then
--|#line 1724 "eiffel.y"
	yy_do_action_377
when 378 then
--|#line 1726 "eiffel.y"
	yy_do_action_378
when 379 then
--|#line 1728 "eiffel.y"
	yy_do_action_379
when 380 then
--|#line 1730 "eiffel.y"
	yy_do_action_380
when 381 then
--|#line 1732 "eiffel.y"
	yy_do_action_381
when 382 then
--|#line 1734 "eiffel.y"
	yy_do_action_382
when 383 then
--|#line 1738 "eiffel.y"
	yy_do_action_383
when 384 then
--|#line 1742 "eiffel.y"
	yy_do_action_384
when 385 then
--|#line 1746 "eiffel.y"
	yy_do_action_385
when 386 then
--|#line 1750 "eiffel.y"
	yy_do_action_386
when 387 then
--|#line 1754 "eiffel.y"
	yy_do_action_387
when 388 then
--|#line 1758 "eiffel.y"
	yy_do_action_388
when 389 then
--|#line 1760 "eiffel.y"
	yy_do_action_389
when 390 then
--|#line 1762 "eiffel.y"
	yy_do_action_390
when 391 then
--|#line 1764 "eiffel.y"
	yy_do_action_391
when 392 then
--|#line 1768 "eiffel.y"
	yy_do_action_392
when 393 then
--|#line 1772 "eiffel.y"
	yy_do_action_393
when 394 then
--|#line 1779 "eiffel.y"
	yy_do_action_394
when 395 then
--|#line 1787 "eiffel.y"
	yy_do_action_395
when 396 then
--|#line 1789 "eiffel.y"
	yy_do_action_396
when 397 then
--|#line 1793 "eiffel.y"
	yy_do_action_397
when 398 then
--|#line 1795 "eiffel.y"
	yy_do_action_398
when 399 then
--|#line 1799 "eiffel.y"
	yy_do_action_399
when 400 then
--|#line 1812 "eiffel.y"
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
--|#line 1816 "eiffel.y"
	yy_do_action_401
when 402 then
--|#line 1818 "eiffel.y"
	yy_do_action_402
when 403 then
--|#line 1820 "eiffel.y"
	yy_do_action_403
when 404 then
--|#line 1824 "eiffel.y"
	yy_do_action_404
when 405 then
--|#line 1829 "eiffel.y"
	yy_do_action_405
when 406 then
--|#line 1836 "eiffel.y"
	yy_do_action_406
when 407 then
--|#line 1838 "eiffel.y"
	yy_do_action_407
when 408 then
--|#line 1842 "eiffel.y"
	yy_do_action_408
when 409 then
--|#line 1847 "eiffel.y"
	yy_do_action_409
when 410 then
--|#line 1858 "eiffel.y"
	yy_do_action_410
when 411 then
--|#line 1862 "eiffel.y"
	yy_do_action_411
when 412 then
--|#line 1864 "eiffel.y"
	yy_do_action_412
when 413 then
--|#line 1866 "eiffel.y"
	yy_do_action_413
when 414 then
--|#line 1868 "eiffel.y"
	yy_do_action_414
when 415 then
--|#line 1870 "eiffel.y"
	yy_do_action_415
when 416 then
--|#line 1872 "eiffel.y"
	yy_do_action_416
when 417 then
--|#line 1876 "eiffel.y"
	yy_do_action_417
when 418 then
--|#line 1878 "eiffel.y"
	yy_do_action_418
when 419 then
--|#line 1880 "eiffel.y"
	yy_do_action_419
when 420 then
--|#line 1895 "eiffel.y"
	yy_do_action_420
when 421 then
--|#line 1897 "eiffel.y"
	yy_do_action_421
when 422 then
--|#line 1899 "eiffel.y"
	yy_do_action_422
when 423 then
--|#line 1903 "eiffel.y"
	yy_do_action_423
when 424 then
--|#line 1905 "eiffel.y"
	yy_do_action_424
when 425 then
--|#line 1909 "eiffel.y"
	yy_do_action_425
when 426 then
--|#line 1916 "eiffel.y"
	yy_do_action_426
when 427 then
--|#line 1931 "eiffel.y"
	yy_do_action_427
when 428 then
--|#line 1946 "eiffel.y"
	yy_do_action_428
when 429 then
--|#line 1964 "eiffel.y"
	yy_do_action_429
when 430 then
--|#line 1966 "eiffel.y"
	yy_do_action_430
when 431 then
--|#line 1968 "eiffel.y"
	yy_do_action_431
when 432 then
--|#line 1975 "eiffel.y"
	yy_do_action_432
when 433 then
--|#line 1979 "eiffel.y"
	yy_do_action_433
when 434 then
--|#line 1981 "eiffel.y"
	yy_do_action_434
when 435 then
--|#line 1983 "eiffel.y"
	yy_do_action_435
when 436 then
--|#line 1987 "eiffel.y"
	yy_do_action_436
when 437 then
--|#line 1989 "eiffel.y"
	yy_do_action_437
when 438 then
--|#line 1991 "eiffel.y"
	yy_do_action_438
when 439 then
--|#line 1993 "eiffel.y"
	yy_do_action_439
when 440 then
--|#line 1995 "eiffel.y"
	yy_do_action_440
when 441 then
--|#line 1997 "eiffel.y"
	yy_do_action_441
when 442 then
--|#line 1999 "eiffel.y"
	yy_do_action_442
when 443 then
--|#line 2001 "eiffel.y"
	yy_do_action_443
when 444 then
--|#line 2003 "eiffel.y"
	yy_do_action_444
when 445 then
--|#line 2005 "eiffel.y"
	yy_do_action_445
when 446 then
--|#line 2007 "eiffel.y"
	yy_do_action_446
when 447 then
--|#line 2009 "eiffel.y"
	yy_do_action_447
when 448 then
--|#line 2011 "eiffel.y"
	yy_do_action_448
when 449 then
--|#line 2013 "eiffel.y"
	yy_do_action_449
when 450 then
--|#line 2015 "eiffel.y"
	yy_do_action_450
when 451 then
--|#line 2017 "eiffel.y"
	yy_do_action_451
when 452 then
--|#line 2019 "eiffel.y"
	yy_do_action_452
when 453 then
--|#line 2021 "eiffel.y"
	yy_do_action_453
when 454 then
--|#line 2023 "eiffel.y"
	yy_do_action_454
when 455 then
--|#line 2025 "eiffel.y"
	yy_do_action_455
when 456 then
--|#line 2027 "eiffel.y"
	yy_do_action_456
when 457 then
--|#line 2031 "eiffel.y"
	yy_do_action_457
when 458 then
--|#line 2033 "eiffel.y"
	yy_do_action_458
when 459 then
--|#line 2035 "eiffel.y"
	yy_do_action_459
when 460 then
--|#line 2037 "eiffel.y"
	yy_do_action_460
when 461 then
--|#line 2041 "eiffel.y"
	yy_do_action_461
when 462 then
--|#line 2043 "eiffel.y"
	yy_do_action_462
when 463 then
--|#line 2045 "eiffel.y"
	yy_do_action_463
when 464 then
--|#line 2047 "eiffel.y"
	yy_do_action_464
when 465 then
--|#line 2049 "eiffel.y"
	yy_do_action_465
when 466 then
--|#line 2051 "eiffel.y"
	yy_do_action_466
when 467 then
--|#line 2053 "eiffel.y"
	yy_do_action_467
when 468 then
--|#line 2055 "eiffel.y"
	yy_do_action_468
when 469 then
--|#line 2057 "eiffel.y"
	yy_do_action_469
when 470 then
--|#line 2059 "eiffel.y"
	yy_do_action_470
when 471 then
--|#line 2061 "eiffel.y"
	yy_do_action_471
when 472 then
--|#line 2063 "eiffel.y"
	yy_do_action_472
when 473 then
--|#line 2065 "eiffel.y"
	yy_do_action_473
when 474 then
--|#line 2067 "eiffel.y"
	yy_do_action_474
when 475 then
--|#line 2069 "eiffel.y"
	yy_do_action_475
when 476 then
--|#line 2071 "eiffel.y"
	yy_do_action_476
when 477 then
--|#line 2073 "eiffel.y"
	yy_do_action_477
when 478 then
--|#line 2075 "eiffel.y"
	yy_do_action_478
when 479 then
--|#line 2079 "eiffel.y"
	yy_do_action_479
when 480 then
--|#line 2083 "eiffel.y"
	yy_do_action_480
when 481 then
--|#line 2087 "eiffel.y"
	yy_do_action_481
when 482 then
--|#line 2091 "eiffel.y"
	yy_do_action_482
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

yyval33 := new_index_as (yytype31 (yyvs.item (yyvsp - 2)), yytype62 (yyvs.item (yyvsp - 1))) 
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


			yyval := yyval31
		end

	yy_do_action_21 is
			--|#line 298 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 298")
end

				yyval62 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval62.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_22 is
			--|#line 303 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 303")
end

				yyval62 := yytype62 (yyvs.item (yyvsp - 2))
				yyval62.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_23 is
			--|#line 308 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 308")
end

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval62 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval62
		end

	yy_do_action_24 is
			--|#line 315 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 315")
end

yyval6 := yytype31 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_25 is
			--|#line 317 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 317")
end

yyval6 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_26 is
			--|#line 319 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 319")
end

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype19 (yyvs.item (yyvsp - 1)), Void)
			
			yyval := yyval6
		end

	yy_do_action_27 is
			--|#line 323 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 323")
end

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype19 (yyvs.item (yyvsp - 2)), yytype58 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval6
		end

	yy_do_action_28 is
			--|#line 333 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 333")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_29 is
			--|#line 339 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 339")
end
			yyval := yyval_default;
				is_frozen_class := False
				is_deferred := True
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_30 is
			--|#line 346 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 346")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := True
				is_separate := False
			

		end

	yy_do_action_31 is
			--|#line 352 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 352")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := True
			

		end

	yy_do_action_32 is
			--|#line 360 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 360")
end
			yyval := yyval_default;
				is_frozen_class := False
			

		end

	yy_do_action_33 is
			--|#line 364 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 364")
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
			--|#line 375 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 375")
end
			yyval := yyval_default;
				is_external_class := False
			

		end

	yy_do_action_35 is
			--|#line 379 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 379")
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
			--|#line 394 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 394")
end


			yyval := yyval56
		end

	yy_do_action_37 is
			--|#line 396 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 396")
end

yyval56 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval56
		end

	yy_do_action_38 is
			--|#line 403 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 403")
end


			yyval := yyval70
		end

	yy_do_action_39 is
			--|#line 405 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 405")
end

				yyval70 := yytype70 (yyvs.item (yyvsp))
				if yyval70.is_empty then
					yyval70 := Void
				end
			
			yyval := yyval70
		end

	yy_do_action_40 is
			--|#line 414 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 414")
end

				yyval70 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval70, yytype28 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_41 is
			--|#line 419 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 419")
end

				yyval70 := yytype70 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval70, yytype28 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_42 is
			--|#line 426 "eiffel.y"
		local
			yyval28: FEATURE_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 426")
end

yyval28 := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) 
			yyval := yyval28
		end

	yy_do_action_43 is
			--|#line 428 "eiffel.y"
		local
			yyval28: FEATURE_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 428")
end

yyval28 := new_feature_clause_as (yytype14 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval28
		end

	yy_do_action_44 is
			--|#line 432 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 432")
end

yyval14 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval14
		end

	yy_do_action_45 is
			--|#line 432 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 432")
end
			yyval := yyval_default;
				inherit_context := False
				fclause_pos := clone (current_position)
			

		end

	yy_do_action_46 is
			--|#line 441 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 441")
end


			yyval := yyval14
		end

	yy_do_action_47 is
			--|#line 443 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 443")
end

yyval14 := new_client_as (yytype74 (yyvs.item (yyvsp))) 
			yyval := yyval14
		end

	yy_do_action_48 is
			--|#line 447 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 447")
end

				yyval74 := new_eiffel_list_id_as (1)
				yyval74.extend (new_none_id_as)
			
			yyval := yyval74
		end

	yy_do_action_49 is
			--|#line 452 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 452")
end

yyval74 := yytype74 (yyvs.item (yyvsp - 1)) 
			yyval := yyval74
		end

	yy_do_action_50 is
			--|#line 456 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 456")
end

				yyval74 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval74.extend (yytype88 (yyvs.item (yyvsp)).first)
				yytype88 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype88 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval74
		end

	yy_do_action_51 is
			--|#line 462 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 462")
end

				yyval74 := yytype74 (yyvs.item (yyvsp - 2))
				yyval74.extend (yytype88 (yyvs.item (yyvsp)).first)
				yytype88 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype88 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval74
		end

	yy_do_action_52 is
			--|#line 470 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [FEATURE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 470")
end

				yyval69 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval69.extend (yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval69
		end

	yy_do_action_53 is
			--|#line 475 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [FEATURE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 475")
end

				yyval69 := yytype69 (yyvs.item (yyvsp - 1))
				yyval69.extend (yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval69
		end

	yy_do_action_54 is
			--|#line 482 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 482")
end
			yyval := yyval_default;


		end

	yy_do_action_55 is
			--|#line 483 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 483")
end
			yyval := yyval_default;


		end

	yy_do_action_56 is
			--|#line 486 "eiffel.y"
		local
			yyval27: FEATURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 486")
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
			--|#line 499 "eiffel.y"
		local
			yyval91: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 499")
end

yyval91 := new_clickable_feature_name_list (yytype89 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval91
		end

	yy_do_action_58 is
			--|#line 501 "eiffel.y"
		local
			yyval91: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 501")
end

				yyval91 := yytype91 (yyvs.item (yyvsp - 2))
				yyval91.first.extend (yytype89 (yyvs.item (yyvsp)).first)
			
			yyval := yyval91
		end

	yy_do_action_59 is
			--|#line 508 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 508")
end

yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
		end

	yy_do_action_60 is
			--|#line 512 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 512")
end
			yyval := yyval_default;
is_frozen := False 

		end

	yy_do_action_61 is
			--|#line 514 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 514")
end
			yyval := yyval_default;
is_frozen := True 

		end

	yy_do_action_62 is
			--|#line 518 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 518")
end

yyval89 := new_clickable_feature_name (yytype88 (yyvs.item (yyvsp))) 
			yyval := yyval89
		end

	yy_do_action_63 is
			--|#line 520 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 520")
end

yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
		end

	yy_do_action_64 is
			--|#line 522 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 522")
end

yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
		end

	yy_do_action_65 is
			--|#line 526 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 526")
end

yyval89 := new_clickable_infix (yytype90 (yyvs.item (yyvsp))) 
			yyval := yyval89
		end

	yy_do_action_66 is
			--|#line 531 "eiffel.y"
		local
			yyval89: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 531")
end

yyval89 := new_clickable_prefix (yytype90 (yyvs.item (yyvsp))) 
			yyval := yyval89
		end

	yy_do_action_67 is
			--|#line 535 "eiffel.y"
		local
			yyval8: BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 535")
end

yyval8 := new_declaration_body (yytype86 (yyvs.item (yyvsp - 2)), yytype59 (yyvs.item (yyvsp - 1)), yytype15 (yyvs.item (yyvsp))) 
			yyval := yyval8
		end

	yy_do_action_68 is
			--|#line 539 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 539")
end

feature_indexes := yytype77 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_69 is
			--|#line 541 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 541")
end

yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_70 is
			--|#line 545 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 545")
end

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (yytype6 (yyvs.item (yyvsp - 1))))
				feature_indexes := yytype77 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_71 is
			--|#line 550 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 550")
end

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (new_unique_as))
				feature_indexes := yytype77 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_72 is
			--|#line 555 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 555")
end

				yyval15 := yytype54 (yyvs.item (yyvsp))
				feature_indexes := yytype77 (yyvs.item (yyvsp - 1))
			
			yyval := yyval15
		end

	yy_do_action_73 is
			--|#line 566 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 566")
end


			yyval := yyval81
		end

	yy_do_action_74 is
			--|#line 568 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 568")
end

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_75 is
			--|#line 570 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 570")
end

yyval81 := new_eiffel_list_parent_as (0) 
			yyval := yyval81
		end

	yy_do_action_76 is
			--|#line 574 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 574")
end

				yyval81 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval81.extend (yytype45 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_77 is
			--|#line 579 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 579")
end

				yyval81 := yytype81 (yyvs.item (yyvsp - 1))
				yyval81.extend (yytype45 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_78 is
			--|#line 586 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 586")
end

				yyval45 := yytype45 (yyvs.item (yyvsp))
				yytype45 (yyvs.item (yyvsp)).set_location (yytype93 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_79 is
			--|#line 591 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 591")
end

				inherit_context := False
				yyval45 := yytype45 (yyvs.item (yyvsp - 1))
				yytype45 (yyvs.item (yyvsp - 1)).set_location (yytype93 (yyvs.item (yyvsp - 2)))
			
			yyval := yyval45
		end

	yy_do_action_80 is
			--|#line 599 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 599")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 1)), yytype85 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval45
		end

	yy_do_action_81 is
			--|#line 604 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 604")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 7)), yytype85 (yyvs.item (yyvsp - 6)), yytype82 (yyvs.item (yyvsp - 5)), yytype67 (yyvs.item (yyvsp - 4)), yytype72 (yyvs.item (yyvsp - 3)), yytype72 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_82 is
			--|#line 609 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 609")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 6)), yytype85 (yyvs.item (yyvsp - 5)), Void, yytype67 (yyvs.item (yyvsp - 4)), yytype72 (yyvs.item (yyvsp - 3)), yytype72 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_83 is
			--|#line 614 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 614")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 5)), yytype85 (yyvs.item (yyvsp - 4)), Void, Void, yytype72 (yyvs.item (yyvsp - 3)), yytype72 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_84 is
			--|#line 619 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 619")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 4)), yytype85 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype72 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_85 is
			--|#line 624 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 624")
end

				inherit_context := False
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 3)), yytype85 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype72 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval45
		end

	yy_do_action_86 is
			--|#line 629 "eiffel.y"
		local
			yyval45: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 629")
end

				inherit_context := True
				real_class_end_position := current_position.end_position - 3
				yyval45 := new_parent_clause (yytype88 (yyvs.item (yyvsp - 2)), yytype85 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval45
		end

	yy_do_action_87 is
			--|#line 637 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 637")
end


			yyval := yyval82
		end

	yy_do_action_88 is
			--|#line 639 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 639")
end

yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
		end

	yy_do_action_89 is
			--|#line 643 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 643")
end

				yyval82 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval82.extend (yytype49 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_90 is
			--|#line 648 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 648")
end

				yyval82 := yytype82 (yyvs.item (yyvsp - 2))
				yyval82.extend (yytype49 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_91 is
			--|#line 655 "eiffel.y"
		local
			yyval49: RENAME_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 655")
end

yyval49 := new_rename_pair (yytype89 (yyvs.item (yyvsp - 2)), yytype89 (yyvs.item (yyvsp))) 
			yyval := yyval49
		end

	yy_do_action_92 is
			--|#line 659 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 659")
end


			yyval := yyval67
		end

	yy_do_action_93 is
			--|#line 661 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 661")
end

yyval67 := yytype67 (yyvs.item (yyvsp)) 
			yyval := yyval67
		end

	yy_do_action_94 is
			--|#line 665 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 665")
end

yyval67 := yytype67 (yyvs.item (yyvsp)) 
			yyval := yyval67
		end

	yy_do_action_95 is
			--|#line 667 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 667")
end


			yyval := yyval67
		end

	yy_do_action_96 is
			--|#line 671 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 671")
end

				yyval67 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				yyval67.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_97 is
			--|#line 676 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 676")
end

				yyval67 := yytype67 (yyvs.item (yyvsp - 1))
				yyval67.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_98 is
			--|#line 683 "eiffel.y"
		local
			yyval23: EXPORT_ITEM_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 683")
end

yyval23 := new_export_item_as (new_client_as (yytype74 (yyvs.item (yyvsp - 2))), yytype29 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_99 is
			--|#line 687 "eiffel.y"
		local
			yyval29: FEATURE_SET_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 687")
end

yyval29 := new_all_as 
			yyval := yyval29
		end

	yy_do_action_100 is
			--|#line 689 "eiffel.y"
		local
			yyval29: FEATURE_SET_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 689")
end

yyval29 := new_feature_list_as (yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval29
		end

	yy_do_action_101 is
			--|#line 693 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 693")
end


			yyval := yyval64
		end

	yy_do_action_102 is
			--|#line 695 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 695")
end

			yyval64 := yytype64 (yyvs.item (yyvsp))
		
			yyval := yyval64
		end

	yy_do_action_103 is
			--|#line 701 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 701")
end

			yyval64 := new_eiffel_list_convert (Initial_convert_list_size)
			yyval64.extend (yytype16 (yyvs.item (yyvsp)))
		
			yyval := yyval64
		end

	yy_do_action_104 is
			--|#line 706 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 706")
end

			yyval64 := yytype64 (yyvs.item (yyvsp - 2))
			yyval64.extend (yytype16 (yyvs.item (yyvsp)))
		
			yyval := yyval64
		end

	yy_do_action_105 is
			--|#line 714 "eiffel.y"
		local
			yyval16: CONVERT_FEAT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 714")
end

				-- True because this is a conversion feature used as a creation
				-- procedure in current class.
			yyval16 := new_convert_feat_as (True, yytype89 (yyvs.item (yyvsp - 5)).first, yytype85 (yyvs.item (yyvsp - 2)))
		
			yyval := yyval16
		end

	yy_do_action_106 is
			--|#line 720 "eiffel.y"
		local
			yyval16: CONVERT_FEAT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 720")
end

				-- False because this is not a conversion feature used as a creation
				-- procedure.
			yyval16 := new_convert_feat_as (False, yytype89 (yyvs.item (yyvsp - 4)).first, yytype85 (yyvs.item (yyvsp - 1)))
		
			yyval := yyval16
		end

	yy_do_action_107 is
			--|#line 728 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 728")
end

				yyval72 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval72.extend (yytype89 (yyvs.item (yyvsp)).first)
			
			yyval := yyval72
		end

	yy_do_action_108 is
			--|#line 733 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 733")
end

				yyval72 := yytype72 (yyvs.item (yyvsp - 2))
				yyval72.extend (yytype89 (yyvs.item (yyvsp)).first)
			
			yyval := yyval72
		end

	yy_do_action_109 is
			--|#line 740 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 740")
end


			yyval := yyval72
		end

	yy_do_action_110 is
			--|#line 742 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 742")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_111 is
			--|#line 746 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 746")
end


			yyval := yyval72
		end

	yy_do_action_112 is
			--|#line 748 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 748")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_113 is
			--|#line 752 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 752")
end


			yyval := yyval72
		end

	yy_do_action_114 is
			--|#line 754 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 754")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_115 is
			--|#line 758 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 758")
end


			yyval := yyval72
		end

	yy_do_action_116 is
			--|#line 760 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 760")
end

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_117 is
			--|#line 764 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 764")
end


			yyval := yyval72
		end

	yy_do_action_118 is
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

	yy_do_action_119 is
			--|#line 770 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 770")
end


			yyval := yyval72
		end

	yy_do_action_120 is
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

	yy_do_action_121 is
			--|#line 780 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 780")
end


			yyval := yyval86
		end

	yy_do_action_122 is
			--|#line 782 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 782")
end

yyval86 := yytype86 (yyvs.item (yyvsp - 1)) 
			yyval := yyval86
		end

	yy_do_action_123 is
			--|#line 786 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 786")
end


			yyval := yyval86
		end

	yy_do_action_124 is
			--|#line 788 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 788")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_125 is
			--|#line 792 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 792")
end

				yyval86 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval86.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval86
		end

	yy_do_action_126 is
			--|#line 797 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 797")
end

				yyval86 := yytype86 (yyvs.item (yyvsp - 1))
				yyval86.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval86
		end

	yy_do_action_127 is
			--|#line 804 "eiffel.y"
		local
			yyval60: TYPE_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 804")
end

yyval60 := new_type_dec_as (yytype76 (yyvs.item (yyvsp - 5)), yytype59 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 4))) 
			yyval := yyval60
		end

	yy_do_action_128 is
			--|#line 808 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 808")
end
			yyval := yyval_default;


		end

	yy_do_action_129 is
			--|#line 809 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 809")
end
			yyval := yyval_default;
				if il_parser then
						-- Trigger a syntax error.
					raise_error
				end
			

		end

	yy_do_action_130 is
			--|#line 818 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 818")
end


			yyval := yyval86
		end

	yy_do_action_131 is
			--|#line 820 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 820")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_132 is
			--|#line 824 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 824")
end

				yyval86 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval86.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval86
		end

	yy_do_action_133 is
			--|#line 829 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 829")
end

				yyval86 := yytype86 (yyvs.item (yyvsp - 1))
				yyval86.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval86
		end

	yy_do_action_134 is
			--|#line 836 "eiffel.y"
		local
			yyval60: TYPE_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 836")
end

yyval60 := new_type_dec_as (yytype76 (yyvs.item (yyvsp - 4)), yytype59 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval60
		end

	yy_do_action_135 is
			--|#line 840 "eiffel.y"
		local
			yyval76: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 840")
end

				create yyval76.make (Initial_identifier_list_size)
				Names_heap.put (yytype31 (yyvs.item (yyvsp)))
				yyval76.extend (Names_heap.found_item)
			
			yyval := yyval76
		end

	yy_do_action_136 is
			--|#line 846 "eiffel.y"
		local
			yyval76: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 846")
end

				yyval76 := yytype76 (yyvs.item (yyvsp - 2))
				Names_heap.put (yytype31 (yyvs.item (yyvsp)))
				yyval76.extend (Names_heap.found_item)
			
			yyval := yyval76
		end

	yy_do_action_137 is
			--|#line 854 "eiffel.y"
		local
			yyval76: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 854")
end

create yyval76.make (0) 
			yyval := yyval76
		end

	yy_do_action_138 is
			--|#line 856 "eiffel.y"
		local
			yyval76: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 856")
end

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_139 is
			--|#line 860 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 860")
end


			yyval := yyval59
		end

	yy_do_action_140 is
			--|#line 862 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 862")
end

yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
		end

	yy_do_action_141 is
			--|#line 866 "eiffel.y"
		local
			yyval54: ROUTINE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 866")
end

yyval54 := new_routine_as (yytype56 (yyvs.item (yyvsp - 7)), yytype50 (yyvs.item (yyvsp - 5)), yytype86 (yyvs.item (yyvsp - 4)), yytype53 (yyvs.item (yyvsp - 3)), yytype22 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp - 1)), fbody_pos, current_position) 
			yyval := yyval54
		end

	yy_do_action_142 is
			--|#line 866 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 866")
end
			yyval := yyval_default;
fbody_pos := current_position.start_position 

		end

	yy_do_action_143 is
			--|#line 878 "eiffel.y"
		local
			yyval53: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 878")
end

yyval53 := yytype38 (yyvs.item (yyvsp)) 
			yyval := yyval53
		end

	yy_do_action_144 is
			--|#line 880 "eiffel.y"
		local
			yyval53: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 880")
end

yyval53 := yytype25 (yyvs.item (yyvsp)) 
			yyval := yyval53
		end

	yy_do_action_145 is
			--|#line 882 "eiffel.y"
		local
			yyval53: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 882")
end

yyval53 := new_deferred_as 
			yyval := yyval53
		end

	yy_do_action_146 is
			--|#line 886 "eiffel.y"
		local
			yyval25: EXTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 886")
end

yyval25 := new_external_as (yytype26 (yyvs.item (yyvsp - 1)), yytype56 (yyvs.item (yyvsp))) 
			yyval := yyval25
		end

	yy_do_action_147 is
			--|#line 890 "eiffel.y"
		local
			yyval26: EXTERNAL_LANG_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 890")
end

yyval26 := new_external_lang_as (yytype56 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval26
		end

	yy_do_action_148 is
			--|#line 895 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 895")
end


			yyval := yyval56
		end

	yy_do_action_149 is
			--|#line 897 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 897")
end

yyval56 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval56
		end

	yy_do_action_150 is
			--|#line 901 "eiffel.y"
		local
			yyval38: INTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 901")
end

yyval38 := new_do_as (yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_151 is
			--|#line 903 "eiffel.y"
		local
			yyval38: INTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 903")
end

yyval38 := new_once_as (yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_152 is
			--|#line 907 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 907")
end


			yyval := yyval86
		end

	yy_do_action_153 is
			--|#line 909 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 909")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_154 is
			--|#line 913 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 913")
end


			yyval := yyval78
		end

	yy_do_action_155 is
			--|#line 915 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 915")
end

yyval78 := yytype78 (yyvs.item (yyvsp)) 
			yyval := yyval78
		end

	yy_do_action_156 is
			--|#line 919 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 919")
end

				yyval78 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval78.extend (yytype36 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_157 is
			--|#line 924 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 924")
end

				yyval78 := yytype78 (yyvs.item (yyvsp - 1))
				yyval78.extend (yytype36 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_158 is
			--|#line 931 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 931")
end

yyval36 := yytype36 (yyvs.item (yyvsp - 1)) 
			yyval := yyval36
		end

	yy_do_action_159 is
			--|#line 935 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 935")
end
			yyval := yyval_default;


		end

	yy_do_action_160 is
			--|#line 936 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 936")
end
			yyval := yyval_default;


		end

	yy_do_action_161 is
			--|#line 939 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 939")
end

yyval36 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_162 is
			--|#line 941 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 941")
end

yyval36 := yytype35 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_163 is
			--|#line 943 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 943")
end

yyval36 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_164 is
			--|#line 945 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 945")
end

yyval36 := yytype52 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_165 is
			--|#line 947 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 947")
end

yyval36 := yytype32 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_166 is
			--|#line 949 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 949")
end

yyval36 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_167 is
			--|#line 951 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 951")
end

yyval36 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_168 is
			--|#line 953 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 953")
end

yyval36 := yytype20 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_169 is
			--|#line 955 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 955")
end

yyval36 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_170 is
			--|#line 957 "eiffel.y"
		local
			yyval36: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 957")
end

yyval36 := yytype51 (yyvs.item (yyvsp)) 
			yyval := yyval36
		end

	yy_do_action_171 is
			--|#line 961 "eiffel.y"
		local
			yyval50: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 961")
end


			yyval := yyval50
		end

	yy_do_action_172 is
			--|#line 963 "eiffel.y"
		local
			yyval50: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 963")
end

				id_level := Normal_level
				yyval50 := new_require_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval50
		end

	yy_do_action_173 is
			--|#line 963 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 963")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_174 is
			--|#line 970 "eiffel.y"
		local
			yyval50: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 970")
end

				id_level := Normal_level
				yyval50 := new_require_else_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval50
		end

	yy_do_action_175 is
			--|#line 970 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 970")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_176 is
			--|#line 979 "eiffel.y"
		local
			yyval22: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 979")
end


			yyval := yyval22
		end

	yy_do_action_177 is
			--|#line 981 "eiffel.y"
		local
			yyval22: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 981")
end

				id_level := Normal_level
				yyval22 := new_ensure_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_178 is
			--|#line 981 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 981")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_179 is
			--|#line 988 "eiffel.y"
		local
			yyval22: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 988")
end

				id_level := Normal_level
				yyval22 := new_ensure_then_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval22
		end

	yy_do_action_180 is
			--|#line 988 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 988")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_181 is
			--|#line 997 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 997")
end


			yyval := yyval84
		end

	yy_do_action_182 is
			--|#line 999 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 999")
end

				yyval84 := yytype84 (yyvs.item (yyvsp))
				if yyval84.is_empty then
					yyval84 := Void
				end
			
			yyval := yyval84
		end

	yy_do_action_183 is
			--|#line 1008 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1008")
end

				yyval84 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval84, yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_184 is
			--|#line 1013 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1013")
end

				yyval84 := yytype84 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval84, yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_185 is
			--|#line 1020 "eiffel.y"
		local
			yyval57: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1020")
end

yyval57 := yytype57 (yyvs.item (yyvsp - 1)) 
			yyval := yyval57
		end

	yy_do_action_186 is
			--|#line 1024 "eiffel.y"
		local
			yyval57: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1024")
end

yyval57 := new_tagged_as (Void, yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval57
		end

	yy_do_action_187 is
			--|#line 1026 "eiffel.y"
		local
			yyval57: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1026")
end

yyval57 := new_tagged_as (yytype31 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval57
		end

	yy_do_action_188 is
			--|#line 1028 "eiffel.y"
		local
			yyval57: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1028")
end


			yyval := yyval57
		end

	yy_do_action_189 is
			--|#line 1036 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1036")
end

yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
		end

	yy_do_action_190 is
			--|#line 1038 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1038")
end

yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
		end

	yy_do_action_191 is
			--|#line 1042 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1042")
end

yyval59 := new_expanded_type (yytype88 (yyvs.item (yyvsp - 1)), yytype85 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_192 is
			--|#line 1044 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1044")
end

yyval59 := new_separate_type (yytype88 (yyvs.item (yyvsp - 1)), yytype85 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_193 is
			--|#line 1046 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1046")
end

yyval59 := new_bits_as (yytype37 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_194 is
			--|#line 1048 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1048")
end

yyval59 := new_bits_symbol_as (yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_195 is
			--|#line 1050 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1050")
end

yyval59 := new_like_id_as (yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_196 is
			--|#line 1052 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1052")
end

yyval59 := new_like_current_as 
			yyval := yyval59
		end

	yy_do_action_197 is
			--|#line 1056 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1056")
end

yyval59 := new_class_type (yytype88 (yyvs.item (yyvsp - 1)), yytype85 (yyvs.item (yyvsp))) 
			yyval := yyval59
		end

	yy_do_action_198 is
			--|#line 1060 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1060")
end


			yyval := yyval85
		end

	yy_do_action_199 is
			--|#line 1062 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1062")
end


			yyval := yyval85
		end

	yy_do_action_200 is
			--|#line 1064 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1064")
end

yyval85 := yytype85 (yyvs.item (yyvsp - 1)) 
			yyval := yyval85
		end

	yy_do_action_201 is
			--|#line 1068 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1068")
end


			yyval := yyval85
		end

	yy_do_action_202 is
			--|#line 1070 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1070")
end

yyval85 := yytype85 (yyvs.item (yyvsp - 1)) 
			yyval := yyval85
		end

	yy_do_action_203 is
			--|#line 1074 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1074")
end

				yyval85 := new_eiffel_list_type (Initial_type_list_size)
				yyval85.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval85
		end

	yy_do_action_204 is
			--|#line 1079 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1079")
end

				yyval85 := yytype85 (yyvs.item (yyvsp - 2))
				yyval85.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval85
		end

	yy_do_action_205 is
			--|#line 1090 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1090")
end

				-- $$ := Void
				formal_generics_start_position := current_position.start_position
				formal_generics_end_position := 0
			
			yyval := yyval73
		end

	yy_do_action_206 is
			--|#line 1096 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1096")
end

				yyval73 := yytype73 (yyvs.item (yyvsp - 1))
				formal_generics_start_position := yytype93 (yyvs.item (yyvsp - 3)).start_position
				formal_generics_end_position := current_position.start_position
			
			yyval := yyval73
		end

	yy_do_action_207 is
			--|#line 1104 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1104")
end


			yyval := yyval73
		end

	yy_do_action_208 is
			--|#line 1106 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1106")
end

yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
		end

	yy_do_action_209 is
			--|#line 1110 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1110")
end

				yyval73 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval73.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval73
		end

	yy_do_action_210 is
			--|#line 1115 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1115")
end

				yyval73 := yytype73 (yyvs.item (yyvsp - 2))
				yyval73.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval73
		end

	yy_do_action_211 is
			--|#line 1122 "eiffel.y"
		local
			yyval30: FORMAL_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1122")
end

				check formal_exists: not formal_parameters.is_empty end
				yyval30 := new_formal_dec_as (formal_parameters.last, yytype92 (yyvs.item (yyvsp)).first, yytype92 (yyvs.item (yyvsp)).second, formal_parameters.count)
			
			yyval := yyval30
		end

	yy_do_action_212 is
			--|#line 1122 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1122")
end
			yyval := yyval_default;
formal_parameters.extend (create {ID_AS}.initialize (token_buffer)) 

		end

	yy_do_action_213 is
			--|#line 1132 "eiffel.y"
		local
			yyval92: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1132")
end

create yyval92 
			yyval := yyval92
		end

	yy_do_action_214 is
			--|#line 1134 "eiffel.y"
		local
			yyval92: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1134")
end

				create yyval92
				yyval92.set_first (yytype59 (yyvs.item (yyvsp - 1)))
				yyval92.set_second (yytype72 (yyvs.item (yyvsp)))
			
			yyval := yyval92
		end

	yy_do_action_215 is
			--|#line 1142 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1142")
end


			yyval := yyval72
		end

	yy_do_action_216 is
			--|#line 1144 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1144")
end

yyval72 := yytype72 (yyvs.item (yyvsp - 1)) 
			yyval := yyval72
		end

	yy_do_action_217 is
			--|#line 1152 "eiffel.y"
		local
			yyval32: IF_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1152")
end

				yyval32 := new_if_as (yytype24 (yyvs.item (yyvsp - 5)), yytype78 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 7)), current_position)
			
			yyval := yyval32
		end

	yy_do_action_218 is
			--|#line 1158 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1158")
end


			yyval := yyval66
		end

	yy_do_action_219 is
			--|#line 1160 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1160")
end

yyval66 := yytype66 (yyvs.item (yyvsp)) 
			yyval := yyval66
		end

	yy_do_action_220 is
			--|#line 1164 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1164")
end

				yyval66 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval66.extend (yytype21 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_221 is
			--|#line 1169 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1169")
end

				yyval66 := yytype66 (yyvs.item (yyvsp - 1))
				yyval66.extend (yytype21 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_222 is
			--|#line 1176 "eiffel.y"
		local
			yyval21: ELSIF_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1176")
end

yyval21 := new_elseif_as (yytype24 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 4))) 
			yyval := yyval21
		end

	yy_do_action_223 is
			--|#line 1180 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1180")
end


			yyval := yyval78
		end

	yy_do_action_224 is
			--|#line 1182 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1182")
end

yyval78 := yytype78 (yyvs.item (yyvsp)) 
			yyval := yyval78
		end

	yy_do_action_225 is
			--|#line 1186 "eiffel.y"
		local
			yyval34: INSPECT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1186")
end

				yyval34 := new_inspect_as (yytype24 (yyvs.item (yyvsp - 3)), yytype63 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval34
		end

	yy_do_action_226 is
			--|#line 1192 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1192")
end


			yyval := yyval63
		end

	yy_do_action_227 is
			--|#line 1194 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1194")
end

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_228 is
			--|#line 1198 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1198")
end

				yyval63 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval63.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_229 is
			--|#line 1203 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1203")
end

				yyval63 := yytype63 (yyvs.item (yyvsp - 1))
				yyval63.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_230 is
			--|#line 1210 "eiffel.y"
		local
			yyval11: CASE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1210")
end

yyval11 := new_case_as (yytype79 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval11
		end

	yy_do_action_231 is
			--|#line 1214 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INTERVAL_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1214")
end

				yyval79 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval79.extend (yytype39 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_232 is
			--|#line 1219 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [INTERVAL_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1219")
end

				yyval79 := yytype79 (yyvs.item (yyvsp - 2))
				yyval79.extend (yytype39 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_233 is
			--|#line 1226 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1226")
end

yyval39 := new_interval_as (yytype37 (yyvs.item (yyvsp)), Void) 
			yyval := yyval39
		end

	yy_do_action_234 is
			--|#line 1228 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1228")
end

yyval39 := new_interval_as (yytype37 (yyvs.item (yyvsp - 2)), yytype37 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_235 is
			--|#line 1230 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1230")
end

yyval39 := new_interval_as (yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval39
		end

	yy_do_action_236 is
			--|#line 1232 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1232")
end

yyval39 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_237 is
			--|#line 1234 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1234")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp)), Void) 
			yyval := yyval39
		end

	yy_do_action_238 is
			--|#line 1236 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1236")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_239 is
			--|#line 1238 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1238")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp - 2)), yytype37 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_240 is
			--|#line 1240 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1240")
end

yyval39 := new_interval_as (yytype37 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_241 is
			--|#line 1242 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1242")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_242 is
			--|#line 1244 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1244")
end

yyval39 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_243 is
			--|#line 1246 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1246")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp)), Void) 
			yyval := yyval39
		end

	yy_do_action_244 is
			--|#line 1248 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1248")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_245 is
			--|#line 1250 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1250")
end

yyval39 := new_interval_as (yytype31 (yyvs.item (yyvsp - 2)), yytype47 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_246 is
			--|#line 1252 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1252")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp - 2)), yytype47 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_247 is
			--|#line 1254 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1254")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp - 2)), yytype37 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_248 is
			--|#line 1256 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1256")
end

yyval39 := new_interval_as (yytype37 (yyvs.item (yyvsp - 2)), yytype47 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_249 is
			--|#line 1258 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1258")
end

yyval39 := new_interval_as (yytype47 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_250 is
			--|#line 1260 "eiffel.y"
		local
			yyval39: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1260")
end

yyval39 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype47 (yyvs.item (yyvsp))) 
			yyval := yyval39
		end

	yy_do_action_251 is
			--|#line 1265 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1265")
end


			yyval := yyval78
		end

	yy_do_action_252 is
			--|#line 1267 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1267")
end

				yyval78 := yytype78 (yyvs.item (yyvsp))
				if yyval78 = Void then
					yyval78 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval78
		end

	yy_do_action_253 is
			--|#line 1276 "eiffel.y"
		local
			yyval41: LOOP_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1276")
end

				yyval41 := new_loop_as (yytype78 (yyvs.item (yyvsp - 8)), yytype84 (yyvs.item (yyvsp - 7)), yytype61 (yyvs.item (yyvsp - 6)), yytype24 (yyvs.item (yyvsp - 3)), yytype78 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval41
		end

	yy_do_action_254 is
			--|#line 1282 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1282")
end


			yyval := yyval84
		end

	yy_do_action_255 is
			--|#line 1284 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1284")
end

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_256 is
			--|#line 1288 "eiffel.y"
		local
			yyval40: INVARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1288")
end


			yyval := yyval40
		end

	yy_do_action_257 is
			--|#line 1290 "eiffel.y"
		local
			yyval40: INVARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1290")
end

				id_level := Normal_level
				inherit_context := False
				yyval40 := new_invariant_as (yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval40
		end

	yy_do_action_258 is
			--|#line 1290 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1290")
end
			yyval := yyval_default;
id_level := Invariant_level 

		end

	yy_do_action_259 is
			--|#line 1300 "eiffel.y"
		local
			yyval61: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1300")
end


			yyval := yyval61
		end

	yy_do_action_260 is
			--|#line 1302 "eiffel.y"
		local
			yyval61: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1302")
end

yyval61 := new_variant_as (yytype31 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval61
		end

	yy_do_action_261 is
			--|#line 1304 "eiffel.y"
		local
			yyval61: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1304")
end

yyval61 := new_variant_as (Void, yytype24 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval61
		end

	yy_do_action_262 is
			--|#line 1308 "eiffel.y"
		local
			yyval20: DEBUG_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1308")
end

				yyval20 := new_debug_as (yytype83 (yyvs.item (yyvsp - 2)), yytype78 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval20
		end

	yy_do_action_263 is
			--|#line 1314 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1314")
end


			yyval := yyval83
		end

	yy_do_action_264 is
			--|#line 1316 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1316")
end


			yyval := yyval83
		end

	yy_do_action_265 is
			--|#line 1318 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1318")
end

yyval83 := yytype83 (yyvs.item (yyvsp - 1)) 
			yyval := yyval83
		end

	yy_do_action_266 is
			--|#line 1322 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1322")
end

				yyval83 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval83.extend (yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_267 is
			--|#line 1327 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1327")
end

				yyval83 := yytype83 (yyvs.item (yyvsp - 2))
				yyval83.extend (yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_268 is
			--|#line 1334 "eiffel.y"
		local
			yyval51: RETRY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1334")
end

yyval51 := new_retry_as (current_position) 
			yyval := yyval51
		end

	yy_do_action_269 is
			--|#line 1338 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1338")
end


			yyval := yyval78
		end

	yy_do_action_270 is
			--|#line 1340 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1340")
end

				yyval78 := yytype78 (yyvs.item (yyvsp))
				if yyval78 = Void then
					yyval78 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval78
		end

	yy_do_action_271 is
			--|#line 1349 "eiffel.y"
		local
			yyval5: ASSIGN_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1349")
end

yyval5 := new_assign_as (new_access_id_as (yytype31 (yyvs.item (yyvsp - 2)), Void), yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_272 is
			--|#line 1351 "eiffel.y"
		local
			yyval5: ASSIGN_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1351")
end

yyval5 := new_assign_as (new_result_as, yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_273 is
			--|#line 1355 "eiffel.y"
		local
			yyval52: REVERSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1355")
end

yyval52 := new_reverse_as (new_access_id_as (yytype31 (yyvs.item (yyvsp - 2)), Void), yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval52
		end

	yy_do_action_274 is
			--|#line 1357 "eiffel.y"
		local
			yyval52: REVERSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1357")
end

yyval52 := new_reverse_as (new_result_as, yytype24 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval52
		end

	yy_do_action_275 is
			--|#line 1361 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1361")
end


			yyval := yyval65
		end

	yy_do_action_276 is
			--|#line 1363 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1363")
end

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_277 is
			--|#line 1367 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1367")
end

				yyval65 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval65.extend (yytype17 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_278 is
			--|#line 1372 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1372")
end

				yyval65 := yytype65 (yyvs.item (yyvsp - 1))
				yyval65.extend (yytype17 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_279 is
			--|#line 1379 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1379")
end

				inherit_context := False
				yyval17 := new_create_as (Void, Void)
			
			yyval := yyval17
		end

	yy_do_action_280 is
			--|#line 1385 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1385")
end

				inherit_context := False
				yyval17 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp)))
			
			yyval := yyval17
		end

	yy_do_action_281 is
			--|#line 1390 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1390")
end

				inherit_context := False
				yyval17 := new_create_as (new_client_as (yytype74 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval17
		end

	yy_do_action_282 is
			--|#line 1395 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1395")
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

	yy_do_action_283 is
			--|#line 1405 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1405")
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

	yy_do_action_284 is
			--|#line 1415 "eiffel.y"
		local
			yyval17: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1415")
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

	yy_do_action_285 is
			--|#line 1427 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1427")
end

yyval55 := new_routine_creation_as (new_result_operand_as, yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_286 is
			--|#line 1430 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1430")
end

yyval55 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_287 is
			--|#line 1432 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1432")
end

yyval55 := new_routine_creation_as (new_operand_as (Void, yytype31 (yyvs.item (yyvsp - 3)), Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_288 is
			--|#line 1434 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1434")
end

yyval55 := new_routine_creation_as (new_operand_as (Void, Void, yytype24 (yyvs.item (yyvsp - 4))), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_289 is
			--|#line 1436 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1436")
end

yyval55 := new_routine_creation_as (new_operand_as (yytype59 (yyvs.item (yyvsp - 4)), Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_290 is
			--|#line 1438 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1438")
end

yyval55 := new_routine_creation_as (Void, yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_291 is
			--|#line 1440 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1440")
end

yyval55 := new_unqualified_routine_creation_as (new_operand_as (Void, Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval55
		end

	yy_do_action_292 is
			--|#line 1442 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1442")
end

			yyval55 := new_routine_creation_as (new_result_operand_as, yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_293 is
			--|#line 1451 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1451")
end

			yyval55 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_294 is
			--|#line 1460 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1460")
end

			yyval55 := new_routine_creation_as (new_operand_as (Void, yytype31 (yyvs.item (yyvsp - 4)), Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
			
		
			yyval := yyval55
		end

	yy_do_action_295 is
			--|#line 1470 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1470")
end

			yyval55 := new_routine_creation_As (new_operand_as (Void, Void, yytype24 (yyvs.item (yyvsp - 5))), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_296 is
			--|#line 1479 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1479")
end

			yyval55 := new_routine_creation_as (new_operand_as (yytype59 (yyvs.item (yyvsp - 4)), Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_297 is
			--|#line 1488 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1488")
end

			yyval55 := new_routine_creation_as (Void, yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_298 is
			--|#line 1497 "eiffel.y"
		local
			yyval55: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1497")
end

			yyval55 := new_unqualified_routine_creation_as (new_operand_as (Void, Void, Void), yytype31 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 2)).start_position,
					yytype93 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval55
		end

	yy_do_action_299 is
			--|#line 1508 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1508")
end


			yyval := yyval80
		end

	yy_do_action_300 is
			--|#line 1510 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1510")
end

yyval80 := yytype80 (yyvs.item (yyvsp - 1)) 
			yyval := yyval80
		end

	yy_do_action_301 is
			--|#line 1514 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1514")
end

				yyval80 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval80.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_302 is
			--|#line 1519 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1519")
end

				yyval80 := yytype80 (yyvs.item (yyvsp - 2))
				yyval80.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_303 is
			--|#line 1526 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1526")
end

yyval44 := new_operand_as (Void, Void, Void) 
			yyval := yyval44
		end

	yy_do_action_304 is
			--|#line 1532 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1532")
end

yyval44 := new_operand_as (new_class_type (yytype88 (yyvs.item (yyvsp - 1)), Void), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_305 is
			--|#line 1534 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1534")
end

yyval44 := new_operand_as (new_class_type (yytype88 (yyvs.item (yyvsp - 2)), yytype85 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_306 is
			--|#line 1536 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1536")
end

yyval44 := new_operand_as (new_expanded_type (yytype88 (yyvs.item (yyvsp - 2)), yytype85 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_307 is
			--|#line 1538 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1538")
end

yyval44 := new_operand_as (new_separate_type (yytype88 (yyvs.item (yyvsp - 2)), yytype85 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_308 is
			--|#line 1540 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1540")
end

yyval44 := new_operand_as (new_bits_as (yytype37 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_309 is
			--|#line 1542 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1542")
end

yyval44 := new_operand_as (new_bits_symbol_as (yytype31 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_310 is
			--|#line 1544 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1544")
end

yyval44 := new_operand_as (new_like_id_as (yytype31 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval44
		end

	yy_do_action_311 is
			--|#line 1546 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1546")
end

yyval44 := new_operand_as (new_like_current_as, Void, Void) 
			yyval := yyval44
		end

	yy_do_action_312 is
			--|#line 1548 "eiffel.y"
		local
			yyval44: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1548")
end

yyval44 := new_operand_as (Void, Void, yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval44
		end

	yy_do_action_313 is
			--|#line 1552 "eiffel.y"
		local
			yyval18: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1552")
end

				yyval18 := new_creation_as (yytype59 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 5)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 5)).start_position,
						yytype93 (yyvs.item (yyvsp - 5)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval18
		end

	yy_do_action_314 is
			--|#line 1561 "eiffel.y"
		local
			yyval18: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1561")
end

yyval18 := new_creation_as (Void, yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 3))) 
			yyval := yyval18
		end

	yy_do_action_315 is
			--|#line 1563 "eiffel.y"
		local
			yyval18: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1563")
end

yyval18 := new_creation_as (yytype59 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 6))) 
			yyval := yyval18
		end

	yy_do_action_316 is
			--|#line 1567 "eiffel.y"
		local
			yyval19: CREATION_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1567")
end

yyval19 := new_creation_expr_as (yytype59 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval19
		end

	yy_do_action_317 is
			--|#line 1569 "eiffel.y"
		local
			yyval19: CREATION_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1569")
end

				yyval19 := new_creation_expr_as (yytype59 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype93 (yyvs.item (yyvsp - 1)).start_position,
						yytype93 (yyvs.item (yyvsp - 1)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval19
		end

	yy_do_action_318 is
			--|#line 1580 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1580")
end


			yyval := yyval59
		end

	yy_do_action_319 is
			--|#line 1582 "eiffel.y"
		local
			yyval59: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1582")
end

yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
		end

	yy_do_action_320 is
			--|#line 1586 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1586")
end

yyval1 := new_access_id_as (yytype31 (yyvs.item (yyvsp)), Void) 
			yyval := yyval1
		end

	yy_do_action_321 is
			--|#line 1588 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1588")
end

yyval1 := new_result_as 
			yyval := yyval1
		end

	yy_do_action_322 is
			--|#line 1592 "eiffel.y"
		local
			yyval3: ACCESS_INV_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1592")
end


			yyval := yyval3
		end

	yy_do_action_323 is
			--|#line 1594 "eiffel.y"
		local
			yyval3: ACCESS_INV_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1594")
end

yyval3 := new_access_inv_as (yytype31 (yyvs.item (yyvsp - 1)), yytype68 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_324 is
			--|#line 1602 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1602")
end

yyval35 := new_instr_call_as (yytype1 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_325 is
			--|#line 1604 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1604")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_326 is
			--|#line 1606 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1606")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_327 is
			--|#line 1608 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1608")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_328 is
			--|#line 1610 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1610")
end

yyval35 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_329 is
			--|#line 1612 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1612")
end

yyval35 := new_instr_call_as (yytype46 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_330 is
			--|#line 1614 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1614")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_331 is
			--|#line 1616 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1616")
end

yyval35 := new_instr_call_as (yytype47 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_332 is
			--|#line 1618 "eiffel.y"
		local
			yyval35: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1618")
end

yyval35 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 1))) 
			yyval := yyval35
		end

	yy_do_action_333 is
			--|#line 1622 "eiffel.y"
		local
			yyval13: CHECK_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1622")
end

yyval13 := new_check_as (yytype84 (yyvs.item (yyvsp - 1)), yytype93 (yyvs.item (yyvsp - 3)), current_position) 
			yyval := yyval13
		end

	yy_do_action_334 is
			--|#line 1630 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1630")
end

create {VALUE_AS} yyval24.initialize (yytype6 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_335 is
			--|#line 1632 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1632")
end

create {VALUE_AS} yyval24.initialize (yytype4 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_336 is
			--|#line 1634 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1634")
end

create {VALUE_AS} yyval24.initialize (yytype58 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_337 is
			--|#line 1636 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1636")
end

yyval24 := new_expr_call_as (yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_338 is
			--|#line 1638 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1638")
end

yyval24 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval24
		end

	yy_do_action_339 is
			--|#line 1640 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1640")
end

yyval24 := new_paran_as (yytype24 (yyvs.item (yyvsp - 1))) 
			yyval := yyval24
		end

	yy_do_action_340 is
			--|#line 1642 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1642")
end

yyval24 := new_bin_plus_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_341 is
			--|#line 1644 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1644")
end

yyval24 := new_bin_minus_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_342 is
			--|#line 1646 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1646")
end

yyval24 := new_bin_star_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_343 is
			--|#line 1648 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1648")
end

yyval24 := new_bin_slash_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_344 is
			--|#line 1650 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1650")
end

yyval24 := new_bin_mod_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_345 is
			--|#line 1652 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1652")
end

yyval24 := new_bin_div_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_346 is
			--|#line 1654 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1654")
end

yyval24 := new_bin_power_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_347 is
			--|#line 1656 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1656")
end

yyval24 := new_bin_and_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_348 is
			--|#line 1658 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1658")
end

yyval24 := new_bin_and_then_as (yytype24 (yyvs.item (yyvsp - 3)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_349 is
			--|#line 1660 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1660")
end

yyval24 := new_bin_or_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_350 is
			--|#line 1662 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1662")
end

yyval24 := new_bin_or_else_as (yytype24 (yyvs.item (yyvsp - 3)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_351 is
			--|#line 1664 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1664")
end

yyval24 := new_bin_implies_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_352 is
			--|#line 1666 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1666")
end

yyval24 := new_bin_xor_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_353 is
			--|#line 1668 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1668")
end

yyval24 := new_bin_ge_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_354 is
			--|#line 1670 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1670")
end

yyval24 := new_bin_gt_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_355 is
			--|#line 1672 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1672")
end

yyval24 := new_bin_le_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_356 is
			--|#line 1674 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1674")
end

yyval24 := new_bin_lt_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_357 is
			--|#line 1676 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1676")
end

yyval24 := new_bin_eq_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_358 is
			--|#line 1678 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1678")
end

yyval24 := new_bin_ne_as (yytype24 (yyvs.item (yyvsp - 2)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_359 is
			--|#line 1680 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1680")
end

yyval24 := new_bin_free_as (yytype24 (yyvs.item (yyvsp - 2)), yytype31 (yyvs.item (yyvsp - 1)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_360 is
			--|#line 1682 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1682")
end

yyval24 := new_un_minus_as (yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_361 is
			--|#line 1684 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1684")
end

yyval24 := new_un_plus_as (yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_362 is
			--|#line 1686 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1686")
end

yyval24 := new_un_not_as (yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_363 is
			--|#line 1688 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1688")
end

yyval24 := new_un_old_as (yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_364 is
			--|#line 1690 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1690")
end

yyval24 := new_un_free_as (yytype31 (yyvs.item (yyvsp - 1)), yytype24 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_365 is
			--|#line 1692 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1692")
end

yyval24 := new_un_strip_as (yytype76 (yyvs.item (yyvsp - 1))) 
			yyval := yyval24
		end

	yy_do_action_366 is
			--|#line 1694 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1694")
end

yyval24 := new_address_as (yytype89 (yyvs.item (yyvsp)).first) 
			yyval := yyval24
		end

	yy_do_action_367 is
			--|#line 1696 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1696")
end

yyval24 := new_expr_address_as (yytype24 (yyvs.item (yyvsp - 1))) 
			yyval := yyval24
		end

	yy_do_action_368 is
			--|#line 1698 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1698")
end

yyval24 := new_address_current_as 
			yyval := yyval24
		end

	yy_do_action_369 is
			--|#line 1700 "eiffel.y"
		local
			yyval24: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1700")
end

yyval24 := new_address_result_as 
			yyval := yyval24
		end

	yy_do_action_370 is
			--|#line 1704 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1704")
end

create yyval31.initialize (token_buffer) 
			yyval := yyval31
		end

	yy_do_action_371 is
			--|#line 1712 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1712")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_372 is
			--|#line 1714 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1714")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_373 is
			--|#line 1716 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1716")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_374 is
			--|#line 1718 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1718")
end

yyval10 := new_current_as 
			yyval := yyval10
		end

	yy_do_action_375 is
			--|#line 1720 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1720")
end

yyval10 := new_result_as 
			yyval := yyval10
		end

	yy_do_action_376 is
			--|#line 1722 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1722")
end

yyval10 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_377 is
			--|#line 1724 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1724")
end

yyval10 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_378 is
			--|#line 1726 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1726")
end

yyval10 := yytype46 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_379 is
			--|#line 1728 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1728")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_380 is
			--|#line 1730 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1730")
end

yyval10 := yytype47 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_381 is
			--|#line 1732 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1732")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_382 is
			--|#line 1734 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1734")
end

yyval10 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_383 is
			--|#line 1738 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1738")
end

yyval42 := new_nested_as (new_current_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_384 is
			--|#line 1742 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1742")
end

yyval42 := new_nested_as (new_result_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_385 is
			--|#line 1746 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1746")
end

yyval42 := new_nested_as (yytype1 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_386 is
			--|#line 1750 "eiffel.y"
		local
			yyval43: NESTED_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1750")
end

yyval43 := new_nested_expr_as (yytype24 (yyvs.item (yyvsp - 3)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval43
		end

	yy_do_action_387 is
			--|#line 1754 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1754")
end

yyval42 := new_nested_as (yytype46 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_388 is
			--|#line 1758 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1758")
end

yyval46 := new_precursor_as (Void, yytype68 (yyvs.item (yyvsp))) 
			yyval := yyval46
		end

	yy_do_action_389 is
			--|#line 1760 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1760")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 2)), yytype68 (yyvs.item (yyvsp)), Void) 
			yyval := yyval46
		end

	yy_do_action_390 is
			--|#line 1762 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1762")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 5)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_391 is
			--|#line 1764 "eiffel.y"
		local
			yyval46: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1764")
end

yyval46 := new_precursor (yytype88 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp)), yytype93 (yyvs.item (yyvsp - 2))) 
			yyval := yyval46
		end

	yy_do_action_392 is
			--|#line 1768 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1768")
end

yyval42 := new_nested_as (yytype47 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_393 is
			--|#line 1772 "eiffel.y"
		local
			yyval47: STATIC_ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1772")
end

				yyval47 := new_static_access_as (yytype59 (yyvs.item (yyvsp - 4)), yytype31 (yyvs.item (yyvsp - 1)), yytype68 (yyvs.item (yyvsp)));
			
			yyval := yyval47
		end

	yy_do_action_394 is
			--|#line 1779 "eiffel.y"
		local
			yyval47: STATIC_ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1779")
end

				yyval47 := new_static_access_as (yytype59 (yyvs.item (yyvsp - 3)), yytype31 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval47
		end

	yy_do_action_395 is
			--|#line 1787 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1787")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_396 is
			--|#line 1789 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1789")
end

yyval10 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_397 is
			--|#line 1793 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1793")
end

yyval42 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_398 is
			--|#line 1795 "eiffel.y"
		local
			yyval42: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1795")
end

yyval42 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype42 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_399 is
			--|#line 1799 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1799")
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

	yy_do_action_400 is
			--|#line 1812 "eiffel.y"
		local
			yyval2: ACCESS_FEAT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1812")
end

yyval2 := new_access_feat_as (yytype31 (yyvs.item (yyvsp - 1)), yytype68 (yyvs.item (yyvsp))) 
			yyval := yyval2
		end

	yy_do_action_401 is
			--|#line 1816 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1816")
end


			yyval := yyval68
		end

	yy_do_action_402 is
			--|#line 1818 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1818")
end


			yyval := yyval68
		end

	yy_do_action_403 is
			--|#line 1820 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1820")
end

yyval68 := yytype68 (yyvs.item (yyvsp - 1)) 
			yyval := yyval68
		end

	yy_do_action_404 is
			--|#line 1824 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1824")
end

				yyval68 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval68.extend (yytype24 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_405 is
			--|#line 1829 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1829")
end

				yyval68 := yytype68 (yyvs.item (yyvsp - 2))
				yyval68.extend (yytype24 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_406 is
			--|#line 1836 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1836")
end

yyval68 := new_eiffel_list_expr_as (0) 
			yyval := yyval68
		end

	yy_do_action_407 is
			--|#line 1838 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1838")
end

yyval68 := yytype68 (yyvs.item (yyvsp)) 
			yyval := yyval68
		end

	yy_do_action_408 is
			--|#line 1842 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1842")
end

				yyval68 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval68.extend (yytype24 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_409 is
			--|#line 1847 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1847")
end

				yyval68 := yytype68 (yyvs.item (yyvsp - 2))
				yyval68.extend (yytype24 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_410 is
			--|#line 1858 "eiffel.y"
		local
			yyval31: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1858")
end

create yyval31.initialize (token_buffer) 
			yyval := yyval31
		end

	yy_do_action_411 is
			--|#line 1862 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1862")
end

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_412 is
			--|#line 1864 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1864")
end

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_413 is
			--|#line 1866 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1866")
end

yyval6 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_414 is
			--|#line 1868 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1868")
end

yyval6 := yytype48 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_415 is
			--|#line 1870 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1870")
end

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_416 is
			--|#line 1872 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1872")
end

yyval6 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_417 is
			--|#line 1876 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1876")
end

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_418 is
			--|#line 1878 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1878")
end

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_419 is
			--|#line 1880 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1880")
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

	yy_do_action_420 is
			--|#line 1895 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1895")
end

yyval6 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval6
		end

	yy_do_action_421 is
			--|#line 1897 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1897")
end

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_422 is
			--|#line 1899 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1899")
end

yyval6 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_423 is
			--|#line 1903 "eiffel.y"
		local
			yyval9: BOOL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1903")
end

yyval9 := new_boolean_as (False) 
			yyval := yyval9
		end

	yy_do_action_424 is
			--|#line 1905 "eiffel.y"
		local
			yyval9: BOOL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1905")
end

yyval9 := new_boolean_as (True) 
			yyval := yyval9
		end

	yy_do_action_425 is
			--|#line 1909 "eiffel.y"
		local
			yyval12: CHAR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1909")
end

				check is_character: not token_buffer.is_empty end
				yyval12 := new_character_as (token_buffer.item (1))
			
			yyval := yyval12
		end

	yy_do_action_426 is
			--|#line 1916 "eiffel.y"
		local
			yyval37: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1916")
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

	yy_do_action_427 is
			--|#line 1931 "eiffel.y"
		local
			yyval37: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1931")
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
			--|#line 1946 "eiffel.y"
		local
			yyval37: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1946")
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

	yy_do_action_429 is
			--|#line 1964 "eiffel.y"
		local
			yyval48: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1964")
end

yyval48 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval48
		end

	yy_do_action_430 is
			--|#line 1966 "eiffel.y"
		local
			yyval48: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1966")
end

yyval48 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval48
		end

	yy_do_action_431 is
			--|#line 1968 "eiffel.y"
		local
			yyval48: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1968")
end

				token_buffer.precede ('-')
				yyval48 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval48
		end

	yy_do_action_432 is
			--|#line 1975 "eiffel.y"
		local
			yyval7: BIT_CONST_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1975")
end

yyval7 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval7
		end

	yy_do_action_433 is
			--|#line 1979 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1979")
end

yyval56 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval56
		end

	yy_do_action_434 is
			--|#line 1981 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1981")
end

yyval56 := new_empty_string_as 
			yyval := yyval56
		end

	yy_do_action_435 is
			--|#line 1983 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1983")
end

yyval56 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval56
		end

	yy_do_action_436 is
			--|#line 1987 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1987")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_437 is
			--|#line 1989 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1989")
end

yyval56 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval56
		end

	yy_do_action_438 is
			--|#line 1991 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1991")
end

yyval56 := new_lt_string_as 
			yyval := yyval56
		end

	yy_do_action_439 is
			--|#line 1993 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1993")
end

yyval56 := new_le_string_as 
			yyval := yyval56
		end

	yy_do_action_440 is
			--|#line 1995 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1995")
end

yyval56 := new_gt_string_as 
			yyval := yyval56
		end

	yy_do_action_441 is
			--|#line 1997 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1997")
end

yyval56 := new_ge_string_as 
			yyval := yyval56
		end

	yy_do_action_442 is
			--|#line 1999 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1999")
end

yyval56 := new_minus_string_as 
			yyval := yyval56
		end

	yy_do_action_443 is
			--|#line 2001 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2001")
end

yyval56 := new_plus_string_as 
			yyval := yyval56
		end

	yy_do_action_444 is
			--|#line 2003 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2003")
end

yyval56 := new_star_string_as 
			yyval := yyval56
		end

	yy_do_action_445 is
			--|#line 2005 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2005")
end

yyval56 := new_slash_string_as 
			yyval := yyval56
		end

	yy_do_action_446 is
			--|#line 2007 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2007")
end

yyval56 := new_mod_string_as 
			yyval := yyval56
		end

	yy_do_action_447 is
			--|#line 2009 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2009")
end

yyval56 := new_div_string_as 
			yyval := yyval56
		end

	yy_do_action_448 is
			--|#line 2011 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2011")
end

yyval56 := new_power_string_as 
			yyval := yyval56
		end

	yy_do_action_449 is
			--|#line 2013 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2013")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_450 is
			--|#line 2015 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2015")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_451 is
			--|#line 2017 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2017")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_452 is
			--|#line 2019 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2019")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_453 is
			--|#line 2021 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2021")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_454 is
			--|#line 2023 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2023")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_455 is
			--|#line 2025 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2025")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_456 is
			--|#line 2027 "eiffel.y"
		local
			yyval56: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2027")
end

yyval56 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval56
		end

	yy_do_action_457 is
			--|#line 2031 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2031")
end

yyval90 := new_clickable_string (new_minus_string_as) 
			yyval := yyval90
		end

	yy_do_action_458 is
			--|#line 2033 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2033")
end

yyval90 := new_clickable_string (new_plus_string_as) 
			yyval := yyval90
		end

	yy_do_action_459 is
			--|#line 2035 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2035")
end

yyval90 := new_clickable_string (new_not_string_as) 
			yyval := yyval90
		end

	yy_do_action_460 is
			--|#line 2037 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2037")
end

yyval90 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval90
		end

	yy_do_action_461 is
			--|#line 2041 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2041")
end

yyval90 := new_clickable_string (new_lt_string_as) 
			yyval := yyval90
		end

	yy_do_action_462 is
			--|#line 2043 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2043")
end

yyval90 := new_clickable_string (new_le_string_as) 
			yyval := yyval90
		end

	yy_do_action_463 is
			--|#line 2045 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2045")
end

yyval90 := new_clickable_string (new_gt_string_as) 
			yyval := yyval90
		end

	yy_do_action_464 is
			--|#line 2047 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2047")
end

yyval90 := new_clickable_string (new_ge_string_as) 
			yyval := yyval90
		end

	yy_do_action_465 is
			--|#line 2049 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2049")
end

yyval90 := new_clickable_string (new_minus_string_as) 
			yyval := yyval90
		end

	yy_do_action_466 is
			--|#line 2051 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2051")
end

yyval90 := new_clickable_string (new_plus_string_as) 
			yyval := yyval90
		end

	yy_do_action_467 is
			--|#line 2053 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2053")
end

yyval90 := new_clickable_string (new_star_string_as) 
			yyval := yyval90
		end

	yy_do_action_468 is
			--|#line 2055 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2055")
end

yyval90 := new_clickable_string (new_slash_string_as) 
			yyval := yyval90
		end

	yy_do_action_469 is
			--|#line 2057 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2057")
end

yyval90 := new_clickable_string (new_mod_string_as) 
			yyval := yyval90
		end

	yy_do_action_470 is
			--|#line 2059 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2059")
end

yyval90 := new_clickable_string (new_div_string_as) 
			yyval := yyval90
		end

	yy_do_action_471 is
			--|#line 2061 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2061")
end

yyval90 := new_clickable_string (new_power_string_as) 
			yyval := yyval90
		end

	yy_do_action_472 is
			--|#line 2063 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2063")
end

yyval90 := new_clickable_string (new_and_string_as) 
			yyval := yyval90
		end

	yy_do_action_473 is
			--|#line 2065 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2065")
end

yyval90 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval90
		end

	yy_do_action_474 is
			--|#line 2067 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2067")
end

yyval90 := new_clickable_string (new_implies_string_as) 
			yyval := yyval90
		end

	yy_do_action_475 is
			--|#line 2069 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2069")
end

yyval90 := new_clickable_string (new_or_string_as) 
			yyval := yyval90
		end

	yy_do_action_476 is
			--|#line 2071 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2071")
end

yyval90 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval90
		end

	yy_do_action_477 is
			--|#line 2073 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2073")
end

yyval90 := new_clickable_string (new_xor_string_as) 
			yyval := yyval90
		end

	yy_do_action_478 is
			--|#line 2075 "eiffel.y"
		local
			yyval90: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2075")
end

yyval90 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval90
		end

	yy_do_action_479 is
			--|#line 2079 "eiffel.y"
		local
			yyval4: ARRAY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2079")
end

yyval4 := new_array_as (yytype68 (yyvs.item (yyvsp - 1))) 
			yyval := yyval4
		end

	yy_do_action_480 is
			--|#line 2083 "eiffel.y"
		local
			yyval58: TUPLE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2083")
end

yyval58 := new_tuple_as (yytype68 (yyvs.item (yyvsp - 1))) 
			yyval := yyval58
		end

	yy_do_action_481 is
			--|#line 2087 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2087")
end
			yyval := yyval_default;


		end

	yy_do_action_482 is
			--|#line 2091 "eiffel.y"
		local
			yyval93: TOKEN_LOCATION
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2091")
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

			  161,  217,  217,  216,  216,  148,  148,  232,  232,  234,
			  234,  233,  233,  236,  236,  235,  235,  238,  238,  237,
			  237,  271,  271,  272,  272,  273,  273,  210,  298,  298,
			  275,  275,  276,  276,  211,  245,  245,  246,  246,  206,
			  206,  196,  299,  195,  195,  195,  157,  158,  200,  200,
			  173,  173,  274,  274,  252,  252,  253,  253,  170,  296,
			  296,  171,  171,  171,  171,  171,  171,  171,  171,  171,
			  171,  192,  192,  301,  192,  302,  154,  154,  303,  154,
			  304,  265,  265,  266,  266,  202,  203,  203,  203,  205,
			  205,  209,  209,  209,  209,  209,  209,  207,  269,  269,

			  269,  268,  268,  270,  270,  240,  240,  241,  241,  242,
			  242,  162,  305,  286,  286,  239,  239,  166,  220,  220,
			  221,  221,  153,  254,  254,  168,  214,  214,  215,  215,
			  141,  256,  256,  174,  174,  174,  174,  174,  174,  174,
			  174,  174,  174,  174,  174,  174,  174,  174,  174,  174,
			  174,  255,  255,  176,  267,  267,  175,  175,  306,  212,
			  212,  212,  152,  263,  263,  263,  264,  264,  193,  251,
			  251,  132,  132,  194,  194,  218,  218,  219,  219,  149,
			  149,  149,  149,  149,  149,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  257,

			  257,  258,  258,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  150,  150,  150,  151,  151,  208,  208,
			  127,  127,  130,  130,  169,  169,  169,  169,  169,  169,
			  169,  169,  169,  143,  156,  156,  156,  156,  156,  156,
			  156,  156,  156,  156,  156,  156,  156,  156,  156,  156,
			  156,  156,  156,  156,  156,  156,  156,  156,  156,  156,
			  156,  156,  156,  156,  156,  156,  156,  156,  156,  156,
			  165,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  181,  180,  179,  183,  178,  187,  187,
			  187,  187,  182,  188,  189,  139,  139,  177,  177,  128,

			  129,  225,  225,  225,  226,  226,  227,  227,  228,  228,
			  163,  134,  134,  134,  134,  134,  134,  135,  135,  135,
			  135,  135,  135,  138,  138,  142,  172,  172,  172,  190,
			  190,  190,  136,  199,  199,  199,  201,  201,  201,  201,
			  201,  201,  201,  201,  201,  201,  201,  201,  201,  201,
			  201,  201,  201,  201,  201,  201,  201,  284,  284,  284,
			  284,  283,  283,  283,  283,  283,  283,  283,  283,  283,
			  283,  283,  283,  283,  283,  283,  283,  283,  283,  131,
			  204,  300,  287>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,    1,    2,   17,    1,    1,    1,    0,    2,    1,
			    0,    2,    1,    0,    3,    2,    1,    2,    3,    2,
			    0,    1,    3,    1,    1,    1,    2,    3,    2,    2,
			    3,    3,    0,    1,    0,    1,    0,    2,    0,    1,
			    1,    2,    1,    2,    3,    0,    0,    1,    2,    3,
			    1,    3,    1,    2,    0,    1,    3,    1,    3,    2,
			    0,    1,    1,    1,    1,    2,    2,    3,    1,    2,
			    2,    2,    2,    0,    2,    2,    1,    2,    2,    3,
			    2,    8,    7,    6,    5,    4,    3,    1,    2,    1,
			    3,    3,    0,    1,    2,    2,    1,    2,    3,    1,

			    1,    0,    2,    1,    3,    6,    5,    1,    3,    0,
			    1,    1,    2,    0,    1,    1,    2,    0,    1,    1,
			    2,    0,    3,    0,    1,    1,    2,    6,    0,    3,
			    0,    1,    1,    2,    5,    1,    3,    0,    1,    0,
			    2,    8,    0,    1,    1,    1,    3,    2,    0,    2,
			    2,    2,    0,    2,    1,    2,    1,    2,    3,    0,
			    2,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    0,    3,    0,    4,    0,    0,    3,    0,    4,
			    0,    0,    1,    1,    2,    3,    2,    4,    3,    1,
			    1,    3,    3,    2,    2,    2,    2,    2,    0,    2,

			    3,    2,    3,    1,    3,    0,    4,    0,    1,    1,
			    3,    3,    0,    0,    3,    0,    3,    8,    0,    1,
			    1,    2,    5,    0,    2,    6,    0,    1,    1,    2,
			    5,    1,    3,    1,    3,    1,    3,    1,    3,    3,
			    3,    3,    3,    1,    3,    3,    3,    3,    3,    3,
			    3,    0,    2,   10,    0,    2,    0,    3,    0,    0,
			    4,    2,    5,    0,    2,    3,    1,    3,    1,    0,
			    2,    4,    4,    4,    4,    0,    1,    1,    2,    1,
			    3,    2,    2,    4,    3,    5,    5,    5,    7,    7,
			    5,    3,    5,    5,    5,    7,    6,    5,    4,    0,

			    3,    1,    3,    1,    3,    4,    5,    5,    4,    4,
			    4,    4,    1,    6,    4,    7,    6,    5,    0,    1,
			    1,    1,    0,    3,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    4,    1,    1,    1,    1,    1,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    4,    3,
			    4,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    2,    2,    2,    2,    2,    4,    2,    4,    2,    2,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    3,    3,    3,    5,    3,    2,    5,
			    8,    6,    3,    7,    6,    1,    1,    3,    3,    2,

			    2,    0,    2,    3,    1,    3,    0,    1,    1,    3,
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
			    7,   20,  410,    0,   32,    1,    0,    0,   16,   20,
			    0,    0,    0,    0,    6,    2,  189,  190,  198,   33,
			   34,    0,   34,   19,  456,  455,  454,  453,  452,  451,
			  450,  449,  448,  447,  446,  445,  444,  443,  442,  441,
			  440,  439,  438,  435,  437,  434,  424,  423,    0,   23,
			    0,  432,  436,  429,  425,  426,    0,    0,   21,   25,
			  415,  411,  412,    0,   24,  413,  414,  416,  433,   54,
			   17,  198,    5,  196,  195,  198,    0,    0,  194,  193,
			    0,  197,   35,   29,    0,   34,   34,   28,    0,    0,
			  431,  428,  430,  427,   26,  406,    0,    0,   55,   18,

			  192,  191,  199,  203,    0,  482,   31,   30,    0,  482,
			    0,  375,    0,  401,    0,  374,    0,    0,  406,  482,
			  420,  419,    0,    0,    0,    0,  370,    0,    0,  376,
			  335,  334,  421,  417,  337,  418,  382,  408,  401,    0,
			  379,  373,  372,  371,  381,  377,  378,  380,  338,  422,
			  336,    0,  407,   27,   22,  200,    0,  148,    0,  482,
			  322,  482,  482,    0,    0,    0,    0,    0,    0,  299,
			    0,    0,  388,    0,  482,    0,  369,    0,    0,  368,
			    0,   62,   63,   64,  366,    0,    0,  198,    0,    0,
			    0,  363,  137,  362,  360,  361,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  482,  399,  364,    0,    0,
			  480,    0,  204,    0,   36,  207,  322,    0,  317,    0,
			    0,  396,  384,  401,  395,    0,    0,    0,    0,    0,
			    0,    0,  291,    0,  402,  404,    0,    0,    0,  383,
			  460,  459,  458,  457,   66,  478,  477,  476,  475,  474,
			  473,  472,  471,  470,  469,  468,  467,  466,  465,  464,
			  463,  462,  461,   65,    0,    0,  482,  482,  479,  299,
			  339,  135,  138,    0,  385,  346,  345,  344,  343,  342,
			  341,  340,  353,  355,  354,  356,  357,  358,    0,  347,

			  352,    0,  349,  351,  359,    0,  387,  392,  409,  149,
			    0,   73,  212,  209,    0,  208,  316,  401,  299,  299,
			    0,  400,  299,  299,  299,    0,    0,  303,    0,  312,
			  301,    0,  299,  401,  403,    0,    0,  299,  367,    0,
			    0,    0,  298,  482,    0,    0,  365,  348,  350,  299,
			   37,  482,  482,  213,  206,    0,  323,  297,  292,  397,
			  398,  290,  285,  286,    0,    0,    0,    0,    0,    0,
			  198,  300,    0,  287,  389,  405,    0,  293,  482,  299,
			  401,    0,  386,  136,  294,   76,  482,    0,   75,  482,
			    0,  211,  210,  299,  299,  198,  196,  195,  198,  194,

			  193,    0,  482,    0,  302,  401,    0,  296,  391,  299,
			   77,   78,  198,  279,  277,  101,  482,    0,  215,  289,
			  288,  192,  311,  310,  191,  309,  308,  201,    0,  305,
			  393,  401,  295,   79,   80,    0,    0,  281,    0,   38,
			  278,  282,    0,  214,  307,  306,  202,  390,  111,  119,
			   87,  115,   54,   86,  109,  113,  117,    0,   92,   48,
			    0,   50,  280,  107,  103,  102,    0,   45,   60,   40,
			  482,   39,    0,  284,    0,  112,  120,   89,   88,    0,
			  116,   96,   94,    0,   95,  110,  113,  114,  117,  118,
			    0,   85,   93,  109,   49,    0,    0,    0,    0,    0,

			   46,   61,   52,   60,   57,  121,    0,  256,   41,  283,
			  216,    0,    0,   97,   99,   54,  100,  117,    0,   84,
			  113,   51,  108,  104,    0,    0,   44,   47,   53,   60,
			  123,  159,  139,   59,  258,  482,   90,   91,   98,    0,
			   83,  117,    0,    0,   58,  125,  482,    0,  124,   56,
			    0,   13,  481,    7,   82,    0,  106,    0,    0,  122,
			  126,  160,  140,   10,   20,   67,   68,  183,  257,  481,
			  482,    0,   81,  105,  128,   13,   20,   13,   69,   36,
			   15,   20,  184,   54,    0,    4,    3,    0,    0,   71,
			   20,   70,   72,  142,   14,  185,  186,  401,    0,   54,

			  171,  188,  129,  127,  173,  152,  187,  175,  481,  130,
			    0,  481,  172,  132,  482,  153,  131,  159,  482,  159,
			  145,  144,  143,  176,  174,    0,  133,  151,  481,  148,
			    0,  150,  178,  269,    0,  156,  481,  482,  146,  147,
			  180,  481,  159,    0,   54,  157,  268,  482,  159,  163,
			  169,  161,  168,  165,  166,  162,  159,  167,  170,  164,
			    0,  481,  177,  270,  141,  134,    0,  254,  158,    0,
			    0,  263,    0,  481,    0,    0,  318,    0,  324,  401,
			  330,  326,  325,  327,  332,  328,  329,  331,  179,  226,
			  481,  259,    0,    0,    0,    0,  159,    0,    0,  321,

			    0,  322,  320,  319,    0,    0,    0,    0,  482,  228,
			  251,  227,  255,    0,    0,  272,  274,  159,  264,  266,
			    0,    0,  333,    0,  314,    0,    0,  271,  273,    0,
			  159,    0,  229,  261,  401,  482,  482,  265,    0,  262,
			    0,  322,    0,  235,  237,  233,  231,  243,    0,  252,
			  225,    0,    0,  220,  223,  482,    0,  267,  322,  313,
			    0,    0,    0,    0,    0,  159,    0,  260,    0,  159,
			    0,  221,    0,  315,    0,  236,  242,  250,  241,  238,
			  239,  245,  240,  234,  248,  249,  244,  247,  246,  230,
			  232,  159,  224,  217,    0,    0,    0,  159,    0,  253,

			  222,  394,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  701,  129,  231,  228,  130,  649,   58,   59,  131,  132,
			  531,  133,  232,  134,  709,  135,  650,  436,  468,  565,
			  578,  464,  414,  651,  136,  652,  753,  633,  481,  137,
			  621,  629,  502,  469,  515,  313,  138,    7,  139,  653,
			    8,  654,  655,  635,  656,   65,  622,  746,  535,  657,
			  234,  140,  141,  142,  143,  144,  145,  330,  385,  411,
			  146,  147,  747,   66,  477,  605,  658,  659,  623,  592,
			  148,  311,  149,  224,   68,  567,  583,  150,  103,  551,
			   16,  704,   17,  545,  613,  714,   69,  710,  711,  465,
			  439,  415,  416,  754,  755,  454,  493,  482,  216,  246,

			  151,  152,  503,  470,  471,  462,  485,  486,  487,  488,
			  489,  490,  443,  157,  314,  315,  483,  460,  546,  283,
			    4,    9,  579,  566,  643,  627,  636,  770,  731,  748,
			  242,  331,  352,  386,  458,  478,  696,  720,  568,  569,
			  691,  403,   81,  104,  532,  547,  548,  610,  615,  616,
			  181,   72,  182,  183,  463,  504,  273,  254,  505,  391,
			  341,  802,    5,   21,  586,   99,   22,   83,  500,  628,
			  506,  588,  600,  570,  608,  611,  641,  661,  353,  552>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    4,  400, -32768,  298,  133, -32768,  731, 1516, -32768,  198,
			  424,  164,  424,  323, -32768, -32768, -32768, -32768,  654, -32768,
			  695,  709,  146, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  714, -32768,
			  298, -32768, -32768, -32768, -32768, -32768,  324,  264, -32768, -32768,
			 -32768, -32768, -32768,   -8, -32768, -32768, -32768, -32768, -32768,  299,
			 -32768,  654, -32768, -32768, -32768,  654,  730,  727, -32768, -32768,
			  267, -32768, -32768, -32768,  424,  695,  695, -32768,  298,  723,
			 -32768, -32768, -32768, -32768, -32768, 1360,  691, 1629, -32768, -32768,

			 -32768, -32768, -32768, -32768,  343,  536, -32768, -32768,  707, -32768,
			  684,  421,   17,  119,  703,  374,   49,  171, 1360, -32768,
			 -32768, -32768, 1360, 1360,  721, 1360, -32768, 1360, 1360,  530,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, 1884,  126, 1360,
			 -32768, -32768, -32768, -32768, -32768, -32768,  529,  527, -32768, -32768,
			 -32768,  701,  706, -32768, -32768, -32768,  298,  548,  700, -32768,
			  438, -32768, -32768,  157,  720,  719,  717,  298, 1360,  493,
			  424, 1171, -32768,  424, -32768,  157, -32768,  189, 1760, -32768,
			 1360, -32768, -32768, -32768, -32768,  424,  627,  463,  697,  157,
			 1842, -32768,  157, -32768, -32768, -32768,  157, 1360, 1360, 1360,

			 1360, 1360, 1360, 1360, 1360, 1360, 1360, 1360, 1360, 1360,
			 1024, 1360,  907, 1360, 1360, -32768, -32768, -32768,  157,  157,
			 -32768, 1360, -32768, 1494,  512,  683,  438,  157, -32768,  157,
			  157,  686, -32768,  650, -32768,  157,  157,  157,  692, 1822,
			 1473,  157, -32768,  690, -32768, 1884,  457,  688,  157, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, 1800,  685, -32768, -32768, -32768,  678,
			  308, -32768,  546,  689, -32768,  485,  485,  485,  485,  485,
			  676,  676,  664,  664,  664,  664,  664,  664, 1360,  971,

			 1916, 1360, 1686, 1901, -32768,  157, -32768, -32768, 1884, -32768,
			 1047,  653, -32768, -32768,  677,  687, -32768,  650,  678,  678,
			  157, -32768,  678,  678,  678,  699,  698,  684,   78, 1884,
			 -32768,  444,  678,  650, -32768, 1360,  696,  678, -32768,  673,
			  157,  633, -32768, -32768,  157,  157, -32768,  971, 1686,  678,
			 -32768,  462, -32768,  667, -32768,  683, -32768, -32768, -32768,  686,
			 -32768, -32768, -32768, -32768,  157,  157,  424,    2,  424,  323,
			  443, -32768, 1473, -32768, -32768, 1884,  157, -32768, -32768,  678,
			  650,  157, -32768, -32768, -32768, -32768,  582,  424, -32768,  593,
			  424, -32768, -32768,  678,  678,  654,  665,  662,  654,  661,

			  660,    3,  432,  659, -32768,  650,  619, -32768, -32768,  678,
			 -32768,  666,  654,  367, -32768,  640,  592,  658,  657, -32768,
			 -32768,  643, -32768, -32768,  639, -32768, -32768,  584,  335, -32768,
			 -32768,  650, -32768, -32768,  484,  218,   43,   50,   43,  602,
			 -32768,  367,   43, -32768, -32768, -32768,  583, -32768,   43,   43,
			   43,   43,  272, -32768,  567,  543,  541,  608,  601, -32768,
			  429, -32768,  599, -32768, -32768,  629,  302, -32768,  533, -32768,
			 -32768,  602,   43,   50,   -2,  599,  599, -32768,  614,  607,
			  599, -32768,  598,   39, -32768, -32768,  543, -32768,  541, -32768,
			  579, -32768, -32768,  567, -32768,  424,   43,   43,  604,  600,

			  598, -32768, -32768,  336, -32768,  206,   43,  564, -32768,  599,
			 -32768,   43,   43, -32768, -32768,  535,  599,  541,  572, -32768,
			  543, -32768, -32768, -32768,  298,  298, -32768, -32768, -32768,  556,
			  157, -32768,  589, -32768, -32768, -32768, -32768, -32768, -32768,  561,
			 -32768,  541,  398,  310, -32768, -32768,  546,  581,  157,  524,
			  298,  217,  178,  547, -32768,  553, -32768,  569,  571, -32768,
			 -32768, -32768, -32768, 1657,   47, -32768, -32768, -32768, -32768,  555,
			 -32768,  539, -32768, -32768,  550,  522,  431,  522, -32768,  512,
			 -32768,   12, -32768,  535, 1360, -32768, -32768,  157,  298, -32768,
			  228, -32768, -32768, -32768, -32768, -32768, 1884,  352,  545,  535,

			  502, 1360, -32768, -32768,  537,  506, 1884, -32768,  158,  157,
			   81,  158, -32768, -32768,  546, -32768,  157, -32768, -32768, -32768,
			 -32768, -32768, -32768,  518, -32768,  544, -32768, -32768,  295,  548,
			 1494, -32768,  483,  477,  298, -32768,  386,  -24, -32768, -32768,
			 -32768,  -32, -32768,  501,  535, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  152,  -32, -32768, -32768, -32768, -32768, 1360,  492,  524,  147,
			 1360,  534,  532,  490,  271,   55,  298, 1360,  530,  130,
			 -32768, -32768, -32768, -32768, -32768, -32768,  529,  527, -32768,  268,
			  -45,  445, 1360, 1360, 1706, 1192, -32768,  470,  488, -32768,

			  298,  438, -32768, -32768,  496, 1780, 1360, 1360, -32768, -32768,
			  465,  425, -32768, 1360,  434, 1884, 1884, -32768, -32768, -32768,
			  214,  459, -32768,  473, -32768,   28,  489, 1884, 1884,  140,
			 -32768,  442, -32768, 1884,  347, -32768,   94, -32768, 1494, -32768,
			   28,  438,  454,  480,  478,  472, -32768,  468,  -12, -32768,
			 -32768, 1360, 1360, -32768,  403,   70,  389, -32768,  438, -32768,
			  424,  120,  140,  427,  140, -32768,  140, 1884,  772, -32768,
			  348, -32768, 1360, -32768,  277, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, 1316,  368,  159, -32768,  157, -32768,

			 -32768, -32768,   73,   33, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -683,  186,  525, -209, -32768, -32768,  747,  278, -32768,    5,
			 -32768,   -1, -150, -32768,  131,    7, -32768, -419, -32768, -32768,
			 -32768,  342,  420, -32768,   25, -32768,   83, -32768,  353,  672,
			 -32768, -32768,  330,  363, -32768,  475,    0, -32768,  132, -32768,
			   10, -32768, -32768,  193, -32768,  -11, -32768,   58, -32768, -32768,
			  497,  168,  167,  165,  163,  162,  160,  446,  433, -32768,
			  156,  155, -219, -32768,  303, -32768, -32768, -32768, -32768, -32768,
			 -32768,  234,   -4,  181, -200,  240, -32768,  745,    1, -32768,
			 -168, -32768, -32768,  258,  185, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  349, -32768, -32768,  -84, -32768,

			  694, -32768, -32768, -32768, -32768,   75,  371,  309,  369, -353,
			  362, -307, -32768, -32768, -32768, -32768, -392, -32768, -172, -32768,
			  221, -314, -32768, -167, -32768, -589, -32768, -32768, -32768, -32768,
			 -232, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -567, -32768,
			 -32768, -32768,  -44, -385, -32768, -32768, -32768, -32768, -32768, -32768,
			   14,   15, -32768, -32768, -108,  243, -32768, -32768, -32768, -32768,
			   96, -32768, -32768, -32768, -32768, -336, -32768,   44, -32768, -521,
			 -32768, -32768, -32768, -329, -32768, -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    3,    6,   79,   67,   15,  247,   61,   64,  184,    6,
			  549,   74,   60,   78,   62,  388,  428,  316,   18,   70,
			  282,  437,  472,  309,   71,  249,   75,  100,  766,  172,
			  631,  101,   63,  804, -181,    2,   14,    2,  496,   13,
			   95,  612,  741,  168,  624,    2,  284,  342,  648,  473,
			    2,   89,  427,  663,  647, -181, -181,  758,   94,  667,
			 -181,    2,  396,  167,  510,   18,   87,  514,  306,  307,
			  646,   12,   14,  803,  662,  180,   14,  166,  594,    1,
			    2,  526,   14,  -47,   11,  765,  357,  358,    2,  108,
			  361,  362,  363,   67,  688,   18,   61,   64,  105,   10,

			  373,  700,   60,   18,   62,  377,  697,  721,  527,  179,
			  165,   14,  169,  580,  369,  178,  484,  384,  186,  178,
			  164,  699,   63,  712,  185,  178,  -47,  177,  736,  106,
			  107,  177,  187,  517, -219,  668, -219,  177,  -47,  542,
			  543,  749,  176,  620,  619,  171,  368,  407,  699,  321,
			   54,  618,  171,    2,   77,   76,  171,  222, -218,  367,
			 -218,  419,  420,  233,  215,  170,  617,  541,  238,   55,
			   54,   18,  163,    2,  366,  233,  789,  432,  677,  538,
			  792,  518,   18,  707,  243,    2,  706,  676,   18,  279,
			    2,  742,  281,  675,  382,   20,  233,    2,  674,  275,

			  693,  158,  796,  692,   14,  160,   19,   13,  800,  673,
			  539,  742,  672,  671,   86,  189,   82,  185,  233,  233,
			 -181, -181,  418,  114,   73,  799,  670,  317, -181,  318,
			  319,    2,  530,  356,  555,  322,  323,  324,  113,   12,
			 -181,  332,   85, -181, -181,  669,  529,  595,  337,  374,
			  581,   14,   11, -181,  738,  226,   -8,  229,  230,  737,
			   -8,    2,  590,  603,   -8,  459,   -8,   10,   -8,  214,
			  248,   -8,  213,  212,  211,  210,  209,  208,  207,  206,
			  205,  204,  203,  202,  201,  200,  199,  198,  197,  126,
			  -11,  -11,  564,   93,   -8,   92,  408,  563,  -11,  637,

			   14,  253,  252,   13,   14,  349,  350,  637,  665,   98,
			  -11,  305,  -11,  -11,  251,  250,  102,  185,  435,  -11,
			  233,  430,  214,  214,  795,  214,  214,  214,  499,  186,
			  466,   14,  561,  344,   13,   12,   98,   77,   76,   97,
			  379,  498,  479,  370,  233,  383,  343,  447,   11,  214,
			  156,  421,   55,   91,  424,   90,    2,  557,  400, -154,
			 -154, -154, -154,   10,  393,  394,   12,  397,  434,  399,
			  708,  214,  340,  171, -154,  156,  405,  214,  171,   11,
			  395,  409,  398,  156,  446,  215,  751, -154,  522,  466,
			  215,  601,  155,  798,   10, -154, -154, -154,  533,  175,

			  -46,  412,  -43,  479,  537,   18,  214,  -43,  589,  501,
			  591,  -43,  174,  435,  793,  -43,   18,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  639,  214,  214,    2,  214,  214,  214,  614,  156,  381,
			  214,   77,   76,  -46,  614,  556,  163,  387,  389,  461,
			 -155, -155, -155, -155,  772,  -46,   55,   14,   -9,  162,
			    2,  214,   -9,  227,    2, -155,   -9,  769,   -9,  495,
			   -9,  764, -304,   -9,  406,  763,  494, -304, -155,  214,
			  214,  762,  387,  761,  372,  417, -155, -155, -155,  371,
			  402,  401,  724,  -12,  -12,  719,   -9,  335,  742,   98,

			  760,  -12,  334,  -54,  -54,  197,  126,  214,  750,  521,
			  277,   80,  417,  -12,  344,  -12,  -12,  474,  241,  240,
			  740,  -54,  -12,  475,  476,  739,  480,  708,  -54,  730,
			  281,  725,  759,  -54,  735,  277,  722,  -54,  757,   18,
			   18,  -54,  777,  781,  784,  788,  713,  509,  281,  773,
			  453,  562,  219,  452,  218,  196, -181,  175,  516,   67,
			  695,  561,   61, -205,    6,   18,  507,  664,   60,  642,
			   62,  690,   98,  451,  450,  223,    6, -205, -205,  449,
			  640,    6,  448,  634,  597,  632,  345,  598,  609,  599,
			    6,   70,  774,  604,  602, -205,  310,  564,  587,  -42,

			   70,  607, -205,   18,  -42,  585,  501, -205,  -42,  281,
			  574, -205,  -42, -205,  573, -205,  281, -182, -182,  572,
			 -205, -182,    1,  -74,  -74, -182,  559,  554,  550,  501,
			 -182,  553,  451,  413,  413,  644,  449, -182,  540,  496,
			 -182,  -74,  558,  534,  435,  519,  525, -182,  -74,   18,
			  524, -276, -275,  -74,  511, -182, -182,  -74, -276, -275,
			  679,  -74,  512, -276, -275,  448,  584, -276, -275,  497,
			  452, -276, -275,  467,  491,  702,  171,  703,  203,  202,
			  201,  200,  199,  198,  197,  126,  445, -200, -199,  698,
			  444,   18,  201,  200,  199,  198,  197,  126,  442,  438,

			  441,  723,   80,  433,  240,  431,  429,  426,  425,  423,
			  625,  320,  422,  734,  630,   18,  312,  390,  745,  380,
			  378,  376,  161,  365,  364,  702,  354,  355,  214,  744,
			  351,  276,  339,  660,  346,  336,  743,  333,  214,  325,
			  702,  278,  237,  666,  236,  235,  221,  192,  225,  173,
			  220,  780,  783,  787,  159,  745,   93,  153,  109,   91,
			   88,  776,  779,  782,  786,   82,  744,   84,  775,  778,
			   23,  785,  544,  743,  571,   18,  213,  212,  211,  210,
			  209,  208,  207,  206,  205,  204,  203,  202,  201,  200,
			  199,  198,  197,  126,  190,  191,  457,  193,  801,  194,

			  195,  626,  520,  456,  729,  455,  560,  492,   96,  582,
			  638,  217,  188,  593,  536,  687,  686,  360,  404,  410,
			  685,  214,  684,  683,  790,  682,  214,  681,  680,  645,
			  392,  752,  756,  528,  508,  513,  440,  214,  771,  523,
			  239,  577,  732,  245,  154,  359,  678,  214,  214,    0,
			    0,  756,  274,    0,    0,  791,    0,    0,    0,  214,
			  214,    0,    0,    0,    0,  214,    0,    0,    0,  285,
			  286,  287,  288,  289,  290,  291,  292,  293,  294,  295,
			  296,  297,  299,  300,  302,  303,  304,    0,    0,    0,
			    0,    0,    0,  308,    0,    0,    0,    0,    0,  214,

			  214,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  329,    0,    0,    0,    0,    0,    0,    0,
			    0,  128,  127,    0,    0,    0,  214,    0,  126,  125,
			  124,  123,    0,  122,    0,    0,  121,   54,  120,   52,
			    2,   51,   50,    0,    0,  119,    0,    0,   48,    0,
			  118,    0,    0,  117,    0,   95,    0,    0,   47,   46,
			    0,  116,    0,    0,    0,    0,    0,  115,    0,    0,
			  347,  301,    0,  348,    0,    0,    0,    0,  114,  209,
			  208,  207,  206,  205,  204,  203,  202,  201,  200,  199,
			  198,  197,  126,  113,  112,    0,    0,    0,    0,    0,

			  111,    0,    0,    0,    0,    0,    0,  375,    0,    0,
			  110,    0,   45,   44,   43,   42,   41,   40,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,    0,    0,    0,    0,  128,  127,
			    0,    0,    0,    0,  329,  126,  125,  124,  123,    0,
			  122,    0,    0,  121,   54,  120,   52,    2,   51,   50,
			    0,    0,  119,    0,    0,   48,    0,  118,    0,    0,
			  117,    0,   95,    0,    0,   47,   46,    0,  116,   52,
			    0,    0,    0,    0,  115,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  114,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  113,  112,    0,    0,    0,    0,    0,  111,    0,    0,
			    0,  298,    0,    0,    0,    0,    0,  110,    0,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,    0,   45,   44,   43,   42,   41,   40,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  128,  127,    0,    0,    0,
			    0,    0,  126,  125,  124,  123,    0,  122,    0,    0,

			  121,   54,  120,   52,    2,   51,   50,    0,    0,  119,
			    0,    0,   48,    0,  118,    0,  244,  117,    0,   95,
			    0,    0,   47,   46,   52,  116,    0,    0,    0,    0,
			    0,  115,    0,    0,    0,    0,    0,  718,    0,    0,
			    0,    0,  114,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  596,  113,  112,    0,
			    0,    0,    0,    0,  111,    0,    0,    0,    0,    0,
			    0,    0,    0,  606,  110,    0,   45,   44,   43,   42,
			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   44,    0,

			   42,   41,   40,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,    0,
			  213,  212,  211,  210,  209,  208,  207,  206,  205,  204,
			  203,  202,  201,  200,  199,  198,  197,  126,  689,    0,
			    0,    0,  694,    0,    0,    0,    0,    0,    0,  705,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  715,  716,    0,    0,    0,    0,
			    0,    0,    0,    0,  128,  127,    0,    0,  727,  728,
			    0,  126,  125,  124,  123,  733,  122,    0,    0,  121,
			   54,  120,   52,    2,   51,   50,    0,    0,  119,    0,

			    0,   48,    0,  118,    0,    0,  117,    0,   95,    0,
			    0,   47,   46,  797,  116,    0,    0,    0,    0,    0,
			  115,    0,    0,  767,  768,    0,    0,    0,    0,    0,
			    0,  114,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  794,    0,  113,  112,    0,    0,
			    0,    0,    0,  111,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  110,    0,   45,   44,   43,   42,   41,
			   40,   39,   38,   37,   36,   35,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,  128,  127,    0,
			    0,    0,    0,    0,  126,  125,  124,  123,    0,  122,

			    0,    0,  121,   54,  120,   52,    2,   51,   50,    0,
			    0,  119,    0,    0,   48,    0,  118,    0,    0,  328,
			    0,   95,    0,    0,   47,   46,   52,  116,    0,    0,
			   57,   56,    0,  115,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  114,   55,   54,   53,   52,    2,
			   51,   50,    0,   49,    0,    0,    0,   48,    0,  113,
			  112,    0,    0,    0,    0,    0,  111,   47,   46,    0,
			    0,    0,    0,    0,    0,    0,  327,    0,   45,   44,
			   43,   42,   41,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,

			   44,    0,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   45,   44,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   57,   56,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   55,   54,
			   53,   52,    2,   51,   50,    0,    0,    0,    0,    0,
			   48,   57,   56,    0,    0,    0,    0,    0,    0,    0,
			   47,   46,    0,    0,    0,    0,   55,   54,   53,   52,
			    0,   51,  211,  210,  209,  208,  207,  206,  205,  204,

			  203,  202,  201,  200,  199,  198,  197,  126,   47,   46,
			  213,  212,  211,  210,  209,  208,  207,  206,  205,  204,
			  203,  202,  201,  200,  199,  198,  197,  126,    0,    0,
			    0,    0,  576,    0,   45,   44,   43,   42,   41,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,  575,    0,    0,    0,
			    0,    0,   45,   44,   43,   42,   41,   40,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,  213,  212,  211,  210,  209,  208,
			  207,  206,  205,  204,  203,  202,  201,  200,  199,  198,

			  197,  126,    0,  717,  213,  212,  211,  210,  209,  208,
			  207,  206,  205,  204,  203,  202,  201,  200,  199,  198,
			  197,  126,    0,    0,    0,  726,  213,  212,  211,  210,
			  209,  208,  207,  206,  205,  204,  203,  202,  201,  200,
			  199,  198,  197,  126,    0,  338,  213,  212,  211,  210,
			  209,  208,  207,  206,  205,  204,  203,  202,  201,  200,
			  199,  198,  197,  126,    0,    0,    0,  326,  272,  271,
			  270,  269,  268,  267,  266,  265,  264,  263,  262,  261,
			  260,  259,  258,  257,  256,    0,  255,  280,  213,  212,
			  211,  210,  209,  208,  207,  206,  205,  204,  203,  202,

			  201,  200,  199,  198,  197,  126,  212,  211,  210,  209,
			  208,  207,  206,  205,  204,  203,  202,  201,  200,  199,
			  198,  197,  126,  210,  209,  208,  207,  206,  205,  204,
			  203,  202,  201,  200,  199,  198,  197,  126>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,    1,   13,    7,    3,  173,    7,    7,  116,    9,
			  531,   11,    7,   13,    7,  351,  401,  226,    3,    9,
			  192,  413,  441,  223,   10,  175,   12,   71,   40,  113,
			  619,   75,    7,    0,   66,   33,   33,   33,   40,   36,
			   48,  608,  725,   26,  611,   33,  196,  279,   72,  441,
			   33,   50,   49,  642,   78,  100,  101,  740,   66,  648,
			   92,   33,   60,   46,   66,   50,   22,   28,  218,  219,
			   94,   68,   33,    0,  641,   26,   33,   60,   66,   75,
			   33,  500,   33,   33,   81,   97,  318,  319,   33,   88,
			  322,  323,  324,   97,  661,   80,   97,   97,   84,   96,

			  332,   46,   97,   88,   97,  337,  673,  696,  500,   60,
			   93,   33,  112,   66,   36,   76,  452,  349,  117,   76,
			  103,   93,   97,  690,   46,   76,   76,   88,  717,   85,
			   86,   88,  117,  486,   64,  656,   66,   88,   88,  524,
			  525,  730,   93,   62,   63,   26,   68,  379,   93,  233,
			   30,   70,   26,   33,   14,   15,   26,  156,   64,   81,
			   66,  393,  394,  163,   38,   46,   85,  520,  167,   29,
			   30,  156,   25,   33,   96,  175,  765,  409,   26,  515,
			  769,  488,  167,   53,  170,   33,   56,   35,  173,  189,
			   33,   71,  192,   41,  344,   62,  196,   33,   46,  185,

			   53,  105,  791,   56,   33,  109,   73,   36,  797,   57,
			  517,   71,   60,   61,   68,  119,   70,   46,  218,  219,
			   62,   63,  390,   71,   60,   66,   74,  227,   70,  229,
			  230,   33,   26,  317,  541,  235,  236,  237,   86,   68,
			   82,  241,   96,   85,   66,   93,   40,  583,  248,  333,
			  564,   33,   81,   75,   40,  159,   58,  161,  162,   45,
			   62,   33,  576,  599,   66,   47,   68,   96,   70,  137,
			  174,   73,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   62,   63,   75,   29,   96,   31,  380,   80,   70,  628,

			   33,  112,  113,   36,   33,  305,  310,  636,  644,   37,
			   82,  215,   84,   85,  125,  126,   49,   46,   46,   91,
			  320,  405,  190,  191,   47,  193,  194,  195,   26,  328,
			  438,   33,   37,   25,   36,   68,   37,   14,   15,   40,
			  340,   39,  450,  328,  344,  345,   38,  431,   81,  217,
			   40,  395,   29,   29,  398,   31,   33,   47,  369,   64,
			   65,   66,   67,   96,  364,  365,   68,  367,  412,  369,
			  102,  239,  276,   26,   79,   40,  376,  245,   26,   81,
			  366,  381,  368,   40,   49,   38,   39,   92,  496,  497,
			   38,   39,   49,   25,   96,  100,  101,  102,  506,   25,

			   33,  387,   66,  511,  512,  390,  274,   71,  575,   73,
			  577,   75,   38,   46,   66,   79,  401,  285,  286,  287,
			  288,  289,  290,  291,  292,  293,  294,  295,  296,  297,
			  630,  299,  300,   33,  302,  303,  304,  609,   40,  343,
			  308,   14,   15,   76,  616,   47,   25,  351,  352,  435,
			   64,   65,   66,   67,   65,   88,   29,   33,   58,   38,
			   33,  329,   62,   25,   33,   79,   66,   64,   68,   40,
			   70,    3,   40,   73,  378,    3,   47,   45,   92,  347,
			  348,    3,  386,    3,   40,  389,  100,  101,  102,   45,
			   47,   48,  701,   62,   63,  695,   96,   40,   71,   37,

			   46,   70,   45,   41,   42,   20,   21,  375,   66,  495,
			   47,   48,  416,   82,   25,   84,   85,  442,   25,   26,
			   47,   59,   91,  448,  449,   66,  451,  102,   66,   64,
			  530,   35,  741,   71,  100,   47,   66,   75,  738,  524,
			  525,   79,  761,  762,  763,  764,  101,  472,  548,  758,
			   66,  550,   25,   69,   25,   25,   66,   25,  483,  563,
			   26,   37,  563,   27,  564,  550,  470,   66,  563,   92,
			  563,   79,   37,   89,   90,   27,  576,   41,   42,   95,
			   97,  581,   98,   39,  584,   67,   40,  587,   82,  588,
			  590,  581,  760,   91,   49,   59,   84,   75,   48,   66,

			  590,   64,   66,  588,   71,   66,   73,   71,   75,  609,
			   39,   75,   79,   77,   45,   79,  616,   62,   63,   66,
			   84,   66,   75,   41,   42,   70,   45,   66,   39,   73,
			   75,  535,   89,   41,   41,  634,   95,   82,   66,   40,
			   85,   59,  546,   79,   46,   66,   46,   92,   66,  634,
			   46,   59,   59,   71,   40,  100,  101,   75,   66,   66,
			  660,   79,   55,   71,   71,   98,  570,   75,   75,   40,
			   69,   79,   79,   71,   66,  675,   26,  676,   14,   15,
			   16,   17,   18,   19,   20,   21,   47,  104,  104,  674,
			   47,  676,   16,   17,   18,   19,   20,   21,   41,   59,

			   42,  700,   48,   37,   26,   86,   47,   47,   47,   47,
			  614,   25,   47,  713,  618,  700,   33,   50,  729,   86,
			   47,   25,   38,   25,   25,  725,   49,   40,  596,  729,
			   77,  104,   47,  637,   45,   47,  729,   47,  606,   47,
			  740,   44,   25,  647,   25,   25,   40,   26,   48,   46,
			   49,  762,  763,  764,   47,  766,   29,   66,   35,   29,
			   46,  761,  762,  763,  764,   70,  766,   58,  761,  762,
			   39,  764,  529,  766,  553,  760,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,  122,  123,  434,  125,  798,  127,

			  128,  616,  493,  434,  708,  434,  548,  458,   63,  569,
			  629,  139,  118,  579,  511,  660,  660,  320,  372,  386,
			  660,  689,  660,  660,  766,  660,  694,  660,  660,  636,
			  355,  735,  736,  503,  471,  482,  416,  705,  755,  497,
			  168,  563,  711,  171,   97,  320,  660,  715,  716,   -1,
			   -1,  755,  180,   -1,   -1,   83,   -1,   -1,   -1,  727,
			  728,   -1,   -1,   -1,   -1,  733,   -1,   -1,   -1,  197,
			  198,  199,  200,  201,  202,  203,  204,  205,  206,  207,
			  208,  209,  210,  211,  212,  213,  214,   -1,   -1,   -1,
			   -1,   -1,   -1,  221,   -1,   -1,   -1,   -1,   -1,  767,

			  768,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  240,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   14,   15,   -1,   -1,   -1,  794,   -1,   21,   22,
			   23,   24,   -1,   26,   -1,   -1,   29,   30,   31,   32,
			   33,   34,   35,   -1,   -1,   38,   -1,   -1,   41,   -1,
			   43,   -1,   -1,   46,   -1,   48,   -1,   -1,   51,   52,
			   -1,   54,   -1,   -1,   -1,   -1,   -1,   60,   -1,   -1,
			  298,   64,   -1,  301,   -1,   -1,   -1,   -1,   71,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   86,   87,   -1,   -1,   -1,   -1,   -1,

			   93,   -1,   -1,   -1,   -1,   -1,   -1,  335,   -1,   -1,
			  103,   -1,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,   -1,   -1,   -1,   -1,   14,   15,
			   -1,   -1,   -1,   -1,  372,   21,   22,   23,   24,   -1,
			   26,   -1,   -1,   29,   30,   31,   32,   33,   34,   35,
			   -1,   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   -1,
			   46,   -1,   48,   -1,   -1,   51,   52,   -1,   54,   32,
			   -1,   -1,   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   71,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   86,   87,   -1,   -1,   -1,   -1,   -1,   93,   -1,   -1,
			   -1,   97,   -1,   -1,   -1,   -1,   -1,  103,   -1,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,   -1,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   14,   15,   -1,   -1,   -1,
			   -1,   -1,   21,   22,   23,   24,   -1,   26,   -1,   -1,

			   29,   30,   31,   32,   33,   34,   35,   -1,   -1,   38,
			   -1,   -1,   41,   -1,   43,   -1,   45,   46,   -1,   48,
			   -1,   -1,   51,   52,   32,   54,   -1,   -1,   -1,   -1,
			   -1,   60,   -1,   -1,   -1,   -1,   -1,   45,   -1,   -1,
			   -1,   -1,   71,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  584,   86,   87,   -1,
			   -1,   -1,   -1,   -1,   93,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  601,  103,   -1,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  106,   -1,

			  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,   -1,
			    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,  666,   -1,
			   -1,   -1,  670,   -1,   -1,   -1,   -1,   -1,   -1,  677,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  692,  693,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   14,   15,   -1,   -1,  706,  707,
			   -1,   21,   22,   23,   24,  713,   26,   -1,   -1,   29,
			   30,   31,   32,   33,   34,   35,   -1,   -1,   38,   -1,

			   -1,   41,   -1,   43,   -1,   -1,   46,   -1,   48,   -1,
			   -1,   51,   52,   97,   54,   -1,   -1,   -1,   -1,   -1,
			   60,   -1,   -1,  751,  752,   -1,   -1,   -1,   -1,   -1,
			   -1,   71,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  772,   -1,   86,   87,   -1,   -1,
			   -1,   -1,   -1,   93,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  103,   -1,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,   14,   15,   -1,
			   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,   26,

			   -1,   -1,   29,   30,   31,   32,   33,   34,   35,   -1,
			   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   -1,   46,
			   -1,   48,   -1,   -1,   51,   52,   32,   54,   -1,   -1,
			   14,   15,   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   71,   29,   30,   31,   32,   33,
			   34,   35,   -1,   37,   -1,   -1,   -1,   41,   -1,   86,
			   87,   -1,   -1,   -1,   -1,   -1,   93,   51,   52,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  103,   -1,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,

			  106,   -1,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,   14,   15,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   29,   30,
			   31,   32,   33,   34,   35,   -1,   -1,   -1,   -1,   -1,
			   41,   14,   15,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   51,   52,   -1,   -1,   -1,   -1,   29,   30,   31,   32,
			   -1,   34,    6,    7,    8,    9,   10,   11,   12,   13,

			   14,   15,   16,   17,   18,   19,   20,   21,   51,   52,
			    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   -1,   -1,
			   -1,   -1,   75,   -1,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,   99,   -1,   -1,   -1,
			   -1,   -1,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,

			   20,   21,   -1,   97,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   -1,   -1,   -1,   45,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   -1,   45,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   -1,   -1,   -1,   45,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,   -1,  126,   45,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,

			   16,   17,   18,   19,   20,   21,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21>>)
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

	yyFinal: INTEGER is 804
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 127
			-- Number of tokens

	yyLast: INTEGER is 1937
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
