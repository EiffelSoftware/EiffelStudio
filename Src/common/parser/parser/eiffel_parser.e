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
					--|#line 275 "eiffel.y"
				yy_do_action_10
			when 11 then
					--|#line 279 "eiffel.y"
				yy_do_action_11
			when 12 then
					--|#line 281 "eiffel.y"
				yy_do_action_12
			when 13 then
					--|#line 283 "eiffel.y"
				yy_do_action_13
			when 14 then
					--|#line 287 "eiffel.y"
				yy_do_action_14
			when 15 then
					--|#line 289 "eiffel.y"
				yy_do_action_15
			when 16 then
					--|#line 291 "eiffel.y"
				yy_do_action_16
			when 17 then
					--|#line 295 "eiffel.y"
				yy_do_action_17
			when 18 then
					--|#line 300 "eiffel.y"
				yy_do_action_18
			when 19 then
					--|#line 307 "eiffel.y"
				yy_do_action_19
			when 20 then
					--|#line 311 "eiffel.y"
				yy_do_action_20
			when 21 then
					--|#line 313 "eiffel.y"
				yy_do_action_21
			when 22 then
					--|#line 325 "eiffel.y"
				yy_do_action_22
			when 23 then
					--|#line 330 "eiffel.y"
				yy_do_action_23
			when 24 then
					--|#line 335 "eiffel.y"
				yy_do_action_24
			when 25 then
					--|#line 342 "eiffel.y"
				yy_do_action_25
			when 26 then
					--|#line 344 "eiffel.y"
				yy_do_action_26
			when 27 then
					--|#line 346 "eiffel.y"
				yy_do_action_27
			when 28 then
					--|#line 350 "eiffel.y"
				yy_do_action_28
			when 29 then
					--|#line 360 "eiffel.y"
				yy_do_action_29
			when 30 then
					--|#line 366 "eiffel.y"
				yy_do_action_30
			when 31 then
					--|#line 373 "eiffel.y"
				yy_do_action_31
			when 32 then
					--|#line 379 "eiffel.y"
				yy_do_action_32
			when 33 then
					--|#line 387 "eiffel.y"
				yy_do_action_33
			when 34 then
					--|#line 391 "eiffel.y"
				yy_do_action_34
			when 35 then
					--|#line 402 "eiffel.y"
				yy_do_action_35
			when 36 then
					--|#line 406 "eiffel.y"
				yy_do_action_36
			when 37 then
					--|#line 421 "eiffel.y"
				yy_do_action_37
			when 38 then
					--|#line 423 "eiffel.y"
				yy_do_action_38
			when 39 then
					--|#line 430 "eiffel.y"
				yy_do_action_39
			when 40 then
					--|#line 432 "eiffel.y"
				yy_do_action_40
			when 41 then
					--|#line 441 "eiffel.y"
				yy_do_action_41
			when 42 then
					--|#line 446 "eiffel.y"
				yy_do_action_42
			when 43 then
					--|#line 453 "eiffel.y"
				yy_do_action_43
			when 44 then
					--|#line 455 "eiffel.y"
				yy_do_action_44
			when 45 then
					--|#line 459 "eiffel.y"
				yy_do_action_45
			when 46 then
					--|#line 459 "eiffel.y"
				yy_do_action_46
			when 47 then
					--|#line 468 "eiffel.y"
				yy_do_action_47
			when 48 then
					--|#line 470 "eiffel.y"
				yy_do_action_48
			when 49 then
					--|#line 474 "eiffel.y"
				yy_do_action_49
			when 50 then
					--|#line 479 "eiffel.y"
				yy_do_action_50
			when 51 then
					--|#line 483 "eiffel.y"
				yy_do_action_51
			when 52 then
					--|#line 489 "eiffel.y"
				yy_do_action_52
			when 53 then
					--|#line 497 "eiffel.y"
				yy_do_action_53
			when 54 then
					--|#line 502 "eiffel.y"
				yy_do_action_54
			when 55 then
					--|#line 509 "eiffel.y"
				yy_do_action_55
			when 56 then
					--|#line 510 "eiffel.y"
				yy_do_action_56
			when 57 then
					--|#line 513 "eiffel.y"
				yy_do_action_57
			when 58 then
					--|#line 526 "eiffel.y"
				yy_do_action_58
			when 59 then
					--|#line 528 "eiffel.y"
				yy_do_action_59
			when 60 then
					--|#line 535 "eiffel.y"
				yy_do_action_60
			when 61 then
					--|#line 539 "eiffel.y"
				yy_do_action_61
			when 62 then
					--|#line 541 "eiffel.y"
				yy_do_action_62
			when 63 then
					--|#line 545 "eiffel.y"
				yy_do_action_63
			when 64 then
					--|#line 547 "eiffel.y"
				yy_do_action_64
			when 65 then
					--|#line 549 "eiffel.y"
				yy_do_action_65
			when 66 then
					--|#line 553 "eiffel.y"
				yy_do_action_66
			when 67 then
					--|#line 558 "eiffel.y"
				yy_do_action_67
			when 68 then
					--|#line 562 "eiffel.y"
				yy_do_action_68
			when 69 then
					--|#line 566 "eiffel.y"
				yy_do_action_69
			when 70 then
					--|#line 568 "eiffel.y"
				yy_do_action_70
			when 71 then
					--|#line 572 "eiffel.y"
				yy_do_action_71
			when 72 then
					--|#line 577 "eiffel.y"
				yy_do_action_72
			when 73 then
					--|#line 582 "eiffel.y"
				yy_do_action_73
			when 74 then
					--|#line 593 "eiffel.y"
				yy_do_action_74
			when 75 then
					--|#line 595 "eiffel.y"
				yy_do_action_75
			when 76 then
					--|#line 597 "eiffel.y"
				yy_do_action_76
			when 77 then
					--|#line 601 "eiffel.y"
				yy_do_action_77
			when 78 then
					--|#line 606 "eiffel.y"
				yy_do_action_78
			when 79 then
					--|#line 613 "eiffel.y"
				yy_do_action_79
			when 80 then
					--|#line 618 "eiffel.y"
				yy_do_action_80
			when 81 then
					--|#line 626 "eiffel.y"
				yy_do_action_81
			when 82 then
					--|#line 631 "eiffel.y"
				yy_do_action_82
			when 83 then
					--|#line 636 "eiffel.y"
				yy_do_action_83
			when 84 then
					--|#line 641 "eiffel.y"
				yy_do_action_84
			when 85 then
					--|#line 646 "eiffel.y"
				yy_do_action_85
			when 86 then
					--|#line 651 "eiffel.y"
				yy_do_action_86
			when 87 then
					--|#line 656 "eiffel.y"
				yy_do_action_87
			when 88 then
					--|#line 664 "eiffel.y"
				yy_do_action_88
			when 89 then
					--|#line 666 "eiffel.y"
				yy_do_action_89
			when 90 then
					--|#line 670 "eiffel.y"
				yy_do_action_90
			when 91 then
					--|#line 675 "eiffel.y"
				yy_do_action_91
			when 92 then
					--|#line 682 "eiffel.y"
				yy_do_action_92
			when 93 then
					--|#line 686 "eiffel.y"
				yy_do_action_93
			when 94 then
					--|#line 688 "eiffel.y"
				yy_do_action_94
			when 95 then
					--|#line 692 "eiffel.y"
				yy_do_action_95
			when 96 then
					--|#line 700 "eiffel.y"
				yy_do_action_96
			when 97 then
					--|#line 704 "eiffel.y"
				yy_do_action_97
			when 98 then
					--|#line 711 "eiffel.y"
				yy_do_action_98
			when 99 then
					--|#line 720 "eiffel.y"
				yy_do_action_99
			when 100 then
					--|#line 728 "eiffel.y"
				yy_do_action_100
			when 101 then
					--|#line 730 "eiffel.y"
				yy_do_action_101
			when 102 then
					--|#line 732 "eiffel.y"
				yy_do_action_102
			when 103 then
					--|#line 736 "eiffel.y"
				yy_do_action_103
			when 104 then
					--|#line 738 "eiffel.y"
				yy_do_action_104
			when 105 then
					--|#line 744 "eiffel.y"
				yy_do_action_105
			when 106 then
					--|#line 749 "eiffel.y"
				yy_do_action_106
			when 107 then
					--|#line 757 "eiffel.y"
				yy_do_action_107
			when 108 then
					--|#line 763 "eiffel.y"
				yy_do_action_108
			when 109 then
					--|#line 771 "eiffel.y"
				yy_do_action_109
			when 110 then
					--|#line 776 "eiffel.y"
				yy_do_action_110
			when 111 then
					--|#line 783 "eiffel.y"
				yy_do_action_111
			when 112 then
					--|#line 785 "eiffel.y"
				yy_do_action_112
			when 113 then
					--|#line 789 "eiffel.y"
				yy_do_action_113
			when 114 then
					--|#line 791 "eiffel.y"
				yy_do_action_114
			when 115 then
					--|#line 795 "eiffel.y"
				yy_do_action_115
			when 116 then
					--|#line 797 "eiffel.y"
				yy_do_action_116
			when 117 then
					--|#line 801 "eiffel.y"
				yy_do_action_117
			when 118 then
					--|#line 803 "eiffel.y"
				yy_do_action_118
			when 119 then
					--|#line 807 "eiffel.y"
				yy_do_action_119
			when 120 then
					--|#line 809 "eiffel.y"
				yy_do_action_120
			when 121 then
					--|#line 813 "eiffel.y"
				yy_do_action_121
			when 122 then
					--|#line 815 "eiffel.y"
				yy_do_action_122
			when 123 then
					--|#line 823 "eiffel.y"
				yy_do_action_123
			when 124 then
					--|#line 825 "eiffel.y"
				yy_do_action_124
			when 125 then
					--|#line 829 "eiffel.y"
				yy_do_action_125
			when 126 then
					--|#line 831 "eiffel.y"
				yy_do_action_126
			when 127 then
					--|#line 835 "eiffel.y"
				yy_do_action_127
			when 128 then
					--|#line 840 "eiffel.y"
				yy_do_action_128
			when 129 then
					--|#line 847 "eiffel.y"
				yy_do_action_129
			when 130 then
					--|#line 851 "eiffel.y"
				yy_do_action_130
			when 131 then
					--|#line 852 "eiffel.y"
				yy_do_action_131
			when 132 then
					--|#line 861 "eiffel.y"
				yy_do_action_132
			when 133 then
					--|#line 863 "eiffel.y"
				yy_do_action_133
			when 134 then
					--|#line 867 "eiffel.y"
				yy_do_action_134
			when 135 then
					--|#line 872 "eiffel.y"
				yy_do_action_135
			when 136 then
					--|#line 879 "eiffel.y"
				yy_do_action_136
			when 137 then
					--|#line 883 "eiffel.y"
				yy_do_action_137
			when 138 then
					--|#line 889 "eiffel.y"
				yy_do_action_138
			when 139 then
					--|#line 897 "eiffel.y"
				yy_do_action_139
			when 140 then
					--|#line 899 "eiffel.y"
				yy_do_action_140
			when 141 then
					--|#line 903 "eiffel.y"
				yy_do_action_141
			when 142 then
					--|#line 905 "eiffel.y"
				yy_do_action_142
			when 143 then
					--|#line 909 "eiffel.y"
				yy_do_action_143
			when 144 then
					--|#line 909 "eiffel.y"
				yy_do_action_144
			when 145 then
					--|#line 921 "eiffel.y"
				yy_do_action_145
			when 146 then
					--|#line 923 "eiffel.y"
				yy_do_action_146
			when 147 then
					--|#line 925 "eiffel.y"
				yy_do_action_147
			when 148 then
					--|#line 929 "eiffel.y"
				yy_do_action_148
			when 149 then
					--|#line 936 "eiffel.y"
				yy_do_action_149
			when 150 then
					--|#line 941 "eiffel.y"
				yy_do_action_150
			when 151 then
					--|#line 943 "eiffel.y"
				yy_do_action_151
			when 152 then
					--|#line 947 "eiffel.y"
				yy_do_action_152
			when 153 then
					--|#line 949 "eiffel.y"
				yy_do_action_153
			when 154 then
					--|#line 953 "eiffel.y"
				yy_do_action_154
			when 155 then
					--|#line 955 "eiffel.y"
				yy_do_action_155
			when 156 then
					--|#line 959 "eiffel.y"
				yy_do_action_156
			when 157 then
					--|#line 961 "eiffel.y"
				yy_do_action_157
			when 158 then
					--|#line 965 "eiffel.y"
				yy_do_action_158
			when 159 then
					--|#line 970 "eiffel.y"
				yy_do_action_159
			when 160 then
					--|#line 977 "eiffel.y"
				yy_do_action_160
			when 161 then
					--|#line 981 "eiffel.y"
				yy_do_action_161
			when 162 then
					--|#line 982 "eiffel.y"
				yy_do_action_162
			when 163 then
					--|#line 985 "eiffel.y"
				yy_do_action_163
			when 164 then
					--|#line 987 "eiffel.y"
				yy_do_action_164
			when 165 then
					--|#line 989 "eiffel.y"
				yy_do_action_165
			when 166 then
					--|#line 991 "eiffel.y"
				yy_do_action_166
			when 167 then
					--|#line 993 "eiffel.y"
				yy_do_action_167
			when 168 then
					--|#line 995 "eiffel.y"
				yy_do_action_168
			when 169 then
					--|#line 997 "eiffel.y"
				yy_do_action_169
			when 170 then
					--|#line 999 "eiffel.y"
				yy_do_action_170
			when 171 then
					--|#line 1001 "eiffel.y"
				yy_do_action_171
			when 172 then
					--|#line 1003 "eiffel.y"
				yy_do_action_172
			when 173 then
					--|#line 1007 "eiffel.y"
				yy_do_action_173
			when 174 then
					--|#line 1009 "eiffel.y"
				yy_do_action_174
			when 175 then
					--|#line 1009 "eiffel.y"
				yy_do_action_175
			when 176 then
					--|#line 1016 "eiffel.y"
				yy_do_action_176
			when 177 then
					--|#line 1016 "eiffel.y"
				yy_do_action_177
			when 178 then
					--|#line 1025 "eiffel.y"
				yy_do_action_178
			when 179 then
					--|#line 1027 "eiffel.y"
				yy_do_action_179
			when 180 then
					--|#line 1027 "eiffel.y"
				yy_do_action_180
			when 181 then
					--|#line 1034 "eiffel.y"
				yy_do_action_181
			when 182 then
					--|#line 1034 "eiffel.y"
				yy_do_action_182
			when 183 then
					--|#line 1043 "eiffel.y"
				yy_do_action_183
			when 184 then
					--|#line 1045 "eiffel.y"
				yy_do_action_184
			when 185 then
					--|#line 1054 "eiffel.y"
				yy_do_action_185
			when 186 then
					--|#line 1059 "eiffel.y"
				yy_do_action_186
			when 187 then
					--|#line 1066 "eiffel.y"
				yy_do_action_187
			when 188 then
					--|#line 1070 "eiffel.y"
				yy_do_action_188
			when 189 then
					--|#line 1072 "eiffel.y"
				yy_do_action_189
			when 190 then
					--|#line 1074 "eiffel.y"
				yy_do_action_190
			when 191 then
					--|#line 1082 "eiffel.y"
				yy_do_action_191
			when 192 then
					--|#line 1084 "eiffel.y"
				yy_do_action_192
			when 193 then
					--|#line 1088 "eiffel.y"
				yy_do_action_193
			when 194 then
					--|#line 1090 "eiffel.y"
				yy_do_action_194
			when 195 then
					--|#line 1092 "eiffel.y"
				yy_do_action_195
			when 196 then
					--|#line 1094 "eiffel.y"
				yy_do_action_196
			when 197 then
					--|#line 1096 "eiffel.y"
				yy_do_action_197
			when 198 then
					--|#line 1098 "eiffel.y"
				yy_do_action_198
			when 199 then
					--|#line 1100 "eiffel.y"
				yy_do_action_199
			when 200 then
					--|#line 1104 "eiffel.y"
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
					--|#line 1108 "eiffel.y"
				yy_do_action_201
			when 202 then
					--|#line 1110 "eiffel.y"
				yy_do_action_202
			when 203 then
					--|#line 1112 "eiffel.y"
				yy_do_action_203
			when 204 then
					--|#line 1116 "eiffel.y"
				yy_do_action_204
			when 205 then
					--|#line 1118 "eiffel.y"
				yy_do_action_205
			when 206 then
					--|#line 1122 "eiffel.y"
				yy_do_action_206
			when 207 then
					--|#line 1127 "eiffel.y"
				yy_do_action_207
			when 208 then
					--|#line 1138 "eiffel.y"
				yy_do_action_208
			when 209 then
					--|#line 1144 "eiffel.y"
				yy_do_action_209
			when 210 then
					--|#line 1152 "eiffel.y"
				yy_do_action_210
			when 211 then
					--|#line 1154 "eiffel.y"
				yy_do_action_211
			when 212 then
					--|#line 1158 "eiffel.y"
				yy_do_action_212
			when 213 then
					--|#line 1163 "eiffel.y"
				yy_do_action_213
			when 214 then
					--|#line 1170 "eiffel.y"
				yy_do_action_214
			when 215 then
					--|#line 1187 "eiffel.y"
				yy_do_action_215
			when 216 then
					--|#line 1205 "eiffel.y"
				yy_do_action_216
			when 217 then
					--|#line 1224 "eiffel.y"
				yy_do_action_217
			when 218 then
					--|#line 1224 "eiffel.y"
				yy_do_action_218
			when 219 then
					--|#line 1237 "eiffel.y"
				yy_do_action_219
			when 220 then
					--|#line 1239 "eiffel.y"
				yy_do_action_220
			when 221 then
					--|#line 1247 "eiffel.y"
				yy_do_action_221
			when 222 then
					--|#line 1249 "eiffel.y"
				yy_do_action_222
			when 223 then
					--|#line 1257 "eiffel.y"
				yy_do_action_223
			when 224 then
					--|#line 1263 "eiffel.y"
				yy_do_action_224
			when 225 then
					--|#line 1265 "eiffel.y"
				yy_do_action_225
			when 226 then
					--|#line 1269 "eiffel.y"
				yy_do_action_226
			when 227 then
					--|#line 1274 "eiffel.y"
				yy_do_action_227
			when 228 then
					--|#line 1281 "eiffel.y"
				yy_do_action_228
			when 229 then
					--|#line 1285 "eiffel.y"
				yy_do_action_229
			when 230 then
					--|#line 1287 "eiffel.y"
				yy_do_action_230
			when 231 then
					--|#line 1291 "eiffel.y"
				yy_do_action_231
			when 232 then
					--|#line 1297 "eiffel.y"
				yy_do_action_232
			when 233 then
					--|#line 1299 "eiffel.y"
				yy_do_action_233
			when 234 then
					--|#line 1303 "eiffel.y"
				yy_do_action_234
			when 235 then
					--|#line 1308 "eiffel.y"
				yy_do_action_235
			when 236 then
					--|#line 1315 "eiffel.y"
				yy_do_action_236
			when 237 then
					--|#line 1319 "eiffel.y"
				yy_do_action_237
			when 238 then
					--|#line 1324 "eiffel.y"
				yy_do_action_238
			when 239 then
					--|#line 1331 "eiffel.y"
				yy_do_action_239
			when 240 then
					--|#line 1333 "eiffel.y"
				yy_do_action_240
			when 241 then
					--|#line 1335 "eiffel.y"
				yy_do_action_241
			when 242 then
					--|#line 1337 "eiffel.y"
				yy_do_action_242
			when 243 then
					--|#line 1339 "eiffel.y"
				yy_do_action_243
			when 244 then
					--|#line 1341 "eiffel.y"
				yy_do_action_244
			when 245 then
					--|#line 1343 "eiffel.y"
				yy_do_action_245
			when 246 then
					--|#line 1345 "eiffel.y"
				yy_do_action_246
			when 247 then
					--|#line 1347 "eiffel.y"
				yy_do_action_247
			when 248 then
					--|#line 1349 "eiffel.y"
				yy_do_action_248
			when 249 then
					--|#line 1351 "eiffel.y"
				yy_do_action_249
			when 250 then
					--|#line 1353 "eiffel.y"
				yy_do_action_250
			when 251 then
					--|#line 1355 "eiffel.y"
				yy_do_action_251
			when 252 then
					--|#line 1357 "eiffel.y"
				yy_do_action_252
			when 253 then
					--|#line 1359 "eiffel.y"
				yy_do_action_253
			when 254 then
					--|#line 1361 "eiffel.y"
				yy_do_action_254
			when 255 then
					--|#line 1363 "eiffel.y"
				yy_do_action_255
			when 256 then
					--|#line 1365 "eiffel.y"
				yy_do_action_256
			when 257 then
					--|#line 1370 "eiffel.y"
				yy_do_action_257
			when 258 then
					--|#line 1372 "eiffel.y"
				yy_do_action_258
			when 259 then
					--|#line 1381 "eiffel.y"
				yy_do_action_259
			when 260 then
					--|#line 1387 "eiffel.y"
				yy_do_action_260
			when 261 then
					--|#line 1389 "eiffel.y"
				yy_do_action_261
			when 262 then
					--|#line 1393 "eiffel.y"
				yy_do_action_262
			when 263 then
					--|#line 1395 "eiffel.y"
				yy_do_action_263
			when 264 then
					--|#line 1395 "eiffel.y"
				yy_do_action_264
			when 265 then
					--|#line 1405 "eiffel.y"
				yy_do_action_265
			when 266 then
					--|#line 1407 "eiffel.y"
				yy_do_action_266
			when 267 then
					--|#line 1409 "eiffel.y"
				yy_do_action_267
			when 268 then
					--|#line 1413 "eiffel.y"
				yy_do_action_268
			when 269 then
					--|#line 1419 "eiffel.y"
				yy_do_action_269
			when 270 then
					--|#line 1421 "eiffel.y"
				yy_do_action_270
			when 271 then
					--|#line 1423 "eiffel.y"
				yy_do_action_271
			when 272 then
					--|#line 1427 "eiffel.y"
				yy_do_action_272
			when 273 then
					--|#line 1432 "eiffel.y"
				yy_do_action_273
			when 274 then
					--|#line 1439 "eiffel.y"
				yy_do_action_274
			when 275 then
					--|#line 1443 "eiffel.y"
				yy_do_action_275
			when 276 then
					--|#line 1445 "eiffel.y"
				yy_do_action_276
			when 277 then
					--|#line 1454 "eiffel.y"
				yy_do_action_277
			when 278 then
					--|#line 1456 "eiffel.y"
				yy_do_action_278
			when 279 then
					--|#line 1460 "eiffel.y"
				yy_do_action_279
			when 280 then
					--|#line 1462 "eiffel.y"
				yy_do_action_280
			when 281 then
					--|#line 1466 "eiffel.y"
				yy_do_action_281
			when 282 then
					--|#line 1468 "eiffel.y"
				yy_do_action_282
			when 283 then
					--|#line 1472 "eiffel.y"
				yy_do_action_283
			when 284 then
					--|#line 1477 "eiffel.y"
				yy_do_action_284
			when 285 then
					--|#line 1484 "eiffel.y"
				yy_do_action_285
			when 286 then
					--|#line 1490 "eiffel.y"
				yy_do_action_286
			when 287 then
					--|#line 1495 "eiffel.y"
				yy_do_action_287
			when 288 then
					--|#line 1500 "eiffel.y"
				yy_do_action_288
			when 289 then
					--|#line 1510 "eiffel.y"
				yy_do_action_289
			when 290 then
					--|#line 1520 "eiffel.y"
				yy_do_action_290
			when 291 then
					--|#line 1532 "eiffel.y"
				yy_do_action_291
			when 292 then
					--|#line 1534 "eiffel.y"
				yy_do_action_292
			when 293 then
					--|#line 1536 "eiffel.y"
				yy_do_action_293
			when 294 then
					--|#line 1554 "eiffel.y"
				yy_do_action_294
			when 295 then
					--|#line 1556 "eiffel.y"
				yy_do_action_295
			when 296 then
					--|#line 1558 "eiffel.y"
				yy_do_action_296
			when 297 then
					--|#line 1560 "eiffel.y"
				yy_do_action_297
			when 298 then
					--|#line 1562 "eiffel.y"
				yy_do_action_298
			when 299 then
					--|#line 1564 "eiffel.y"
				yy_do_action_299
			when 300 then
					--|#line 1566 "eiffel.y"
				yy_do_action_300
			when 301 then
					--|#line 1570 "eiffel.y"
				yy_do_action_301
			when 302 then
					--|#line 1572 "eiffel.y"
				yy_do_action_302
			when 303 then
					--|#line 1574 "eiffel.y"
				yy_do_action_303
			when 304 then
					--|#line 1576 "eiffel.y"
				yy_do_action_304
			when 305 then
					--|#line 1578 "eiffel.y"
				yy_do_action_305
			when 306 then
					--|#line 1580 "eiffel.y"
				yy_do_action_306
			when 307 then
					--|#line 1584 "eiffel.y"
				yy_do_action_307
			when 308 then
					--|#line 1586 "eiffel.y"
				yy_do_action_308
			when 309 then
					--|#line 1588 "eiffel.y"
				yy_do_action_309
			when 310 then
					--|#line 1592 "eiffel.y"
				yy_do_action_310
			when 311 then
					--|#line 1597 "eiffel.y"
				yy_do_action_311
			when 312 then
					--|#line 1604 "eiffel.y"
				yy_do_action_312
			when 313 then
					--|#line 1610 "eiffel.y"
				yy_do_action_313
			when 314 then
					--|#line 1612 "eiffel.y"
				yy_do_action_314
			when 315 then
					--|#line 1614 "eiffel.y"
				yy_do_action_315
			when 316 then
					--|#line 1616 "eiffel.y"
				yy_do_action_316
			when 317 then
					--|#line 1618 "eiffel.y"
				yy_do_action_317
			when 318 then
					--|#line 1620 "eiffel.y"
				yy_do_action_318
			when 319 then
					--|#line 1622 "eiffel.y"
				yy_do_action_319
			when 320 then
					--|#line 1624 "eiffel.y"
				yy_do_action_320
			when 321 then
					--|#line 1626 "eiffel.y"
				yy_do_action_321
			when 322 then
					--|#line 1628 "eiffel.y"
				yy_do_action_322
			when 323 then
					--|#line 1632 "eiffel.y"
				yy_do_action_323
			when 324 then
					--|#line 1641 "eiffel.y"
				yy_do_action_324
			when 325 then
					--|#line 1643 "eiffel.y"
				yy_do_action_325
			when 326 then
					--|#line 1647 "eiffel.y"
				yy_do_action_326
			when 327 then
					--|#line 1649 "eiffel.y"
				yy_do_action_327
			when 328 then
					--|#line 1660 "eiffel.y"
				yy_do_action_328
			when 329 then
					--|#line 1662 "eiffel.y"
				yy_do_action_329
			when 330 then
					--|#line 1666 "eiffel.y"
				yy_do_action_330
			when 331 then
					--|#line 1668 "eiffel.y"
				yy_do_action_331
			when 332 then
					--|#line 1672 "eiffel.y"
				yy_do_action_332
			when 333 then
					--|#line 1674 "eiffel.y"
				yy_do_action_333
			when 334 then
					--|#line 1682 "eiffel.y"
				yy_do_action_334
			when 335 then
					--|#line 1684 "eiffel.y"
				yy_do_action_335
			when 336 then
					--|#line 1686 "eiffel.y"
				yy_do_action_336
			when 337 then
					--|#line 1688 "eiffel.y"
				yy_do_action_337
			when 338 then
					--|#line 1690 "eiffel.y"
				yy_do_action_338
			when 339 then
					--|#line 1692 "eiffel.y"
				yy_do_action_339
			when 340 then
					--|#line 1694 "eiffel.y"
				yy_do_action_340
			when 341 then
					--|#line 1696 "eiffel.y"
				yy_do_action_341
			when 342 then
					--|#line 1698 "eiffel.y"
				yy_do_action_342
			when 343 then
					--|#line 1702 "eiffel.y"
				yy_do_action_343
			when 344 then
					--|#line 1710 "eiffel.y"
				yy_do_action_344
			when 345 then
					--|#line 1712 "eiffel.y"
				yy_do_action_345
			when 346 then
					--|#line 1714 "eiffel.y"
				yy_do_action_346
			when 347 then
					--|#line 1716 "eiffel.y"
				yy_do_action_347
			when 348 then
					--|#line 1718 "eiffel.y"
				yy_do_action_348
			when 349 then
					--|#line 1720 "eiffel.y"
				yy_do_action_349
			when 350 then
					--|#line 1722 "eiffel.y"
				yy_do_action_350
			when 351 then
					--|#line 1724 "eiffel.y"
				yy_do_action_351
			when 352 then
					--|#line 1726 "eiffel.y"
				yy_do_action_352
			when 353 then
					--|#line 1728 "eiffel.y"
				yy_do_action_353
			when 354 then
					--|#line 1730 "eiffel.y"
				yy_do_action_354
			when 355 then
					--|#line 1732 "eiffel.y"
				yy_do_action_355
			when 356 then
					--|#line 1734 "eiffel.y"
				yy_do_action_356
			when 357 then
					--|#line 1736 "eiffel.y"
				yy_do_action_357
			when 358 then
					--|#line 1738 "eiffel.y"
				yy_do_action_358
			when 359 then
					--|#line 1740 "eiffel.y"
				yy_do_action_359
			when 360 then
					--|#line 1742 "eiffel.y"
				yy_do_action_360
			when 361 then
					--|#line 1744 "eiffel.y"
				yy_do_action_361
			when 362 then
					--|#line 1746 "eiffel.y"
				yy_do_action_362
			when 363 then
					--|#line 1748 "eiffel.y"
				yy_do_action_363
			when 364 then
					--|#line 1750 "eiffel.y"
				yy_do_action_364
			when 365 then
					--|#line 1752 "eiffel.y"
				yy_do_action_365
			when 366 then
					--|#line 1754 "eiffel.y"
				yy_do_action_366
			when 367 then
					--|#line 1756 "eiffel.y"
				yy_do_action_367
			when 368 then
					--|#line 1758 "eiffel.y"
				yy_do_action_368
			when 369 then
					--|#line 1760 "eiffel.y"
				yy_do_action_369
			when 370 then
					--|#line 1762 "eiffel.y"
				yy_do_action_370
			when 371 then
					--|#line 1764 "eiffel.y"
				yy_do_action_371
			when 372 then
					--|#line 1766 "eiffel.y"
				yy_do_action_372
			when 373 then
					--|#line 1768 "eiffel.y"
				yy_do_action_373
			when 374 then
					--|#line 1770 "eiffel.y"
				yy_do_action_374
			when 375 then
					--|#line 1772 "eiffel.y"
				yy_do_action_375
			when 376 then
					--|#line 1774 "eiffel.y"
				yy_do_action_376
			when 377 then
					--|#line 1776 "eiffel.y"
				yy_do_action_377
			when 378 then
					--|#line 1778 "eiffel.y"
				yy_do_action_378
			when 379 then
					--|#line 1780 "eiffel.y"
				yy_do_action_379
			when 380 then
					--|#line 1782 "eiffel.y"
				yy_do_action_380
			when 381 then
					--|#line 1786 "eiffel.y"
				yy_do_action_381
			when 382 then
					--|#line 1794 "eiffel.y"
				yy_do_action_382
			when 383 then
					--|#line 1796 "eiffel.y"
				yy_do_action_383
			when 384 then
					--|#line 1798 "eiffel.y"
				yy_do_action_384
			when 385 then
					--|#line 1800 "eiffel.y"
				yy_do_action_385
			when 386 then
					--|#line 1802 "eiffel.y"
				yy_do_action_386
			when 387 then
					--|#line 1804 "eiffel.y"
				yy_do_action_387
			when 388 then
					--|#line 1806 "eiffel.y"
				yy_do_action_388
			when 389 then
					--|#line 1808 "eiffel.y"
				yy_do_action_389
			when 390 then
					--|#line 1810 "eiffel.y"
				yy_do_action_390
			when 391 then
					--|#line 1812 "eiffel.y"
				yy_do_action_391
			when 392 then
					--|#line 1814 "eiffel.y"
				yy_do_action_392
			when 393 then
					--|#line 1816 "eiffel.y"
				yy_do_action_393
			when 394 then
					--|#line 1820 "eiffel.y"
				yy_do_action_394
			when 395 then
					--|#line 1824 "eiffel.y"
				yy_do_action_395
			when 396 then
					--|#line 1828 "eiffel.y"
				yy_do_action_396
			when 397 then
					--|#line 1832 "eiffel.y"
				yy_do_action_397
			when 398 then
					--|#line 1836 "eiffel.y"
				yy_do_action_398
			when 399 then
					--|#line 1840 "eiffel.y"
				yy_do_action_399
			when 400 then
					--|#line 1842 "eiffel.y"
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
					--|#line 1844 "eiffel.y"
				yy_do_action_401
			when 402 then
					--|#line 1846 "eiffel.y"
				yy_do_action_402
			when 403 then
					--|#line 1850 "eiffel.y"
				yy_do_action_403
			when 404 then
					--|#line 1854 "eiffel.y"
				yy_do_action_404
			when 405 then
					--|#line 1861 "eiffel.y"
				yy_do_action_405
			when 406 then
					--|#line 1869 "eiffel.y"
				yy_do_action_406
			when 407 then
					--|#line 1871 "eiffel.y"
				yy_do_action_407
			when 408 then
					--|#line 1875 "eiffel.y"
				yy_do_action_408
			when 409 then
					--|#line 1877 "eiffel.y"
				yy_do_action_409
			when 410 then
					--|#line 1881 "eiffel.y"
				yy_do_action_410
			when 411 then
					--|#line 1883 "eiffel.y"
				yy_do_action_411
			when 412 then
					--|#line 1885 "eiffel.y"
				yy_do_action_412
			when 413 then
					--|#line 1889 "eiffel.y"
				yy_do_action_413
			when 414 then
					--|#line 1902 "eiffel.y"
				yy_do_action_414
			when 415 then
					--|#line 1906 "eiffel.y"
				yy_do_action_415
			when 416 then
					--|#line 1908 "eiffel.y"
				yy_do_action_416
			when 417 then
					--|#line 1910 "eiffel.y"
				yy_do_action_417
			when 418 then
					--|#line 1914 "eiffel.y"
				yy_do_action_418
			when 419 then
					--|#line 1919 "eiffel.y"
				yy_do_action_419
			when 420 then
					--|#line 1926 "eiffel.y"
				yy_do_action_420
			when 421 then
					--|#line 1928 "eiffel.y"
				yy_do_action_421
			when 422 then
					--|#line 1932 "eiffel.y"
				yy_do_action_422
			when 423 then
					--|#line 1937 "eiffel.y"
				yy_do_action_423
			when 424 then
					--|#line 1948 "eiffel.y"
				yy_do_action_424
			when 425 then
					--|#line 1957 "eiffel.y"
				yy_do_action_425
			when 426 then
					--|#line 1959 "eiffel.y"
				yy_do_action_426
			when 427 then
					--|#line 1961 "eiffel.y"
				yy_do_action_427
			when 428 then
					--|#line 1963 "eiffel.y"
				yy_do_action_428
			when 429 then
					--|#line 1965 "eiffel.y"
				yy_do_action_429
			when 430 then
					--|#line 1967 "eiffel.y"
				yy_do_action_430
			when 431 then
					--|#line 1971 "eiffel.y"
				yy_do_action_431
			when 432 then
					--|#line 1973 "eiffel.y"
				yy_do_action_432
			when 433 then
					--|#line 1975 "eiffel.y"
				yy_do_action_433
			when 434 then
					--|#line 1990 "eiffel.y"
				yy_do_action_434
			when 435 then
					--|#line 1992 "eiffel.y"
				yy_do_action_435
			when 436 then
					--|#line 1994 "eiffel.y"
				yy_do_action_436
			when 437 then
					--|#line 1996 "eiffel.y"
				yy_do_action_437
			when 438 then
					--|#line 2003 "eiffel.y"
				yy_do_action_438
			when 439 then
					--|#line 2005 "eiffel.y"
				yy_do_action_439
			when 440 then
					--|#line 2009 "eiffel.y"
				yy_do_action_440
			when 441 then
					--|#line 2016 "eiffel.y"
				yy_do_action_441
			when 442 then
					--|#line 2031 "eiffel.y"
				yy_do_action_442
			when 443 then
					--|#line 2046 "eiffel.y"
				yy_do_action_443
			when 444 then
					--|#line 2064 "eiffel.y"
				yy_do_action_444
			when 445 then
					--|#line 2066 "eiffel.y"
				yy_do_action_445
			when 446 then
					--|#line 2068 "eiffel.y"
				yy_do_action_446
			when 447 then
					--|#line 2075 "eiffel.y"
				yy_do_action_447
			when 448 then
					--|#line 2079 "eiffel.y"
				yy_do_action_448
			when 449 then
					--|#line 2081 "eiffel.y"
				yy_do_action_449
			when 450 then
					--|#line 2083 "eiffel.y"
				yy_do_action_450
			when 451 then
					--|#line 2087 "eiffel.y"
				yy_do_action_451
			when 452 then
					--|#line 2089 "eiffel.y"
				yy_do_action_452
			when 453 then
					--|#line 2091 "eiffel.y"
				yy_do_action_453
			when 454 then
					--|#line 2093 "eiffel.y"
				yy_do_action_454
			when 455 then
					--|#line 2095 "eiffel.y"
				yy_do_action_455
			when 456 then
					--|#line 2097 "eiffel.y"
				yy_do_action_456
			when 457 then
					--|#line 2099 "eiffel.y"
				yy_do_action_457
			when 458 then
					--|#line 2101 "eiffel.y"
				yy_do_action_458
			when 459 then
					--|#line 2103 "eiffel.y"
				yy_do_action_459
			when 460 then
					--|#line 2105 "eiffel.y"
				yy_do_action_460
			when 461 then
					--|#line 2107 "eiffel.y"
				yy_do_action_461
			when 462 then
					--|#line 2109 "eiffel.y"
				yy_do_action_462
			when 463 then
					--|#line 2111 "eiffel.y"
				yy_do_action_463
			when 464 then
					--|#line 2113 "eiffel.y"
				yy_do_action_464
			when 465 then
					--|#line 2115 "eiffel.y"
				yy_do_action_465
			when 466 then
					--|#line 2117 "eiffel.y"
				yy_do_action_466
			when 467 then
					--|#line 2119 "eiffel.y"
				yy_do_action_467
			when 468 then
					--|#line 2121 "eiffel.y"
				yy_do_action_468
			when 469 then
					--|#line 2123 "eiffel.y"
				yy_do_action_469
			when 470 then
					--|#line 2125 "eiffel.y"
				yy_do_action_470
			when 471 then
					--|#line 2127 "eiffel.y"
				yy_do_action_471
			when 472 then
					--|#line 2131 "eiffel.y"
				yy_do_action_472
			when 473 then
					--|#line 2133 "eiffel.y"
				yy_do_action_473
			when 474 then
					--|#line 2135 "eiffel.y"
				yy_do_action_474
			when 475 then
					--|#line 2137 "eiffel.y"
				yy_do_action_475
			when 476 then
					--|#line 2141 "eiffel.y"
				yy_do_action_476
			when 477 then
					--|#line 2143 "eiffel.y"
				yy_do_action_477
			when 478 then
					--|#line 2145 "eiffel.y"
				yy_do_action_478
			when 479 then
					--|#line 2147 "eiffel.y"
				yy_do_action_479
			when 480 then
					--|#line 2149 "eiffel.y"
				yy_do_action_480
			when 481 then
					--|#line 2151 "eiffel.y"
				yy_do_action_481
			when 482 then
					--|#line 2153 "eiffel.y"
				yy_do_action_482
			when 483 then
					--|#line 2155 "eiffel.y"
				yy_do_action_483
			when 484 then
					--|#line 2157 "eiffel.y"
				yy_do_action_484
			when 485 then
					--|#line 2159 "eiffel.y"
				yy_do_action_485
			when 486 then
					--|#line 2161 "eiffel.y"
				yy_do_action_486
			when 487 then
					--|#line 2163 "eiffel.y"
				yy_do_action_487
			when 488 then
					--|#line 2165 "eiffel.y"
				yy_do_action_488
			when 489 then
					--|#line 2167 "eiffel.y"
				yy_do_action_489
			when 490 then
					--|#line 2169 "eiffel.y"
				yy_do_action_490
			when 491 then
					--|#line 2171 "eiffel.y"
				yy_do_action_491
			when 492 then
					--|#line 2173 "eiffel.y"
				yy_do_action_492
			when 493 then
					--|#line 2175 "eiffel.y"
				yy_do_action_493
			when 494 then
					--|#line 2179 "eiffel.y"
				yy_do_action_494
			when 495 then
					--|#line 2183 "eiffel.y"
				yy_do_action_495
			when 496 then
					--|#line 2187 "eiffel.y"
				yy_do_action_496
			when 497 then
					--|#line 2191 "eiffel.y"
				yy_do_action_497
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
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_10 is
			--|#line 275 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 275 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 275")
end



			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_11 is
			--|#line 279 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 279 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 279")
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

	yy_do_action_12 is
			--|#line 281 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 281 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 281")
end


yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_13 is
			--|#line 283 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 283 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 283")
end


yyval81 := Void 
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_14 is
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

	yy_do_action_15 is
			--|#line 289 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 289 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 289")
end


yyval81 := yytype81 (yyvs.item (yyvsp - 1)) 
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_16 is
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
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_17 is
			--|#line 295 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 295 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 295")
end


				yyval81 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval81.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_18 is
			--|#line 300 "eiffel.y"
		local
			yyval81: INDEXING_CLAUSE_AS
		do
--|#line 300 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 300")
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

	yy_do_action_19 is
			--|#line 307 "eiffel.y"
		local
			yyval35: INDEX_AS
		do
--|#line 307 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 307")
end


yyval35 := new_index_as (yytype33 (yyvs.item (yyvsp - 2)), yytype66 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval35
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_20 is
			--|#line 311 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 311 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 311")
end


yyval33 := yytype33 (yyvs.item (yyvsp - 1)) 
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_21 is
			--|#line 313 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 313 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 313")
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

	yy_do_action_22 is
			--|#line 325 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 325 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 325")
end


				yyval66 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval66.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval66
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_23 is
			--|#line 330 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 330 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 330")
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

	yy_do_action_24 is
			--|#line 335 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 335 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 335")
end


-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval66 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval66
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_25 is
			--|#line 342 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 342 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 342")
end


yyval7 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_26 is
			--|#line 344 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 344 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 344")
end


yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_27 is
			--|#line 346 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 346 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 346")
end


				create {CUSTOM_ATTRIBUTE_AS} yyval7.initialize (yytype20 (yyvs.item (yyvsp - 1)), Void)
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_28 is
			--|#line 350 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 350 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 350")
end


				create {CUSTOM_ATTRIBUTE_AS} yyval7.initialize (yytype20 (yyvs.item (yyvsp - 2)), yytype62 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_29 is
			--|#line 360 "eiffel.y"
		do
--|#line 360 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 360")
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

	yy_do_action_30 is
			--|#line 366 "eiffel.y"
		do
--|#line 366 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 366")
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

	yy_do_action_31 is
			--|#line 373 "eiffel.y"
		do
--|#line 373 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 373")
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

	yy_do_action_32 is
			--|#line 379 "eiffel.y"
		do
--|#line 379 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 379")
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

	yy_do_action_33 is
			--|#line 387 "eiffel.y"
		do
--|#line 387 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 387")
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

	yy_do_action_34 is
			--|#line 391 "eiffel.y"
		do
--|#line 391 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 391")
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

	yy_do_action_35 is
			--|#line 402 "eiffel.y"
		do
--|#line 402 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 402")
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

	yy_do_action_36 is
			--|#line 406 "eiffel.y"
		do
--|#line 406 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 406")
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

	yy_do_action_37 is
			--|#line 421 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 421 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 421")
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

	yy_do_action_38 is
			--|#line 423 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 423 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 423")
end


yyval60 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_39 is
			--|#line 430 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 430 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 430")
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

	yy_do_action_40 is
			--|#line 432 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 432 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 432")
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

	yy_do_action_41 is
			--|#line 441 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 441 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 441")
end


				yyval74 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval74, yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval74
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_42 is
			--|#line 446 "eiffel.y"
		local
			yyval74: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 446 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 446")
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

	yy_do_action_43 is
			--|#line 453 "eiffel.y"
		local
			yyval29: FEATURE_CLAUSE_AS
		do
--|#line 453 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 453")
end


yyval29 := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) 
			yyval := yyval29
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_44 is
			--|#line 455 "eiffel.y"
		local
			yyval29: FEATURE_CLAUSE_AS
		do
--|#line 455 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 455")
end


yyval29 := new_feature_clause_as (yytype15 (yyvs.item (yyvsp - 1)), yytype73 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval29
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_45 is
			--|#line 459 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 459 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 459")
end


yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_46 is
			--|#line 459 "eiffel.y"
		do
--|#line 459 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 459")
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

	yy_do_action_47 is
			--|#line 468 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 468 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 468")
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

	yy_do_action_48 is
			--|#line 470 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 470 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 470")
end


yyval15 := new_client_as (yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval15
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_49 is
			--|#line 474 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [ID_AS]
		do
--|#line 474 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 474")
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

	yy_do_action_50 is
			--|#line 479 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [ID_AS]
		do
--|#line 479 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 479")
end


yyval78 := yytype78 (yyvs.item (yyvsp - 1)) 
			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_51 is
			--|#line 483 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [ID_AS]
		do
--|#line 483 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 483")
end


				yyval78 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval78.extend (yytype92 (yyvs.item (yyvsp)).first)
				yytype92 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype92 (yyvs.item (yyvsp)).first, Void, False, False, False))
			
			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_52 is
			--|#line 489 "eiffel.y"
		local
			yyval78: EIFFEL_LIST [ID_AS]
		do
--|#line 489 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 489")
end


				yyval78 := yytype78 (yyvs.item (yyvsp - 2))
				yyval78.extend (yytype92 (yyvs.item (yyvsp)).first)
				yytype92 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype92 (yyvs.item (yyvsp)).first, Void, False, False, False))
			
			yyval := yyval78
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_53 is
			--|#line 497 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_AS]
		do
--|#line 497 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 497")
end


				yyval73 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval73.extend (yytype28 (yyvs.item (yyvsp)))
			
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_54 is
			--|#line 502 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_AS]
		do
--|#line 502 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 502")
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

	yy_do_action_55 is
			--|#line 509 "eiffel.y"
		do
--|#line 509 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 509")
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

	yy_do_action_56 is
			--|#line 510 "eiffel.y"
		do
--|#line 510 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 510")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_57 is
			--|#line 513 "eiffel.y"
		local
			yyval28: FEATURE_AS
		do
--|#line 513 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 513")
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

	yy_do_action_58 is
			--|#line 526 "eiffel.y"
		local
			yyval95: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
--|#line 526 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 526")
end


yyval95 := new_clickable_feature_name_list (yytype93 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval95
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_59 is
			--|#line 528 "eiffel.y"
		local
			yyval95: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
--|#line 528 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 528")
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

	yy_do_action_60 is
			--|#line 535 "eiffel.y"
		local
			yyval93: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 535 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 535")
end


yyval93 := yytype93 (yyvs.item (yyvsp)) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_61 is
			--|#line 539 "eiffel.y"
		do
--|#line 539 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 539")
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

	yy_do_action_62 is
			--|#line 541 "eiffel.y"
		do
--|#line 541 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 541")
end

			yyval := yyval_default;
is_frozen := True 

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_63 is
			--|#line 545 "eiffel.y"
		local
			yyval93: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 545 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 545")
end


yyval93 := new_clickable_feature_name (yytype92 (yyvs.item (yyvsp))) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_64 is
			--|#line 547 "eiffel.y"
		local
			yyval93: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 547 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 547")
end


yyval93 := yytype93 (yyvs.item (yyvsp)) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_65 is
			--|#line 549 "eiffel.y"
		local
			yyval93: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 549 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 549")
end


yyval93 := yytype93 (yyvs.item (yyvsp)) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_66 is
			--|#line 553 "eiffel.y"
		local
			yyval93: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 553 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 553")
end


yyval93 := new_clickable_infix (yytype94 (yyvs.item (yyvsp))) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_67 is
			--|#line 558 "eiffel.y"
		local
			yyval93: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 558 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 558")
end


yyval93 := new_clickable_prefix (yytype94 (yyvs.item (yyvsp))) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_68 is
			--|#line 562 "eiffel.y"
		local
			yyval9: BODY_AS
		do
--|#line 562 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 562")
end


yyval9 := new_declaration_body (yytype90 (yyvs.item (yyvsp - 2)), yytype63 (yyvs.item (yyvsp - 1)), yytype16 (yyvs.item (yyvsp))) 
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_69 is
			--|#line 566 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 566 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 566")
end


feature_indexes := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_70 is
			--|#line 568 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 568 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 568")
end


yyval16 := yytype16 (yyvs.item (yyvsp)) 
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_71 is
			--|#line 572 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 572 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 572")
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

	yy_do_action_72 is
			--|#line 577 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 577 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 577")
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

	yy_do_action_73 is
			--|#line 582 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 582 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 582")
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

	yy_do_action_74 is
			--|#line 593 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [PARENT_AS]
		do
--|#line 593 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 593")
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

	yy_do_action_75 is
			--|#line 595 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [PARENT_AS]
		do
--|#line 595 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 595")
end


yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_76 is
			--|#line 597 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [PARENT_AS]
		do
--|#line 597 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 597")
end


yyval85 := new_eiffel_list_parent_as (0) 
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_77 is
			--|#line 601 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [PARENT_AS]
		do
--|#line 601 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 601")
end


				yyval85 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval85.extend (yytype47 (yyvs.item (yyvsp)))
			
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_78 is
			--|#line 606 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [PARENT_AS]
		do
--|#line 606 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 606")
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

	yy_do_action_79 is
			--|#line 613 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 613 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 613")
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

	yy_do_action_80 is
			--|#line 618 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 618 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 618")
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
				yyval47 := new_parent_clause (yytype92 (yyvs.item (yyvsp - 1)), yytype89 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_82 is
			--|#line 631 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 631 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 631")
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

	yy_do_action_83 is
			--|#line 636 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 636 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 636")
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

	yy_do_action_84 is
			--|#line 641 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 641 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 641")
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

	yy_do_action_85 is
			--|#line 646 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 646 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 646")
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

	yy_do_action_86 is
			--|#line 651 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 651 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 651")
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

	yy_do_action_87 is
			--|#line 656 "eiffel.y"
		local
			yyval47: PARENT_AS
		do
--|#line 656 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 656")
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

	yy_do_action_88 is
			--|#line 664 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [RENAME_AS]
		do
--|#line 664 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 664")
end



			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_89 is
			--|#line 666 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [RENAME_AS]
		do
--|#line 666 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 666")
end


yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_90 is
			--|#line 670 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [RENAME_AS]
		do
--|#line 670 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 670")
end


				yyval86 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval86.extend (yytype51 (yyvs.item (yyvsp)))
			
			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_91 is
			--|#line 675 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [RENAME_AS]
		do
--|#line 675 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 675")
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

	yy_do_action_92 is
			--|#line 682 "eiffel.y"
		local
			yyval51: RENAME_AS
		do
--|#line 682 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 682")
end


yyval51 := new_rename_pair (yytype93 (yyvs.item (yyvsp - 2)), yytype93 (yyvs.item (yyvsp))) 
			yyval := yyval51
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_93 is
			--|#line 686 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 686 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 686")
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

	yy_do_action_94 is
			--|#line 688 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 688 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 688")
end


yyval71 := yytype71 (yyvs.item (yyvsp)) 
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_95 is
			--|#line 692 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 692 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 692")
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

	yy_do_action_96 is
			--|#line 700 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 700 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 700")
end



			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_97 is
			--|#line 704 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 704 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 704")
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

	yy_do_action_98 is
			--|#line 711 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 711 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 711")
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

	yy_do_action_99 is
			--|#line 720 "eiffel.y"
		local
			yyval24: EXPORT_ITEM_AS
		do
--|#line 720 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 720")
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

	yy_do_action_100 is
			--|#line 728 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 728 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 728")
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

	yy_do_action_101 is
			--|#line 730 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 730 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 730")
end


yyval30 := new_all_as 
			yyval := yyval30
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_102 is
			--|#line 732 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 732 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 732")
end


yyval30 := new_feature_list_as (yytype76 (yyvs.item (yyvsp))) 
			yyval := yyval30
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_103 is
			--|#line 736 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 736 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 736")
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

	yy_do_action_104 is
			--|#line 738 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 738 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 738")
end


			yyval68 := yytype68 (yyvs.item (yyvsp))
		
			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_105 is
			--|#line 744 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 744 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 744")
end


			yyval68 := new_eiffel_list_convert (Initial_convert_list_size)
			yyval68.extend (yytype17 (yyvs.item (yyvsp)))
		
			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_106 is
			--|#line 749 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 749 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 749")
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

	yy_do_action_107 is
			--|#line 757 "eiffel.y"
		local
			yyval17: CONVERT_FEAT_AS
		do
--|#line 757 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 757")
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

	yy_do_action_108 is
			--|#line 763 "eiffel.y"
		local
			yyval17: CONVERT_FEAT_AS
		do
--|#line 763 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 763")
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

	yy_do_action_109 is
			--|#line 771 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 771 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 771")
end


				yyval76 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval76.extend (yytype93 (yyvs.item (yyvsp)).first)
			
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_110 is
			--|#line 776 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 776 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 776")
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

	yy_do_action_111 is
			--|#line 783 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 783 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 783")
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

	yy_do_action_112 is
			--|#line 785 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 785 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 785")
end


yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_113 is
			--|#line 789 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 789 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 789")
end



			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_114 is
			--|#line 791 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 791 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 791")
end


yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_115 is
			--|#line 795 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 795 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 795")
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

	yy_do_action_116 is
			--|#line 797 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 797 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 797")
end


yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_117 is
			--|#line 801 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 801 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 801")
end



			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_118 is
			--|#line 803 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 803 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 803")
end


yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_119 is
			--|#line 807 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 807 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 807")
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

	yy_do_action_120 is
			--|#line 809 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 809 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 809")
end


yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_121 is
			--|#line 813 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 813 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 813")
end



			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_122 is
			--|#line 815 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 815 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 815")
end


yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_123 is
			--|#line 823 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 823 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 823")
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

	yy_do_action_124 is
			--|#line 825 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 825 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 825")
end


yyval90 := yytype90 (yyvs.item (yyvsp - 1)) 
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_125 is
			--|#line 829 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 829 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 829")
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

	yy_do_action_126 is
			--|#line 831 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 831 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 831")
end


yyval90 := yytype90 (yyvs.item (yyvsp)) 
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_127 is
			--|#line 835 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 835 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 835")
end


				yyval90 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval90.extend (yytype64 (yyvs.item (yyvsp)))
			
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_128 is
			--|#line 840 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 840 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 840")
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

	yy_do_action_129 is
			--|#line 847 "eiffel.y"
		local
			yyval64: TYPE_DEC_AS
		do
--|#line 847 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 847")
end


yyval64 := new_type_dec_as (yytype80 (yyvs.item (yyvsp - 5)), yytype63 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 4))) 
			yyval := yyval64
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_130 is
			--|#line 851 "eiffel.y"
		do
--|#line 851 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 851")
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

	yy_do_action_131 is
			--|#line 852 "eiffel.y"
		do
--|#line 852 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 852")
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

	yy_do_action_132 is
			--|#line 861 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 861 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 861")
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

	yy_do_action_133 is
			--|#line 863 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 863 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 863")
end


yyval90 := yytype90 (yyvs.item (yyvsp)) 
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_134 is
			--|#line 867 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 867 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 867")
end


				yyval90 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval90.extend (yytype64 (yyvs.item (yyvsp)))
			
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_135 is
			--|#line 872 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 872 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 872")
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

	yy_do_action_136 is
			--|#line 879 "eiffel.y"
		local
			yyval64: TYPE_DEC_AS
		do
--|#line 879 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 879")
end


yyval64 := new_type_dec_as (yytype80 (yyvs.item (yyvsp - 4)), yytype63 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval64
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_137 is
			--|#line 883 "eiffel.y"
		local
			yyval80: ARRAYED_LIST [INTEGER]
		do
--|#line 883 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 883")
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

	yy_do_action_138 is
			--|#line 889 "eiffel.y"
		local
			yyval80: ARRAYED_LIST [INTEGER]
		do
--|#line 889 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 889")
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

	yy_do_action_139 is
			--|#line 897 "eiffel.y"
		local
			yyval80: ARRAYED_LIST [INTEGER]
		do
--|#line 897 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 897")
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

	yy_do_action_140 is
			--|#line 899 "eiffel.y"
		local
			yyval80: ARRAYED_LIST [INTEGER]
		do
--|#line 899 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 899")
end


yyval80 := yytype80 (yyvs.item (yyvsp)) 
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_141 is
			--|#line 903 "eiffel.y"
		local
			yyval63: TYPE
		do
--|#line 903 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 903")
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

	yy_do_action_142 is
			--|#line 905 "eiffel.y"
		local
			yyval63: TYPE
		do
--|#line 905 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 905")
end


yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_143 is
			--|#line 909 "eiffel.y"
		local
			yyval56: ROUTINE_AS
		do
--|#line 909 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 909")
end


yyval56 := new_routine_as (yytype60 (yyvs.item (yyvsp - 7)), yytype52 (yyvs.item (yyvsp - 5)), yytype90 (yyvs.item (yyvsp - 4)), yytype55 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp - 1)), fbody_pos, current_position) 
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_144 is
			--|#line 909 "eiffel.y"
		do
--|#line 909 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 909")
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

	yy_do_action_145 is
			--|#line 921 "eiffel.y"
		local
			yyval55: ROUT_BODY_AS
		do
--|#line 921 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 921")
end


yyval55 := yytype40 (yyvs.item (yyvsp)) 
			yyval := yyval55
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_146 is
			--|#line 923 "eiffel.y"
		local
			yyval55: ROUT_BODY_AS
		do
--|#line 923 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 923")
end


yyval55 := yytype26 (yyvs.item (yyvsp)) 
			yyval := yyval55
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_147 is
			--|#line 925 "eiffel.y"
		local
			yyval55: ROUT_BODY_AS
		do
--|#line 925 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 925")
end


yyval55 := new_deferred_as 
			yyval := yyval55
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_148 is
			--|#line 929 "eiffel.y"
		local
			yyval26: EXTERNAL_AS
		do
--|#line 929 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 929")
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

	yy_do_action_149 is
			--|#line 936 "eiffel.y"
		local
			yyval27: EXTERNAL_LANG_AS
		do
--|#line 936 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 936")
end


yyval27 := new_external_lang_as (yytype60 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval27
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_150 is
			--|#line 941 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 941 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 941")
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

	yy_do_action_151 is
			--|#line 943 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 943 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 943")
end


yyval60 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_152 is
			--|#line 947 "eiffel.y"
		local
			yyval40: INTERNAL_AS
		do
--|#line 947 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 947")
end


yyval40 := new_do_as (yytype82 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_153 is
			--|#line 949 "eiffel.y"
		local
			yyval40: INTERNAL_AS
		do
--|#line 949 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 949")
end


yyval40 := new_once_as (yytype82 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_154 is
			--|#line 953 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 953 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 953")
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

	yy_do_action_155 is
			--|#line 955 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 955 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 955")
end


yyval90 := yytype90 (yyvs.item (yyvsp)) 
			yyval := yyval90
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_156 is
			--|#line 959 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 959 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 959")
end



			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_157 is
			--|#line 961 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 961 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 961")
end


yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_158 is
			--|#line 965 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 965 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 965")
end


				yyval82 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval82.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_159 is
			--|#line 970 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 970 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 970")
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

	yy_do_action_160 is
			--|#line 977 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 977 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 977")
end


yyval38 := yytype38 (yyvs.item (yyvsp - 1)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_161 is
			--|#line 981 "eiffel.y"
		do
--|#line 981 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 981")
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

	yy_do_action_162 is
			--|#line 982 "eiffel.y"
		do
--|#line 982 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 982")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_163 is
			--|#line 985 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 985 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 985")
end


yyval38 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_164 is
			--|#line 987 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 987 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 987")
end


yyval38 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_165 is
			--|#line 989 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 989 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 989")
end


yyval38 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_166 is
			--|#line 991 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 991 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 991")
end


yyval38 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_167 is
			--|#line 993 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 993 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 993")
end


yyval38 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_168 is
			--|#line 995 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 995 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 995")
end


yyval38 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_169 is
			--|#line 997 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 997 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 997")
end


yyval38 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_170 is
			--|#line 999 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 999 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 999")
end


yyval38 := yytype21 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_171 is
			--|#line 1001 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 1001 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1001")
end


yyval38 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_172 is
			--|#line 1003 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 1003 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1003")
end


yyval38 := yytype53 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_173 is
			--|#line 1007 "eiffel.y"
		local
			yyval52: REQUIRE_AS
		do
--|#line 1007 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1007")
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

	yy_do_action_174 is
			--|#line 1009 "eiffel.y"
		local
			yyval52: REQUIRE_AS
		do
--|#line 1009 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1009")
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

	yy_do_action_175 is
			--|#line 1009 "eiffel.y"
		do
--|#line 1009 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1009")
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

	yy_do_action_176 is
			--|#line 1016 "eiffel.y"
		local
			yyval52: REQUIRE_AS
		do
--|#line 1016 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1016")
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

	yy_do_action_177 is
			--|#line 1016 "eiffel.y"
		do
--|#line 1016 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1016")
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

	yy_do_action_178 is
			--|#line 1025 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1025 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1025")
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

	yy_do_action_179 is
			--|#line 1027 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1027 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1027")
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

	yy_do_action_180 is
			--|#line 1027 "eiffel.y"
		do
--|#line 1027 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1027")
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

	yy_do_action_181 is
			--|#line 1034 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1034 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1034")
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

	yy_do_action_182 is
			--|#line 1034 "eiffel.y"
		do
--|#line 1034 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1034")
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

	yy_do_action_183 is
			--|#line 1043 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1043 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1043")
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

	yy_do_action_184 is
			--|#line 1045 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1045 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1045")
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

	yy_do_action_185 is
			--|#line 1054 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1054 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1054")
end


				yyval88 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval88, yytype61 (yyvs.item (yyvsp)))
			
			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_186 is
			--|#line 1059 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1059 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1059")
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

	yy_do_action_187 is
			--|#line 1066 "eiffel.y"
		local
			yyval61: TAGGED_AS
		do
--|#line 1066 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1066")
end


yyval61 := yytype61 (yyvs.item (yyvsp - 1)) 
			yyval := yyval61
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_188 is
			--|#line 1070 "eiffel.y"
		local
			yyval61: TAGGED_AS
		do
--|#line 1070 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1070")
end


yyval61 := new_tagged_as (Void, yytype25 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval61
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_189 is
			--|#line 1072 "eiffel.y"
		local
			yyval61: TAGGED_AS
		do
--|#line 1072 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1072")
end


yyval61 := new_tagged_as (yytype33 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval61
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_190 is
			--|#line 1074 "eiffel.y"
		local
			yyval61: TAGGED_AS
		do
--|#line 1074 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1074")
end



			yyval := yyval61
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_191 is
			--|#line 1082 "eiffel.y"
		local
			yyval63: TYPE
		do
--|#line 1082 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1082")
end


yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_192 is
			--|#line 1084 "eiffel.y"
		local
			yyval63: TYPE
		do
--|#line 1084 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1084")
end


yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_193 is
			--|#line 1088 "eiffel.y"
		local
			yyval63: TYPE
		do
--|#line 1088 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1088")
end


yyval63 := new_class_type (yytype92 (yyvs.item (yyvsp - 1)), yytype89 (yyvs.item (yyvsp)), False, True, False) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_194 is
			--|#line 1090 "eiffel.y"
		local
			yyval63: TYPE
		do
--|#line 1090 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1090")
end


yyval63 := new_class_type (yytype92 (yyvs.item (yyvsp - 1)), yytype89 (yyvs.item (yyvsp)), True, False, False) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_195 is
			--|#line 1092 "eiffel.y"
		local
			yyval63: TYPE
		do
--|#line 1092 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1092")
end


yyval63 := new_class_type (yytype92 (yyvs.item (yyvsp - 1)), yytype89 (yyvs.item (yyvsp)), False, False, True) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_196 is
			--|#line 1094 "eiffel.y"
		local
			yyval63: TYPE
		do
--|#line 1094 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1094")
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
			--|#line 1096 "eiffel.y"
		local
			yyval63: TYPE
		do
--|#line 1096 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1096")
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
			--|#line 1098 "eiffel.y"
		local
			yyval63: TYPE
		do
--|#line 1098 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1098")
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
			--|#line 1100 "eiffel.y"
		local
			yyval63: TYPE
		do
--|#line 1100 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1100")
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
			--|#line 1104 "eiffel.y"
		local
			yyval63: TYPE
		do
--|#line 1104 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1104")
end


yyval63 := new_class_type (yytype92 (yyvs.item (yyvsp - 1)), yytype89 (yyvs.item (yyvsp)), False, False, False) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_201 is
			--|#line 1108 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE]
		do
--|#line 1108 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1108")
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
			--|#line 1110 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE]
		do
--|#line 1110 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1110")
end



			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_203 is
			--|#line 1112 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE]
		do
--|#line 1112 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1112")
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
			--|#line 1116 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE]
		do
--|#line 1116 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1116")
end



			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_205 is
			--|#line 1118 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE]
		do
--|#line 1118 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1118")
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
			--|#line 1122 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE]
		do
--|#line 1122 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1122")
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
			--|#line 1127 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE]
		do
--|#line 1127 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1127")
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
			--|#line 1138 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1138 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1138")
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
			--|#line 1144 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1144 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1144")
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
			--|#line 1152 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1152 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1152")
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
			--|#line 1154 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1154 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1154")
end


yyval77 := yytype77 (yyvs.item (yyvsp)) 
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_212 is
			--|#line 1158 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1158 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1158")
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
			--|#line 1163 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1163 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1163")
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
			--|#line 1170 "eiffel.y"
		local
			yyval31: FORMAL_AS
		do
--|#line 1170 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1170")
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
			--|#line 1187 "eiffel.y"
		local
			yyval31: FORMAL_AS
		do
--|#line 1187 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1187")
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
			--|#line 1205 "eiffel.y"
		local
			yyval31: FORMAL_AS
		do
--|#line 1205 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1205")
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
			--|#line 1224 "eiffel.y"
		local
			yyval32: FORMAL_DEC_AS
		do
--|#line 1224 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1224")
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
			--|#line 1224 "eiffel.y"
		do
--|#line 1224 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1224")
end

			yyval := yyval_default;
					-- Needs to be done here, in case current formal is used in
					-- Constraint.
				formal_parameters.extend (yytype31 (yyvs.item (yyvsp)))
				yytype31 (yyvs.item (yyvsp)).set_position (formal_parameters.count)
			

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
			--|#line 1237 "eiffel.y"
		local
			yyval96: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
--|#line 1237 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1237")
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
			--|#line 1239 "eiffel.y"
		local
			yyval96: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
--|#line 1239 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1239")
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
			--|#line 1247 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 1247 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1247")
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
			--|#line 1249 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 1249 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1249")
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
			--|#line 1257 "eiffel.y"
		local
			yyval34: IF_AS
		do
--|#line 1257 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1257")
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
			--|#line 1263 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1263 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1263")
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
			--|#line 1265 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1265 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1265")
end


yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_226 is
			--|#line 1269 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1269 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1269")
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
			--|#line 1274 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1274 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1274")
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
			--|#line 1281 "eiffel.y"
		local
			yyval22: ELSIF_AS
		do
--|#line 1281 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1281")
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
			--|#line 1285 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1285 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1285")
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
			--|#line 1287 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1287 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1287")
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
			--|#line 1291 "eiffel.y"
		local
			yyval36: INSPECT_AS
		do
--|#line 1291 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1291")
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
			--|#line 1297 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CASE_AS]
		do
--|#line 1297 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1297")
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
			--|#line 1299 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CASE_AS]
		do
--|#line 1299 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1299")
end


yyval67 := yytype67 (yyvs.item (yyvsp)) 
			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_234 is
			--|#line 1303 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CASE_AS]
		do
--|#line 1303 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1303")
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
			--|#line 1308 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CASE_AS]
		do
--|#line 1308 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1308")
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
			--|#line 1315 "eiffel.y"
		local
			yyval12: CASE_AS
		do
--|#line 1315 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1315")
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
			--|#line 1319 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line 1319 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1319")
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
			--|#line 1324 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line 1324 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1324")
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
			--|#line 1331 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1331 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1331")
end


yyval41 := new_interval_as (yytype39 (yyvs.item (yyvsp)), Void) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_240 is
			--|#line 1333 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1333 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1333")
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
			--|#line 1335 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1335 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1335")
end


yyval41 := new_interval_as (yytype13 (yyvs.item (yyvsp)), Void) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_242 is
			--|#line 1337 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1337 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1337")
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
			--|#line 1339 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1339 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1339")
end


yyval41 := new_interval_as (yytype33 (yyvs.item (yyvsp)), Void) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_244 is
			--|#line 1341 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1341 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1341")
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
			--|#line 1343 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1343 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1343")
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
			--|#line 1345 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1345 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1345")
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
			--|#line 1347 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1347 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1347")
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
			--|#line 1349 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1349 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1349")
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
			--|#line 1351 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1351 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1351")
end


yyval41 := new_interval_as (yytype49 (yyvs.item (yyvsp)), Void) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_250 is
			--|#line 1353 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1353 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1353")
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
			--|#line 1355 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1355 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1355")
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
			--|#line 1357 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1357 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1357")
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
			--|#line 1359 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1359 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1359")
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
			--|#line 1361 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1361 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1361")
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
			--|#line 1363 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1363 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1363")
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
			--|#line 1365 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1365 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1365")
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
			--|#line 1370 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1370 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1370")
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
			--|#line 1372 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1372 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1372")
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
			--|#line 1381 "eiffel.y"
		local
			yyval43: LOOP_AS
		do
--|#line 1381 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1381")
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
			--|#line 1387 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1387 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1387")
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
			--|#line 1389 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1389 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1389")
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
			--|#line 1393 "eiffel.y"
		local
			yyval42: INVARIANT_AS
		do
--|#line 1393 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1393")
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
			--|#line 1395 "eiffel.y"
		local
			yyval42: INVARIANT_AS
		do
--|#line 1395 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1395")
end


				id_level := Normal_level
				inherit_context := False
				yyval42 := new_invariant_as (yytype88 (yyvs.item (yyvsp)))
			
			yyval := yyval42
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_264 is
			--|#line 1395 "eiffel.y"
		do
--|#line 1395 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1395")
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

	yy_do_action_265 is
			--|#line 1405 "eiffel.y"
		local
			yyval65: VARIANT_AS
		do
--|#line 1405 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1405")
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
			--|#line 1407 "eiffel.y"
		local
			yyval65: VARIANT_AS
		do
--|#line 1407 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1407")
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
			--|#line 1409 "eiffel.y"
		local
			yyval65: VARIANT_AS
		do
--|#line 1409 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1409")
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
			--|#line 1413 "eiffel.y"
		local
			yyval21: DEBUG_AS
		do
--|#line 1413 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1413")
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
			--|#line 1419 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1419 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1419")
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
			--|#line 1421 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1421 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1421")
end



			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_271 is
			--|#line 1423 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1423 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1423")
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
			--|#line 1427 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1427 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1427")
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
			--|#line 1432 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1432 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1432")
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
			--|#line 1439 "eiffel.y"
		local
			yyval53: RETRY_AS
		do
--|#line 1439 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1439")
end


yyval53 := new_retry_as (current_position) 
			yyval := yyval53
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_275 is
			--|#line 1443 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1443 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1443")
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
			--|#line 1445 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1445 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1445")
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
			--|#line 1454 "eiffel.y"
		local
			yyval6: ASSIGN_AS
		do
--|#line 1454 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1454")
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
			--|#line 1456 "eiffel.y"
		local
			yyval6: ASSIGN_AS
		do
--|#line 1456 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1456")
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
			--|#line 1460 "eiffel.y"
		local
			yyval54: REVERSE_AS
		do
--|#line 1460 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1460")
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
			--|#line 1462 "eiffel.y"
		local
			yyval54: REVERSE_AS
		do
--|#line 1462 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1462")
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
			--|#line 1466 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1466 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1466")
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
			--|#line 1468 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1468 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1468")
end


yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_283 is
			--|#line 1472 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1472 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1472")
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
			--|#line 1477 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1477 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1477")
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
			--|#line 1484 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1484 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1484")
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
			--|#line 1490 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1490 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1490")
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
			--|#line 1495 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1495 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1495")
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
			--|#line 1500 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1500 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1500")
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
			--|#line 1510 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1510 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1510")
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
			--|#line 1520 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1520 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1520")
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
			--|#line 1532 "eiffel.y"
		local
			yyval57: ROUTINE_CREATION_AS
		do
--|#line 1532 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1532")
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
			--|#line 1534 "eiffel.y"
		local
			yyval57: ROUTINE_CREATION_AS
		do
--|#line 1534 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1534")
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
			--|#line 1536 "eiffel.y"
		local
			yyval57: ROUTINE_CREATION_AS
		do
--|#line 1536 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1536")
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
			--|#line 1554 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1554 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1554")
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
			--|#line 1556 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1556 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1556")
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
			--|#line 1558 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1558 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1558")
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
			--|#line 1560 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1560 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1560")
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
			--|#line 1562 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1562 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1562")
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
			--|#line 1564 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1564 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1564")
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
			--|#line 1566 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1566 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1566")
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
			--|#line 1570 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1570 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1570")
end


yyval46 := new_operand_as (Void, yytype33 (yyvs.item (yyvsp)), Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_302 is
			--|#line 1572 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1572 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1572")
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
			--|#line 1574 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1574 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1574")
end


yyval46 := new_result_operand_as 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_304 is
			--|#line 1576 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1576 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1576")
end


yyval46 := new_operand_as (Void, Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_305 is
			--|#line 1578 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1578 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1578")
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
			--|#line 1580 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1580 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1580")
end


yyval46 := Void 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_307 is
			--|#line 1584 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1584 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1584")
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
			--|#line 1586 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1586 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1586")
end



			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_309 is
			--|#line 1588 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1588 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1588")
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
			--|#line 1592 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1592 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1592")
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
			--|#line 1597 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1597 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1597")
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
			--|#line 1604 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1604 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1604")
end


yyval46 := new_operand_as (Void, Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_313 is
			--|#line 1610 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1610 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1610")
end


yyval46 := new_operand_as (new_class_type (yytype92 (yyvs.item (yyvsp - 1)), Void, False, False, False), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_314 is
			--|#line 1612 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1612 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1612")
end


yyval46 := new_operand_as (new_class_type (yytype92 (yyvs.item (yyvsp - 2)), yytype89 (yyvs.item (yyvsp - 1)), False, False, False), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_315 is
			--|#line 1614 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1614 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1614")
end


yyval46 := new_operand_as (new_class_type (yytype92 (yyvs.item (yyvsp - 2)), yytype89 (yyvs.item (yyvsp - 1)), True, False, False), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_316 is
			--|#line 1616 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1616 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1616")
end


yyval46 := new_operand_as (new_class_type (yytype92 (yyvs.item (yyvsp - 2)), yytype89 (yyvs.item (yyvsp - 1)), False, True, False), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_317 is
			--|#line 1618 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1618 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1618")
end


yyval46 := new_operand_as (new_class_type (yytype92 (yyvs.item (yyvsp - 2)), yytype89 (yyvs.item (yyvsp - 1)), False, False, True), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_318 is
			--|#line 1620 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1620 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1620")
end


yyval46 := new_operand_as (new_bits_as (yytype39 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_319 is
			--|#line 1622 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1622 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1622")
end


yyval46 := new_operand_as (new_bits_symbol_as (yytype33 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_320 is
			--|#line 1624 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1624 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1624")
end


yyval46 := new_operand_as (new_like_id_as (yytype33 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_321 is
			--|#line 1626 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1626 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1626")
end


yyval46 := new_operand_as (new_like_current_as, Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_322 is
			--|#line 1628 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1628 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1628")
end


yyval46 := new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_323 is
			--|#line 1632 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1632 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1632")
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

	yy_do_action_324 is
			--|#line 1641 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1641 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1641")
end


yyval19 := new_creation_as (Void, yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_325 is
			--|#line 1643 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1643 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1643")
end


yyval19 := new_creation_as (yytype63 (yyvs.item (yyvsp - 3)), yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 6))) 
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_326 is
			--|#line 1647 "eiffel.y"
		local
			yyval20: CREATION_EXPR_AS
		do
--|#line 1647 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1647")
end


yyval20 := new_creation_expr_as (yytype63 (yyvs.item (yyvsp - 3)), yytype4 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval20
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_327 is
			--|#line 1649 "eiffel.y"
		local
			yyval20: CREATION_EXPR_AS
		do
--|#line 1649 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1649")
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

	yy_do_action_328 is
			--|#line 1660 "eiffel.y"
		local
			yyval63: TYPE
		do
--|#line 1660 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1660")
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

	yy_do_action_329 is
			--|#line 1662 "eiffel.y"
		local
			yyval63: TYPE
		do
--|#line 1662 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1662")
end


yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_330 is
			--|#line 1666 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1666 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1666")
end


yyval2 := new_access_id_as (yytype33 (yyvs.item (yyvsp)), Void) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_331 is
			--|#line 1668 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1668 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1668")
end


yyval2 := new_result_as 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_332 is
			--|#line 1672 "eiffel.y"
		local
			yyval4: ACCESS_INV_AS
		do
--|#line 1672 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1672")
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

	yy_do_action_333 is
			--|#line 1674 "eiffel.y"
		local
			yyval4: ACCESS_INV_AS
		do
--|#line 1674 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1674")
end


yyval4 := new_access_inv_as (yytype33 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_334 is
			--|#line 1682 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1682 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1682")
end


yyval37 := new_instr_call_as (yytype2 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_335 is
			--|#line 1684 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1684 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1684")
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
			--|#line 1686 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1686 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1686")
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
			--|#line 1688 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1688 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1688")
end


yyval37 := new_instr_call_as (yytype44 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_338 is
			--|#line 1690 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1690 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1690")
end


yyval37 := new_instr_call_as (yytype45 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_339 is
			--|#line 1692 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1692 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1692")
end


yyval37 := new_instr_call_as (yytype48 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_340 is
			--|#line 1694 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1694 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1694")
end


yyval37 := new_instr_call_as (yytype44 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_341 is
			--|#line 1696 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1696 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1696")
end


yyval37 := new_instr_call_as (yytype49 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_342 is
			--|#line 1698 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1698 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1698")
end


yyval37 := new_instr_call_as (yytype44 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_343 is
			--|#line 1702 "eiffel.y"
		local
			yyval14: CHECK_AS
		do
--|#line 1702 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1702")
end


yyval14 := new_check_as (yytype88 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 3)), current_position) 
			yyval := yyval14
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_344 is
			--|#line 1710 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1710 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1710")
end


create {VALUE_AS} yyval25.initialize (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_345 is
			--|#line 1712 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1712 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1712")
end


create {VOID_AS} yyval25 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_346 is
			--|#line 1714 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1714 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1714")
end


create {VALUE_AS} yyval25.initialize (yytype5 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_347 is
			--|#line 1716 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1716 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1716")
end


create {VALUE_AS} yyval25.initialize (yytype62 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_348 is
			--|#line 1718 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1718 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1718")
end


yyval25 := new_expr_call_as (yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_349 is
			--|#line 1720 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1720 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1720")
end


yyval25 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_350 is
			--|#line 1722 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1722 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1722")
end


yyval25 := new_paran_as (yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_351 is
			--|#line 1724 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1724 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1724")
end


yyval25 := new_bin_plus_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_352 is
			--|#line 1726 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1726 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1726")
end


yyval25 := new_bin_minus_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_353 is
			--|#line 1728 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1728 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1728")
end


yyval25 := new_bin_star_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_354 is
			--|#line 1730 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1730 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1730")
end


yyval25 := new_bin_slash_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_355 is
			--|#line 1732 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1732 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1732")
end


yyval25 := new_bin_mod_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_356 is
			--|#line 1734 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1734 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1734")
end


yyval25 := new_bin_div_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_357 is
			--|#line 1736 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1736 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1736")
end


yyval25 := new_bin_power_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_358 is
			--|#line 1738 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1738 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1738")
end


yyval25 := new_bin_and_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_359 is
			--|#line 1740 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1740 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1740")
end


yyval25 := new_bin_and_then_as (yytype25 (yyvs.item (yyvsp - 3)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_360 is
			--|#line 1742 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1742 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1742")
end


yyval25 := new_bin_or_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_361 is
			--|#line 1744 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1744 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1744")
end


yyval25 := new_bin_or_else_as (yytype25 (yyvs.item (yyvsp - 3)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_362 is
			--|#line 1746 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1746 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1746")
end


yyval25 := new_bin_implies_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_363 is
			--|#line 1748 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1748 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1748")
end


yyval25 := new_bin_xor_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_364 is
			--|#line 1750 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1750 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1750")
end


yyval25 := new_bin_ge_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_365 is
			--|#line 1752 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1752 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1752")
end


yyval25 := new_bin_gt_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_366 is
			--|#line 1754 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1754 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1754")
end


yyval25 := new_bin_le_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_367 is
			--|#line 1756 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1756 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1756")
end


yyval25 := new_bin_lt_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_368 is
			--|#line 1758 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1758 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1758")
end


yyval25 := new_bin_eq_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_369 is
			--|#line 1760 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1760 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1760")
end


yyval25 := new_bin_ne_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_370 is
			--|#line 1762 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1762 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1762")
end


yyval25 := new_bin_free_as (yytype25 (yyvs.item (yyvsp - 2)), yytype33 (yyvs.item (yyvsp - 1)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_371 is
			--|#line 1764 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1764 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1764")
end


yyval25 := new_un_minus_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_372 is
			--|#line 1766 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1766 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1766")
end


yyval25 := new_un_plus_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_373 is
			--|#line 1768 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1768 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1768")
end


yyval25 := new_un_not_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_374 is
			--|#line 1770 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1770 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1770")
end


yyval25 := new_un_old_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_375 is
			--|#line 1772 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1772 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1772")
end


yyval25 := new_un_free_as (yytype33 (yyvs.item (yyvsp - 1)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_376 is
			--|#line 1774 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1774 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1774")
end


yyval25 := new_un_strip_as (yytype80 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_377 is
			--|#line 1776 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1776 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1776")
end


yyval25 := new_address_as (yytype93 (yyvs.item (yyvsp)).first) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_378 is
			--|#line 1778 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1778 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1778")
end


yyval25 := new_expr_address_as (yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_379 is
			--|#line 1780 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1780 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1780")
end


yyval25 := new_address_current_as 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_380 is
			--|#line 1782 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1782 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1782")
end


yyval25 := new_address_result_as 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_381 is
			--|#line 1786 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1786 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1786")
end


create yyval33.initialize (token_buffer) 
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_382 is
			--|#line 1794 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1794 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1794")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_383 is
			--|#line 1796 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1796 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1796")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_384 is
			--|#line 1798 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1798 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1798")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_385 is
			--|#line 1800 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1800 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1800")
end


yyval11 := new_current_as 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_386 is
			--|#line 1802 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1802 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1802")
end


yyval11 := new_result_as 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_387 is
			--|#line 1804 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1804 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1804")
end


yyval11 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_388 is
			--|#line 1806 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1806 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1806")
end


yyval11 := yytype45 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_389 is
			--|#line 1808 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1808 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1808")
end


yyval11 := yytype48 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_390 is
			--|#line 1810 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1810 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1810")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_391 is
			--|#line 1812 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1812 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1812")
end


yyval11 := yytype49 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_392 is
			--|#line 1814 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1814 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1814")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_393 is
			--|#line 1816 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1816 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1816")
end


yyval11 := yytype20 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_394 is
			--|#line 1820 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1820 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1820")
end


yyval44 := new_nested_as (new_current_as, yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_395 is
			--|#line 1824 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1824 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1824")
end


yyval44 := new_nested_as (new_result_as, yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_396 is
			--|#line 1828 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1828 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1828")
end


yyval44 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_397 is
			--|#line 1832 "eiffel.y"
		local
			yyval45: NESTED_EXPR_AS
		do
--|#line 1832 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1832")
end


yyval45 := new_nested_expr_as (yytype25 (yyvs.item (yyvsp - 3)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_398 is
			--|#line 1836 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1836 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1836")
end


yyval44 := new_nested_as (yytype48 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_399 is
			--|#line 1840 "eiffel.y"
		local
			yyval48: PRECURSOR_AS
		do
--|#line 1840 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1840")
end


yyval48 := new_precursor_as (Void, yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_400 is
			--|#line 1842 "eiffel.y"
		local
			yyval48: PRECURSOR_AS
		do
--|#line 1842 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1842")
end


yyval48 := new_precursor (yytype92 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp)), Void) 
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_401 is
			--|#line 1844 "eiffel.y"
		local
			yyval48: PRECURSOR_AS
		do
--|#line 1844 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1844")
end


yyval48 := new_precursor (yytype92 (yyvs.item (yyvsp - 5)), yytype72 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 2))) 
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_402 is
			--|#line 1846 "eiffel.y"
		local
			yyval48: PRECURSOR_AS
		do
--|#line 1846 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1846")
end


yyval48 := new_precursor (yytype92 (yyvs.item (yyvsp - 4)), yytype72 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 2))) 
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_403 is
			--|#line 1850 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1850 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1850")
end


yyval44 := new_nested_as (yytype49 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_404 is
			--|#line 1854 "eiffel.y"
		local
			yyval49: STATIC_ACCESS_AS
		do
--|#line 1854 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1854")
end


				yyval49 := new_static_access_as (yytype63 (yyvs.item (yyvsp - 4)), yytype33 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp)));
			
			yyval := yyval49
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_405 is
			--|#line 1861 "eiffel.y"
		local
			yyval49: STATIC_ACCESS_AS
		do
--|#line 1861 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1861")
end


				yyval49 := new_static_access_as (yytype63 (yyvs.item (yyvsp - 3)), yytype33 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval49
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_406 is
			--|#line 1869 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1869 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1869")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_407 is
			--|#line 1871 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1871 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1871")
end


yyval11 := yytype3 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_408 is
			--|#line 1875 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1875 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1875")
end


yyval44 := new_nested_as (yytype3 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_409 is
			--|#line 1877 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1877 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1877")
end


yyval44 := new_nested_as (yytype3 (yyvs.item (yyvsp - 2)), yytype44 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_410 is
			--|#line 1881 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1881 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1881")
end


yyval33 := yytype33 (yyvs.item (yyvsp))
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_411 is
			--|#line 1883 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1883 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1883")
end


yyval33 := yytype93 (yyvs.item (yyvsp)).first.internal_name 
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_412 is
			--|#line 1885 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1885 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1885")
end


yyval33 := yytype93 (yyvs.item (yyvsp)).first.internal_name 
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_413 is
			--|#line 1889 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1889 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1889")
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

	yy_do_action_414 is
			--|#line 1902 "eiffel.y"
		local
			yyval3: ACCESS_FEAT_AS
		do
--|#line 1902 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1902")
end


yyval3 := new_access_feat_as (yytype33 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval3
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_415 is
			--|#line 1906 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1906 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1906")
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

	yy_do_action_416 is
			--|#line 1908 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1908 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1908")
end



			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_417 is
			--|#line 1910 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1910 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1910")
end


yyval72 := yytype72 (yyvs.item (yyvsp - 1)) 
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_418 is
			--|#line 1914 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1914 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1914")
end


				yyval72 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval72.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_419 is
			--|#line 1919 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1919 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1919")
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

	yy_do_action_420 is
			--|#line 1926 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1926 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1926")
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

	yy_do_action_421 is
			--|#line 1928 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1928 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1928")
end


yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_422 is
			--|#line 1932 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1932 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1932")
end


				yyval72 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval72.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_423 is
			--|#line 1937 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1937 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1937")
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

	yy_do_action_424 is
			--|#line 1948 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1948 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1948")
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

	yy_do_action_425 is
			--|#line 1957 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1957 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1957")
end


yyval7 := yytype10 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_426 is
			--|#line 1959 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1959 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1959")
end


yyval7 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_427 is
			--|#line 1961 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1961 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1961")
end


yyval7 := yytype39 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_428 is
			--|#line 1963 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1963 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1963")
end


yyval7 := yytype50 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_429 is
			--|#line 1965 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1965 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1965")
end


yyval7 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_430 is
			--|#line 1967 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1967 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1967")
end


yyval7 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_431 is
			--|#line 1971 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1971 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1971")
end


yyval7 := yytype10 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_432 is
			--|#line 1973 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1973 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1973")
end


yyval7 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_433 is
			--|#line 1975 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1975 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1975")
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

	yy_do_action_434 is
			--|#line 1990 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1990 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1990")
end


yyval7 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_435 is
			--|#line 1992 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1992 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1992")
end


yyval7 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_436 is
			--|#line 1994 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1994 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1994")
end


yyval7 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_437 is
			--|#line 1996 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1996 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1996")
end


				yytype60 (yyvs.item (yyvsp)).set_is_once_string (True)
				yyval7 := yytype60 (yyvs.item (yyvsp))
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_438 is
			--|#line 2003 "eiffel.y"
		local
			yyval10: BOOL_AS
		do
--|#line 2003 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2003")
end


yyval10 := new_boolean_as (False) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_439 is
			--|#line 2005 "eiffel.y"
		local
			yyval10: BOOL_AS
		do
--|#line 2005 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2005")
end


yyval10 := new_boolean_as (True) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_440 is
			--|#line 2009 "eiffel.y"
		local
			yyval13: CHAR_AS
		do
--|#line 2009 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2009")
end


				check is_character: not token_buffer.is_empty end
				yyval13 := new_character_as (token_buffer.item (1))
			
			yyval := yyval13
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_441 is
			--|#line 2016 "eiffel.y"
		local
			yyval39: INTEGER_CONSTANT
		do
--|#line 2016 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2016")
end


				if token_buffer.is_integer then
					yyval39 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval39 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval39 := new_integer_as (False, "0")
				end
			
			yyval := yyval39
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_442 is
			--|#line 2031 "eiffel.y"
		local
			yyval39: INTEGER_CONSTANT
		do
--|#line 2031 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2031")
end


				if token_buffer.is_integer then
					yyval39 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval39 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval39 := new_integer_as (False, "0")
				end
			
			yyval := yyval39
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_443 is
			--|#line 2046 "eiffel.y"
		local
			yyval39: INTEGER_CONSTANT
		do
--|#line 2046 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2046")
end


				if token_buffer.is_integer then
					yyval39 := new_integer_as (True, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval39 := new_integer_as_from_hexa (token_buffer)	
				else
					token_buffer.precede ('-')
					report_integer_too_small_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval39 := new_integer_as (False, "0")
				end
			
			yyval := yyval39
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_444 is
			--|#line 2064 "eiffel.y"
		local
			yyval50: REAL_AS
		do
--|#line 2064 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2064")
end


yyval50 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval50
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_445 is
			--|#line 2066 "eiffel.y"
		local
			yyval50: REAL_AS
		do
--|#line 2066 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2066")
end


yyval50 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval50
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_446 is
			--|#line 2068 "eiffel.y"
		local
			yyval50: REAL_AS
		do
--|#line 2068 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2068")
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

	yy_do_action_447 is
			--|#line 2075 "eiffel.y"
		local
			yyval8: BIT_CONST_AS
		do
--|#line 2075 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2075")
end


yyval8 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval8
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_448 is
			--|#line 2079 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2079 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2079")
end


yyval60 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_449 is
			--|#line 2081 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2081 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2081")
end


yyval60 := new_empty_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_450 is
			--|#line 2083 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2083 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2083")
end


yyval60 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_451 is
			--|#line 2087 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2087 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2087")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_452 is
			--|#line 2089 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2089 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2089")
end


yyval60 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_453 is
			--|#line 2091 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2091 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2091")
end


yyval60 := new_lt_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_454 is
			--|#line 2093 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2093 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2093")
end


yyval60 := new_le_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_455 is
			--|#line 2095 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2095 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2095")
end


yyval60 := new_gt_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_456 is
			--|#line 2097 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2097 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2097")
end


yyval60 := new_ge_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_457 is
			--|#line 2099 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2099 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2099")
end


yyval60 := new_minus_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_458 is
			--|#line 2101 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2101 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2101")
end


yyval60 := new_plus_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_459 is
			--|#line 2103 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2103 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2103")
end


yyval60 := new_star_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_460 is
			--|#line 2105 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2105 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2105")
end


yyval60 := new_slash_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_461 is
			--|#line 2107 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2107 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2107")
end


yyval60 := new_mod_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_462 is
			--|#line 2109 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2109 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2109")
end


yyval60 := new_div_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_463 is
			--|#line 2111 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2111 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2111")
end


yyval60 := new_power_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_464 is
			--|#line 2113 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2113 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2113")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_465 is
			--|#line 2115 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2115 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2115")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_466 is
			--|#line 2117 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2117 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2117")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_467 is
			--|#line 2119 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2119 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2119")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_468 is
			--|#line 2121 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2121 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2121")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_469 is
			--|#line 2123 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2123 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2123")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_470 is
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

	yy_do_action_471 is
			--|#line 2127 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2127 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2127")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_472 is
			--|#line 2131 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2131 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2131")
end


yyval94 := new_clickable_string (new_minus_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_473 is
			--|#line 2133 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2133 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2133")
end


yyval94 := new_clickable_string (new_plus_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_474 is
			--|#line 2135 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2135 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2135")
end


yyval94 := new_clickable_string (new_not_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_475 is
			--|#line 2137 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2137 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2137")
end


yyval94 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_476 is
			--|#line 2141 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2141 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2141")
end


yyval94 := new_clickable_string (new_lt_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_477 is
			--|#line 2143 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2143 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2143")
end


yyval94 := new_clickable_string (new_le_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_478 is
			--|#line 2145 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2145 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2145")
end


yyval94 := new_clickable_string (new_gt_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_479 is
			--|#line 2147 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2147 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2147")
end


yyval94 := new_clickable_string (new_ge_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_480 is
			--|#line 2149 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2149 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2149")
end


yyval94 := new_clickable_string (new_minus_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_481 is
			--|#line 2151 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2151 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2151")
end


yyval94 := new_clickable_string (new_plus_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_482 is
			--|#line 2153 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2153 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2153")
end


yyval94 := new_clickable_string (new_star_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_483 is
			--|#line 2155 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2155 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2155")
end


yyval94 := new_clickable_string (new_slash_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_484 is
			--|#line 2157 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2157 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2157")
end


yyval94 := new_clickable_string (new_mod_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_485 is
			--|#line 2159 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2159 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2159")
end


yyval94 := new_clickable_string (new_div_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_486 is
			--|#line 2161 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2161 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2161")
end


yyval94 := new_clickable_string (new_power_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_487 is
			--|#line 2163 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2163 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2163")
end


yyval94 := new_clickable_string (new_and_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_488 is
			--|#line 2165 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2165 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2165")
end


yyval94 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_489 is
			--|#line 2167 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2167 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2167")
end


yyval94 := new_clickable_string (new_implies_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_490 is
			--|#line 2169 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2169 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2169")
end


yyval94 := new_clickable_string (new_or_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_491 is
			--|#line 2171 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2171 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2171")
end


yyval94 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_492 is
			--|#line 2173 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2173 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2173")
end


yyval94 := new_clickable_string (new_xor_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_493 is
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

	yy_do_action_494 is
			--|#line 2179 "eiffel.y"
		local
			yyval5: ARRAY_AS
		do
--|#line 2179 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2179")
end


yyval5 := new_array_as (yytype72 (yyvs.item (yyvsp - 1))) 
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_495 is
			--|#line 2183 "eiffel.y"
		local
			yyval62: TUPLE_AS
		do
--|#line 2183 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2183")
end


yyval62 := new_tuple_as (yytype72 (yyvs.item (yyvsp - 1))) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_496 is
			--|#line 2187 "eiffel.y"
		do
--|#line 2187 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2187")
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

	yy_do_action_497 is
			--|#line 2191 "eiffel.y"
		local
			yyval58: TOKEN_LOCATION
		do
--|#line 2191 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2191")
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
			when 813 then
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
			    0,  295,  295,  295,  296,  298,  285,  284,  254,  254,
			  254,  256,  256,  256,  257,  257,  257,  255,  255,  172,
			  168,  168,  220,  220,  220,  136,  136,  136,  136,  297,
			  297,  297,  297,  300,  300,  301,  301,  205,  205,  237,
			  237,  238,  238,  163,  163,  148,  302,  147,  147,  250,
			  250,  251,  251,  236,  236,  299,  299,  162,  292,  292,
			  289,  304,  304,  288,  288,  288,  286,  287,  140,  149,
			  149,  150,  150,  150,  266,  266,  266,  267,  267,  191,
			  191,  192,  192,  192,  192,  192,  192,  192,  268,  268,
			  269,  269,  197,  230,  230,  229,  229,  231,  231,  158,

			  164,  164,  164,  224,  224,  223,  223,  151,  151,  239,
			  239,  241,  241,  240,  240,  243,  243,  242,  242,  245,
			  245,  244,  244,  278,  278,  279,  279,  280,  280,  217,
			  305,  305,  282,  282,  283,  283,  218,  252,  252,  253,
			  253,  213,  213,  202,  306,  201,  201,  201,  160,  161,
			  207,  207,  178,  178,  281,  281,  259,  259,  260,  260,
			  175,  303,  303,  176,  176,  176,  176,  176,  176,  176,
			  176,  176,  176,  198,  198,  308,  198,  309,  157,  157,
			  310,  157,  311,  272,  272,  273,  273,  209,  210,  210,
			  210,  212,  212,  216,  216,  216,  216,  216,  216,  216,

			  214,  276,  276,  276,  275,  275,  277,  277,  247,  247,
			  248,  248,  249,  249,  165,  165,  165,  166,  312,  293,
			  293,  246,  246,  171,  227,  227,  228,  228,  156,  261,
			  261,  173,  221,  221,  222,  222,  144,  263,  263,  179,
			  179,  179,  179,  179,  179,  179,  179,  179,  179,  179,
			  179,  179,  179,  179,  179,  179,  179,  262,  262,  181,
			  274,  274,  180,  180,  313,  219,  219,  219,  155,  270,
			  270,  270,  271,  271,  199,  258,  258,  135,  135,  200,
			  200,  225,  225,  226,  226,  152,  152,  152,  152,  152,
			  152,  203,  203,  203,  204,  204,  204,  204,  204,  204,

			  204,  190,  190,  190,  190,  190,  190,  264,  264,  264,
			  265,  265,  189,  189,  189,  189,  189,  189,  189,  189,
			  189,  189,  189,  153,  153,  153,  154,  154,  215,  215,
			  130,  130,  133,  133,  174,  174,  174,  174,  174,  174,
			  174,  174,  174,  146,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  169,  143,  143,  143,  143,  143,  143,  143,  143,
			  143,  143,  143,  143,  186,  185,  184,  188,  183,  193,

			  193,  193,  193,  187,  194,  195,  142,  142,  182,  182,
			  170,  170,  170,  131,  132,  232,  232,  232,  233,  233,
			  234,  234,  235,  235,  167,  137,  137,  137,  137,  137,
			  137,  138,  138,  138,  138,  138,  138,  138,  141,  141,
			  145,  177,  177,  177,  196,  196,  196,  139,  206,  206,
			  206,  208,  208,  208,  208,  208,  208,  208,  208,  208,
			  208,  208,  208,  208,  208,  208,  208,  208,  208,  208,
			  208,  208,  291,  291,  291,  291,  290,  290,  290,  290,
			  290,  290,  290,  290,  290,  290,  290,  290,  290,  290,
			  290,  290,  290,  290,  134,  211,  307,  294>>)
		end

	yytypes1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,   33,   81,    1,   35,   81,   58,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    2,    5,    7,    8,   10,   11,   13,
			   20,   25,   33,   33,   33,   44,   44,   44,   44,   44,
			   45,   48,   49,   57,   59,   60,   60,   62,   93,   93,
			    1,    1,    1,    1,    1,    1,   63,   63,   63,   92,

			    1,    1,    1,    1,   35,   33,   33,    1,    1,    1,
			    1,    1,    1,    1,   94,    1,    1,    1,    1,    1,
			   33,   33,   46,    1,    1,   72,   60,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,   94,    1,    1,    1,    1,
			    1,    1,    1,   92,   93,   93,   93,   25,   72,   72,
			    1,   63,   92,   72,    1,   58,   63,   25,   25,    1,
			   25,   25,   25,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,   33,    1,   25,   72,    1,    1,   92,   92,    1,

			   33,   92,    1,    1,    1,   33,   39,    1,   89,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    7,    7,    8,   10,   13,   20,   33,   39,   50,   60,
			   66,   58,   58,    3,   11,   33,   33,   44,   63,   25,
			    1,   84,    1,   92,    1,   25,   72,   63,   58,   11,
			   25,    1,    1,   92,    1,    1,    1,   63,   33,    1,
			    1,   33,   80,   80,   11,   25,   25,   25,   25,   25,
			   25,   25,   25,   25,   25,   25,   25,   25,    1,   25,
			   25,    1,   25,   25,   25,   58,   11,   11,   89,   89,
			   89,    1,    1,    1,   63,   89,   92,    1,    1,    1,

			    1,    1,   62,    1,    1,    1,   33,   33,    1,   72,
			    1,    1,    1,    1,    1,   25,   46,   84,   33,    1,
			    1,    1,    1,   33,    1,   25,    1,   58,   58,    1,
			   84,   58,    1,    1,    1,    1,   25,   25,   33,    1,
			    1,   77,   58,    1,    7,   84,   84,    3,   44,    1,
			    1,    1,    1,    1,   92,    1,    1,   84,   72,   25,
			    1,   84,    1,   33,    1,   58,    1,    4,   58,   11,
			   33,   84,   63,    1,   60,    1,   92,   92,    1,   33,
			   92,   33,   39,    1,    1,   89,   46,   33,   58,   84,
			   72,    4,   33,   33,   60,    1,   60,    1,    1,    1,

			   31,   32,   77,   77,   89,   89,    1,    1,   89,    1,
			    1,    1,   89,    1,   72,    1,   72,   84,   60,    1,
			   85,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			   72,   47,   85,   58,    1,   58,    1,   96,   32,   47,
			   47,   92,    1,   18,   69,   69,   58,   63,    1,   89,
			    1,   15,   78,    1,   68,   18,    1,    1,   76,    1,
			    1,    1,    1,    1,    1,   71,   76,   76,   76,   86,
			    1,   78,   92,   76,   93,   17,   68,   93,    1,   15,
			   29,   74,   74,   15,   78,   76,   76,   76,   51,   86,
			   93,   76,   24,   71,   78,    1,   76,   76,   76,   76,

			   76,   76,    1,   71,   71,    1,    1,    1,    1,    1,
			    1,    1,    1,   28,   73,   93,   95,    1,   58,   29,
			   76,    1,    1,    1,   24,    1,   30,   76,   76,   76,
			    1,   76,   92,   93,   17,    1,    1,   15,   78,   28,
			    1,    1,    9,   90,   93,    1,   42,   51,   93,    1,
			   76,    1,   76,   89,   89,   93,   64,   80,   90,   90,
			    1,    1,   63,    1,   58,    1,   76,    1,    1,   58,
			    1,   64,    1,   63,    1,    1,   16,   81,   61,   88,
			   88,    1,   81,    1,    1,    1,    1,    1,    7,   16,
			   81,    1,   81,   61,   61,   58,    1,    1,    1,    1,

			   81,   81,   81,   56,   60,    1,    1,   25,   33,   33,
			   63,    1,    1,    1,    1,    1,   52,   25,    1,    1,
			    1,   90,    1,   88,   64,   80,   90,   90,    1,    1,
			    1,    1,   26,   40,   55,   88,   58,   64,   82,    1,
			   27,   58,   82,    1,   23,    1,   38,   82,    1,   60,
			   60,    1,    1,    1,   82,   63,   38,    1,    1,    1,
			    6,   14,   19,   21,   34,   36,   37,   38,   43,   53,
			   54,   58,    1,   88,   82,    1,    1,   58,   82,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			   33,   44,   44,   44,   44,   44,   45,   48,   49,   88,

			   25,    1,   88,    1,    1,   25,    1,   87,   88,   92,
			    1,    1,    2,   33,   63,   63,   25,    1,    1,    1,
			   12,   67,   67,   88,    1,   65,   25,   25,    1,    1,
			   60,   87,   82,    1,   63,    4,    1,    1,   25,   25,
			   58,    1,   82,   12,   25,   33,    1,   82,    1,    1,
			    1,    1,    2,    1,   13,   33,   39,   41,   49,   83,
			   82,    1,    1,   58,   22,   70,   70,   58,   60,    2,
			    4,    1,    1,    1,    1,    1,    1,    1,   25,   25,
			    1,   82,   22,    1,    4,   63,   13,   33,   49,   13,
			   33,   39,   49,   33,   39,   49,   13,   33,   39,   49,

			   82,   41,    1,   82,    1,   25,    1,   82,    1,    1,
			    1,   82,   33,    1,    1,    1>>)
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
			    8,  497,    0,  424,    0,   33,    1,   17,  497,   21,
			  471,  470,  469,  468,  467,  466,  465,  464,  463,  462,
			  461,  460,  459,  458,  457,  456,  455,  454,  453,  345,
			  450,  452,  449,    0,  386,    0,    0,  415,    0,    0,
			    0,  385,    0,  439,  438,  420,    0,  420,    0,  497,
			    0,  447,  451,  434,  440,  433,    0,    0,    0,    0,
			  381,    0,    0,  387,  346,  344,  435,  431,  348,  432,
			  393,    3,  410,    0,  415,  390,  384,  383,  382,  392,
			  388,  389,  391,  349,  293,  436,  448,  347,  411,  412,
			    0,    0,    0,    0,    0,    7,    2,  191,  192,  201,

			   34,   35,    0,   35,   18,    0,    0,  497,  497,    0,
			  475,  474,  473,  472,   67,  306,  303,  304,    0,    0,
			  410,  307,    0,    0,    0,  399,  437,  493,  492,  491,
			  490,  489,  488,  487,  486,  485,  484,  483,  482,  481,
			  480,  479,  478,  477,  476,   66,    0,  497,    0,  380,
			  379,    6,    0,   63,   64,   65,  377,  422,    0,  421,
			    0,    0,  201,    0,    0,    0,    0,    0,  374,  139,
			  373,  371,  372,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  497,  375,  413,    0,    0,  201,  201,  199,

			  198,  201,  441,    0,    0,  197,  196,    0,  200,   36,
			   30,    0,   35,   35,   29,   20,   24,  444,    0,    0,
			   22,   26,  429,  425,  426,    0,   25,  427,  428,  430,
			   55,    0,    0,  407,  395,  410,  415,  406,    0,    0,
			    0,  291,    0,    0,  416,  418,    0,    0,    0,  394,
			    0,  495,    0,    0,  497,  497,  494,    0,  307,  497,
			  350,  137,  140,    0,  396,  357,  356,  355,  354,  353,
			  352,  351,  364,  366,  365,  367,  368,  369,    0,  358,
			  363,    0,  360,  362,  370,    0,  398,  403,  195,  194,
			  193,  443,  442,  202,  206,    0,  497,   32,   31,  446,

			  445,   27,    0,    0,   56,   19,  307,  307,    0,  414,
			  305,  302,  312,    0,  308,  322,  310,    0,  307,  415,
			  417,    0,    0,  307,  378,  423,    0,    0,    0,  497,
			  294,  332,  497,    0,    0,  376,  359,  361,  307,  203,
			    0,  150,    0,   28,   23,  300,  297,  408,  409,    0,
			    0,    0,    0,    0,  201,  309,    0,  292,  400,  419,
			    0,  298,  497,  307,  415,  332,    0,  327,    0,  397,
			  138,  295,  207,    0,   37,  210,  201,  201,  199,  198,
			  201,  197,  196,    0,  497,    0,  311,  415,    0,  299,
			  402,  326,  415,  307,  151,    0,   74,    0,    0,  216,

			  218,  212,    0,  211,  195,  194,  321,  320,  193,  319,
			  318,  204,    0,  314,  404,  415,  333,  296,   38,  497,
			  497,  214,  215,  219,  209,    0,  317,  315,  316,  205,
			  401,   77,  497,    0,   76,  497,    0,  217,  213,   78,
			   79,  201,  285,  283,  103,  497,    0,  221,   80,   81,
			    0,    0,  287,    0,   39,  284,  288,    0,  220,  113,
			  121,   88,  117,   55,   87,  111,  115,  119,    0,   93,
			   49,    0,   51,  286,  109,  105,  104,    0,   46,   61,
			   41,  497,   40,    0,  290,    0,  114,  122,   90,   89,
			    0,  118,   97,   95,  100,   96,  112,  115,  116,  119,

			  120,    0,   86,   94,  111,   50,    0,    0,    0,    0,
			    0,   47,   62,   53,   61,   58,  123,    0,  262,   42,
			  289,  222,    0,    0,   98,  101,   55,  102,  119,    0,
			   85,  115,   52,  110,  106,    0,    0,   45,   48,   54,
			   61,  125,  161,  141,   60,  264,  497,   91,   92,   99,
			    0,   84,  119,    0,    0,   59,  127,  497,    0,  126,
			   57,    0,   14,  496,    8,   83,    0,  108,    0,    0,
			  124,  128,  162,  142,   11,  497,   68,   69,  185,  263,
			  496,  497,    0,   82,  107,  130,   14,  497,   14,   70,
			   37,   16,  497,  186,   55,    0,    5,    4,    0,    0,

			   72,  497,   71,   73,  144,   15,  187,  188,  410,    0,
			   55,  173,  190,  131,  129,  175,  154,  189,  177,  496,
			  132,    0,  496,  174,  134,  497,  155,  133,  161,  497,
			  161,  147,  146,  145,  178,  176,    0,  135,  153,  496,
			  150,    0,  152,  180,  275,    0,  158,  496,  497,  148,
			  149,  182,  496,  161,    0,   55,  159,  274,  497,  161,
			  165,  171,  163,  170,  167,  168,  164,  161,  169,  172,
			  166,    0,  496,  179,  276,  143,  136,    0,  260,  160,
			    0,    0,  269,    0,  496,    0,    0,  328,    0,  334,
			  410,  340,  336,  335,  337,  342,  338,  339,  341,  181,

			  232,  496,  265,    0,    0,    0,    0,  161,    0,    0,
			  331,    0,  332,  330,  329,    0,    0,    0,    0,  497,
			  234,  257,  233,  261,    0,    0,  278,  280,  161,  270,
			  272,    0,    0,  343,    0,  324,    0,    0,  277,  279,
			    0,  161,    0,  235,  267,  410,  497,  497,  271,    0,
			  268,    0,  332,    0,  241,  243,  239,  237,  249,    0,
			  258,  231,    0,    0,  226,  229,  497,    0,  273,  332,
			  323,    0,    0,    0,    0,    0,  161,    0,  266,    0,
			  161,    0,  227,    0,  325,    0,  242,  248,  256,  247,
			  244,  245,  251,  246,  240,  254,  255,  250,  253,  252,

			  236,  238,  161,  230,  223,    0,    0,    0,  161,    0,
			  259,  228,  405,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  712,   63,  233,  367,   64,  660,  220,  221,   65,   66,
			  542,   67,  234,   68,  720,   69,  661,  451,  479,  576,
			  589,  475,  443,  662,   70,  663,  764,  644,  492,  157,
			  632,  640,  513,  480,  526,  400,  401,   72,  106,   73,
			   74,  664,    7,  665,  666,  646,  667,  227,  633,  757,
			  546,  668,  237,   75,   76,   77,   78,   79,   80,  316,
			  122,  431,  440,   81,   82,  758,  228,  488,  616,  669,
			  670,  634,  603,   83,   84,  396,   85,  374,   86,  578,
			  594,   87,  294,  562,   97,  715,   98,  556,  624,  725,
			  230,  721,  722,  476,  454,  444,  445,  765,  766,  465,

			  504,  493,  125,  246,  158,  159,  514,  481,  482,  473,
			  496,  497,  498,  499,  500,  501,  458,  341,  402,  403,
			  494,  471,  557,  263,    5,    8,  590,  577,  654,  638,
			  647,  781,  742,  759,  241,  317,  420,  432,  469,  489,
			  707,  731,  579,  580,  702,  385,  208,  295,  543,  558,
			  559,  621,  626,  627,   99,  153,   88,   89,  474,  515,
			  145,  114,  516,  437,    9,  813,    6,  102,  597,  305,
			  103,  210,  511,  639,  517,  599,  611,  581,  619,  622,
			  652,  672,  423,  563>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   36,  630, 1329, -32768,  138,  239, -32768, -32768,  583,   65,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,  715,  261,  246,   39,  109, 1724, 1903,
			  755,  236,   21, -32768, -32768, 1329,  465, 1329,  753, -32768,
			  138, -32768, -32768, -32768, -32768, -32768, 1329, 1329,  770, 1329,
			 -32768, 1329, 1329,  459, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, 2034,  754, 1329,  676, -32768, -32768, -32768, -32768, -32768,
			 -32768,  454,  443, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  213,  213,   85,  213,  223, -32768, -32768, -32768, -32768,  649,

			 -32768,  692,  736,  156, -32768,  752, 1561, -32768, -32768,  133,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  138, 1329,
			  764,  703,  758,  213, 1213, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  213, -32768,  133, -32768,
			 -32768, -32768, 1329, -32768, -32768, -32768, -32768, 2034,  733,  741,
			  213,  662,  492,  734,  138,   65,  731, 1992, -32768,   65,
			 -32768, -32768, -32768,  133, 1329, 1329, 1329, 1329, 1329, 1329,
			 1329, 1329, 1329, 1329, 1329, 1329, 1329, 1097, 1329,  981,
			 1329, 1329, -32768, -32768, -32768,  133,  133,  649,  649, -32768,

			 -32768,  649, -32768,  730,  729, -32768, -32768,  556, -32768, -32768,
			 -32768,  213,  692,  692, -32768, -32768, -32768, -32768,  405,  397,
			 -32768, -32768, -32768, -32768, -32768,  168, -32768, -32768, -32768, -32768,
			  348,   65,   65,  712, -32768, -32768,  676, -32768,  724, 1949,
			  865, -32768,  133,  722, -32768, 2034,  375,  720,   65, -32768,
			 1930, -32768, 1329,  714, -32768, -32768, -32768,  710,  703, -32768,
			  224, -32768,  503,  711, -32768,  488,  488,  488,  488,  488,
			  643,  643,  509,  509,  509,  509,  509,  509, 1329, 2063,
			 2049, 1329, 1730, 1971, -32768,   65, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  271,  476, -32768, -32768, -32768,

			 -32768, -32768,  689, 1585, -32768, -32768,  703,  703,  133, -32768,
			 -32768, -32768,  715,  232, -32768, 2034, -32768,  374,  703,  676,
			 -32768, 1329,  725,  703, -32768, 2034,  702,   65,  659, -32768,
			 -32768,  241, -32768,  133,   65, -32768, 2063, 1730,  703, -32768,
			  138,  507,  696, -32768, -32768, -32768, -32768,  712, -32768,  213,
			  213,   80,  213,  223,  452, -32768, 1445, -32768, -32768, 2034,
			   65, -32768, -32768,  703,  676,  241,   65, -32768,   65, -32768,
			 -32768, -32768, -32768, 1768,  506,    5,  649,  649,  695,  694,
			  649,  691,  688,   10,  318,  685, -32768,  676,  647, -32768,
			 -32768, -32768,  676,  703, -32768, 1724,  654,  693,  690, -32768,

			 -32768, -32768,  673,  681,  670,  669, -32768, -32768,  666, -32768,
			 -32768,  606,  231, -32768, -32768,  676, -32768, -32768, -32768,  198,
			 -32768, -32768, -32768,  656, -32768,    5, -32768, -32768, -32768,  604,
			 -32768, -32768,  761,  213, -32768,  792,  213, -32768, -32768, -32768,
			  664,  649,   57, -32768,  635,  775,  653,  652, -32768,  517,
			  181,   53,   81,   53,  599, -32768,   57,   53, -32768,   53,
			   53,   53,   53,   93, -32768,  546,  532,  518,  625,  610,
			 -32768,  288, -32768,  585, -32768, -32768,  629,  191, -32768,  479,
			 -32768, -32768,  599,   53,   81,  -10,  585,  585, -32768,  617,
			  600,  585, -32768,  593,   43, -32768, -32768,  532, -32768,  518,

			 -32768,  586, -32768, -32768,  546, -32768,  213,   53,   53,  598,
			  596,  593, -32768, -32768,  311, -32768,  121,   53,  559, -32768,
			  585, -32768,   53,   53, -32768, -32768,  473,  585,  518,  557,
			 -32768,  532, -32768, -32768, -32768,  138,  138, -32768, -32768, -32768,
			  548,   65, -32768,  580, -32768, -32768, -32768, -32768, -32768, -32768,
			  552, -32768,  518,  267,  248, -32768, -32768,  503,  567,   65,
			  460,  138,  249,  -24,  536, -32768,  540, -32768,  555,  565,
			 -32768, -32768, -32768, -32768, 1701,  533, -32768, -32768, -32768, -32768,
			  645, -32768,  527, -32768, -32768,  543,  512,  839,  512, -32768,
			  506, -32768,  519, -32768,  473, 1329, -32768, -32768,   65,  138,

			 -32768,  799, -32768, -32768, -32768, -32768, -32768, 2034,  450,  513,
			  473,  468, 1329, -32768, -32768,  493,  466, 2034, -32768,  255,
			   65,  355,  255, -32768, -32768,  503, -32768,   65, -32768, -32768,
			 -32768, -32768, -32768, -32768,  477, -32768,  498, -32768, -32768,  564,
			  507, 1768, -32768,  432,  419,  138, -32768,  721,  155, -32768,
			 -32768, -32768,   56, -32768,  446,  473, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  719,   56, -32768, -32768, -32768, -32768, 1329,  423,  460,
			   98, 1329,  464,  469,  409,   15,  -12,  138, 1329,  459,
			  194, -32768, -32768, -32768, -32768, -32768, -32768,  454,  443, -32768,

			  561,  379,  363, 1329, 1329, 1894, 1746, -32768,  389,  402,
			 -32768,  138,  241, -32768, -32768,  407, 1753, 1329, 1329, -32768,
			 -32768,  373,  329, -32768, 1329,  314, 2034, 2034, -32768, -32768,
			 -32768,  247,  346, -32768,  357, -32768,   -6,  362, 2034, 2034,
			  340, -32768,  298, -32768, 2034,  408, -32768,  315, -32768, 1768,
			 -32768,   -6,  241,  310,  349,  333,  323, -32768,  301,  -22,
			 -32768, -32768, 1329, 1329, -32768,  225,  284,  277, -32768,  241,
			 -32768,  213,   72,  340,  123,  340, -32768,  340, 2034, 1912,
			 -32768,  159, -32768, 1329, -32768,  166, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, 1635,  176,   96, -32768,   65,
			 -32768, -32768, -32768,   45,   23, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -699,  214,  574, -345, -32768, -32768,  575,  303, -32768,  -98,
			 -32768, -101, -129, -32768,  154, -100, -32768, -423, -32768, -32768,
			 -32768,  367,  429, -32768,  -91, -32768,  106, -32768,  380,    1,
			 -32768, -32768,  354,  384, -32768, -32768,  435,    0, -32768,  126,
			  136, -32768,    2, -32768, -32768,  212, -32768,  -90, -32768,   70,
			 -32768, -32768,  531,  186,  185,  184,  178,  177,  174,  481,
			 -32768,  412, -32768,  172,  167, -139, -32768,  299, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  245,  -36,  189, -360,  250,
			 -32768,  603,    3, -32768, -145, -32768, -32768,  259,  195, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  350,

			 -32768, -32768,  -43, -32768,  765, -32768, -32768, -32768, -32768, -239,
			  364,  307,  361, -447,  356, -435, -32768, -32768, -32768, -32768,
			 -416, -32768, -155, -32768,  243, -451, -32768, -143, -32768, -192,
			 -32768, -32768, -32768, -32768,  -48, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -597, -32768, -32768, -32768, -169, -372, -32768, -32768,
			 -32768, -32768, -32768, -32768,  -11, -32768,   -3,  -30,   -1,  264,
			 -32768, -32768, -32768, -32768,   51, -32768, -32768, -32768, -32768, -395,
			 -32768,  -86, -32768, -526, -32768, -32768, -32768, -479, -32768, -32768,
			 -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    4,  247,  126,   71,  206,  223,  224,   96,  222,  105,
			  104,  412,  155,  394,  262,  225,  560,  214,  777,  249,
			  391,    3,  623,  815,  434,  635,  452,    3,  288,  289,
			  507,  194,  290,  483,  711,  162,  120,  752,  399,  154,
			  484,  156, -183,   95,  264,  814,   94,  152,   95,  161,
			  528, -183,  769,  166,  151,  673,  521,  167,  168,  411,
			  170,  160,  171,  172,  529,  119,  286,  287,  495,    3,
			  229,  525,    3,  398,  193,  699,  151,  776,   93,  197,
			  198,  150,  201,  710,  552,  118,  151,  708,  537,  710,
			  -47,   92,  200,  550,  205,  538,  397,   39,    3,  117,

			  165,   91,   54,  450,  723,    3,  226,    2,   90,  235,
			   35,    1,  243,    3,  -48,   39,  149,  566,    3,   39,
			  239,  238, -183,  109,  592,  245,  297,  298,   35,   39,
			  304,  549,   35,  -47,  116,  124,  601,  204,  203,  450,
			  378,  679,   35,  753,  115,  199,  -47,  541,  235,  253,
			 -183,  704,  202,  250,  703,  123,    3,  -48,  231,  232,
			  648,  540,  810,  553,  554,  258,    3,  257,  648,  261,
			  -48,   95,  121,  235,   94,  265,  266,  267,  268,  269,
			  270,  271,  272,  273,  274,  275,  276,  277,  279,  280,
			  282,  283,  284,  309,  753,  235,  235,  191,  248,  606,

			  296,  809,  223,  224,  369,  222,   93,  404,  405,   39,
			  330,  408,  225,  806,   95,  614,   45,  510,  485,   92,
			  486,  487,   35,  491,  213,  804,  209,  659,  470,   91,
			  509,  306,  307,  658,  301,  304,   90,  204,  203,  -55,
			  -55,  315,  235,  285,  520,  236,   95,  718,  323,  333,
			  717,  657,  202,  325,  212,  527,    3,  -55,  345,  346,
			  676,  148,  332,  382,  -55,   95,  366,  229,  353,  -55,
			  357,  340,  449,  -55,  147,  361,  358,  -55,  160,  336,
			  429,  650,  337,  191,  236,  338,  109,  749,  340,  780,
			  371,  447,  748,  191,  191,  568,  191,  191,  191,  108,

			  352,  101,  354,  226,  775,  327,  328,  340,  235,  236,
			  331,  340,  100,  351,  567,  389,  161, -183, -183,  191,
			  339,  390,  359,  350,  575, -183,  774,  363,  506,  574,
			  349,  236,  236,  235,  370,  505,  773, -183,  376,  377,
			 -183,  380,  783,  372,  414,  417,  730,  342, -225,  416,
			 -225,  379,  772,  381,  204,  203,  771,  315, -313,  418,
			  387,  113,  112, -313,  761,  191,  392,  735,  393,  202,
			   54,  191,  430,    3,  111,  110,  191,  -44,  318, -224,
			  365, -224,  -44,  368,  512,  304,  -44,  333,  303,  768,
			  -44,  191,  191,  191,  191,  191,  191,  191,  191,  191,

			  191,  191,  191,  191,  751,  191,  191,  770,  191,  191,
			  191,  753,  750,  388,  356,  321,  746,  631,  630,  355,
			  320,  155,  441,  155,  784,  629,  292,  155,  300,  155,
			  155,  155,  155,  719,  291,  328,  299,  741,  642,  472,
			  628,  191,  736,  600,  236,  602,  192,  762,  154,  255,
			  154,  191,  477,  155,  154,  733,  154,  154,  154,  154,
			  490,  674,  191,  191,  155,  625,  724,  678,  196,  236,
			  433,  435,  625,  223,  224, -183,  222,  155,  155,  195,
			  154, -183, -183,  433,  173,  191,  446,  155,  192,  612,
			  706,  154,  155,  155,  148,  532,  446,  572,   95,  384,

			  383,   94,  701, -208,  154,  154,  533,  477,  174,   60,
			  304,  160,  675,  653,  154,  732,  544, -208, -208,  154,
			  154,  490,  548,  180,  179,  178,  177,  176,  175,  174,
			   60,  651,  518,   93,  373, -208,  747,  645,  229,  255,
			  207,  261, -208,  334,  643,  -43,   92, -208,  620,  760,
			  -43, -208,  512, -208,  -43, -208,   91,  618,  -43,  261,
			 -208,  615,  613,   90,  573,  190,  189,  188,  187,  186,
			  185,  184,  183,  182,  181,  180,  179,  178,  177,  176,
			  175,  174,   60,  464,  800,  605,  463,  575,  803,   95,
			  395,  598,   94,  596,  104,  608,  607,  564,  609,  591,

			  584,  572,  610,  104,  585,  293,  583,  462,  569,  461,
			  807,    1,  570,  617,  460,  460,  811,  459,  565,  561,
			  261,  512,  462,  551,   93,  507,  785,  261, -156, -156,
			 -156, -156,  595,  788,  792,  795,  799,   92,  545,  450,
			  754,   -9,  536, -156,  535,   -9,  459,   91,  655,   -9,
			  756,   -9,  530,   -9,   90,  523,   -9,  522, -156,  178,
			  177,  176,  175,  174,   60,  719, -156, -156, -156,  508,
			  478,  690,  786,  789,  709,  796,  636,  754,  700,  463,
			  641,   -9,  705,  791,  794,  798,  713,  756,  -10,  716,
			  714,  502,  -10,  457,  453,  456,  -10,  207,  -10,  671,

			  -10,  448,  124,  -10,  726,  727,  436, -184, -184,  677,
			 -203, -184, -202,  428,  734, -184,  427,  426,  738,  739,
			 -184,  425,  424,  422,  745,  744,  421, -184,  -10,  240,
			 -184,  419,  413,  191,  415,  410,  713,  308,  409, -184,
			  755,  407,  406,  191,  375,  688,  364, -184, -184,  362,
			  360,  713,    3,  107,  687,  343,  335,  329,  292,  291,
			  686,  326,  209,  778,  779,  685,  259,  322,  254,  319,
			  740,  310,  787,  790,  793,  797,  684,  755,  256,  683,
			  682,  252,  251,  242,  805, -157, -157, -157, -157, -301,
			   40,  215,  192,  681,  211,   39,  169,  763,  767,  164,

			 -157,  146,  -75,  -75,  555,  468,   37,  582,   35,  812,
			  467,  531,  163,  466,  680, -157,  442,  767,  571,  503,
			  -75,  547,  637, -157, -157, -157,  191,  -75,  302,  649,
			  593,  191,  -75,  442, -282,  604,  -75,  386,  698,  348,
			  -75, -282,  191,  697,  439,  696, -282,  801,  695,  694,
			 -282, -281,  191,  191, -282,  693,  692,  691, -281,  656,
			  438,  -12,  -12, -281,  191,  191,  519, -281,  539,  -12,
			  191, -281,  782,  524,  455,  534,  743,  588,  344,   62,
			   61,  -12,  347,  -12,  -12,  689,   60,   59,   58,   57,
			    0,   56,  -12,    0,   55,   54,   53,   52,    3,   51,

			   50,  -13,  -13,   49,  191,  191,   48,    0,   47,  -13,
			  314,  313,    0,   45,    0,    0,   44,   43,    0,   42,
			    0,  -13,    0,  -13,  -13,   41,    0,    0,    0,    0,
			    0,  191,  -13,    0,    0,    0,   40,    0,    0,    0,
			    0,   39,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   38,   37,   36,   35,    0,    0,    0,    0,    0,
			   34,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  312,    0,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   22,   21,   20,   19,   18,   17,   16,   15,
			   14,   13,   12,   11,   10,   62,   61,    0,    0,    0,

			    0,    0,   60,   59,   58,   57,    0,   56,    0,    0,
			   55,   54,   53,   52,    3,   51,   50,    0,    0,   49,
			    0,    0,   48,    0,   47,    0,    0,   46,    0,   45,
			    0,    0,   44,   43,    0,   42,    0,    0,    0,    0,
			    0,   41,    0,    0,    0,  281,    0,    0,    0,    0,
			    0,    0,   40,    0,    0,    0,    0,   39,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   38,   37,   36,
			   35,    0,    0,    0,    0,    0,   34,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   33,    0,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,

			   20,   19,   18,   17,   16,   15,   14,   13,   12,   11,
			   10,   62,   61,    0,    0,    0,    0,    0,   60,   59,
			   58,   57,    0,   56,    0,    0,   55,   54,   53,   52,
			    3,   51,   50,    0,    0,   49,    0,    0,   48,    0,
			   47,    0,    0,   46,    0,   45,    0,    0,   44,   43,
			    0,   42,    0,    0,    0,    0,    0,   41,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   40,    0,
			    0,    0,    0,   39,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   38,   37,   36,   35,    0,    0,    0,
			    0,    0,   34,    0,    0,    0,  278,    0,    0,    0,

			    0,    0,   33,    0,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   22,   21,   20,   19,   18,   17,
			   16,   15,   14,   13,   12,   11,   10,   62,   61,    0,
			    0,    0,    0,    0,   60,   59,   58,   57,    0,   56,
			    0,    0,   55,   54,   53,   52,    3,   51,   50,    0,
			    0,   49,    0,    0,   48,    0,   47,    0,  244,   46,
			    0,   45,    0,    0,   44,   43,    0,   42,    0,    0,
			    0,    0,    0,   41,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   40,    0,    0,    0,    0,   39,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   38,

			   37,   36,   35,    0,    0,    0,    0,    0,   34,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   33,    0,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   22,   21,   20,   19,   18,   17,   16,   15,   14,   13,
			   12,   11,   10,   62,   61,    0,    0,    0,    0,    0,
			   60,   59,   58,   57,    0,   56,    0,    0,   55,   54,
			   53,   52,    3,   51,   50,    0,    0,   49,    0,    0,
			   48,    0,   47,    0,    0,   46,    0,   45,    0,    0,
			   44,   43,    0,   42,    0,    0,    0,    0,    0,   41,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			   40,    0,    0,    0,    0,   39,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   38,   37,   36,   35,    0,
			    0,    0,    0,    0,   34,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   33,    0,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,   22,   21,   20,   19,
			   18,   17,   16,   15,   14,   13,   12,   11,   10,   62,
			   61,    0,    0,    0,    0,    0,   60,   59,   58,   57,
			    0,   56,    0,    0,   55,   54,   53,   52,    3,   51,
			   50,    0,    0,   49,    0,    0,   48,    0,   47,    0,
			    0,  313,    0,   45,    0,    0,   44,   43,    0,   42,

			    0,    0,    0,    0,    0,   41,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   40,    0,    0,    0,
			    0,   39,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   38,   37,   36,   35,    0,    0,    0,    0,    0,
			   34,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  312,    0,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   22,   21,   20,   19,   18,   17,   16,   15,
			   14,   13,   12,   11,   10,  219,  218,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  202,   54,  217,   52,    3,   51,   50,    0,  216,  219,

			  218,    0,   48,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   44,   43,  202,   54,  217,   52,    3,   51,
			   50,    0,    0,    0,    0,    0,   48,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   44,   43,    0,  190,
			  189,  188,  187,  186,  185,  184,  183,  182,  181,  180,
			  179,  178,  177,  176,  175,  174,   60,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   32,   31,
			   30,    0,   28,   27,   26,   25,   24,   23,   22,   21,
			   20,   19,   18,   17,   16,   15,   14,   13,   12,   11,
			   10,    0,   32,   31,   30,    0,   28,   27,   26,   25,

			   24,   23,   22,   21,   20,   19,   18,   17,   16,   15,
			   14,   13,   12,   11,   10,  219,  218,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  202,   54,  217,   52,  808,   51,  188,  187,  186,  185,
			  184,  183,  182,  181,  180,  179,  178,  177,  176,  175,
			  174,   60,   44,   43,    0,    0,   52,  190,  189,  188,
			  187,  186,  185,  184,  183,  182,  181,  180,  179,  178,
			  177,  176,  175,  174,   60,    0,  587,    0,   52,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  729,    0,    0,    0,    0,    0,    0,  737,    0,

			   52,    0,  586,    0,    0,    0,    0,    0,   32,   31,
			   30,    0,   28,   27,   26,   25,   24,   23,   22,   21,
			   20,   19,   18,   17,   16,   15,   14,   13,   12,   11,
			   10,   32,   31,   30,    0,   28,   27,   26,   25,   24,
			   23,   22,   21,   20,   19,   18,   17,   16,   15,   14,
			   13,   12,   11,   10,   31,    0,    0,   28,   27,   26,
			   25,   24,   23,   22,   21,   20,   19,   18,   17,   16,
			   15,   14,   13,   12,   11,   10,   31,    0,    0,   28,
			   27,   26,   25,   24,   23,   22,   21,   20,   19,   18,
			   17,   16,   15,   14,   13,   12,   11,   10,  190,  189,

			  188,  187,  186,  185,  184,  183,  182,  181,  180,  179,
			  178,  177,  176,  175,  174,   60,  190,  189,  188,  187,
			  186,  185,  184,  183,  182,  181,  180,  179,  178,  177,
			  176,  175,  174,   60,  190,  189,  188,  187,  186,  185,
			  184,  183,  182,  181,  180,  179,  178,  177,  176,  175,
			  174,   60,    0,  190,  189,  188,  187,  186,  185,  184,
			  183,  182,  181,  180,  179,  178,  177,  176,  175,  174,
			   60,    0,    0,    0,    0,  324,  189,  188,  187,  186,
			  185,  184,  183,  182,  181,  180,  179,  178,  177,  176,
			  175,  174,   60,  728,  311,  802,  190,  189,  188,  187,

			  186,  185,  184,  183,  182,  181,  180,  179,  178,  177,
			  176,  175,  174,   60,  144,  143,  142,  141,  140,  139,
			  138,  137,  136,  135,  134,  133,  132,  131,  130,  129,
			  128,    0,  127,    0,    0,    0,    0,  260,  190,  189,
			  188,  187,  186,  185,  184,  183,  182,  181,  180,  179,
			  178,  177,  176,  175,  174,   60,  187,  186,  185,  184,
			  183,  182,  181,  180,  179,  178,  177,  176,  175,  174,
			   60,  186,  185,  184,  183,  182,  181,  180,  179,  178,
			  177,  176,  175,  174,   60>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  146,   38,    2,   94,  106,  106,    4,  106,    9,
			    8,  383,   42,  373,  169,  106,  542,  103,   40,  148,
			  365,   33,  619,    0,  419,  622,  442,   33,  197,  198,
			   40,   74,  201,  456,   46,   46,   36,  736,   33,   42,
			  456,   42,   66,   33,  173,    0,   36,   26,   33,   46,
			  497,   75,  751,   50,   33,  652,   66,   56,   57,   49,
			   59,   46,   61,   62,  499,   26,  195,  196,  463,   33,
			  106,   28,   33,   68,   73,  672,   33,   99,   68,   90,
			   91,   60,   93,   95,  531,   46,   33,  684,  511,   95,
			   33,   81,   92,  528,   94,  511,   91,   76,   33,   60,

			   49,   91,   30,   46,  701,   33,  106,   71,   98,  109,
			   89,   75,  123,   33,   33,   76,   95,  552,   33,   76,
			  119,  118,   66,   25,  575,  124,  212,  213,   89,   76,
			   37,  526,   89,   76,   95,   26,  587,   14,   15,   46,
			   60,  667,   89,   71,  105,   60,   89,   26,  148,  160,
			   94,   53,   29,  152,   56,   46,   33,   76,  107,  108,
			  639,   40,   66,  535,  536,  165,   33,  164,  647,  169,
			   89,   33,   36,  173,   36,  174,  175,  176,  177,  178,
			  179,  180,  181,  182,  183,  184,  185,  186,  187,  188,
			  189,  190,  191,  236,   71,  195,  196,   71,  147,  594,

			  211,   25,  303,  303,  333,  303,   68,  376,  377,   76,
			  258,  380,  303,   47,   33,  610,   48,   26,  457,   81,
			  459,  460,   89,  462,   68,   66,   70,   72,   47,   91,
			   39,  231,  232,   78,   66,   37,   98,   14,   15,   41,
			   42,  240,  242,  192,  483,  109,   33,   53,  248,   25,
			   56,   96,   29,  252,   98,  494,   33,   59,  306,  307,
			  655,   25,   38,  353,   66,   33,   25,  303,   36,   71,
			  318,   40,  441,   75,   38,  323,  319,   79,   46,  278,
			   49,  641,  281,  157,  148,  285,   25,   40,   40,   64,
			  338,  436,   45,  167,  168,   47,  170,  171,  172,   38,

			   68,   62,  313,  303,    3,  254,  255,   40,  308,  173,
			  259,   40,   73,   81,   47,  363,  313,   62,   63,  193,
			   49,  364,  321,   91,   75,   70,    3,  327,   40,   80,
			   98,  195,  196,  333,  334,   47,    3,   82,  349,  350,
			   85,  352,   65,  340,  387,  393,  706,  296,   64,  392,
			   66,  351,    3,  353,   14,   15,   46,  356,   40,  395,
			  360,  115,  116,   45,   66,  239,  366,  712,  368,   29,
			   30,  245,  415,   33,  128,  129,  250,   66,  242,   64,
			  329,   66,   71,  332,   73,   37,   75,   25,   40,  749,
			   79,  265,  266,  267,  268,  269,  270,  271,  272,  273,

			  274,  275,  276,  277,   47,  279,  280,  752,  282,  283,
			  284,   71,   66,  362,   40,   40,  102,   62,   63,   45,
			   45,  451,  433,  453,  769,   70,   29,  457,   31,  459,
			  460,  461,  462,  104,   29,  384,   31,   64,  630,  450,
			   85,  315,   35,  586,  308,  588,   38,   39,  451,   47,
			  453,  325,  453,  483,  457,   66,  459,  460,  461,  462,
			  461,  653,  336,  337,  494,  620,  103,  659,   25,  333,
			  419,  420,  627,  574,  574,   66,  574,  507,  508,   25,
			  483,  102,  103,  432,   25,  359,  435,  517,   38,   39,
			   26,  494,  522,  523,   25,  506,  445,   37,   33,   47,

			   48,   36,   79,   27,  507,  508,  507,  508,   20,   21,
			   37,   46,   66,   94,  517,  707,  517,   41,   42,  522,
			  523,  522,  523,   14,   15,   16,   17,   18,   19,   20,
			   21,   99,  481,   68,   27,   59,  728,   39,  574,   47,
			   48,  541,   66,   40,   67,   66,   81,   71,   82,  741,
			   71,   75,   73,   77,   75,   79,   91,   64,   79,  559,
			   84,   93,   49,   98,  561,    4,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   66,  776,   66,   69,   75,  780,   33,
			   84,   48,   36,   66,  592,  595,  595,  546,  598,   66,

			   45,   37,  599,  601,   39,   49,   66,   90,  557,   92,
			  802,   75,   45,  612,   97,   97,  808,  100,   66,   39,
			  620,   73,   90,   66,   68,   40,  771,  627,   64,   65,
			   66,   67,  581,  772,  773,  774,  775,   81,   79,   46,
			  740,   58,   46,   79,   46,   62,  100,   91,  645,   66,
			  740,   68,   66,   70,   98,   55,   73,   40,   94,   16,
			   17,   18,   19,   20,   21,  104,  102,  103,  104,   40,
			   71,  671,  772,  773,  685,  775,  625,  777,  677,   69,
			  629,   98,  681,  773,  774,  775,  686,  777,   58,  688,
			  687,   66,   62,   41,   59,   42,   66,   48,   68,  648,

			   70,   37,   26,   73,  703,  704,   50,   62,   63,  658,
			  106,   66,  106,   47,  711,   70,   47,   47,  717,  718,
			   75,   40,   49,   33,  724,  724,   33,   82,   98,   26,
			   85,   77,   47,  607,   87,   47,  736,   25,   47,   94,
			  740,   47,   47,  617,   48,   26,   87,  102,  103,   47,
			   25,  751,   33,   38,   35,   66,   45,   47,   29,   29,
			   41,   47,   70,  762,  763,   46,   35,   47,  106,   47,
			  719,   47,  772,  773,  774,  775,   57,  777,   44,   60,
			   61,   40,   49,   25,  783,   64,   65,   66,   67,   25,
			   71,   39,   38,   74,   58,   76,   26,  746,  747,   46,

			   79,   46,   41,   42,  540,  449,   87,  564,   89,  809,
			  449,  504,   47,  449,   95,   94,   41,  766,  559,  469,
			   59,  522,  627,  102,  103,  104,  700,   66,  225,  640,
			  580,  705,   71,   41,   59,  590,   75,  356,  671,  308,
			   79,   66,  716,  671,  432,  671,   71,  777,  671,  671,
			   75,   59,  726,  727,   79,  671,  671,  671,   66,  647,
			  425,   62,   63,   71,  738,  739,  482,   75,  514,   70,
			  744,   79,  766,  493,  445,  508,  722,  574,  303,   14,
			   15,   82,  308,   84,   85,  671,   21,   22,   23,   24,
			   -1,   26,   93,   -1,   29,   30,   31,   32,   33,   34,

			   35,   62,   63,   38,  778,  779,   41,   -1,   43,   70,
			   45,   46,   -1,   48,   -1,   -1,   51,   52,   -1,   54,
			   -1,   82,   -1,   84,   85,   60,   -1,   -1,   -1,   -1,
			   -1,  805,   93,   -1,   -1,   -1,   71,   -1,   -1,   -1,
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
			   -1,   60,   -1,   -1,   -1,   64,   -1,   -1,   -1,   -1,
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
			   -1,   -1,   95,   -1,   -1,   -1,   99,   -1,   -1,   -1,

			   -1,   -1,  105,   -1,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,   14,   15,   -1,
			   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,   26,
			   -1,   -1,   29,   30,   31,   32,   33,   34,   35,   -1,
			   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   45,   46,
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
			   15,   -1,   -1,   -1,   -1,   -1,   21,   22,   23,   24,
			   -1,   26,   -1,   -1,   29,   30,   31,   32,   33,   34,
			   35,   -1,   -1,   38,   -1,   -1,   41,   -1,   43,   -1,
			   -1,   46,   -1,   48,   -1,   -1,   51,   52,   -1,   54,

			   -1,   -1,   -1,   -1,   -1,   60,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   71,   -1,   -1,   -1,
			   -1,   76,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   86,   87,   88,   89,   -1,   -1,   -1,   -1,   -1,
			   95,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  105,   -1,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,   14,   15,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   29,   30,   31,   32,   33,   34,   35,   -1,   37,   14,

			   15,   -1,   41,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   51,   52,   29,   30,   31,   32,   33,   34,
			   35,   -1,   -1,   -1,   -1,   -1,   41,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   51,   52,   -1,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  107,  108,
			  109,   -1,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,   -1,  107,  108,  109,   -1,  111,  112,  113,  114,

			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,   14,   15,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   29,   30,   31,   32,   99,   34,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   51,   52,   -1,   -1,   32,    4,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   -1,   75,   -1,   32,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   45,   -1,   -1,   -1,   -1,   -1,   -1,   45,   -1,

			   32,   -1,  101,   -1,   -1,   -1,   -1,   -1,  107,  108,
			  109,   -1,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  107,  108,  109,   -1,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  108,   -1,   -1,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  108,   -1,   -1,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,    4,    5,

			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   -1,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   -1,   -1,   -1,   -1,   45,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   99,   45,   83,    4,    5,    6,    7,

			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,   -1,  129,   -1,   -1,   -1,   -1,   45,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21>>)
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

	yytype63 (v: ANY): TYPE is
		require
			valid_type: yyis_type63 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type63 (v: ANY): BOOLEAN is
		local
			u: TYPE
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

	yytype89 (v: ANY): EIFFEL_LIST [TYPE] is
		require
			valid_type: yyis_type89 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type89 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE]
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

	yytype96 (v: ANY): PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]] is
		require
			valid_type: yyis_type96 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type96 (v: ANY): BOOLEAN is
		local
			u: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 815
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 130
			-- Number of tokens

	yyLast: INTEGER is 2084
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 384
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 314
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
