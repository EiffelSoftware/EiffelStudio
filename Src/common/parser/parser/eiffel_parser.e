indexing

	description: "Eiffel parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_PARSER

inherit

	EIFFEL_PARSER_SKELETON
		redefine
			yy_translate
		end

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
--|#line 237 "eiffel.y"
	yy_do_action_4
when 5 then
--|#line 246 "eiffel.y"
	yy_do_action_5
when 6 then
--|#line 248 "eiffel.y"
	yy_do_action_6
when 7 then
--|#line 250 "eiffel.y"
	yy_do_action_7
when 8 then
--|#line 252 "eiffel.y"
	yy_do_action_8
when 9 then
--|#line 254 "eiffel.y"
	yy_do_action_9
when 10 then
--|#line 256 "eiffel.y"
	yy_do_action_10
when 11 then
--|#line 258 "eiffel.y"
	yy_do_action_11
when 12 then
--|#line 260 "eiffel.y"
	yy_do_action_12
when 13 then
--|#line 262 "eiffel.y"
	yy_do_action_13
when 14 then
--|#line 264 "eiffel.y"
	yy_do_action_14
when 15 then
--|#line 266 "eiffel.y"
	yy_do_action_15
when 16 then
--|#line 268 "eiffel.y"
	yy_do_action_16
when 17 then
--|#line 272 "eiffel.y"
	yy_do_action_17
when 18 then
--|#line 276 "eiffel.y"
	yy_do_action_18
when 19 then
--|#line 280 "eiffel.y"
	yy_do_action_19
when 20 then
--|#line 284 "eiffel.y"
	yy_do_action_20
when 21 then
--|#line 288 "eiffel.y"
	yy_do_action_21
when 22 then
--|#line 292 "eiffel.y"
	yy_do_action_22
when 23 then
--|#line 296 "eiffel.y"
	yy_do_action_23
when 24 then
--|#line 300 "eiffel.y"
	yy_do_action_24
when 25 then
--|#line 304 "eiffel.y"
	yy_do_action_25
when 26 then
--|#line 308 "eiffel.y"
	yy_do_action_26
when 27 then
--|#line 312 "eiffel.y"
	yy_do_action_27
when 28 then
--|#line 316 "eiffel.y"
	yy_do_action_28
when 29 then
--|#line 323 "eiffel.y"
	yy_do_action_29
when 30 then
--|#line 325 "eiffel.y"
	yy_do_action_30
when 31 then
--|#line 327 "eiffel.y"
	yy_do_action_31
when 32 then
--|#line 331 "eiffel.y"
	yy_do_action_32
when 33 then
--|#line 333 "eiffel.y"
	yy_do_action_33
when 34 then
--|#line 335 "eiffel.y"
	yy_do_action_34
when 35 then
--|#line 339 "eiffel.y"
	yy_do_action_35
when 36 then
--|#line 341 "eiffel.y"
	yy_do_action_36
when 37 then
--|#line 343 "eiffel.y"
	yy_do_action_37
when 38 then
--|#line 347 "eiffel.y"
	yy_do_action_38
when 39 then
--|#line 352 "eiffel.y"
	yy_do_action_39
when 40 then
--|#line 359 "eiffel.y"
	yy_do_action_40
when 41 then
--|#line 363 "eiffel.y"
	yy_do_action_41
when 42 then
--|#line 365 "eiffel.y"
	yy_do_action_42
when 43 then
--|#line 369 "eiffel.y"
	yy_do_action_43
when 44 then
--|#line 374 "eiffel.y"
	yy_do_action_44
when 45 then
--|#line 379 "eiffel.y"
	yy_do_action_45
when 46 then
--|#line 386 "eiffel.y"
	yy_do_action_46
when 47 then
--|#line 388 "eiffel.y"
	yy_do_action_47
when 48 then
--|#line 390 "eiffel.y"
	yy_do_action_48
when 49 then
--|#line 394 "eiffel.y"
	yy_do_action_49
when 50 then
--|#line 404 "eiffel.y"
	yy_do_action_50
when 51 then
--|#line 410 "eiffel.y"
	yy_do_action_51
when 52 then
--|#line 417 "eiffel.y"
	yy_do_action_52
when 53 then
--|#line 423 "eiffel.y"
	yy_do_action_53
when 54 then
--|#line 431 "eiffel.y"
	yy_do_action_54
when 55 then
--|#line 435 "eiffel.y"
	yy_do_action_55
when 56 then
--|#line 446 "eiffel.y"
	yy_do_action_56
when 57 then
--|#line 450 "eiffel.y"
	yy_do_action_57
when 58 then
--|#line 465 "eiffel.y"
	yy_do_action_58
when 59 then
--|#line 467 "eiffel.y"
	yy_do_action_59
when 60 then
--|#line 474 "eiffel.y"
	yy_do_action_60
when 61 then
--|#line 476 "eiffel.y"
	yy_do_action_61
when 62 then
--|#line 485 "eiffel.y"
	yy_do_action_62
when 63 then
--|#line 490 "eiffel.y"
	yy_do_action_63
when 64 then
--|#line 497 "eiffel.y"
	yy_do_action_64
when 65 then
--|#line 499 "eiffel.y"
	yy_do_action_65
when 66 then
--|#line 503 "eiffel.y"
	yy_do_action_66
when 67 then
--|#line 503 "eiffel.y"
	yy_do_action_67
when 68 then
--|#line 512 "eiffel.y"
	yy_do_action_68
when 69 then
--|#line 514 "eiffel.y"
	yy_do_action_69
when 70 then
--|#line 518 "eiffel.y"
	yy_do_action_70
when 71 then
--|#line 523 "eiffel.y"
	yy_do_action_71
when 72 then
--|#line 527 "eiffel.y"
	yy_do_action_72
when 73 then
--|#line 533 "eiffel.y"
	yy_do_action_73
when 74 then
--|#line 541 "eiffel.y"
	yy_do_action_74
when 75 then
--|#line 546 "eiffel.y"
	yy_do_action_75
when 76 then
--|#line 553 "eiffel.y"
	yy_do_action_76
when 77 then
--|#line 554 "eiffel.y"
	yy_do_action_77
when 78 then
--|#line 557 "eiffel.y"
	yy_do_action_78
when 79 then
--|#line 570 "eiffel.y"
	yy_do_action_79
when 80 then
--|#line 572 "eiffel.y"
	yy_do_action_80
when 81 then
--|#line 579 "eiffel.y"
	yy_do_action_81
when 82 then
--|#line 583 "eiffel.y"
	yy_do_action_82
when 83 then
--|#line 585 "eiffel.y"
	yy_do_action_83
when 84 then
--|#line 589 "eiffel.y"
	yy_do_action_84
when 85 then
--|#line 591 "eiffel.y"
	yy_do_action_85
when 86 then
--|#line 593 "eiffel.y"
	yy_do_action_86
when 87 then
--|#line 597 "eiffel.y"
	yy_do_action_87
when 88 then
--|#line 602 "eiffel.y"
	yy_do_action_88
when 89 then
--|#line 606 "eiffel.y"
	yy_do_action_89
when 90 then
--|#line 610 "eiffel.y"
	yy_do_action_90
when 91 then
--|#line 612 "eiffel.y"
	yy_do_action_91
when 92 then
--|#line 616 "eiffel.y"
	yy_do_action_92
when 93 then
--|#line 621 "eiffel.y"
	yy_do_action_93
when 94 then
--|#line 626 "eiffel.y"
	yy_do_action_94
when 95 then
--|#line 637 "eiffel.y"
	yy_do_action_95
when 96 then
--|#line 639 "eiffel.y"
	yy_do_action_96
when 97 then
--|#line 641 "eiffel.y"
	yy_do_action_97
when 98 then
--|#line 645 "eiffel.y"
	yy_do_action_98
when 99 then
--|#line 650 "eiffel.y"
	yy_do_action_99
when 100 then
--|#line 657 "eiffel.y"
	yy_do_action_100
when 101 then
--|#line 662 "eiffel.y"
	yy_do_action_101
when 102 then
--|#line 670 "eiffel.y"
	yy_do_action_102
when 103 then
--|#line 675 "eiffel.y"
	yy_do_action_103
when 104 then
--|#line 680 "eiffel.y"
	yy_do_action_104
when 105 then
--|#line 685 "eiffel.y"
	yy_do_action_105
when 106 then
--|#line 690 "eiffel.y"
	yy_do_action_106
when 107 then
--|#line 695 "eiffel.y"
	yy_do_action_107
when 108 then
--|#line 700 "eiffel.y"
	yy_do_action_108
when 109 then
--|#line 708 "eiffel.y"
	yy_do_action_109
when 110 then
--|#line 710 "eiffel.y"
	yy_do_action_110
when 111 then
--|#line 714 "eiffel.y"
	yy_do_action_111
when 112 then
--|#line 719 "eiffel.y"
	yy_do_action_112
when 113 then
--|#line 726 "eiffel.y"
	yy_do_action_113
when 114 then
--|#line 730 "eiffel.y"
	yy_do_action_114
when 115 then
--|#line 732 "eiffel.y"
	yy_do_action_115
when 116 then
--|#line 736 "eiffel.y"
	yy_do_action_116
when 117 then
--|#line 738 "eiffel.y"
	yy_do_action_117
when 118 then
--|#line 742 "eiffel.y"
	yy_do_action_118
when 119 then
--|#line 747 "eiffel.y"
	yy_do_action_119
when 120 then
--|#line 754 "eiffel.y"
	yy_do_action_120
when 121 then
--|#line 758 "eiffel.y"
	yy_do_action_121
when 122 then
--|#line 760 "eiffel.y"
	yy_do_action_122
when 123 then
--|#line 764 "eiffel.y"
	yy_do_action_123
when 124 then
--|#line 769 "eiffel.y"
	yy_do_action_124
when 125 then
--|#line 776 "eiffel.y"
	yy_do_action_125
when 126 then
--|#line 778 "eiffel.y"
	yy_do_action_126
when 127 then
--|#line 782 "eiffel.y"
	yy_do_action_127
when 128 then
--|#line 784 "eiffel.y"
	yy_do_action_128
when 129 then
--|#line 788 "eiffel.y"
	yy_do_action_129
when 130 then
--|#line 790 "eiffel.y"
	yy_do_action_130
when 131 then
--|#line 794 "eiffel.y"
	yy_do_action_131
when 132 then
--|#line 796 "eiffel.y"
	yy_do_action_132
when 133 then
--|#line 800 "eiffel.y"
	yy_do_action_133
when 134 then
--|#line 802 "eiffel.y"
	yy_do_action_134
when 135 then
--|#line 806 "eiffel.y"
	yy_do_action_135
when 136 then
--|#line 808 "eiffel.y"
	yy_do_action_136
when 137 then
--|#line 816 "eiffel.y"
	yy_do_action_137
when 138 then
--|#line 818 "eiffel.y"
	yy_do_action_138
when 139 then
--|#line 822 "eiffel.y"
	yy_do_action_139
when 140 then
--|#line 824 "eiffel.y"
	yy_do_action_140
when 141 then
--|#line 828 "eiffel.y"
	yy_do_action_141
when 142 then
--|#line 833 "eiffel.y"
	yy_do_action_142
when 143 then
--|#line 840 "eiffel.y"
	yy_do_action_143
when 144 then
--|#line 844 "eiffel.y"
	yy_do_action_144
when 145 then
--|#line 845 "eiffel.y"
	yy_do_action_145
when 146 then
--|#line 854 "eiffel.y"
	yy_do_action_146
when 147 then
--|#line 856 "eiffel.y"
	yy_do_action_147
when 148 then
--|#line 860 "eiffel.y"
	yy_do_action_148
when 149 then
--|#line 865 "eiffel.y"
	yy_do_action_149
when 150 then
--|#line 872 "eiffel.y"
	yy_do_action_150
when 151 then
--|#line 876 "eiffel.y"
	yy_do_action_151
when 152 then
--|#line 882 "eiffel.y"
	yy_do_action_152
when 153 then
--|#line 890 "eiffel.y"
	yy_do_action_153
when 154 then
--|#line 892 "eiffel.y"
	yy_do_action_154
when 155 then
--|#line 896 "eiffel.y"
	yy_do_action_155
when 156 then
--|#line 898 "eiffel.y"
	yy_do_action_156
when 157 then
--|#line 902 "eiffel.y"
	yy_do_action_157
when 158 then
--|#line 902 "eiffel.y"
	yy_do_action_158
when 159 then
--|#line 914 "eiffel.y"
	yy_do_action_159
when 160 then
--|#line 916 "eiffel.y"
	yy_do_action_160
when 161 then
--|#line 918 "eiffel.y"
	yy_do_action_161
when 162 then
--|#line 922 "eiffel.y"
	yy_do_action_162
when 163 then
--|#line 926 "eiffel.y"
	yy_do_action_163
when 164 then
--|#line 931 "eiffel.y"
	yy_do_action_164
when 165 then
--|#line 933 "eiffel.y"
	yy_do_action_165
when 166 then
--|#line 937 "eiffel.y"
	yy_do_action_166
when 167 then
--|#line 939 "eiffel.y"
	yy_do_action_167
when 168 then
--|#line 943 "eiffel.y"
	yy_do_action_168
when 169 then
--|#line 945 "eiffel.y"
	yy_do_action_169
when 170 then
--|#line 949 "eiffel.y"
	yy_do_action_170
when 171 then
--|#line 951 "eiffel.y"
	yy_do_action_171
when 172 then
--|#line 955 "eiffel.y"
	yy_do_action_172
when 173 then
--|#line 960 "eiffel.y"
	yy_do_action_173
when 174 then
--|#line 967 "eiffel.y"
	yy_do_action_174
when 175 then
--|#line 971 "eiffel.y"
	yy_do_action_175
when 176 then
--|#line 972 "eiffel.y"
	yy_do_action_176
when 177 then
--|#line 975 "eiffel.y"
	yy_do_action_177
when 178 then
--|#line 977 "eiffel.y"
	yy_do_action_178
when 179 then
--|#line 979 "eiffel.y"
	yy_do_action_179
when 180 then
--|#line 981 "eiffel.y"
	yy_do_action_180
when 181 then
--|#line 983 "eiffel.y"
	yy_do_action_181
when 182 then
--|#line 985 "eiffel.y"
	yy_do_action_182
when 183 then
--|#line 987 "eiffel.y"
	yy_do_action_183
when 184 then
--|#line 989 "eiffel.y"
	yy_do_action_184
when 185 then
--|#line 991 "eiffel.y"
	yy_do_action_185
when 186 then
--|#line 993 "eiffel.y"
	yy_do_action_186
when 187 then
--|#line 997 "eiffel.y"
	yy_do_action_187
when 188 then
--|#line 999 "eiffel.y"
	yy_do_action_188
when 189 then
--|#line 999 "eiffel.y"
	yy_do_action_189
when 190 then
--|#line 1006 "eiffel.y"
	yy_do_action_190
when 191 then
--|#line 1006 "eiffel.y"
	yy_do_action_191
when 192 then
--|#line 1015 "eiffel.y"
	yy_do_action_192
when 193 then
--|#line 1017 "eiffel.y"
	yy_do_action_193
when 194 then
--|#line 1017 "eiffel.y"
	yy_do_action_194
when 195 then
--|#line 1024 "eiffel.y"
	yy_do_action_195
when 196 then
--|#line 1024 "eiffel.y"
	yy_do_action_196
when 197 then
--|#line 1033 "eiffel.y"
	yy_do_action_197
when 198 then
--|#line 1035 "eiffel.y"
	yy_do_action_198
when 199 then
--|#line 1044 "eiffel.y"
	yy_do_action_199
when 200 then
--|#line 1049 "eiffel.y"
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
--|#line 1056 "eiffel.y"
	yy_do_action_201
when 202 then
--|#line 1060 "eiffel.y"
	yy_do_action_202
when 203 then
--|#line 1062 "eiffel.y"
	yy_do_action_203
when 204 then
--|#line 1064 "eiffel.y"
	yy_do_action_204
when 205 then
--|#line 1072 "eiffel.y"
	yy_do_action_205
when 206 then
--|#line 1074 "eiffel.y"
	yy_do_action_206
when 207 then
--|#line 1078 "eiffel.y"
	yy_do_action_207
when 208 then
--|#line 1080 "eiffel.y"
	yy_do_action_208
when 209 then
--|#line 1082 "eiffel.y"
	yy_do_action_209
when 210 then
--|#line 1084 "eiffel.y"
	yy_do_action_210
when 211 then
--|#line 1086 "eiffel.y"
	yy_do_action_211
when 212 then
--|#line 1088 "eiffel.y"
	yy_do_action_212
when 213 then
--|#line 1092 "eiffel.y"
	yy_do_action_213
when 214 then
--|#line 1094 "eiffel.y"
	yy_do_action_214
when 215 then
--|#line 1096 "eiffel.y"
	yy_do_action_215
when 216 then
--|#line 1098 "eiffel.y"
	yy_do_action_216
when 217 then
--|#line 1100 "eiffel.y"
	yy_do_action_217
when 218 then
--|#line 1102 "eiffel.y"
	yy_do_action_218
when 219 then
--|#line 1104 "eiffel.y"
	yy_do_action_219
when 220 then
--|#line 1106 "eiffel.y"
	yy_do_action_220
when 221 then
--|#line 1108 "eiffel.y"
	yy_do_action_221
when 222 then
--|#line 1110 "eiffel.y"
	yy_do_action_222
when 223 then
--|#line 1112 "eiffel.y"
	yy_do_action_223
when 224 then
--|#line 1114 "eiffel.y"
	yy_do_action_224
when 225 then
--|#line 1118 "eiffel.y"
	yy_do_action_225
when 226 then
--|#line 1120 "eiffel.y"
	yy_do_action_226
when 227 then
--|#line 1122 "eiffel.y"
	yy_do_action_227
when 228 then
--|#line 1126 "eiffel.y"
	yy_do_action_228
when 229 then
--|#line 1131 "eiffel.y"
	yy_do_action_229
when 230 then
--|#line 1142 "eiffel.y"
	yy_do_action_230
when 231 then
--|#line 1148 "eiffel.y"
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
--|#line 1174 "eiffel.y"
	yy_do_action_236
when 237 then
--|#line 1174 "eiffel.y"
	yy_do_action_237
when 238 then
--|#line 1184 "eiffel.y"
	yy_do_action_238
when 239 then
--|#line 1186 "eiffel.y"
	yy_do_action_239
when 240 then
--|#line 1194 "eiffel.y"
	yy_do_action_240
when 241 then
--|#line 1196 "eiffel.y"
	yy_do_action_241
when 242 then
--|#line 1204 "eiffel.y"
	yy_do_action_242
when 243 then
--|#line 1210 "eiffel.y"
	yy_do_action_243
when 244 then
--|#line 1212 "eiffel.y"
	yy_do_action_244
when 245 then
--|#line 1216 "eiffel.y"
	yy_do_action_245
when 246 then
--|#line 1221 "eiffel.y"
	yy_do_action_246
when 247 then
--|#line 1228 "eiffel.y"
	yy_do_action_247
when 248 then
--|#line 1232 "eiffel.y"
	yy_do_action_248
when 249 then
--|#line 1234 "eiffel.y"
	yy_do_action_249
when 250 then
--|#line 1238 "eiffel.y"
	yy_do_action_250
when 251 then
--|#line 1244 "eiffel.y"
	yy_do_action_251
when 252 then
--|#line 1246 "eiffel.y"
	yy_do_action_252
when 253 then
--|#line 1250 "eiffel.y"
	yy_do_action_253
when 254 then
--|#line 1255 "eiffel.y"
	yy_do_action_254
when 255 then
--|#line 1262 "eiffel.y"
	yy_do_action_255
when 256 then
--|#line 1266 "eiffel.y"
	yy_do_action_256
when 257 then
--|#line 1271 "eiffel.y"
	yy_do_action_257
when 258 then
--|#line 1278 "eiffel.y"
	yy_do_action_258
when 259 then
--|#line 1280 "eiffel.y"
	yy_do_action_259
when 260 then
--|#line 1282 "eiffel.y"
	yy_do_action_260
when 261 then
--|#line 1284 "eiffel.y"
	yy_do_action_261
when 262 then
--|#line 1286 "eiffel.y"
	yy_do_action_262
when 263 then
--|#line 1288 "eiffel.y"
	yy_do_action_263
when 264 then
--|#line 1290 "eiffel.y"
	yy_do_action_264
when 265 then
--|#line 1292 "eiffel.y"
	yy_do_action_265
when 266 then
--|#line 1294 "eiffel.y"
	yy_do_action_266
when 267 then
--|#line 1296 "eiffel.y"
	yy_do_action_267
when 268 then
--|#line 1298 "eiffel.y"
	yy_do_action_268
when 269 then
--|#line 1300 "eiffel.y"
	yy_do_action_269
when 270 then
--|#line 1302 "eiffel.y"
	yy_do_action_270
when 271 then
--|#line 1304 "eiffel.y"
	yy_do_action_271
when 272 then
--|#line 1306 "eiffel.y"
	yy_do_action_272
when 273 then
--|#line 1308 "eiffel.y"
	yy_do_action_273
when 274 then
--|#line 1310 "eiffel.y"
	yy_do_action_274
when 275 then
--|#line 1312 "eiffel.y"
	yy_do_action_275
when 276 then
--|#line 1317 "eiffel.y"
	yy_do_action_276
when 277 then
--|#line 1319 "eiffel.y"
	yy_do_action_277
when 278 then
--|#line 1328 "eiffel.y"
	yy_do_action_278
when 279 then
--|#line 1334 "eiffel.y"
	yy_do_action_279
when 280 then
--|#line 1336 "eiffel.y"
	yy_do_action_280
when 281 then
--|#line 1340 "eiffel.y"
	yy_do_action_281
when 282 then
--|#line 1342 "eiffel.y"
	yy_do_action_282
when 283 then
--|#line 1342 "eiffel.y"
	yy_do_action_283
when 284 then
--|#line 1352 "eiffel.y"
	yy_do_action_284
when 285 then
--|#line 1354 "eiffel.y"
	yy_do_action_285
when 286 then
--|#line 1356 "eiffel.y"
	yy_do_action_286
when 287 then
--|#line 1360 "eiffel.y"
	yy_do_action_287
when 288 then
--|#line 1366 "eiffel.y"
	yy_do_action_288
when 289 then
--|#line 1368 "eiffel.y"
	yy_do_action_289
when 290 then
--|#line 1370 "eiffel.y"
	yy_do_action_290
when 291 then
--|#line 1374 "eiffel.y"
	yy_do_action_291
when 292 then
--|#line 1379 "eiffel.y"
	yy_do_action_292
when 293 then
--|#line 1386 "eiffel.y"
	yy_do_action_293
when 294 then
--|#line 1390 "eiffel.y"
	yy_do_action_294
when 295 then
--|#line 1392 "eiffel.y"
	yy_do_action_295
when 296 then
--|#line 1401 "eiffel.y"
	yy_do_action_296
when 297 then
--|#line 1403 "eiffel.y"
	yy_do_action_297
when 298 then
--|#line 1407 "eiffel.y"
	yy_do_action_298
when 299 then
--|#line 1409 "eiffel.y"
	yy_do_action_299
when 300 then
--|#line 1413 "eiffel.y"
	yy_do_action_300
when 301 then
--|#line 1415 "eiffel.y"
	yy_do_action_301
when 302 then
--|#line 1419 "eiffel.y"
	yy_do_action_302
when 303 then
--|#line 1424 "eiffel.y"
	yy_do_action_303
when 304 then
--|#line 1431 "eiffel.y"
	yy_do_action_304
when 305 then
--|#line 1437 "eiffel.y"
	yy_do_action_305
when 306 then
--|#line 1442 "eiffel.y"
	yy_do_action_306
when 307 then
--|#line 1447 "eiffel.y"
	yy_do_action_307
when 308 then
--|#line 1457 "eiffel.y"
	yy_do_action_308
when 309 then
--|#line 1467 "eiffel.y"
	yy_do_action_309
when 310 then
--|#line 1479 "eiffel.y"
	yy_do_action_310
when 311 then
--|#line 1482 "eiffel.y"
	yy_do_action_311
when 312 then
--|#line 1484 "eiffel.y"
	yy_do_action_312
when 313 then
--|#line 1486 "eiffel.y"
	yy_do_action_313
when 314 then
--|#line 1488 "eiffel.y"
	yy_do_action_314
when 315 then
--|#line 1490 "eiffel.y"
	yy_do_action_315
when 316 then
--|#line 1492 "eiffel.y"
	yy_do_action_316
when 317 then
--|#line 1494 "eiffel.y"
	yy_do_action_317
when 318 then
--|#line 1503 "eiffel.y"
	yy_do_action_318
when 319 then
--|#line 1512 "eiffel.y"
	yy_do_action_319
when 320 then
--|#line 1522 "eiffel.y"
	yy_do_action_320
when 321 then
--|#line 1531 "eiffel.y"
	yy_do_action_321
when 322 then
--|#line 1540 "eiffel.y"
	yy_do_action_322
when 323 then
--|#line 1549 "eiffel.y"
	yy_do_action_323
when 324 then
--|#line 1560 "eiffel.y"
	yy_do_action_324
when 325 then
--|#line 1562 "eiffel.y"
	yy_do_action_325
when 326 then
--|#line 1566 "eiffel.y"
	yy_do_action_326
when 327 then
--|#line 1571 "eiffel.y"
	yy_do_action_327
when 328 then
--|#line 1578 "eiffel.y"
	yy_do_action_328
when 329 then
--|#line 1580 "eiffel.y"
	yy_do_action_329
when 330 then
--|#line 1582 "eiffel.y"
	yy_do_action_330
when 331 then
--|#line 1586 "eiffel.y"
	yy_do_action_331
when 332 then
--|#line 1595 "eiffel.y"
	yy_do_action_332
when 333 then
--|#line 1597 "eiffel.y"
	yy_do_action_333
when 334 then
--|#line 1601 "eiffel.y"
	yy_do_action_334
when 335 then
--|#line 1603 "eiffel.y"
	yy_do_action_335
when 336 then
--|#line 1614 "eiffel.y"
	yy_do_action_336
when 337 then
--|#line 1616 "eiffel.y"
	yy_do_action_337
when 338 then
--|#line 1620 "eiffel.y"
	yy_do_action_338
when 339 then
--|#line 1622 "eiffel.y"
	yy_do_action_339
when 340 then
--|#line 1626 "eiffel.y"
	yy_do_action_340
when 341 then
--|#line 1628 "eiffel.y"
	yy_do_action_341
when 342 then
--|#line 1636 "eiffel.y"
	yy_do_action_342
when 343 then
--|#line 1638 "eiffel.y"
	yy_do_action_343
when 344 then
--|#line 1640 "eiffel.y"
	yy_do_action_344
when 345 then
--|#line 1642 "eiffel.y"
	yy_do_action_345
when 346 then
--|#line 1644 "eiffel.y"
	yy_do_action_346
when 347 then
--|#line 1646 "eiffel.y"
	yy_do_action_347
when 348 then
--|#line 1648 "eiffel.y"
	yy_do_action_348
when 349 then
--|#line 1650 "eiffel.y"
	yy_do_action_349
when 350 then
--|#line 1652 "eiffel.y"
	yy_do_action_350
when 351 then
--|#line 1656 "eiffel.y"
	yy_do_action_351
when 352 then
--|#line 1664 "eiffel.y"
	yy_do_action_352
when 353 then
--|#line 1666 "eiffel.y"
	yy_do_action_353
when 354 then
--|#line 1668 "eiffel.y"
	yy_do_action_354
when 355 then
--|#line 1670 "eiffel.y"
	yy_do_action_355
when 356 then
--|#line 1672 "eiffel.y"
	yy_do_action_356
when 357 then
--|#line 1674 "eiffel.y"
	yy_do_action_357
when 358 then
--|#line 1676 "eiffel.y"
	yy_do_action_358
when 359 then
--|#line 1678 "eiffel.y"
	yy_do_action_359
when 360 then
--|#line 1680 "eiffel.y"
	yy_do_action_360
when 361 then
--|#line 1682 "eiffel.y"
	yy_do_action_361
when 362 then
--|#line 1684 "eiffel.y"
	yy_do_action_362
when 363 then
--|#line 1686 "eiffel.y"
	yy_do_action_363
when 364 then
--|#line 1688 "eiffel.y"
	yy_do_action_364
when 365 then
--|#line 1690 "eiffel.y"
	yy_do_action_365
when 366 then
--|#line 1692 "eiffel.y"
	yy_do_action_366
when 367 then
--|#line 1694 "eiffel.y"
	yy_do_action_367
when 368 then
--|#line 1696 "eiffel.y"
	yy_do_action_368
when 369 then
--|#line 1698 "eiffel.y"
	yy_do_action_369
when 370 then
--|#line 1700 "eiffel.y"
	yy_do_action_370
when 371 then
--|#line 1702 "eiffel.y"
	yy_do_action_371
when 372 then
--|#line 1704 "eiffel.y"
	yy_do_action_372
when 373 then
--|#line 1706 "eiffel.y"
	yy_do_action_373
when 374 then
--|#line 1708 "eiffel.y"
	yy_do_action_374
when 375 then
--|#line 1710 "eiffel.y"
	yy_do_action_375
when 376 then
--|#line 1712 "eiffel.y"
	yy_do_action_376
when 377 then
--|#line 1714 "eiffel.y"
	yy_do_action_377
when 378 then
--|#line 1716 "eiffel.y"
	yy_do_action_378
when 379 then
--|#line 1718 "eiffel.y"
	yy_do_action_379
when 380 then
--|#line 1720 "eiffel.y"
	yy_do_action_380
when 381 then
--|#line 1722 "eiffel.y"
	yy_do_action_381
when 382 then
--|#line 1724 "eiffel.y"
	yy_do_action_382
when 383 then
--|#line 1726 "eiffel.y"
	yy_do_action_383
when 384 then
--|#line 1728 "eiffel.y"
	yy_do_action_384
when 385 then
--|#line 1730 "eiffel.y"
	yy_do_action_385
when 386 then
--|#line 1732 "eiffel.y"
	yy_do_action_386
when 387 then
--|#line 1734 "eiffel.y"
	yy_do_action_387
when 388 then
--|#line 1738 "eiffel.y"
	yy_do_action_388
when 389 then
--|#line 1746 "eiffel.y"
	yy_do_action_389
when 390 then
--|#line 1748 "eiffel.y"
	yy_do_action_390
when 391 then
--|#line 1750 "eiffel.y"
	yy_do_action_391
when 392 then
--|#line 1752 "eiffel.y"
	yy_do_action_392
when 393 then
--|#line 1754 "eiffel.y"
	yy_do_action_393
when 394 then
--|#line 1756 "eiffel.y"
	yy_do_action_394
when 395 then
--|#line 1758 "eiffel.y"
	yy_do_action_395
when 396 then
--|#line 1760 "eiffel.y"
	yy_do_action_396
when 397 then
--|#line 1762 "eiffel.y"
	yy_do_action_397
when 398 then
--|#line 1764 "eiffel.y"
	yy_do_action_398
when 399 then
--|#line 1766 "eiffel.y"
	yy_do_action_399
when 400 then
--|#line 1768 "eiffel.y"
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
--|#line 1772 "eiffel.y"
	yy_do_action_401
when 402 then
--|#line 1776 "eiffel.y"
	yy_do_action_402
when 403 then
--|#line 1780 "eiffel.y"
	yy_do_action_403
when 404 then
--|#line 1784 "eiffel.y"
	yy_do_action_404
when 405 then
--|#line 1788 "eiffel.y"
	yy_do_action_405
when 406 then
--|#line 1792 "eiffel.y"
	yy_do_action_406
when 407 then
--|#line 1794 "eiffel.y"
	yy_do_action_407
when 408 then
--|#line 1796 "eiffel.y"
	yy_do_action_408
when 409 then
--|#line 1798 "eiffel.y"
	yy_do_action_409
when 410 then
--|#line 1800 "eiffel.y"
	yy_do_action_410
when 411 then
--|#line 1802 "eiffel.y"
	yy_do_action_411
when 412 then
--|#line 1804 "eiffel.y"
	yy_do_action_412
when 413 then
--|#line 1806 "eiffel.y"
	yy_do_action_413
when 414 then
--|#line 1808 "eiffel.y"
	yy_do_action_414
when 415 then
--|#line 1810 "eiffel.y"
	yy_do_action_415
when 416 then
--|#line 1812 "eiffel.y"
	yy_do_action_416
when 417 then
--|#line 1814 "eiffel.y"
	yy_do_action_417
when 418 then
--|#line 1816 "eiffel.y"
	yy_do_action_418
when 419 then
--|#line 1818 "eiffel.y"
	yy_do_action_419
when 420 then
--|#line 1820 "eiffel.y"
	yy_do_action_420
when 421 then
--|#line 1824 "eiffel.y"
	yy_do_action_421
when 422 then
--|#line 1828 "eiffel.y"
	yy_do_action_422
when 423 then
--|#line 1835 "eiffel.y"
	yy_do_action_423
when 424 then
--|#line 1843 "eiffel.y"
	yy_do_action_424
when 425 then
--|#line 1845 "eiffel.y"
	yy_do_action_425
when 426 then
--|#line 1849 "eiffel.y"
	yy_do_action_426
when 427 then
--|#line 1851 "eiffel.y"
	yy_do_action_427
when 428 then
--|#line 1855 "eiffel.y"
	yy_do_action_428
when 429 then
--|#line 1868 "eiffel.y"
	yy_do_action_429
when 430 then
--|#line 1872 "eiffel.y"
	yy_do_action_430
when 431 then
--|#line 1874 "eiffel.y"
	yy_do_action_431
when 432 then
--|#line 1876 "eiffel.y"
	yy_do_action_432
when 433 then
--|#line 1880 "eiffel.y"
	yy_do_action_433
when 434 then
--|#line 1885 "eiffel.y"
	yy_do_action_434
when 435 then
--|#line 1892 "eiffel.y"
	yy_do_action_435
when 436 then
--|#line 1894 "eiffel.y"
	yy_do_action_436
when 437 then
--|#line 1898 "eiffel.y"
	yy_do_action_437
when 438 then
--|#line 1903 "eiffel.y"
	yy_do_action_438
when 439 then
--|#line 1914 "eiffel.y"
	yy_do_action_439
when 440 then
--|#line 1916 "eiffel.y"
	yy_do_action_440
when 441 then
--|#line 1918 "eiffel.y"
	yy_do_action_441
when 442 then
--|#line 1920 "eiffel.y"
	yy_do_action_442
when 443 then
--|#line 1922 "eiffel.y"
	yy_do_action_443
when 444 then
--|#line 1924 "eiffel.y"
	yy_do_action_444
when 445 then
--|#line 1926 "eiffel.y"
	yy_do_action_445
when 446 then
--|#line 1928 "eiffel.y"
	yy_do_action_446
when 447 then
--|#line 1930 "eiffel.y"
	yy_do_action_447
when 448 then
--|#line 1932 "eiffel.y"
	yy_do_action_448
when 449 then
--|#line 1934 "eiffel.y"
	yy_do_action_449
when 450 then
--|#line 1936 "eiffel.y"
	yy_do_action_450
when 451 then
--|#line 1940 "eiffel.y"
	yy_do_action_451
when 452 then
--|#line 1942 "eiffel.y"
	yy_do_action_452
when 453 then
--|#line 1944 "eiffel.y"
	yy_do_action_453
when 454 then
--|#line 1946 "eiffel.y"
	yy_do_action_454
when 455 then
--|#line 1948 "eiffel.y"
	yy_do_action_455
when 456 then
--|#line 1950 "eiffel.y"
	yy_do_action_456
when 457 then
--|#line 1954 "eiffel.y"
	yy_do_action_457
when 458 then
--|#line 1956 "eiffel.y"
	yy_do_action_458
when 459 then
--|#line 1958 "eiffel.y"
	yy_do_action_459
when 460 then
--|#line 1973 "eiffel.y"
	yy_do_action_460
when 461 then
--|#line 1975 "eiffel.y"
	yy_do_action_461
when 462 then
--|#line 1977 "eiffel.y"
	yy_do_action_462
when 463 then
--|#line 1981 "eiffel.y"
	yy_do_action_463
when 464 then
--|#line 1983 "eiffel.y"
	yy_do_action_464
when 465 then
--|#line 1987 "eiffel.y"
	yy_do_action_465
when 466 then
--|#line 1994 "eiffel.y"
	yy_do_action_466
when 467 then
--|#line 2009 "eiffel.y"
	yy_do_action_467
when 468 then
--|#line 2024 "eiffel.y"
	yy_do_action_468
when 469 then
--|#line 2042 "eiffel.y"
	yy_do_action_469
when 470 then
--|#line 2044 "eiffel.y"
	yy_do_action_470
when 471 then
--|#line 2046 "eiffel.y"
	yy_do_action_471
when 472 then
--|#line 2053 "eiffel.y"
	yy_do_action_472
when 473 then
--|#line 2057 "eiffel.y"
	yy_do_action_473
when 474 then
--|#line 2059 "eiffel.y"
	yy_do_action_474
when 475 then
--|#line 2061 "eiffel.y"
	yy_do_action_475
when 476 then
--|#line 2065 "eiffel.y"
	yy_do_action_476
when 477 then
--|#line 2067 "eiffel.y"
	yy_do_action_477
when 478 then
--|#line 2069 "eiffel.y"
	yy_do_action_478
when 479 then
--|#line 2071 "eiffel.y"
	yy_do_action_479
when 480 then
--|#line 2073 "eiffel.y"
	yy_do_action_480
when 481 then
--|#line 2075 "eiffel.y"
	yy_do_action_481
when 482 then
--|#line 2077 "eiffel.y"
	yy_do_action_482
when 483 then
--|#line 2079 "eiffel.y"
	yy_do_action_483
when 484 then
--|#line 2081 "eiffel.y"
	yy_do_action_484
when 485 then
--|#line 2083 "eiffel.y"
	yy_do_action_485
when 486 then
--|#line 2085 "eiffel.y"
	yy_do_action_486
when 487 then
--|#line 2087 "eiffel.y"
	yy_do_action_487
when 488 then
--|#line 2089 "eiffel.y"
	yy_do_action_488
when 489 then
--|#line 2091 "eiffel.y"
	yy_do_action_489
when 490 then
--|#line 2093 "eiffel.y"
	yy_do_action_490
when 491 then
--|#line 2095 "eiffel.y"
	yy_do_action_491
when 492 then
--|#line 2097 "eiffel.y"
	yy_do_action_492
when 493 then
--|#line 2099 "eiffel.y"
	yy_do_action_493
when 494 then
--|#line 2101 "eiffel.y"
	yy_do_action_494
when 495 then
--|#line 2103 "eiffel.y"
	yy_do_action_495
when 496 then
--|#line 2105 "eiffel.y"
	yy_do_action_496
when 497 then
--|#line 2109 "eiffel.y"
	yy_do_action_497
when 498 then
--|#line 2111 "eiffel.y"
	yy_do_action_498
when 499 then
--|#line 2113 "eiffel.y"
	yy_do_action_499
when 500 then
--|#line 2115 "eiffel.y"
	yy_do_action_500
when 501 then
--|#line 2119 "eiffel.y"
	yy_do_action_501
when 502 then
--|#line 2121 "eiffel.y"
	yy_do_action_502
when 503 then
--|#line 2123 "eiffel.y"
	yy_do_action_503
when 504 then
--|#line 2125 "eiffel.y"
	yy_do_action_504
when 505 then
--|#line 2127 "eiffel.y"
	yy_do_action_505
when 506 then
--|#line 2129 "eiffel.y"
	yy_do_action_506
when 507 then
--|#line 2131 "eiffel.y"
	yy_do_action_507
when 508 then
--|#line 2133 "eiffel.y"
	yy_do_action_508
when 509 then
--|#line 2135 "eiffel.y"
	yy_do_action_509
when 510 then
--|#line 2137 "eiffel.y"
	yy_do_action_510
when 511 then
--|#line 2139 "eiffel.y"
	yy_do_action_511
when 512 then
--|#line 2141 "eiffel.y"
	yy_do_action_512
when 513 then
--|#line 2143 "eiffel.y"
	yy_do_action_513
when 514 then
--|#line 2145 "eiffel.y"
	yy_do_action_514
when 515 then
--|#line 2147 "eiffel.y"
	yy_do_action_515
when 516 then
--|#line 2149 "eiffel.y"
	yy_do_action_516
when 517 then
--|#line 2151 "eiffel.y"
	yy_do_action_517
when 518 then
--|#line 2153 "eiffel.y"
	yy_do_action_518
when 519 then
--|#line 2157 "eiffel.y"
	yy_do_action_519
when 520 then
--|#line 2161 "eiffel.y"
	yy_do_action_520
when 521 then
--|#line 2165 "eiffel.y"
	yy_do_action_521
when 522 then
--|#line 2169 "eiffel.y"
	yy_do_action_522
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
				type_node := yytype58 (yyvs.item (yyvsp))
			

		end

	yy_do_action_3 is
			--|#line 195 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 195")
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
			--|#line 237 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 237")
end
			yyval := yyval_default;
				if inherit_context then
					inherit_context := False
					real_class_end_position := 0
				end
			

		end

	yy_do_action_5 is
			--|#line 246 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 246")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_6 is
			--|#line 248 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 248")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_7 is
			--|#line 250 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 250")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_8 is
			--|#line 252 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 252")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_9 is
			--|#line 254 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 254")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_10 is
			--|#line 256 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 256")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_11 is
			--|#line 258 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 258")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_12 is
			--|#line 260 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 260")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_13 is
			--|#line 262 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 262")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_14 is
			--|#line 264 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 264")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_15 is
			--|#line 266 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 266")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_16 is
			--|#line 268 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 268")
end

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_17 is
			--|#line 272 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 272")
end

yyval86 := new_clickable_id (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval86
		end

	yy_do_action_18 is
			--|#line 276 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 276")
end

yyval86 := new_clickable_id (new_boolean_id_as) 
			yyval := yyval86
		end

	yy_do_action_19 is
			--|#line 280 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 280")
end

yyval86 := new_clickable_id (new_character_id_as (False)) 
			yyval := yyval86
		end

	yy_do_action_20 is
			--|#line 284 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 284")
end

yyval86 := new_clickable_id (new_character_id_as (True)) 
			yyval := yyval86
		end

	yy_do_action_21 is
			--|#line 288 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 288")
end

yyval86 := new_clickable_id (new_double_id_as) 
			yyval := yyval86
		end

	yy_do_action_22 is
			--|#line 292 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 292")
end

yyval86 := new_clickable_id (new_integer_id_as (8)) 
			yyval := yyval86
		end

	yy_do_action_23 is
			--|#line 296 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 296")
end

yyval86 := new_clickable_id (new_integer_id_as (16)) 
			yyval := yyval86
		end

	yy_do_action_24 is
			--|#line 300 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 300")
end

yyval86 := new_clickable_id (new_integer_id_as (32)) 
			yyval := yyval86
		end

	yy_do_action_25 is
			--|#line 304 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 304")
end

yyval86 := new_clickable_id (new_integer_id_as (64)) 
			yyval := yyval86
		end

	yy_do_action_26 is
			--|#line 308 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 308")
end

yyval86 := new_clickable_id (new_none_id_as) 
			yyval := yyval86
		end

	yy_do_action_27 is
			--|#line 312 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 312")
end

yyval86 := new_clickable_id (new_pointer_id_as) 
			yyval := yyval86
		end

	yy_do_action_28 is
			--|#line 316 "eiffel.y"
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 316")
end

yyval86 := new_clickable_id (new_real_id_as) 
			yyval := yyval86
		end

	yy_do_action_29 is
			--|#line 323 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 323")
end


			yyval := yyval75
		end

	yy_do_action_30 is
			--|#line 325 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 325")
end

yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
		end

	yy_do_action_31 is
			--|#line 327 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 327")
end


			yyval := yyval75
		end

	yy_do_action_32 is
			--|#line 331 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 331")
end


			yyval := yyval75
		end

	yy_do_action_33 is
			--|#line 333 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 333")
end

yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
		end

	yy_do_action_34 is
			--|#line 335 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 335")
end

yyval75 := Void 
			yyval := yyval75
		end

	yy_do_action_35 is
			--|#line 339 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 339")
end


			yyval := yyval75
		end

	yy_do_action_36 is
			--|#line 341 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 341")
end

yyval75 := yytype75 (yyvs.item (yyvsp - 1)) 
			yyval := yyval75
		end

	yy_do_action_37 is
			--|#line 343 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 343")
end

yyval75 := Void 
			yyval := yyval75
		end

	yy_do_action_38 is
			--|#line 347 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 347")
end

				yyval75 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval75.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_39 is
			--|#line 352 "eiffel.y"
		local
			yyval75: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 352")
end

				yyval75 := yytype75 (yyvs.item (yyvsp - 1))
				yyval75.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_40 is
			--|#line 359 "eiffel.y"
		local
			yyval32: INDEX_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 359")
end

yyval32 := new_index_as (yytype30 (yyvs.item (yyvsp - 2)), yytype61 (yyvs.item (yyvsp - 1))) 
			yyval := yyval32
		end

	yy_do_action_41 is
			--|#line 363 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 363")
end

yyval30 := yytype30 (yyvs.item (yyvsp - 1)) 
			yyval := yyval30
		end

	yy_do_action_42 is
			--|#line 365 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 365")
end


			yyval := yyval30
		end

	yy_do_action_43 is
			--|#line 369 "eiffel.y"
		local
			yyval61: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 369")
end

				yyval61 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval61.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_44 is
			--|#line 374 "eiffel.y"
		local
			yyval61: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 374")
end

				yyval61 := yytype61 (yyvs.item (yyvsp - 2))
				yyval61.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_45 is
			--|#line 379 "eiffel.y"
		local
			yyval61: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 379")
end

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval61 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval61
		end

	yy_do_action_46 is
			--|#line 386 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 386")
end

yyval6 := yytype30 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_47 is
			--|#line 388 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 388")
end

yyval6 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_48 is
			--|#line 390 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 390")
end

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype18 (yyvs.item (yyvsp - 1)), Void)
			
			yyval := yyval6
		end

	yy_do_action_49 is
			--|#line 394 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 394")
end

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype18 (yyvs.item (yyvsp - 2)), yytype57 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval6
		end

	yy_do_action_50 is
			--|#line 404 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 404")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_51 is
			--|#line 410 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 410")
end
			yyval := yyval_default;
				is_frozen_class := False
				is_deferred := True
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_52 is
			--|#line 417 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 417")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := True
				is_separate := False
			

		end

	yy_do_action_53 is
			--|#line 423 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 423")
end
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := True
			

		end

	yy_do_action_54 is
			--|#line 431 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 431")
end
			yyval := yyval_default;
				is_frozen_class := False
			

		end

	yy_do_action_55 is
			--|#line 435 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 435")
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
			--|#line 446 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 446")
end
			yyval := yyval_default;
				is_external_class := False
			

		end

	yy_do_action_57 is
			--|#line 450 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 450")
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
			--|#line 465 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 465")
end


			yyval := yyval55
		end

	yy_do_action_59 is
			--|#line 467 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 467")
end

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_60 is
			--|#line 474 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 474")
end


			yyval := yyval68
		end

	yy_do_action_61 is
			--|#line 476 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 476")
end

				yyval68 := yytype68 (yyvs.item (yyvsp))
				if yyval68.is_empty then
					yyval68 := Void
				end
			
			yyval := yyval68
		end

	yy_do_action_62 is
			--|#line 485 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 485")
end

				yyval68 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval68, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_63 is
			--|#line 490 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 490")
end

				yyval68 := yytype68 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval68, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_64 is
			--|#line 497 "eiffel.y"
		local
			yyval27: FEATURE_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 497")
end

yyval27 := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) 
			yyval := yyval27
		end

	yy_do_action_65 is
			--|#line 499 "eiffel.y"
		local
			yyval27: FEATURE_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 499")
end

yyval27 := new_feature_clause_as (yytype14 (yyvs.item (yyvsp - 1)), yytype67 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval27
		end

	yy_do_action_66 is
			--|#line 503 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 503")
end

yyval14 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval14
		end

	yy_do_action_67 is
			--|#line 503 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 503")
end
			yyval := yyval_default;
				inherit_context := False
				fclause_pos := clone (current_position)
			

		end

	yy_do_action_68 is
			--|#line 512 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 512")
end


			yyval := yyval14
		end

	yy_do_action_69 is
			--|#line 514 "eiffel.y"
		local
			yyval14: CLIENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 514")
end

yyval14 := new_client_as (yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval14
		end

	yy_do_action_70 is
			--|#line 518 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 518")
end

				yyval72 := new_eiffel_list_id_as (1)
				yyval72.extend (new_none_id_as)
			
			yyval := yyval72
		end

	yy_do_action_71 is
			--|#line 523 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 523")
end

yyval72 := yytype72 (yyvs.item (yyvsp - 1)) 
			yyval := yyval72
		end

	yy_do_action_72 is
			--|#line 527 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 527")
end

				yyval72 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval72.extend (yytype86 (yyvs.item (yyvsp)).first)
				yytype86 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype86 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval72
		end

	yy_do_action_73 is
			--|#line 533 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 533")
end

				yyval72 := yytype72 (yyvs.item (yyvsp - 2))
				yyval72.extend (yytype86 (yyvs.item (yyvsp)).first)
				yytype86 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype86 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval72
		end

	yy_do_action_74 is
			--|#line 541 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [FEATURE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 541")
end

				yyval67 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval67.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_75 is
			--|#line 546 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [FEATURE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 546")
end

				yyval67 := yytype67 (yyvs.item (yyvsp - 1))
				yyval67.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_76 is
			--|#line 553 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 553")
end
			yyval := yyval_default;


		end

	yy_do_action_77 is
			--|#line 554 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 554")
end
			yyval := yyval_default;


		end

	yy_do_action_78 is
			--|#line 557 "eiffel.y"
		local
			yyval26: FEATURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 557")
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
			--|#line 570 "eiffel.y"
		local
			yyval89: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 570")
end

yyval89 := new_clickable_feature_name_list (yytype87 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval89
		end

	yy_do_action_80 is
			--|#line 572 "eiffel.y"
		local
			yyval89: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 572")
end

				yyval89 := yytype89 (yyvs.item (yyvsp - 2))
				yyval89.first.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval89
		end

	yy_do_action_81 is
			--|#line 579 "eiffel.y"
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 579")
end

yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
		end

	yy_do_action_82 is
			--|#line 583 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 583")
end
			yyval := yyval_default;
is_frozen := False 

		end

	yy_do_action_83 is
			--|#line 585 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 585")
end
			yyval := yyval_default;
is_frozen := True 

		end

	yy_do_action_84 is
			--|#line 589 "eiffel.y"
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 589")
end

yyval87 := new_clickable_feature_name (yytype86 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_85 is
			--|#line 591 "eiffel.y"
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 591")
end

yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
		end

	yy_do_action_86 is
			--|#line 593 "eiffel.y"
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 593")
end

yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
		end

	yy_do_action_87 is
			--|#line 597 "eiffel.y"
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 597")
end

yyval87 := new_clickable_infix (yytype88 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_88 is
			--|#line 602 "eiffel.y"
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 602")
end

yyval87 := new_clickable_prefix (yytype88 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_89 is
			--|#line 606 "eiffel.y"
		local
			yyval8: BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 606")
end

yyval8 := new_declaration_body (yytype84 (yyvs.item (yyvsp - 2)), yytype58 (yyvs.item (yyvsp - 1)), yytype15 (yyvs.item (yyvsp))) 
			yyval := yyval8
		end

	yy_do_action_90 is
			--|#line 610 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 610")
end

feature_indexes := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_91 is
			--|#line 612 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 612")
end

yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_92 is
			--|#line 616 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 616")
end

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (yytype6 (yyvs.item (yyvsp - 1))))
				feature_indexes := yytype75 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_93 is
			--|#line 621 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 621")
end

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (new_unique_as))
				feature_indexes := yytype75 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_94 is
			--|#line 626 "eiffel.y"
		local
			yyval15: CONTENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 626")
end

				yyval15 := yytype53 (yyvs.item (yyvsp))
				feature_indexes := yytype75 (yyvs.item (yyvsp - 1))
			
			yyval := yyval15
		end

	yy_do_action_95 is
			--|#line 637 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 637")
end


			yyval := yyval79
		end

	yy_do_action_96 is
			--|#line 639 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 639")
end

yyval79 := yytype79 (yyvs.item (yyvsp)) 
			yyval := yyval79
		end

	yy_do_action_97 is
			--|#line 641 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 641")
end

yyval79 := new_eiffel_list_parent_as (0) 
			yyval := yyval79
		end

	yy_do_action_98 is
			--|#line 645 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 645")
end

				yyval79 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval79.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_99 is
			--|#line 650 "eiffel.y"
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 650")
end

				yyval79 := yytype79 (yyvs.item (yyvsp - 1))
				yyval79.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_100 is
			--|#line 657 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 657")
end

				yyval44 := yytype44 (yyvs.item (yyvsp))
				yytype44 (yyvs.item (yyvsp)).set_location (yytype91 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_101 is
			--|#line 662 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 662")
end

				inherit_context := False
				yyval44 := yytype44 (yyvs.item (yyvsp - 1))
				yytype44 (yyvs.item (yyvsp - 1)).set_location (yytype91 (yyvs.item (yyvsp - 2)))
			
			yyval := yyval44
		end

	yy_do_action_102 is
			--|#line 670 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 670")
end

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_103 is
			--|#line 675 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 675")
end

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 7)), yytype83 (yyvs.item (yyvsp - 6)), yytype80 (yyvs.item (yyvsp - 5)), yytype65 (yyvs.item (yyvsp - 4)), yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_104 is
			--|#line 680 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 680")
end

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 6)), yytype83 (yyvs.item (yyvsp - 5)), Void, yytype65 (yyvs.item (yyvsp - 4)), yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_105 is
			--|#line 685 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 685")
end

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 5)), yytype83 (yyvs.item (yyvsp - 4)), Void, Void, yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_106 is
			--|#line 690 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 690")
end

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 4)), yytype83 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_107 is
			--|#line 695 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 695")
end

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 3)), yytype83 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_108 is
			--|#line 700 "eiffel.y"
		local
			yyval44: PARENT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 700")
end

				inherit_context := True
				real_class_end_position := current_position.end_position - 3
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 2)), yytype83 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_109 is
			--|#line 708 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 708")
end


			yyval := yyval80
		end

	yy_do_action_110 is
			--|#line 710 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 710")
end

yyval80 := yytype80 (yyvs.item (yyvsp)) 
			yyval := yyval80
		end

	yy_do_action_111 is
			--|#line 714 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 714")
end

				yyval80 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval80.extend (yytype48 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_112 is
			--|#line 719 "eiffel.y"
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 719")
end

				yyval80 := yytype80 (yyvs.item (yyvsp - 2))
				yyval80.extend (yytype48 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_113 is
			--|#line 726 "eiffel.y"
		local
			yyval48: RENAME_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 726")
end

yyval48 := new_rename_pair (yytype87 (yyvs.item (yyvsp - 2)), yytype87 (yyvs.item (yyvsp))) 
			yyval := yyval48
		end

	yy_do_action_114 is
			--|#line 730 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 730")
end


			yyval := yyval65
		end

	yy_do_action_115 is
			--|#line 732 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 732")
end

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_116 is
			--|#line 736 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 736")
end

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_117 is
			--|#line 738 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 738")
end


			yyval := yyval65
		end

	yy_do_action_118 is
			--|#line 742 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 742")
end

				yyval65 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				yyval65.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_119 is
			--|#line 747 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 747")
end

				yyval65 := yytype65 (yyvs.item (yyvsp - 1))
				yyval65.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_120 is
			--|#line 754 "eiffel.y"
		local
			yyval22: EXPORT_ITEM_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 754")
end

yyval22 := new_export_item_as (new_client_as (yytype72 (yyvs.item (yyvsp - 2))), yytype28 (yyvs.item (yyvsp - 1))) 
			yyval := yyval22
		end

	yy_do_action_121 is
			--|#line 758 "eiffel.y"
		local
			yyval28: FEATURE_SET_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 758")
end

yyval28 := new_all_as 
			yyval := yyval28
		end

	yy_do_action_122 is
			--|#line 760 "eiffel.y"
		local
			yyval28: FEATURE_SET_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 760")
end

yyval28 := new_feature_list_as (yytype70 (yyvs.item (yyvsp))) 
			yyval := yyval28
		end

	yy_do_action_123 is
			--|#line 764 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 764")
end

				yyval70 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval70.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval70
		end

	yy_do_action_124 is
			--|#line 769 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 769")
end

				yyval70 := yytype70 (yyvs.item (yyvsp - 2))
				yyval70.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval70
		end

	yy_do_action_125 is
			--|#line 776 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 776")
end


			yyval := yyval70
		end

	yy_do_action_126 is
			--|#line 778 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 778")
end

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_127 is
			--|#line 782 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 782")
end


			yyval := yyval70
		end

	yy_do_action_128 is
			--|#line 784 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 784")
end

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_129 is
			--|#line 788 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 788")
end


			yyval := yyval70
		end

	yy_do_action_130 is
			--|#line 790 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 790")
end

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_131 is
			--|#line 794 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 794")
end


			yyval := yyval70
		end

	yy_do_action_132 is
			--|#line 796 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 796")
end

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_133 is
			--|#line 800 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 800")
end


			yyval := yyval70
		end

	yy_do_action_134 is
			--|#line 802 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 802")
end

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_135 is
			--|#line 806 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 806")
end


			yyval := yyval70
		end

	yy_do_action_136 is
			--|#line 808 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 808")
end

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_137 is
			--|#line 816 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 816")
end


			yyval := yyval84
		end

	yy_do_action_138 is
			--|#line 818 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 818")
end

yyval84 := yytype84 (yyvs.item (yyvsp - 1)) 
			yyval := yyval84
		end

	yy_do_action_139 is
			--|#line 822 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 822")
end


			yyval := yyval84
		end

	yy_do_action_140 is
			--|#line 824 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 824")
end

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_141 is
			--|#line 828 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 828")
end

				yyval84 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_142 is
			--|#line 833 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 833")
end

				yyval84 := yytype84 (yyvs.item (yyvsp - 1))
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_143 is
			--|#line 840 "eiffel.y"
		local
			yyval59: TYPE_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 840")
end

yyval59 := new_type_dec_as (yytype74 (yyvs.item (yyvsp - 4)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval59
		end

	yy_do_action_144 is
			--|#line 844 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 844")
end
			yyval := yyval_default;


		end

	yy_do_action_145 is
			--|#line 845 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 845")
end
			yyval := yyval_default;
				if il_parser then
						-- Trigger a syntax error.
					raise_error
				end
			

		end

	yy_do_action_146 is
			--|#line 854 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 854")
end


			yyval := yyval84
		end

	yy_do_action_147 is
			--|#line 856 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 856")
end

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_148 is
			--|#line 860 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 860")
end

				yyval84 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_149 is
			--|#line 865 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 865")
end

				yyval84 := yytype84 (yyvs.item (yyvsp - 1))
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_150 is
			--|#line 872 "eiffel.y"
		local
			yyval59: TYPE_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 872")
end

yyval59 := new_type_dec_as (yytype74 (yyvs.item (yyvsp - 3)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval59
		end

	yy_do_action_151 is
			--|#line 876 "eiffel.y"
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 876")
end

				create yyval74.make (Initial_identifier_list_size)
				Names_heap.put (yytype30 (yyvs.item (yyvsp)))
				yyval74.extend (Names_heap.found_item)
			
			yyval := yyval74
		end

	yy_do_action_152 is
			--|#line 882 "eiffel.y"
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 882")
end

				yyval74 := yytype74 (yyvs.item (yyvsp - 2))
				Names_heap.put (yytype30 (yyvs.item (yyvsp)))
				yyval74.extend (Names_heap.found_item)
			
			yyval := yyval74
		end

	yy_do_action_153 is
			--|#line 890 "eiffel.y"
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 890")
end

create yyval74.make (0) 
			yyval := yyval74
		end

	yy_do_action_154 is
			--|#line 892 "eiffel.y"
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 892")
end

yyval74 := yytype74 (yyvs.item (yyvsp)) 
			yyval := yyval74
		end

	yy_do_action_155 is
			--|#line 896 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 896")
end


			yyval := yyval58
		end

	yy_do_action_156 is
			--|#line 898 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 898")
end

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_157 is
			--|#line 902 "eiffel.y"
		local
			yyval53: ROUTINE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 902")
end

yyval53 := new_routine_as (yytype55 (yyvs.item (yyvsp - 7)), yytype49 (yyvs.item (yyvsp - 5)), yytype84 (yyvs.item (yyvsp - 4)), yytype52 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), fbody_pos, current_position) 
			yyval := yyval53
		end

	yy_do_action_158 is
			--|#line 902 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 902")
end
			yyval := yyval_default;
fbody_pos := current_position.start_position 

		end

	yy_do_action_159 is
			--|#line 914 "eiffel.y"
		local
			yyval52: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 914")
end

yyval52 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval52
		end

	yy_do_action_160 is
			--|#line 916 "eiffel.y"
		local
			yyval52: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 916")
end

yyval52 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval52
		end

	yy_do_action_161 is
			--|#line 918 "eiffel.y"
		local
			yyval52: ROUT_BODY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 918")
end

yyval52 := new_deferred_as 
			yyval := yyval52
		end

	yy_do_action_162 is
			--|#line 922 "eiffel.y"
		local
			yyval24: EXTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 922")
end

yyval24 := new_external_as (yytype25 (yyvs.item (yyvsp - 1)), yytype55 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_163 is
			--|#line 926 "eiffel.y"
		local
			yyval25: EXTERNAL_LANG_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 926")
end

yyval25 := new_external_lang_as (yytype55 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
		end

	yy_do_action_164 is
			--|#line 931 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 931")
end


			yyval := yyval55
		end

	yy_do_action_165 is
			--|#line 933 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 933")
end

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_166 is
			--|#line 937 "eiffel.y"
		local
			yyval37: INTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 937")
end

yyval37 := new_do_as (yytype76 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_167 is
			--|#line 939 "eiffel.y"
		local
			yyval37: INTERNAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 939")
end

yyval37 := new_once_as (yytype76 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_168 is
			--|#line 943 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 943")
end


			yyval := yyval84
		end

	yy_do_action_169 is
			--|#line 945 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 945")
end

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_170 is
			--|#line 949 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 949")
end


			yyval := yyval76
		end

	yy_do_action_171 is
			--|#line 951 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 951")
end

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_172 is
			--|#line 955 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 955")
end

				yyval76 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval76.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_173 is
			--|#line 960 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 960")
end

				yyval76 := yytype76 (yyvs.item (yyvsp - 1))
				yyval76.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_174 is
			--|#line 967 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 967")
end

yyval35 := yytype35 (yyvs.item (yyvsp - 1)) 
			yyval := yyval35
		end

	yy_do_action_175 is
			--|#line 971 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 971")
end
			yyval := yyval_default;


		end

	yy_do_action_176 is
			--|#line 972 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 972")
end
			yyval := yyval_default;


		end

	yy_do_action_177 is
			--|#line 975 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 975")
end

yyval35 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_178 is
			--|#line 977 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 977")
end

yyval35 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_179 is
			--|#line 979 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 979")
end

yyval35 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_180 is
			--|#line 981 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 981")
end

yyval35 := yytype51 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_181 is
			--|#line 983 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 983")
end

yyval35 := yytype31 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_182 is
			--|#line 985 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 985")
end

yyval35 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_183 is
			--|#line 987 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 987")
end

yyval35 := yytype40 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_184 is
			--|#line 989 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 989")
end

yyval35 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_185 is
			--|#line 991 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 991")
end

yyval35 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_186 is
			--|#line 993 "eiffel.y"
		local
			yyval35: INSTRUCTION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 993")
end

yyval35 := yytype50 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_187 is
			--|#line 997 "eiffel.y"
		local
			yyval49: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 997")
end


			yyval := yyval49
		end

	yy_do_action_188 is
			--|#line 999 "eiffel.y"
		local
			yyval49: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 999")
end

				id_level := Normal_level
				yyval49 := new_require_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval49
		end

	yy_do_action_189 is
			--|#line 999 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 999")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_190 is
			--|#line 1006 "eiffel.y"
		local
			yyval49: REQUIRE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1006")
end

				id_level := Normal_level
				yyval49 := new_require_else_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval49
		end

	yy_do_action_191 is
			--|#line 1006 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1006")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_192 is
			--|#line 1015 "eiffel.y"
		local
			yyval21: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1015")
end


			yyval := yyval21
		end

	yy_do_action_193 is
			--|#line 1017 "eiffel.y"
		local
			yyval21: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1017")
end

				id_level := Normal_level
				yyval21 := new_ensure_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_194 is
			--|#line 1017 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1017")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_195 is
			--|#line 1024 "eiffel.y"
		local
			yyval21: ENSURE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1024")
end

				id_level := Normal_level
				yyval21 := new_ensure_then_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_196 is
			--|#line 1024 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1024")
end
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_197 is
			--|#line 1033 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1033")
end


			yyval := yyval82
		end

	yy_do_action_198 is
			--|#line 1035 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1035")
end

				yyval82 := yytype82 (yyvs.item (yyvsp))
				if yyval82.is_empty then
					yyval82 := Void
				end
			
			yyval := yyval82
		end

	yy_do_action_199 is
			--|#line 1044 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1044")
end

				yyval82 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval82, yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_200 is
			--|#line 1049 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1049")
end

				yyval82 := yytype82 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval82, yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_201 is
			--|#line 1056 "eiffel.y"
		local
			yyval56: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1056")
end

yyval56 := yytype56 (yyvs.item (yyvsp - 1)) 
			yyval := yyval56
		end

	yy_do_action_202 is
			--|#line 1060 "eiffel.y"
		local
			yyval56: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1060")
end

yyval56 := new_tagged_as (Void, yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval56
		end

	yy_do_action_203 is
			--|#line 1062 "eiffel.y"
		local
			yyval56: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1062")
end

yyval56 := new_tagged_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval56
		end

	yy_do_action_204 is
			--|#line 1064 "eiffel.y"
		local
			yyval56: TAGGED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1064")
end


			yyval := yyval56
		end

	yy_do_action_205 is
			--|#line 1072 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1072")
end

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_206 is
			--|#line 1074 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1074")
end

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_207 is
			--|#line 1078 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1078")
end

yyval58 := new_expanded_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_208 is
			--|#line 1080 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1080")
end

yyval58 := new_separate_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_209 is
			--|#line 1082 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1082")
end

yyval58 := new_bits_as (yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_210 is
			--|#line 1084 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1084")
end

yyval58 := new_bits_symbol_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_211 is
			--|#line 1086 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1086")
end

yyval58 := new_like_id_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_212 is
			--|#line 1088 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1088")
end

yyval58 := new_like_current_as 
			yyval := yyval58
		end

	yy_do_action_213 is
			--|#line 1092 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1092")
end

yyval58 := new_class_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_214 is
			--|#line 1094 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1094")
end

yyval58 := new_boolean_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_215 is
			--|#line 1096 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1096")
end

yyval58 := new_character_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, False) 
			yyval := yyval58
		end

	yy_do_action_216 is
			--|#line 1098 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1098")
end

yyval58 := new_character_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, True) 
			yyval := yyval58
		end

	yy_do_action_217 is
			--|#line 1100 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1100")
end

yyval58 := new_double_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_218 is
			--|#line 1102 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1102")
end

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 8) 
			yyval := yyval58
		end

	yy_do_action_219 is
			--|#line 1104 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1104")
end

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 16) 
			yyval := yyval58
		end

	yy_do_action_220 is
			--|#line 1106 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1106")
end

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 32) 
			yyval := yyval58
		end

	yy_do_action_221 is
			--|#line 1108 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1108")
end

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 64) 
			yyval := yyval58
		end

	yy_do_action_222 is
			--|#line 1110 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1110")
end

yyval58 := new_none_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_223 is
			--|#line 1112 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1112")
end

yyval58 := new_pointer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_224 is
			--|#line 1114 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1114")
end

yyval58 := new_real_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_225 is
			--|#line 1118 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1118")
end


			yyval := yyval83
		end

	yy_do_action_226 is
			--|#line 1120 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1120")
end


			yyval := yyval83
		end

	yy_do_action_227 is
			--|#line 1122 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1122")
end

yyval83 := yytype83 (yyvs.item (yyvsp - 1)) 
			yyval := yyval83
		end

	yy_do_action_228 is
			--|#line 1126 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1126")
end

				yyval83 := new_eiffel_list_type (Initial_type_list_size)
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_229 is
			--|#line 1131 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [TYPE]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1131")
end

				yyval83 := yytype83 (yyvs.item (yyvsp - 2))
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_230 is
			--|#line 1142 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1142")
end

				-- $$ := Void
				formal_generics_start_position := current_position.start_position
				formal_generics_end_position := 0
			
			yyval := yyval71
		end

	yy_do_action_231 is
			--|#line 1148 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1148")
end

				yyval71 := yytype71 (yyvs.item (yyvsp - 1))
				formal_generics_start_position := yytype91 (yyvs.item (yyvsp - 3)).start_position
				formal_generics_end_position := current_position.start_position
			
			yyval := yyval71
		end

	yy_do_action_232 is
			--|#line 1156 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1156")
end


			yyval := yyval71
		end

	yy_do_action_233 is
			--|#line 1158 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1158")
end

yyval71 := yytype71 (yyvs.item (yyvsp)) 
			yyval := yyval71
		end

	yy_do_action_234 is
			--|#line 1162 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1162")
end

				yyval71 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval71.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_235 is
			--|#line 1167 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1167")
end

				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_236 is
			--|#line 1174 "eiffel.y"
		local
			yyval29: FORMAL_DEC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1174")
end

				check formal_exists: not formal_parameters.is_empty end
				yyval29 := new_formal_dec_as (formal_parameters.last, yytype90 (yyvs.item (yyvsp)).first, yytype90 (yyvs.item (yyvsp)).second, formal_parameters.count)
			
			yyval := yyval29
		end

	yy_do_action_237 is
			--|#line 1174 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1174")
end
			yyval := yyval_default;
formal_parameters.extend (create {ID_AS}.initialize (token_buffer)) 

		end

	yy_do_action_238 is
			--|#line 1184 "eiffel.y"
		local
			yyval90: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1184")
end

create yyval90 
			yyval := yyval90
		end

	yy_do_action_239 is
			--|#line 1186 "eiffel.y"
		local
			yyval90: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1186")
end

				create yyval90
				yyval90.set_first (yytype58 (yyvs.item (yyvsp - 1)))
				yyval90.set_second (yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval90
		end

	yy_do_action_240 is
			--|#line 1194 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1194")
end


			yyval := yyval70
		end

	yy_do_action_241 is
			--|#line 1196 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1196")
end

yyval70 := yytype70 (yyvs.item (yyvsp - 1)) 
			yyval := yyval70
		end

	yy_do_action_242 is
			--|#line 1204 "eiffel.y"
		local
			yyval31: IF_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1204")
end

				yyval31 := new_if_as (yytype23 (yyvs.item (yyvsp - 5)), yytype76 (yyvs.item (yyvsp - 3)), yytype64 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 7)), current_position)
			
			yyval := yyval31
		end

	yy_do_action_243 is
			--|#line 1210 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1210")
end


			yyval := yyval64
		end

	yy_do_action_244 is
			--|#line 1212 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1212")
end

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_245 is
			--|#line 1216 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1216")
end

				yyval64 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval64.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_246 is
			--|#line 1221 "eiffel.y"
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1221")
end

				yyval64 := yytype64 (yyvs.item (yyvsp - 1))
				yyval64.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_247 is
			--|#line 1228 "eiffel.y"
		local
			yyval20: ELSIF_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1228")
end

yyval20 := new_elseif_as (yytype23 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 4))) 
			yyval := yyval20
		end

	yy_do_action_248 is
			--|#line 1232 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1232")
end


			yyval := yyval76
		end

	yy_do_action_249 is
			--|#line 1234 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1234")
end

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_250 is
			--|#line 1238 "eiffel.y"
		local
			yyval33: INSPECT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1238")
end

				yyval33 := new_inspect_as (yytype23 (yyvs.item (yyvsp - 3)), yytype62 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval33
		end

	yy_do_action_251 is
			--|#line 1244 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1244")
end


			yyval := yyval62
		end

	yy_do_action_252 is
			--|#line 1246 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1246")
end

yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
		end

	yy_do_action_253 is
			--|#line 1250 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1250")
end

				yyval62 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval62.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_254 is
			--|#line 1255 "eiffel.y"
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1255")
end

				yyval62 := yytype62 (yyvs.item (yyvsp - 1))
				yyval62.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_255 is
			--|#line 1262 "eiffel.y"
		local
			yyval11: CASE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1262")
end

yyval11 := new_case_as (yytype77 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval11
		end

	yy_do_action_256 is
			--|#line 1266 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [INTERVAL_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1266")
end

				yyval77 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval77.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_257 is
			--|#line 1271 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [INTERVAL_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1271")
end

				yyval77 := yytype77 (yyvs.item (yyvsp - 2))
				yyval77.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_258 is
			--|#line 1278 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1278")
end

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_259 is
			--|#line 1280 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1280")
end

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_260 is
			--|#line 1282 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1282")
end

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_261 is
			--|#line 1284 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1284")
end

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_262 is
			--|#line 1286 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1286")
end

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_263 is
			--|#line 1288 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1288")
end

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_264 is
			--|#line 1290 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1290")
end

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_265 is
			--|#line 1292 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1292")
end

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_266 is
			--|#line 1294 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1294")
end

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_267 is
			--|#line 1296 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1296")
end

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_268 is
			--|#line 1298 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1298")
end

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_269 is
			--|#line 1300 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1300")
end

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_270 is
			--|#line 1302 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1302")
end

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_271 is
			--|#line 1304 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1304")
end

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_272 is
			--|#line 1306 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1306")
end

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_273 is
			--|#line 1308 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1308")
end

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_274 is
			--|#line 1310 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1310")
end

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_275 is
			--|#line 1312 "eiffel.y"
		local
			yyval38: INTERVAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1312")
end

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_276 is
			--|#line 1317 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1317")
end


			yyval := yyval76
		end

	yy_do_action_277 is
			--|#line 1319 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1319")
end

				yyval76 := yytype76 (yyvs.item (yyvsp))
				if yyval76 = Void then
					yyval76 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval76
		end

	yy_do_action_278 is
			--|#line 1328 "eiffel.y"
		local
			yyval40: LOOP_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1328")
end

				yyval40 := new_loop_as (yytype76 (yyvs.item (yyvsp - 8)), yytype82 (yyvs.item (yyvsp - 7)), yytype60 (yyvs.item (yyvsp - 6)), yytype23 (yyvs.item (yyvsp - 3)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval40
		end

	yy_do_action_279 is
			--|#line 1334 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1334")
end


			yyval := yyval82
		end

	yy_do_action_280 is
			--|#line 1336 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1336")
end

yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
		end

	yy_do_action_281 is
			--|#line 1340 "eiffel.y"
		local
			yyval39: INVARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1340")
end


			yyval := yyval39
		end

	yy_do_action_282 is
			--|#line 1342 "eiffel.y"
		local
			yyval39: INVARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1342")
end

				id_level := Normal_level
				inherit_context := False
				yyval39 := new_invariant_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval39
		end

	yy_do_action_283 is
			--|#line 1342 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1342")
end
			yyval := yyval_default;
id_level := Invariant_level 

		end

	yy_do_action_284 is
			--|#line 1352 "eiffel.y"
		local
			yyval60: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1352")
end


			yyval := yyval60
		end

	yy_do_action_285 is
			--|#line 1354 "eiffel.y"
		local
			yyval60: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1354")
end

yyval60 := new_variant_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval60
		end

	yy_do_action_286 is
			--|#line 1356 "eiffel.y"
		local
			yyval60: VARIANT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1356")
end

yyval60 := new_variant_as (Void, yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval60
		end

	yy_do_action_287 is
			--|#line 1360 "eiffel.y"
		local
			yyval19: DEBUG_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1360")
end

				yyval19 := new_debug_as (yytype81 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval19
		end

	yy_do_action_288 is
			--|#line 1366 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1366")
end


			yyval := yyval81
		end

	yy_do_action_289 is
			--|#line 1368 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1368")
end


			yyval := yyval81
		end

	yy_do_action_290 is
			--|#line 1370 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1370")
end

yyval81 := yytype81 (yyvs.item (yyvsp - 1)) 
			yyval := yyval81
		end

	yy_do_action_291 is
			--|#line 1374 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1374")
end

				yyval81 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval81.extend (yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_292 is
			--|#line 1379 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1379")
end

				yyval81 := yytype81 (yyvs.item (yyvsp - 2))
				yyval81.extend (yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_293 is
			--|#line 1386 "eiffel.y"
		local
			yyval50: RETRY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1386")
end

yyval50 := new_retry_as (current_position) 
			yyval := yyval50
		end

	yy_do_action_294 is
			--|#line 1390 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1390")
end


			yyval := yyval76
		end

	yy_do_action_295 is
			--|#line 1392 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1392")
end

				yyval76 := yytype76 (yyvs.item (yyvsp))
				if yyval76 = Void then
					yyval76 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval76
		end

	yy_do_action_296 is
			--|#line 1401 "eiffel.y"
		local
			yyval5: ASSIGN_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1401")
end

yyval5 := new_assign_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_297 is
			--|#line 1403 "eiffel.y"
		local
			yyval5: ASSIGN_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1403")
end

yyval5 := new_assign_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_298 is
			--|#line 1407 "eiffel.y"
		local
			yyval51: REVERSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1407")
end

yyval51 := new_reverse_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval51
		end

	yy_do_action_299 is
			--|#line 1409 "eiffel.y"
		local
			yyval51: REVERSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1409")
end

yyval51 := new_reverse_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval51
		end

	yy_do_action_300 is
			--|#line 1413 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1413")
end


			yyval := yyval63
		end

	yy_do_action_301 is
			--|#line 1415 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1415")
end

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_302 is
			--|#line 1419 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1419")
end

				yyval63 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval63.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_303 is
			--|#line 1424 "eiffel.y"
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1424")
end

				yyval63 := yytype63 (yyvs.item (yyvsp - 1))
				yyval63.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_304 is
			--|#line 1431 "eiffel.y"
		local
			yyval16: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1431")
end

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_305 is
			--|#line 1437 "eiffel.y"
		local
			yyval16: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1437")
end

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_306 is
			--|#line 1442 "eiffel.y"
		local
			yyval16: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1442")
end

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype72 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_307 is
			--|#line 1447 "eiffel.y"
		local
			yyval16: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1447")
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
			--|#line 1457 "eiffel.y"
		local
			yyval16: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1457")
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
			--|#line 1467 "eiffel.y"
		local
			yyval16: CREATE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1467")
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
			--|#line 1479 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1479")
end

yyval54 := new_routine_creation_as (new_result_operand_as, yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_311 is
			--|#line 1482 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1482")
end

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_312 is
			--|#line 1484 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1484")
end

yyval54 := new_routine_creation_as (new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 3)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_313 is
			--|#line 1486 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1486")
end

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 4))), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_314 is
			--|#line 1488 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1488")
end

yyval54 := new_routine_creation_as (new_operand_as (yytype58 (yyvs.item (yyvsp - 4)), Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_315 is
			--|#line 1490 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1490")
end

yyval54 := new_routine_creation_as (Void, yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_316 is
			--|#line 1492 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1492")
end

yyval54 := new_unqualified_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_317 is
			--|#line 1494 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1494")
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
			--|#line 1503 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1503")
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
			--|#line 1512 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1512")
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
			--|#line 1522 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1522")
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
			--|#line 1531 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1531")
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
			--|#line 1540 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1540")
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
			--|#line 1549 "eiffel.y"
		local
			yyval54: ROUTINE_CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1549")
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
			--|#line 1560 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1560")
end


			yyval := yyval78
		end

	yy_do_action_325 is
			--|#line 1562 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1562")
end

yyval78 := yytype78 (yyvs.item (yyvsp - 1)) 
			yyval := yyval78
		end

	yy_do_action_326 is
			--|#line 1566 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1566")
end

				yyval78 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval78.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_327 is
			--|#line 1571 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1571")
end

				yyval78 := yytype78 (yyvs.item (yyvsp - 2))
				yyval78.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_328 is
			--|#line 1578 "eiffel.y"
		local
			yyval43: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1578")
end

yyval43 := new_operand_as (Void, Void, Void) 
			yyval := yyval43
		end

	yy_do_action_329 is
			--|#line 1580 "eiffel.y"
		local
			yyval43: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1580")
end

yyval43 := new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval43
		end

	yy_do_action_330 is
			--|#line 1582 "eiffel.y"
		local
			yyval43: OPERAND_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1582")
end

yyval43 := new_operand_as (yytype58 (yyvs.item (yyvsp - 1)), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_331 is
			--|#line 1586 "eiffel.y"
		local
			yyval17: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1586")
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
			--|#line 1595 "eiffel.y"
		local
			yyval17: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1595")
end

yyval17 := new_creation_as (Void, yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval17
		end

	yy_do_action_333 is
			--|#line 1597 "eiffel.y"
		local
			yyval17: CREATION_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1597")
end

yyval17 := new_creation_as (yytype58 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 6))) 
			yyval := yyval17
		end

	yy_do_action_334 is
			--|#line 1601 "eiffel.y"
		local
			yyval18: CREATION_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1601")
end

yyval18 := new_creation_expr_as (yytype58 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval18
		end

	yy_do_action_335 is
			--|#line 1603 "eiffel.y"
		local
			yyval18: CREATION_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1603")
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
			--|#line 1614 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1614")
end


			yyval := yyval58
		end

	yy_do_action_337 is
			--|#line 1616 "eiffel.y"
		local
			yyval58: TYPE
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1616")
end

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_338 is
			--|#line 1620 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1620")
end

yyval1 := new_access_id_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval1
		end

	yy_do_action_339 is
			--|#line 1622 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1622")
end

yyval1 := new_result_as 
			yyval := yyval1
		end

	yy_do_action_340 is
			--|#line 1626 "eiffel.y"
		local
			yyval3: ACCESS_INV_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1626")
end


			yyval := yyval3
		end

	yy_do_action_341 is
			--|#line 1628 "eiffel.y"
		local
			yyval3: ACCESS_INV_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1628")
end

yyval3 := new_access_inv_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_342 is
			--|#line 1636 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1636")
end

yyval34 := new_instr_call_as (yytype1 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_343 is
			--|#line 1638 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1638")
end

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_344 is
			--|#line 1640 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1640")
end

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_345 is
			--|#line 1642 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1642")
end

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_346 is
			--|#line 1644 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1644")
end

yyval34 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_347 is
			--|#line 1646 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1646")
end

yyval34 := new_instr_call_as (yytype45 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_348 is
			--|#line 1648 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1648")
end

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_349 is
			--|#line 1650 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1650")
end

yyval34 := new_instr_call_as (yytype46 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_350 is
			--|#line 1652 "eiffel.y"
		local
			yyval34: INSTR_CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1652")
end

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_351 is
			--|#line 1656 "eiffel.y"
		local
			yyval13: CHECK_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1656")
end

yyval13 := new_check_as (yytype82 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 3)), current_position) 
			yyval := yyval13
		end

	yy_do_action_352 is
			--|#line 1664 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1664")
end

create {VALUE_AS} yyval23.initialize (yytype6 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_353 is
			--|#line 1666 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1666")
end

create {VALUE_AS} yyval23.initialize (yytype4 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_354 is
			--|#line 1668 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1668")
end

create {VALUE_AS} yyval23.initialize (yytype57 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_355 is
			--|#line 1670 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1670")
end

yyval23 := new_expr_call_as (yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_356 is
			--|#line 1672 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1672")
end

yyval23 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_357 is
			--|#line 1674 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1674")
end

yyval23 := new_paran_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_358 is
			--|#line 1676 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1676")
end

yyval23 := new_bin_plus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_359 is
			--|#line 1678 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1678")
end

yyval23 := new_bin_minus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_360 is
			--|#line 1680 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1680")
end

yyval23 := new_bin_star_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_361 is
			--|#line 1682 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1682")
end

yyval23 := new_bin_slash_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_362 is
			--|#line 1684 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1684")
end

yyval23 := new_bin_mod_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_363 is
			--|#line 1686 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1686")
end

yyval23 := new_bin_div_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_364 is
			--|#line 1688 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1688")
end

yyval23 := new_bin_power_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_365 is
			--|#line 1690 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1690")
end

yyval23 := new_bin_and_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_366 is
			--|#line 1692 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1692")
end

yyval23 := new_bin_and_then_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_367 is
			--|#line 1694 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1694")
end

yyval23 := new_bin_or_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_368 is
			--|#line 1696 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1696")
end

yyval23 := new_bin_or_else_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_369 is
			--|#line 1698 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1698")
end

yyval23 := new_bin_implies_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_370 is
			--|#line 1700 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1700")
end

yyval23 := new_bin_xor_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_371 is
			--|#line 1702 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1702")
end

yyval23 := new_bin_ge_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_372 is
			--|#line 1704 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1704")
end

yyval23 := new_bin_gt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_373 is
			--|#line 1706 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1706")
end

yyval23 := new_bin_le_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_374 is
			--|#line 1708 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1708")
end

yyval23 := new_bin_lt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_375 is
			--|#line 1710 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1710")
end

yyval23 := new_bin_eq_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_376 is
			--|#line 1712 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1712")
end

yyval23 := new_bin_ne_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_377 is
			--|#line 1714 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1714")
end

yyval23 := new_bin_free_as (yytype23 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_378 is
			--|#line 1716 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1716")
end

yyval23 := new_un_minus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_379 is
			--|#line 1718 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1718")
end

yyval23 := new_un_plus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_380 is
			--|#line 1720 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1720")
end

yyval23 := new_un_not_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_381 is
			--|#line 1722 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1722")
end

yyval23 := new_un_old_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_382 is
			--|#line 1724 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1724")
end

yyval23 := new_un_free_as (yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_383 is
			--|#line 1726 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1726")
end

yyval23 := new_un_strip_as (yytype74 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_384 is
			--|#line 1728 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1728")
end

yyval23 := new_address_as (yytype87 (yyvs.item (yyvsp)).first) 
			yyval := yyval23
		end

	yy_do_action_385 is
			--|#line 1730 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1730")
end

yyval23 := new_expr_address_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_386 is
			--|#line 1732 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1732")
end

yyval23 := new_address_current_as 
			yyval := yyval23
		end

	yy_do_action_387 is
			--|#line 1734 "eiffel.y"
		local
			yyval23: EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1734")
end

yyval23 := new_address_result_as 
			yyval := yyval23
		end

	yy_do_action_388 is
			--|#line 1738 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1738")
end

create yyval30.initialize (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_389 is
			--|#line 1746 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1746")
end

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_390 is
			--|#line 1748 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1748")
end

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_391 is
			--|#line 1750 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1750")
end

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_392 is
			--|#line 1752 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1752")
end

yyval10 := new_current_as 
			yyval := yyval10
		end

	yy_do_action_393 is
			--|#line 1754 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1754")
end

yyval10 := new_result_as 
			yyval := yyval10
		end

	yy_do_action_394 is
			--|#line 1756 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1756")
end

yyval10 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_395 is
			--|#line 1758 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1758")
end

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_396 is
			--|#line 1760 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1760")
end

yyval10 := yytype45 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_397 is
			--|#line 1762 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1762")
end

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_398 is
			--|#line 1764 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1764")
end

yyval10 := yytype46 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_399 is
			--|#line 1766 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1766")
end

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_400 is
			--|#line 1768 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1768")
end

yyval10 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_401 is
			--|#line 1772 "eiffel.y"
		local
			yyval41: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1772")
end

yyval41 := new_nested_as (new_current_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_402 is
			--|#line 1776 "eiffel.y"
		local
			yyval41: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1776")
end

yyval41 := new_nested_as (new_result_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_403 is
			--|#line 1780 "eiffel.y"
		local
			yyval41: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1780")
end

yyval41 := new_nested_as (yytype1 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_404 is
			--|#line 1784 "eiffel.y"
		local
			yyval42: NESTED_EXPR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1784")
end

yyval42 := new_nested_expr_as (yytype23 (yyvs.item (yyvsp - 3)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_405 is
			--|#line 1788 "eiffel.y"
		local
			yyval41: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1788")
end

yyval41 := new_nested_as (yytype45 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_406 is
			--|#line 1792 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1792")
end

yyval45 := new_precursor_as (Void, yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_407 is
			--|#line 1794 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1794")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 2)), yytype66 (yyvs.item (yyvsp)), Void) 
			yyval := yyval45
		end

	yy_do_action_408 is
			--|#line 1796 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1796")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 5)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_409 is
			--|#line 1798 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1798")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_410 is
			--|#line 1800 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1800")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_411 is
			--|#line 1802 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1802")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_412 is
			--|#line 1804 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1804")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_413 is
			--|#line 1806 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1806")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_414 is
			--|#line 1808 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1808")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_415 is
			--|#line 1810 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1810")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_416 is
			--|#line 1812 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1812")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_417 is
			--|#line 1814 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1814")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_418 is
			--|#line 1816 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1816")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_419 is
			--|#line 1818 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1818")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_420 is
			--|#line 1820 "eiffel.y"
		local
			yyval45: PRECURSOR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1820")
end

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 2))) 
			yyval := yyval45
		end

	yy_do_action_421 is
			--|#line 1824 "eiffel.y"
		local
			yyval41: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1824")
end

yyval41 := new_nested_as (yytype46 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_422 is
			--|#line 1828 "eiffel.y"
		local
			yyval46: STATIC_ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1828")
end

				yyval46 := new_static_access_as (yytype58 (yyvs.item (yyvsp - 4)), yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp)));
			
			yyval := yyval46
		end

	yy_do_action_423 is
			--|#line 1835 "eiffel.y"
		local
			yyval46: STATIC_ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1835")
end

				yyval46 := new_static_access_as (yytype58 (yyvs.item (yyvsp - 3)), yytype30 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval46
		end

	yy_do_action_424 is
			--|#line 1843 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1843")
end

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_425 is
			--|#line 1845 "eiffel.y"
		local
			yyval10: CALL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1845")
end

yyval10 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_426 is
			--|#line 1849 "eiffel.y"
		local
			yyval41: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1849")
end

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_427 is
			--|#line 1851 "eiffel.y"
		local
			yyval41: NESTED_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1851")
end

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype41 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_428 is
			--|#line 1855 "eiffel.y"
		local
			yyval1: ACCESS_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1855")
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
			--|#line 1868 "eiffel.y"
		local
			yyval2: ACCESS_FEAT_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1868")
end

yyval2 := new_access_feat_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval2
		end

	yy_do_action_430 is
			--|#line 1872 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1872")
end


			yyval := yyval66
		end

	yy_do_action_431 is
			--|#line 1874 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1874")
end


			yyval := yyval66
		end

	yy_do_action_432 is
			--|#line 1876 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1876")
end

yyval66 := yytype66 (yyvs.item (yyvsp - 1)) 
			yyval := yyval66
		end

	yy_do_action_433 is
			--|#line 1880 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1880")
end

				yyval66 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_434 is
			--|#line 1885 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1885")
end

				yyval66 := yytype66 (yyvs.item (yyvsp - 2))
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_435 is
			--|#line 1892 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1892")
end

yyval66 := new_eiffel_list_expr_as (0) 
			yyval := yyval66
		end

	yy_do_action_436 is
			--|#line 1894 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1894")
end

yyval66 := yytype66 (yyvs.item (yyvsp)) 
			yyval := yyval66
		end

	yy_do_action_437 is
			--|#line 1898 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1898")
end

				yyval66 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_438 is
			--|#line 1903 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1903")
end

				yyval66 := yytype66 (yyvs.item (yyvsp - 2))
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_439 is
			--|#line 1914 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1914")
end

create yyval30.initialize (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_440 is
			--|#line 1916 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1916")
end

yyval30 := new_boolean_id_as 
			yyval := yyval30
		end

	yy_do_action_441 is
			--|#line 1918 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1918")
end

yyval30 := new_character_id_as (False) 
			yyval := yyval30
		end

	yy_do_action_442 is
			--|#line 1920 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1920")
end

yyval30 := new_character_id_as (True) 
			yyval := yyval30
		end

	yy_do_action_443 is
			--|#line 1922 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1922")
end

yyval30 := new_double_id_as 
			yyval := yyval30
		end

	yy_do_action_444 is
			--|#line 1924 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1924")
end

yyval30 := new_integer_id_as (8) 
			yyval := yyval30
		end

	yy_do_action_445 is
			--|#line 1926 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1926")
end

yyval30 := new_integer_id_as (16) 
			yyval := yyval30
		end

	yy_do_action_446 is
			--|#line 1928 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1928")
end

yyval30 := new_integer_id_as (32) 
			yyval := yyval30
		end

	yy_do_action_447 is
			--|#line 1930 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1930")
end

yyval30 := new_integer_id_as (64) 
			yyval := yyval30
		end

	yy_do_action_448 is
			--|#line 1932 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1932")
end

yyval30 := new_none_id_as 
			yyval := yyval30
		end

	yy_do_action_449 is
			--|#line 1934 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1934")
end

yyval30 := new_pointer_id_as 
			yyval := yyval30
		end

	yy_do_action_450 is
			--|#line 1936 "eiffel.y"
		local
			yyval30: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1936")
end

yyval30 := new_real_id_as 
			yyval := yyval30
		end

	yy_do_action_451 is
			--|#line 1940 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1940")
end

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_452 is
			--|#line 1942 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1942")
end

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_453 is
			--|#line 1944 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1944")
end

yyval6 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_454 is
			--|#line 1946 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1946")
end

yyval6 := yytype47 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_455 is
			--|#line 1948 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1948")
end

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_456 is
			--|#line 1950 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1950")
end

yyval6 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_457 is
			--|#line 1954 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1954")
end

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_458 is
			--|#line 1956 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1956")
end

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_459 is
			--|#line 1958 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1958")
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
			--|#line 1973 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1973")
end

yyval6 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval6
		end

	yy_do_action_461 is
			--|#line 1975 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1975")
end

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_462 is
			--|#line 1977 "eiffel.y"
		local
			yyval6: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1977")
end

yyval6 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_463 is
			--|#line 1981 "eiffel.y"
		local
			yyval9: BOOL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1981")
end

yyval9 := new_boolean_as (False) 
			yyval := yyval9
		end

	yy_do_action_464 is
			--|#line 1983 "eiffel.y"
		local
			yyval9: BOOL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1983")
end

yyval9 := new_boolean_as (True) 
			yyval := yyval9
		end

	yy_do_action_465 is
			--|#line 1987 "eiffel.y"
		local
			yyval12: CHAR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1987")
end

				check is_character: not token_buffer.is_empty end
				yyval12 := new_character_as (token_buffer.item (1))
			
			yyval := yyval12
		end

	yy_do_action_466 is
			--|#line 1994 "eiffel.y"
		local
			yyval36: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1994")
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
			--|#line 2009 "eiffel.y"
		local
			yyval36: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2009")
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
			--|#line 2024 "eiffel.y"
		local
			yyval36: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2024")
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
			--|#line 2042 "eiffel.y"
		local
			yyval47: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2042")
end

yyval47 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval47
		end

	yy_do_action_470 is
			--|#line 2044 "eiffel.y"
		local
			yyval47: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2044")
end

yyval47 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval47
		end

	yy_do_action_471 is
			--|#line 2046 "eiffel.y"
		local
			yyval47: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2046")
end

				token_buffer.precede ('-')
				yyval47 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval47
		end

	yy_do_action_472 is
			--|#line 2053 "eiffel.y"
		local
			yyval7: BIT_CONST_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2053")
end

yyval7 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval7
		end

	yy_do_action_473 is
			--|#line 2057 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2057")
end

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_474 is
			--|#line 2059 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2059")
end

yyval55 := new_empty_string_as 
			yyval := yyval55
		end

	yy_do_action_475 is
			--|#line 2061 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2061")
end

yyval55 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval55
		end

	yy_do_action_476 is
			--|#line 2065 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2065")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_477 is
			--|#line 2067 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2067")
end

yyval55 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval55
		end

	yy_do_action_478 is
			--|#line 2069 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2069")
end

yyval55 := new_lt_string_as 
			yyval := yyval55
		end

	yy_do_action_479 is
			--|#line 2071 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2071")
end

yyval55 := new_le_string_as 
			yyval := yyval55
		end

	yy_do_action_480 is
			--|#line 2073 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2073")
end

yyval55 := new_gt_string_as 
			yyval := yyval55
		end

	yy_do_action_481 is
			--|#line 2075 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2075")
end

yyval55 := new_ge_string_as 
			yyval := yyval55
		end

	yy_do_action_482 is
			--|#line 2077 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2077")
end

yyval55 := new_minus_string_as 
			yyval := yyval55
		end

	yy_do_action_483 is
			--|#line 2079 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2079")
end

yyval55 := new_plus_string_as 
			yyval := yyval55
		end

	yy_do_action_484 is
			--|#line 2081 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2081")
end

yyval55 := new_star_string_as 
			yyval := yyval55
		end

	yy_do_action_485 is
			--|#line 2083 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2083")
end

yyval55 := new_slash_string_as 
			yyval := yyval55
		end

	yy_do_action_486 is
			--|#line 2085 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2085")
end

yyval55 := new_mod_string_as 
			yyval := yyval55
		end

	yy_do_action_487 is
			--|#line 2087 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2087")
end

yyval55 := new_div_string_as 
			yyval := yyval55
		end

	yy_do_action_488 is
			--|#line 2089 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2089")
end

yyval55 := new_power_string_as 
			yyval := yyval55
		end

	yy_do_action_489 is
			--|#line 2091 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2091")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_490 is
			--|#line 2093 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2093")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_491 is
			--|#line 2095 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2095")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_492 is
			--|#line 2097 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2097")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_493 is
			--|#line 2099 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2099")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_494 is
			--|#line 2101 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2101")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_495 is
			--|#line 2103 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2103")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_496 is
			--|#line 2105 "eiffel.y"
		local
			yyval55: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2105")
end

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_497 is
			--|#line 2109 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2109")
end

yyval88 := new_clickable_string (new_minus_string_as) 
			yyval := yyval88
		end

	yy_do_action_498 is
			--|#line 2111 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2111")
end

yyval88 := new_clickable_string (new_plus_string_as) 
			yyval := yyval88
		end

	yy_do_action_499 is
			--|#line 2113 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2113")
end

yyval88 := new_clickable_string (new_not_string_as) 
			yyval := yyval88
		end

	yy_do_action_500 is
			--|#line 2115 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2115")
end

yyval88 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval88
		end

	yy_do_action_501 is
			--|#line 2119 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2119")
end

yyval88 := new_clickable_string (new_lt_string_as) 
			yyval := yyval88
		end

	yy_do_action_502 is
			--|#line 2121 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2121")
end

yyval88 := new_clickable_string (new_le_string_as) 
			yyval := yyval88
		end

	yy_do_action_503 is
			--|#line 2123 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2123")
end

yyval88 := new_clickable_string (new_gt_string_as) 
			yyval := yyval88
		end

	yy_do_action_504 is
			--|#line 2125 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2125")
end

yyval88 := new_clickable_string (new_ge_string_as) 
			yyval := yyval88
		end

	yy_do_action_505 is
			--|#line 2127 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2127")
end

yyval88 := new_clickable_string (new_minus_string_as) 
			yyval := yyval88
		end

	yy_do_action_506 is
			--|#line 2129 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2129")
end

yyval88 := new_clickable_string (new_plus_string_as) 
			yyval := yyval88
		end

	yy_do_action_507 is
			--|#line 2131 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2131")
end

yyval88 := new_clickable_string (new_star_string_as) 
			yyval := yyval88
		end

	yy_do_action_508 is
			--|#line 2133 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2133")
end

yyval88 := new_clickable_string (new_slash_string_as) 
			yyval := yyval88
		end

	yy_do_action_509 is
			--|#line 2135 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2135")
end

yyval88 := new_clickable_string (new_mod_string_as) 
			yyval := yyval88
		end

	yy_do_action_510 is
			--|#line 2137 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2137")
end

yyval88 := new_clickable_string (new_div_string_as) 
			yyval := yyval88
		end

	yy_do_action_511 is
			--|#line 2139 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2139")
end

yyval88 := new_clickable_string (new_power_string_as) 
			yyval := yyval88
		end

	yy_do_action_512 is
			--|#line 2141 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2141")
end

yyval88 := new_clickable_string (new_and_string_as) 
			yyval := yyval88
		end

	yy_do_action_513 is
			--|#line 2143 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2143")
end

yyval88 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval88
		end

	yy_do_action_514 is
			--|#line 2145 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2145")
end

yyval88 := new_clickable_string (new_implies_string_as) 
			yyval := yyval88
		end

	yy_do_action_515 is
			--|#line 2147 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2147")
end

yyval88 := new_clickable_string (new_or_string_as) 
			yyval := yyval88
		end

	yy_do_action_516 is
			--|#line 2149 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2149")
end

yyval88 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval88
		end

	yy_do_action_517 is
			--|#line 2151 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2151")
end

yyval88 := new_clickable_string (new_xor_string_as) 
			yyval := yyval88
		end

	yy_do_action_518 is
			--|#line 2153 "eiffel.y"
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2153")
end

yyval88 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval88
		end

	yy_do_action_519 is
			--|#line 2157 "eiffel.y"
		local
			yyval4: ARRAY_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2157")
end

yyval4 := new_array_as (yytype66 (yyvs.item (yyvsp - 1))) 
			yyval := yyval4
		end

	yy_do_action_520 is
			--|#line 2161 "eiffel.y"
		local
			yyval57: TUPLE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2161")
end

yyval57 := new_tuple_as (yytype66 (yyvs.item (yyvsp - 1))) 
			yyval := yyval57
		end

	yy_do_action_521 is
			--|#line 2165 "eiffel.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2165")
end
			yyval := yyval_default;


		end

	yy_do_action_522 is
			--|#line 2169 "eiffel.y"
		local
			yyval91: TOKEN_LOCATION
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2169")
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



feature {NONE} -- Implementation

	yy_translate (i: INTEGER): INTEGER is
			-- Translate lexical token `i' into 
			-- geyacc internal token code.
		do
			if i <= yyMax_token then
				Result := yytranslate.item (i)
			else
				Result := yyNsyms
			end
		end

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
