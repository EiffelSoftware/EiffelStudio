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
	make, make_il_parser, make_type_parser, make_expression_parser

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
					--|#line 176 "eiffel.y"
				yy_do_action_1
			when 2 then
					--|#line 183 "eiffel.y"
				yy_do_action_2
			when 3 then
					--|#line 190 "eiffel.y"
				yy_do_action_3
			when 4 then
					--|#line 199 "eiffel.y"
				yy_do_action_4
			when 5 then
					--|#line 242 "eiffel.y"
				yy_do_action_5
			when 6 then
					--|#line 251 "eiffel.y"
				yy_do_action_6
			when 7 then
					--|#line 259 "eiffel.y"
				yy_do_action_7
			when 8 then
					--|#line 271 "eiffel.y"
				yy_do_action_8
			when 9 then
					--|#line 273 "eiffel.y"
				yy_do_action_9
			when 10 then
					--|#line 273 "eiffel.y"
				yy_do_action_10
			when 11 then
					--|#line 283 "eiffel.y"
				yy_do_action_11
			when 12 then
					--|#line 287 "eiffel.y"
				yy_do_action_12
			when 13 then
					--|#line 289 "eiffel.y"
				yy_do_action_13
			when 14 then
					--|#line 291 "eiffel.y"
				yy_do_action_14
			when 15 then
					--|#line 295 "eiffel.y"
				yy_do_action_15
			when 16 then
					--|#line 297 "eiffel.y"
				yy_do_action_16
			when 17 then
					--|#line 299 "eiffel.y"
				yy_do_action_17
			when 18 then
					--|#line 303 "eiffel.y"
				yy_do_action_18
			when 19 then
					--|#line 308 "eiffel.y"
				yy_do_action_19
			when 20 then
					--|#line 315 "eiffel.y"
				yy_do_action_20
			when 21 then
					--|#line 319 "eiffel.y"
				yy_do_action_21
			when 22 then
					--|#line 321 "eiffel.y"
				yy_do_action_22
			when 23 then
					--|#line 333 "eiffel.y"
				yy_do_action_23
			when 24 then
					--|#line 338 "eiffel.y"
				yy_do_action_24
			when 25 then
					--|#line 343 "eiffel.y"
				yy_do_action_25
			when 26 then
					--|#line 350 "eiffel.y"
				yy_do_action_26
			when 27 then
					--|#line 352 "eiffel.y"
				yy_do_action_27
			when 28 then
					--|#line 354 "eiffel.y"
				yy_do_action_28
			when 29 then
					--|#line 358 "eiffel.y"
				yy_do_action_29
			when 30 then
					--|#line 368 "eiffel.y"
				yy_do_action_30
			when 31 then
					--|#line 374 "eiffel.y"
				yy_do_action_31
			when 32 then
					--|#line 381 "eiffel.y"
				yy_do_action_32
			when 33 then
					--|#line 387 "eiffel.y"
				yy_do_action_33
			when 34 then
					--|#line 395 "eiffel.y"
				yy_do_action_34
			when 35 then
					--|#line 399 "eiffel.y"
				yy_do_action_35
			when 36 then
					--|#line 410 "eiffel.y"
				yy_do_action_36
			when 37 then
					--|#line 414 "eiffel.y"
				yy_do_action_37
			when 38 then
					--|#line 429 "eiffel.y"
				yy_do_action_38
			when 39 then
					--|#line 431 "eiffel.y"
				yy_do_action_39
			when 40 then
					--|#line 438 "eiffel.y"
				yy_do_action_40
			when 41 then
					--|#line 440 "eiffel.y"
				yy_do_action_41
			when 42 then
					--|#line 449 "eiffel.y"
				yy_do_action_42
			when 43 then
					--|#line 454 "eiffel.y"
				yy_do_action_43
			when 44 then
					--|#line 461 "eiffel.y"
				yy_do_action_44
			when 45 then
					--|#line 463 "eiffel.y"
				yy_do_action_45
			when 46 then
					--|#line 467 "eiffel.y"
				yy_do_action_46
			when 47 then
					--|#line 467 "eiffel.y"
				yy_do_action_47
			when 48 then
					--|#line 476 "eiffel.y"
				yy_do_action_48
			when 49 then
					--|#line 478 "eiffel.y"
				yy_do_action_49
			when 50 then
					--|#line 482 "eiffel.y"
				yy_do_action_50
			when 51 then
					--|#line 487 "eiffel.y"
				yy_do_action_51
			when 52 then
					--|#line 491 "eiffel.y"
				yy_do_action_52
			when 53 then
					--|#line 497 "eiffel.y"
				yy_do_action_53
			when 54 then
					--|#line 505 "eiffel.y"
				yy_do_action_54
			when 55 then
					--|#line 510 "eiffel.y"
				yy_do_action_55
			when 56 then
					--|#line 517 "eiffel.y"
				yy_do_action_56
			when 57 then
					--|#line 518 "eiffel.y"
				yy_do_action_57
			when 58 then
					--|#line 521 "eiffel.y"
				yy_do_action_58
			when 59 then
					--|#line 534 "eiffel.y"
				yy_do_action_59
			when 60 then
					--|#line 536 "eiffel.y"
				yy_do_action_60
			when 61 then
					--|#line 543 "eiffel.y"
				yy_do_action_61
			when 62 then
					--|#line 547 "eiffel.y"
				yy_do_action_62
			when 63 then
					--|#line 549 "eiffel.y"
				yy_do_action_63
			when 64 then
					--|#line 553 "eiffel.y"
				yy_do_action_64
			when 65 then
					--|#line 555 "eiffel.y"
				yy_do_action_65
			when 66 then
					--|#line 557 "eiffel.y"
				yy_do_action_66
			when 67 then
					--|#line 561 "eiffel.y"
				yy_do_action_67
			when 68 then
					--|#line 566 "eiffel.y"
				yy_do_action_68
			when 69 then
					--|#line 570 "eiffel.y"
				yy_do_action_69
			when 70 then
					--|#line 574 "eiffel.y"
				yy_do_action_70
			when 71 then
					--|#line 576 "eiffel.y"
				yy_do_action_71
			when 72 then
					--|#line 580 "eiffel.y"
				yy_do_action_72
			when 73 then
					--|#line 585 "eiffel.y"
				yy_do_action_73
			when 74 then
					--|#line 590 "eiffel.y"
				yy_do_action_74
			when 75 then
					--|#line 601 "eiffel.y"
				yy_do_action_75
			when 76 then
					--|#line 603 "eiffel.y"
				yy_do_action_76
			when 77 then
					--|#line 605 "eiffel.y"
				yy_do_action_77
			when 78 then
					--|#line 609 "eiffel.y"
				yy_do_action_78
			when 79 then
					--|#line 614 "eiffel.y"
				yy_do_action_79
			when 80 then
					--|#line 621 "eiffel.y"
				yy_do_action_80
			when 81 then
					--|#line 626 "eiffel.y"
				yy_do_action_81
			when 82 then
					--|#line 634 "eiffel.y"
				yy_do_action_82
			when 83 then
					--|#line 639 "eiffel.y"
				yy_do_action_83
			when 84 then
					--|#line 644 "eiffel.y"
				yy_do_action_84
			when 85 then
					--|#line 649 "eiffel.y"
				yy_do_action_85
			when 86 then
					--|#line 654 "eiffel.y"
				yy_do_action_86
			when 87 then
					--|#line 659 "eiffel.y"
				yy_do_action_87
			when 88 then
					--|#line 664 "eiffel.y"
				yy_do_action_88
			when 89 then
					--|#line 672 "eiffel.y"
				yy_do_action_89
			when 90 then
					--|#line 674 "eiffel.y"
				yy_do_action_90
			when 91 then
					--|#line 678 "eiffel.y"
				yy_do_action_91
			when 92 then
					--|#line 683 "eiffel.y"
				yy_do_action_92
			when 93 then
					--|#line 690 "eiffel.y"
				yy_do_action_93
			when 94 then
					--|#line 694 "eiffel.y"
				yy_do_action_94
			when 95 then
					--|#line 696 "eiffel.y"
				yy_do_action_95
			when 96 then
					--|#line 700 "eiffel.y"
				yy_do_action_96
			when 97 then
					--|#line 708 "eiffel.y"
				yy_do_action_97
			when 98 then
					--|#line 712 "eiffel.y"
				yy_do_action_98
			when 99 then
					--|#line 719 "eiffel.y"
				yy_do_action_99
			when 100 then
					--|#line 728 "eiffel.y"
				yy_do_action_100
			when 101 then
					--|#line 736 "eiffel.y"
				yy_do_action_101
			when 102 then
					--|#line 738 "eiffel.y"
				yy_do_action_102
			when 103 then
					--|#line 740 "eiffel.y"
				yy_do_action_103
			when 104 then
					--|#line 744 "eiffel.y"
				yy_do_action_104
			when 105 then
					--|#line 746 "eiffel.y"
				yy_do_action_105
			when 106 then
					--|#line 752 "eiffel.y"
				yy_do_action_106
			when 107 then
					--|#line 757 "eiffel.y"
				yy_do_action_107
			when 108 then
					--|#line 765 "eiffel.y"
				yy_do_action_108
			when 109 then
					--|#line 771 "eiffel.y"
				yy_do_action_109
			when 110 then
					--|#line 779 "eiffel.y"
				yy_do_action_110
			when 111 then
					--|#line 784 "eiffel.y"
				yy_do_action_111
			when 112 then
					--|#line 791 "eiffel.y"
				yy_do_action_112
			when 113 then
					--|#line 793 "eiffel.y"
				yy_do_action_113
			when 114 then
					--|#line 797 "eiffel.y"
				yy_do_action_114
			when 115 then
					--|#line 799 "eiffel.y"
				yy_do_action_115
			when 116 then
					--|#line 803 "eiffel.y"
				yy_do_action_116
			when 117 then
					--|#line 805 "eiffel.y"
				yy_do_action_117
			when 118 then
					--|#line 809 "eiffel.y"
				yy_do_action_118
			when 119 then
					--|#line 811 "eiffel.y"
				yy_do_action_119
			when 120 then
					--|#line 815 "eiffel.y"
				yy_do_action_120
			when 121 then
					--|#line 817 "eiffel.y"
				yy_do_action_121
			when 122 then
					--|#line 821 "eiffel.y"
				yy_do_action_122
			when 123 then
					--|#line 823 "eiffel.y"
				yy_do_action_123
			when 124 then
					--|#line 831 "eiffel.y"
				yy_do_action_124
			when 125 then
					--|#line 833 "eiffel.y"
				yy_do_action_125
			when 126 then
					--|#line 837 "eiffel.y"
				yy_do_action_126
			when 127 then
					--|#line 839 "eiffel.y"
				yy_do_action_127
			when 128 then
					--|#line 843 "eiffel.y"
				yy_do_action_128
			when 129 then
					--|#line 848 "eiffel.y"
				yy_do_action_129
			when 130 then
					--|#line 855 "eiffel.y"
				yy_do_action_130
			when 131 then
					--|#line 859 "eiffel.y"
				yy_do_action_131
			when 132 then
					--|#line 860 "eiffel.y"
				yy_do_action_132
			when 133 then
					--|#line 869 "eiffel.y"
				yy_do_action_133
			when 134 then
					--|#line 871 "eiffel.y"
				yy_do_action_134
			when 135 then
					--|#line 875 "eiffel.y"
				yy_do_action_135
			when 136 then
					--|#line 880 "eiffel.y"
				yy_do_action_136
			when 137 then
					--|#line 887 "eiffel.y"
				yy_do_action_137
			when 138 then
					--|#line 891 "eiffel.y"
				yy_do_action_138
			when 139 then
					--|#line 897 "eiffel.y"
				yy_do_action_139
			when 140 then
					--|#line 905 "eiffel.y"
				yy_do_action_140
			when 141 then
					--|#line 907 "eiffel.y"
				yy_do_action_141
			when 142 then
					--|#line 911 "eiffel.y"
				yy_do_action_142
			when 143 then
					--|#line 913 "eiffel.y"
				yy_do_action_143
			when 144 then
					--|#line 917 "eiffel.y"
				yy_do_action_144
			when 145 then
					--|#line 917 "eiffel.y"
				yy_do_action_145
			when 146 then
					--|#line 932 "eiffel.y"
				yy_do_action_146
			when 147 then
					--|#line 934 "eiffel.y"
				yy_do_action_147
			when 148 then
					--|#line 936 "eiffel.y"
				yy_do_action_148
			when 149 then
					--|#line 940 "eiffel.y"
				yy_do_action_149
			when 150 then
					--|#line 947 "eiffel.y"
				yy_do_action_150
			when 151 then
					--|#line 952 "eiffel.y"
				yy_do_action_151
			when 152 then
					--|#line 954 "eiffel.y"
				yy_do_action_152
			when 153 then
					--|#line 958 "eiffel.y"
				yy_do_action_153
			when 154 then
					--|#line 960 "eiffel.y"
				yy_do_action_154
			when 155 then
					--|#line 964 "eiffel.y"
				yy_do_action_155
			when 156 then
					--|#line 966 "eiffel.y"
				yy_do_action_156
			when 157 then
					--|#line 970 "eiffel.y"
				yy_do_action_157
			when 158 then
					--|#line 972 "eiffel.y"
				yy_do_action_158
			when 159 then
					--|#line 976 "eiffel.y"
				yy_do_action_159
			when 160 then
					--|#line 981 "eiffel.y"
				yy_do_action_160
			when 161 then
					--|#line 988 "eiffel.y"
				yy_do_action_161
			when 162 then
					--|#line 992 "eiffel.y"
				yy_do_action_162
			when 163 then
					--|#line 993 "eiffel.y"
				yy_do_action_163
			when 164 then
					--|#line 996 "eiffel.y"
				yy_do_action_164
			when 165 then
					--|#line 998 "eiffel.y"
				yy_do_action_165
			when 166 then
					--|#line 1000 "eiffel.y"
				yy_do_action_166
			when 167 then
					--|#line 1002 "eiffel.y"
				yy_do_action_167
			when 168 then
					--|#line 1004 "eiffel.y"
				yy_do_action_168
			when 169 then
					--|#line 1006 "eiffel.y"
				yy_do_action_169
			when 170 then
					--|#line 1008 "eiffel.y"
				yy_do_action_170
			when 171 then
					--|#line 1010 "eiffel.y"
				yy_do_action_171
			when 172 then
					--|#line 1012 "eiffel.y"
				yy_do_action_172
			when 173 then
					--|#line 1014 "eiffel.y"
				yy_do_action_173
			when 174 then
					--|#line 1018 "eiffel.y"
				yy_do_action_174
			when 175 then
					--|#line 1020 "eiffel.y"
				yy_do_action_175
			when 176 then
					--|#line 1020 "eiffel.y"
				yy_do_action_176
			when 177 then
					--|#line 1027 "eiffel.y"
				yy_do_action_177
			when 178 then
					--|#line 1027 "eiffel.y"
				yy_do_action_178
			when 179 then
					--|#line 1036 "eiffel.y"
				yy_do_action_179
			when 180 then
					--|#line 1038 "eiffel.y"
				yy_do_action_180
			when 181 then
					--|#line 1038 "eiffel.y"
				yy_do_action_181
			when 182 then
					--|#line 1045 "eiffel.y"
				yy_do_action_182
			when 183 then
					--|#line 1045 "eiffel.y"
				yy_do_action_183
			when 184 then
					--|#line 1054 "eiffel.y"
				yy_do_action_184
			when 185 then
					--|#line 1056 "eiffel.y"
				yy_do_action_185
			when 186 then
					--|#line 1065 "eiffel.y"
				yy_do_action_186
			when 187 then
					--|#line 1070 "eiffel.y"
				yy_do_action_187
			when 188 then
					--|#line 1077 "eiffel.y"
				yy_do_action_188
			when 189 then
					--|#line 1081 "eiffel.y"
				yy_do_action_189
			when 190 then
					--|#line 1083 "eiffel.y"
				yy_do_action_190
			when 191 then
					--|#line 1085 "eiffel.y"
				yy_do_action_191
			when 192 then
					--|#line 1093 "eiffel.y"
				yy_do_action_192
			when 193 then
					--|#line 1095 "eiffel.y"
				yy_do_action_193
			when 194 then
					--|#line 1099 "eiffel.y"
				yy_do_action_194
			when 195 then
					--|#line 1108 "eiffel.y"
				yy_do_action_195
			when 196 then
					--|#line 1110 "eiffel.y"
				yy_do_action_196
			when 197 then
					--|#line 1112 "eiffel.y"
				yy_do_action_197
			when 198 then
					--|#line 1114 "eiffel.y"
				yy_do_action_198
			when 199 then
					--|#line 1116 "eiffel.y"
				yy_do_action_199
			when 200 then
					--|#line 1120 "eiffel.y"
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
					--|#line 1124 "eiffel.y"
				yy_do_action_201
			when 202 then
					--|#line 1126 "eiffel.y"
				yy_do_action_202
			when 203 then
					--|#line 1128 "eiffel.y"
				yy_do_action_203
			when 204 then
					--|#line 1132 "eiffel.y"
				yy_do_action_204
			when 205 then
					--|#line 1134 "eiffel.y"
				yy_do_action_205
			when 206 then
					--|#line 1138 "eiffel.y"
				yy_do_action_206
			when 207 then
					--|#line 1143 "eiffel.y"
				yy_do_action_207
			when 208 then
					--|#line 1154 "eiffel.y"
				yy_do_action_208
			when 209 then
					--|#line 1160 "eiffel.y"
				yy_do_action_209
			when 210 then
					--|#line 1168 "eiffel.y"
				yy_do_action_210
			when 211 then
					--|#line 1170 "eiffel.y"
				yy_do_action_211
			when 212 then
					--|#line 1174 "eiffel.y"
				yy_do_action_212
			when 213 then
					--|#line 1179 "eiffel.y"
				yy_do_action_213
			when 214 then
					--|#line 1186 "eiffel.y"
				yy_do_action_214
			when 215 then
					--|#line 1203 "eiffel.y"
				yy_do_action_215
			when 216 then
					--|#line 1221 "eiffel.y"
				yy_do_action_216
			when 217 then
					--|#line 1240 "eiffel.y"
				yy_do_action_217
			when 218 then
					--|#line 1240 "eiffel.y"
				yy_do_action_218
			when 219 then
					--|#line 1253 "eiffel.y"
				yy_do_action_219
			when 220 then
					--|#line 1255 "eiffel.y"
				yy_do_action_220
			when 221 then
					--|#line 1263 "eiffel.y"
				yy_do_action_221
			when 222 then
					--|#line 1265 "eiffel.y"
				yy_do_action_222
			when 223 then
					--|#line 1273 "eiffel.y"
				yy_do_action_223
			when 224 then
					--|#line 1279 "eiffel.y"
				yy_do_action_224
			when 225 then
					--|#line 1281 "eiffel.y"
				yy_do_action_225
			when 226 then
					--|#line 1285 "eiffel.y"
				yy_do_action_226
			when 227 then
					--|#line 1290 "eiffel.y"
				yy_do_action_227
			when 228 then
					--|#line 1297 "eiffel.y"
				yy_do_action_228
			when 229 then
					--|#line 1301 "eiffel.y"
				yy_do_action_229
			when 230 then
					--|#line 1303 "eiffel.y"
				yy_do_action_230
			when 231 then
					--|#line 1307 "eiffel.y"
				yy_do_action_231
			when 232 then
					--|#line 1313 "eiffel.y"
				yy_do_action_232
			when 233 then
					--|#line 1315 "eiffel.y"
				yy_do_action_233
			when 234 then
					--|#line 1319 "eiffel.y"
				yy_do_action_234
			when 235 then
					--|#line 1324 "eiffel.y"
				yy_do_action_235
			when 236 then
					--|#line 1331 "eiffel.y"
				yy_do_action_236
			when 237 then
					--|#line 1335 "eiffel.y"
				yy_do_action_237
			when 238 then
					--|#line 1340 "eiffel.y"
				yy_do_action_238
			when 239 then
					--|#line 1347 "eiffel.y"
				yy_do_action_239
			when 240 then
					--|#line 1349 "eiffel.y"
				yy_do_action_240
			when 241 then
					--|#line 1351 "eiffel.y"
				yy_do_action_241
			when 242 then
					--|#line 1353 "eiffel.y"
				yy_do_action_242
			when 243 then
					--|#line 1355 "eiffel.y"
				yy_do_action_243
			when 244 then
					--|#line 1357 "eiffel.y"
				yy_do_action_244
			when 245 then
					--|#line 1359 "eiffel.y"
				yy_do_action_245
			when 246 then
					--|#line 1361 "eiffel.y"
				yy_do_action_246
			when 247 then
					--|#line 1363 "eiffel.y"
				yy_do_action_247
			when 248 then
					--|#line 1365 "eiffel.y"
				yy_do_action_248
			when 249 then
					--|#line 1367 "eiffel.y"
				yy_do_action_249
			when 250 then
					--|#line 1369 "eiffel.y"
				yy_do_action_250
			when 251 then
					--|#line 1371 "eiffel.y"
				yy_do_action_251
			when 252 then
					--|#line 1373 "eiffel.y"
				yy_do_action_252
			when 253 then
					--|#line 1375 "eiffel.y"
				yy_do_action_253
			when 254 then
					--|#line 1377 "eiffel.y"
				yy_do_action_254
			when 255 then
					--|#line 1379 "eiffel.y"
				yy_do_action_255
			when 256 then
					--|#line 1381 "eiffel.y"
				yy_do_action_256
			when 257 then
					--|#line 1386 "eiffel.y"
				yy_do_action_257
			when 258 then
					--|#line 1388 "eiffel.y"
				yy_do_action_258
			when 259 then
					--|#line 1397 "eiffel.y"
				yy_do_action_259
			when 260 then
					--|#line 1403 "eiffel.y"
				yy_do_action_260
			when 261 then
					--|#line 1405 "eiffel.y"
				yy_do_action_261
			when 262 then
					--|#line 1409 "eiffel.y"
				yy_do_action_262
			when 263 then
					--|#line 1411 "eiffel.y"
				yy_do_action_263
			when 264 then
					--|#line 1411 "eiffel.y"
				yy_do_action_264
			when 265 then
					--|#line 1422 "eiffel.y"
				yy_do_action_265
			when 266 then
					--|#line 1424 "eiffel.y"
				yy_do_action_266
			when 267 then
					--|#line 1426 "eiffel.y"
				yy_do_action_267
			when 268 then
					--|#line 1430 "eiffel.y"
				yy_do_action_268
			when 269 then
					--|#line 1436 "eiffel.y"
				yy_do_action_269
			when 270 then
					--|#line 1438 "eiffel.y"
				yy_do_action_270
			when 271 then
					--|#line 1440 "eiffel.y"
				yy_do_action_271
			when 272 then
					--|#line 1444 "eiffel.y"
				yy_do_action_272
			when 273 then
					--|#line 1449 "eiffel.y"
				yy_do_action_273
			when 274 then
					--|#line 1456 "eiffel.y"
				yy_do_action_274
			when 275 then
					--|#line 1460 "eiffel.y"
				yy_do_action_275
			when 276 then
					--|#line 1462 "eiffel.y"
				yy_do_action_276
			when 277 then
					--|#line 1471 "eiffel.y"
				yy_do_action_277
			when 278 then
					--|#line 1473 "eiffel.y"
				yy_do_action_278
			when 279 then
					--|#line 1477 "eiffel.y"
				yy_do_action_279
			when 280 then
					--|#line 1479 "eiffel.y"
				yy_do_action_280
			when 281 then
					--|#line 1483 "eiffel.y"
				yy_do_action_281
			when 282 then
					--|#line 1485 "eiffel.y"
				yy_do_action_282
			when 283 then
					--|#line 1489 "eiffel.y"
				yy_do_action_283
			when 284 then
					--|#line 1494 "eiffel.y"
				yy_do_action_284
			when 285 then
					--|#line 1501 "eiffel.y"
				yy_do_action_285
			when 286 then
					--|#line 1507 "eiffel.y"
				yy_do_action_286
			when 287 then
					--|#line 1512 "eiffel.y"
				yy_do_action_287
			when 288 then
					--|#line 1517 "eiffel.y"
				yy_do_action_288
			when 289 then
					--|#line 1527 "eiffel.y"
				yy_do_action_289
			when 290 then
					--|#line 1537 "eiffel.y"
				yy_do_action_290
			when 291 then
					--|#line 1549 "eiffel.y"
				yy_do_action_291
			when 292 then
					--|#line 1551 "eiffel.y"
				yy_do_action_292
			when 293 then
					--|#line 1553 "eiffel.y"
				yy_do_action_293
			when 294 then
					--|#line 1571 "eiffel.y"
				yy_do_action_294
			when 295 then
					--|#line 1573 "eiffel.y"
				yy_do_action_295
			when 296 then
					--|#line 1575 "eiffel.y"
				yy_do_action_296
			when 297 then
					--|#line 1577 "eiffel.y"
				yy_do_action_297
			when 298 then
					--|#line 1579 "eiffel.y"
				yy_do_action_298
			when 299 then
					--|#line 1581 "eiffel.y"
				yy_do_action_299
			when 300 then
					--|#line 1583 "eiffel.y"
				yy_do_action_300
			when 301 then
					--|#line 1587 "eiffel.y"
				yy_do_action_301
			when 302 then
					--|#line 1589 "eiffel.y"
				yy_do_action_302
			when 303 then
					--|#line 1591 "eiffel.y"
				yy_do_action_303
			when 304 then
					--|#line 1593 "eiffel.y"
				yy_do_action_304
			when 305 then
					--|#line 1595 "eiffel.y"
				yy_do_action_305
			when 306 then
					--|#line 1597 "eiffel.y"
				yy_do_action_306
			when 307 then
					--|#line 1601 "eiffel.y"
				yy_do_action_307
			when 308 then
					--|#line 1603 "eiffel.y"
				yy_do_action_308
			when 309 then
					--|#line 1605 "eiffel.y"
				yy_do_action_309
			when 310 then
					--|#line 1609 "eiffel.y"
				yy_do_action_310
			when 311 then
					--|#line 1614 "eiffel.y"
				yy_do_action_311
			when 312 then
					--|#line 1621 "eiffel.y"
				yy_do_action_312
			when 313 then
					--|#line 1627 "eiffel.y"
				yy_do_action_313
			when 314 then
					--|#line 1629 "eiffel.y"
				yy_do_action_314
			when 315 then
					--|#line 1631 "eiffel.y"
				yy_do_action_315
			when 316 then
					--|#line 1640 "eiffel.y"
				yy_do_action_316
			when 317 then
					--|#line 1642 "eiffel.y"
				yy_do_action_317
			when 318 then
					--|#line 1644 "eiffel.y"
				yy_do_action_318
			when 319 then
					--|#line 1646 "eiffel.y"
				yy_do_action_319
			when 320 then
					--|#line 1648 "eiffel.y"
				yy_do_action_320
			when 321 then
					--|#line 1650 "eiffel.y"
				yy_do_action_321
			when 322 then
					--|#line 1654 "eiffel.y"
				yy_do_action_322
			when 323 then
					--|#line 1663 "eiffel.y"
				yy_do_action_323
			when 324 then
					--|#line 1665 "eiffel.y"
				yy_do_action_324
			when 325 then
					--|#line 1669 "eiffel.y"
				yy_do_action_325
			when 326 then
					--|#line 1671 "eiffel.y"
				yy_do_action_326
			when 327 then
					--|#line 1682 "eiffel.y"
				yy_do_action_327
			when 328 then
					--|#line 1684 "eiffel.y"
				yy_do_action_328
			when 329 then
					--|#line 1688 "eiffel.y"
				yy_do_action_329
			when 330 then
					--|#line 1690 "eiffel.y"
				yy_do_action_330
			when 331 then
					--|#line 1694 "eiffel.y"
				yy_do_action_331
			when 332 then
					--|#line 1696 "eiffel.y"
				yy_do_action_332
			when 333 then
					--|#line 1704 "eiffel.y"
				yy_do_action_333
			when 334 then
					--|#line 1706 "eiffel.y"
				yy_do_action_334
			when 335 then
					--|#line 1708 "eiffel.y"
				yy_do_action_335
			when 336 then
					--|#line 1710 "eiffel.y"
				yy_do_action_336
			when 337 then
					--|#line 1712 "eiffel.y"
				yy_do_action_337
			when 338 then
					--|#line 1714 "eiffel.y"
				yy_do_action_338
			when 339 then
					--|#line 1716 "eiffel.y"
				yy_do_action_339
			when 340 then
					--|#line 1718 "eiffel.y"
				yy_do_action_340
			when 341 then
					--|#line 1720 "eiffel.y"
				yy_do_action_341
			when 342 then
					--|#line 1724 "eiffel.y"
				yy_do_action_342
			when 343 then
					--|#line 1732 "eiffel.y"
				yy_do_action_343
			when 344 then
					--|#line 1735 "eiffel.y"
				yy_do_action_344
			when 345 then
					--|#line 1737 "eiffel.y"
				yy_do_action_345
			when 346 then
					--|#line 1739 "eiffel.y"
				yy_do_action_346
			when 347 then
					--|#line 1741 "eiffel.y"
				yy_do_action_347
			when 348 then
					--|#line 1743 "eiffel.y"
				yy_do_action_348
			when 349 then
					--|#line 1745 "eiffel.y"
				yy_do_action_349
			when 350 then
					--|#line 1747 "eiffel.y"
				yy_do_action_350
			when 351 then
					--|#line 1749 "eiffel.y"
				yy_do_action_351
			when 352 then
					--|#line 1751 "eiffel.y"
				yy_do_action_352
			when 353 then
					--|#line 1753 "eiffel.y"
				yy_do_action_353
			when 354 then
					--|#line 1755 "eiffel.y"
				yy_do_action_354
			when 355 then
					--|#line 1757 "eiffel.y"
				yy_do_action_355
			when 356 then
					--|#line 1759 "eiffel.y"
				yy_do_action_356
			when 357 then
					--|#line 1761 "eiffel.y"
				yy_do_action_357
			when 358 then
					--|#line 1763 "eiffel.y"
				yy_do_action_358
			when 359 then
					--|#line 1765 "eiffel.y"
				yy_do_action_359
			when 360 then
					--|#line 1767 "eiffel.y"
				yy_do_action_360
			when 361 then
					--|#line 1769 "eiffel.y"
				yy_do_action_361
			when 362 then
					--|#line 1771 "eiffel.y"
				yy_do_action_362
			when 363 then
					--|#line 1773 "eiffel.y"
				yy_do_action_363
			when 364 then
					--|#line 1775 "eiffel.y"
				yy_do_action_364
			when 365 then
					--|#line 1779 "eiffel.y"
				yy_do_action_365
			when 366 then
					--|#line 1782 "eiffel.y"
				yy_do_action_366
			when 367 then
					--|#line 1784 "eiffel.y"
				yy_do_action_367
			when 368 then
					--|#line 1786 "eiffel.y"
				yy_do_action_368
			when 369 then
					--|#line 1788 "eiffel.y"
				yy_do_action_369
			when 370 then
					--|#line 1790 "eiffel.y"
				yy_do_action_370
			when 371 then
					--|#line 1792 "eiffel.y"
				yy_do_action_371
			when 372 then
					--|#line 1794 "eiffel.y"
				yy_do_action_372
			when 373 then
					--|#line 1796 "eiffel.y"
				yy_do_action_373
			when 374 then
					--|#line 1798 "eiffel.y"
				yy_do_action_374
			when 375 then
					--|#line 1800 "eiffel.y"
				yy_do_action_375
			when 376 then
					--|#line 1802 "eiffel.y"
				yy_do_action_376
			when 377 then
					--|#line 1804 "eiffel.y"
				yy_do_action_377
			when 378 then
					--|#line 1806 "eiffel.y"
				yy_do_action_378
			when 379 then
					--|#line 1808 "eiffel.y"
				yy_do_action_379
			when 380 then
					--|#line 1810 "eiffel.y"
				yy_do_action_380
			when 381 then
					--|#line 1812 "eiffel.y"
				yy_do_action_381
			when 382 then
					--|#line 1814 "eiffel.y"
				yy_do_action_382
			when 383 then
					--|#line 1818 "eiffel.y"
				yy_do_action_383
			when 384 then
					--|#line 1826 "eiffel.y"
				yy_do_action_384
			when 385 then
					--|#line 1828 "eiffel.y"
				yy_do_action_385
			when 386 then
					--|#line 1830 "eiffel.y"
				yy_do_action_386
			when 387 then
					--|#line 1832 "eiffel.y"
				yy_do_action_387
			when 388 then
					--|#line 1834 "eiffel.y"
				yy_do_action_388
			when 389 then
					--|#line 1836 "eiffel.y"
				yy_do_action_389
			when 390 then
					--|#line 1838 "eiffel.y"
				yy_do_action_390
			when 391 then
					--|#line 1840 "eiffel.y"
				yy_do_action_391
			when 392 then
					--|#line 1842 "eiffel.y"
				yy_do_action_392
			when 393 then
					--|#line 1844 "eiffel.y"
				yy_do_action_393
			when 394 then
					--|#line 1846 "eiffel.y"
				yy_do_action_394
			when 395 then
					--|#line 1848 "eiffel.y"
				yy_do_action_395
			when 396 then
					--|#line 1852 "eiffel.y"
				yy_do_action_396
			when 397 then
					--|#line 1856 "eiffel.y"
				yy_do_action_397
			when 398 then
					--|#line 1860 "eiffel.y"
				yy_do_action_398
			when 399 then
					--|#line 1864 "eiffel.y"
				yy_do_action_399
			when 400 then
					--|#line 1868 "eiffel.y"
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
					--|#line 1872 "eiffel.y"
				yy_do_action_401
			when 402 then
					--|#line 1874 "eiffel.y"
				yy_do_action_402
			when 403 then
					--|#line 1876 "eiffel.y"
				yy_do_action_403
			when 404 then
					--|#line 1878 "eiffel.y"
				yy_do_action_404
			when 405 then
					--|#line 1882 "eiffel.y"
				yy_do_action_405
			when 406 then
					--|#line 1886 "eiffel.y"
				yy_do_action_406
			when 407 then
					--|#line 1893 "eiffel.y"
				yy_do_action_407
			when 408 then
					--|#line 1901 "eiffel.y"
				yy_do_action_408
			when 409 then
					--|#line 1903 "eiffel.y"
				yy_do_action_409
			when 410 then
					--|#line 1907 "eiffel.y"
				yy_do_action_410
			when 411 then
					--|#line 1909 "eiffel.y"
				yy_do_action_411
			when 412 then
					--|#line 1913 "eiffel.y"
				yy_do_action_412
			when 413 then
					--|#line 1915 "eiffel.y"
				yy_do_action_413
			when 414 then
					--|#line 1917 "eiffel.y"
				yy_do_action_414
			when 415 then
					--|#line 1921 "eiffel.y"
				yy_do_action_415
			when 416 then
					--|#line 1934 "eiffel.y"
				yy_do_action_416
			when 417 then
					--|#line 1938 "eiffel.y"
				yy_do_action_417
			when 418 then
					--|#line 1940 "eiffel.y"
				yy_do_action_418
			when 419 then
					--|#line 1942 "eiffel.y"
				yy_do_action_419
			when 420 then
					--|#line 1946 "eiffel.y"
				yy_do_action_420
			when 421 then
					--|#line 1951 "eiffel.y"
				yy_do_action_421
			when 422 then
					--|#line 1958 "eiffel.y"
				yy_do_action_422
			when 423 then
					--|#line 1960 "eiffel.y"
				yy_do_action_423
			when 424 then
					--|#line 1964 "eiffel.y"
				yy_do_action_424
			when 425 then
					--|#line 1969 "eiffel.y"
				yy_do_action_425
			when 426 then
					--|#line 1980 "eiffel.y"
				yy_do_action_426
			when 427 then
					--|#line 1989 "eiffel.y"
				yy_do_action_427
			when 428 then
					--|#line 1991 "eiffel.y"
				yy_do_action_428
			when 429 then
					--|#line 1993 "eiffel.y"
				yy_do_action_429
			when 430 then
					--|#line 1995 "eiffel.y"
				yy_do_action_430
			when 431 then
					--|#line 1997 "eiffel.y"
				yy_do_action_431
			when 432 then
					--|#line 1999 "eiffel.y"
				yy_do_action_432
			when 433 then
					--|#line 2003 "eiffel.y"
				yy_do_action_433
			when 434 then
					--|#line 2006 "eiffel.y"
				yy_do_action_434
			when 435 then
					--|#line 2008 "eiffel.y"
				yy_do_action_435
			when 436 then
					--|#line 2010 "eiffel.y"
				yy_do_action_436
			when 437 then
					--|#line 2012 "eiffel.y"
				yy_do_action_437
			when 438 then
					--|#line 2014 "eiffel.y"
				yy_do_action_438
			when 439 then
					--|#line 2022 "eiffel.y"
				yy_do_action_439
			when 440 then
					--|#line 2024 "eiffel.y"
				yy_do_action_440
			when 441 then
					--|#line 2028 "eiffel.y"
				yy_do_action_441
			when 442 then
					--|#line 2035 "eiffel.y"
				yy_do_action_442
			when 443 then
					--|#line 2038 "eiffel.y"
				yy_do_action_443
			when 444 then
					--|#line 2042 "eiffel.y"
				yy_do_action_444
			when 445 then
					--|#line 2062 "eiffel.y"
				yy_do_action_445
			when 446 then
					--|#line 2080 "eiffel.y"
				yy_do_action_446
			when 447 then
					--|#line 2102 "eiffel.y"
				yy_do_action_447
			when 448 then
					--|#line 2104 "eiffel.y"
				yy_do_action_448
			when 449 then
					--|#line 2106 "eiffel.y"
				yy_do_action_449
			when 450 then
					--|#line 2113 "eiffel.y"
				yy_do_action_450
			when 451 then
					--|#line 2117 "eiffel.y"
				yy_do_action_451
			when 452 then
					--|#line 2119 "eiffel.y"
				yy_do_action_452
			when 453 then
					--|#line 2121 "eiffel.y"
				yy_do_action_453
			when 454 then
					--|#line 2125 "eiffel.y"
				yy_do_action_454
			when 455 then
					--|#line 2127 "eiffel.y"
				yy_do_action_455
			when 456 then
					--|#line 2129 "eiffel.y"
				yy_do_action_456
			when 457 then
					--|#line 2131 "eiffel.y"
				yy_do_action_457
			when 458 then
					--|#line 2133 "eiffel.y"
				yy_do_action_458
			when 459 then
					--|#line 2135 "eiffel.y"
				yy_do_action_459
			when 460 then
					--|#line 2137 "eiffel.y"
				yy_do_action_460
			when 461 then
					--|#line 2139 "eiffel.y"
				yy_do_action_461
			when 462 then
					--|#line 2141 "eiffel.y"
				yy_do_action_462
			when 463 then
					--|#line 2143 "eiffel.y"
				yy_do_action_463
			when 464 then
					--|#line 2145 "eiffel.y"
				yy_do_action_464
			when 465 then
					--|#line 2147 "eiffel.y"
				yy_do_action_465
			when 466 then
					--|#line 2149 "eiffel.y"
				yy_do_action_466
			when 467 then
					--|#line 2151 "eiffel.y"
				yy_do_action_467
			when 468 then
					--|#line 2153 "eiffel.y"
				yy_do_action_468
			when 469 then
					--|#line 2155 "eiffel.y"
				yy_do_action_469
			when 470 then
					--|#line 2157 "eiffel.y"
				yy_do_action_470
			when 471 then
					--|#line 2159 "eiffel.y"
				yy_do_action_471
			when 472 then
					--|#line 2161 "eiffel.y"
				yy_do_action_472
			when 473 then
					--|#line 2163 "eiffel.y"
				yy_do_action_473
			when 474 then
					--|#line 2165 "eiffel.y"
				yy_do_action_474
			when 475 then
					--|#line 2169 "eiffel.y"
				yy_do_action_475
			when 476 then
					--|#line 2171 "eiffel.y"
				yy_do_action_476
			when 477 then
					--|#line 2173 "eiffel.y"
				yy_do_action_477
			when 478 then
					--|#line 2175 "eiffel.y"
				yy_do_action_478
			when 479 then
					--|#line 2179 "eiffel.y"
				yy_do_action_479
			when 480 then
					--|#line 2181 "eiffel.y"
				yy_do_action_480
			when 481 then
					--|#line 2183 "eiffel.y"
				yy_do_action_481
			when 482 then
					--|#line 2185 "eiffel.y"
				yy_do_action_482
			when 483 then
					--|#line 2187 "eiffel.y"
				yy_do_action_483
			when 484 then
					--|#line 2189 "eiffel.y"
				yy_do_action_484
			when 485 then
					--|#line 2191 "eiffel.y"
				yy_do_action_485
			when 486 then
					--|#line 2193 "eiffel.y"
				yy_do_action_486
			when 487 then
					--|#line 2195 "eiffel.y"
				yy_do_action_487
			when 488 then
					--|#line 2197 "eiffel.y"
				yy_do_action_488
			when 489 then
					--|#line 2199 "eiffel.y"
				yy_do_action_489
			when 490 then
					--|#line 2201 "eiffel.y"
				yy_do_action_490
			when 491 then
					--|#line 2203 "eiffel.y"
				yy_do_action_491
			when 492 then
					--|#line 2205 "eiffel.y"
				yy_do_action_492
			when 493 then
					--|#line 2207 "eiffel.y"
				yy_do_action_493
			when 494 then
					--|#line 2209 "eiffel.y"
				yy_do_action_494
			when 495 then
					--|#line 2211 "eiffel.y"
				yy_do_action_495
			when 496 then
					--|#line 2213 "eiffel.y"
				yy_do_action_496
			when 497 then
					--|#line 2217 "eiffel.y"
				yy_do_action_497
			when 498 then
					--|#line 2221 "eiffel.y"
				yy_do_action_498
			when 499 then
					--|#line 2225 "eiffel.y"
				yy_do_action_499
			when 500 then
					--|#line 2229 "eiffel.y"
				yy_do_action_500
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
			--|#line 176 "eiffel.y"
		do
--|#line 176 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 176")
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
			--|#line 183 "eiffel.y"
		do
--|#line 183 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 183")
end

			yyval := yyval_default;
				if not type_parser then
					raise_error
				end
				type_node := yytype63 (yyvs.item (yyvsp))
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_3 is
			--|#line 190 "eiffel.y"
		do
--|#line 190 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 190")
end

			yyval := yyval_default;
				if not expression_parser then
					raise_error
				end
				expression_node := yytype25 (yyvs.item (yyvsp))
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_4 is
			--|#line 199 "eiffel.y"
		do
--|#line 199 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 199")
end

			yyval := yyval_default;
				root_node := new_class_description (yytype92 (yyvs.item (yyvsp - 13)), yytype60 (yyvs.item (yyvsp - 11)),
					is_deferred, is_expanded, is_separate, is_frozen_class, is_external_class,
					yytype81 (yyvs.item (yyvsp - 16)), yytype81 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp - 12)), yytype85 (yyvs.item (yyvsp - 9)), yytype69 (yyvs.item (yyvsp - 7)), yytype68 (yyvs.item (yyvsp - 6)), yytype74 (yyvs.item (yyvsp - 5)), yytype42 (yyvs.item (yyvsp - 3)), suppliers, yytype60 (yyvs.item (yyvsp - 10)), click_list
				)

				if real_class_end_position = 0 then
					root_node.set_text_positions (
						current_position.start_position,
						yytype58 (yyvs.item (yyvsp - 4)).start_position,
						yytype58 (yyvs.item (yyvsp - 8)).start_position,
						formal_generics_start_position,
						formal_generics_end_position,
						yytype58 (yyvs.item (yyvsp - 2)).start_position
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

	yy_do_action_5 is
			--|#line 242 "eiffel.y"
		do
--|#line 242 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 242")
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

	yy_do_action_6 is
			--|#line 251 "eiffel.y"
		local
			yyval92: PAIR [ID_AS, CLICK_AST]
		do
--|#line 251 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 251")
end


				if not case_sensitive then
					token_buffer.to_lower
				end
				yyval92 := new_clickable_id (create {ID_AS}.initialize (token_buffer))
			
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_7 is
			--|#line 259 "eiffel.y"
		local
			yyval92: PAIR [ID_AS, CLICK_AST]
		do
--|#line 259 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 259")
end


				if not case_sensitive then
					token_buffer.to_upper
				end
				yyval92 := new_clickable_id (create {ID_AS}.initialize (token_buffer))
			
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_8 is
			--|#line 271 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 271 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 271")
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

	yy_do_action_9 is
			--|#line 273 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 273 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 273")
end


				yyval81 := yytype81 (yyvs.item (yyvsp))
				set_has_old_verbatim_strings_warning (initial_has_old_verbatim_strings_warning)
			
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_10 is
			--|#line 273 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 273 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 273")
end


				initial_has_old_verbatim_strings_warning := has_old_verbatim_strings_warning
				set_has_old_verbatim_strings_warning (false)
			
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

	yy_do_action_11 is
			--|#line 283 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 283 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 283")
end



			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_12 is
			--|#line 287 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 287 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 287")
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

	yy_do_action_13 is
			--|#line 289 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 289 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 289")
end


yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_14 is
			--|#line 291 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 291 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 291")
end


yyval81 := Void 
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_15 is
			--|#line 295 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 295 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 295")
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

	yy_do_action_16 is
			--|#line 297 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 297 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 297")
end


yyval81 := yytype81 (yyvs.item (yyvsp - 1)) 
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_17 is
			--|#line 299 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 299 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 299")
end


yyval81 := Void 
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_18 is
			--|#line 303 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 303 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 303")
end


				yyval81 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval81.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_19 is
			--|#line 308 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 308 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 308")
end


				yyval81 := yytype81 (yyvs.item (yyvsp - 1))
				yyval81.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_20 is
			--|#line 315 "eiffel.y"
		local
			yyval35: INDEX_AS
		do
--|#line 315 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 315")
end


yyval35 := new_index_as (yytype33 (yyvs.item (yyvsp - 2)), yytype66 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval35
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_21 is
			--|#line 319 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 319 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 319")
end


yyval33 := yytype33 (yyvs.item (yyvsp - 1)) 
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_22 is
			--|#line 321 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 321 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 321")
end


				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (current_position.start_position,
						current_position.end_position, filename, 0,
						"Missing `Index' part of `Index_clause'."))
				end
				yyval33 := Void
			
			yyval := yyval33
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

	yy_do_action_23 is
			--|#line 333 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 333 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 333")
end


				yyval66 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval66.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval66
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_24 is
			--|#line 338 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 338 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 338")
end


				yyval66 := yytype66 (yyvs.item (yyvsp - 2))
				yyval66.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval66
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_25 is
			--|#line 343 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 343 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 343")
end


-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval66 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval66
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_26 is
			--|#line 350 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 350 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 350")
end


yyval7 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_27 is
			--|#line 352 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 352 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 352")
end


yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_28 is
			--|#line 354 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 354 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 354")
end


				create {CUSTOM_ATTRIBUTE_AS} yyval7.initialize (yytype20 (yyvs.item (yyvsp - 1)), Void)
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_29 is
			--|#line 358 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 358 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 358")
end


				create {CUSTOM_ATTRIBUTE_AS} yyval7.initialize (yytype20 (yyvs.item (yyvsp - 2)), yytype62 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_30 is
			--|#line 368 "eiffel.y"
		do
--|#line 368 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 368")
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

	yy_do_action_31 is
			--|#line 374 "eiffel.y"
		do
--|#line 374 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 374")
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

	yy_do_action_32 is
			--|#line 381 "eiffel.y"
		do
--|#line 381 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 381")
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

	yy_do_action_33 is
			--|#line 387 "eiffel.y"
		do
--|#line 387 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 387")
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

	yy_do_action_34 is
			--|#line 395 "eiffel.y"
		do
--|#line 395 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 395")
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

	yy_do_action_35 is
			--|#line 399 "eiffel.y"
		do
--|#line 399 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 399")
end

			yyval := yyval_default;
					-- I'm adding a few comments line
					-- here because otherwise the generated
					-- parser is very different from the
					-- previous one, since line numbers are
					-- emitted.
				is_frozen_class := True
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_36 is
			--|#line 410 "eiffel.y"
		do
--|#line 410 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 410")
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

	yy_do_action_37 is
			--|#line 414 "eiffel.y"
		do
--|#line 414 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 414")
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

	yy_do_action_38 is
			--|#line 429 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 429 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 429")
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

	yy_do_action_39 is
			--|#line 431 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 431 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 431")
end


yyval60 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_40 is
			--|#line 438 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 438 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 438")
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

	yy_do_action_41 is
			--|#line 440 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 440 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 440")
end


				yyval74 := yytype74 (yyvs.item (yyvsp))
				if yyval74.is_empty then
					yyval74 := Void
				end
			
			yyval := yyval74
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_42 is
			--|#line 449 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 449 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 449")
end


				yyval74 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval74, yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval74
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_43 is
			--|#line 454 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 454 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 454")
end


				yyval74 := yytype74 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval74, yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval74
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_44 is
			--|#line 461 "eiffel.y"
		local
			yyval29: FEATURE_CLAUSE_AS
		do
--|#line 461 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 461")
end


yyval29 := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) 
			yyval := yyval29
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_45 is
			--|#line 463 "eiffel.y"
		local
			yyval29: FEATURE_CLAUSE_AS
		do
--|#line 463 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 463")
end


yyval29 := new_feature_clause_as (yytype15 (yyvs.item (yyvsp - 1)), yytype73 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval29
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_46 is
			--|#line 467 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 467 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 467")
end


yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_47 is
			--|#line 467 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 467 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 467")
end


				inherit_context := False
				fclause_pos := current_position.twin
			
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

	yy_do_action_48 is
			--|#line 476 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 476 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 476")
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

	yy_do_action_49 is
			--|#line 478 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 478 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 478")
end


yyval15 := new_client_as (yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval15
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_50 is
			--|#line 482 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [ID_AS]
		do
--|#line 482 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 482")
end


				yyval78 := new_eiffel_list_id_as (1)
				yyval78.extend (new_none_id_as)
			
			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_51 is
			--|#line 487 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [ID_AS]
		do
--|#line 487 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 487")
end


yyval78 := yytype78 (yyvs.item (yyvsp - 1)) 
			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_52 is
			--|#line 491 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [ID_AS]
		do
--|#line 491 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 491")
end


				yyval78 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval78.extend (yytype92 (yyvs.item (yyvsp)).first)
				yytype92 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype92 (yyvs.item (yyvsp)).first, Void, False, False))
			
			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_53 is
			--|#line 497 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [ID_AS]
		do
--|#line 497 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 497")
end


				yyval78 := yytype78 (yyvs.item (yyvsp - 2))
				yyval78.extend (yytype92 (yyvs.item (yyvsp)).first)
				yytype92 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype92 (yyvs.item (yyvsp)).first, Void, False, False))
			
			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_54 is
			--|#line 505 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_AS]
		do
--|#line 505 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 505")
end


				yyval73 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval73.extend (yytype28 (yyvs.item (yyvsp)))
			
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_55 is
			--|#line 510 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_AS]
		do
--|#line 510 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 510")
end


				yyval73 := yytype73 (yyvs.item (yyvsp - 1))
				yyval73.extend (yytype28 (yyvs.item (yyvsp)))
			
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_56 is
			--|#line 517 "eiffel.y"
		do
--|#line 517 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 517")
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

	yy_do_action_57 is
			--|#line 518 "eiffel.y"
		do
--|#line 518 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 518")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_58 is
			--|#line 521 "eiffel.y"
		local
			yyval28: FEATURE_AS
		do
--|#line 521 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 521")
end


					-- Generate a syntax error when `feature_indexes' is not
					-- Void and it applies to synonyms of the current feature
					-- declaration.
				if (il_parser and feature_indexes /= Void and yytype95 (yyvs.item (yyvsp - 2)).first.count /= 1) then
					raise_error
				end
				yyval28 := new_feature_declaration (yytype95 (yyvs.item (yyvsp - 2)), yytype9 (yyvs.item (yyvsp - 1)), feature_indexes)
				feature_indexes := Void
			
			yyval := yyval28
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_59 is
			--|#line 534 "eiffel.y"
		local
			yyval95: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
--|#line 534 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 534")
end


yyval95 := new_clickable_feature_name_list (yytype93 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval95
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_60 is
			--|#line 536 "eiffel.y"
		local
			yyval95: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
--|#line 536 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 536")
end


				yyval95 := yytype95 (yyvs.item (yyvsp - 2))
				yyval95.first.extend (yytype93 (yyvs.item (yyvsp)).first)
			
			yyval := yyval95
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_61 is
			--|#line 543 "eiffel.y"
		local
			yyval93: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 543 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 543")
end


yyval93 := yytype93 (yyvs.item (yyvsp)) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_62 is
			--|#line 547 "eiffel.y"
		do
--|#line 547 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 547")
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

	yy_do_action_63 is
			--|#line 549 "eiffel.y"
		do
--|#line 549 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 549")
end

			yyval := yyval_default;
is_frozen := True 

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_64 is
			--|#line 553 "eiffel.y"
		local
			yyval93: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 553 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 553")
end


yyval93 := new_clickable_feature_name (yytype92 (yyvs.item (yyvsp))) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_65 is
			--|#line 555 "eiffel.y"
		local
			yyval93: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 555 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 555")
end


yyval93 := yytype93 (yyvs.item (yyvsp)) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_66 is
			--|#line 557 "eiffel.y"
		local
			yyval93: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 557 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 557")
end


yyval93 := yytype93 (yyvs.item (yyvsp)) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_67 is
			--|#line 561 "eiffel.y"
		local
			yyval93: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 561 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 561")
end


yyval93 := new_clickable_infix (yytype94 (yyvs.item (yyvsp))) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_68 is
			--|#line 566 "eiffel.y"
		local
			yyval93: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 566 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 566")
end


yyval93 := new_clickable_prefix (yytype94 (yyvs.item (yyvsp))) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_69 is
			--|#line 570 "eiffel.y"
		local
			yyval9: BODY_AS
		do
--|#line 570 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 570")
end


yyval9 := new_declaration_body (yytype90 (yyvs.item (yyvsp - 2)), yytype63 (yyvs.item (yyvsp - 1)), yytype16 (yyvs.item (yyvsp))) 
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_70 is
			--|#line 574 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 574 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 574")
end


feature_indexes := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_71 is
			--|#line 576 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 576 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 576")
end


yyval16 := yytype16 (yyvs.item (yyvsp)) 
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_72 is
			--|#line 580 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 580 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 580")
end


				yyval16 := new_constant_as (create {VALUE_AS}.initialize (yytype7 (yyvs.item (yyvsp - 1))))
				feature_indexes := yytype81 (yyvs.item (yyvsp))
			
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_73 is
			--|#line 585 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 585 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 585")
end


				yyval16 := new_constant_as (create {VALUE_AS}.initialize (new_unique_as))
				feature_indexes := yytype81 (yyvs.item (yyvsp))
			
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_74 is
			--|#line 590 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 590 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 590")
end


				yyval16 := yytype56 (yyvs.item (yyvsp))
				feature_indexes := yytype81 (yyvs.item (yyvsp - 1))
			
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_75 is
			--|#line 601 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [PARENT_AS]
		do
--|#line 601 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 601")
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

	yy_do_action_76 is
			--|#line 603 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [PARENT_AS]
		do
--|#line 603 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 603")
end


yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_77 is
			--|#line 605 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [PARENT_AS]
		do
--|#line 605 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 605")
end


yyval85 := new_eiffel_list_parent_as (0) 
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_78 is
			--|#line 609 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [PARENT_AS]
		do
--|#line 609 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 609")
end


				yyval85 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval85.extend (yytype47 (yyvs.item (yyvsp)))
			
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_79 is
			--|#line 614 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [PARENT_AS]
		do
--|#line 614 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 614")
end


				yyval85 := yytype85 (yyvs.item (yyvsp - 1))
				yyval85.extend (yytype47 (yyvs.item (yyvsp)))
			
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_80 is
			--|#line 621 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 621 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 621")
end


				yyval47 := yytype47 (yyvs.item (yyvsp))
				yytype47 (yyvs.item (yyvsp)).set_location (yytype58 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_81 is
			--|#line 626 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 626 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 626")
end


				inherit_context := False
				yyval47 := yytype47 (yyvs.item (yyvsp - 1))
				yytype47 (yyvs.item (yyvsp - 1)).set_location (yytype58 (yyvs.item (yyvsp - 2)))
			
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_82 is
			--|#line 634 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 634 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 634")
end


				inherit_context := False
				yyval47 := new_parent_clause (yytype92 (yyvs.item (yyvsp - 1)), yytype89 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_83 is
			--|#line 639 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 639 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 639")
end


				inherit_context := False
				yyval47 := new_parent_clause (yytype92 (yyvs.item (yyvsp - 7)), yytype89 (yyvs.item (yyvsp - 6)), yytype86 (yyvs.item (yyvsp - 5)), yytype71 (yyvs.item (yyvsp - 4)), yytype76 (yyvs.item (yyvsp - 3)), yytype76 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_84 is
			--|#line 644 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 644 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 644")
end


				inherit_context := False
				yyval47 := new_parent_clause (yytype92 (yyvs.item (yyvsp - 6)), yytype89 (yyvs.item (yyvsp - 5)), Void, yytype71 (yyvs.item (yyvsp - 4)), yytype76 (yyvs.item (yyvsp - 3)), yytype76 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_85 is
			--|#line 649 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 649 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 649")
end


				inherit_context := False
				yyval47 := new_parent_clause (yytype92 (yyvs.item (yyvsp - 5)), yytype89 (yyvs.item (yyvsp - 4)), Void, Void, yytype76 (yyvs.item (yyvsp - 3)), yytype76 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_86 is
			--|#line 654 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 654 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 654")
end


				inherit_context := False
				yyval47 := new_parent_clause (yytype92 (yyvs.item (yyvsp - 4)), yytype89 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype76 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_87 is
			--|#line 659 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 659 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 659")
end


				inherit_context := False
				yyval47 := new_parent_clause (yytype92 (yyvs.item (yyvsp - 3)), yytype89 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype76 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_88 is
			--|#line 664 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 664 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 664")
end


				inherit_context := True
				real_class_end_position := current_position.end_position - 3
				yyval47 := new_parent_clause (yytype92 (yyvs.item (yyvsp - 2)), yytype89 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_89 is
			--|#line 672 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [RENAME_AS]
		do
--|#line 672 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 672")
end



			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_90 is
			--|#line 674 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [RENAME_AS]
		do
--|#line 674 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 674")
end


yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_91 is
			--|#line 678 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [RENAME_AS]
		do
--|#line 678 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 678")
end


				yyval86 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval86.extend (yytype51 (yyvs.item (yyvsp)))
			
			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_92 is
			--|#line 683 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [RENAME_AS]
		do
--|#line 683 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 683")
end


				yyval86 := yytype86 (yyvs.item (yyvsp - 2))
				yyval86.extend (yytype51 (yyvs.item (yyvsp)))
			
			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_93 is
			--|#line 690 "eiffel.y"
		local
			yyval51: RENAME_AS
		do
--|#line 690 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 690")
end


yyval51 := new_rename_pair (yytype93 (yyvs.item (yyvsp - 2)), yytype93 (yyvs.item (yyvsp))) 
			yyval := yyval51
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_94 is
			--|#line 694 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 694 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 694")
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

	yy_do_action_95 is
			--|#line 696 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 696 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 696")
end


yyval71 := yytype71 (yyvs.item (yyvsp)) 
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_96 is
			--|#line 700 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 700 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 700")
end


				if yytype71 (yyvs.item (yyvsp)).is_empty then
					yyval71 := Void
				else
					yyval71 := yytype71 (yyvs.item (yyvsp))
				end
			
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_97 is
			--|#line 708 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 708 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 708")
end



			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_98 is
			--|#line 712 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 712 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 712")
end


				yyval71 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				if yytype24 (yyvs.item (yyvsp)) /= Void then
					yyval71.extend (yytype24 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_99 is
			--|#line 719 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 719 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 719")
end


				yyval71 := yytype71 (yyvs.item (yyvsp - 1))
				if yytype24 (yyvs.item (yyvsp)) /= Void then
					yyval71.extend (yytype24 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_100 is
			--|#line 728 "eiffel.y"
		local
			yyval24: EXPORT_ITEM_AS
		do
--|#line 728 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 728")
end


				if yytype30 (yyvs.item (yyvsp - 1)) /= Void then
					yyval24 := new_export_item_as (new_client_as (yytype78 (yyvs.item (yyvsp - 2))), yytype30 (yyvs.item (yyvsp - 1)))
				end
			
			yyval := yyval24
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_101 is
			--|#line 736 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 736 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 736")
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

	yy_do_action_102 is
			--|#line 738 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 738 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 738")
end


yyval30 := new_all_as 
			yyval := yyval30
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_103 is
			--|#line 740 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 740 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 740")
end


yyval30 := new_feature_list_as (yytype76 (yyvs.item (yyvsp))) 
			yyval := yyval30
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_104 is
			--|#line 744 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 744 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 744")
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

	yy_do_action_105 is
			--|#line 746 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 746 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 746")
end


			yyval68 := yytype68 (yyvs.item (yyvsp))
		
			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_106 is
			--|#line 752 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 752 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 752")
end


			yyval68 := new_eiffel_list_convert (Initial_convert_list_size)
			yyval68.extend (yytype17 (yyvs.item (yyvsp)))
		
			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_107 is
			--|#line 757 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 757 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 757")
end


			yyval68 := yytype68 (yyvs.item (yyvsp - 2))
			yyval68.extend (yytype17 (yyvs.item (yyvsp)))
		
			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_108 is
			--|#line 765 "eiffel.y"
		local
			yyval17: CONVERT_FEAT_AS
		do
--|#line 765 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 765")
end


				-- True because this is a conversion feature used as a creation
				-- procedure in current class.
			yyval17 := new_convert_feat_as (True, yytype93 (yyvs.item (yyvsp - 5)).first, yytype89 (yyvs.item (yyvsp - 2)))
		
			yyval := yyval17
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_109 is
			--|#line 771 "eiffel.y"
		local
			yyval17: CONVERT_FEAT_AS
		do
--|#line 771 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 771")
end


				-- False because this is not a conversion feature used as a creation
				-- procedure.
			yyval17 := new_convert_feat_as (False, yytype93 (yyvs.item (yyvsp - 4)).first, yytype89 (yyvs.item (yyvsp - 1)))
		
			yyval := yyval17
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_110 is
			--|#line 779 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 779 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 779")
end


				yyval76 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval76.extend (yytype93 (yyvs.item (yyvsp)).first)
			
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_111 is
			--|#line 784 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 784 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 784")
end


				yyval76 := yytype76 (yyvs.item (yyvsp - 2))
				yyval76.extend (yytype93 (yyvs.item (yyvsp)).first)
			
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_112 is
			--|#line 791 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 791 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 791")
end



			yyval := yyval76
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

	yy_do_action_113 is
			--|#line 793 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 793 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 793")
end


yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_114 is
			--|#line 797 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 797 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 797")
end



			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_115 is
			--|#line 799 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 799 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 799")
end


yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_116 is
			--|#line 803 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 803 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 803")
end



			yyval := yyval76
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

	yy_do_action_117 is
			--|#line 805 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 805 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 805")
end


yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_118 is
			--|#line 809 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 809 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 809")
end



			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_119 is
			--|#line 811 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 811 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 811")
end


yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_120 is
			--|#line 815 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 815 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 815")
end



			yyval := yyval76
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

	yy_do_action_121 is
			--|#line 817 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 817 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 817")
end


yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_122 is
			--|#line 821 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 821 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 821")
end



			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_123 is
			--|#line 823 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 823 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 823")
end


yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_124 is
			--|#line 831 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 831 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 831")
end



			yyval := yyval90
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
			--|#line 833 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 833 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 833")
end


yyval90 := yytype90 (yyvs.item (yyvsp - 1)) 
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_126 is
			--|#line 837 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 837 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 837")
end



			yyval := yyval90
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

	yy_do_action_127 is
			--|#line 839 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 839 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 839")
end


yyval90 := yytype90 (yyvs.item (yyvsp)) 
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_128 is
			--|#line 843 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 843 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 843")
end


				yyval90 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval90.extend (yytype64 (yyvs.item (yyvsp)))
			
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_129 is
			--|#line 848 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 848 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 848")
end


				yyval90 := yytype90 (yyvs.item (yyvsp - 1))
				yyval90.extend (yytype64 (yyvs.item (yyvsp)))
			
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_130 is
			--|#line 855 "eiffel.y"
		local
			yyval64: TYPE_DEC_AS
		do
--|#line 855 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 855")
end


yyval64 := new_type_dec_as (yytype80 (yyvs.item (yyvsp - 5)), yytype63 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 4))) 
			yyval := yyval64
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_131 is
			--|#line 859 "eiffel.y"
		do
--|#line 859 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 859")
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

	yy_do_action_132 is
			--|#line 860 "eiffel.y"
		do
--|#line 860 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 860")
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

	yy_do_action_133 is
			--|#line 869 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 869 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 869")
end


yyval90 := new_eiffel_list_type_dec_as (0) 
			yyval := yyval90
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

	yy_do_action_134 is
			--|#line 871 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 871 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 871")
end


yyval90 := yytype90 (yyvs.item (yyvsp)) 
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_135 is
			--|#line 875 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 875 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 875")
end


				yyval90 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval90.extend (yytype64 (yyvs.item (yyvsp)))
			
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_136 is
			--|#line 880 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 880 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 880")
end


				yyval90 := yytype90 (yyvs.item (yyvsp - 1))
				yyval90.extend (yytype64 (yyvs.item (yyvsp)))
			
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_137 is
			--|#line 887 "eiffel.y"
		local
			yyval64: TYPE_DEC_AS
		do
--|#line 887 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 887")
end


yyval64 := new_type_dec_as (yytype80 (yyvs.item (yyvsp - 4)), yytype63 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval64
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_138 is
			--|#line 891 "eiffel.y"
		local
			yyval80: ARRAYED_LIST [INTEGER]
		do
--|#line 891 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 891")
end


				create yyval80.make (Initial_identifier_list_size)
				Names_heap.put (yytype33 (yyvs.item (yyvsp)))
				yyval80.extend (Names_heap.found_item)
			
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_139 is
			--|#line 897 "eiffel.y"
		local
			yyval80: ARRAYED_LIST [INTEGER]
		do
--|#line 897 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 897")
end


				yyval80 := yytype80 (yyvs.item (yyvsp - 2))
				Names_heap.put (yytype33 (yyvs.item (yyvsp)))
				yyval80.extend (Names_heap.found_item)
			
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_140 is
			--|#line 905 "eiffel.y"
		local
			yyval80: ARRAYED_LIST [INTEGER]
		do
--|#line 905 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 905")
end


create yyval80.make (0) 
			yyval := yyval80
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
			--|#line 907 "eiffel.y"
		local
			yyval80: ARRAYED_LIST [INTEGER]
		do
--|#line 907 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 907")
end


yyval80 := yytype80 (yyvs.item (yyvsp)) 
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_142 is
			--|#line 911 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 911 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 911")
end



			yyval := yyval63
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

	yy_do_action_143 is
			--|#line 913 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 913 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 913")
end


yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_144 is
			--|#line 917 "eiffel.y"
		local
			yyval56: ROUTINE_AS
		do
--|#line 917 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 917")
end


				yyval56 := new_routine_as (yytype60 (yyvs.item (yyvsp - 7)), yytype52 (yyvs.item (yyvsp - 5)), yytype90 (yyvs.item (yyvsp - 4)), yytype55 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp - 1)), fbody_pos, current_position, once_manifest_string_count)
				once_manifest_string_count := 0
			
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_145 is
			--|#line 917 "eiffel.y"
		local
			yyval56: ROUTINE_AS
		do
--|#line 917 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 917")
end


fbody_pos := current_position.start_position 
			yyval := yyval56
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

	yy_do_action_146 is
			--|#line 932 "eiffel.y"
		local
			yyval55: ROUT_BODY_AS
		do
--|#line 932 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 932")
end


yyval55 := yytype40 (yyvs.item (yyvsp)) 
			yyval := yyval55
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_147 is
			--|#line 934 "eiffel.y"
		local
			yyval55: ROUT_BODY_AS
		do
--|#line 934 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 934")
end


yyval55 := yytype26 (yyvs.item (yyvsp)) 
			yyval := yyval55
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_148 is
			--|#line 936 "eiffel.y"
		local
			yyval55: ROUT_BODY_AS
		do
--|#line 936 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 936")
end


yyval55 := new_deferred_as 
			yyval := yyval55
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_149 is
			--|#line 940 "eiffel.y"
		local
			yyval26: EXTERNAL_AS
		do
--|#line 940 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 940")
end


				yyval26 := new_external_as (yytype27 (yyvs.item (yyvsp - 1)), yytype60 (yyvs.item (yyvsp)))
				has_externals := True
			
			yyval := yyval26
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_150 is
			--|#line 947 "eiffel.y"
		local
			yyval27: EXTERNAL_LANG_AS
		do
--|#line 947 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 947")
end


yyval27 := new_external_lang_as (yytype60 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval27
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_151 is
			--|#line 952 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 952 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 952")
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

	yy_do_action_152 is
			--|#line 954 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 954 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 954")
end


yyval60 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_153 is
			--|#line 958 "eiffel.y"
		local
			yyval40: INTERNAL_AS
		do
--|#line 958 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 958")
end


yyval40 := new_do_as (yytype82 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_154 is
			--|#line 960 "eiffel.y"
		local
			yyval40: INTERNAL_AS
		do
--|#line 960 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 960")
end


yyval40 := new_once_as (yytype82 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_155 is
			--|#line 964 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 964 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 964")
end



			yyval := yyval90
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

	yy_do_action_156 is
			--|#line 966 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 966 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 966")
end


yyval90 := yytype90 (yyvs.item (yyvsp)) 
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_157 is
			--|#line 970 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 970 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 970")
end



			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_158 is
			--|#line 972 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 972 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 972")
end


yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_159 is
			--|#line 976 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 976 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 976")
end


				yyval82 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval82.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_160 is
			--|#line 981 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 981 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 981")
end


				yyval82 := yytype82 (yyvs.item (yyvsp - 1))
				yyval82.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_161 is
			--|#line 988 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 988 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 988")
end


yyval38 := yytype38 (yyvs.item (yyvsp - 1)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_162 is
			--|#line 992 "eiffel.y"
		do
--|#line 992 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 992")
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

	yy_do_action_163 is
			--|#line 993 "eiffel.y"
		do
--|#line 993 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 993")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_164 is
			--|#line 996 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 996 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 996")
end


yyval38 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_165 is
			--|#line 998 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 998 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 998")
end


yyval38 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_166 is
			--|#line 1000 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 1000 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1000")
end


yyval38 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_167 is
			--|#line 1002 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 1002 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1002")
end


yyval38 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_168 is
			--|#line 1004 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 1004 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1004")
end


yyval38 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_169 is
			--|#line 1006 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 1006 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1006")
end


yyval38 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_170 is
			--|#line 1008 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 1008 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1008")
end


yyval38 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_171 is
			--|#line 1010 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 1010 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1010")
end


yyval38 := yytype21 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_172 is
			--|#line 1012 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 1012 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1012")
end


yyval38 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_173 is
			--|#line 1014 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 1014 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1014")
end


yyval38 := yytype53 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_174 is
			--|#line 1018 "eiffel.y"
		local
			yyval52: REQUIRE_AS
		do
--|#line 1018 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1018")
end



			yyval := yyval52
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
			--|#line 1020 "eiffel.y"
		local
			yyval52: REQUIRE_AS
		do
--|#line 1020 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1020")
end


				id_level := Normal_level
				yyval52 := new_require_as (yytype88 (yyvs.item (yyvsp)))
			
			yyval := yyval52
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_176 is
			--|#line 1020 "eiffel.y"
		local
			yyval52: REQUIRE_AS
		do
--|#line 1020 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1020")
end


id_level := Assert_level 
			yyval := yyval52
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
			--|#line 1027 "eiffel.y"
		local
			yyval52: REQUIRE_AS
		do
--|#line 1027 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1027")
end


				id_level := Normal_level
				yyval52 := new_require_else_as (yytype88 (yyvs.item (yyvsp)))
			
			yyval := yyval52
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_178 is
			--|#line 1027 "eiffel.y"
		local
			yyval52: REQUIRE_AS
		do
--|#line 1027 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1027")
end


id_level := Assert_level 
			yyval := yyval52
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

	yy_do_action_179 is
			--|#line 1036 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1036 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1036")
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

	yy_do_action_180 is
			--|#line 1038 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1038 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1038")
end


				id_level := Normal_level
				yyval23 := new_ensure_as (yytype88 (yyvs.item (yyvsp)))
			
			yyval := yyval23
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_181 is
			--|#line 1038 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1038 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1038")
end


id_level := Assert_level 
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

	yy_do_action_182 is
			--|#line 1045 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1045 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1045")
end


				id_level := Normal_level
				yyval23 := new_ensure_then_as (yytype88 (yyvs.item (yyvsp)))
			
			yyval := yyval23
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_183 is
			--|#line 1045 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1045 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1045")
end


id_level := Assert_level 
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

	yy_do_action_184 is
			--|#line 1054 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1054 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1054")
end



			yyval := yyval88
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

	yy_do_action_185 is
			--|#line 1056 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1056 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1056")
end


				yyval88 := yytype88 (yyvs.item (yyvsp))
				if yyval88.is_empty then
					yyval88 := Void
				end
			
			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_186 is
			--|#line 1065 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1065 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1065")
end


				yyval88 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval88, yytype61 (yyvs.item (yyvsp)))
			
			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_187 is
			--|#line 1070 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1070 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1070")
end


				yyval88 := yytype88 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval88, yytype61 (yyvs.item (yyvsp)))
			
			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_188 is
			--|#line 1077 "eiffel.y"
		local
			yyval61: TAGGED_AS
		do
--|#line 1077 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1077")
end


yyval61 := yytype61 (yyvs.item (yyvsp - 1)) 
			yyval := yyval61
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_189 is
			--|#line 1081 "eiffel.y"
		local
			yyval61: TAGGED_AS
		do
--|#line 1081 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1081")
end


yyval61 := new_tagged_as (Void, yytype25 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval61
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_190 is
			--|#line 1083 "eiffel.y"
		local
			yyval61: TAGGED_AS
		do
--|#line 1083 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1083")
end


yyval61 := new_tagged_as (yytype33 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval61
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_191 is
			--|#line 1085 "eiffel.y"
		local
			yyval61: TAGGED_AS
		do
--|#line 1085 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1085")
end



			yyval := yyval61
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_192 is
			--|#line 1093 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1093 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1093")
end


yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_193 is
			--|#line 1095 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1095 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1095")
end


yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_194 is
			--|#line 1099 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1099 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1099")
end


				yyval63 := new_class_type (yytype92 (yyvs.item (yyvsp - 1)), yytype89 (yyvs.item (yyvsp)), True, False)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype58 (yyvs.item (yyvsp - 3)).start_position,
						yytype58 (yyvs.item (yyvsp - 3)).end_position, filename, 0, "Make an expanded version of the base class associated with this type."))
				end
			
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_195 is
			--|#line 1108 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1108 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1108")
end


yyval63 := new_class_type (yytype92 (yyvs.item (yyvsp - 1)), yytype89 (yyvs.item (yyvsp)), False, True) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_196 is
			--|#line 1110 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1110 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1110")
end


yyval63 := new_bits_as (yytype39 (yyvs.item (yyvsp))) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_197 is
			--|#line 1112 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1112 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1112")
end


yyval63 := new_bits_symbol_as (yytype33 (yyvs.item (yyvsp))) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_198 is
			--|#line 1114 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1114 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1114")
end


yyval63 := new_like_id_as (yytype33 (yyvs.item (yyvsp))) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_199 is
			--|#line 1116 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1116 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1116")
end


yyval63 := new_like_current_as 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_200 is
			--|#line 1120 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1120 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1120")
end


yyval63 := new_class_type (yytype92 (yyvs.item (yyvsp - 1)), yytype89 (yyvs.item (yyvsp)), False, False) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_201 is
			--|#line 1124 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_AS]
		do
--|#line 1124 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1124")
end



			yyval := yyval89
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

	yy_do_action_202 is
			--|#line 1126 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_AS]
		do
--|#line 1126 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1126")
end



			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_203 is
			--|#line 1128 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_AS]
		do
--|#line 1128 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1128")
end


yyval89 := yytype89 (yyvs.item (yyvsp - 1)) 
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_204 is
			--|#line 1132 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_AS]
		do
--|#line 1132 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1132")
end



			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_205 is
			--|#line 1134 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_AS]
		do
--|#line 1134 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1134")
end


yyval89 := yytype89 (yyvs.item (yyvsp - 1)) 
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_206 is
			--|#line 1138 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_AS]
		do
--|#line 1138 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1138")
end


				yyval89 := new_eiffel_list_type (Initial_type_list_size)
				yyval89.extend (yytype63 (yyvs.item (yyvsp)))
			
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_207 is
			--|#line 1143 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_AS]
		do
--|#line 1143 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1143")
end


				yyval89 := yytype89 (yyvs.item (yyvsp - 2))
				yyval89.extend (yytype63 (yyvs.item (yyvsp)))
			
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_208 is
			--|#line 1154 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1154 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1154")
end


				-- $$ := Void
				formal_generics_start_position := current_position.start_position
				formal_generics_end_position := 0
			
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

	yy_do_action_209 is
			--|#line 1160 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1160 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1160")
end


				yyval77 := yytype77 (yyvs.item (yyvsp - 1))
				formal_generics_start_position := yytype58 (yyvs.item (yyvsp - 3)).start_position
				formal_generics_end_position := current_position.start_position
			
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_210 is
			--|#line 1168 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1168 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1168")
end



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

	yy_do_action_211 is
			--|#line 1170 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1170 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1170")
end


yyval77 := yytype77 (yyvs.item (yyvsp)) 
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_212 is
			--|#line 1174 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1174 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1174")
end


				yyval77 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval77.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_213 is
			--|#line 1179 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1179 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1179")
end


				yyval77 := yytype77 (yyvs.item (yyvsp - 2))
				yyval77.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_214 is
			--|#line 1186 "eiffel.y"
		local
			yyval31: FORMAL_AS
		do
--|#line 1186 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1186")
end


				if None_classname.is_equal (token_buffer) then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `token_buffer' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					if not case_sensitive then
						token_buffer.to_upper
					end
					yyval31 := new_formal_as (create {ID_AS}.initialize (token_buffer), True, False)
				end
			
			yyval := yyval31
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_215 is
			--|#line 1203 "eiffel.y"
		local
			yyval31: FORMAL_AS
		do
--|#line 1203 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1203")
end


				if None_classname.is_equal (token_buffer) then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `token_buffer' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					if not case_sensitive then
						token_buffer.to_upper
					end
					yyval31 := new_formal_as (create {ID_AS}.initialize (token_buffer), False, True)
				end
			
			yyval := yyval31
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_216 is
			--|#line 1221 "eiffel.y"
		local
			yyval31: FORMAL_AS
		do
--|#line 1221 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1221")
end


				if None_classname.is_equal (token_buffer) then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `token_buffer' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					if not case_sensitive then
						token_buffer.to_upper
					end
					yyval31 := new_formal_as (create {ID_AS}.initialize (token_buffer), False, False)
				end
			
			yyval := yyval31
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_217 is
			--|#line 1240 "eiffel.y"
		local
			yyval32: FORMAL_DEC_AS
		do
--|#line 1240 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1240")
end


				yyval32 := new_formal_dec_as (yytype31 (yyvs.item (yyvsp - 2)), yytype96 (yyvs.item (yyvsp)).first, yytype96 (yyvs.item (yyvsp)).second)
			
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_218 is
			--|#line 1240 "eiffel.y"
		local
			yyval32: FORMAL_DEC_AS
		do
--|#line 1240 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1240")
end


					-- Needs to be done here, in case current formal is used in
					-- Constraint.
				formal_parameters.extend (yytype31 (yyvs.item (yyvsp)))
				yytype31 (yyvs.item (yyvsp)).set_position (formal_parameters.count)
			
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

	yy_do_action_219 is
			--|#line 1253 "eiffel.y"
		local
			yyval96: PAIR [TYPE_AS, EIFFEL_LIST [FEATURE_NAME]]
		do
--|#line 1253 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1253")
end


create yyval96 
			yyval := yyval96
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
			--|#line 1255 "eiffel.y"
		local
			yyval96: PAIR [TYPE_AS, EIFFEL_LIST [FEATURE_NAME]]
		do
--|#line 1255 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1255")
end


				create yyval96
				yyval96.set_first (yytype63 (yyvs.item (yyvsp - 1)))
				yyval96.set_second (yytype76 (yyvs.item (yyvsp)))
			
			yyval := yyval96
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_221 is
			--|#line 1263 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 1263 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1263")
end



			yyval := yyval76
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

	yy_do_action_222 is
			--|#line 1265 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 1265 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1265")
end


yyval76 := yytype76 (yyvs.item (yyvsp - 1)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_223 is
			--|#line 1273 "eiffel.y"
		local
			yyval34: IF_AS
		do
--|#line 1273 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1273")
end


				yyval34 := new_if_as (yytype25 (yyvs.item (yyvsp - 5)), yytype82 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 7)), current_position)
			
			yyval := yyval34
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_224 is
			--|#line 1279 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1279 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1279")
end



			yyval := yyval70
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
			--|#line 1281 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1281 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1281")
end


yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_226 is
			--|#line 1285 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1285 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1285")
end


				yyval70 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval70.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_227 is
			--|#line 1290 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1290 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1290")
end


				yyval70 := yytype70 (yyvs.item (yyvsp - 1))
				yyval70.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_228 is
			--|#line 1297 "eiffel.y"
		local
			yyval22: ELSIF_AS
		do
--|#line 1297 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1297")
end


yyval22 := new_elseif_as (yytype25 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 4))) 
			yyval := yyval22
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_229 is
			--|#line 1301 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1301 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1301")
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

	yy_do_action_230 is
			--|#line 1303 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1303 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1303")
end


yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_231 is
			--|#line 1307 "eiffel.y"
		local
			yyval36: INSPECT_AS
		do
--|#line 1307 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1307")
end


				yyval36 := new_inspect_as (yytype25 (yyvs.item (yyvsp - 3)), yytype67 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_232 is
			--|#line 1313 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CASE_AS]
		do
--|#line 1313 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1313")
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

	yy_do_action_233 is
			--|#line 1315 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CASE_AS]
		do
--|#line 1315 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1315")
end


yyval67 := yytype67 (yyvs.item (yyvsp)) 
			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_234 is
			--|#line 1319 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CASE_AS]
		do
--|#line 1319 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1319")
end


				yyval67 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval67.extend (yytype12 (yyvs.item (yyvsp)))
			
			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_235 is
			--|#line 1324 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CASE_AS]
		do
--|#line 1324 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1324")
end


				yyval67 := yytype67 (yyvs.item (yyvsp - 1))
				yyval67.extend (yytype12 (yyvs.item (yyvsp)))
			
			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_236 is
			--|#line 1331 "eiffel.y"
		local
			yyval12: CASE_AS
		do
--|#line 1331 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1331")
end


yyval12 := new_case_as (yytype83 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval12
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_237 is
			--|#line 1335 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line 1335 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1335")
end


				yyval83 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval83.extend (yytype41 (yyvs.item (yyvsp)))
			
			yyval := yyval83
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_238 is
			--|#line 1340 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line 1340 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1340")
end


				yyval83 := yytype83 (yyvs.item (yyvsp - 2))
				yyval83.extend (yytype41 (yyvs.item (yyvsp)))
			
			yyval := yyval83
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_239 is
			--|#line 1347 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1347 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1347")
end


yyval41 := new_interval_as (yytype39 (yyvs.item (yyvsp)), Void) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_240 is
			--|#line 1349 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1349 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1349")
end


yyval41 := new_interval_as (yytype39 (yyvs.item (yyvsp - 2)), yytype39 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_241 is
			--|#line 1351 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1351 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1351")
end


yyval41 := new_interval_as (yytype13 (yyvs.item (yyvsp)), Void) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_242 is
			--|#line 1353 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1353 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1353")
end


yyval41 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_243 is
			--|#line 1355 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1355 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1355")
end


yyval41 := new_interval_as (yytype33 (yyvs.item (yyvsp)), Void) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_244 is
			--|#line 1357 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1357 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1357")
end


yyval41 := new_interval_as (yytype33 (yyvs.item (yyvsp - 2)), yytype33 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_245 is
			--|#line 1359 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1359 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1359")
end


yyval41 := new_interval_as (yytype33 (yyvs.item (yyvsp - 2)), yytype39 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_246 is
			--|#line 1361 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1361 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1361")
end


yyval41 := new_interval_as (yytype39 (yyvs.item (yyvsp - 2)), yytype33 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_247 is
			--|#line 1363 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1363 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1363")
end


yyval41 := new_interval_as (yytype33 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_248 is
			--|#line 1365 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1365 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1365")
end


yyval41 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype33 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_249 is
			--|#line 1367 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1367 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1367")
end


yyval41 := new_interval_as (yytype49 (yyvs.item (yyvsp)), Void) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_250 is
			--|#line 1369 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1369 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1369")
end


yyval41 := new_interval_as (yytype49 (yyvs.item (yyvsp - 2)), yytype33 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_251 is
			--|#line 1371 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1371 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1371")
end


yyval41 := new_interval_as (yytype33 (yyvs.item (yyvsp - 2)), yytype49 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_252 is
			--|#line 1373 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1373 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1373")
end


yyval41 := new_interval_as (yytype49 (yyvs.item (yyvsp - 2)), yytype49 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_253 is
			--|#line 1375 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1375 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1375")
end


yyval41 := new_interval_as (yytype49 (yyvs.item (yyvsp - 2)), yytype39 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_254 is
			--|#line 1377 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1377 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1377")
end


yyval41 := new_interval_as (yytype39 (yyvs.item (yyvsp - 2)), yytype49 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_255 is
			--|#line 1379 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1379 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1379")
end


yyval41 := new_interval_as (yytype49 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_256 is
			--|#line 1381 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1381 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1381")
end


yyval41 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype49 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_257 is
			--|#line 1386 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1386 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1386")
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

	yy_do_action_258 is
			--|#line 1388 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1388 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1388")
end


				yyval82 := yytype82 (yyvs.item (yyvsp))
				if yyval82 = Void then
					yyval82 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_259 is
			--|#line 1397 "eiffel.y"
		local
			yyval43: LOOP_AS
		do
--|#line 1397 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1397")
end


				yyval43 := new_loop_as (yytype82 (yyvs.item (yyvsp - 8)), yytype88 (yyvs.item (yyvsp - 7)), yytype65 (yyvs.item (yyvsp - 6)), yytype25 (yyvs.item (yyvsp - 3)), yytype82 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 10
	yyvsp := yyvsp - 9
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_260 is
			--|#line 1403 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1403 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1403")
end



			yyval := yyval88
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
			--|#line 1405 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1405 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1405")
end


yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_262 is
			--|#line 1409 "eiffel.y"
		local
			yyval42: INVARIANT_AS
		do
--|#line 1409 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1409")
end



			yyval := yyval42
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

	yy_do_action_263 is
			--|#line 1411 "eiffel.y"
		local
			yyval42: INVARIANT_AS
		do
--|#line 1411 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1411")
end


				id_level := Normal_level
				inherit_context := False
				yyval42 := new_invariant_as (yytype88 (yyvs.item (yyvsp)), once_manifest_string_count)
				once_manifest_string_count := 0
			
			yyval := yyval42
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_264 is
			--|#line 1411 "eiffel.y"
		local
			yyval42: INVARIANT_AS
		do
--|#line 1411 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1411")
end


id_level := Invariant_level 
			yyval := yyval42
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
			--|#line 1422 "eiffel.y"
		local
			yyval65: VARIANT_AS
		do
--|#line 1422 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1422")
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

	yy_do_action_266 is
			--|#line 1424 "eiffel.y"
		local
			yyval65: VARIANT_AS
		do
--|#line 1424 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1424")
end


yyval65 := new_variant_as (yytype33 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval65
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_267 is
			--|#line 1426 "eiffel.y"
		local
			yyval65: VARIANT_AS
		do
--|#line 1426 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1426")
end


yyval65 := new_variant_as (Void, yytype25 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval65
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_268 is
			--|#line 1430 "eiffel.y"
		local
			yyval21: DEBUG_AS
		do
--|#line 1430 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1430")
end


				yyval21 := new_debug_as (yytype87 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval21
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_269 is
			--|#line 1436 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1436 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1436")
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

	yy_do_action_270 is
			--|#line 1438 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1438 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1438")
end



			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_271 is
			--|#line 1440 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1440 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1440")
end


yyval87 := yytype87 (yyvs.item (yyvsp - 1)) 
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_272 is
			--|#line 1444 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1444 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1444")
end


				yyval87 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval87.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_273 is
			--|#line 1449 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1449 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1449")
end


				yyval87 := yytype87 (yyvs.item (yyvsp - 2))
				yyval87.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_274 is
			--|#line 1456 "eiffel.y"
		local
			yyval53: RETRY_AS
		do
--|#line 1456 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1456")
end


yyval53 := new_retry_as (current_position) 
			yyval := yyval53
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_275 is
			--|#line 1460 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1460 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1460")
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

	yy_do_action_276 is
			--|#line 1462 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1462 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1462")
end


				yyval82 := yytype82 (yyvs.item (yyvsp))
				if yyval82 = Void then
					yyval82 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_277 is
			--|#line 1471 "eiffel.y"
		local
			yyval6: ASSIGN_AS
		do
--|#line 1471 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1471")
end


yyval6 := new_assign_as (new_access_id_as (yytype33 (yyvs.item (yyvsp - 2)), Void), yytype25 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_278 is
			--|#line 1473 "eiffel.y"
		local
			yyval6: ASSIGN_AS
		do
--|#line 1473 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1473")
end


yyval6 := new_assign_as (new_result_as, yytype25 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_279 is
			--|#line 1477 "eiffel.y"
		local
			yyval54: REVERSE_AS
		do
--|#line 1477 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1477")
end


yyval54 := new_reverse_as (new_access_id_as (yytype33 (yyvs.item (yyvsp - 2)), Void), yytype25 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval54
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_280 is
			--|#line 1479 "eiffel.y"
		local
			yyval54: REVERSE_AS
		do
--|#line 1479 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1479")
end


yyval54 := new_reverse_as (new_result_as, yytype25 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval54
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_281 is
			--|#line 1483 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1483 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1483")
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

	yy_do_action_282 is
			--|#line 1485 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1485 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1485")
end


yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_283 is
			--|#line 1489 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1489 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1489")
end


				yyval69 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval69.extend (yytype18 (yyvs.item (yyvsp)))
			
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_284 is
			--|#line 1494 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1494 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1494")
end


				yyval69 := yytype69 (yyvs.item (yyvsp - 1))
				yyval69.extend (yytype18 (yyvs.item (yyvsp)))
			
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_285 is
			--|#line 1501 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1501 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1501")
end


				inherit_context := False
				yyval18 := new_create_as (Void, Void)
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_286 is
			--|#line 1507 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1507 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1507")
end


				inherit_context := False
				yyval18 := new_create_as (yytype15 (yyvs.item (yyvsp - 1)), yytype76 (yyvs.item (yyvsp)))
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_287 is
			--|#line 1512 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1512 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1512")
end


				inherit_context := False
				yyval18 := new_create_as (new_client_as (yytype78 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_288 is
			--|#line 1517 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1517 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1517")
end


				inherit_context := False
				yyval18 := new_create_as (Void, Void)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype58 (yyvs.item (yyvsp - 1)).start_position,
						yytype58 (yyvs.item (yyvsp - 1)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_289 is
			--|#line 1527 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1527 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1527")
end


				inherit_context := False
				yyval18 := new_create_as (yytype15 (yyvs.item (yyvsp - 1)), yytype76 (yyvs.item (yyvsp)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype58 (yyvs.item (yyvsp - 3)).start_position,
						yytype58 (yyvs.item (yyvsp - 3)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_290 is
			--|#line 1537 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1537 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1537")
end


				inherit_context := False
				yyval18 := new_create_as (new_client_as (yytype78 (yyvs.item (yyvsp))), Void)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype58 (yyvs.item (yyvsp - 2)).start_position,
						yytype58 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_291 is
			--|#line 1549 "eiffel.y"
		local
			yyval57: ROUTINE_CREATION_AS
		do
--|#line 1549 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1549")
end


yyval57 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), False) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_292 is
			--|#line 1551 "eiffel.y"
		local
			yyval57: ROUTINE_CREATION_AS
		do
--|#line 1551 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1551")
end


yyval57 := new_routine_creation_as (yytype46 (yyvs.item (yyvsp - 3)), yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), True) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_293 is
			--|#line 1553 "eiffel.y"
		local
			yyval57: ROUTINE_CREATION_AS
		do
--|#line 1553 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1553")
end


			yyval57 := yytype59 (yyvs.item (yyvsp)).first
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype59 (yyvs.item (yyvsp)).second.start_position,
					yytype59 (yyvs.item (yyvsp)).second.end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_294 is
			--|#line 1571 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1571 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1571")
end


yyval59 := new_old_routine_creation_as (yytype58 (yyvs.item (yyvsp - 2)), new_operand_as (Void, Void, Void), yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), False) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_295 is
			--|#line 1573 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1573 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1573")
end


yyval59 := new_old_routine_creation_as (yytype58 (yyvs.item (yyvsp - 2)), new_operand_as (Void, yytype33 (yyvs.item (yyvsp - 4)), Void), yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), True) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_296 is
			--|#line 1575 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1575 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1575")
end


yyval59 := new_old_routine_creation_as (yytype58 (yyvs.item (yyvsp - 2)), new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp - 5))), yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), True) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_297 is
			--|#line 1577 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1577 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1577")
end


yyval59 := new_old_routine_creation_as (yytype58 (yyvs.item (yyvsp - 2)), new_result_operand_as, yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), True) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_298 is
			--|#line 1579 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1579 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1579")
end


yyval59 := new_old_routine_creation_as (yytype58 (yyvs.item (yyvsp - 2)), new_operand_as (Void, Void, Void), yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), True) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_299 is
			--|#line 1581 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1581 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1581")
end


yyval59 := new_old_routine_creation_as (yytype58 (yyvs.item (yyvsp - 2)), new_operand_as (yytype63 (yyvs.item (yyvsp - 4)), Void, Void), yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), True) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_300 is
			--|#line 1583 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1583 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1583")
end


yyval59 := new_old_routine_creation_as (yytype58 (yyvs.item (yyvsp - 2)), Void, yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), True) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_301 is
			--|#line 1587 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1587 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1587")
end


yyval46 := new_operand_as (Void, yytype33 (yyvs.item (yyvsp)), Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_302 is
			--|#line 1589 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1589 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1589")
end


yyval46 := new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_303 is
			--|#line 1591 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1591 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1591")
end


yyval46 := new_result_operand_as 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_304 is
			--|#line 1593 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1593 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1593")
end


yyval46 := new_operand_as (Void, Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_305 is
			--|#line 1595 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1595 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1595")
end


yyval46 := new_operand_as (yytype63 (yyvs.item (yyvsp - 1)), Void, Void)
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_306 is
			--|#line 1597 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1597 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1597")
end


yyval46 := Void 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_307 is
			--|#line 1601 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1601 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1601")
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

	yy_do_action_308 is
			--|#line 1603 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1603 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1603")
end



			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_309 is
			--|#line 1605 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1605 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1605")
end


yyval84 := yytype84 (yyvs.item (yyvsp - 1)) 
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_310 is
			--|#line 1609 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1609 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1609")
end


				yyval84 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval84.extend (yytype46 (yyvs.item (yyvsp)))
			
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_311 is
			--|#line 1614 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1614 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1614")
end


				yyval84 := yytype84 (yyvs.item (yyvsp - 2))
				yyval84.extend (yytype46 (yyvs.item (yyvsp)))
			
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_312 is
			--|#line 1621 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1621 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1621")
end


yyval46 := new_operand_as (Void, Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_313 is
			--|#line 1627 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1627 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1627")
end


yyval46 := new_operand_as (new_class_type (yytype92 (yyvs.item (yyvsp - 1)), Void, False, False), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_314 is
			--|#line 1629 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1629 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1629")
end


yyval46 := new_operand_as (new_class_type (yytype92 (yyvs.item (yyvsp - 2)), yytype89 (yyvs.item (yyvsp - 1)), False, False), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_315 is
			--|#line 1631 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1631 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1631")
end


				yyval46 := new_operand_as (new_class_type (yytype92 (yyvs.item (yyvsp - 2)), yytype89 (yyvs.item (yyvsp - 1)), True, False), Void, Void)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype58 (yyvs.item (yyvsp - 5)).start_position,
						yytype58 (yyvs.item (yyvsp - 5)).end_position, filename, 0, "Make an expanded version of the base class associated with this type."))
				end
		
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_316 is
			--|#line 1640 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1640 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1640")
end


yyval46 := new_operand_as (new_class_type (yytype92 (yyvs.item (yyvsp - 2)), yytype89 (yyvs.item (yyvsp - 1)), False, True), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_317 is
			--|#line 1642 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1642 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1642")
end


yyval46 := new_operand_as (new_bits_as (yytype39 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_318 is
			--|#line 1644 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1644 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1644")
end


yyval46 := new_operand_as (new_bits_symbol_as (yytype33 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_319 is
			--|#line 1646 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1646 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1646")
end


yyval46 := new_operand_as (new_like_id_as (yytype33 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_320 is
			--|#line 1648 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1648 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1648")
end


yyval46 := new_operand_as (new_like_current_as, Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_321 is
			--|#line 1650 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1650 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1650")
end


yyval46 := new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_322 is
			--|#line 1654 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1654 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1654")
end


				yyval19 := new_creation_as (yytype63 (yyvs.item (yyvsp - 3)), yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 5)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype58 (yyvs.item (yyvsp - 5)).start_position,
						yytype58 (yyvs.item (yyvsp - 5)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_323 is
			--|#line 1663 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1663 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1663")
end


yyval19 := new_creation_as (Void, yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_324 is
			--|#line 1665 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1665 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1665")
end


yyval19 := new_creation_as (yytype63 (yyvs.item (yyvsp - 3)), yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 6))) 
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_325 is
			--|#line 1669 "eiffel.y"
		local
			yyval20: CREATION_EXPR_AS
		do
--|#line 1669 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1669")
end


yyval20 := new_creation_expr_as (yytype63 (yyvs.item (yyvsp - 3)), yytype4 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval20
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_326 is
			--|#line 1671 "eiffel.y"
		local
			yyval20: CREATION_EXPR_AS
		do
--|#line 1671 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1671")
end


				yyval20 := new_creation_expr_as (yytype63 (yyvs.item (yyvsp - 3)), yytype4 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype58 (yyvs.item (yyvsp - 1)).start_position,
						yytype58 (yyvs.item (yyvsp - 1)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval20
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_327 is
			--|#line 1682 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1682 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1682")
end



			yyval := yyval63
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

	yy_do_action_328 is
			--|#line 1684 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1684 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1684")
end


yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_329 is
			--|#line 1688 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1688 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1688")
end


yyval2 := new_access_id_as (yytype33 (yyvs.item (yyvsp)), Void) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_330 is
			--|#line 1690 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1690 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1690")
end


yyval2 := new_result_as 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_331 is
			--|#line 1694 "eiffel.y"
		local
			yyval4: ACCESS_INV_AS
		do
--|#line 1694 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1694")
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

	yy_do_action_332 is
			--|#line 1696 "eiffel.y"
		local
			yyval4: ACCESS_INV_AS
		do
--|#line 1696 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1696")
end


yyval4 := new_access_inv_as (yytype33 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_333 is
			--|#line 1704 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1704 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1704")
end


yyval37 := new_instr_call_as (yytype2 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_334 is
			--|#line 1706 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1706 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1706")
end


yyval37 := new_instr_call_as (yytype44 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_335 is
			--|#line 1708 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1708 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1708")
end


yyval37 := new_instr_call_as (yytype44 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_336 is
			--|#line 1710 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1710 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1710")
end


yyval37 := new_instr_call_as (yytype44 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_337 is
			--|#line 1712 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1712 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1712")
end


yyval37 := new_instr_call_as (yytype45 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_338 is
			--|#line 1714 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1714 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1714")
end


yyval37 := new_instr_call_as (yytype48 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_339 is
			--|#line 1716 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1716 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1716")
end


yyval37 := new_instr_call_as (yytype44 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_340 is
			--|#line 1718 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1718 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1718")
end


yyval37 := new_instr_call_as (yytype49 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_341 is
			--|#line 1720 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1720 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1720")
end


yyval37 := new_instr_call_as (yytype44 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_342 is
			--|#line 1724 "eiffel.y"
		local
			yyval14: CHECK_AS
		do
--|#line 1724 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1724")
end


yyval14 := new_check_as (yytype88 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 3)), current_position) 
			yyval := yyval14
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_343 is
			--|#line 1732 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1732 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1732")
end


create {VALUE_AS} yyval25.initialize (yytype39 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_344 is
			--|#line 1735 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1735 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1735")
end


yyval25 := yytype25 (yyvs.item (yyvsp)) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_345 is
			--|#line 1737 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1737 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1737")
end


yyval25 := new_bin_plus_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_346 is
			--|#line 1739 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1739 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1739")
end


yyval25 := new_bin_minus_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_347 is
			--|#line 1741 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1741 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1741")
end


yyval25 := new_bin_star_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_348 is
			--|#line 1743 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1743 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1743")
end


yyval25 := new_bin_slash_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_349 is
			--|#line 1745 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1745 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1745")
end


yyval25 := new_bin_mod_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_350 is
			--|#line 1747 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1747 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1747")
end


yyval25 := new_bin_div_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_351 is
			--|#line 1749 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1749 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1749")
end


yyval25 := new_bin_power_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_352 is
			--|#line 1751 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1751 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1751")
end


yyval25 := new_bin_and_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_353 is
			--|#line 1753 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1753 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1753")
end


yyval25 := new_bin_and_then_as (yytype25 (yyvs.item (yyvsp - 3)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_354 is
			--|#line 1755 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1755 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1755")
end


yyval25 := new_bin_or_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_355 is
			--|#line 1757 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1757 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1757")
end


yyval25 := new_bin_or_else_as (yytype25 (yyvs.item (yyvsp - 3)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_356 is
			--|#line 1759 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1759 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1759")
end


yyval25 := new_bin_implies_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_357 is
			--|#line 1761 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1761 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1761")
end


yyval25 := new_bin_xor_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_358 is
			--|#line 1763 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1763 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1763")
end


yyval25 := new_bin_ge_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_359 is
			--|#line 1765 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1765 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1765")
end


yyval25 := new_bin_gt_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_360 is
			--|#line 1767 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1767 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1767")
end


yyval25 := new_bin_le_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_361 is
			--|#line 1769 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1769 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1769")
end


yyval25 := new_bin_lt_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_362 is
			--|#line 1771 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1771 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1771")
end


yyval25 := new_bin_eq_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_363 is
			--|#line 1773 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1773 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1773")
end


yyval25 := new_bin_ne_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_364 is
			--|#line 1775 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1775 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1775")
end


yyval25 := new_bin_free_as (yytype25 (yyvs.item (yyvsp - 2)), yytype33 (yyvs.item (yyvsp - 1)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_365 is
			--|#line 1779 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1779 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1779")
end


create {VALUE_AS} yyval25.initialize (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_366 is
			--|#line 1782 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1782 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1782")
end


create {VALUE_AS} yyval25.initialize (yytype39 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_367 is
			--|#line 1784 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1784 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1784")
end


create {VOID_AS} yyval25 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_368 is
			--|#line 1786 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1786 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1786")
end


create {VALUE_AS} yyval25.initialize (yytype5 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_369 is
			--|#line 1788 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1788 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1788")
end


create {VALUE_AS} yyval25.initialize (yytype62 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_370 is
			--|#line 1790 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1790 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1790")
end


yyval25 := new_expr_call_as (yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_371 is
			--|#line 1792 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1792 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1792")
end


yyval25 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_372 is
			--|#line 1794 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1794 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1794")
end


yyval25 := new_paran_as (yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_373 is
			--|#line 1796 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1796 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1796")
end


yyval25 := new_un_minus_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_374 is
			--|#line 1798 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1798 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1798")
end


yyval25 := new_un_plus_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_375 is
			--|#line 1800 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1800 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1800")
end


yyval25 := new_un_not_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_376 is
			--|#line 1802 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1802 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1802")
end


yyval25 := new_un_old_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_377 is
			--|#line 1804 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1804 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1804")
end


yyval25 := new_un_free_as (yytype33 (yyvs.item (yyvsp - 1)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_378 is
			--|#line 1806 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1806 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1806")
end


yyval25 := new_un_strip_as (yytype80 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_379 is
			--|#line 1808 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1808 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1808")
end


yyval25 := new_address_as (yytype93 (yyvs.item (yyvsp)).first) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_380 is
			--|#line 1810 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1810 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1810")
end


yyval25 := new_expr_address_as (yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_381 is
			--|#line 1812 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1812 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1812")
end


yyval25 := new_address_current_as 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_382 is
			--|#line 1814 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1814 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1814")
end


yyval25 := new_address_result_as 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_383 is
			--|#line 1818 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1818 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1818")
end


create yyval33.initialize (token_buffer) 
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_384 is
			--|#line 1826 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1826 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1826")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_385 is
			--|#line 1828 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1828 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1828")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_386 is
			--|#line 1830 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1830 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1830")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_387 is
			--|#line 1832 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1832 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1832")
end


yyval11 := new_current_as 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_388 is
			--|#line 1834 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1834 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1834")
end


yyval11 := new_result_as 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_389 is
			--|#line 1836 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1836 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1836")
end


yyval11 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_390 is
			--|#line 1838 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1838 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1838")
end


yyval11 := yytype45 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_391 is
			--|#line 1840 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1840 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1840")
end


yyval11 := yytype48 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_392 is
			--|#line 1842 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1842 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1842")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_393 is
			--|#line 1844 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1844 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1844")
end


yyval11 := yytype49 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_394 is
			--|#line 1846 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1846 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1846")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_395 is
			--|#line 1848 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1848 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1848")
end


yyval11 := yytype20 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_396 is
			--|#line 1852 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1852 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1852")
end


yyval44 := new_nested_as (new_current_as, yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_397 is
			--|#line 1856 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1856 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1856")
end


yyval44 := new_nested_as (new_result_as, yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_398 is
			--|#line 1860 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1860 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1860")
end


yyval44 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_399 is
			--|#line 1864 "eiffel.y"
		local
			yyval45: NESTED_EXPR_AS
		do
--|#line 1864 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1864")
end


yyval45 := new_nested_expr_as (yytype25 (yyvs.item (yyvsp - 3)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_400 is
			--|#line 1868 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1868 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1868")
end


yyval44 := new_nested_as (yytype48 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_401 is
			--|#line 1872 "eiffel.y"
		local
			yyval48: PRECURSOR_AS
		do
--|#line 1872 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1872")
end


yyval48 := new_precursor_as (Void, yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_402 is
			--|#line 1874 "eiffel.y"
		local
			yyval48: PRECURSOR_AS
		do
--|#line 1874 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1874")
end


yyval48 := new_precursor (yytype92 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp)), Void) 
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_403 is
			--|#line 1876 "eiffel.y"
		local
			yyval48: PRECURSOR_AS
		do
--|#line 1876 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1876")
end


yyval48 := new_precursor (yytype92 (yyvs.item (yyvsp - 5)), yytype72 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 2))) 
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_404 is
			--|#line 1878 "eiffel.y"
		local
			yyval48: PRECURSOR_AS
		do
--|#line 1878 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1878")
end


yyval48 := new_precursor (yytype92 (yyvs.item (yyvsp - 4)), yytype72 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 2))) 
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_405 is
			--|#line 1882 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1882 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1882")
end


yyval44 := new_nested_as (yytype49 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_406 is
			--|#line 1886 "eiffel.y"
		local
			yyval49: STATIC_ACCESS_AS
		do
--|#line 1886 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1886")
end


				yyval49 := new_static_access_as (yytype63 (yyvs.item (yyvsp - 4)), yytype33 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp)));
			
			yyval := yyval49
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_407 is
			--|#line 1893 "eiffel.y"
		local
			yyval49: STATIC_ACCESS_AS
		do
--|#line 1893 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1893")
end


				yyval49 := new_static_access_as (yytype63 (yyvs.item (yyvsp - 3)), yytype33 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval49
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_408 is
			--|#line 1901 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1901 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1901")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_409 is
			--|#line 1903 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1903 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1903")
end


yyval11 := yytype3 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_410 is
			--|#line 1907 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1907 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1907")
end


yyval44 := new_nested_as (yytype3 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_411 is
			--|#line 1909 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1909 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1909")
end


yyval44 := new_nested_as (yytype3 (yyvs.item (yyvsp - 2)), yytype44 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_412 is
			--|#line 1913 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1913 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1913")
end


yyval33 := yytype33 (yyvs.item (yyvsp))
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_413 is
			--|#line 1915 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1915 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1915")
end


yyval33 := yytype93 (yyvs.item (yyvsp)).first.internal_name 
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_414 is
			--|#line 1917 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1917 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1917")
end


yyval33 := yytype93 (yyvs.item (yyvsp)).first.internal_name 
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_415 is
			--|#line 1921 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1921 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1921")
end


				inspect id_level
				when Normal_level then
					yyval2 := new_access_id_as (yytype33 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp)))
				when Assert_level then
					yyval2 := new_access_assert_as (yytype33 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp)))
				when Invariant_level then
					yyval2 := new_access_inv_as (yytype33 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_416 is
			--|#line 1934 "eiffel.y"
		local
			yyval3: ACCESS_FEAT_AS
		do
--|#line 1934 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1934")
end


yyval3 := new_access_feat_as (yytype33 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval3
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_417 is
			--|#line 1938 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1938 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1938")
end



			yyval := yyval72
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

	yy_do_action_418 is
			--|#line 1940 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1940 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1940")
end



			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_419 is
			--|#line 1942 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1942 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1942")
end


yyval72 := yytype72 (yyvs.item (yyvsp - 1)) 
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_420 is
			--|#line 1946 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1946 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1946")
end


				yyval72 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval72.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_421 is
			--|#line 1951 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1951 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1951")
end


				yyval72 := yytype72 (yyvs.item (yyvsp - 2))
				yyval72.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_422 is
			--|#line 1958 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1958 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1958")
end


yyval72 := new_eiffel_list_expr_as (0) 
			yyval := yyval72
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

	yy_do_action_423 is
			--|#line 1960 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1960 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1960")
end


yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_424 is
			--|#line 1964 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1964 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1964")
end


				yyval72 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval72.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_425 is
			--|#line 1969 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1969 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1969")
end


				yyval72 := yytype72 (yyvs.item (yyvsp - 2))
				yyval72.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_426 is
			--|#line 1980 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1980 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1980")
end


				if not case_sensitive then
					token_buffer.to_lower
				end
				create yyval33.initialize (token_buffer)
			
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_427 is
			--|#line 1989 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1989 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1989")
end


yyval7 := yytype10 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_428 is
			--|#line 1991 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1991 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1991")
end


yyval7 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_429 is
			--|#line 1993 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1993 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1993")
end


yyval7 := yytype39 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_430 is
			--|#line 1995 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1995 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1995")
end


yyval7 := yytype50 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_431 is
			--|#line 1997 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1997 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1997")
end


yyval7 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_432 is
			--|#line 1999 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1999 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1999")
end


yyval7 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_433 is
			--|#line 2003 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 2003 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2003")
end


yyval7 := yytype10 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_434 is
			--|#line 2006 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 2006 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2006")
end


yyval7 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_435 is
			--|#line 2008 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 2008 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2008")
end


yyval7 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_436 is
			--|#line 2010 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 2010 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2010")
end


yyval7 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_437 is
			--|#line 2012 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 2012 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2012")
end


yyval7 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_438 is
			--|#line 2014 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 2014 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2014")
end


				yytype60 (yyvs.item (yyvsp)).set_is_once_string (True)
				once_manifest_string_count := once_manifest_string_count + 1
				yyval7 := yytype60 (yyvs.item (yyvsp))
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_439 is
			--|#line 2022 "eiffel.y"
		local
			yyval10: BOOL_AS
		do
--|#line 2022 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2022")
end


yyval10 := new_boolean_as (False) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_440 is
			--|#line 2024 "eiffel.y"
		local
			yyval10: BOOL_AS
		do
--|#line 2024 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2024")
end


yyval10 := new_boolean_as (True) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_441 is
			--|#line 2028 "eiffel.y"
		local
			yyval13: CHAR_AS
		do
--|#line 2028 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2028")
end


				check is_character: not token_buffer.is_empty end
				yyval13 := new_character_as (token_buffer.item (1))
			
			yyval := yyval13
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_442 is
			--|#line 2035 "eiffel.y"
		local
			yyval39: INTEGER_CONSTANT
		do
--|#line 2035 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2035")
end


yyval39 := yytype39 (yyvs.item (yyvsp)) 
			yyval := yyval39
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_443 is
			--|#line 2038 "eiffel.y"
		local
			yyval39: INTEGER_CONSTANT
		do
--|#line 2038 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2038")
end


yyval39 := yytype39 (yyvs.item (yyvsp)) 
			yyval := yyval39
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_444 is
			--|#line 2042 "eiffel.y"
		local
			yyval39: INTEGER_CONSTANT
		do
--|#line 2042 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2042")
end


				if token_buffer.is_integer then
					yyval39 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval39 := new_integer_as_from_hexa ('%U', token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval39 := new_integer_as (False, "0")
				end
				if not yyval39.is_initialized then
					report_integer_too_large_error (token_buffer)
				end
			
			yyval := yyval39
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_445 is
			--|#line 2062 "eiffel.y"
		local
			yyval39: INTEGER_CONSTANT
		do
--|#line 2062 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2062")
end


				if token_buffer.is_integer then
					yyval39 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval39 := new_integer_as_from_hexa ('+', token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval39 := new_integer_as (False, "0")
				end
				if not yyval39.is_initialized then
					report_integer_too_large_error (token_buffer)
				end
			
			yyval := yyval39
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_446 is
			--|#line 2080 "eiffel.y"
		local
			yyval39: INTEGER_CONSTANT
		do
--|#line 2080 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2080")
end


				if token_buffer.is_integer then
					yyval39 := new_integer_as (True, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval39 := new_integer_as_from_hexa ('-', token_buffer)
				else
					token_buffer.precede ('-')
					report_integer_too_small_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval39 := new_integer_as (False, "0")
				end
				if not yyval39.is_initialized then
					token_buffer.precede ('-')
					report_integer_too_small_error (token_buffer)
				end
			
			yyval := yyval39
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_447 is
			--|#line 2102 "eiffel.y"
		local
			yyval50: REAL_AS
		do
--|#line 2102 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2102")
end


yyval50 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval50
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_448 is
			--|#line 2104 "eiffel.y"
		local
			yyval50: REAL_AS
		do
--|#line 2104 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2104")
end


yyval50 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval50
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_449 is
			--|#line 2106 "eiffel.y"
		local
			yyval50: REAL_AS
		do
--|#line 2106 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2106")
end


				token_buffer.precede ('-')
				yyval50 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval50
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_450 is
			--|#line 2113 "eiffel.y"
		local
			yyval8: BIT_CONST_AS
		do
--|#line 2113 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2113")
end


yyval8 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval8
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_451 is
			--|#line 2117 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2117 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2117")
end


yyval60 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_452 is
			--|#line 2119 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2119 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2119")
end


yyval60 := new_empty_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_453 is
			--|#line 2121 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2121 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2121")
end


yyval60 := new_empty_verbatim_string_as (verbatim_marker.substring (2, verbatim_marker.count), not has_old_verbatim_strings and then verbatim_marker.item (1) = ']') 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_454 is
			--|#line 2125 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2125 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2125")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_455 is
			--|#line 2127 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2127 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2127")
end


yyval60 := new_verbatim_string_as (cloned_string (token_buffer), verbatim_marker.substring (2, verbatim_marker.count), not has_old_verbatim_strings and then verbatim_marker.item (1) = ']') 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_456 is
			--|#line 2129 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2129 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2129")
end


yyval60 := new_lt_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_457 is
			--|#line 2131 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2131 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2131")
end


yyval60 := new_le_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_458 is
			--|#line 2133 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2133 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2133")
end


yyval60 := new_gt_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_459 is
			--|#line 2135 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2135 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2135")
end


yyval60 := new_ge_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_460 is
			--|#line 2137 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2137 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2137")
end


yyval60 := new_minus_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_461 is
			--|#line 2139 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2139 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2139")
end


yyval60 := new_plus_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_462 is
			--|#line 2141 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2141 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2141")
end


yyval60 := new_star_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_463 is
			--|#line 2143 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2143 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2143")
end


yyval60 := new_slash_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_464 is
			--|#line 2145 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2145 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2145")
end


yyval60 := new_mod_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_465 is
			--|#line 2147 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2147 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2147")
end


yyval60 := new_div_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_466 is
			--|#line 2149 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2149 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2149")
end


yyval60 := new_power_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_467 is
			--|#line 2151 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2151 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2151")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_468 is
			--|#line 2153 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2153 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2153")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_469 is
			--|#line 2155 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2155 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2155")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_470 is
			--|#line 2157 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2157 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2157")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_471 is
			--|#line 2159 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2159 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2159")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_472 is
			--|#line 2161 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2161 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2161")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_473 is
			--|#line 2163 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2163 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2163")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_474 is
			--|#line 2165 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2165 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2165")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_475 is
			--|#line 2169 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2169 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2169")
end


yyval94 := new_clickable_string (new_minus_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_476 is
			--|#line 2171 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2171 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2171")
end


yyval94 := new_clickable_string (new_plus_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_477 is
			--|#line 2173 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2173 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2173")
end


yyval94 := new_clickable_string (new_not_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_478 is
			--|#line 2175 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2175 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2175")
end


yyval94 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_479 is
			--|#line 2179 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2179 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2179")
end


yyval94 := new_clickable_string (new_lt_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_480 is
			--|#line 2181 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2181 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2181")
end


yyval94 := new_clickable_string (new_le_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_481 is
			--|#line 2183 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2183 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2183")
end


yyval94 := new_clickable_string (new_gt_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_482 is
			--|#line 2185 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2185 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2185")
end


yyval94 := new_clickable_string (new_ge_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_483 is
			--|#line 2187 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2187 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2187")
end


yyval94 := new_clickable_string (new_minus_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_484 is
			--|#line 2189 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2189 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2189")
end


yyval94 := new_clickable_string (new_plus_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_485 is
			--|#line 2191 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2191 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2191")
end


yyval94 := new_clickable_string (new_star_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_486 is
			--|#line 2193 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2193 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2193")
end


yyval94 := new_clickable_string (new_slash_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_487 is
			--|#line 2195 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2195 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2195")
end


yyval94 := new_clickable_string (new_mod_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_488 is
			--|#line 2197 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2197 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2197")
end


yyval94 := new_clickable_string (new_div_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_489 is
			--|#line 2199 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2199 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2199")
end


yyval94 := new_clickable_string (new_power_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_490 is
			--|#line 2201 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2201 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2201")
end


yyval94 := new_clickable_string (new_and_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_491 is
			--|#line 2203 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2203 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2203")
end


yyval94 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_492 is
			--|#line 2205 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2205 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2205")
end


yyval94 := new_clickable_string (new_implies_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_493 is
			--|#line 2207 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2207 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2207")
end


yyval94 := new_clickable_string (new_or_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_494 is
			--|#line 2209 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2209 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2209")
end


yyval94 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_495 is
			--|#line 2211 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2211 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2211")
end


yyval94 := new_clickable_string (new_xor_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_496 is
			--|#line 2213 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2213 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2213")
end


yyval94 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_497 is
			--|#line 2217 "eiffel.y"
		local
			yyval5: ARRAY_AS
		do
--|#line 2217 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2217")
end


yyval5 := new_array_as (yytype72 (yyvs.item (yyvsp - 1))) 
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_498 is
			--|#line 2221 "eiffel.y"
		local
			yyval62: TUPLE_AS
		do
--|#line 2221 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2221")
end


yyval62 := new_tuple_as (yytype72 (yyvs.item (yyvsp - 1))) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_499 is
			--|#line 2225 "eiffel.y"
		do
--|#line 2225 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2225")
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

	yy_do_action_500 is
			--|#line 2229 "eiffel.y"
		local
			yyval58: TOKEN_LOCATION
		do
--|#line 2229 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2229")
end


yyval58 := current_position.twin 
			yyval := yyval58
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
			when 814 then
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
			  125,  126,  127,  128,  129>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  298,  298,  298,  299,  301,  288,  287,  257,  257,
			  302,  257,  259,  259,  259,  260,  260,  260,  258,  258,
			  173,  169,  169,  223,  223,  223,  136,  136,  136,  136,
			  300,  300,  300,  300,  304,  304,  305,  305,  208,  208,
			  240,  240,  241,  241,  164,  164,  148,  306,  147,  147,
			  253,  253,  254,  254,  239,  239,  303,  303,  163,  295,
			  295,  292,  308,  308,  291,  291,  291,  289,  290,  140,
			  149,  149,  150,  150,  150,  269,  269,  269,  270,  270,
			  194,  194,  195,  195,  195,  195,  195,  195,  195,  271,
			  271,  272,  272,  200,  233,  233,  232,  232,  234,  234,

			  158,  165,  165,  165,  227,  227,  226,  226,  151,  151,
			  242,  242,  244,  244,  243,  243,  246,  246,  245,  245,
			  248,  248,  247,  247,  281,  281,  282,  282,  283,  283,
			  220,  309,  309,  285,  285,  286,  286,  221,  255,  255,
			  256,  256,  216,  216,  205,  310,  204,  204,  204,  161,
			  162,  210,  210,  181,  181,  284,  284,  262,  262,  263,
			  263,  176,  307,  307,  177,  177,  177,  177,  177,  177,
			  177,  177,  177,  177,  201,  201,  312,  201,  313,  157,
			  157,  314,  157,  315,  275,  275,  276,  276,  212,  213,
			  213,  213,  215,  215,  219,  219,  219,  219,  219,  219,

			  217,  279,  279,  279,  278,  278,  280,  280,  250,  250,
			  251,  251,  252,  252,  166,  166,  166,  167,  316,  296,
			  296,  249,  249,  172,  230,  230,  231,  231,  156,  264,
			  264,  174,  224,  224,  225,  225,  144,  266,  266,  182,
			  182,  182,  182,  182,  182,  182,  182,  182,  182,  182,
			  182,  182,  182,  182,  182,  182,  182,  265,  265,  184,
			  277,  277,  183,  183,  317,  222,  222,  222,  155,  273,
			  273,  273,  274,  274,  202,  261,  261,  135,  135,  203,
			  203,  228,  228,  229,  229,  152,  152,  152,  152,  152,
			  152,  206,  206,  206,  207,  207,  207,  207,  207,  207,

			  207,  193,  193,  193,  193,  193,  193,  267,  267,  267,
			  268,  268,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  153,  153,  153,  154,  154,  218,  218,  130,
			  130,  133,  133,  175,  175,  175,  175,  175,  175,  175,
			  175,  175,  146,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  160,  160,  160,  160,  160,
			  160,  160,  160,  160,  160,  160,  160,  160,  160,  160,
			  160,  160,  160,  170,  143,  143,  143,  143,  143,  143,
			  143,  143,  143,  143,  143,  143,  189,  188,  187,  191,

			  186,  196,  196,  196,  196,  190,  197,  198,  142,  142,
			  185,  185,  171,  171,  171,  131,  132,  235,  235,  235,
			  236,  236,  237,  237,  238,  238,  168,  137,  137,  137,
			  137,  137,  137,  138,  138,  138,  138,  138,  138,  141,
			  141,  145,  178,  178,  180,  179,  179,  199,  199,  199,
			  139,  209,  209,  209,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  294,  294,  294,  294,  293,
			  293,  293,  293,  293,  293,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  293,  134,  214,  311,

			  297>>)
		end

	yytypes1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,   33,   81,    1,   81,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    2,    5,    7,    8,   10,   11,   13,   20,   25,
			   25,   33,   33,   33,   39,   39,   44,   44,   44,   44,
			   44,   45,   48,   49,   57,   59,   60,   60,   62,   93,
			   93,    1,    1,    1,    1,   63,   63,   63,   92,   58,

			    1,    1,    1,    1,   35,   81,   58,    1,    1,    1,
			    1,    1,    1,    1,   94,    1,    1,    1,    1,    1,
			   33,   33,   46,    1,    1,   72,   60,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,   94,    1,    1,    1,    1,
			    1,    1,    1,   92,   93,   93,   93,   25,   72,   72,
			    1,   63,   92,   72,    1,   58,   63,   25,   25,    1,
			   25,    1,   25,    1,   25,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,   33,    1,   25,   72,    1,    1,   92,

			    1,   33,    1,    1,   33,   39,   39,   39,    1,   89,
			    1,    1,    1,    1,    1,    1,    1,   35,   33,   33,
			   58,   58,    3,   11,   33,   33,   44,   63,   25,    1,
			   84,    1,   92,    1,   25,   72,   63,   58,   11,   25,
			    1,    1,   92,    1,    1,    1,   63,   33,    1,    1,
			   33,   80,   80,   11,   25,   25,   25,   25,   25,   25,
			   25,   25,   25,   25,   25,   25,   25,    1,   25,   25,
			    1,   25,   25,   25,   58,   11,   11,   89,    1,   63,
			   89,   92,   92,    1,    1,    1,    1,    1,    1,    1,
			    7,    7,    8,   10,   13,   20,   33,   39,   50,   60,

			   66,   33,   33,    1,   72,    1,    1,    1,    1,    1,
			   25,   46,   84,   58,   33,    1,    1,    1,    1,   33,
			    1,   25,    1,   58,   58,    1,   84,   58,    1,    1,
			    1,    1,   25,   25,   33,    1,    1,   89,   77,   58,
			    1,    1,    1,   62,    1,    1,    1,   84,   84,    3,
			   44,    1,    1,    1,   92,    1,    1,    1,   84,   72,
			   25,    1,   84,    1,   33,    1,   58,    1,    4,   58,
			   11,   33,   84,   63,    1,   60,    1,    1,    7,   92,
			    1,   33,   33,   39,    1,    1,   89,   46,    1,   33,
			   58,   84,   72,    4,   33,   33,   60,    1,   60,    1,

			    1,    1,   31,   32,   77,   77,   89,    1,    1,    1,
			    1,    1,   89,    1,   92,   72,    1,   72,   84,   60,
			    1,   85,    1,    1,   32,    1,    1,    1,    1,   89,
			   72,   47,   85,   58,    1,   58,    1,   96,   32,    1,
			   47,   47,   92,    1,   18,   69,   69,   58,   63,    1,
			   89,    1,   15,   78,    1,   68,   18,    1,    1,   76,
			    1,    1,    1,    1,    1,    1,   71,   76,   76,   76,
			   86,    1,   78,   92,   76,   93,   17,   68,   93,    1,
			   15,   29,   74,   74,   15,   78,   76,   76,   76,   51,
			   86,   93,   76,   24,   71,   78,    1,   76,   76,   76,

			   76,   76,   76,    1,   71,   71,    1,    1,    1,    1,
			    1,    1,   15,    1,   28,   73,   93,   95,    1,   58,
			   29,   76,    1,    1,    1,   24,    1,   30,   76,   76,
			   76,    1,   76,   92,   93,   17,    1,    1,   15,   78,
			   28,    1,    1,    9,   90,   93,    1,   42,   51,   93,
			    1,   76,    1,   76,   89,   89,   93,   64,   80,   90,
			   90,    1,    1,   63,   42,   58,    1,   76,    1,    1,
			   58,    1,   64,    1,   63,    1,    1,   16,   81,   61,
			   88,   88,    1,   81,    1,    1,    1,    1,    1,    7,
			   16,   81,    1,   81,   61,   61,   58,    1,    1,    1,

			    1,   81,   81,   81,   56,   60,    1,    1,   25,   33,
			   33,   63,   56,    1,    1,    1,    1,   52,   25,    1,
			   52,    1,   90,   52,   88,   64,   80,   90,   90,    1,
			    1,    1,    1,   26,   40,   55,   88,   58,   64,   82,
			    1,   27,   58,   82,    1,   23,    1,   38,   82,    1,
			   60,   60,    1,   23,    1,   82,   63,   38,    1,    1,
			    1,    6,   14,   19,   21,   34,   36,   37,   38,   43,
			   53,   54,   58,   23,   88,   82,    1,    1,   58,   82,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    2,   33,   44,   44,   44,   44,   44,   45,   48,   49,

			   88,   25,    1,   88,    1,    1,   25,    1,   87,   88,
			   92,    1,    1,    2,   33,   63,   63,   25,    1,    1,
			    1,   12,   67,   67,   88,    1,   65,   25,   25,    1,
			    1,   60,   87,   82,    1,   63,    4,    1,    1,   25,
			   25,   58,    1,   82,   12,   25,   33,    1,   82,    1,
			    1,    1,    1,    2,    1,   13,   33,   39,   41,   49,
			   83,   82,    1,    1,   58,   22,   70,   70,   58,   60,
			    2,    4,    1,    1,    1,    1,    1,    1,    1,   25,
			   25,    1,   82,   22,    1,    4,   63,   13,   33,   49,
			   13,   33,   39,   49,   33,   39,   49,   13,   33,   39,

			   49,   82,   41,    1,   82,    1,   25,    1,   82,    1,
			    1,    1,   82,   33,    1,    1,    1>>)
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
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    8,   11,    0,  426,  500,   34,    1,  500,  474,  473,
			  472,  471,  470,  469,  468,  467,  466,  465,  464,  463,
			  462,  461,  460,  459,  458,  457,  456,  367,  453,  455,
			  452,    0,  388,    0,    0,  417,    0,    0,    0,  387,
			    0,  440,  439,  422,  500,  422,    0,  500,  500,  450,
			  454,  435,  441,  444,    0,    0,    0,    0,  383,    0,
			    0,  389,  368,  365,  436,  433,  370,  434,  395,    3,
			  344,  412,    0,  417,  366,  343,  392,  386,  385,  384,
			  394,  390,  391,  393,  371,  293,  437,  451,  369,  413,
			  414,    0,    0,    0,    7,    2,  192,  193,  201,    0,

			   35,   36,    0,   36,   18,  500,   22,  500,  500,    0,
			  478,  477,  476,  475,   68,  306,  303,  304,  500,    0,
			  412,  307,    0,    0,    0,  401,  438,  496,  495,  494,
			  493,  492,  491,  490,  489,  488,  487,  486,  485,  484,
			  483,  482,  481,  480,  479,   67,    0,  500,    0,  382,
			  381,    6,    0,   64,   65,   66,  379,  424,    0,  423,
			    0,    0,  201,    0,  500,    0,    0,    0,  376,  140,
			  375,  446,  373,  445,  374,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  500,  377,  415,    0,    0,  201,

			  199,  198,    0,    0,  197,  196,  442,  443,  500,  200,
			    0,   37,   31,    0,   36,   36,   30,   19,    0,    0,
			    0,    0,  409,  397,  412,  417,  408,    0,    0,    0,
			  291,    0,    0,  418,  420,    0,    0,    0,  396,    0,
			  498,    0,    0,  500,  500,  497,    0,  307,  500,  372,
			  138,  141,    0,  398,  351,  350,  349,  348,  347,  346,
			  345,  358,  360,  359,  361,  362,  363,    0,  352,  357,
			    0,  354,  356,  364,    0,  400,  405,  195,  202,  206,
			    0,  201,  500,   33,   32,   21,   25,  447,    0,    0,
			   23,   27,  431,  427,  428,    0,   26,  429,  430,  432,

			   56,  307,  307,    0,  416,  305,  302,  312,  500,  308,
			  321,  310,    0,    0,  307,  417,  419,    0,    0,  307,
			  380,  425,    0,    0,    0,  500,  294,  331,  500,    0,
			    0,  378,  353,  355,  307,  203,  500,  194,  151,    0,
			  449,  448,   28,    0,    0,   57,   20,  300,  297,  410,
			  411,    0,    0,    0,  201,  309,    0,    0,  292,  402,
			  421,    0,  298,  500,  307,  417,  331,    0,  326,    0,
			  399,  139,  295,  207,    0,   38,  210,   29,   24,  201,
			  199,  198,  197,  196,  500,  500,    0,  311,    0,  417,
			    0,  299,  404,  325,  417,  307,  152,    0,   75,    0,

			    0,  216,  218,  212,    0,  211,  195,  320,  319,  318,
			  317,  204,    0,  314,  201,  406,  417,  332,  296,   39,
			  500,  500,  214,  215,  219,  209,    0,  316,  205,    0,
			  403,   78,  500,    0,   77,  500,    0,  217,  213,  315,
			   79,   80,  201,  285,  283,  104,  500,    0,  221,   81,
			   82,    0,    0,  287,    0,   40,  284,  288,    0,  220,
			  114,  122,   89,  118,   56,   88,  112,  116,  120,    0,
			   94,   50,    0,   52,  286,  110,  106,  105,    0,   47,
			   62,   42,  500,   41,    0,  290,    0,  115,  123,   91,
			   90,    0,  119,   98,   96,  101,   97,  113,  116,  117,

			  120,  121,    0,   87,   95,  112,   51,    0,    0,    0,
			    0,    0,   48,   63,   54,   62,   59,  124,    0,  262,
			   43,  289,  222,    0,    0,   99,  102,   56,  103,  120,
			    0,   86,  116,   53,  111,  107,  500,  500,   46,   49,
			   55,   62,  126,  162,  142,   61,  264,  500,   92,   93,
			  100,    0,   85,  120,    0,    0,   60,  128,  500,    0,
			  127,   58,  500,   15,  499,    8,   84,    0,  109,    0,
			    0,  125,  129,  163,  143,   12,  500,   69,   70,  186,
			  263,  499,  500,    0,   83,  108,  131,   15,  500,   15,
			   71,   38,   17,  500,  187,   56,    0,    5,    4,    0,

			  500,   73,  500,   72,   74,  145,   16,  188,  189,  412,
			    0,   56,  174,  191,  132,  130,  176,  155,  190,  178,
			  499,  133,    0,  499,  175,  135,  500,  156,  134,  162,
			  500,  162,  148,  147,  146,  179,  177,    0,  136,  154,
			  499,  151,    0,  153,  181,  275,  500,  159,  499,  500,
			  149,  150,  183,  499,  162,    0,   56,  160,  274,  500,
			  162,  166,  172,  164,  171,  168,  169,  165,  162,  170,
			  173,  167,    0,  499,  180,  276,  144,  137,    0,  260,
			  161,    0,    0,  269,    0,  499,    0,    0,  500,    0,
			  333,  412,  339,  335,  334,  336,  341,  337,  338,  340,

			  182,  232,  499,  265,    0,    0,    0,    0,  162,    0,
			    0,  330,  500,  331,  329,  328,    0,    0,    0,    0,
			  500,  234,  257,  233,  261,    0,    0,  278,  280,  162,
			  270,  272,    0,    0,  342,    0,  323,    0,    0,  277,
			  279,    0,  162,    0,  235,  267,  412,  500,  500,  271,
			    0,  268,    0,  331,    0,  241,  243,  239,  237,  249,
			    0,  258,  231,    0,    0,  226,  229,  500,    0,  273,
			  331,  322,    0,    0,    0,    0,    0,  162,    0,  266,
			    0,  162,    0,  227,    0,  324,    0,  242,  248,  256,
			  247,  244,  245,  251,  246,  240,  254,  255,  250,  253,

			  252,  236,  238,  162,  230,  223,    0,    0,    0,  162,
			    0,  259,  228,  407,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  713,   61,  222,  368,   62,  661,  290,  291,   63,   64,
			  543,   65,  223,   66,  721,   67,  662,  452,  480,  577,
			  590,  476,  444,  663,   68,  664,  765,  645,  493,  157,
			   70,  633,  641,  514,  481,  527,  402,  403,   71,  219,
			   72,   73,  665,  104,  666,  667,  647,  668,  297,   74,
			   75,  634,  758,  547,  669,  226,   76,   77,   78,   79,
			   80,   81,  311,  122,  431,  441,   82,   83,  759,  298,
			  489,  617,  670,  671,  635,  604,   84,   85,  398,   86,
			  375,   87,  579,  595,   88,  279,  563,   96,  716,   97,
			  557,  625,  726,  300,  722,  723,  477,  455,  445,  446,

			  766,  767,  466,  505,  494,  125,  235,  158,  159,  515,
			  482,  483,  474,  497,  498,  499,  500,  501,  502,  459,
			  338,  404,  405,  495,  472,  558,  252,    5,  105,  591,
			  578,  655,  639,  648,  782,  743,  760,  230,  312,  421,
			  432,  470,  490,  708,  732,  580,  581,  703,  386,  209,
			  280,  544,  559,  560,  622,  627,  628,   98,  153,   89,
			   90,  475,  516,  145,  114,  517,  437,   99,  814,    6,
			  102,  598,    7,  346,  103,  212,  512,  640,  518,  600,
			  612,  582,  620,  623,  653,  673,  424,  564>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  137, 1739, 1251, -32768,    7,  153, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  708,  308,  333,   35,  128, 1926, 2136,  751,  263,
			    9, -32768, -32768, 1251,  219, 1251,  749, -32768,    7, -32768,
			 -32768, -32768, -32768, -32768, 1251, 1251,  766, 1251, -32768, 1599,
			 1483,  514, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2262,
			 -32768,  750, 1251,  670, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  506,  498, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  269,  201,  422, -32768, -32768, -32768, -32768,  637,  721,

			 -32768,  698,  729,  135, -32768,  320,  131, -32768, -32768,   57,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,    7, 1251,
			  761,  691,  758,  269, 1135, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  269, -32768,   57, -32768,
			 -32768, -32768, 1251, -32768, -32768, -32768, -32768, 2262,  735,  741,
			  269,  676,  482,  736,    7,  131,  734, 2219, -32768,  131,
			 -32768, -32768, -32768, -32768, -32768,   57, 1251, 1251, 1251, 1251,
			 1251, 1251, 1251, 1251, 1251, 1251, 1251, 1251, 1251, 1019,
			 1251,  903, 1251, 1251, -32768, -32768, -32768,   57,   57,  637,

			 -32768, -32768,  737,  727, -32768, -32768, -32768, -32768,   74, -32768,
			  269, -32768, -32768,  269,  698,  698, -32768, -32768,  710, 1715,
			  131,  131,  702, -32768, -32768,  670, -32768,  720, 2201,  785,
			 -32768,   57,  716, -32768, 2262,  387,  707,  131, -32768, 2158,
			 -32768, 1251,  706, -32768, -32768, -32768,  704,  691, -32768,  252,
			 -32768,  544,  703, -32768,  483,  483,  483,  483,  483,  846,
			  846, 1066, 1066, 1066, 1066, 1066, 1066, 1251, 2291, 2277,
			 1251, 1908, 2180, -32768,  131, -32768, -32768, -32768, -32768, -32768,
			  305,  637,  763, -32768, -32768, -32768, -32768, -32768,  442,  354,
			 -32768, -32768, -32768, -32768, -32768,  -20, -32768, -32768, -32768, -32768,

			  328,  691,  691,   57, -32768, -32768, -32768,  708,  189, -32768,
			 2262, -32768,  383,  699,  691,  670, -32768, 1251,  719,  691,
			 -32768, 2262,  696,  131,  655, -32768, -32768,  289, -32768,   57,
			  131, -32768, 2291, 1908,  691, -32768,    7, -32768,  546,  690,
			 -32768, -32768, -32768,  669, 1763, -32768, -32768, -32768, -32768,  702,
			 -32768,  269,   15,  422,  412, -32768, 1367,  656, -32768, -32768,
			 2262,  131, -32768, -32768,  691,  670,  289,  131, -32768,  131,
			 -32768, -32768, -32768, -32768, 1949,  516,    3, -32768, -32768,  637,
			  687,  686,  682,  675,   18,  349,  674, -32768,  269,  670,
			  631, -32768, -32768, -32768,  670,  691, -32768, 1926,  638,  680,

			  679, -32768, -32768, -32768,  665,  664,  663, -32768, -32768, -32768,
			 -32768,  596,  255, -32768,  637, -32768,  670, -32768, -32768, -32768,
			  605, -32768, -32768, -32768,  642, -32768,    3, -32768,  585,  641,
			 -32768, -32768,  496,  269, -32768,  657,  269, -32768, -32768, -32768,
			 -32768,  649,  637,  167, -32768,  623,  582,  639,  629, -32768,
			  242,  234,  -10,   37,  -10,  591, -32768,  167,  -10, -32768,
			  -10,  -10,  -10,  -10,  204, -32768,  551,  541,  528,  612,
			  608, -32768,  324, -32768,  594, -32768, -32768,  628,  223, -32768,
			  778, -32768, -32768,  591,  -10,   37,  174,  594,  594, -32768,
			  618,  601,  594, -32768,  598,  140, -32768, -32768,  541, -32768,

			  528, -32768,  589, -32768, -32768,  551, -32768,  269,  -10,  -10,
			  604,  599,  598, -32768, -32768,  510, -32768,  233,  -10,  558,
			 -32768,  594, -32768,  -10,  -10, -32768, -32768,  517,  594,  528,
			  567, -32768,  541, -32768, -32768, -32768,    7,    7, -32768, -32768,
			 -32768,  557,  131, -32768,  590, -32768, -32768, -32768, -32768, -32768,
			 -32768,  560, -32768,  528,  303,  279, -32768, -32768,  544,  575,
			  131,  509,    7,  312,  -37,  547, -32768,  552, -32768,  572,
			  571, -32768, -32768, -32768, -32768, 1879,  550, -32768, -32768, -32768,
			 -32768,  902, -32768,  549, -32768, -32768,  553,  518,  709,  518,
			 -32768,  516, -32768,  529, -32768,  517, 1251, -32768, -32768,  131,

			    7, -32768,  677, -32768, -32768, -32768, -32768, -32768, 2262,  415,
			  545,  517,  495, 1251, -32768, -32768,  527,  508, 2262, -32768,
			  462,  131,  243,  462, -32768, -32768,  544, -32768,  131, -32768,
			 -32768, -32768, -32768, -32768, -32768,  511, -32768,  538, -32768, -32768,
			  181,  546, 1949, -32768,  473,  472,    7, -32768,  403,   63,
			 -32768, -32768, -32768,  157, -32768,  490,  517, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  578,  157, -32768, -32768, -32768, -32768, 1251,  474,
			  509,   94, 1251,  524,  520,  475,  110,   -9,   41, 1251,
			  514,  388, -32768, -32768, -32768, -32768, -32768, -32768,  506,  498,

			 -32768, 1928,  314,  418, 1251, 1251, 2103, 1977, -32768,  445,
			  454, -32768,    7,  289, -32768, -32768,  463, 2139, 1251, 1251,
			 -32768, -32768,  431,  385, -32768, 1251,  391, 2262, 2262, -32768,
			 -32768, -32768,  335,  425, -32768,  437, -32768,  -13,  447, 2262,
			 2262,  405, -32768,  399, -32768, 2262,  317, -32768,  230, -32768,
			 1949, -32768,  -13,  289,  404,  443,  430,  423, -32768,  406,
			   22, -32768, -32768, 1251, 1251, -32768,  327,  -34,  282, -32768,
			  289, -32768,  269,  249,  405,  410,  405, -32768,  405, 2262,
			 2121, -32768,  214, -32768, 1251, -32768,  251, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, -32768, 1957,  151,  158, -32768,
			  131, -32768, -32768, -32768,  145,   50, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -586,  258,  625, -341, -32768, -32768,  579,  344, -32768, -212,
			 -32768, -213, -134, -32768,  197, -215, -32768, -398, -32768, -32768,
			 -32768,  407,  469, -32768, -208, -32768,  122, -32768,  394,    1,
			  476, -32768, -32768,  371,  408, -32768, -32768,  459,    0, -32768,
			  142,  118, -32768, -103, -32768, -32768,  236, -32768,  -67,  -75,
			  -81, -32768,   98, -32768, -32768,  565,  211,  207,  206,  205,
			  203,  188,  499, -32768,  426, -32768,  182,  180, -167, -32768,
			  323, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  259,  -23,
			  200, -366,  254, -32768,  537,   43, -32768, -145, -32768, -32768,
			  267,  196, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768,  355, -32768, -32768,  -58, -32768,  776, -32768, -32768,
			 -32768, -32768, -136,  363,  307,  353, -390,  351, -451, -32768,
			 -32768, -32768, -32768, -412, -32768, -164, -32768,  231, -549, -32768,
			 -109, -32768, -571, -32768, -32768, -32768, -32768,  268, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -601, -32768, -32768, -32768, -178,
			 -374, -32768, -32768, -32768, -32768, -32768, -32768,  -11, -32768,   56,
			   25,    4,  257, -32768, -32768, -32768, -32768,   10, -32768, -32768,
			 -32768, -32768, -32768, -367, -32768,  -87, -32768, -534, -32768, -32768,
			 -32768, -431, -32768, -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    4,  236,  217,   69,  294,  251,  293,  292,  396,  561,
			  412,  295,  207,  126,  238,  196,  216,  106,  206,  624,
			    3,  277,  636,  151,    3,  393,  205,  593,   43, -184,
			 -225,  453, -225,  162,  120,  152,  401,  712, -184,  602,
			   94,  253,  151,   93,  156,  485,  342,   95,    3,  530,
			  816,   94,  674,  434,   93,  167,  168,  165,  170,  484,
			  643,  119,  778,  275,  276,  155,   37,  411,    3,  150,
			  -49,  400,  700,  195,   94,  380, -327,   93,  551,   33,
			  199,  118,  711,  675,  709,   37,  711,  161,   92,  679,
			    3,  166,  201,  204,  399,  117,  154,  496,   33,   92,

			  539,  724,  567,  337,  149,   91,  218,   94,  529,  224,
			   93,   37,  232,  -49,  538,  106,   91,  220,  221,  109,
			  228,  777,   92,  278,   33,  234,  -49,  283,  284,  294,
			  116,  293,  292,   37,  680,  660,  295,  733,  207,   91,
			  115,  659,  553,   94,  206,  815,   33,  705,  224,  242,
			  704,  753,  121,  239,  124,   92,  160,  237,  748,  658,
			  550,  227,  554,  555,    3,  247,  770,  304,  526,  250,
			    3,  761,   91,  151,  123,  224,  810,  254,  255,  256,
			  257,  258,  259,  260,  261,  262,  263,  264,  265,  266,
			  268,  269,  271,  272,  273,  370,  299,  224,  224,  281,

			  -48,  406,  282,  215,  274,  211,  801,  246,    2,  649,
			  804,  193,    1,  451,  508,  101,   37,  649,  573,  296,
			  301,  302,   94, -184,  811,  353,  100,  225,  607,   33,
			  310,  224,  808,  214,    3,  160,  429,  319,  812,  313,
			  522,  345,  321,  -48,  615, -157, -157, -157, -157,  511,
			  451, -184,   94,  323,  324,   93,  -48,  359,  327,  542,
			 -157,  200,  510,  207,  450,  160,  225,   94,  332,  206,
			  352,  333,  207,  541,  334, -157,  651,  329,  206,   52,
			  805,  471,    3, -157, -157, -157,  383,  351,  148,  677,
			  328,  448,  339,  225, -224,  336, -224,  354,  807,  193,

			   92,  147,   94,  224,  428,  632,  631,  392,  465,  193,
			  193,  464,  193,  630,  367,  225,  225,   91,  360,  336,
			  754,  299,  486,  364,  487,  488,  569,  492,  629,  224,
			  371,  415,  463,  109,  462,  366,  417,  193,  369,  461,
			  379,  731,  460,  336,  296,  336,  108,  784,  521,  314,
			  568,  161,  381,  382,  335,  194,  763,  310,  430,  528,
			  294,  389,  293,  292,  507,  345,  313,  394,  344,  395,
			  193,  506,  736,  390,  419,  750,  193,  414,   -9,  373,
			  749,  193,   -9,  173,  769,  341,   -9,  576,   -9, -313,
			   -9,  781,  575,   -9, -313,  324,  193,  193,  193,  193,

			  193,  193,  193,  193,  193,  193,  193,  193,  193,  776,
			  193,  193,  771,  193,  193,  193, -184, -184,   -9,  203,
			  202,  225,  442,  356,  203,  202,  775,  317,  355,  785,
			  433,  435,  316,  774,   53,   52,  203,  202,    3,   53,
			  473,  719,  433,    3,  718,  447,  773,  225,  113,  112,
			  772,   53,  193,  194,  613,    3,  447,  626,  478,  385,
			  384,  111,  110,  193,  626,  762,  491, -158, -158, -158,
			 -158,  171,  329,  340,  193,  193,  754,  155,  601,  155,
			  603,  754, -158,  155,  752,  155,  155,  155,  155,  720,
			  217,  751,  519,  747,  207,  742,  533, -158,  737,  217,

			  206,  244,  193,  176,   58, -158, -158, -158,  154,  155,
			  154,  734,  534,  478,  154,  326,  154,  154,  154,  154,
			  155,  725,  545,  198, -184, -184,  755,  491,  549,  244,
			  208,  197, -184,  155,  155,  172,  174,  -76,  -76,  175,
			  154, -184,  250,  155, -184,  148,  573, -184,  155,  155,
			  707,  154,  299,  702,  345,  -76,  676,  565,  787,  790,
			  250,  797,  -76,  755,  154,  154,  654,  -76,  570,  347,
			  348,  -76,  652,  374,  154,  -76,  -45,  646,  644,  154,
			  154,  -45,  358,  513,  330,  -45,  106,  362,  616,  -45,
			  621,  619,  596,  576,  614,  606,  609,  608,  106,  610,

			  397,  599,  372,  106,  689,  574,  789,  793,  796,  800,
			  586,    3,  106,  688,  618,  597,  592,  585,  584,  687,
			  571,  250,    1,  443,  686,  461,  566,  786,  250,  562,
			  513,  463,  391,  552,  508,  685,  637,  546,  684,  683,
			  642, -282,  345,  611,  451,  537,  -56,  -56, -282,   38,
			  536,  460,  682, -282,   37,  531,  524, -282,  523,  672,
			  207, -282,  479,  418,  -56,   35,  206,   33,  509,  678,
			  458,  -56,  691,  681,  757,  710,  -56,  464,  503,  701,
			  -56,  457,  454,  706,  -56,  208,  449,  714,  439,  656,
			  717, -203,  436,  207,  207,  207,  124,  207,  443,  206,

			  206,  206, -202,  206,  426,  727,  728,  792,  795,  799,
			  427,  757,  423,  422,  425,  420, -281,  229,  416,  739,
			  740,  413,  410, -281,  388,  746,  745,  303, -281,  409,
			  741,  715, -281,  408,  407,  377, -281,  714,  376,  -13,
			  -13,  756,  365,  363,  361,  357,  107,  -13,  331,  285,
			  193,  325,  714,  322,  318,  735,  173,  764,  768,  -13,
			  193,  -13,  -13,  315,  779,  780,  171,  305,  211,  248,
			  -13,  -14,  -14,  788,  791,  794,  798,  768,  756,  -14,
			  245,  241,  243,  231,  240,  806, -301,  213,  194,  210,
			 -208,  -14,  169,  -14,  -14,  164,  583,  146,  556,   60,

			   59,  469,  -14,  468, -208, -208,   58,   57,   56,   55,
			  813,   54,  532,  467,   53,   52,   51,   50,    3,   49,
			   48,  163, -208,   47,  638,  504,   46,  572,   45, -208,
			  309,  308,  343,   43, -208,  594,   42,   41, -208,   40,
			 -208,  650, -208,  193,  -44,   39,  548, -208,  193,  -44,
			  605,  513,  699,  -44,  698,  387,   38,  -44,  440,  193,
			  697,   37,  180,  179,  178,  177,  176,   58,  350,  193,
			  193,   36,   35,   34,   33,  696,  802,  695,  694,  693,
			   32,  193,  193,  692,  657,  438,  540,  193,  525,  783,
			  307,  520,   30,   29,   28,   27,   26,   25,   24,   23,

			   22,   21,   20,   19,   18,   17,   16,   15,   14,   13,
			   12,   11,   10,    9,    8,  456,  535,   60,   59,  589,
			  744,  193,  193,  378,   58,   57,   56,   55,  349,   54,
			  690,    0,   53,   52,   51,   50,    3,   49,   48,    0,
			    0,   47,    0,    0,   46,    0,   45,    0,  193,   44,
			    0,   43,    0,    0,   42,   41,    0,   40,    0,    0,
			    0,    0,    0,   39, -185, -185,    0,  270, -185,    0,
			    0,    0, -185,    0,   38,    0,    0, -185,    0,   37,
			    0,    0,    0,    0, -185,    0,    0, -185,    0,   36,
			   35,   34,   33,    0,    0,    0, -185,    0,   32,    0,

			    0,    0,    0,    0, -185, -185,    0,    0,   31,    0,
			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,
			   20,   19,   18,   17,   16,   15,   14,   13,   12,   11,
			   10,    9,    8,   60,   59,    0,    0,    0,    0,    0,
			   58,   57,   56,   55,    0,   54,    0,    0,   53,   52,
			   51,   50,    3,   49,   48,    0,    0,   47,    0,    0,
			   46,    0,   45,    0,    0,   44,    0,   43,    0,    0,
			   42,   41,    0,   40,    0,    0,    0,    0,    0,   39,
			  182,  181,  180,  179,  178,  177,  176,   58,    0,    0,
			   38,    0,    0,    0,    0,   37,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,   36,   35,   34,   33,    0,
			    0,    0,    0,    0,   32,    0,    0,    0,  267,    0,
			    0,    0,    0,    0,   31,    0,   30,   29,   28,   27,
			   26,   25,   24,   23,   22,   21,   20,   19,   18,   17,
			   16,   15,   14,   13,   12,   11,   10,    9,    8,   60,
			   59,    0,    0,    0,    0,    0,   58,   57,   56,   55,
			    0,   54,    0,    0,   53,   52,   51,   50,    3,   49,
			   48,    0,    0,   47,    0,    0,   46,    0,   45,    0,
			  233,   44,    0,   43,    0,    0,   42,   41,    0,   40,
			    0,    0,    0,    0,    0,   39,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,   38,    0,    0,    0,
			    0,   37,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   36,   35,   34,   33,    0,    0,    0,    0,    0,
			   32,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			   31,    0,   30,   29,   28,   27,   26,   25,   24,   23,
			   22,   21,   20,   19,   18,   17,   16,   15,   14,   13,
			   12,   11,   10,    9,    8,   60,   59,    0,    0,    0,
			    0,    0,   58,   57,   56,   55,    0,   54,    0,    0,
			   53,   52,   51,   50,    3,   49,   48,    0,    0,   47,
			    0,    0,   46,    0,   45,    0,    0,   44,    0,   43,

			    0,    0,   42,   41,    0,   40,    0,    0,    0,    0,
			    0,   39,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   38,    0,    0,    0,    0,   37,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   36,   35,   34,
			   33,    0,    0,    0,    0,    0,   32,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   31,    0,   30,   29,
			   28,   27,   26,   25,   24,   23,   22,   21,   20,   19,
			   18,   17,   16,   15,   14,   13,   12,   11,   10,    9,
			    8,   60,   59,    0,    0,    0,    0,    0,   58,   57,
			   56,   55,    0,   54,    0,    0,   53,   52,   51,   50,

			    3,   49,   48,    0,    0,   47,    0,    0,   46,    0,
			   45,    0,    0,  308,    0,   43,    0,    0,   42,   41,
			    0,   40,    0,    0,    0,    0,    0,   39,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   38,    0,
			    0,    0,    0,   37,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   36,   35,   34,   33,    0,    0,    0,
			    0,    0,   32,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  307,    0,   30,   29,   28,   27,   26,   25,
			   24,   23,   22,   21,   20,   19,   18,   17,   16,   15,
			   14,   13,   12,   11,   10,    9,    8,   60,   59,    0,

			    0,    0,    0,    0,   58,   57,   56,   55,    0,   54,
			    0,    0,  173,   52,   51,   50,    3,   49,   48,    0,
			    0,   47,    0,    0,   46,    0,   45,    0,    0,   44,
			    0,   43,    0,    0,   42,   41,    0,   40,    0,    0,
			    0,    0,    0,   39,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   38,    0,    0,    0,    0,   37,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   36,
			   35,   34,   33,    0,    0,    0,    0,    0,   32,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   31,    0,
			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,

			   20,   19,   18,   17,   16,   15,   14,   13,   12,   11,
			   10,    9,    8,   60,   59,    0,    0,    0,    0,    0,
			   58,   57,   56,   55,    0,   54,    0,    0,  171,   52,
			   51,   50,    3,   49,   48,    0,    0,   47,    0,    0,
			   46,    0,   45,    0,    0,   44,    0,   43,    0,    0,
			   42,   41,    0,   40,    0,    0,    0,    0,    0,   39,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			   38,    0,    0,    0,    0,   37,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   36,   35,   34,   33,    0,
			    0,    0,    0,    0,   32,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,   31,    0,   30,   29,   28,   27,
			   26,   25,   24,   23,   22,   21,   20,   19,   18,   17,
			   16,   15,   14,   13,   12,   11,   10,    9,    8,  289,
			  288,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   53,   52,  287,   50,    3,   49,
			   48,    0,  286,  -10,  -10,    0,   46,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   42,   41,  -10,  -10,
			  -10,  -10,  -10,  -10,  -10,    0,  -10,  289,  288,    0,
			  -10,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  -10,  -10,   53,   52,  287,   50,    3,   49,   48,    0,

			    0,    0,    0,    0,   46,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   42,   41,    0,    0,    0,    0,
			    0,    0,   30,   29,   28,    0,   26,   25,   24,   23,
			   22,   21,   20,   19,   18,   17,   16,   15,   14,   13,
			   12,   11,   10,    9,    8,    0,  -10,  -10,  -10,    0,
			  -10,  -10,  -10,  -10,  -10,  -10,  -10,  -10,  -10,  -10,
			  -10,  -10,  -10,  -10,  -10,  -10,  -10,  -10,  -10,    0,
			   30,   29,   28,    0,   26,   25,   24,   23,   22,   21,
			   20,   19,   18,   17,   16,   15,   14,   13,   12,   11,
			   10,    9,    8,  289,  288,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,   53,   52,
			  287,   50,    0,   49,  190,  189,  188,  187,  186,  185,
			  184,  183,  182,  181,  180,  179,  178,  177,  176,   58,
			   42,   41,  192,  191,  190,  189,  188,  187,  186,  185,
			  184,  183,  182,  181,  180,  179,  178,  177,  176,   58,
			    0,    0,    0,    0,  588,    0,    0,    0,   50,    0,
			    0,  192,  191,  190,  189,  188,  187,  186,  185,  184,
			  183,  182,  181,  180,  179,  178,  177,  176,   58,    0,
			  587,   50,    0,    0,    0,    0,   30,   29,   28,    0,
			   26,   25,   24,   23,   22,   21,   20,   19,   18,   17,

			   16,   15,   14,   13,   12,   11,   10,    9,    8,   50,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  730,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  720,   30,   29,   28,    0,   26,   25,   24,
			   23,   22,   21,   20,   19,   18,   17,   16,   15,   14,
			   13,   12,   11,   10,    9,    8,  809,   29,    0,    0,
			   26,   25,   24,   23,   22,   21,   20,   19,   18,   17,
			   16,   15,   14,   13,   12,   11,   10,    9,    8,    0,
			    0,    0,    0,    0,    0,   29,    0,    0,   26,   25,
			   24,   23,   22,   21,   20,   19,   18,   17,   16,   15,

			   14,   13,   12,   11,   10,    9,    8,  192,  191,  190,
			  189,  188,  187,  186,  185,  184,  183,  182,  181,  180,
			  179,  178,  177,  176,   58,  192,  191,  190,  189,  188,
			  187,  186,  185,  184,  183,  182,  181,  180,  179,  178,
			  177,  176,   58,  192,  191,  190,  189,  188,  187,  186,
			  185,  184,  183,  182,  181,  180,  179,  178,  177,  176,
			   58,    0,  192,  191,  190,  189,  188,  187,  186,  185,
			  184,  183,  182,  181,  180,  179,  178,  177,  176,   58,
			    0,    0,    0,    0,  738,  191,  190,  189,  188,  187,
			  186,  185,  184,  183,  182,  181,  180,  179,  178,  177,

			  176,   58,  729,  320,  803,  192,  191,  190,  189,  188,
			  187,  186,  185,  184,  183,  182,  181,  180,  179,  178,
			  177,  176,   58,  192,  191,  190,  189,  188,  187,  186,
			  185,  184,  183,  182,  181,  180,  179,  178,  177,  176,
			   58,    0,    0,    0,    0,    0,  306,  144,  143,  142,
			  141,  140,  139,  138,  137,  136,  135,  134,  133,  132,
			  131,  130,  129,  128,  249,  127,  192,  191,  190,  189,
			  188,  187,  186,  185,  184,  183,  182,  181,  180,  179,
			  178,  177,  176,   58,  189,  188,  187,  186,  185,  184,
			  183,  182,  181,  180,  179,  178,  177,  176,   58,  188,

			  187,  186,  185,  184,  183,  182,  181,  180,  179,  178,
			  177,  176,   58>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  146,  105,    2,  219,  169,  219,  219,  374,  543,
			  384,  219,   93,   36,  148,   73,  103,    7,   93,  620,
			   33,  199,  623,   33,   33,  366,   93,  576,   48,   66,
			   64,  443,   66,   44,   34,   26,   33,   46,   75,  588,
			   33,  175,   33,   36,   40,  457,   66,    4,   33,  500,
			    0,   33,  653,  420,   36,   54,   55,   47,   57,  457,
			  631,   26,   40,  197,  198,   40,   76,   49,   33,   60,
			   33,   68,  673,   72,   33,   60,   35,   36,  529,   89,
			   91,   46,   95,  654,  685,   76,   95,   44,   81,  660,
			   33,   48,   92,   93,   91,   60,   40,  464,   89,   81,

			  512,  702,  553,  281,   95,   98,  106,   33,  498,  109,
			   36,   76,  123,   76,  512,  105,   98,  107,  108,   25,
			  119,   99,   81,   49,   89,  124,   89,  214,  215,  344,
			   95,  344,  344,   76,  668,   72,  344,  708,  219,   98,
			  105,   78,  532,   33,  219,    0,   89,   53,  148,  160,
			   56,  737,   34,  152,   26,   81,   46,  147,  729,   96,
			  527,  118,  536,  537,   33,  165,  752,  225,   28,  169,
			   33,  742,   98,   33,   46,  175,   25,  176,  177,  178,
			  179,  180,  181,  182,  183,  184,  185,  186,  187,  188,
			  189,  190,  191,  192,  193,  329,  219,  197,  198,  210,

			   33,  379,  213,   68,  194,   70,  777,  164,   71,  640,
			  781,   69,   75,   46,   40,   62,   76,  648,   37,  219,
			  220,  221,   33,   66,   66,   36,   73,  109,  595,   89,
			  229,  231,  803,   98,   33,   46,  414,  237,  809,  229,
			   66,   37,  241,   76,  611,   64,   65,   66,   67,   26,
			   46,   94,   33,  243,  244,   36,   89,  315,  248,   26,
			   79,   60,   39,  344,  442,   46,  148,   33,  267,  344,
			   81,  270,  353,   40,  274,   94,  642,   25,  353,   30,
			   66,   47,   33,  102,  103,  104,  353,   98,   25,  656,
			   38,  436,  282,  175,   64,   40,   66,  308,   47,  157,

			   81,   38,   33,  303,   49,   62,   63,  365,   66,  167,
			  168,   69,  170,   70,   25,  197,  198,   98,  317,   40,
			   71,  344,  458,  323,  460,  461,   47,  463,   85,  329,
			  330,  389,   90,   25,   92,  325,  394,  195,  328,   97,
			  351,  707,  100,   40,  344,   40,   38,   65,  484,  231,
			   47,  308,  352,  353,   49,   38,   39,  356,  416,  495,
			  575,  361,  575,  575,   40,   37,  356,  367,   40,  369,
			  228,   47,  713,  363,  397,   40,  234,  388,   58,  336,
			   45,  239,   62,   29,  750,   31,   66,   75,   68,   40,
			   70,   64,   80,   73,   45,  385,  254,  255,  256,  257,

			  258,  259,  260,  261,  262,  263,  264,  265,  266,    3,
			  268,  269,  753,  271,  272,  273,  102,  103,   98,   14,
			   15,  303,  433,   40,   14,   15,    3,   40,   45,  770,
			  420,  421,   45,    3,   29,   30,   14,   15,   33,   29,
			  451,   53,  432,   33,   56,  435,    3,  329,  115,  116,
			   46,   29,  310,   38,   39,   33,  446,  621,  454,   47,
			   48,  128,  129,  321,  628,   66,  462,   64,   65,   66,
			   67,   29,   25,   31,  332,  333,   71,  452,  587,  454,
			  589,   71,   79,  458,   47,  460,  461,  462,  463,  104,
			  593,   66,  482,  102,  575,   64,  507,   94,   35,  602,

			  575,   47,  360,   20,   21,  102,  103,  104,  452,  484,
			  454,   66,  508,  509,  458,  247,  460,  461,  462,  463,
			  495,  103,  518,   25,   62,   63,  741,  523,  524,   47,
			   48,   25,   70,  508,  509,   59,   60,   41,   42,   25,
			  484,   66,  542,  518,   82,   25,   37,   85,  523,  524,
			   26,  495,  575,   79,   37,   59,   66,  547,  773,  774,
			  560,  776,   66,  778,  508,  509,   94,   71,  558,  301,
			  302,   75,   99,   27,  518,   79,   66,   39,   67,  523,
			  524,   71,  314,   73,   40,   75,  576,  319,   93,   79,
			   82,   64,  582,   75,   49,   66,  596,  596,  588,  599,

			   84,   48,  334,  593,   26,  562,  773,  774,  775,  776,
			   39,   33,  602,   35,  613,   66,   66,   45,   66,   41,
			   45,  621,   75,   41,   46,   97,   66,  772,  628,   39,
			   73,   90,  364,   66,   40,   57,  626,   79,   60,   61,
			  630,   59,   37,  600,   46,   46,   41,   42,   66,   71,
			   46,  100,   74,   71,   76,   66,   55,   75,   40,  649,
			  741,   79,   71,  395,   59,   87,  741,   89,   40,  659,
			   41,   66,  672,   95,  741,  686,   71,   69,   66,  678,
			   75,   42,   59,  682,   79,   48,   37,  687,   47,  646,
			  689,  106,   50,  774,  775,  776,   26,  778,   41,  774,

			  775,  776,  106,  778,   40,  704,  705,  774,  775,  776,
			   47,  778,   33,   33,   49,   77,   59,   26,   87,  718,
			  719,   47,   47,   66,   68,  725,  725,   25,   71,   47,
			  720,  688,   75,   47,   47,   66,   79,  737,   48,   62,
			   63,  741,   87,   47,   25,   46,   38,   70,   45,   39,
			  608,   47,  752,   47,   47,  712,   29,  747,  748,   82,
			  618,   84,   85,   47,  763,  764,   29,   47,   70,   35,
			   93,   62,   63,  773,  774,  775,  776,  767,  778,   70,
			   44,   40,  106,   25,   49,  784,   25,   58,   38,   68,
			   27,   82,   26,   84,   85,   46,  565,   46,  541,   14,

			   15,  450,   93,  450,   41,   42,   21,   22,   23,   24,
			  810,   26,  505,  450,   29,   30,   31,   32,   33,   34,
			   35,   45,   59,   38,  628,  470,   41,  560,   43,   66,
			   45,   46,  295,   48,   71,  581,   51,   52,   75,   54,
			   77,  641,   79,  701,   66,   60,  523,   84,  706,   71,
			  591,   73,  672,   75,  672,  356,   71,   79,  432,  717,
			  672,   76,   16,   17,   18,   19,   20,   21,  303,  727,
			  728,   86,   87,   88,   89,  672,  778,  672,  672,  672,
			   95,  739,  740,  672,  648,  426,  515,  745,  494,  767,
			  105,  483,  107,  108,  109,  110,  111,  112,  113,  114,

			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  446,  509,   14,   15,  575,
			  723,  779,  780,  344,   21,   22,   23,   24,  303,   26,
			  672,   -1,   29,   30,   31,   32,   33,   34,   35,   -1,
			   -1,   38,   -1,   -1,   41,   -1,   43,   -1,  806,   46,
			   -1,   48,   -1,   -1,   51,   52,   -1,   54,   -1,   -1,
			   -1,   -1,   -1,   60,   62,   63,   -1,   64,   66,   -1,
			   -1,   -1,   70,   -1,   71,   -1,   -1,   75,   -1,   76,
			   -1,   -1,   -1,   -1,   82,   -1,   -1,   85,   -1,   86,
			   87,   88,   89,   -1,   -1,   -1,   94,   -1,   95,   -1,

			   -1,   -1,   -1,   -1,  102,  103,   -1,   -1,  105,   -1,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,   14,   15,   -1,   -1,   -1,   -1,   -1,
			   21,   22,   23,   24,   -1,   26,   -1,   -1,   29,   30,
			   31,   32,   33,   34,   35,   -1,   -1,   38,   -1,   -1,
			   41,   -1,   43,   -1,   -1,   46,   -1,   48,   -1,   -1,
			   51,   52,   -1,   54,   -1,   -1,   -1,   -1,   -1,   60,
			   14,   15,   16,   17,   18,   19,   20,   21,   -1,   -1,
			   71,   -1,   -1,   -1,   -1,   76,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   86,   87,   88,   89,   -1,
			   -1,   -1,   -1,   -1,   95,   -1,   -1,   -1,   99,   -1,
			   -1,   -1,   -1,   -1,  105,   -1,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,   14,
			   15,   -1,   -1,   -1,   -1,   -1,   21,   22,   23,   24,
			   -1,   26,   -1,   -1,   29,   30,   31,   32,   33,   34,
			   35,   -1,   -1,   38,   -1,   -1,   41,   -1,   43,   -1,
			   45,   46,   -1,   48,   -1,   -1,   51,   52,   -1,   54,
			   -1,   -1,   -1,   -1,   -1,   60,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   71,   -1,   -1,   -1,
			   -1,   76,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   86,   87,   88,   89,   -1,   -1,   -1,   -1,   -1,
			   95,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  105,   -1,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,   14,   15,   -1,   -1,   -1,
			   -1,   -1,   21,   22,   23,   24,   -1,   26,   -1,   -1,
			   29,   30,   31,   32,   33,   34,   35,   -1,   -1,   38,
			   -1,   -1,   41,   -1,   43,   -1,   -1,   46,   -1,   48,

			   -1,   -1,   51,   52,   -1,   54,   -1,   -1,   -1,   -1,
			   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   71,   -1,   -1,   -1,   -1,   76,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   86,   87,   88,
			   89,   -1,   -1,   -1,   -1,   -1,   95,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  105,   -1,  107,  108,
			  109,  110,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,   14,   15,   -1,   -1,   -1,   -1,   -1,   21,   22,
			   23,   24,   -1,   26,   -1,   -1,   29,   30,   31,   32,

			   33,   34,   35,   -1,   -1,   38,   -1,   -1,   41,   -1,
			   43,   -1,   -1,   46,   -1,   48,   -1,   -1,   51,   52,
			   -1,   54,   -1,   -1,   -1,   -1,   -1,   60,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   71,   -1,
			   -1,   -1,   -1,   76,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   86,   87,   88,   89,   -1,   -1,   -1,
			   -1,   -1,   95,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  105,   -1,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,   14,   15,   -1,

			   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,   26,
			   -1,   -1,   29,   30,   31,   32,   33,   34,   35,   -1,
			   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   -1,   46,
			   -1,   48,   -1,   -1,   51,   52,   -1,   54,   -1,   -1,
			   -1,   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   71,   -1,   -1,   -1,   -1,   76,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   86,
			   87,   88,   89,   -1,   -1,   -1,   -1,   -1,   95,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  105,   -1,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,

			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,   14,   15,   -1,   -1,   -1,   -1,   -1,
			   21,   22,   23,   24,   -1,   26,   -1,   -1,   29,   30,
			   31,   32,   33,   34,   35,   -1,   -1,   38,   -1,   -1,
			   41,   -1,   43,   -1,   -1,   46,   -1,   48,   -1,   -1,
			   51,   52,   -1,   54,   -1,   -1,   -1,   -1,   -1,   60,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   71,   -1,   -1,   -1,   -1,   76,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   86,   87,   88,   89,   -1,
			   -1,   -1,   -1,   -1,   95,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,  105,   -1,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,   14,
			   15,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   29,   30,   31,   32,   33,   34,
			   35,   -1,   37,   14,   15,   -1,   41,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   51,   52,   29,   30,
			   31,   32,   33,   34,   35,   -1,   37,   14,   15,   -1,
			   41,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   51,   52,   29,   30,   31,   32,   33,   34,   35,   -1,

			   -1,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   51,   52,   -1,   -1,   -1,   -1,
			   -1,   -1,  107,  108,  109,   -1,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,   -1,  107,  108,  109,   -1,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,   -1,
			  107,  108,  109,   -1,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,   14,   15,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   29,   30,
			   31,   32,   -1,   34,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   51,   52,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   -1,   -1,   -1,   -1,   75,   -1,   -1,   -1,   32,   -1,
			   -1,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   -1,
			  101,   32,   -1,   -1,   -1,   -1,  107,  108,  109,   -1,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,

			  121,  122,  123,  124,  125,  126,  127,  128,  129,   32,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   45,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  104,  107,  108,  109,   -1,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,   99,  108,   -1,   -1,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,   -1,
			   -1,   -1,   -1,   -1,   -1,  108,   -1,   -1,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,

			  123,  124,  125,  126,  127,  128,  129,    4,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,    4,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   -1,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   -1,   -1,   -1,   -1,   45,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,

			   20,   21,   99,   45,   83,    4,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   -1,   -1,   -1,   -1,   -1,   45,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,   45,  129,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,    8,

			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21>>)
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

	yytype31 (v: ANY): FORMAL_AS is
		require
			valid_type: yyis_type31 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type31 (v: ANY): BOOLEAN is
		local
			u: FORMAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype32 (v: ANY): FORMAL_DEC_AS is
		require
			valid_type: yyis_type32 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type32 (v: ANY): BOOLEAN is
		local
			u: FORMAL_DEC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype33 (v: ANY): ID_AS is
		require
			valid_type: yyis_type33 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type33 (v: ANY): BOOLEAN is
		local
			u: ID_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype34 (v: ANY): IF_AS is
		require
			valid_type: yyis_type34 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type34 (v: ANY): BOOLEAN is
		local
			u: IF_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype35 (v: ANY): INDEX_AS is
		require
			valid_type: yyis_type35 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type35 (v: ANY): BOOLEAN is
		local
			u: INDEX_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype36 (v: ANY): INSPECT_AS is
		require
			valid_type: yyis_type36 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type36 (v: ANY): BOOLEAN is
		local
			u: INSPECT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype37 (v: ANY): INSTR_CALL_AS is
		require
			valid_type: yyis_type37 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type37 (v: ANY): BOOLEAN is
		local
			u: INSTR_CALL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype38 (v: ANY): INSTRUCTION_AS is
		require
			valid_type: yyis_type38 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type38 (v: ANY): BOOLEAN is
		local
			u: INSTRUCTION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype39 (v: ANY): INTEGER_CONSTANT is
		require
			valid_type: yyis_type39 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type39 (v: ANY): BOOLEAN is
		local
			u: INTEGER_CONSTANT
		do
			u ?= v
			Result := (u = v)
		end

	yytype40 (v: ANY): INTERNAL_AS is
		require
			valid_type: yyis_type40 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type40 (v: ANY): BOOLEAN is
		local
			u: INTERNAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype41 (v: ANY): INTERVAL_AS is
		require
			valid_type: yyis_type41 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type41 (v: ANY): BOOLEAN is
		local
			u: INTERVAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype42 (v: ANY): INVARIANT_AS is
		require
			valid_type: yyis_type42 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type42 (v: ANY): BOOLEAN is
		local
			u: INVARIANT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype43 (v: ANY): LOOP_AS is
		require
			valid_type: yyis_type43 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type43 (v: ANY): BOOLEAN is
		local
			u: LOOP_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype44 (v: ANY): NESTED_AS is
		require
			valid_type: yyis_type44 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type44 (v: ANY): BOOLEAN is
		local
			u: NESTED_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype45 (v: ANY): NESTED_EXPR_AS is
		require
			valid_type: yyis_type45 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type45 (v: ANY): BOOLEAN is
		local
			u: NESTED_EXPR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype46 (v: ANY): OPERAND_AS is
		require
			valid_type: yyis_type46 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type46 (v: ANY): BOOLEAN is
		local
			u: OPERAND_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype47 (v: ANY): PARENT_AS is
		require
			valid_type: yyis_type47 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type47 (v: ANY): BOOLEAN is
		local
			u: PARENT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype48 (v: ANY): PRECURSOR_AS is
		require
			valid_type: yyis_type48 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type48 (v: ANY): BOOLEAN is
		local
			u: PRECURSOR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype49 (v: ANY): STATIC_ACCESS_AS is
		require
			valid_type: yyis_type49 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type49 (v: ANY): BOOLEAN is
		local
			u: STATIC_ACCESS_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype50 (v: ANY): REAL_AS is
		require
			valid_type: yyis_type50 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type50 (v: ANY): BOOLEAN is
		local
			u: REAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype51 (v: ANY): RENAME_AS is
		require
			valid_type: yyis_type51 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type51 (v: ANY): BOOLEAN is
		local
			u: RENAME_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype52 (v: ANY): REQUIRE_AS is
		require
			valid_type: yyis_type52 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type52 (v: ANY): BOOLEAN is
		local
			u: REQUIRE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype53 (v: ANY): RETRY_AS is
		require
			valid_type: yyis_type53 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type53 (v: ANY): BOOLEAN is
		local
			u: RETRY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype54 (v: ANY): REVERSE_AS is
		require
			valid_type: yyis_type54 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type54 (v: ANY): BOOLEAN is
		local
			u: REVERSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype55 (v: ANY): ROUT_BODY_AS is
		require
			valid_type: yyis_type55 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type55 (v: ANY): BOOLEAN is
		local
			u: ROUT_BODY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype56 (v: ANY): ROUTINE_AS is
		require
			valid_type: yyis_type56 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type56 (v: ANY): BOOLEAN is
		local
			u: ROUTINE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype57 (v: ANY): ROUTINE_CREATION_AS is
		require
			valid_type: yyis_type57 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type57 (v: ANY): BOOLEAN is
		local
			u: ROUTINE_CREATION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype58 (v: ANY): TOKEN_LOCATION is
		require
			valid_type: yyis_type58 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type58 (v: ANY): BOOLEAN is
		local
			u: TOKEN_LOCATION
		do
			u ?= v
			Result := (u = v)
		end

	yytype59 (v: ANY): PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION] is
		require
			valid_type: yyis_type59 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type59 (v: ANY): BOOLEAN is
		local
			u: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
			u ?= v
			Result := (u = v)
		end

	yytype60 (v: ANY): STRING_AS is
		require
			valid_type: yyis_type60 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type60 (v: ANY): BOOLEAN is
		local
			u: STRING_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype61 (v: ANY): TAGGED_AS is
		require
			valid_type: yyis_type61 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type61 (v: ANY): BOOLEAN is
		local
			u: TAGGED_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype62 (v: ANY): TUPLE_AS is
		require
			valid_type: yyis_type62 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type62 (v: ANY): BOOLEAN is
		local
			u: TUPLE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype63 (v: ANY): TYPE_AS is
		require
			valid_type: yyis_type63 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type63 (v: ANY): BOOLEAN is
		local
			u: TYPE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype64 (v: ANY): TYPE_DEC_AS is
		require
			valid_type: yyis_type64 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type64 (v: ANY): BOOLEAN is
		local
			u: TYPE_DEC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype65 (v: ANY): VARIANT_AS is
		require
			valid_type: yyis_type65 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type65 (v: ANY): BOOLEAN is
		local
			u: VARIANT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype66 (v: ANY): EIFFEL_LIST [ATOMIC_AS] is
		require
			valid_type: yyis_type66 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type66 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ATOMIC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype67 (v: ANY): EIFFEL_LIST [CASE_AS] is
		require
			valid_type: yyis_type67 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type67 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CASE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype68 (v: ANY): EIFFEL_LIST [CONVERT_FEAT_AS] is
		require
			valid_type: yyis_type68 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type68 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype69 (v: ANY): EIFFEL_LIST [CREATE_AS] is
		require
			valid_type: yyis_type69 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type69 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CREATE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype70 (v: ANY): EIFFEL_LIST [ELSIF_AS] is
		require
			valid_type: yyis_type70 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type70 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ELSIF_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype71 (v: ANY): EIFFEL_LIST [EXPORT_ITEM_AS] is
		require
			valid_type: yyis_type71 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type71 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype72 (v: ANY): EIFFEL_LIST [EXPR_AS] is
		require
			valid_type: yyis_type72 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type72 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXPR_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype73 (v: ANY): EIFFEL_LIST [FEATURE_AS] is
		require
			valid_type: yyis_type73 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type73 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype74 (v: ANY): EIFFEL_LIST [FEATURE_CLAUSE_AS] is
		require
			valid_type: yyis_type74 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type74 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype76 (v: ANY): EIFFEL_LIST [FEATURE_NAME] is
		require
			valid_type: yyis_type76 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type76 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_NAME]
		do
			u ?= v
			Result := (u = v)
		end

	yytype77 (v: ANY): EIFFEL_LIST [FORMAL_DEC_AS] is
		require
			valid_type: yyis_type77 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type77 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FORMAL_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype78 (v: ANY): EIFFEL_LIST [ID_AS] is
		require
			valid_type: yyis_type78 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type78 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ID_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype80 (v: ANY): ARRAYED_LIST [INTEGER] is
		require
			valid_type: yyis_type80 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type80 (v: ANY): BOOLEAN is
		local
			u: ARRAYED_LIST [INTEGER]
		do
			u ?= v
			Result := (u = v)
		end

	yytype81 (v: ANY): INDEXING_CLAUSE_AS is
		require
			valid_type: yyis_type81 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type81 (v: ANY): BOOLEAN is
		local
			u: INDEXING_CLAUSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype82 (v: ANY): EIFFEL_LIST [INSTRUCTION_AS] is
		require
			valid_type: yyis_type82 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type82 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INSTRUCTION_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype83 (v: ANY): EIFFEL_LIST [INTERVAL_AS] is
		require
			valid_type: yyis_type83 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type83 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INTERVAL_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype84 (v: ANY): EIFFEL_LIST [OPERAND_AS] is
		require
			valid_type: yyis_type84 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type84 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [OPERAND_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype85 (v: ANY): EIFFEL_LIST [PARENT_AS] is
		require
			valid_type: yyis_type85 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type85 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [PARENT_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype86 (v: ANY): EIFFEL_LIST [RENAME_AS] is
		require
			valid_type: yyis_type86 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type86 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [RENAME_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype87 (v: ANY): EIFFEL_LIST [STRING_AS] is
		require
			valid_type: yyis_type87 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type87 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [STRING_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype88 (v: ANY): EIFFEL_LIST [TAGGED_AS] is
		require
			valid_type: yyis_type88 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type88 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TAGGED_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype89 (v: ANY): EIFFEL_LIST [TYPE_AS] is
		require
			valid_type: yyis_type89 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type89 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype90 (v: ANY): EIFFEL_LIST [TYPE_DEC_AS] is
		require
			valid_type: yyis_type90 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type90 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype92 (v: ANY): PAIR [ID_AS, CLICK_AST] is
		require
			valid_type: yyis_type92 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type92 (v: ANY): BOOLEAN is
		local
			u: PAIR [ID_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype93 (v: ANY): PAIR [FEATURE_NAME, CLICK_AST] is
		require
			valid_type: yyis_type93 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type93 (v: ANY): BOOLEAN is
		local
			u: PAIR [FEATURE_NAME, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype94 (v: ANY): PAIR [STRING_AS, CLICK_AST] is
		require
			valid_type: yyis_type94 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type94 (v: ANY): BOOLEAN is
		local
			u: PAIR [STRING_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype95 (v: ANY): PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST] is
		require
			valid_type: yyis_type95 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type95 (v: ANY): BOOLEAN is
		local
			u: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype96 (v: ANY): PAIR [TYPE_AS, EIFFEL_LIST [FEATURE_NAME]] is
		require
			valid_type: yyis_type96 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type96 (v: ANY): BOOLEAN is
		local
			u: PAIR [TYPE_AS, EIFFEL_LIST [FEATURE_NAME]]
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 816
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 130
			-- Number of tokens

	yyLast: INTEGER is 2312
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 384
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 318
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
