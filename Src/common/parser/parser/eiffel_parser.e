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
					--|#line 175 "eiffel.y"
				yy_do_action_1
			when 2 then
					--|#line 182 "eiffel.y"
				yy_do_action_2
			when 3 then
					--|#line 191 "eiffel.y"
				yy_do_action_3
			when 4 then
					--|#line 234 "eiffel.y"
				yy_do_action_4
			when 5 then
					--|#line 243 "eiffel.y"
				yy_do_action_5
			when 6 then
					--|#line 251 "eiffel.y"
				yy_do_action_6
			when 7 then
					--|#line 263 "eiffel.y"
				yy_do_action_7
			when 8 then
					--|#line 265 "eiffel.y"
				yy_do_action_8
			when 9 then
					--|#line 267 "eiffel.y"
				yy_do_action_9
			when 10 then
					--|#line 271 "eiffel.y"
				yy_do_action_10
			when 11 then
					--|#line 273 "eiffel.y"
				yy_do_action_11
			when 12 then
					--|#line 275 "eiffel.y"
				yy_do_action_12
			when 13 then
					--|#line 279 "eiffel.y"
				yy_do_action_13
			when 14 then
					--|#line 281 "eiffel.y"
				yy_do_action_14
			when 15 then
					--|#line 283 "eiffel.y"
				yy_do_action_15
			when 16 then
					--|#line 287 "eiffel.y"
				yy_do_action_16
			when 17 then
					--|#line 292 "eiffel.y"
				yy_do_action_17
			when 18 then
					--|#line 299 "eiffel.y"
				yy_do_action_18
			when 19 then
					--|#line 303 "eiffel.y"
				yy_do_action_19
			when 20 then
					--|#line 305 "eiffel.y"
				yy_do_action_20
			when 21 then
					--|#line 317 "eiffel.y"
				yy_do_action_21
			when 22 then
					--|#line 322 "eiffel.y"
				yy_do_action_22
			when 23 then
					--|#line 327 "eiffel.y"
				yy_do_action_23
			when 24 then
					--|#line 334 "eiffel.y"
				yy_do_action_24
			when 25 then
					--|#line 336 "eiffel.y"
				yy_do_action_25
			when 26 then
					--|#line 338 "eiffel.y"
				yy_do_action_26
			when 27 then
					--|#line 342 "eiffel.y"
				yy_do_action_27
			when 28 then
					--|#line 352 "eiffel.y"
				yy_do_action_28
			when 29 then
					--|#line 358 "eiffel.y"
				yy_do_action_29
			when 30 then
					--|#line 365 "eiffel.y"
				yy_do_action_30
			when 31 then
					--|#line 371 "eiffel.y"
				yy_do_action_31
			when 32 then
					--|#line 379 "eiffel.y"
				yy_do_action_32
			when 33 then
					--|#line 383 "eiffel.y"
				yy_do_action_33
			when 34 then
					--|#line 394 "eiffel.y"
				yy_do_action_34
			when 35 then
					--|#line 398 "eiffel.y"
				yy_do_action_35
			when 36 then
					--|#line 413 "eiffel.y"
				yy_do_action_36
			when 37 then
					--|#line 415 "eiffel.y"
				yy_do_action_37
			when 38 then
					--|#line 422 "eiffel.y"
				yy_do_action_38
			when 39 then
					--|#line 424 "eiffel.y"
				yy_do_action_39
			when 40 then
					--|#line 433 "eiffel.y"
				yy_do_action_40
			when 41 then
					--|#line 438 "eiffel.y"
				yy_do_action_41
			when 42 then
					--|#line 445 "eiffel.y"
				yy_do_action_42
			when 43 then
					--|#line 447 "eiffel.y"
				yy_do_action_43
			when 44 then
					--|#line 451 "eiffel.y"
				yy_do_action_44
			when 45 then
					--|#line 451 "eiffel.y"
				yy_do_action_45
			when 46 then
					--|#line 460 "eiffel.y"
				yy_do_action_46
			when 47 then
					--|#line 462 "eiffel.y"
				yy_do_action_47
			when 48 then
					--|#line 466 "eiffel.y"
				yy_do_action_48
			when 49 then
					--|#line 471 "eiffel.y"
				yy_do_action_49
			when 50 then
					--|#line 475 "eiffel.y"
				yy_do_action_50
			when 51 then
					--|#line 481 "eiffel.y"
				yy_do_action_51
			when 52 then
					--|#line 489 "eiffel.y"
				yy_do_action_52
			when 53 then
					--|#line 494 "eiffel.y"
				yy_do_action_53
			when 54 then
					--|#line 501 "eiffel.y"
				yy_do_action_54
			when 55 then
					--|#line 502 "eiffel.y"
				yy_do_action_55
			when 56 then
					--|#line 505 "eiffel.y"
				yy_do_action_56
			when 57 then
					--|#line 518 "eiffel.y"
				yy_do_action_57
			when 58 then
					--|#line 520 "eiffel.y"
				yy_do_action_58
			when 59 then
					--|#line 527 "eiffel.y"
				yy_do_action_59
			when 60 then
					--|#line 531 "eiffel.y"
				yy_do_action_60
			when 61 then
					--|#line 533 "eiffel.y"
				yy_do_action_61
			when 62 then
					--|#line 537 "eiffel.y"
				yy_do_action_62
			when 63 then
					--|#line 539 "eiffel.y"
				yy_do_action_63
			when 64 then
					--|#line 541 "eiffel.y"
				yy_do_action_64
			when 65 then
					--|#line 545 "eiffel.y"
				yy_do_action_65
			when 66 then
					--|#line 550 "eiffel.y"
				yy_do_action_66
			when 67 then
					--|#line 554 "eiffel.y"
				yy_do_action_67
			when 68 then
					--|#line 558 "eiffel.y"
				yy_do_action_68
			when 69 then
					--|#line 560 "eiffel.y"
				yy_do_action_69
			when 70 then
					--|#line 564 "eiffel.y"
				yy_do_action_70
			when 71 then
					--|#line 569 "eiffel.y"
				yy_do_action_71
			when 72 then
					--|#line 574 "eiffel.y"
				yy_do_action_72
			when 73 then
					--|#line 585 "eiffel.y"
				yy_do_action_73
			when 74 then
					--|#line 587 "eiffel.y"
				yy_do_action_74
			when 75 then
					--|#line 589 "eiffel.y"
				yy_do_action_75
			when 76 then
					--|#line 593 "eiffel.y"
				yy_do_action_76
			when 77 then
					--|#line 598 "eiffel.y"
				yy_do_action_77
			when 78 then
					--|#line 605 "eiffel.y"
				yy_do_action_78
			when 79 then
					--|#line 610 "eiffel.y"
				yy_do_action_79
			when 80 then
					--|#line 618 "eiffel.y"
				yy_do_action_80
			when 81 then
					--|#line 623 "eiffel.y"
				yy_do_action_81
			when 82 then
					--|#line 628 "eiffel.y"
				yy_do_action_82
			when 83 then
					--|#line 633 "eiffel.y"
				yy_do_action_83
			when 84 then
					--|#line 638 "eiffel.y"
				yy_do_action_84
			when 85 then
					--|#line 643 "eiffel.y"
				yy_do_action_85
			when 86 then
					--|#line 648 "eiffel.y"
				yy_do_action_86
			when 87 then
					--|#line 656 "eiffel.y"
				yy_do_action_87
			when 88 then
					--|#line 658 "eiffel.y"
				yy_do_action_88
			when 89 then
					--|#line 662 "eiffel.y"
				yy_do_action_89
			when 90 then
					--|#line 667 "eiffel.y"
				yy_do_action_90
			when 91 then
					--|#line 674 "eiffel.y"
				yy_do_action_91
			when 92 then
					--|#line 678 "eiffel.y"
				yy_do_action_92
			when 93 then
					--|#line 680 "eiffel.y"
				yy_do_action_93
			when 94 then
					--|#line 684 "eiffel.y"
				yy_do_action_94
			when 95 then
					--|#line 692 "eiffel.y"
				yy_do_action_95
			when 96 then
					--|#line 696 "eiffel.y"
				yy_do_action_96
			when 97 then
					--|#line 703 "eiffel.y"
				yy_do_action_97
			when 98 then
					--|#line 712 "eiffel.y"
				yy_do_action_98
			when 99 then
					--|#line 720 "eiffel.y"
				yy_do_action_99
			when 100 then
					--|#line 722 "eiffel.y"
				yy_do_action_100
			when 101 then
					--|#line 724 "eiffel.y"
				yy_do_action_101
			when 102 then
					--|#line 728 "eiffel.y"
				yy_do_action_102
			when 103 then
					--|#line 730 "eiffel.y"
				yy_do_action_103
			when 104 then
					--|#line 736 "eiffel.y"
				yy_do_action_104
			when 105 then
					--|#line 741 "eiffel.y"
				yy_do_action_105
			when 106 then
					--|#line 749 "eiffel.y"
				yy_do_action_106
			when 107 then
					--|#line 755 "eiffel.y"
				yy_do_action_107
			when 108 then
					--|#line 763 "eiffel.y"
				yy_do_action_108
			when 109 then
					--|#line 768 "eiffel.y"
				yy_do_action_109
			when 110 then
					--|#line 775 "eiffel.y"
				yy_do_action_110
			when 111 then
					--|#line 777 "eiffel.y"
				yy_do_action_111
			when 112 then
					--|#line 781 "eiffel.y"
				yy_do_action_112
			when 113 then
					--|#line 783 "eiffel.y"
				yy_do_action_113
			when 114 then
					--|#line 787 "eiffel.y"
				yy_do_action_114
			when 115 then
					--|#line 789 "eiffel.y"
				yy_do_action_115
			when 116 then
					--|#line 793 "eiffel.y"
				yy_do_action_116
			when 117 then
					--|#line 795 "eiffel.y"
				yy_do_action_117
			when 118 then
					--|#line 799 "eiffel.y"
				yy_do_action_118
			when 119 then
					--|#line 801 "eiffel.y"
				yy_do_action_119
			when 120 then
					--|#line 805 "eiffel.y"
				yy_do_action_120
			when 121 then
					--|#line 807 "eiffel.y"
				yy_do_action_121
			when 122 then
					--|#line 815 "eiffel.y"
				yy_do_action_122
			when 123 then
					--|#line 817 "eiffel.y"
				yy_do_action_123
			when 124 then
					--|#line 821 "eiffel.y"
				yy_do_action_124
			when 125 then
					--|#line 823 "eiffel.y"
				yy_do_action_125
			when 126 then
					--|#line 827 "eiffel.y"
				yy_do_action_126
			when 127 then
					--|#line 832 "eiffel.y"
				yy_do_action_127
			when 128 then
					--|#line 839 "eiffel.y"
				yy_do_action_128
			when 129 then
					--|#line 843 "eiffel.y"
				yy_do_action_129
			when 130 then
					--|#line 844 "eiffel.y"
				yy_do_action_130
			when 131 then
					--|#line 853 "eiffel.y"
				yy_do_action_131
			when 132 then
					--|#line 855 "eiffel.y"
				yy_do_action_132
			when 133 then
					--|#line 859 "eiffel.y"
				yy_do_action_133
			when 134 then
					--|#line 864 "eiffel.y"
				yy_do_action_134
			when 135 then
					--|#line 871 "eiffel.y"
				yy_do_action_135
			when 136 then
					--|#line 875 "eiffel.y"
				yy_do_action_136
			when 137 then
					--|#line 881 "eiffel.y"
				yy_do_action_137
			when 138 then
					--|#line 889 "eiffel.y"
				yy_do_action_138
			when 139 then
					--|#line 891 "eiffel.y"
				yy_do_action_139
			when 140 then
					--|#line 895 "eiffel.y"
				yy_do_action_140
			when 141 then
					--|#line 897 "eiffel.y"
				yy_do_action_141
			when 142 then
					--|#line 901 "eiffel.y"
				yy_do_action_142
			when 143 then
					--|#line 901 "eiffel.y"
				yy_do_action_143
			when 144 then
					--|#line 913 "eiffel.y"
				yy_do_action_144
			when 145 then
					--|#line 915 "eiffel.y"
				yy_do_action_145
			when 146 then
					--|#line 917 "eiffel.y"
				yy_do_action_146
			when 147 then
					--|#line 921 "eiffel.y"
				yy_do_action_147
			when 148 then
					--|#line 928 "eiffel.y"
				yy_do_action_148
			when 149 then
					--|#line 933 "eiffel.y"
				yy_do_action_149
			when 150 then
					--|#line 935 "eiffel.y"
				yy_do_action_150
			when 151 then
					--|#line 939 "eiffel.y"
				yy_do_action_151
			when 152 then
					--|#line 941 "eiffel.y"
				yy_do_action_152
			when 153 then
					--|#line 945 "eiffel.y"
				yy_do_action_153
			when 154 then
					--|#line 947 "eiffel.y"
				yy_do_action_154
			when 155 then
					--|#line 951 "eiffel.y"
				yy_do_action_155
			when 156 then
					--|#line 953 "eiffel.y"
				yy_do_action_156
			when 157 then
					--|#line 957 "eiffel.y"
				yy_do_action_157
			when 158 then
					--|#line 962 "eiffel.y"
				yy_do_action_158
			when 159 then
					--|#line 969 "eiffel.y"
				yy_do_action_159
			when 160 then
					--|#line 973 "eiffel.y"
				yy_do_action_160
			when 161 then
					--|#line 974 "eiffel.y"
				yy_do_action_161
			when 162 then
					--|#line 977 "eiffel.y"
				yy_do_action_162
			when 163 then
					--|#line 979 "eiffel.y"
				yy_do_action_163
			when 164 then
					--|#line 981 "eiffel.y"
				yy_do_action_164
			when 165 then
					--|#line 983 "eiffel.y"
				yy_do_action_165
			when 166 then
					--|#line 985 "eiffel.y"
				yy_do_action_166
			when 167 then
					--|#line 987 "eiffel.y"
				yy_do_action_167
			when 168 then
					--|#line 989 "eiffel.y"
				yy_do_action_168
			when 169 then
					--|#line 991 "eiffel.y"
				yy_do_action_169
			when 170 then
					--|#line 993 "eiffel.y"
				yy_do_action_170
			when 171 then
					--|#line 995 "eiffel.y"
				yy_do_action_171
			when 172 then
					--|#line 999 "eiffel.y"
				yy_do_action_172
			when 173 then
					--|#line 1001 "eiffel.y"
				yy_do_action_173
			when 174 then
					--|#line 1001 "eiffel.y"
				yy_do_action_174
			when 175 then
					--|#line 1008 "eiffel.y"
				yy_do_action_175
			when 176 then
					--|#line 1008 "eiffel.y"
				yy_do_action_176
			when 177 then
					--|#line 1017 "eiffel.y"
				yy_do_action_177
			when 178 then
					--|#line 1019 "eiffel.y"
				yy_do_action_178
			when 179 then
					--|#line 1019 "eiffel.y"
				yy_do_action_179
			when 180 then
					--|#line 1026 "eiffel.y"
				yy_do_action_180
			when 181 then
					--|#line 1026 "eiffel.y"
				yy_do_action_181
			when 182 then
					--|#line 1035 "eiffel.y"
				yy_do_action_182
			when 183 then
					--|#line 1037 "eiffel.y"
				yy_do_action_183
			when 184 then
					--|#line 1046 "eiffel.y"
				yy_do_action_184
			when 185 then
					--|#line 1051 "eiffel.y"
				yy_do_action_185
			when 186 then
					--|#line 1058 "eiffel.y"
				yy_do_action_186
			when 187 then
					--|#line 1062 "eiffel.y"
				yy_do_action_187
			when 188 then
					--|#line 1064 "eiffel.y"
				yy_do_action_188
			when 189 then
					--|#line 1066 "eiffel.y"
				yy_do_action_189
			when 190 then
					--|#line 1074 "eiffel.y"
				yy_do_action_190
			when 191 then
					--|#line 1076 "eiffel.y"
				yy_do_action_191
			when 192 then
					--|#line 1080 "eiffel.y"
				yy_do_action_192
			when 193 then
					--|#line 1082 "eiffel.y"
				yy_do_action_193
			when 194 then
					--|#line 1084 "eiffel.y"
				yy_do_action_194
			when 195 then
					--|#line 1086 "eiffel.y"
				yy_do_action_195
			when 196 then
					--|#line 1088 "eiffel.y"
				yy_do_action_196
			when 197 then
					--|#line 1090 "eiffel.y"
				yy_do_action_197
			when 198 then
					--|#line 1092 "eiffel.y"
				yy_do_action_198
			when 199 then
					--|#line 1096 "eiffel.y"
				yy_do_action_199
			when 200 then
					--|#line 1100 "eiffel.y"
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
					--|#line 1102 "eiffel.y"
				yy_do_action_201
			when 202 then
					--|#line 1104 "eiffel.y"
				yy_do_action_202
			when 203 then
					--|#line 1108 "eiffel.y"
				yy_do_action_203
			when 204 then
					--|#line 1110 "eiffel.y"
				yy_do_action_204
			when 205 then
					--|#line 1114 "eiffel.y"
				yy_do_action_205
			when 206 then
					--|#line 1119 "eiffel.y"
				yy_do_action_206
			when 207 then
					--|#line 1130 "eiffel.y"
				yy_do_action_207
			when 208 then
					--|#line 1136 "eiffel.y"
				yy_do_action_208
			when 209 then
					--|#line 1144 "eiffel.y"
				yy_do_action_209
			when 210 then
					--|#line 1146 "eiffel.y"
				yy_do_action_210
			when 211 then
					--|#line 1150 "eiffel.y"
				yy_do_action_211
			when 212 then
					--|#line 1155 "eiffel.y"
				yy_do_action_212
			when 213 then
					--|#line 1162 "eiffel.y"
				yy_do_action_213
			when 214 then
					--|#line 1162 "eiffel.y"
				yy_do_action_214
			when 215 then
					--|#line 1187 "eiffel.y"
				yy_do_action_215
			when 216 then
					--|#line 1189 "eiffel.y"
				yy_do_action_216
			when 217 then
					--|#line 1197 "eiffel.y"
				yy_do_action_217
			when 218 then
					--|#line 1199 "eiffel.y"
				yy_do_action_218
			when 219 then
					--|#line 1207 "eiffel.y"
				yy_do_action_219
			when 220 then
					--|#line 1213 "eiffel.y"
				yy_do_action_220
			when 221 then
					--|#line 1215 "eiffel.y"
				yy_do_action_221
			when 222 then
					--|#line 1219 "eiffel.y"
				yy_do_action_222
			when 223 then
					--|#line 1224 "eiffel.y"
				yy_do_action_223
			when 224 then
					--|#line 1231 "eiffel.y"
				yy_do_action_224
			when 225 then
					--|#line 1235 "eiffel.y"
				yy_do_action_225
			when 226 then
					--|#line 1237 "eiffel.y"
				yy_do_action_226
			when 227 then
					--|#line 1241 "eiffel.y"
				yy_do_action_227
			when 228 then
					--|#line 1247 "eiffel.y"
				yy_do_action_228
			when 229 then
					--|#line 1249 "eiffel.y"
				yy_do_action_229
			when 230 then
					--|#line 1253 "eiffel.y"
				yy_do_action_230
			when 231 then
					--|#line 1258 "eiffel.y"
				yy_do_action_231
			when 232 then
					--|#line 1265 "eiffel.y"
				yy_do_action_232
			when 233 then
					--|#line 1269 "eiffel.y"
				yy_do_action_233
			when 234 then
					--|#line 1274 "eiffel.y"
				yy_do_action_234
			when 235 then
					--|#line 1281 "eiffel.y"
				yy_do_action_235
			when 236 then
					--|#line 1283 "eiffel.y"
				yy_do_action_236
			when 237 then
					--|#line 1285 "eiffel.y"
				yy_do_action_237
			when 238 then
					--|#line 1287 "eiffel.y"
				yy_do_action_238
			when 239 then
					--|#line 1289 "eiffel.y"
				yy_do_action_239
			when 240 then
					--|#line 1291 "eiffel.y"
				yy_do_action_240
			when 241 then
					--|#line 1293 "eiffel.y"
				yy_do_action_241
			when 242 then
					--|#line 1295 "eiffel.y"
				yy_do_action_242
			when 243 then
					--|#line 1297 "eiffel.y"
				yy_do_action_243
			when 244 then
					--|#line 1299 "eiffel.y"
				yy_do_action_244
			when 245 then
					--|#line 1301 "eiffel.y"
				yy_do_action_245
			when 246 then
					--|#line 1303 "eiffel.y"
				yy_do_action_246
			when 247 then
					--|#line 1305 "eiffel.y"
				yy_do_action_247
			when 248 then
					--|#line 1307 "eiffel.y"
				yy_do_action_248
			when 249 then
					--|#line 1309 "eiffel.y"
				yy_do_action_249
			when 250 then
					--|#line 1311 "eiffel.y"
				yy_do_action_250
			when 251 then
					--|#line 1313 "eiffel.y"
				yy_do_action_251
			when 252 then
					--|#line 1315 "eiffel.y"
				yy_do_action_252
			when 253 then
					--|#line 1320 "eiffel.y"
				yy_do_action_253
			when 254 then
					--|#line 1322 "eiffel.y"
				yy_do_action_254
			when 255 then
					--|#line 1331 "eiffel.y"
				yy_do_action_255
			when 256 then
					--|#line 1337 "eiffel.y"
				yy_do_action_256
			when 257 then
					--|#line 1339 "eiffel.y"
				yy_do_action_257
			when 258 then
					--|#line 1343 "eiffel.y"
				yy_do_action_258
			when 259 then
					--|#line 1345 "eiffel.y"
				yy_do_action_259
			when 260 then
					--|#line 1345 "eiffel.y"
				yy_do_action_260
			when 261 then
					--|#line 1355 "eiffel.y"
				yy_do_action_261
			when 262 then
					--|#line 1357 "eiffel.y"
				yy_do_action_262
			when 263 then
					--|#line 1359 "eiffel.y"
				yy_do_action_263
			when 264 then
					--|#line 1363 "eiffel.y"
				yy_do_action_264
			when 265 then
					--|#line 1369 "eiffel.y"
				yy_do_action_265
			when 266 then
					--|#line 1371 "eiffel.y"
				yy_do_action_266
			when 267 then
					--|#line 1373 "eiffel.y"
				yy_do_action_267
			when 268 then
					--|#line 1377 "eiffel.y"
				yy_do_action_268
			when 269 then
					--|#line 1382 "eiffel.y"
				yy_do_action_269
			when 270 then
					--|#line 1389 "eiffel.y"
				yy_do_action_270
			when 271 then
					--|#line 1393 "eiffel.y"
				yy_do_action_271
			when 272 then
					--|#line 1395 "eiffel.y"
				yy_do_action_272
			when 273 then
					--|#line 1404 "eiffel.y"
				yy_do_action_273
			when 274 then
					--|#line 1406 "eiffel.y"
				yy_do_action_274
			when 275 then
					--|#line 1410 "eiffel.y"
				yy_do_action_275
			when 276 then
					--|#line 1412 "eiffel.y"
				yy_do_action_276
			when 277 then
					--|#line 1416 "eiffel.y"
				yy_do_action_277
			when 278 then
					--|#line 1418 "eiffel.y"
				yy_do_action_278
			when 279 then
					--|#line 1422 "eiffel.y"
				yy_do_action_279
			when 280 then
					--|#line 1427 "eiffel.y"
				yy_do_action_280
			when 281 then
					--|#line 1434 "eiffel.y"
				yy_do_action_281
			when 282 then
					--|#line 1440 "eiffel.y"
				yy_do_action_282
			when 283 then
					--|#line 1445 "eiffel.y"
				yy_do_action_283
			when 284 then
					--|#line 1450 "eiffel.y"
				yy_do_action_284
			when 285 then
					--|#line 1460 "eiffel.y"
				yy_do_action_285
			when 286 then
					--|#line 1470 "eiffel.y"
				yy_do_action_286
			when 287 then
					--|#line 1482 "eiffel.y"
				yy_do_action_287
			when 288 then
					--|#line 1484 "eiffel.y"
				yy_do_action_288
			when 289 then
					--|#line 1486 "eiffel.y"
				yy_do_action_289
			when 290 then
					--|#line 1504 "eiffel.y"
				yy_do_action_290
			when 291 then
					--|#line 1506 "eiffel.y"
				yy_do_action_291
			when 292 then
					--|#line 1508 "eiffel.y"
				yy_do_action_292
			when 293 then
					--|#line 1510 "eiffel.y"
				yy_do_action_293
			when 294 then
					--|#line 1512 "eiffel.y"
				yy_do_action_294
			when 295 then
					--|#line 1514 "eiffel.y"
				yy_do_action_295
			when 296 then
					--|#line 1516 "eiffel.y"
				yy_do_action_296
			when 297 then
					--|#line 1520 "eiffel.y"
				yy_do_action_297
			when 298 then
					--|#line 1522 "eiffel.y"
				yy_do_action_298
			when 299 then
					--|#line 1524 "eiffel.y"
				yy_do_action_299
			when 300 then
					--|#line 1526 "eiffel.y"
				yy_do_action_300
			when 301 then
					--|#line 1528 "eiffel.y"
				yy_do_action_301
			when 302 then
					--|#line 1530 "eiffel.y"
				yy_do_action_302
			when 303 then
					--|#line 1534 "eiffel.y"
				yy_do_action_303
			when 304 then
					--|#line 1536 "eiffel.y"
				yy_do_action_304
			when 305 then
					--|#line 1538 "eiffel.y"
				yy_do_action_305
			when 306 then
					--|#line 1542 "eiffel.y"
				yy_do_action_306
			when 307 then
					--|#line 1547 "eiffel.y"
				yy_do_action_307
			when 308 then
					--|#line 1554 "eiffel.y"
				yy_do_action_308
			when 309 then
					--|#line 1560 "eiffel.y"
				yy_do_action_309
			when 310 then
					--|#line 1562 "eiffel.y"
				yy_do_action_310
			when 311 then
					--|#line 1564 "eiffel.y"
				yy_do_action_311
			when 312 then
					--|#line 1566 "eiffel.y"
				yy_do_action_312
			when 313 then
					--|#line 1568 "eiffel.y"
				yy_do_action_313
			when 314 then
					--|#line 1570 "eiffel.y"
				yy_do_action_314
			when 315 then
					--|#line 1572 "eiffel.y"
				yy_do_action_315
			when 316 then
					--|#line 1574 "eiffel.y"
				yy_do_action_316
			when 317 then
					--|#line 1576 "eiffel.y"
				yy_do_action_317
			when 318 then
					--|#line 1578 "eiffel.y"
				yy_do_action_318
			when 319 then
					--|#line 1582 "eiffel.y"
				yy_do_action_319
			when 320 then
					--|#line 1591 "eiffel.y"
				yy_do_action_320
			when 321 then
					--|#line 1593 "eiffel.y"
				yy_do_action_321
			when 322 then
					--|#line 1597 "eiffel.y"
				yy_do_action_322
			when 323 then
					--|#line 1599 "eiffel.y"
				yy_do_action_323
			when 324 then
					--|#line 1610 "eiffel.y"
				yy_do_action_324
			when 325 then
					--|#line 1612 "eiffel.y"
				yy_do_action_325
			when 326 then
					--|#line 1616 "eiffel.y"
				yy_do_action_326
			when 327 then
					--|#line 1618 "eiffel.y"
				yy_do_action_327
			when 328 then
					--|#line 1622 "eiffel.y"
				yy_do_action_328
			when 329 then
					--|#line 1624 "eiffel.y"
				yy_do_action_329
			when 330 then
					--|#line 1632 "eiffel.y"
				yy_do_action_330
			when 331 then
					--|#line 1634 "eiffel.y"
				yy_do_action_331
			when 332 then
					--|#line 1636 "eiffel.y"
				yy_do_action_332
			when 333 then
					--|#line 1638 "eiffel.y"
				yy_do_action_333
			when 334 then
					--|#line 1640 "eiffel.y"
				yy_do_action_334
			when 335 then
					--|#line 1642 "eiffel.y"
				yy_do_action_335
			when 336 then
					--|#line 1644 "eiffel.y"
				yy_do_action_336
			when 337 then
					--|#line 1646 "eiffel.y"
				yy_do_action_337
			when 338 then
					--|#line 1648 "eiffel.y"
				yy_do_action_338
			when 339 then
					--|#line 1652 "eiffel.y"
				yy_do_action_339
			when 340 then
					--|#line 1660 "eiffel.y"
				yy_do_action_340
			when 341 then
					--|#line 1662 "eiffel.y"
				yy_do_action_341
			when 342 then
					--|#line 1664 "eiffel.y"
				yy_do_action_342
			when 343 then
					--|#line 1666 "eiffel.y"
				yy_do_action_343
			when 344 then
					--|#line 1668 "eiffel.y"
				yy_do_action_344
			when 345 then
					--|#line 1670 "eiffel.y"
				yy_do_action_345
			when 346 then
					--|#line 1672 "eiffel.y"
				yy_do_action_346
			when 347 then
					--|#line 1674 "eiffel.y"
				yy_do_action_347
			when 348 then
					--|#line 1676 "eiffel.y"
				yy_do_action_348
			when 349 then
					--|#line 1678 "eiffel.y"
				yy_do_action_349
			when 350 then
					--|#line 1680 "eiffel.y"
				yy_do_action_350
			when 351 then
					--|#line 1682 "eiffel.y"
				yy_do_action_351
			when 352 then
					--|#line 1684 "eiffel.y"
				yy_do_action_352
			when 353 then
					--|#line 1686 "eiffel.y"
				yy_do_action_353
			when 354 then
					--|#line 1688 "eiffel.y"
				yy_do_action_354
			when 355 then
					--|#line 1690 "eiffel.y"
				yy_do_action_355
			when 356 then
					--|#line 1692 "eiffel.y"
				yy_do_action_356
			when 357 then
					--|#line 1694 "eiffel.y"
				yy_do_action_357
			when 358 then
					--|#line 1696 "eiffel.y"
				yy_do_action_358
			when 359 then
					--|#line 1698 "eiffel.y"
				yy_do_action_359
			when 360 then
					--|#line 1700 "eiffel.y"
				yy_do_action_360
			when 361 then
					--|#line 1702 "eiffel.y"
				yy_do_action_361
			when 362 then
					--|#line 1704 "eiffel.y"
				yy_do_action_362
			when 363 then
					--|#line 1706 "eiffel.y"
				yy_do_action_363
			when 364 then
					--|#line 1708 "eiffel.y"
				yy_do_action_364
			when 365 then
					--|#line 1710 "eiffel.y"
				yy_do_action_365
			when 366 then
					--|#line 1712 "eiffel.y"
				yy_do_action_366
			when 367 then
					--|#line 1714 "eiffel.y"
				yy_do_action_367
			when 368 then
					--|#line 1716 "eiffel.y"
				yy_do_action_368
			when 369 then
					--|#line 1718 "eiffel.y"
				yy_do_action_369
			when 370 then
					--|#line 1720 "eiffel.y"
				yy_do_action_370
			when 371 then
					--|#line 1722 "eiffel.y"
				yy_do_action_371
			when 372 then
					--|#line 1724 "eiffel.y"
				yy_do_action_372
			when 373 then
					--|#line 1726 "eiffel.y"
				yy_do_action_373
			when 374 then
					--|#line 1728 "eiffel.y"
				yy_do_action_374
			when 375 then
					--|#line 1730 "eiffel.y"
				yy_do_action_375
			when 376 then
					--|#line 1732 "eiffel.y"
				yy_do_action_376
			when 377 then
					--|#line 1736 "eiffel.y"
				yy_do_action_377
			when 378 then
					--|#line 1744 "eiffel.y"
				yy_do_action_378
			when 379 then
					--|#line 1746 "eiffel.y"
				yy_do_action_379
			when 380 then
					--|#line 1748 "eiffel.y"
				yy_do_action_380
			when 381 then
					--|#line 1750 "eiffel.y"
				yy_do_action_381
			when 382 then
					--|#line 1752 "eiffel.y"
				yy_do_action_382
			when 383 then
					--|#line 1754 "eiffel.y"
				yy_do_action_383
			when 384 then
					--|#line 1756 "eiffel.y"
				yy_do_action_384
			when 385 then
					--|#line 1758 "eiffel.y"
				yy_do_action_385
			when 386 then
					--|#line 1760 "eiffel.y"
				yy_do_action_386
			when 387 then
					--|#line 1762 "eiffel.y"
				yy_do_action_387
			when 388 then
					--|#line 1764 "eiffel.y"
				yy_do_action_388
			when 389 then
					--|#line 1766 "eiffel.y"
				yy_do_action_389
			when 390 then
					--|#line 1770 "eiffel.y"
				yy_do_action_390
			when 391 then
					--|#line 1774 "eiffel.y"
				yy_do_action_391
			when 392 then
					--|#line 1778 "eiffel.y"
				yy_do_action_392
			when 393 then
					--|#line 1782 "eiffel.y"
				yy_do_action_393
			when 394 then
					--|#line 1786 "eiffel.y"
				yy_do_action_394
			when 395 then
					--|#line 1790 "eiffel.y"
				yy_do_action_395
			when 396 then
					--|#line 1792 "eiffel.y"
				yy_do_action_396
			when 397 then
					--|#line 1794 "eiffel.y"
				yy_do_action_397
			when 398 then
					--|#line 1796 "eiffel.y"
				yy_do_action_398
			when 399 then
					--|#line 1800 "eiffel.y"
				yy_do_action_399
			when 400 then
					--|#line 1804 "eiffel.y"
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
					--|#line 1811 "eiffel.y"
				yy_do_action_401
			when 402 then
					--|#line 1819 "eiffel.y"
				yy_do_action_402
			when 403 then
					--|#line 1821 "eiffel.y"
				yy_do_action_403
			when 404 then
					--|#line 1825 "eiffel.y"
				yy_do_action_404
			when 405 then
					--|#line 1827 "eiffel.y"
				yy_do_action_405
			when 406 then
					--|#line 1831 "eiffel.y"
				yy_do_action_406
			when 407 then
					--|#line 1833 "eiffel.y"
				yy_do_action_407
			when 408 then
					--|#line 1835 "eiffel.y"
				yy_do_action_408
			when 409 then
					--|#line 1839 "eiffel.y"
				yy_do_action_409
			when 410 then
					--|#line 1852 "eiffel.y"
				yy_do_action_410
			when 411 then
					--|#line 1856 "eiffel.y"
				yy_do_action_411
			when 412 then
					--|#line 1858 "eiffel.y"
				yy_do_action_412
			when 413 then
					--|#line 1860 "eiffel.y"
				yy_do_action_413
			when 414 then
					--|#line 1864 "eiffel.y"
				yy_do_action_414
			when 415 then
					--|#line 1869 "eiffel.y"
				yy_do_action_415
			when 416 then
					--|#line 1876 "eiffel.y"
				yy_do_action_416
			when 417 then
					--|#line 1878 "eiffel.y"
				yy_do_action_417
			when 418 then
					--|#line 1882 "eiffel.y"
				yy_do_action_418
			when 419 then
					--|#line 1887 "eiffel.y"
				yy_do_action_419
			when 420 then
					--|#line 1898 "eiffel.y"
				yy_do_action_420
			when 421 then
					--|#line 1907 "eiffel.y"
				yy_do_action_421
			when 422 then
					--|#line 1909 "eiffel.y"
				yy_do_action_422
			when 423 then
					--|#line 1911 "eiffel.y"
				yy_do_action_423
			when 424 then
					--|#line 1913 "eiffel.y"
				yy_do_action_424
			when 425 then
					--|#line 1915 "eiffel.y"
				yy_do_action_425
			when 426 then
					--|#line 1917 "eiffel.y"
				yy_do_action_426
			when 427 then
					--|#line 1921 "eiffel.y"
				yy_do_action_427
			when 428 then
					--|#line 1923 "eiffel.y"
				yy_do_action_428
			when 429 then
					--|#line 1925 "eiffel.y"
				yy_do_action_429
			when 430 then
					--|#line 1940 "eiffel.y"
				yy_do_action_430
			when 431 then
					--|#line 1942 "eiffel.y"
				yy_do_action_431
			when 432 then
					--|#line 1944 "eiffel.y"
				yy_do_action_432
			when 433 then
					--|#line 1946 "eiffel.y"
				yy_do_action_433
			when 434 then
					--|#line 1953 "eiffel.y"
				yy_do_action_434
			when 435 then
					--|#line 1955 "eiffel.y"
				yy_do_action_435
			when 436 then
					--|#line 1959 "eiffel.y"
				yy_do_action_436
			when 437 then
					--|#line 1966 "eiffel.y"
				yy_do_action_437
			when 438 then
					--|#line 1981 "eiffel.y"
				yy_do_action_438
			when 439 then
					--|#line 1996 "eiffel.y"
				yy_do_action_439
			when 440 then
					--|#line 2014 "eiffel.y"
				yy_do_action_440
			when 441 then
					--|#line 2016 "eiffel.y"
				yy_do_action_441
			when 442 then
					--|#line 2018 "eiffel.y"
				yy_do_action_442
			when 443 then
					--|#line 2025 "eiffel.y"
				yy_do_action_443
			when 444 then
					--|#line 2029 "eiffel.y"
				yy_do_action_444
			when 445 then
					--|#line 2031 "eiffel.y"
				yy_do_action_445
			when 446 then
					--|#line 2033 "eiffel.y"
				yy_do_action_446
			when 447 then
					--|#line 2037 "eiffel.y"
				yy_do_action_447
			when 448 then
					--|#line 2039 "eiffel.y"
				yy_do_action_448
			when 449 then
					--|#line 2041 "eiffel.y"
				yy_do_action_449
			when 450 then
					--|#line 2043 "eiffel.y"
				yy_do_action_450
			when 451 then
					--|#line 2045 "eiffel.y"
				yy_do_action_451
			when 452 then
					--|#line 2047 "eiffel.y"
				yy_do_action_452
			when 453 then
					--|#line 2049 "eiffel.y"
				yy_do_action_453
			when 454 then
					--|#line 2051 "eiffel.y"
				yy_do_action_454
			when 455 then
					--|#line 2053 "eiffel.y"
				yy_do_action_455
			when 456 then
					--|#line 2055 "eiffel.y"
				yy_do_action_456
			when 457 then
					--|#line 2057 "eiffel.y"
				yy_do_action_457
			when 458 then
					--|#line 2059 "eiffel.y"
				yy_do_action_458
			when 459 then
					--|#line 2061 "eiffel.y"
				yy_do_action_459
			when 460 then
					--|#line 2063 "eiffel.y"
				yy_do_action_460
			when 461 then
					--|#line 2065 "eiffel.y"
				yy_do_action_461
			when 462 then
					--|#line 2067 "eiffel.y"
				yy_do_action_462
			when 463 then
					--|#line 2069 "eiffel.y"
				yy_do_action_463
			when 464 then
					--|#line 2071 "eiffel.y"
				yy_do_action_464
			when 465 then
					--|#line 2073 "eiffel.y"
				yy_do_action_465
			when 466 then
					--|#line 2075 "eiffel.y"
				yy_do_action_466
			when 467 then
					--|#line 2077 "eiffel.y"
				yy_do_action_467
			when 468 then
					--|#line 2081 "eiffel.y"
				yy_do_action_468
			when 469 then
					--|#line 2083 "eiffel.y"
				yy_do_action_469
			when 470 then
					--|#line 2085 "eiffel.y"
				yy_do_action_470
			when 471 then
					--|#line 2087 "eiffel.y"
				yy_do_action_471
			when 472 then
					--|#line 2091 "eiffel.y"
				yy_do_action_472
			when 473 then
					--|#line 2093 "eiffel.y"
				yy_do_action_473
			when 474 then
					--|#line 2095 "eiffel.y"
				yy_do_action_474
			when 475 then
					--|#line 2097 "eiffel.y"
				yy_do_action_475
			when 476 then
					--|#line 2099 "eiffel.y"
				yy_do_action_476
			when 477 then
					--|#line 2101 "eiffel.y"
				yy_do_action_477
			when 478 then
					--|#line 2103 "eiffel.y"
				yy_do_action_478
			when 479 then
					--|#line 2105 "eiffel.y"
				yy_do_action_479
			when 480 then
					--|#line 2107 "eiffel.y"
				yy_do_action_480
			when 481 then
					--|#line 2109 "eiffel.y"
				yy_do_action_481
			when 482 then
					--|#line 2111 "eiffel.y"
				yy_do_action_482
			when 483 then
					--|#line 2113 "eiffel.y"
				yy_do_action_483
			when 484 then
					--|#line 2115 "eiffel.y"
				yy_do_action_484
			when 485 then
					--|#line 2117 "eiffel.y"
				yy_do_action_485
			when 486 then
					--|#line 2119 "eiffel.y"
				yy_do_action_486
			when 487 then
					--|#line 2121 "eiffel.y"
				yy_do_action_487
			when 488 then
					--|#line 2123 "eiffel.y"
				yy_do_action_488
			when 489 then
					--|#line 2125 "eiffel.y"
				yy_do_action_489
			when 490 then
					--|#line 2129 "eiffel.y"
				yy_do_action_490
			when 491 then
					--|#line 2133 "eiffel.y"
				yy_do_action_491
			when 492 then
					--|#line 2137 "eiffel.y"
				yy_do_action_492
			when 493 then
					--|#line 2141 "eiffel.y"
				yy_do_action_493
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
			--|#line 175 "eiffel.y"
		do
--|#line 175 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 175")
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
			--|#line 182 "eiffel.y"
		do
--|#line 182 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 182")
end

			yyval := yyval_default;
				if not type_parser then
					raise_error
				end
				type_node := yytype62 (yyvs.item (yyvsp))
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_3 is
			--|#line 191 "eiffel.y"
		do
--|#line 191 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 191")
end

			yyval := yyval_default;
				root_node := new_class_description (yytype91 (yyvs.item (yyvsp - 13)), yytype59 (yyvs.item (yyvsp - 11)),
					is_deferred, is_expanded, is_separate, is_frozen_class, is_external_class,
					yytype80 (yyvs.item (yyvsp - 16)), yytype80 (yyvs.item (yyvsp - 1)), yytype76 (yyvs.item (yyvsp - 12)), yytype84 (yyvs.item (yyvsp - 9)), yytype68 (yyvs.item (yyvsp - 7)), yytype67 (yyvs.item (yyvsp - 6)), yytype73 (yyvs.item (yyvsp - 5)), yytype41 (yyvs.item (yyvsp - 3)), suppliers, yytype59 (yyvs.item (yyvsp - 10)), click_list
				)

				if real_class_end_position = 0 then
					root_node.set_text_positions (
						current_position.start_position,
						yytype57 (yyvs.item (yyvsp - 4)).start_position,
						yytype57 (yyvs.item (yyvsp - 8)).start_position,
						formal_generics_start_position,
						formal_generics_end_position,
						yytype57 (yyvs.item (yyvsp - 2)).start_position
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
			--|#line 234 "eiffel.y"
		do
--|#line 234 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 234")
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
			--|#line 243 "eiffel.y"
		local
			yyval91: PAIR [ID_AS, CLICK_AST]
		do
--|#line 243 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 243")
end


				if not case_sensitive then
					token_buffer.to_lower
				end
				yyval91 := new_clickable_id (create {ID_AS}.initialize (token_buffer))
			
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_6 is
			--|#line 251 "eiffel.y"
		local
			yyval91: PAIR [ID_AS, CLICK_AST]
		do
--|#line 251 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 251")
end


				if not case_sensitive then
					token_buffer.to_upper
				end
				yyval91 := new_clickable_id (create {ID_AS}.initialize (token_buffer))
			
			yyval := yyval91
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_7 is
			--|#line 263 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 263 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 263")
end



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

	yy_do_action_8 is
			--|#line 265 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 265 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 265")
end


yyval80 := yytype80 (yyvs.item (yyvsp)) 
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_9 is
			--|#line 267 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 267 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 267")
end



			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_10 is
			--|#line 271 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 271 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 271")
end



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

	yy_do_action_11 is
			--|#line 273 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 273 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 273")
end


yyval80 := yytype80 (yyvs.item (yyvsp)) 
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_12 is
			--|#line 275 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 275 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 275")
end


yyval80 := Void 
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_13 is
			--|#line 279 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 279 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 279")
end



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

	yy_do_action_14 is
			--|#line 281 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 281 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 281")
end


yyval80 := yytype80 (yyvs.item (yyvsp - 1)) 
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_15 is
			--|#line 283 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 283 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 283")
end


yyval80 := Void 
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_16 is
			--|#line 287 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 287 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 287")
end


				yyval80 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval80.extend (yytype34 (yyvs.item (yyvsp)))
			
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_17 is
			--|#line 292 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 292 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 292")
end


				yyval80 := yytype80 (yyvs.item (yyvsp - 1))
				yyval80.extend (yytype34 (yyvs.item (yyvsp)))
			
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_18 is
			--|#line 299 "eiffel.y"
		local
			yyval34: INDEX_AS
		do
--|#line 299 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 299")
end


yyval34 := new_index_as (yytype32 (yyvs.item (yyvsp - 2)), yytype65 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval34
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_19 is
			--|#line 303 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 303 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 303")
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
			--|#line 305 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 305 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 305")
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
			--|#line 317 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 317 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 317")
end


				yyval65 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval65.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval65
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_22 is
			--|#line 322 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 322 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 322")
end


				yyval65 := yytype65 (yyvs.item (yyvsp - 2))
				yyval65.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval65
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_23 is
			--|#line 327 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 327 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 327")
end


-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval65 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval65
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_24 is
			--|#line 334 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 334 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 334")
end


yyval7 := yytype32 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_25 is
			--|#line 336 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 336 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 336")
end


yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_26 is
			--|#line 338 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 338 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 338")
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
			--|#line 342 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 342 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 342")
end


				create {CUSTOM_ATTRIBUTE_AS} yyval7.initialize (yytype20 (yyvs.item (yyvsp - 2)), yytype61 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_28 is
			--|#line 352 "eiffel.y"
		do
--|#line 352 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 352")
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
			--|#line 358 "eiffel.y"
		do
--|#line 358 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 358")
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
			--|#line 365 "eiffel.y"
		do
--|#line 365 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 365")
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
			--|#line 371 "eiffel.y"
		do
--|#line 371 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 371")
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
			--|#line 379 "eiffel.y"
		do
--|#line 379 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 379")
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
			--|#line 383 "eiffel.y"
		do
--|#line 383 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 383")
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
			--|#line 394 "eiffel.y"
		do
--|#line 394 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 394")
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
			--|#line 398 "eiffel.y"
		do
--|#line 398 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 398")
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
			--|#line 413 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 413 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 413")
end



			yyval := yyval59
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
			--|#line 415 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 415 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 415")
end


yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_38 is
			--|#line 422 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 422 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 422")
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

	yy_do_action_39 is
			--|#line 424 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 424 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 424")
end


				yyval73 := yytype73 (yyvs.item (yyvsp))
				if yyval73.is_empty then
					yyval73 := Void
				end
			
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_40 is
			--|#line 433 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 433 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 433")
end


				yyval73 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval73, yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_41 is
			--|#line 438 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 438 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 438")
end


				yyval73 := yytype73 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval73, yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_42 is
			--|#line 445 "eiffel.y"
		local
			yyval29: FEATURE_CLAUSE_AS
		do
--|#line 445 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 445")
end


yyval29 := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) 
			yyval := yyval29
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_43 is
			--|#line 447 "eiffel.y"
		local
			yyval29: FEATURE_CLAUSE_AS
		do
--|#line 447 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 447")
end


yyval29 := new_feature_clause_as (yytype15 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval29
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_44 is
			--|#line 451 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 451 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 451")
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
			--|#line 451 "eiffel.y"
		do
--|#line 451 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 451")
end

			yyval := yyval_default;
				inherit_context := False
				fclause_pos := current_position.twin
			

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
			--|#line 460 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 460 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 460")
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
			--|#line 462 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 462 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 462")
end


yyval15 := new_client_as (yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval15
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_48 is
			--|#line 466 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [ID_AS]
		do
--|#line 466 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 466")
end


				yyval77 := new_eiffel_list_id_as (1)
				yyval77.extend (new_none_id_as)
			
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_49 is
			--|#line 471 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [ID_AS]
		do
--|#line 471 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 471")
end


yyval77 := yytype77 (yyvs.item (yyvsp - 1)) 
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_50 is
			--|#line 475 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [ID_AS]
		do
--|#line 475 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 475")
end


				yyval77 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval77.extend (yytype91 (yyvs.item (yyvsp)).first)
				yytype91 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype91 (yyvs.item (yyvsp)).first, Void, False, False, False))
			
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_51 is
			--|#line 481 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [ID_AS]
		do
--|#line 481 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 481")
end


				yyval77 := yytype77 (yyvs.item (yyvsp - 2))
				yyval77.extend (yytype91 (yyvs.item (yyvsp)).first)
				yytype91 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype91 (yyvs.item (yyvsp)).first, Void, False, False, False))
			
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_52 is
			--|#line 489 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_AS]
		do
--|#line 489 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 489")
end


				yyval72 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval72.extend (yytype28 (yyvs.item (yyvsp)))
			
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_53 is
			--|#line 494 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_AS]
		do
--|#line 494 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 494")
end


				yyval72 := yytype72 (yyvs.item (yyvsp - 1))
				yyval72.extend (yytype28 (yyvs.item (yyvsp)))
			
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_54 is
			--|#line 501 "eiffel.y"
		do
--|#line 501 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 501")
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
			--|#line 502 "eiffel.y"
		do
--|#line 502 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 502")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_56 is
			--|#line 505 "eiffel.y"
		local
			yyval28: FEATURE_AS
		do
--|#line 505 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 505")
end


					-- Generate a syntax error when `feature_indexes' is not
					-- Void and it applies to synonyms of the current feature
					-- declaration.
				if (il_parser and feature_indexes /= Void and yytype94 (yyvs.item (yyvsp - 2)).first.count /= 1) then
					raise_error
				end
				yyval28 := new_feature_declaration (yytype94 (yyvs.item (yyvsp - 2)), yytype9 (yyvs.item (yyvsp - 1)), feature_indexes)
				feature_indexes := Void
			
			yyval := yyval28
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_57 is
			--|#line 518 "eiffel.y"
		local
			yyval94: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
--|#line 518 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 518")
end


yyval94 := new_clickable_feature_name_list (yytype92 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_58 is
			--|#line 520 "eiffel.y"
		local
			yyval94: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
--|#line 520 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 520")
end


				yyval94 := yytype94 (yyvs.item (yyvsp - 2))
				yyval94.first.extend (yytype92 (yyvs.item (yyvsp)).first)
			
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_59 is
			--|#line 527 "eiffel.y"
		local
			yyval92: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 527 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 527")
end


yyval92 := yytype92 (yyvs.item (yyvsp)) 
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_60 is
			--|#line 531 "eiffel.y"
		do
--|#line 531 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 531")
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
			--|#line 533 "eiffel.y"
		do
--|#line 533 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 533")
end

			yyval := yyval_default;
is_frozen := True 

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_62 is
			--|#line 537 "eiffel.y"
		local
			yyval92: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 537 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 537")
end


yyval92 := new_clickable_feature_name (yytype91 (yyvs.item (yyvsp))) 
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_63 is
			--|#line 539 "eiffel.y"
		local
			yyval92: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 539 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 539")
end


yyval92 := yytype92 (yyvs.item (yyvsp)) 
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_64 is
			--|#line 541 "eiffel.y"
		local
			yyval92: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 541 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 541")
end


yyval92 := yytype92 (yyvs.item (yyvsp)) 
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_65 is
			--|#line 545 "eiffel.y"
		local
			yyval92: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 545 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 545")
end


yyval92 := new_clickable_infix (yytype93 (yyvs.item (yyvsp))) 
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_66 is
			--|#line 550 "eiffel.y"
		local
			yyval92: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 550 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 550")
end


yyval92 := new_clickable_prefix (yytype93 (yyvs.item (yyvsp))) 
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_67 is
			--|#line 554 "eiffel.y"
		local
			yyval9: BODY_AS
		do
--|#line 554 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 554")
end


yyval9 := new_declaration_body (yytype89 (yyvs.item (yyvsp - 2)), yytype62 (yyvs.item (yyvsp - 1)), yytype16 (yyvs.item (yyvsp))) 
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_68 is
			--|#line 558 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 558 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 558")
end


feature_indexes := yytype80 (yyvs.item (yyvsp)) 
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_69 is
			--|#line 560 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 560 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 560")
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
			--|#line 564 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 564 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 564")
end


				yyval16 := new_constant_as (create {VALUE_AS}.initialize (yytype7 (yyvs.item (yyvsp - 1))))
				feature_indexes := yytype80 (yyvs.item (yyvsp))
			
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_71 is
			--|#line 569 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 569 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 569")
end


				yyval16 := new_constant_as (create {VALUE_AS}.initialize (new_unique_as))
				feature_indexes := yytype80 (yyvs.item (yyvsp))
			
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_72 is
			--|#line 574 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 574 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 574")
end


				yyval16 := yytype55 (yyvs.item (yyvsp))
				feature_indexes := yytype80 (yyvs.item (yyvsp - 1))
			
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
			yyval84: EIFFEL_LIST [PARENT_AS]
		do
--|#line 585 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 585")
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

	yy_do_action_74 is
			--|#line 587 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [PARENT_AS]
		do
--|#line 587 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 587")
end


yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_75 is
			--|#line 589 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [PARENT_AS]
		do
--|#line 589 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 589")
end


yyval84 := new_eiffel_list_parent_as (0) 
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_76 is
			--|#line 593 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [PARENT_AS]
		do
--|#line 593 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 593")
end


				yyval84 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval84.extend (yytype46 (yyvs.item (yyvsp)))
			
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_77 is
			--|#line 598 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [PARENT_AS]
		do
--|#line 598 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 598")
end


				yyval84 := yytype84 (yyvs.item (yyvsp - 1))
				yyval84.extend (yytype46 (yyvs.item (yyvsp)))
			
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_78 is
			--|#line 605 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 605 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 605")
end


				yyval46 := yytype46 (yyvs.item (yyvsp))
				yytype46 (yyvs.item (yyvsp)).set_location (yytype57 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_79 is
			--|#line 610 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 610 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 610")
end


				inherit_context := False
				yyval46 := yytype46 (yyvs.item (yyvsp - 1))
				yytype46 (yyvs.item (yyvsp - 1)).set_location (yytype57 (yyvs.item (yyvsp - 2)))
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_80 is
			--|#line 618 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 618 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 618")
end


				inherit_context := False
				yyval46 := new_parent_clause (yytype91 (yyvs.item (yyvsp - 1)), yytype88 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_81 is
			--|#line 623 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 623 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 623")
end


				inherit_context := False
				yyval46 := new_parent_clause (yytype91 (yyvs.item (yyvsp - 7)), yytype88 (yyvs.item (yyvsp - 6)), yytype85 (yyvs.item (yyvsp - 5)), yytype70 (yyvs.item (yyvsp - 4)), yytype75 (yyvs.item (yyvsp - 3)), yytype75 (yyvs.item (yyvsp - 2)), yytype75 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_82 is
			--|#line 628 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 628 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 628")
end


				inherit_context := False
				yyval46 := new_parent_clause (yytype91 (yyvs.item (yyvsp - 6)), yytype88 (yyvs.item (yyvsp - 5)), Void, yytype70 (yyvs.item (yyvsp - 4)), yytype75 (yyvs.item (yyvsp - 3)), yytype75 (yyvs.item (yyvsp - 2)), yytype75 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_83 is
			--|#line 633 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 633 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 633")
end


				inherit_context := False
				yyval46 := new_parent_clause (yytype91 (yyvs.item (yyvsp - 5)), yytype88 (yyvs.item (yyvsp - 4)), Void, Void, yytype75 (yyvs.item (yyvsp - 3)), yytype75 (yyvs.item (yyvsp - 2)), yytype75 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_84 is
			--|#line 638 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 638 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 638")
end


				inherit_context := False
				yyval46 := new_parent_clause (yytype91 (yyvs.item (yyvsp - 4)), yytype88 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype75 (yyvs.item (yyvsp - 2)), yytype75 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_85 is
			--|#line 643 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 643 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 643")
end


				inherit_context := False
				yyval46 := new_parent_clause (yytype91 (yyvs.item (yyvsp - 3)), yytype88 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype75 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_86 is
			--|#line 648 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 648 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 648")
end


				inherit_context := True
				real_class_end_position := current_position.end_position - 3
				yyval46 := new_parent_clause (yytype91 (yyvs.item (yyvsp - 2)), yytype88 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_87 is
			--|#line 656 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [RENAME_AS]
		do
--|#line 656 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 656")
end



			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_88 is
			--|#line 658 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [RENAME_AS]
		do
--|#line 658 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 658")
end


yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_89 is
			--|#line 662 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [RENAME_AS]
		do
--|#line 662 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 662")
end


				yyval85 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval85.extend (yytype50 (yyvs.item (yyvsp)))
			
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_90 is
			--|#line 667 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [RENAME_AS]
		do
--|#line 667 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 667")
end


				yyval85 := yytype85 (yyvs.item (yyvsp - 2))
				yyval85.extend (yytype50 (yyvs.item (yyvsp)))
			
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_91 is
			--|#line 674 "eiffel.y"
		local
			yyval50: RENAME_AS
		do
--|#line 674 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 674")
end


yyval50 := new_rename_pair (yytype92 (yyvs.item (yyvsp - 2)), yytype92 (yyvs.item (yyvsp))) 
			yyval := yyval50
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_92 is
			--|#line 678 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 678 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 678")
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

	yy_do_action_93 is
			--|#line 680 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 680 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 680")
end


yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_94 is
			--|#line 684 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 684 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 684")
end


				if yytype70 (yyvs.item (yyvsp)).is_empty then
					yyval70 := Void
				else
					yyval70 := yytype70 (yyvs.item (yyvsp))
				end
			
			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_95 is
			--|#line 692 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 692 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 692")
end



			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_96 is
			--|#line 696 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 696 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 696")
end


				yyval70 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				if yytype24 (yyvs.item (yyvsp)) /= Void then
					yyval70.extend (yytype24 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_97 is
			--|#line 703 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 703 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 703")
end


				yyval70 := yytype70 (yyvs.item (yyvsp - 1))
				if yytype24 (yyvs.item (yyvsp)) /= Void then
					yyval70.extend (yytype24 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_98 is
			--|#line 712 "eiffel.y"
		local
			yyval24: EXPORT_ITEM_AS
		do
--|#line 712 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 712")
end


				if yytype30 (yyvs.item (yyvsp - 1)) /= Void then
					yyval24 := new_export_item_as (new_client_as (yytype77 (yyvs.item (yyvsp - 2))), yytype30 (yyvs.item (yyvsp - 1)))
				end
			
			yyval := yyval24
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_99 is
			--|#line 720 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 720 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 720")
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
			--|#line 722 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 722 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 722")
end


yyval30 := new_all_as 
			yyval := yyval30
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_101 is
			--|#line 724 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 724 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 724")
end


yyval30 := new_feature_list_as (yytype75 (yyvs.item (yyvsp))) 
			yyval := yyval30
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_102 is
			--|#line 728 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 728 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 728")
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

	yy_do_action_103 is
			--|#line 730 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 730 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 730")
end


			yyval67 := yytype67 (yyvs.item (yyvsp))
		
			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_104 is
			--|#line 736 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 736 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 736")
end


			yyval67 := new_eiffel_list_convert (Initial_convert_list_size)
			yyval67.extend (yytype17 (yyvs.item (yyvsp)))
		
			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_105 is
			--|#line 741 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 741 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 741")
end


			yyval67 := yytype67 (yyvs.item (yyvsp - 2))
			yyval67.extend (yytype17 (yyvs.item (yyvsp)))
		
			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_106 is
			--|#line 749 "eiffel.y"
		local
			yyval17: CONVERT_FEAT_AS
		do
--|#line 749 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 749")
end


				-- True because this is a conversion feature used as a creation
				-- procedure in current class.
			yyval17 := new_convert_feat_as (True, yytype92 (yyvs.item (yyvsp - 5)).first, yytype88 (yyvs.item (yyvsp - 2)))
		
			yyval := yyval17
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_107 is
			--|#line 755 "eiffel.y"
		local
			yyval17: CONVERT_FEAT_AS
		do
--|#line 755 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 755")
end


				-- False because this is not a conversion feature used as a creation
				-- procedure.
			yyval17 := new_convert_feat_as (False, yytype92 (yyvs.item (yyvsp - 4)).first, yytype88 (yyvs.item (yyvsp - 1)))
		
			yyval := yyval17
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_108 is
			--|#line 763 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 763 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 763")
end


				yyval75 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval75.extend (yytype92 (yyvs.item (yyvsp)).first)
			
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_109 is
			--|#line 768 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 768 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 768")
end


				yyval75 := yytype75 (yyvs.item (yyvsp - 2))
				yyval75.extend (yytype92 (yyvs.item (yyvsp)).first)
			
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_110 is
			--|#line 775 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 775 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 775")
end



			yyval := yyval75
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
			--|#line 777 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 777 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 777")
end


yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_112 is
			--|#line 781 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 781 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 781")
end



			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_113 is
			--|#line 783 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 783 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 783")
end


yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_114 is
			--|#line 787 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 787 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 787")
end



			yyval := yyval75
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
			--|#line 789 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 789 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 789")
end


yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_116 is
			--|#line 793 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 793 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 793")
end



			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_117 is
			--|#line 795 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 795 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 795")
end


yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_118 is
			--|#line 799 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 799 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 799")
end



			yyval := yyval75
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
			--|#line 801 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 801 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 801")
end


yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_120 is
			--|#line 805 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 805 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 805")
end



			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_121 is
			--|#line 807 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 807 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 807")
end


yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_122 is
			--|#line 815 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 815 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 815")
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

	yy_do_action_123 is
			--|#line 817 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 817 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 817")
end


yyval89 := yytype89 (yyvs.item (yyvsp - 1)) 
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_124 is
			--|#line 821 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 821 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 821")
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

	yy_do_action_125 is
			--|#line 823 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 823 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 823")
end


yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_126 is
			--|#line 827 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 827 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 827")
end


				yyval89 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval89.extend (yytype63 (yyvs.item (yyvsp)))
			
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_127 is
			--|#line 832 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 832 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 832")
end


				yyval89 := yytype89 (yyvs.item (yyvsp - 1))
				yyval89.extend (yytype63 (yyvs.item (yyvsp)))
			
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_128 is
			--|#line 839 "eiffel.y"
		local
			yyval63: TYPE_DEC_AS
		do
--|#line 839 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 839")
end


yyval63 := new_type_dec_as (yytype79 (yyvs.item (yyvsp - 5)), yytype62 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 4))) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_129 is
			--|#line 843 "eiffel.y"
		do
--|#line 843 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 843")
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
			--|#line 844 "eiffel.y"
		do
--|#line 844 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 844")
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
			--|#line 853 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 853 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 853")
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

	yy_do_action_132 is
			--|#line 855 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 855 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 855")
end


yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_133 is
			--|#line 859 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 859 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 859")
end


				yyval89 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval89.extend (yytype63 (yyvs.item (yyvsp)))
			
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_134 is
			--|#line 864 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 864 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 864")
end


				yyval89 := yytype89 (yyvs.item (yyvsp - 1))
				yyval89.extend (yytype63 (yyvs.item (yyvsp)))
			
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_135 is
			--|#line 871 "eiffel.y"
		local
			yyval63: TYPE_DEC_AS
		do
--|#line 871 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 871")
end


yyval63 := new_type_dec_as (yytype79 (yyvs.item (yyvsp - 4)), yytype62 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_136 is
			--|#line 875 "eiffel.y"
		local
			yyval79: ARRAYED_LIST [INTEGER]
		do
--|#line 875 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 875")
end


				create yyval79.make (Initial_identifier_list_size)
				Names_heap.put (yytype32 (yyvs.item (yyvsp)))
				yyval79.extend (Names_heap.found_item)
			
			yyval := yyval79
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_137 is
			--|#line 881 "eiffel.y"
		local
			yyval79: ARRAYED_LIST [INTEGER]
		do
--|#line 881 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 881")
end


				yyval79 := yytype79 (yyvs.item (yyvsp - 2))
				Names_heap.put (yytype32 (yyvs.item (yyvsp)))
				yyval79.extend (Names_heap.found_item)
			
			yyval := yyval79
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_138 is
			--|#line 889 "eiffel.y"
		local
			yyval79: ARRAYED_LIST [INTEGER]
		do
--|#line 889 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 889")
end


create yyval79.make (0) 
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

	yy_do_action_139 is
			--|#line 891 "eiffel.y"
		local
			yyval79: ARRAYED_LIST [INTEGER]
		do
--|#line 891 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 891")
end


yyval79 := yytype79 (yyvs.item (yyvsp)) 
			yyval := yyval79
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_140 is
			--|#line 895 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 895 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 895")
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

	yy_do_action_141 is
			--|#line 897 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 897 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 897")
end


yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_142 is
			--|#line 901 "eiffel.y"
		local
			yyval55: ROUTINE_AS
		do
--|#line 901 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 901")
end


yyval55 := new_routine_as (yytype59 (yyvs.item (yyvsp - 7)), yytype51 (yyvs.item (yyvsp - 5)), yytype89 (yyvs.item (yyvsp - 4)), yytype54 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp - 2)), yytype81 (yyvs.item (yyvsp - 1)), fbody_pos, current_position) 
			yyval := yyval55
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_143 is
			--|#line 901 "eiffel.y"
		do
--|#line 901 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 901")
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
			--|#line 913 "eiffel.y"
		local
			yyval54: ROUT_BODY_AS
		do
--|#line 913 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 913")
end


yyval54 := yytype39 (yyvs.item (yyvsp)) 
			yyval := yyval54
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_145 is
			--|#line 915 "eiffel.y"
		local
			yyval54: ROUT_BODY_AS
		do
--|#line 915 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 915")
end


yyval54 := yytype26 (yyvs.item (yyvsp)) 
			yyval := yyval54
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_146 is
			--|#line 917 "eiffel.y"
		local
			yyval54: ROUT_BODY_AS
		do
--|#line 917 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 917")
end


yyval54 := new_deferred_as 
			yyval := yyval54
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_147 is
			--|#line 921 "eiffel.y"
		local
			yyval26: EXTERNAL_AS
		do
--|#line 921 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 921")
end


				yyval26 := new_external_as (yytype27 (yyvs.item (yyvsp - 1)), yytype59 (yyvs.item (yyvsp)))
				has_externals := True
			
			yyval := yyval26
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_148 is
			--|#line 928 "eiffel.y"
		local
			yyval27: EXTERNAL_LANG_AS
		do
--|#line 928 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 928")
end


yyval27 := new_external_lang_as (yytype59 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval27
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_149 is
			--|#line 933 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 933 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 933")
end



			yyval := yyval59
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
			--|#line 935 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 935 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 935")
end


yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_151 is
			--|#line 939 "eiffel.y"
		local
			yyval39: INTERNAL_AS
		do
--|#line 939 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 939")
end


yyval39 := new_do_as (yytype81 (yyvs.item (yyvsp))) 
			yyval := yyval39
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_152 is
			--|#line 941 "eiffel.y"
		local
			yyval39: INTERNAL_AS
		do
--|#line 941 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 941")
end


yyval39 := new_once_as (yytype81 (yyvs.item (yyvsp))) 
			yyval := yyval39
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_153 is
			--|#line 945 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 945 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 945")
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

	yy_do_action_154 is
			--|#line 947 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 947 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 947")
end


yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_155 is
			--|#line 951 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 951 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 951")
end



			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_156 is
			--|#line 953 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 953 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 953")
end


yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_157 is
			--|#line 957 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 957 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 957")
end


				yyval81 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval81.extend (yytype37 (yyvs.item (yyvsp)))
			
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_158 is
			--|#line 962 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 962 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 962")
end


				yyval81 := yytype81 (yyvs.item (yyvsp - 1))
				yyval81.extend (yytype37 (yyvs.item (yyvsp)))
			
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_159 is
			--|#line 969 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 969 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 969")
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
			--|#line 973 "eiffel.y"
		do
--|#line 973 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 973")
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
			--|#line 974 "eiffel.y"
		do
--|#line 974 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 974")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_162 is
			--|#line 977 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 977 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 977")
end


yyval37 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_163 is
			--|#line 979 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 979 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 979")
end


yyval37 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_164 is
			--|#line 981 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 981 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 981")
end


yyval37 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_165 is
			--|#line 983 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 983 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 983")
end


yyval37 := yytype53 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_166 is
			--|#line 985 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 985 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 985")
end


yyval37 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_167 is
			--|#line 987 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 987 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 987")
end


yyval37 := yytype35 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_168 is
			--|#line 989 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 989 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 989")
end


yyval37 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_169 is
			--|#line 991 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 991 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 991")
end


yyval37 := yytype21 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_170 is
			--|#line 993 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 993 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 993")
end


yyval37 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_171 is
			--|#line 995 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 995 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 995")
end


yyval37 := yytype52 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_172 is
			--|#line 999 "eiffel.y"
		local
			yyval51: REQUIRE_AS
		do
--|#line 999 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 999")
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
			--|#line 1001 "eiffel.y"
		local
			yyval51: REQUIRE_AS
		do
--|#line 1001 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1001")
end


				id_level := Normal_level
				yyval51 := new_require_as (yytype87 (yyvs.item (yyvsp)))
			
			yyval := yyval51
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_174 is
			--|#line 1001 "eiffel.y"
		do
--|#line 1001 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1001")
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
			--|#line 1008 "eiffel.y"
		local
			yyval51: REQUIRE_AS
		do
--|#line 1008 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1008")
end


				id_level := Normal_level
				yyval51 := new_require_else_as (yytype87 (yyvs.item (yyvsp)))
			
			yyval := yyval51
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_176 is
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

	yy_do_action_177 is
			--|#line 1017 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1017 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1017")
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
			--|#line 1019 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1019 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1019")
end


				id_level := Normal_level
				yyval23 := new_ensure_as (yytype87 (yyvs.item (yyvsp)))
			
			yyval := yyval23
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_179 is
			--|#line 1019 "eiffel.y"
		do
--|#line 1019 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1019")
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
			--|#line 1026 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1026 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1026")
end


				id_level := Normal_level
				yyval23 := new_ensure_then_as (yytype87 (yyvs.item (yyvsp)))
			
			yyval := yyval23
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_181 is
			--|#line 1026 "eiffel.y"
		do
--|#line 1026 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1026")
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
			--|#line 1035 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1035 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1035")
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

	yy_do_action_183 is
			--|#line 1037 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1037 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1037")
end


				yyval87 := yytype87 (yyvs.item (yyvsp))
				if yyval87.is_empty then
					yyval87 := Void
				end
			
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_184 is
			--|#line 1046 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1046 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1046")
end


				yyval87 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval87, yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_185 is
			--|#line 1051 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1051 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1051")
end


				yyval87 := yytype87 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval87, yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_186 is
			--|#line 1058 "eiffel.y"
		local
			yyval60: TAGGED_AS
		do
--|#line 1058 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1058")
end


yyval60 := yytype60 (yyvs.item (yyvsp - 1)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_187 is
			--|#line 1062 "eiffel.y"
		local
			yyval60: TAGGED_AS
		do
--|#line 1062 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1062")
end


yyval60 := new_tagged_as (Void, yytype25 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_188 is
			--|#line 1064 "eiffel.y"
		local
			yyval60: TAGGED_AS
		do
--|#line 1064 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1064")
end


yyval60 := new_tagged_as (yytype32 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_189 is
			--|#line 1066 "eiffel.y"
		local
			yyval60: TAGGED_AS
		do
--|#line 1066 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1066")
end



			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_190 is
			--|#line 1074 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1074 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1074")
end


yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_191 is
			--|#line 1076 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1076 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1076")
end


yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_192 is
			--|#line 1080 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1080 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1080")
end


yyval62 := new_class_type (yytype91 (yyvs.item (yyvsp - 1)), yytype88 (yyvs.item (yyvsp)), False, True, False) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_193 is
			--|#line 1082 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1082 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1082")
end


yyval62 := new_class_type (yytype91 (yyvs.item (yyvsp - 1)), yytype88 (yyvs.item (yyvsp)), True, False, False) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_194 is
			--|#line 1084 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1084 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1084")
end


yyval62 := new_class_type (yytype91 (yyvs.item (yyvsp - 1)), yytype88 (yyvs.item (yyvsp)), False, False, True) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_195 is
			--|#line 1086 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1086 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1086")
end


yyval62 := new_bits_as (yytype38 (yyvs.item (yyvsp))) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_196 is
			--|#line 1088 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1088 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1088")
end


yyval62 := new_bits_symbol_as (yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_197 is
			--|#line 1090 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1090 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1090")
end


yyval62 := new_like_id_as (yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_198 is
			--|#line 1092 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1092 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1092")
end


yyval62 := new_like_current_as 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_199 is
			--|#line 1096 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1096 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1096")
end


yyval62 := new_class_type (yytype91 (yyvs.item (yyvsp - 1)), yytype88 (yyvs.item (yyvsp)), False, False, False) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_200 is
			--|#line 1100 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TYPE]
		do
--|#line 1100 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1100")
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

	yy_do_action_201 is
			--|#line 1102 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TYPE]
		do
--|#line 1102 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1102")
end



			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_202 is
			--|#line 1104 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TYPE]
		do
--|#line 1104 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1104")
end


yyval88 := yytype88 (yyvs.item (yyvsp - 1)) 
			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_203 is
			--|#line 1108 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TYPE]
		do
--|#line 1108 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1108")
end



			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_204 is
			--|#line 1110 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TYPE]
		do
--|#line 1110 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1110")
end


yyval88 := yytype88 (yyvs.item (yyvsp - 1)) 
			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_205 is
			--|#line 1114 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TYPE]
		do
--|#line 1114 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1114")
end


				yyval88 := new_eiffel_list_type (Initial_type_list_size)
				yyval88.extend (yytype62 (yyvs.item (yyvsp)))
			
			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_206 is
			--|#line 1119 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TYPE]
		do
--|#line 1119 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1119")
end


				yyval88 := yytype88 (yyvs.item (yyvsp - 2))
				yyval88.extend (yytype62 (yyvs.item (yyvsp)))
			
			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_207 is
			--|#line 1130 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1130 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1130")
end


				-- $$ := Void
				formal_generics_start_position := current_position.start_position
				formal_generics_end_position := 0
			
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

	yy_do_action_208 is
			--|#line 1136 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1136 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1136")
end


				yyval76 := yytype76 (yyvs.item (yyvsp - 1))
				formal_generics_start_position := yytype57 (yyvs.item (yyvsp - 3)).start_position
				formal_generics_end_position := current_position.start_position
			
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_209 is
			--|#line 1144 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1144 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1144")
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

	yy_do_action_210 is
			--|#line 1146 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1146 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1146")
end


yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_211 is
			--|#line 1150 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1150 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1150")
end


				yyval76 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval76.extend (yytype31 (yyvs.item (yyvsp)))
			
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_212 is
			--|#line 1155 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1155 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1155")
end


				yyval76 := yytype76 (yyvs.item (yyvsp - 2))
				yyval76.extend (yytype31 (yyvs.item (yyvsp)))
			
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_213 is
			--|#line 1162 "eiffel.y"
		local
			yyval31: FORMAL_DEC_AS
		do
--|#line 1162 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1162")
end


				check formal_exists: not formal_parameters.is_empty end
				yyval31 := new_formal_dec_as (formal_parameters.last, yytype95 (yyvs.item (yyvsp)).first, yytype95 (yyvs.item (yyvsp)).second, formal_parameters.count)
			
			yyval := yyval31
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_214 is
			--|#line 1162 "eiffel.y"
		do
--|#line 1162 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1162")
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
					if not case_sensitive then
						token_buffer.to_upper
					end
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

	yy_do_action_215 is
			--|#line 1187 "eiffel.y"
		local
			yyval95: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
--|#line 1187 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1187")
end


create yyval95 
			yyval := yyval95
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

	yy_do_action_216 is
			--|#line 1189 "eiffel.y"
		local
			yyval95: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
--|#line 1189 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1189")
end


				create yyval95
				yyval95.set_first (yytype62 (yyvs.item (yyvsp - 1)))
				yyval95.set_second (yytype75 (yyvs.item (yyvsp)))
			
			yyval := yyval95
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_217 is
			--|#line 1197 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 1197 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1197")
end



			yyval := yyval75
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

	yy_do_action_218 is
			--|#line 1199 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 1199 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1199")
end


yyval75 := yytype75 (yyvs.item (yyvsp - 1)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_219 is
			--|#line 1207 "eiffel.y"
		local
			yyval33: IF_AS
		do
--|#line 1207 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1207")
end


				yyval33 := new_if_as (yytype25 (yyvs.item (yyvsp - 5)), yytype81 (yyvs.item (yyvsp - 3)), yytype69 (yyvs.item (yyvsp - 2)), yytype81 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 7)), current_position)
			
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_220 is
			--|#line 1213 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1213 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1213")
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

	yy_do_action_221 is
			--|#line 1215 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1215 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1215")
end


yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_222 is
			--|#line 1219 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1219 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1219")
end


				yyval69 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval69.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_223 is
			--|#line 1224 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1224 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1224")
end


				yyval69 := yytype69 (yyvs.item (yyvsp - 1))
				yyval69.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_224 is
			--|#line 1231 "eiffel.y"
		local
			yyval22: ELSIF_AS
		do
--|#line 1231 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1231")
end


yyval22 := new_elseif_as (yytype25 (yyvs.item (yyvsp - 2)), yytype81 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 4))) 
			yyval := yyval22
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_225 is
			--|#line 1235 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1235 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1235")
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

	yy_do_action_226 is
			--|#line 1237 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1237 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1237")
end


yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_227 is
			--|#line 1241 "eiffel.y"
		local
			yyval35: INSPECT_AS
		do
--|#line 1241 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1241")
end


				yyval35 := new_inspect_as (yytype25 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp - 2)), yytype81 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval35
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_228 is
			--|#line 1247 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [CASE_AS]
		do
--|#line 1247 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1247")
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

	yy_do_action_229 is
			--|#line 1249 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [CASE_AS]
		do
--|#line 1249 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1249")
end


yyval66 := yytype66 (yyvs.item (yyvsp)) 
			yyval := yyval66
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_230 is
			--|#line 1253 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [CASE_AS]
		do
--|#line 1253 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1253")
end


				yyval66 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval66.extend (yytype12 (yyvs.item (yyvsp)))
			
			yyval := yyval66
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_231 is
			--|#line 1258 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [CASE_AS]
		do
--|#line 1258 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1258")
end


				yyval66 := yytype66 (yyvs.item (yyvsp - 1))
				yyval66.extend (yytype12 (yyvs.item (yyvsp)))
			
			yyval := yyval66
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_232 is
			--|#line 1265 "eiffel.y"
		local
			yyval12: CASE_AS
		do
--|#line 1265 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1265")
end


yyval12 := new_case_as (yytype82 (yyvs.item (yyvsp - 2)), yytype81 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval12
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_233 is
			--|#line 1269 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line 1269 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1269")
end


				yyval82 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval82.extend (yytype40 (yyvs.item (yyvsp)))
			
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_234 is
			--|#line 1274 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line 1274 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1274")
end


				yyval82 := yytype82 (yyvs.item (yyvsp - 2))
				yyval82.extend (yytype40 (yyvs.item (yyvsp)))
			
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_235 is
			--|#line 1281 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1281 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1281")
end


yyval40 := new_interval_as (yytype38 (yyvs.item (yyvsp)), Void) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_236 is
			--|#line 1283 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1283 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1283")
end


yyval40 := new_interval_as (yytype38 (yyvs.item (yyvsp - 2)), yytype38 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_237 is
			--|#line 1285 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1285 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1285")
end


yyval40 := new_interval_as (yytype13 (yyvs.item (yyvsp)), Void) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_238 is
			--|#line 1287 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1287 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1287")
end


yyval40 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_239 is
			--|#line 1289 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1289 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1289")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp)), Void) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_240 is
			--|#line 1291 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1291 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1291")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_241 is
			--|#line 1293 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1293 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1293")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp - 2)), yytype38 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_242 is
			--|#line 1295 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1295 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1295")
end


yyval40 := new_interval_as (yytype38 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_243 is
			--|#line 1297 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1297 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1297")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_244 is
			--|#line 1299 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1299 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1299")
end


yyval40 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_245 is
			--|#line 1301 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1301 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1301")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp)), Void) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_246 is
			--|#line 1303 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1303 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1303")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_247 is
			--|#line 1305 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1305 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1305")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp - 2)), yytype48 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_248 is
			--|#line 1307 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1307 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1307")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp - 2)), yytype48 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_249 is
			--|#line 1309 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1309 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1309")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp - 2)), yytype38 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_250 is
			--|#line 1311 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1311 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1311")
end


yyval40 := new_interval_as (yytype38 (yyvs.item (yyvsp - 2)), yytype48 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_251 is
			--|#line 1313 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1313 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1313")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_252 is
			--|#line 1315 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1315 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1315")
end


yyval40 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype48 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_253 is
			--|#line 1320 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1320 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1320")
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

	yy_do_action_254 is
			--|#line 1322 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1322 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1322")
end


				yyval81 := yytype81 (yyvs.item (yyvsp))
				if yyval81 = Void then
					yyval81 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_255 is
			--|#line 1331 "eiffel.y"
		local
			yyval42: LOOP_AS
		do
--|#line 1331 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1331")
end


				yyval42 := new_loop_as (yytype81 (yyvs.item (yyvsp - 8)), yytype87 (yyvs.item (yyvsp - 7)), yytype64 (yyvs.item (yyvsp - 6)), yytype25 (yyvs.item (yyvsp - 3)), yytype81 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval42
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 10
	yyvsp := yyvsp - 9
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_256 is
			--|#line 1337 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1337 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1337")
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

	yy_do_action_257 is
			--|#line 1339 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1339 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1339")
end


yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_258 is
			--|#line 1343 "eiffel.y"
		local
			yyval41: INVARIANT_AS
		do
--|#line 1343 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1343")
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

	yy_do_action_259 is
			--|#line 1345 "eiffel.y"
		local
			yyval41: INVARIANT_AS
		do
--|#line 1345 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1345")
end


				id_level := Normal_level
				inherit_context := False
				yyval41 := new_invariant_as (yytype87 (yyvs.item (yyvsp)))
			
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_260 is
			--|#line 1345 "eiffel.y"
		do
--|#line 1345 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1345")
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

	yy_do_action_261 is
			--|#line 1355 "eiffel.y"
		local
			yyval64: VARIANT_AS
		do
--|#line 1355 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1355")
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

	yy_do_action_262 is
			--|#line 1357 "eiffel.y"
		local
			yyval64: VARIANT_AS
		do
--|#line 1357 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1357")
end


yyval64 := new_variant_as (yytype32 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval64
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_263 is
			--|#line 1359 "eiffel.y"
		local
			yyval64: VARIANT_AS
		do
--|#line 1359 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1359")
end


yyval64 := new_variant_as (Void, yytype25 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval64
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_264 is
			--|#line 1363 "eiffel.y"
		local
			yyval21: DEBUG_AS
		do
--|#line 1363 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1363")
end


				yyval21 := new_debug_as (yytype86 (yyvs.item (yyvsp - 2)), yytype81 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval21
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_265 is
			--|#line 1369 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [STRING_AS]
		do
--|#line 1369 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1369")
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

	yy_do_action_266 is
			--|#line 1371 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [STRING_AS]
		do
--|#line 1371 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1371")
end



			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_267 is
			--|#line 1373 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [STRING_AS]
		do
--|#line 1373 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1373")
end


yyval86 := yytype86 (yyvs.item (yyvsp - 1)) 
			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_268 is
			--|#line 1377 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [STRING_AS]
		do
--|#line 1377 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1377")
end


				yyval86 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval86.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_269 is
			--|#line 1382 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [STRING_AS]
		do
--|#line 1382 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1382")
end


				yyval86 := yytype86 (yyvs.item (yyvsp - 2))
				yyval86.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_270 is
			--|#line 1389 "eiffel.y"
		local
			yyval52: RETRY_AS
		do
--|#line 1389 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1389")
end


yyval52 := new_retry_as (current_position) 
			yyval := yyval52
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_271 is
			--|#line 1393 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1393 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1393")
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

	yy_do_action_272 is
			--|#line 1395 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1395 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1395")
end


				yyval81 := yytype81 (yyvs.item (yyvsp))
				if yyval81 = Void then
					yyval81 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_273 is
			--|#line 1404 "eiffel.y"
		local
			yyval6: ASSIGN_AS
		do
--|#line 1404 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1404")
end


yyval6 := new_assign_as (new_access_id_as (yytype32 (yyvs.item (yyvsp - 2)), Void), yytype25 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_274 is
			--|#line 1406 "eiffel.y"
		local
			yyval6: ASSIGN_AS
		do
--|#line 1406 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1406")
end


yyval6 := new_assign_as (new_result_as, yytype25 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_275 is
			--|#line 1410 "eiffel.y"
		local
			yyval53: REVERSE_AS
		do
--|#line 1410 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1410")
end


yyval53 := new_reverse_as (new_access_id_as (yytype32 (yyvs.item (yyvsp - 2)), Void), yytype25 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval53
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_276 is
			--|#line 1412 "eiffel.y"
		local
			yyval53: REVERSE_AS
		do
--|#line 1412 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1412")
end


yyval53 := new_reverse_as (new_result_as, yytype25 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval53
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_277 is
			--|#line 1416 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1416 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1416")
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

	yy_do_action_278 is
			--|#line 1418 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1418 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1418")
end


yyval68 := yytype68 (yyvs.item (yyvsp)) 
			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_279 is
			--|#line 1422 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1422 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1422")
end


				yyval68 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval68.extend (yytype18 (yyvs.item (yyvsp)))
			
			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_280 is
			--|#line 1427 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1427 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1427")
end


				yyval68 := yytype68 (yyvs.item (yyvsp - 1))
				yyval68.extend (yytype18 (yyvs.item (yyvsp)))
			
			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_281 is
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
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_282 is
			--|#line 1440 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1440 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1440")
end


				inherit_context := False
				yyval18 := new_create_as (yytype15 (yyvs.item (yyvsp - 1)), yytype75 (yyvs.item (yyvsp)))
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_283 is
			--|#line 1445 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1445 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1445")
end


				inherit_context := False
				yyval18 := new_create_as (new_client_as (yytype77 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_284 is
			--|#line 1450 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1450 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1450")
end


				inherit_context := False
				yyval18 := new_create_as (Void, Void)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype57 (yyvs.item (yyvsp - 1)).start_position,
						yytype57 (yyvs.item (yyvsp - 1)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_285 is
			--|#line 1460 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1460 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1460")
end


				inherit_context := False
				yyval18 := new_create_as (yytype15 (yyvs.item (yyvsp - 1)), yytype75 (yyvs.item (yyvsp)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype57 (yyvs.item (yyvsp - 3)).start_position,
						yytype57 (yyvs.item (yyvsp - 3)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_286 is
			--|#line 1470 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1470 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1470")
end


				inherit_context := False
				yyval18 := new_create_as (new_client_as (yytype77 (yyvs.item (yyvsp))), Void)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype57 (yyvs.item (yyvsp - 2)).start_position,
						yytype57 (yyvs.item (yyvsp - 2)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_287 is
			--|#line 1482 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1482 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1482")
end


yyval56 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), False) 
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_288 is
			--|#line 1484 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1484 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1484")
end


yyval56 := new_routine_creation_as (yytype45 (yyvs.item (yyvsp - 3)), yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), True) 
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_289 is
			--|#line 1486 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1486 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1486")
end


			yyval56 := yytype58 (yyvs.item (yyvsp)).first
			if has_syntax_warning then
				Error_handler.insert_warning (
					create {SYNTAX_WARNING}.make (yytype58 (yyvs.item (yyvsp)).second.start_position,
					yytype58 (yyvs.item (yyvsp)).second.end_position, filename, 0, "Use keyword `agent' instead."))
			end
		
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_290 is
			--|#line 1504 "eiffel.y"
		local
			yyval58: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1504 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1504")
end


yyval58 := new_old_routine_creation_as (yytype57 (yyvs.item (yyvsp - 2)), new_operand_as (Void, Void, Void), yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), False) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_291 is
			--|#line 1506 "eiffel.y"
		local
			yyval58: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1506 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1506")
end


yyval58 := new_old_routine_creation_as (yytype57 (yyvs.item (yyvsp - 2)), new_operand_as (Void, yytype32 (yyvs.item (yyvsp - 4)), Void), yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), True) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_292 is
			--|#line 1508 "eiffel.y"
		local
			yyval58: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1508 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1508")
end


yyval58 := new_old_routine_creation_as (yytype57 (yyvs.item (yyvsp - 2)), new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp - 5))), yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), True) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_293 is
			--|#line 1510 "eiffel.y"
		local
			yyval58: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1510 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1510")
end


yyval58 := new_old_routine_creation_as (yytype57 (yyvs.item (yyvsp - 2)), new_result_operand_as, yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), True) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_294 is
			--|#line 1512 "eiffel.y"
		local
			yyval58: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1512 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1512")
end


yyval58 := new_old_routine_creation_as (yytype57 (yyvs.item (yyvsp - 2)), new_operand_as (Void, Void, Void), yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), True) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_295 is
			--|#line 1514 "eiffel.y"
		local
			yyval58: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1514 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1514")
end


yyval58 := new_old_routine_creation_as (yytype57 (yyvs.item (yyvsp - 2)), new_operand_as (yytype62 (yyvs.item (yyvsp - 4)), Void, Void), yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), True) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_296 is
			--|#line 1516 "eiffel.y"
		local
			yyval58: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1516 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1516")
end


yyval58 := new_old_routine_creation_as (yytype57 (yyvs.item (yyvsp - 2)), Void, yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), True) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_297 is
			--|#line 1520 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1520 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1520")
end


yyval45 := new_operand_as (Void, yytype32 (yyvs.item (yyvsp)), Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_298 is
			--|#line 1522 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1522 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1522")
end


yyval45 := new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_299 is
			--|#line 1524 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1524 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1524")
end


yyval45 := new_result_operand_as 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_300 is
			--|#line 1526 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1526 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1526")
end


yyval45 := new_operand_as (Void, Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_301 is
			--|#line 1528 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1528 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1528")
end


yyval45 := new_operand_as (yytype62 (yyvs.item (yyvsp - 1)), Void, Void)
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_302 is
			--|#line 1530 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1530 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1530")
end


yyval45 := Void 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_303 is
			--|#line 1534 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1534 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1534")
end



			yyval := yyval83
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

	yy_do_action_304 is
			--|#line 1536 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1536 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1536")
end



			yyval := yyval83
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_305 is
			--|#line 1538 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1538 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1538")
end


yyval83 := yytype83 (yyvs.item (yyvsp - 1)) 
			yyval := yyval83
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_306 is
			--|#line 1542 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1542 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1542")
end


				yyval83 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval83.extend (yytype45 (yyvs.item (yyvsp)))
			
			yyval := yyval83
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_307 is
			--|#line 1547 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1547 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1547")
end


				yyval83 := yytype83 (yyvs.item (yyvsp - 2))
				yyval83.extend (yytype45 (yyvs.item (yyvsp)))
			
			yyval := yyval83
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_308 is
			--|#line 1554 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1554 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1554")
end


yyval45 := new_operand_as (Void, Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_309 is
			--|#line 1560 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1560 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1560")
end


yyval45 := new_operand_as (new_class_type (yytype91 (yyvs.item (yyvsp - 1)), Void, False, False, False), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_310 is
			--|#line 1562 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1562 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1562")
end


yyval45 := new_operand_as (new_class_type (yytype91 (yyvs.item (yyvsp - 2)), yytype88 (yyvs.item (yyvsp - 1)), False, False, False), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_311 is
			--|#line 1564 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1564 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1564")
end


yyval45 := new_operand_as (new_class_type (yytype91 (yyvs.item (yyvsp - 2)), yytype88 (yyvs.item (yyvsp - 1)), True, False, False), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_312 is
			--|#line 1566 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1566 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1566")
end


yyval45 := new_operand_as (new_class_type (yytype91 (yyvs.item (yyvsp - 2)), yytype88 (yyvs.item (yyvsp - 1)), False, True, False), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_313 is
			--|#line 1568 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1568 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1568")
end


yyval45 := new_operand_as (new_class_type (yytype91 (yyvs.item (yyvsp - 2)), yytype88 (yyvs.item (yyvsp - 1)), False, False, True), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_314 is
			--|#line 1570 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1570 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1570")
end


yyval45 := new_operand_as (new_bits_as (yytype38 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_315 is
			--|#line 1572 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1572 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1572")
end


yyval45 := new_operand_as (new_bits_symbol_as (yytype32 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_316 is
			--|#line 1574 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1574 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1574")
end


yyval45 := new_operand_as (new_like_id_as (yytype32 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_317 is
			--|#line 1576 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1576 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1576")
end


yyval45 := new_operand_as (new_like_current_as, Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_318 is
			--|#line 1578 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1578 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1578")
end


yyval45 := new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_319 is
			--|#line 1582 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1582 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1582")
end


				yyval19 := new_creation_as (yytype62 (yyvs.item (yyvsp - 3)), yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 5)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype57 (yyvs.item (yyvsp - 5)).start_position,
						yytype57 (yyvs.item (yyvsp - 5)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_320 is
			--|#line 1591 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1591 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1591")
end


yyval19 := new_creation_as (Void, yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_321 is
			--|#line 1593 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1593 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1593")
end


yyval19 := new_creation_as (yytype62 (yyvs.item (yyvsp - 3)), yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 6))) 
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_322 is
			--|#line 1597 "eiffel.y"
		local
			yyval20: CREATION_EXPR_AS
		do
--|#line 1597 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1597")
end


yyval20 := new_creation_expr_as (yytype62 (yyvs.item (yyvsp - 3)), yytype4 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval20
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_323 is
			--|#line 1599 "eiffel.y"
		local
			yyval20: CREATION_EXPR_AS
		do
--|#line 1599 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1599")
end


				yyval20 := new_creation_expr_as (yytype62 (yyvs.item (yyvsp - 3)), yytype4 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1)))
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yytype57 (yyvs.item (yyvsp - 1)).start_position,
						yytype57 (yyvs.item (yyvsp - 1)).end_position, filename, 0, "Use keyword `create' instead."))
				end
			
			yyval := yyval20
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_324 is
			--|#line 1610 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1610 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1610")
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

	yy_do_action_325 is
			--|#line 1612 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1612 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1612")
end


yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_326 is
			--|#line 1616 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1616 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1616")
end


yyval2 := new_access_id_as (yytype32 (yyvs.item (yyvsp)), Void) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_327 is
			--|#line 1618 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1618 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1618")
end


yyval2 := new_result_as 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_328 is
			--|#line 1622 "eiffel.y"
		local
			yyval4: ACCESS_INV_AS
		do
--|#line 1622 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1622")
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

	yy_do_action_329 is
			--|#line 1624 "eiffel.y"
		local
			yyval4: ACCESS_INV_AS
		do
--|#line 1624 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1624")
end


yyval4 := new_access_inv_as (yytype32 (yyvs.item (yyvsp - 1)), yytype71 (yyvs.item (yyvsp))) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_330 is
			--|#line 1632 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1632 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1632")
end


yyval36 := new_instr_call_as (yytype2 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_331 is
			--|#line 1634 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1634 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1634")
end


yyval36 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_332 is
			--|#line 1636 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1636 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1636")
end


yyval36 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_333 is
			--|#line 1638 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1638 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1638")
end


yyval36 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_334 is
			--|#line 1640 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1640 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1640")
end


yyval36 := new_instr_call_as (yytype44 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_335 is
			--|#line 1642 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1642 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1642")
end


yyval36 := new_instr_call_as (yytype47 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_336 is
			--|#line 1644 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1644 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1644")
end


yyval36 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_337 is
			--|#line 1646 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1646 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1646")
end


yyval36 := new_instr_call_as (yytype48 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_338 is
			--|#line 1648 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1648 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1648")
end


yyval36 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_339 is
			--|#line 1652 "eiffel.y"
		local
			yyval14: CHECK_AS
		do
--|#line 1652 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1652")
end


yyval14 := new_check_as (yytype87 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 3)), current_position) 
			yyval := yyval14
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_340 is
			--|#line 1660 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1660 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1660")
end


create {VALUE_AS} yyval25.initialize (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_341 is
			--|#line 1662 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1662 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1662")
end


create {VOID_AS} yyval25 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_342 is
			--|#line 1664 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1664 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1664")
end


create {VALUE_AS} yyval25.initialize (yytype5 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_343 is
			--|#line 1666 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1666 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1666")
end


create {VALUE_AS} yyval25.initialize (yytype61 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_344 is
			--|#line 1668 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1668 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1668")
end


yyval25 := new_expr_call_as (yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_345 is
			--|#line 1670 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1670 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1670")
end


yyval25 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_346 is
			--|#line 1672 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1672 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1672")
end


yyval25 := new_paran_as (yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_347 is
			--|#line 1674 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1674 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1674")
end


yyval25 := new_bin_plus_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_348 is
			--|#line 1676 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1676 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1676")
end


yyval25 := new_bin_minus_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_349 is
			--|#line 1678 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1678 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1678")
end


yyval25 := new_bin_star_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_350 is
			--|#line 1680 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1680 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1680")
end


yyval25 := new_bin_slash_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_351 is
			--|#line 1682 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1682 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1682")
end


yyval25 := new_bin_mod_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_352 is
			--|#line 1684 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1684 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1684")
end


yyval25 := new_bin_div_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_353 is
			--|#line 1686 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1686 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1686")
end


yyval25 := new_bin_power_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_354 is
			--|#line 1688 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1688 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1688")
end


yyval25 := new_bin_and_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_355 is
			--|#line 1690 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1690 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1690")
end


yyval25 := new_bin_and_then_as (yytype25 (yyvs.item (yyvsp - 3)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_356 is
			--|#line 1692 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1692 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1692")
end


yyval25 := new_bin_or_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_357 is
			--|#line 1694 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1694 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1694")
end


yyval25 := new_bin_or_else_as (yytype25 (yyvs.item (yyvsp - 3)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_358 is
			--|#line 1696 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1696 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1696")
end


yyval25 := new_bin_implies_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_359 is
			--|#line 1698 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1698 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1698")
end


yyval25 := new_bin_xor_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_360 is
			--|#line 1700 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1700 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1700")
end


yyval25 := new_bin_ge_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_361 is
			--|#line 1702 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1702 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1702")
end


yyval25 := new_bin_gt_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_362 is
			--|#line 1704 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1704 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1704")
end


yyval25 := new_bin_le_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_363 is
			--|#line 1706 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1706 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1706")
end


yyval25 := new_bin_lt_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_364 is
			--|#line 1708 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1708 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1708")
end


yyval25 := new_bin_eq_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_365 is
			--|#line 1710 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1710 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1710")
end


yyval25 := new_bin_ne_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_366 is
			--|#line 1712 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1712 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1712")
end


yyval25 := new_bin_free_as (yytype25 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp - 1)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_367 is
			--|#line 1714 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1714 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1714")
end


yyval25 := new_un_minus_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_368 is
			--|#line 1716 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1716 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1716")
end


yyval25 := new_un_plus_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_369 is
			--|#line 1718 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1718 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1718")
end


yyval25 := new_un_not_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_370 is
			--|#line 1720 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1720 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1720")
end


yyval25 := new_un_old_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_371 is
			--|#line 1722 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1722 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1722")
end


yyval25 := new_un_free_as (yytype32 (yyvs.item (yyvsp - 1)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_372 is
			--|#line 1724 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1724 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1724")
end


yyval25 := new_un_strip_as (yytype79 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_373 is
			--|#line 1726 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1726 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1726")
end


yyval25 := new_address_as (yytype92 (yyvs.item (yyvsp)).first) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_374 is
			--|#line 1728 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1728 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1728")
end


yyval25 := new_expr_address_as (yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_375 is
			--|#line 1730 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1730 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1730")
end


yyval25 := new_address_current_as 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_376 is
			--|#line 1732 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1732 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1732")
end


yyval25 := new_address_result_as 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_377 is
			--|#line 1736 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 1736 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1736")
end


create yyval32.initialize (token_buffer) 
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_378 is
			--|#line 1744 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1744 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1744")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_379 is
			--|#line 1746 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1746 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1746")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_380 is
			--|#line 1748 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1748 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1748")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_381 is
			--|#line 1750 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1750 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1750")
end


yyval11 := new_current_as 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_382 is
			--|#line 1752 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1752 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1752")
end


yyval11 := new_result_as 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_383 is
			--|#line 1754 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1754 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1754")
end


yyval11 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_384 is
			--|#line 1756 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1756 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1756")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_385 is
			--|#line 1758 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1758 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1758")
end


yyval11 := yytype47 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_386 is
			--|#line 1760 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1760 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1760")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_387 is
			--|#line 1762 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1762 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1762")
end


yyval11 := yytype48 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_388 is
			--|#line 1764 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1764 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1764")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_389 is
			--|#line 1766 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1766 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1766")
end


yyval11 := yytype20 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_390 is
			--|#line 1770 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1770 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1770")
end


yyval43 := new_nested_as (new_current_as, yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_391 is
			--|#line 1774 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1774 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1774")
end


yyval43 := new_nested_as (new_result_as, yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_392 is
			--|#line 1778 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1778 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1778")
end


yyval43 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_393 is
			--|#line 1782 "eiffel.y"
		local
			yyval44: NESTED_EXPR_AS
		do
--|#line 1782 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1782")
end


yyval44 := new_nested_expr_as (yytype25 (yyvs.item (yyvsp - 3)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_394 is
			--|#line 1786 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1786 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1786")
end


yyval43 := new_nested_as (yytype47 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_395 is
			--|#line 1790 "eiffel.y"
		local
			yyval47: PRECURSOR_AS
		do
--|#line 1790 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1790")
end


yyval47 := new_precursor_as (Void, yytype71 (yyvs.item (yyvsp))) 
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_396 is
			--|#line 1792 "eiffel.y"
		local
			yyval47: PRECURSOR_AS
		do
--|#line 1792 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1792")
end


yyval47 := new_precursor (yytype91 (yyvs.item (yyvsp - 2)), yytype71 (yyvs.item (yyvsp)), Void) 
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_397 is
			--|#line 1794 "eiffel.y"
		local
			yyval47: PRECURSOR_AS
		do
--|#line 1794 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1794")
end


yyval47 := new_precursor (yytype91 (yyvs.item (yyvsp - 5)), yytype71 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 2))) 
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_398 is
			--|#line 1796 "eiffel.y"
		local
			yyval47: PRECURSOR_AS
		do
--|#line 1796 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1796")
end


yyval47 := new_precursor (yytype91 (yyvs.item (yyvsp - 4)), yytype71 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 2))) 
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_399 is
			--|#line 1800 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1800 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1800")
end


yyval43 := new_nested_as (yytype48 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_400 is
			--|#line 1804 "eiffel.y"
		local
			yyval48: STATIC_ACCESS_AS
		do
--|#line 1804 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1804")
end


				yyval48 := new_static_access_as (yytype62 (yyvs.item (yyvsp - 4)), yytype32 (yyvs.item (yyvsp - 1)), yytype71 (yyvs.item (yyvsp)));
			
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_401 is
			--|#line 1811 "eiffel.y"
		local
			yyval48: STATIC_ACCESS_AS
		do
--|#line 1811 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1811")
end


				yyval48 := new_static_access_as (yytype62 (yyvs.item (yyvsp - 3)), yytype32 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_402 is
			--|#line 1819 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1819 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1819")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_403 is
			--|#line 1821 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1821 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1821")
end


yyval11 := yytype3 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_404 is
			--|#line 1825 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1825 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1825")
end


yyval43 := new_nested_as (yytype3 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_405 is
			--|#line 1827 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1827 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1827")
end


yyval43 := new_nested_as (yytype3 (yyvs.item (yyvsp - 2)), yytype43 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_406 is
			--|#line 1831 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 1831 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1831")
end


yyval32 := yytype32 (yyvs.item (yyvsp))
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_407 is
			--|#line 1833 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 1833 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1833")
end


yyval32 := yytype92 (yyvs.item (yyvsp)).first.internal_name 
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_408 is
			--|#line 1835 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 1835 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1835")
end


yyval32 := yytype92 (yyvs.item (yyvsp)).first.internal_name 
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_409 is
			--|#line 1839 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1839 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1839")
end


				inspect id_level
				when Normal_level then
					yyval2 := new_access_id_as (yytype32 (yyvs.item (yyvsp - 1)), yytype71 (yyvs.item (yyvsp)))
				when Assert_level then
					yyval2 := new_access_assert_as (yytype32 (yyvs.item (yyvsp - 1)), yytype71 (yyvs.item (yyvsp)))
				when Invariant_level then
					yyval2 := new_access_inv_as (yytype32 (yyvs.item (yyvsp - 1)), yytype71 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_410 is
			--|#line 1852 "eiffel.y"
		local
			yyval3: ACCESS_FEAT_AS
		do
--|#line 1852 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1852")
end


yyval3 := new_access_feat_as (yytype32 (yyvs.item (yyvsp - 1)), yytype71 (yyvs.item (yyvsp))) 
			yyval := yyval3
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_411 is
			--|#line 1856 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1856 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1856")
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

	yy_do_action_412 is
			--|#line 1858 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1858 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1858")
end



			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_413 is
			--|#line 1860 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1860 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1860")
end


yyval71 := yytype71 (yyvs.item (yyvsp - 1)) 
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_414 is
			--|#line 1864 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1864 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1864")
end


				yyval71 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval71.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_415 is
			--|#line 1869 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1869 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1869")
end


				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_416 is
			--|#line 1876 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1876 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1876")
end


yyval71 := new_eiffel_list_expr_as (0) 
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

	yy_do_action_417 is
			--|#line 1878 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1878 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1878")
end


yyval71 := yytype71 (yyvs.item (yyvsp)) 
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_418 is
			--|#line 1882 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1882 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1882")
end


				yyval71 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval71.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_419 is
			--|#line 1887 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1887 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1887")
end


				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_420 is
			--|#line 1898 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 1898 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1898")
end


				if not case_sensitive then
					token_buffer.to_lower
				end
				create yyval32.initialize (token_buffer)
			
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_421 is
			--|#line 1907 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1907 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1907")
end


yyval7 := yytype10 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_422 is
			--|#line 1909 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1909 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1909")
end


yyval7 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_423 is
			--|#line 1911 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1911 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1911")
end


yyval7 := yytype38 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_424 is
			--|#line 1913 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1913 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1913")
end


yyval7 := yytype49 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_425 is
			--|#line 1915 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1915 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1915")
end


yyval7 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_426 is
			--|#line 1917 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1917 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1917")
end


yyval7 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_427 is
			--|#line 1921 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1921 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1921")
end


yyval7 := yytype10 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_428 is
			--|#line 1923 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1923 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1923")
end


yyval7 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_429 is
			--|#line 1925 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1925 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1925")
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

	yy_do_action_430 is
			--|#line 1940 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1940 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1940")
end


yyval7 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_431 is
			--|#line 1942 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1942 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1942")
end


yyval7 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_432 is
			--|#line 1944 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1944 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1944")
end


yyval7 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_433 is
			--|#line 1946 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1946 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1946")
end


				yytype59 (yyvs.item (yyvsp)).set_is_once_string (True)
				yyval7 := yytype59 (yyvs.item (yyvsp))
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_434 is
			--|#line 1953 "eiffel.y"
		local
			yyval10: BOOL_AS
		do
--|#line 1953 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1953")
end


yyval10 := new_boolean_as (False) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_435 is
			--|#line 1955 "eiffel.y"
		local
			yyval10: BOOL_AS
		do
--|#line 1955 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1955")
end


yyval10 := new_boolean_as (True) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_436 is
			--|#line 1959 "eiffel.y"
		local
			yyval13: CHAR_AS
		do
--|#line 1959 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1959")
end


				check is_character: not token_buffer.is_empty end
				yyval13 := new_character_as (token_buffer.item (1))
			
			yyval := yyval13
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_437 is
			--|#line 1966 "eiffel.y"
		local
			yyval38: INTEGER_CONSTANT
		do
--|#line 1966 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1966")
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

	yy_do_action_438 is
			--|#line 1981 "eiffel.y"
		local
			yyval38: INTEGER_CONSTANT
		do
--|#line 1981 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1981")
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

	yy_do_action_439 is
			--|#line 1996 "eiffel.y"
		local
			yyval38: INTEGER_CONSTANT
		do
--|#line 1996 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1996")
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

	yy_do_action_440 is
			--|#line 2014 "eiffel.y"
		local
			yyval49: REAL_AS
		do
--|#line 2014 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2014")
end


yyval49 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval49
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_441 is
			--|#line 2016 "eiffel.y"
		local
			yyval49: REAL_AS
		do
--|#line 2016 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2016")
end


yyval49 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval49
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_442 is
			--|#line 2018 "eiffel.y"
		local
			yyval49: REAL_AS
		do
--|#line 2018 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2018")
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

	yy_do_action_443 is
			--|#line 2025 "eiffel.y"
		local
			yyval8: BIT_CONST_AS
		do
--|#line 2025 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2025")
end


yyval8 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval8
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_444 is
			--|#line 2029 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2029 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2029")
end


yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_445 is
			--|#line 2031 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2031 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2031")
end


yyval59 := new_empty_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_446 is
			--|#line 2033 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2033 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2033")
end


yyval59 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_447 is
			--|#line 2037 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2037 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2037")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_448 is
			--|#line 2039 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2039 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2039")
end


yyval59 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_449 is
			--|#line 2041 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2041 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2041")
end


yyval59 := new_lt_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_450 is
			--|#line 2043 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2043 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2043")
end


yyval59 := new_le_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_451 is
			--|#line 2045 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2045 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2045")
end


yyval59 := new_gt_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_452 is
			--|#line 2047 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2047 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2047")
end


yyval59 := new_ge_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_453 is
			--|#line 2049 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2049 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2049")
end


yyval59 := new_minus_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_454 is
			--|#line 2051 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2051 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2051")
end


yyval59 := new_plus_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_455 is
			--|#line 2053 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2053 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2053")
end


yyval59 := new_star_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_456 is
			--|#line 2055 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2055 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2055")
end


yyval59 := new_slash_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_457 is
			--|#line 2057 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2057 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2057")
end


yyval59 := new_mod_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_458 is
			--|#line 2059 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2059 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2059")
end


yyval59 := new_div_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_459 is
			--|#line 2061 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2061 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2061")
end


yyval59 := new_power_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_460 is
			--|#line 2063 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2063 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2063")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_461 is
			--|#line 2065 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2065 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2065")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_462 is
			--|#line 2067 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2067 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2067")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_463 is
			--|#line 2069 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2069 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2069")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_464 is
			--|#line 2071 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2071 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2071")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_465 is
			--|#line 2073 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2073 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2073")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_466 is
			--|#line 2075 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2075 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2075")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_467 is
			--|#line 2077 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2077 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2077")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_468 is
			--|#line 2081 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2081 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2081")
end


yyval93 := new_clickable_string (new_minus_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_469 is
			--|#line 2083 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2083 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2083")
end


yyval93 := new_clickable_string (new_plus_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_470 is
			--|#line 2085 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2085 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2085")
end


yyval93 := new_clickable_string (new_not_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_471 is
			--|#line 2087 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2087 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2087")
end


yyval93 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_472 is
			--|#line 2091 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2091 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2091")
end


yyval93 := new_clickable_string (new_lt_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_473 is
			--|#line 2093 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2093 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2093")
end


yyval93 := new_clickable_string (new_le_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_474 is
			--|#line 2095 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2095 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2095")
end


yyval93 := new_clickable_string (new_gt_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_475 is
			--|#line 2097 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2097 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2097")
end


yyval93 := new_clickable_string (new_ge_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_476 is
			--|#line 2099 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2099 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2099")
end


yyval93 := new_clickable_string (new_minus_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_477 is
			--|#line 2101 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2101 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2101")
end


yyval93 := new_clickable_string (new_plus_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_478 is
			--|#line 2103 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2103 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2103")
end


yyval93 := new_clickable_string (new_star_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_479 is
			--|#line 2105 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2105 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2105")
end


yyval93 := new_clickable_string (new_slash_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_480 is
			--|#line 2107 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2107 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2107")
end


yyval93 := new_clickable_string (new_mod_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_481 is
			--|#line 2109 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2109 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2109")
end


yyval93 := new_clickable_string (new_div_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_482 is
			--|#line 2111 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2111 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2111")
end


yyval93 := new_clickable_string (new_power_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_483 is
			--|#line 2113 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2113 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2113")
end


yyval93 := new_clickable_string (new_and_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_484 is
			--|#line 2115 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2115 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2115")
end


yyval93 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_485 is
			--|#line 2117 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2117 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2117")
end


yyval93 := new_clickable_string (new_implies_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_486 is
			--|#line 2119 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2119 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2119")
end


yyval93 := new_clickable_string (new_or_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_487 is
			--|#line 2121 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2121 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2121")
end


yyval93 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_488 is
			--|#line 2123 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2123 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2123")
end


yyval93 := new_clickable_string (new_xor_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_489 is
			--|#line 2125 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2125 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2125")
end


yyval93 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_490 is
			--|#line 2129 "eiffel.y"
		local
			yyval5: ARRAY_AS
		do
--|#line 2129 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2129")
end


yyval5 := new_array_as (yytype71 (yyvs.item (yyvsp - 1))) 
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_491 is
			--|#line 2133 "eiffel.y"
		local
			yyval61: TUPLE_AS
		do
--|#line 2133 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2133")
end


yyval61 := new_tuple_as (yytype71 (yyvs.item (yyvsp - 1))) 
			yyval := yyval61
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_492 is
			--|#line 2137 "eiffel.y"
		do
--|#line 2137 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2137")
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

	yy_do_action_493 is
			--|#line 2141 "eiffel.y"
		local
			yyval57: TOKEN_LOCATION
		do
--|#line 2141 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2141")
end


yyval57 := current_position.twin 
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
			when 806 then
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
			    0,  294,  294,  295,  297,  284,  283,  253,  253,  253,
			  255,  255,  255,  256,  256,  256,  254,  254,  171,  167,
			  167,  219,  219,  219,  136,  136,  136,  136,  296,  296,
			  296,  296,  299,  299,  300,  300,  204,  204,  236,  236,
			  237,  237,  163,  163,  148,  301,  147,  147,  249,  249,
			  250,  250,  235,  235,  298,  298,  162,  291,  291,  288,
			  303,  303,  287,  287,  287,  285,  286,  140,  149,  149,
			  150,  150,  150,  265,  265,  265,  266,  266,  190,  190,
			  191,  191,  191,  191,  191,  191,  191,  267,  267,  268,
			  268,  196,  229,  229,  228,  228,  230,  230,  158,  164,

			  164,  164,  223,  223,  222,  222,  151,  151,  238,  238,
			  240,  240,  239,  239,  242,  242,  241,  241,  244,  244,
			  243,  243,  277,  277,  278,  278,  279,  279,  216,  304,
			  304,  281,  281,  282,  282,  217,  251,  251,  252,  252,
			  212,  212,  201,  305,  200,  200,  200,  160,  161,  206,
			  206,  177,  177,  280,  280,  258,  258,  259,  259,  174,
			  302,  302,  175,  175,  175,  175,  175,  175,  175,  175,
			  175,  175,  197,  197,  307,  197,  308,  157,  157,  309,
			  157,  310,  271,  271,  272,  272,  208,  209,  209,  209,
			  211,  211,  215,  215,  215,  215,  215,  215,  215,  213,

			  275,  275,  275,  274,  274,  276,  276,  246,  246,  247,
			  247,  248,  248,  165,  311,  292,  292,  245,  245,  170,
			  226,  226,  227,  227,  156,  260,  260,  172,  220,  220,
			  221,  221,  144,  262,  262,  178,  178,  178,  178,  178,
			  178,  178,  178,  178,  178,  178,  178,  178,  178,  178,
			  178,  178,  178,  261,  261,  180,  273,  273,  179,  179,
			  312,  218,  218,  218,  155,  269,  269,  269,  270,  270,
			  198,  257,  257,  135,  135,  199,  199,  224,  224,  225,
			  225,  152,  152,  152,  152,  152,  152,  202,  202,  202,
			  203,  203,  203,  203,  203,  203,  203,  189,  189,  189,

			  189,  189,  189,  263,  263,  263,  264,  264,  188,  188,
			  188,  188,  188,  188,  188,  188,  188,  188,  188,  153,
			  153,  153,  154,  154,  214,  214,  130,  130,  133,  133,
			  173,  173,  173,  173,  173,  173,  173,  173,  173,  146,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  168,  143,  143,
			  143,  143,  143,  143,  143,  143,  143,  143,  143,  143,
			  185,  184,  183,  187,  182,  192,  192,  192,  192,  186,

			  193,  194,  142,  142,  181,  181,  169,  169,  169,  131,
			  132,  231,  231,  231,  232,  232,  233,  233,  234,  234,
			  166,  137,  137,  137,  137,  137,  137,  138,  138,  138,
			  138,  138,  138,  138,  141,  141,  145,  176,  176,  176,
			  195,  195,  195,  139,  205,  205,  205,  207,  207,  207,
			  207,  207,  207,  207,  207,  207,  207,  207,  207,  207,
			  207,  207,  207,  207,  207,  207,  207,  207,  290,  290,
			  290,  290,  289,  289,  289,  289,  289,  289,  289,  289,
			  289,  289,  289,  289,  289,  289,  289,  289,  289,  289,
			  134,  210,  306,  293>>)
		end

	yytypes1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,    1,    1,   32,   80,    1,   34,   80,   57,    1,
			    1,    1,    1,    1,    1,   62,   62,   62,   91,    1,
			    1,    1,    1,   34,   32,   32,   91,   91,    1,   32,
			   91,    1,    1,    1,   32,   38,    1,   88,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    7,    7,
			    8,   10,   13,   20,   32,   38,   49,   59,   59,   65,
			   88,   88,   88,    1,    1,    1,   62,   88,   91,    1,

			    1,    1,   62,    1,    1,    1,    1,   61,    1,    1,
			    1,    1,    1,   76,   57,   62,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    2,    5,    7,    8,   10,   11,   13,   20,   25,   32,
			   32,   32,   43,   43,   43,   43,   43,   44,   47,   48,
			   56,   58,   59,   61,   71,   71,   92,   92,    1,    7,
			   62,    1,   59,    1,    1,   57,    1,    1,    1,    1,
			    1,    1,    1,   93,    1,    1,    1,    1,    1,   32,
			   32,   45,    1,    1,   71,   59,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,   93,    1,    1,    1,    1,    1,
			    1,    1,   91,   92,   92,   92,    1,   62,   91,   71,
			   57,   25,   25,    1,   25,   25,   25,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,   32,    1,   25,   71,    1,
			    1,    1,    1,   59,    1,   59,    1,   31,   76,   76,
			   57,    1,    4,   57,   57,    3,   11,   32,   32,   43,
			   62,   25,    1,   83,    1,   91,    1,   25,   71,   62,
			   57,   11,   25,   91,    1,    1,    1,   32,    1,   32,

			   79,   79,   11,   25,   25,   25,   25,   25,   25,   25,
			   25,   25,   25,   25,   25,   25,    1,   25,   25,    1,
			   25,   25,   25,   57,   11,   11,   25,   59,    1,   84,
			    1,    1,    1,    4,   32,   32,   32,    1,   71,    1,
			    1,    1,    1,    1,   25,   45,   83,   32,    1,    1,
			    1,    1,   32,    1,    1,   57,   57,   83,    1,    1,
			    1,    1,   25,   25,   32,   46,   84,   57,    1,   57,
			    1,   95,   31,   71,   83,   83,    3,   43,    1,    1,
			    1,    1,    1,   91,    1,    1,   83,   71,   25,    1,
			   83,    1,   32,    1,   57,   11,   32,   83,   46,   46,

			   91,    1,   18,   68,   68,   57,   62,   91,   91,    1,
			   32,   91,   32,   38,    1,    1,   88,   45,   32,   57,
			   83,   71,   32,    1,   88,    1,   15,   77,    1,   67,
			   18,    1,    1,   75,   88,   88,    1,    1,   88,    1,
			    1,    1,   88,    1,   71,    1,   83,    1,    1,    1,
			    1,    1,    1,   70,   75,   75,   75,   85,    1,   77,
			   91,   75,   92,   17,   67,   92,    1,   15,   29,   73,
			   73,   15,   77,   75,    1,    1,    1,    1,   71,   75,
			   75,   50,   85,   92,   75,   24,   70,   77,    1,   75,
			   75,   75,   75,   75,   75,    1,   70,   70,    1,    1,

			    1,    1,    1,    1,    1,    1,   28,   72,   92,   94,
			    1,   57,   29,   75,    1,    1,    1,   24,    1,   30,
			   75,   75,   75,    1,   75,   91,   92,   17,    1,    1,
			   15,   77,   28,    1,    1,    9,   89,   92,    1,   41,
			   50,   92,    1,   75,    1,   75,   88,   88,   92,   63,
			   79,   89,   89,    1,    1,   62,    1,   57,    1,   75,
			    1,    1,   57,    1,   63,    1,   62,    1,    1,   16,
			   80,   60,   87,   87,    1,   80,    1,    1,    1,    1,
			    1,    7,   16,   80,    1,   80,   60,   60,   57,    1,
			    1,    1,    1,   80,   80,   80,   55,   59,    1,    1,

			   25,   32,   32,   62,    1,    1,    1,    1,    1,   51,
			   25,    1,    1,    1,   89,    1,   87,   63,   79,   89,
			   89,    1,    1,    1,    1,   26,   39,   54,   87,   57,
			   63,   81,    1,   27,   57,   81,    1,   23,    1,   37,
			   81,    1,   59,   59,    1,    1,    1,   81,   62,   37,
			    1,    1,    1,    6,   14,   19,   21,   33,   35,   36,
			   37,   42,   52,   53,   57,    1,   87,   81,    1,    1,
			   57,   81,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,   32,   43,   43,   43,   43,   43,   44,
			   47,   48,   87,   25,    1,   87,    1,    1,   25,    1,

			   86,   87,   91,    1,    1,    2,   32,   62,   62,   25,
			    1,    1,    1,   12,   66,   66,   87,    1,   64,   25,
			   25,    1,    1,   59,   86,   81,    1,   62,    4,    1,
			    1,   25,   25,   57,    1,   81,   12,   25,   32,    1,
			   81,    1,    1,    1,    1,    2,    1,   13,   32,   38,
			   40,   48,   82,   81,    1,    1,   57,   22,   69,   69,
			   57,   59,    2,    4,    1,    1,    1,    1,    1,    1,
			    1,   25,   25,    1,   81,   22,    1,    4,   62,   13,
			   32,   48,   13,   32,   38,   48,   32,   38,   48,   13,
			   32,   38,   48,   81,   40,    1,   81,    1,   25,    1,

			   81,    1,    1,    1,   81,   32,    1,    1,    1>>)
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
			    7,  493,  420,    0,   32,    1,   16,  493,   20,    0,
			    0,    0,    0,    0,    6,    2,  190,  191,  200,   33,
			   34,    0,   34,   17,    0,    0,  200,  200,  198,  197,
			  200,  437,    0,    0,  196,  195,    0,  199,   35,   29,
			    0,   34,   34,   28,   19,  467,  466,  465,  464,  463,
			  462,  461,  460,  459,  458,  457,  456,  455,  454,  453,
			  452,  451,  450,  449,  446,  448,  445,  435,  434,    0,
			   23,    0,  443,  447,  440,  436,    0,    0,   21,   25,
			  425,  421,  422,    0,   24,  423,  424,  426,  444,   54,
			  194,  193,  192,  439,  438,  201,  205,    0,  493,   31,

			   30,    0,    0,  442,  441,   26,  416,    0,    0,   55,
			   18,  202,    0,  149,    0,    0,  493,  341,    0,  382,
			    0,    0,  411,    0,    0,    0,  381,    0,    0,  416,
			  493,  430,  429,    0,    0,    0,    0,  377,    0,    0,
			  383,  342,  340,  431,  427,  344,  428,  389,  418,  406,
			    0,  411,  386,  380,  379,  378,  388,  384,  385,  387,
			  345,  289,  432,  343,    0,  417,  407,  408,   27,   22,
			  206,    0,   36,  209,  493,  328,  493,  493,    0,  471,
			  470,  469,  468,   66,  302,  299,  300,    0,    0,  406,
			  303,    0,    0,    0,  395,  433,  489,  488,  487,  486,

			  485,  484,  483,  482,  481,  480,  479,  478,  477,  476,
			  475,  474,  473,  472,   65,    0,  493,    0,  376,  375,
			    5,    0,   62,   63,   64,  373,    0,    0,  200,    0,
			    0,    0,  370,  138,  369,  367,  368,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  493,  371,  409,    0,
			    0,  491,    0,  150,    0,   73,  214,  211,    0,  210,
			  328,    0,  323,    0,    0,  403,  391,  406,  411,  402,
			    0,    0,    0,  287,    0,    0,  412,  414,    0,    0,
			    0,  390,    0,    0,  493,  493,  490,  303,  346,  136,

			  139,    0,  392,  353,  352,  351,  350,  349,  348,  347,
			  360,  362,  361,  363,  364,  365,    0,  354,  359,    0,
			  356,  358,  366,    0,  394,  399,  419,   37,  493,  493,
			  215,  208,    0,  322,  411,  303,  303,    0,  410,  301,
			  298,  308,    0,  304,  318,  306,    0,  303,  411,  413,
			    0,    0,  303,  374,    0,    0,    0,  290,  493,    0,
			    0,  372,  355,  357,  303,   76,  493,    0,   75,  493,
			    0,  213,  212,  329,  296,  293,  404,  405,    0,    0,
			    0,    0,    0,  200,  305,    0,  288,  396,  415,    0,
			  294,  493,  303,  411,    0,  393,  137,  291,   77,   78,

			  200,  281,  279,  102,  493,    0,  217,  200,  200,  198,
			  197,  200,  196,  195,    0,  493,    0,  307,  411,    0,
			  295,  398,  303,   79,   80,    0,    0,  283,    0,   38,
			  280,  284,    0,  216,  194,  193,  317,  316,  192,  315,
			  314,  203,    0,  310,  400,  411,  292,  112,  120,   87,
			  116,   54,   86,  110,  114,  118,    0,   92,   48,    0,
			   50,  282,  108,  104,  103,    0,   45,   60,   40,  493,
			   39,    0,  286,    0,  313,  311,  312,  204,  397,  113,
			  121,   89,   88,    0,  117,   96,   94,   99,   95,  111,
			  114,  115,  118,  119,    0,   85,   93,  110,   49,    0,

			    0,    0,    0,    0,   46,   61,   52,   60,   57,  122,
			    0,  258,   41,  285,  218,    0,    0,   97,  100,   54,
			  101,  118,    0,   84,  114,   51,  109,  105,    0,    0,
			   44,   47,   53,   60,  124,  160,  140,   59,  260,  493,
			   90,   91,   98,    0,   83,  118,    0,    0,   58,  126,
			  493,    0,  125,   56,    0,   13,  492,    7,   82,    0,
			  107,    0,    0,  123,  127,  161,  141,   10,  493,   67,
			   68,  184,  259,  492,  493,    0,   81,  106,  129,   13,
			  493,   13,   69,   36,   15,  493,  185,   54,    0,    4,
			    3,    0,    0,   71,  493,   70,   72,  143,   14,  186,

			  187,  406,    0,   54,  172,  189,  130,  128,  174,  153,
			  188,  176,  492,  131,    0,  492,  173,  133,  493,  154,
			  132,  160,  493,  160,  146,  145,  144,  177,  175,    0,
			  134,  152,  492,  149,    0,  151,  179,  271,    0,  157,
			  492,  493,  147,  148,  181,  492,  160,    0,   54,  158,
			  270,  493,  160,  164,  170,  162,  169,  166,  167,  163,
			  160,  168,  171,  165,    0,  492,  178,  272,  142,  135,
			    0,  256,  159,    0,    0,  265,    0,  492,    0,    0,
			  324,    0,  330,  406,  336,  332,  331,  333,  338,  334,
			  335,  337,  180,  228,  492,  261,    0,    0,    0,    0,

			  160,    0,    0,  327,    0,  328,  326,  325,    0,    0,
			    0,    0,  493,  230,  253,  229,  257,    0,    0,  274,
			  276,  160,  266,  268,    0,    0,  339,    0,  320,    0,
			    0,  273,  275,    0,  160,    0,  231,  263,  406,  493,
			  493,  267,    0,  264,    0,  328,    0,  237,  239,  235,
			  233,  245,    0,  254,  227,    0,    0,  222,  225,  493,
			    0,  269,  328,  319,    0,    0,    0,    0,    0,  160,
			    0,  262,    0,  160,    0,  223,    0,  321,    0,  238,
			  244,  252,  243,  240,  241,  247,  242,  236,  250,  251,
			  246,  249,  248,  232,  234,  160,  226,  219,    0,    0,

			    0,  160,    0,  255,  224,  401,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  705,  140,  275,  272,  141,  653,   78,   79,  142,  143,
			  535,  144,  276,  145,  713,  146,  654,  426,  467,  569,
			  582,  463,  402,  655,  147,  656,  757,  637,  485,  148,
			  625,  633,  506,  468,  519,  267,  149,   25,  150,  151,
			  657,    6,  658,  659,  639,  660,   85,  626,  750,  539,
			  661,  279,  152,  153,  154,  155,  156,  157,  345,  191,
			  365,  399,  158,  159,  751,   86,  481,  609,  662,  663,
			  627,  596,  160,  161,  265,  162,  172,   88,  571,  587,
			  163,   96,  555,   16,  708,   17,  549,  617,  718,   89,
			  714,  715,  464,  429,  403,  404,  758,  759,  453,  497,

			  486,  194,  288,  164,  165,  507,  469,  470,  461,  489,
			  490,  491,  492,  493,  494,  433,  113,  268,  269,  487,
			  459,  550,  301,    4,    7,  583,  570,  647,  631,  640,
			  774,  735,  752,  283,  346,  329,  366,  457,  482,  700,
			  724,  572,  573,  695,  416,   37,   97,  536,  551,  552,
			  614,  619,  620,   18,  222,  166,  167,  462,  508,  214,
			  183,  509,  371,    8,  806,    5,   21,  590,  110,   22,
			   39,  504,  632,  510,  592,  604,  574,  612,  615,  645,
			  665,  330,  556>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    3,  420, -32768,  211,  188, -32768, -32768,  268,   11,  335,
			  335,  131,  335,  302, -32768, -32768, -32768, -32768,  676, -32768,
			  756,  772,  -19, -32768,  789, 1600,  676,  676, -32768, -32768,
			  676, -32768,  798,  795, -32768, -32768,  141, -32768, -32768, -32768,
			  335,  756,  756, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  777,
			 -32768,  211, -32768, -32768, -32768, -32768,  442,  336, -32768, -32768,
			 -32768, -32768, -32768,  148, -32768, -32768, -32768, -32768, -32768,  165,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  271,  235, -32768,

			 -32768,  211,  774, -32768, -32768, -32768, 1368,  753, 1624, -32768,
			 -32768, -32768,  211,  557,  764,  759, -32768, -32768,  711,  244,
			  139,   66,  120, 1763, 1886,  761,  200,   20,  117, 1368,
			 -32768, -32768, -32768, 1368, 1368,  779, 1368, -32768, 1368, 1368,
			  513, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2047,  766,
			 1368,  678, -32768, -32768, -32768, -32768, -32768, -32768,  511,  506,
			 -32768, -32768, -32768, -32768,  754,  760, -32768, -32768, -32768, -32768,
			 -32768, 1807,  552,  717, -32768,  346, -32768, -32768,  224, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  211, 1368,  773,
			  687,  771,  335, 1252, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  335, -32768,  224, -32768, -32768,
			 -32768, 1368, -32768, -32768, -32768, -32768,  335,  691,  482,  720,
			   11, 2029, -32768,   11, -32768, -32768, -32768,  224, 1368, 1368,
			 1368, 1368, 1368, 1368, 1368, 1368, 1368, 1368, 1368, 1368,
			 1368, 1136, 1368,  970, 1368, 1368, -32768, -32768, -32768,  224,
			  224, -32768, 1368, -32768, 1763,  718, -32768, -32768,  744,  719,
			  346,   11, -32768,   11,   11,  712, -32768, -32768,  678, -32768,
			  743, 1969,  854, -32768,  224,  742, -32768, 2047,  457,  722,
			   11, -32768, 1951,  715, -32768, -32768, -32768,  687,  168, -32768,

			  549,  707, -32768,  495,  495,  495,  495,  495,  529,  529,
			  607,  607,  607,  607,  607,  607, 1368, 1092, 2009, 1368,
			 1769, 2070, -32768,   11, -32768, -32768, 2047, -32768,  428, -32768,
			  701, -32768,  717, -32768,  678,  687,  687,  224, -32768, -32768,
			 -32768,  711,   71, -32768, 2047, -32768,  418,  687,  678, -32768,
			 1368,  721,  687, -32768,  693,   11,  652, -32768, -32768,  224,
			   11, -32768, 1092, 1769,  687, -32768,  592,  335, -32768,  682,
			  335, -32768, -32768, -32768, -32768, -32768,  712, -32768,  335,  335,
			  124,  335,  302,  458, -32768, 1484, -32768, -32768, 2047,   11,
			 -32768, -32768,  687,  678,   11, -32768, -32768, -32768, -32768,  698,

			  676,  164, -32768,  677,  659,  686,  690,  676,  676,  680,
			  673,  676,  672,  669,    7,  417,  668, -32768,  678,  627,
			 -32768, -32768,  687, -32768,  318,  330,  127,  209,  127,  609,
			 -32768,  164,  127, -32768,  665,  664, -32768, -32768,  662, -32768,
			 -32768,  602,  238, -32768, -32768,  678, -32768,  127,  127,  127,
			  127,  197, -32768,  568,  570,  553,  641,  634, -32768,  343,
			 -32768,  622, -32768, -32768,  661,  108, -32768,  491, -32768, -32768,
			  609,  127,  209,   -6, -32768, -32768, -32768,  596, -32768,  622,
			  622, -32768,  638,  618,  622, -32768,  623,  159, -32768, -32768,
			  570, -32768,  553, -32768,  611, -32768, -32768,  568, -32768,  335,

			  127,  127,  626,  624,  623, -32768, -32768,  446, -32768,  321,
			  127,  587, -32768,  622, -32768,  127,  127, -32768, -32768,  532,
			  622,  553,  595, -32768,  570, -32768, -32768, -32768,  211,  211,
			 -32768, -32768, -32768,  586,   11, -32768,  613, -32768, -32768, -32768,
			 -32768, -32768, -32768,  583, -32768,  553,  322,  305, -32768, -32768,
			  549,  603,   11,  530,  211,  320,   69,  572, -32768,  580,
			 -32768,  599,  604, -32768, -32768, -32768, -32768, 1740,  576, -32768,
			 -32768, -32768, -32768,  438, -32768,  574, -32768, -32768,  593,  563,
			  755,  563, -32768,  552, -32768,  569, -32768,  532, 1368, -32768,
			 -32768,   11,  211, -32768,  729, -32768, -32768, -32768, -32768, -32768,

			 2047,  412,  582,  532,  526, 1368, -32768, -32768,  550,  510,
			 2047, -32768,  311,   11,  233,  311, -32768, -32768,  549, -32768,
			   11, -32768, -32768, -32768, -32768, -32768, -32768,  519, -32768,  546,
			 -32768, -32768,  162,  557, 1807, -32768,  488,  485,  211, -32768,
			  551,   98, -32768, -32768, -32768,  -25, -32768,  509,  532, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  775,  -25, -32768, -32768, -32768, -32768,
			 1368,  486,  530,  196, 1368,  535,  528,  497,   85,   28,
			  211, 1368,  513,   -8, -32768, -32768, -32768, -32768, -32768, -32768,
			  511,  506, -32768,  767,  289,  448, 1368, 1368, 1933, 1785,

			 -32768,  460,  477, -32768,  211,  346, -32768, -32768,  487, 1792,
			 1368, 1368, -32768, -32768,  447,  379, -32768, 1368,  393, 2047,
			 2047, -32768, -32768, -32768,   44,  423, -32768,  433, -32768,   29,
			  435, 2047, 2047,  390, -32768,  381, -32768, 2047,   48, -32768,
			  258, -32768, 1807, -32768,   29,  346,  395,  469,  461,  451,
			 -32768,  382,   23, -32768, -32768, 1368, 1368, -32768,  360,  227,
			  356, -32768,  346, -32768,  335,    2,  390,  153,  390, -32768,
			  390, 2047,  591, -32768,  274, -32768, 1368, -32768,  252, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 1674,  206,

			  106, -32768,   11, -32768, -32768, -32768,  156,  128, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -549,  253,  578, -253, -32768, -32768,  804,  344, -32768,   -7,
			 -32768,  -11, -178, -32768,  198,  -23, -32768, -401, -32768, -32768,
			 -32768,  408,  503, -32768,    6, -32768,  145, -32768,  424,  444,
			 -32768, -32768,  396,  431, -32768,  566,    0, -32768,  122, -101,
			 -32768,   -4, -32768, -32768,  256, -32768,  -12, -32768,  121, -32768,
			 -32768,  536,  226,  218,  217,  215,  208,  203,  489, -32768,
			  494, -32768,  202,  201, -194, -32768,  342, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  280,  -13,  225, -166,  283, -32768,
			  778,    1, -32768, -205, -32768, -32768,  295,  230, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  398, -32768,

			 -32768, -130, -32768,  723, -32768, -32768, -32768, -32768, -143,  421,
			  347,  419, -448,  414, -402, -32768, -32768, -32768, -32768, -374,
			 -32768, -214, -32768,  277, -530, -32768, -100, -32768, -594, -32768,
			 -32768, -32768, -32768, -281, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -545, -32768, -32768, -32768,   38, -391, -32768, -32768, -32768,
			 -32768, -32768, -32768,   -3, -32768,   27,  -99, -103,  300, -32768,
			 -32768, -32768, -32768,  -83, -32768, -32768, -32768, -32768, -306, -32768,
			  178, -32768, -509, -32768, -32768, -32768, -360, -32768, -32768, -32768,
			 -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    3,   35,   82,   23,   15,  263,   26,   27,   24,   30,
			  289,   29,   87,   34,   81,  114,  357,  333,   80,  300,
			  190,  258,  368,  442,  225,   84,  553,  427,  224,  635,
			  471,   83,   75,  175,  500,    2,    2,   98,  585,  291,
			   14, -182,  521,   13,    2,  711,  221,  230,  710,   42,
			  594,   38,  667,  220,  374,  375,  441,  472,  671,  302,
			  514,    2,    2,  770,   90,   91,  386,  616,   92, -182,
			  628,  390,  102,  746,  704,   12,  545,  278,    1,   41,
			  219,  324,  325,  397,  742,   82,  256,  755,   11,  741,
			  522,  270,  188,  273,  274,   87,  124,   81,   10,    2,

			  666,   80,  115,  530,   14,    9,  725,  382,   84,  120,
			  195,  420,  187,  170,   83,  218,  278,  226,   14,  543,
			  692,  189,  769,  703,  703,  228,  186,  740,  808,  227,
			  531,  226,  701,  290,  503, -182,  278,  546,  547,  381,
			  753,  446,  124,  559, -182,  488,  193,  502,  338,  716,
			   14,  672,  380,   13,  223,  120,  807,    2,  278,  278,
			  220,  185,  379,  226,    2,  406,  192,   33,   32,  378,
			  652,  184,  803,  323,   14,  793,  651,   13,  277,  796,
			  745,  395,   31,  347,  409,   12,    2,  518,  280,  285,
			   95,   28,  220,  359,  650,  762,  106,  -46,   11,  565,

			   43,  800,  109,  124,  373,  108,  358,  804,   10,   12,
			  425,  355,  356,  542,  105,    9,  120,  277,  387,   99,
			  100,  178,   11,  293,  746,  217, -155, -155, -155, -155,
			  297,  802,   10,  299,  109,  124,  278,  277,  216,    9,
			  -46, -155,  -47,  425,   14,  367,  369,   13,  120,  697,
			   20,  327,  696,  -46,  182,  181, -155,    2,  278,  277,
			  277,   19, -207,  421, -155, -155, -155,  180,  179,  178,
			  255,  334,  641,  335,  336,  394, -207, -207,  112,   12,
			  641,  599,  177,  367,  277,  -47,  405,  477,  444,  473,
			  352, -221,   11, -221, -207,  624,  623,  607,  -47,  799,

			  124, -207,   10,  622,  479,  480, -207,  484,  419,    9,
			 -207,  112, -207,  120, -207,  478,   33,   32,  621, -207,
			  111,  405, -220,  364, -220,  465,   -8,  224,  513,  224,
			   -8,   31,  356,  224,   -8,    2,   -8,  277,   -8,  383,
			  797,   -8,  669,  227,  520,  112,  483,  534,  224,  224,
			  224,  224,  561,  255,  255,  392,  255,  255,  255,  277,
			  396,  533,  112,   14,  400,   94,   -8,  104,   14,  560,
			  413,  271,  224, -182, -182,  407,  408,  458,  411,  255,
			  410, -182,  412,  499,  452,  768,  511,  451,  224,  418,
			  498, -182, -182, -182,  422,  568, -182,  526,  465,  618,

			  567,  224,  224,  255,   33,   32,  618,  537,  450,  255,
			  449,  224,  483,  541,  255,  448,  224,  224,  447,   31,
			   75,  776,  460,    2,  773,  255,  255,  255,  255,  255,
			  255,  255,  255,  255,  255,  255,  255,  255,  424,  255,
			  255,  764,  255,  255,  255,  434,  435,  754,  255,  438,
			  256,  605,  728,  223,  767,  223,  557, -309,  385,  223,
			  359,  746, -309,  384,  766,  109,  255,  562,  643,  -54,
			  -54,   93,  765,  103,  223,  223,  223,  223,   -9,  593,
			  744,  595,   -9,  712,  255,  255,   -9,  -54,   -9,  743,
			   -9,  588,  763,   -9,  -54,  739,  525,  350,  223,  -54,

			 -183, -183,  349,  -54, -183,  415,  414,  -54, -183,  777,
			  255,  734,  -43, -183,  223,  238,  137,  -43,   -9,  505,
			 -183,  -43,  729, -183,  295,  -43,  726,  223,  223,  295,
			   36,  260, -183,  723,  299,  629,  259,  223,  237,  634,
			 -183, -183,  223,  223,   82,  242,  241,  240,  239,  238,
			  137,  717,  299,  217,   87,  566,   81,  -42,  664,  778,
			   80,  699,  -42, -182,  505,  694,  -42,  565,  670,  109,
			  -42,  781,  785,  788,  792,  668,  761,  231,  232,  646,
			  234,   23,  235,  236,  171,  638,  636,  644,  601,  360,
			   23,  602,  613,  603,  257,  254,  253,  252,  251,  250,

			  249,  248,  247,  246,  245,  244,  243,  242,  241,  240,
			  239,  238,  137,  299,  611, -156, -156, -156, -156,  608,
			  299,  244,  243,  242,  241,  240,  239,  238,  137,  733,
			 -156,  606,  281,  -74,  -74,  598,  264,  287,  568,  648,
			  589,  591,  584,  578,  577, -156,  576,    1,  563,  558,
			  448,  -74,  554, -156, -156, -156,  756,  760,  -74,  505,
			  450,  544,  500,  -74,  683,  292,  538,  -74,  447,  425,
			  529,  -74,  528,  516,  795,  702,  760,  523,  515,  706,
			  466,  707,  303,  304,  305,  306,  307,  308,  309,  310,
			  311,  312,  313,  314,  315,  317,  318,  320,  321,  322,

			  401,  501, -202,  451,  193,  727,  326,  495, -201,  476,
			  747,  475,  474,  282,  445,  443,  440,  738, -278,  439,
			  437,  749,  255,  401,   36, -278,  344,  436,  431,  706,
			 -278,  432,  255,  748, -278,  423,  428,  337, -278,  393,
			  391, -277,  779,  782,  706,  789,  389,  747, -277,  176,
			  266,  370,  361, -277,  784,  787,  791, -277,  749,  332,
			  362, -277,  354,  363,  296,  780,  783,  786,  790,  351,
			  748,  254,  253,  252,  251,  250,  249,  248,  247,  246,
			  245,  244,  243,  242,  241,  240,  239,  238,  137,  348,
			  339,  -11,  -11,  331,  388,  328,  284,  294, -297,  -11,

			  262,  681,  805,  261,  256,  233,  174,  215,    2,  116,
			  680,  -11,  173,  -11,  -11,  255,  679,  -12,  -12,  168,
			  255,  678,  -11,  101,   94,  -12,   38,   93,   44,  344,
			   40,  255,  677,  548,  575,  676,  675,  -12,  456,  -12,
			  -12,  255,  255,  455,  524,  454,  125,  564,  -12,  674,
			  630,  124,  229,  255,  255,  496,  586,  540,  642,  255,
			  398,  107,  122,  597,  120,  691,  690,  689,  139,  138,
			  673,  712,  688,  377,  417,  137,  136,  135,  134,  687,
			  133,  686,  685,  132,   75,  131,   73,    2,   72,   71,
			  684,  794,  130,  255,  255,   69,  649,  129,  372,  343,

			  342,  512,  106,  532,  775,   68,   67,  430,  127,  527,
			  517,  581,  169,  736,  126,  376,    0,  682,    0,    0,
			  255,    0,    0,    0,    0,  125,    0,    0,    0,    0,
			  124,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  123,  122,  121,  120,    0,    0,    0,    0,    0,  119,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  341,
			    0,   66,   65,   64,  117,   63,   62,   61,   60,   59,
			   58,   57,   56,   55,   54,   53,   52,   51,   50,   49,
			   48,   47,   46,   45,  139,  138,    0,    0,    0,    0,
			    0,  137,  136,  135,  134,    0,  133,    0,    0,  132,

			   75,  131,   73,    2,   72,   71,    0,    0,  130,    0,
			    0,   69,    0,  129,    0,    0,  128,    0,  106,    0,
			    0,   68,   67,    0,  127,    0,    0,    0,    0,    0,
			  126,    0,  600,    0,  319,    0,    0,    0,    0,    0,
			    0,  125,    0,    0,    0,    0,  124,    0,    0,  610,
			    0,    0,    0,    0,    0,    0,  123,  122,  121,  120,
			    0,    0,    0,    0,    0,  119,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  118,    0,   66,   65,   64,
			  117,   63,   62,   61,   60,   59,   58,   57,   56,   55,
			   54,   53,   52,   51,   50,   49,   48,   47,   46,   45,

			  250,  249,  248,  247,  246,  245,  244,  243,  242,  241,
			  240,  239,  238,  137,  693,    0,    0,    0,  698,    0,
			    0,    0,    0,    0,    0,  709,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  719,  720,    0,    0,    0,    0,    0,    0,    0,    0,
			  139,  138,    0,    0,  731,  732,    0,  137,  136,  135,
			  134,  737,  133,    0,    0,  132,   75,  131,   73,    2,
			   72,   71,    0,    0,  130,    0,    0,   69,    0,  129,
			    0,    0,  128,    0,  106,    0,    0,   68,   67,    0,
			  127,    0,    0,    0,    0,    0,  126,    0,    0,  771,

			  772,    0,    0,    0,    0,    0,    0,  125,    0,    0,
			    0,    0,  124,    0,    0,    0,    0,    0,    0,    0,
			  798,    0,  123,  122,  121,  120,    0,    0,    0,    0,
			    0,  119,    0,    0,    0,  316,    0,    0,    0,    0,
			    0,  118,    0,   66,   65,   64,  117,   63,   62,   61,
			   60,   59,   58,   57,   56,   55,   54,   53,   52,   51,
			   50,   49,   48,   47,   46,   45,  139,  138,    0,    0,
			    0,    0,    0,  137,  136,  135,  134,    0,  133,    0,
			    0,  132,   75,  131,   73,    2,   72,   71,    0,    0,
			  130,    0,    0,   69,    0,  129,    0,  286,  128,    0,

			  106,    0,    0,   68,   67,    0,  127,    0,    0,    0,
			    0,    0,  126,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  125,    0,    0,    0,    0,  124,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  123,  122,
			  121,  120,    0,    0,    0,    0,    0,  119,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  118,    0,   66,
			   65,   64,  117,   63,   62,   61,   60,   59,   58,   57,
			   56,   55,   54,   53,   52,   51,   50,   49,   48,   47,
			   46,   45,  139,  138,    0,    0,    0,    0,    0,  137,
			  136,  135,  134,    0,  133,    0,    0,  132,   75,  131,

			   73,    2,   72,   71,    0,    0,  130,    0,    0,   69,
			    0,  129,    0,    0,  128,    0,  106,    0,    0,   68,
			   67,    0,  127,    0,    0,    0,    0,    0,  126,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  125,
			    0,    0,    0,    0,  124,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  123,  122,  121,  120,    0,    0,
			    0,    0,    0,  119,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  118,    0,   66,   65,   64,  117,   63,
			   62,   61,   60,   59,   58,   57,   56,   55,   54,   53,
			   52,   51,   50,   49,   48,   47,   46,   45,  139,  138,

			    0,    0,    0,    0,    0,  137,  136,  135,  134,    0,
			  133,    0,    0,  132,   75,  131,   73,    2,   72,   71,
			    0,    0,  130,    0,    0,   69,    0,  129,    0,    0,
			  342,    0,  106,    0,    0,   68,   67,    0,  127,    0,
			    0,    0,    0,    0,  126,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  125,    0,    0,    0,    0,
			  124,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  123,  122,  121,  120,    0,    0,    0,    0,    0,  119,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  341,
			    0,   66,   65,   64,  117,   63,   62,   61,   60,   59,

			   58,   57,   56,   55,   54,   53,   52,   51,   50,   49,
			   48,   47,   46,   45,   77,   76,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   31,
			   75,   74,   73,    2,   72,   71,    0,   70,   77,   76,
			    0,   69,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   68,   67,   31,   75,   74,   73,    2,   72,   71,
			    0,    0,    0,    0,    0,   69,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   68,   67,    0,  254,  253,
			  252,  251,  250,  249,  248,  247,  246,  245,  244,  243,
			  242,  241,  240,  239,  238,  137,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,   66,   65,   64,
			    0,   63,   62,   61,   60,   59,   58,   57,   56,   55,
			   54,   53,   52,   51,   50,   49,   48,   47,   46,   45,
			    0,   66,   65,   64,    0,   63,   62,   61,   60,   59,
			   58,   57,   56,   55,   54,   53,   52,   51,   50,   49,
			   48,   47,   46,   45,   77,   76,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   31,
			   75,   74,   73,  801,   72,  252,  251,  250,  249,  248,
			  247,  246,  245,  244,  243,  242,  241,  240,  239,  238,
			  137,   68,   67,    0,    0,   73,  254,  253,  252,  251,

			  250,  249,  248,  247,  246,  245,  244,  243,  242,  241,
			  240,  239,  238,  137,    0,  580,    0,   73,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  722,    0,    0,    0,    0,    0,    0,  730,    0,   73,
			    0,  579,    0,    0,    0,    0,    0,   66,   65,   64,
			    0,   63,   62,   61,   60,   59,   58,   57,   56,   55,
			   54,   53,   52,   51,   50,   49,   48,   47,   46,   45,
			   66,   65,   64,    0,   63,   62,   61,   60,   59,   58,
			   57,   56,   55,   54,   53,   52,   51,   50,   49,   48,
			   47,   46,   45,   65,    0,    0,   63,   62,   61,   60,

			   59,   58,   57,   56,   55,   54,   53,   52,   51,   50,
			   49,   48,   47,   46,   45,   65,    0,    0,   63,   62,
			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,   45,  254,  253,  252,
			  251,  250,  249,  248,  247,  246,  245,  244,  243,  242,
			  241,  240,  239,  238,  137,  254,  253,  252,  251,  250,
			  249,  248,  247,  246,  245,  244,  243,  242,  241,  240,
			  239,  238,  137,  254,  253,  252,  251,  250,  249,  248,
			  247,  246,  245,  244,  243,  242,  241,  240,  239,  238,
			  137,    0,    0,    0,    0,    0,  353,  213,  212,  211,

			  210,  209,  208,  207,  206,  205,  204,  203,  202,  201,
			  200,  199,  198,  197,  340,  196,  251,  250,  249,  248,
			  247,  246,  245,  244,  243,  242,  241,  240,  239,  238,
			  137,    0,  721,  254,  253,  252,  251,  250,  249,  248,
			  247,  246,  245,  244,  243,  242,  241,  240,  239,  238,
			  137,  254,  253,  252,  251,  250,  249,  248,  247,  246,
			  245,  244,  243,  242,  241,  240,  239,  238,  137,    0,
			    0,    0,    0,    0,  298,  253,  252,  251,  250,  249,
			  248,  247,  246,  245,  244,  243,  242,  241,  240,  239,
			  238,  137>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   13,   25,    7,    3,  171,    9,   10,    8,   12,
			  215,   11,   25,   13,   25,   98,  297,  270,   25,  233,
			  121,  151,  328,  414,  127,   25,  535,  401,  127,  623,
			  431,   25,   30,  116,   40,   33,   33,   40,  568,  217,
			   33,   66,  490,   36,   33,   53,   26,  130,   56,   68,
			  580,   70,  646,   33,  335,  336,   49,  431,  652,  237,
			   66,   33,   33,   40,   26,   27,  347,  612,   30,   94,
			  615,  352,   71,   71,   46,   68,  524,  178,   75,   98,
			   60,  259,  260,  364,   40,  108,   38,   39,   81,   45,
			  492,  174,   26,  176,  177,  108,   76,  108,   91,   33,

			  645,  108,  101,  504,   33,   98,  700,   36,  108,   89,
			  123,  392,   46,  112,  108,   95,  217,   46,   33,  521,
			  665,  121,   99,   95,   95,  128,   60,  721,    0,  128,
			  504,   46,  677,  216,   26,   66,  237,  528,  529,   68,
			  734,  422,   76,  545,   75,  451,   26,   39,  278,  694,
			   33,  660,   81,   36,  127,   89,    0,   33,  259,  260,
			   33,   95,   91,   46,   33,  370,   46,   14,   15,   98,
			   72,  105,   66,  256,   33,  769,   78,   36,  178,  773,
			  729,  359,   29,  284,   60,   68,   33,   28,  187,  192,
			   49,   60,   33,   25,   96,  744,   48,   33,   81,   37,

			   22,  795,   37,   76,  334,   40,   38,  801,   91,   68,
			   46,  294,  295,  519,   66,   98,   89,  217,  348,   41,
			   42,   25,   81,  226,   71,   25,   64,   65,   66,   67,
			  230,   25,   91,  233,   37,   76,  337,  237,   38,   98,
			   76,   79,   33,   46,   33,  328,  329,   36,   89,   53,
			   62,  264,   56,   89,  115,  116,   94,   33,  359,  259,
			  260,   73,   27,  393,  102,  103,  104,  128,  129,   25,
			  148,  271,  632,  273,  274,  358,   41,   42,   40,   68,
			  640,  587,   38,  366,  284,   76,  369,   49,  418,  432,
			  290,   64,   81,   66,   59,   62,   63,  603,   89,   47,

			   76,   66,   91,   70,  447,  448,   71,  450,  391,   98,
			   75,   40,   77,   89,   79,  445,   14,   15,   85,   84,
			   49,  404,   64,  323,   66,  428,   58,  426,  471,  428,
			   62,   29,  415,  432,   66,   33,   68,  337,   70,  342,
			   66,   73,  648,  342,  487,   40,  449,   26,  447,  448,
			  449,  450,   47,  231,  232,  355,  234,  235,  236,  359,
			  360,   40,   40,   33,  367,   29,   98,   31,   33,   47,
			  382,   25,  471,   62,   63,  378,  379,   47,  381,  257,
			  380,   70,  382,   40,   66,    3,  469,   69,  487,  389,
			   47,  102,  103,   82,  394,   75,   85,  500,  501,  613,

			   80,  500,  501,  281,   14,   15,  620,  510,   90,  287,
			   92,  510,  515,  516,  292,   97,  515,  516,  100,   29,
			   30,   65,  425,   33,   64,  303,  304,  305,  306,  307,
			  308,  309,  310,  311,  312,  313,  314,  315,  400,  317,
			  318,   46,  320,  321,  322,  407,  408,   66,  326,  411,
			   38,   39,  705,  426,    3,  428,  539,   40,   40,  432,
			   25,   71,   45,   45,    3,   37,  344,  550,  634,   41,
			   42,   29,    3,   31,  447,  448,  449,  450,   58,  579,
			   47,  581,   62,  104,  362,  363,   66,   59,   68,   66,
			   70,  574,  745,   73,   66,  102,  499,   40,  471,   71,

			   62,   63,   45,   75,   66,   47,   48,   79,   70,  762,
			  388,   64,   66,   75,  487,   20,   21,   71,   98,   73,
			   82,   75,   35,   85,   47,   79,   66,  500,  501,   47,
			   48,   25,   94,  699,  534,  618,   25,  510,   25,  622,
			  102,  103,  515,  516,  567,   16,   17,   18,   19,   20,
			   21,  103,  552,   25,  567,  554,  567,   66,  641,  764,
			  567,   26,   71,   66,   73,   79,   75,   37,  651,   37,
			   79,  765,  766,  767,  768,   66,  742,  133,  134,   94,
			  136,  585,  138,  139,   27,   39,   67,   99,  588,   40,
			  594,  591,   82,  592,  150,    4,    5,    6,    7,    8,

			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,  613,   64,   64,   65,   66,   67,   93,
			  620,   14,   15,   16,   17,   18,   19,   20,   21,  712,
			   79,   49,  188,   41,   42,   66,   84,  193,   75,  638,
			   66,   48,   66,   39,   45,   94,   66,   75,   45,   66,
			   97,   59,   39,  102,  103,  104,  739,  740,   66,   73,
			   90,   66,   40,   71,  664,  221,   79,   75,  100,   46,
			   46,   79,   46,   55,   83,  678,  759,   66,   40,  679,
			   71,  680,  238,  239,  240,  241,  242,  243,  244,  245,
			  246,  247,  248,  249,  250,  251,  252,  253,  254,  255,

			   41,   40,  106,   69,   26,  704,  262,   66,  106,   47,
			  733,   47,   47,   26,   87,   47,   47,  717,   59,   47,
			   47,  733,  600,   41,   48,   66,  282,   47,   42,  729,
			   71,   41,  610,  733,   75,   37,   59,   25,   79,   87,
			   47,   59,  765,  766,  744,  768,   25,  770,   66,   38,
			   33,   50,   45,   71,  766,  767,  768,   75,  770,   40,
			  316,   79,   47,  319,   44,  765,  766,  767,  768,   47,
			  770,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   47,
			   47,   62,   63,   49,  350,   77,   25,  106,   25,   70,

			   40,   26,  802,   49,   38,   26,   47,   46,   33,   35,
			   35,   82,   48,   84,   85,  693,   41,   62,   63,   66,
			  698,   46,   93,   46,   29,   70,   70,   29,   39,  385,
			   58,  709,   57,  533,  557,   60,   61,   82,  424,   84,
			   85,  719,  720,  424,  497,  424,   71,  552,   93,   74,
			  620,   76,  129,  731,  732,  457,  573,  515,  633,  737,
			  366,   83,   87,  583,   89,  664,  664,  664,   14,   15,
			   95,  104,  664,  337,  385,   21,   22,   23,   24,  664,
			   26,  664,  664,   29,   30,   31,   32,   33,   34,   35,
			  664,  770,   38,  771,  772,   41,  640,   43,  332,   45,

			   46,  470,   48,  507,  759,   51,   52,  404,   54,  501,
			  486,  567,  108,  715,   60,  337,   -1,  664,   -1,   -1,
			  798,   -1,   -1,   -1,   -1,   71,   -1,   -1,   -1,   -1,
			   76,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   86,   87,   88,   89,   -1,   -1,   -1,   -1,   -1,   95,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  105,
			   -1,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,   14,   15,   -1,   -1,   -1,   -1,
			   -1,   21,   22,   23,   24,   -1,   26,   -1,   -1,   29,

			   30,   31,   32,   33,   34,   35,   -1,   -1,   38,   -1,
			   -1,   41,   -1,   43,   -1,   -1,   46,   -1,   48,   -1,
			   -1,   51,   52,   -1,   54,   -1,   -1,   -1,   -1,   -1,
			   60,   -1,  588,   -1,   64,   -1,   -1,   -1,   -1,   -1,
			   -1,   71,   -1,   -1,   -1,   -1,   76,   -1,   -1,  605,
			   -1,   -1,   -1,   -1,   -1,   -1,   86,   87,   88,   89,
			   -1,   -1,   -1,   -1,   -1,   95,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  105,   -1,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,

			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,  670,   -1,   -1,   -1,  674,   -1,
			   -1,   -1,   -1,   -1,   -1,  681,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  696,  697,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   14,   15,   -1,   -1,  710,  711,   -1,   21,   22,   23,
			   24,  717,   26,   -1,   -1,   29,   30,   31,   32,   33,
			   34,   35,   -1,   -1,   38,   -1,   -1,   41,   -1,   43,
			   -1,   -1,   46,   -1,   48,   -1,   -1,   51,   52,   -1,
			   54,   -1,   -1,   -1,   -1,   -1,   60,   -1,   -1,  755,

			  756,   -1,   -1,   -1,   -1,   -1,   -1,   71,   -1,   -1,
			   -1,   -1,   76,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  776,   -1,   86,   87,   88,   89,   -1,   -1,   -1,   -1,
			   -1,   95,   -1,   -1,   -1,   99,   -1,   -1,   -1,   -1,
			   -1,  105,   -1,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,   14,   15,   -1,   -1,
			   -1,   -1,   -1,   21,   22,   23,   24,   -1,   26,   -1,
			   -1,   29,   30,   31,   32,   33,   34,   35,   -1,   -1,
			   38,   -1,   -1,   41,   -1,   43,   -1,   45,   46,   -1,

			   48,   -1,   -1,   51,   52,   -1,   54,   -1,   -1,   -1,
			   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   71,   -1,   -1,   -1,   -1,   76,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   86,   87,
			   88,   89,   -1,   -1,   -1,   -1,   -1,   95,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  105,   -1,  107,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,   14,   15,   -1,   -1,   -1,   -1,   -1,   21,
			   22,   23,   24,   -1,   26,   -1,   -1,   29,   30,   31,

			   32,   33,   34,   35,   -1,   -1,   38,   -1,   -1,   41,
			   -1,   43,   -1,   -1,   46,   -1,   48,   -1,   -1,   51,
			   52,   -1,   54,   -1,   -1,   -1,   -1,   -1,   60,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   71,
			   -1,   -1,   -1,   -1,   76,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   86,   87,   88,   89,   -1,   -1,
			   -1,   -1,   -1,   95,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  105,   -1,  107,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,   14,   15,

			   -1,   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,
			   26,   -1,   -1,   29,   30,   31,   32,   33,   34,   35,
			   -1,   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   -1,
			   46,   -1,   48,   -1,   -1,   51,   52,   -1,   54,   -1,
			   -1,   -1,   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   71,   -1,   -1,   -1,   -1,
			   76,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   86,   87,   88,   89,   -1,   -1,   -1,   -1,   -1,   95,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  105,
			   -1,  107,  108,  109,  110,  111,  112,  113,  114,  115,

			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,   14,   15,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   29,
			   30,   31,   32,   33,   34,   35,   -1,   37,   14,   15,
			   -1,   41,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   51,   52,   29,   30,   31,   32,   33,   34,   35,
			   -1,   -1,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   51,   52,   -1,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  107,  108,  109,
			   -1,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			   -1,  107,  108,  109,   -1,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,   14,   15,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   29,
			   30,   31,   32,   99,   34,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   51,   52,   -1,   -1,   32,    4,    5,    6,    7,

			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   -1,   75,   -1,   32,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   45,   -1,   -1,   -1,   -1,   -1,   -1,   45,   -1,   32,
			   -1,  101,   -1,   -1,   -1,   -1,   -1,  107,  108,  109,
			   -1,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  107,  108,  109,   -1,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  108,   -1,   -1,  111,  112,  113,  114,

			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  108,   -1,   -1,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,    4,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,    4,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   -1,   -1,   -1,   -1,   -1,   45,  111,  112,  113,

			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,   45,  129,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   -1,   99,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   -1,
			   -1,   -1,   -1,   -1,   45,    5,    6,    7,    8,    9,
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

	yytype57 (v: ANY): TOKEN_LOCATION is
		require
			valid_type: yyis_type57 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type57 (v: ANY): BOOLEAN is
		local
			u: TOKEN_LOCATION
		do
			u ?= v
			Result := (u = v)
		end

	yytype58 (v: ANY): PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION] is
		require
			valid_type: yyis_type58 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type58 (v: ANY): BOOLEAN is
		local
			u: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
			u ?= v
			Result := (u = v)
		end

	yytype59 (v: ANY): STRING_AS is
		require
			valid_type: yyis_type59 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type59 (v: ANY): BOOLEAN is
		local
			u: STRING_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype60 (v: ANY): TAGGED_AS is
		require
			valid_type: yyis_type60 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type60 (v: ANY): BOOLEAN is
		local
			u: TAGGED_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype61 (v: ANY): TUPLE_AS is
		require
			valid_type: yyis_type61 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type61 (v: ANY): BOOLEAN is
		local
			u: TUPLE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype62 (v: ANY): TYPE is
		require
			valid_type: yyis_type62 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type62 (v: ANY): BOOLEAN is
		local
			u: TYPE
		do
			u ?= v
			Result := (u = v)
		end

	yytype63 (v: ANY): TYPE_DEC_AS is
		require
			valid_type: yyis_type63 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type63 (v: ANY): BOOLEAN is
		local
			u: TYPE_DEC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype64 (v: ANY): VARIANT_AS is
		require
			valid_type: yyis_type64 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type64 (v: ANY): BOOLEAN is
		local
			u: VARIANT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype65 (v: ANY): EIFFEL_LIST [ATOMIC_AS] is
		require
			valid_type: yyis_type65 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type65 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ATOMIC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype66 (v: ANY): EIFFEL_LIST [CASE_AS] is
		require
			valid_type: yyis_type66 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type66 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CASE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype67 (v: ANY): EIFFEL_LIST [CONVERT_FEAT_AS] is
		require
			valid_type: yyis_type67 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type67 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype68 (v: ANY): EIFFEL_LIST [CREATE_AS] is
		require
			valid_type: yyis_type68 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type68 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CREATE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype69 (v: ANY): EIFFEL_LIST [ELSIF_AS] is
		require
			valid_type: yyis_type69 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type69 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ELSIF_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype70 (v: ANY): EIFFEL_LIST [EXPORT_ITEM_AS] is
		require
			valid_type: yyis_type70 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type70 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype71 (v: ANY): EIFFEL_LIST [EXPR_AS] is
		require
			valid_type: yyis_type71 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type71 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXPR_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype72 (v: ANY): EIFFEL_LIST [FEATURE_AS] is
		require
			valid_type: yyis_type72 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type72 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype73 (v: ANY): EIFFEL_LIST [FEATURE_CLAUSE_AS] is
		require
			valid_type: yyis_type73 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type73 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype75 (v: ANY): EIFFEL_LIST [FEATURE_NAME] is
		require
			valid_type: yyis_type75 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type75 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_NAME]
		do
			u ?= v
			Result := (u = v)
		end

	yytype76 (v: ANY): EIFFEL_LIST [FORMAL_DEC_AS] is
		require
			valid_type: yyis_type76 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type76 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FORMAL_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype77 (v: ANY): EIFFEL_LIST [ID_AS] is
		require
			valid_type: yyis_type77 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type77 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ID_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype79 (v: ANY): ARRAYED_LIST [INTEGER] is
		require
			valid_type: yyis_type79 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type79 (v: ANY): BOOLEAN is
		local
			u: ARRAYED_LIST [INTEGER]
		do
			u ?= v
			Result := (u = v)
		end

	yytype80 (v: ANY): INDEXING_CLAUSE_AS is
		require
			valid_type: yyis_type80 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type80 (v: ANY): BOOLEAN is
		local
			u: INDEXING_CLAUSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype81 (v: ANY): EIFFEL_LIST [INSTRUCTION_AS] is
		require
			valid_type: yyis_type81 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type81 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INSTRUCTION_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype82 (v: ANY): EIFFEL_LIST [INTERVAL_AS] is
		require
			valid_type: yyis_type82 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type82 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INTERVAL_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype83 (v: ANY): EIFFEL_LIST [OPERAND_AS] is
		require
			valid_type: yyis_type83 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type83 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [OPERAND_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype84 (v: ANY): EIFFEL_LIST [PARENT_AS] is
		require
			valid_type: yyis_type84 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type84 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [PARENT_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype85 (v: ANY): EIFFEL_LIST [RENAME_AS] is
		require
			valid_type: yyis_type85 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type85 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [RENAME_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype86 (v: ANY): EIFFEL_LIST [STRING_AS] is
		require
			valid_type: yyis_type86 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type86 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [STRING_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype87 (v: ANY): EIFFEL_LIST [TAGGED_AS] is
		require
			valid_type: yyis_type87 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type87 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TAGGED_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype88 (v: ANY): EIFFEL_LIST [TYPE] is
		require
			valid_type: yyis_type88 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type88 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE]
		do
			u ?= v
			Result := (u = v)
		end

	yytype89 (v: ANY): EIFFEL_LIST [TYPE_DEC_AS] is
		require
			valid_type: yyis_type89 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type89 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype91 (v: ANY): PAIR [ID_AS, CLICK_AST] is
		require
			valid_type: yyis_type91 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type91 (v: ANY): BOOLEAN is
		local
			u: PAIR [ID_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype92 (v: ANY): PAIR [FEATURE_NAME, CLICK_AST] is
		require
			valid_type: yyis_type92 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type92 (v: ANY): BOOLEAN is
		local
			u: PAIR [FEATURE_NAME, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype93 (v: ANY): PAIR [STRING_AS, CLICK_AST] is
		require
			valid_type: yyis_type93 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type93 (v: ANY): BOOLEAN is
		local
			u: PAIR [STRING_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype94 (v: ANY): PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST] is
		require
			valid_type: yyis_type94 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type94 (v: ANY): BOOLEAN is
		local
			u: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype95 (v: ANY): PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]] is
		require
			valid_type: yyis_type95 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type95 (v: ANY): BOOLEAN is
		local
			u: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 808
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 130
			-- Number of tokens

	yyLast: INTEGER is 2091
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 384
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 313
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
