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
					--|#line 924 "eiffel.y"
				yy_do_action_145
			when 146 then
					--|#line 926 "eiffel.y"
				yy_do_action_146
			when 147 then
					--|#line 928 "eiffel.y"
				yy_do_action_147
			when 148 then
					--|#line 932 "eiffel.y"
				yy_do_action_148
			when 149 then
					--|#line 939 "eiffel.y"
				yy_do_action_149
			when 150 then
					--|#line 944 "eiffel.y"
				yy_do_action_150
			when 151 then
					--|#line 946 "eiffel.y"
				yy_do_action_151
			when 152 then
					--|#line 950 "eiffel.y"
				yy_do_action_152
			when 153 then
					--|#line 952 "eiffel.y"
				yy_do_action_153
			when 154 then
					--|#line 956 "eiffel.y"
				yy_do_action_154
			when 155 then
					--|#line 958 "eiffel.y"
				yy_do_action_155
			when 156 then
					--|#line 962 "eiffel.y"
				yy_do_action_156
			when 157 then
					--|#line 964 "eiffel.y"
				yy_do_action_157
			when 158 then
					--|#line 968 "eiffel.y"
				yy_do_action_158
			when 159 then
					--|#line 973 "eiffel.y"
				yy_do_action_159
			when 160 then
					--|#line 980 "eiffel.y"
				yy_do_action_160
			when 161 then
					--|#line 984 "eiffel.y"
				yy_do_action_161
			when 162 then
					--|#line 985 "eiffel.y"
				yy_do_action_162
			when 163 then
					--|#line 988 "eiffel.y"
				yy_do_action_163
			when 164 then
					--|#line 990 "eiffel.y"
				yy_do_action_164
			when 165 then
					--|#line 992 "eiffel.y"
				yy_do_action_165
			when 166 then
					--|#line 994 "eiffel.y"
				yy_do_action_166
			when 167 then
					--|#line 996 "eiffel.y"
				yy_do_action_167
			when 168 then
					--|#line 998 "eiffel.y"
				yy_do_action_168
			when 169 then
					--|#line 1000 "eiffel.y"
				yy_do_action_169
			when 170 then
					--|#line 1002 "eiffel.y"
				yy_do_action_170
			when 171 then
					--|#line 1004 "eiffel.y"
				yy_do_action_171
			when 172 then
					--|#line 1006 "eiffel.y"
				yy_do_action_172
			when 173 then
					--|#line 1010 "eiffel.y"
				yy_do_action_173
			when 174 then
					--|#line 1012 "eiffel.y"
				yy_do_action_174
			when 175 then
					--|#line 1012 "eiffel.y"
				yy_do_action_175
			when 176 then
					--|#line 1019 "eiffel.y"
				yy_do_action_176
			when 177 then
					--|#line 1019 "eiffel.y"
				yy_do_action_177
			when 178 then
					--|#line 1028 "eiffel.y"
				yy_do_action_178
			when 179 then
					--|#line 1030 "eiffel.y"
				yy_do_action_179
			when 180 then
					--|#line 1030 "eiffel.y"
				yy_do_action_180
			when 181 then
					--|#line 1037 "eiffel.y"
				yy_do_action_181
			when 182 then
					--|#line 1037 "eiffel.y"
				yy_do_action_182
			when 183 then
					--|#line 1046 "eiffel.y"
				yy_do_action_183
			when 184 then
					--|#line 1048 "eiffel.y"
				yy_do_action_184
			when 185 then
					--|#line 1057 "eiffel.y"
				yy_do_action_185
			when 186 then
					--|#line 1062 "eiffel.y"
				yy_do_action_186
			when 187 then
					--|#line 1069 "eiffel.y"
				yy_do_action_187
			when 188 then
					--|#line 1073 "eiffel.y"
				yy_do_action_188
			when 189 then
					--|#line 1075 "eiffel.y"
				yy_do_action_189
			when 190 then
					--|#line 1077 "eiffel.y"
				yy_do_action_190
			when 191 then
					--|#line 1085 "eiffel.y"
				yy_do_action_191
			when 192 then
					--|#line 1087 "eiffel.y"
				yy_do_action_192
			when 193 then
					--|#line 1091 "eiffel.y"
				yy_do_action_193
			when 194 then
					--|#line 1100 "eiffel.y"
				yy_do_action_194
			when 195 then
					--|#line 1102 "eiffel.y"
				yy_do_action_195
			when 196 then
					--|#line 1104 "eiffel.y"
				yy_do_action_196
			when 197 then
					--|#line 1106 "eiffel.y"
				yy_do_action_197
			when 198 then
					--|#line 1108 "eiffel.y"
				yy_do_action_198
			when 199 then
					--|#line 1112 "eiffel.y"
				yy_do_action_199
			when 200 then
					--|#line 1116 "eiffel.y"
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
					--|#line 1118 "eiffel.y"
				yy_do_action_201
			when 202 then
					--|#line 1120 "eiffel.y"
				yy_do_action_202
			when 203 then
					--|#line 1124 "eiffel.y"
				yy_do_action_203
			when 204 then
					--|#line 1126 "eiffel.y"
				yy_do_action_204
			when 205 then
					--|#line 1130 "eiffel.y"
				yy_do_action_205
			when 206 then
					--|#line 1135 "eiffel.y"
				yy_do_action_206
			when 207 then
					--|#line 1146 "eiffel.y"
				yy_do_action_207
			when 208 then
					--|#line 1152 "eiffel.y"
				yy_do_action_208
			when 209 then
					--|#line 1160 "eiffel.y"
				yy_do_action_209
			when 210 then
					--|#line 1162 "eiffel.y"
				yy_do_action_210
			when 211 then
					--|#line 1166 "eiffel.y"
				yy_do_action_211
			when 212 then
					--|#line 1171 "eiffel.y"
				yy_do_action_212
			when 213 then
					--|#line 1178 "eiffel.y"
				yy_do_action_213
			when 214 then
					--|#line 1195 "eiffel.y"
				yy_do_action_214
			when 215 then
					--|#line 1213 "eiffel.y"
				yy_do_action_215
			when 216 then
					--|#line 1232 "eiffel.y"
				yy_do_action_216
			when 217 then
					--|#line 1232 "eiffel.y"
				yy_do_action_217
			when 218 then
					--|#line 1245 "eiffel.y"
				yy_do_action_218
			when 219 then
					--|#line 1247 "eiffel.y"
				yy_do_action_219
			when 220 then
					--|#line 1255 "eiffel.y"
				yy_do_action_220
			when 221 then
					--|#line 1257 "eiffel.y"
				yy_do_action_221
			when 222 then
					--|#line 1265 "eiffel.y"
				yy_do_action_222
			when 223 then
					--|#line 1271 "eiffel.y"
				yy_do_action_223
			when 224 then
					--|#line 1273 "eiffel.y"
				yy_do_action_224
			when 225 then
					--|#line 1277 "eiffel.y"
				yy_do_action_225
			when 226 then
					--|#line 1282 "eiffel.y"
				yy_do_action_226
			when 227 then
					--|#line 1289 "eiffel.y"
				yy_do_action_227
			when 228 then
					--|#line 1293 "eiffel.y"
				yy_do_action_228
			when 229 then
					--|#line 1295 "eiffel.y"
				yy_do_action_229
			when 230 then
					--|#line 1299 "eiffel.y"
				yy_do_action_230
			when 231 then
					--|#line 1305 "eiffel.y"
				yy_do_action_231
			when 232 then
					--|#line 1307 "eiffel.y"
				yy_do_action_232
			when 233 then
					--|#line 1311 "eiffel.y"
				yy_do_action_233
			when 234 then
					--|#line 1316 "eiffel.y"
				yy_do_action_234
			when 235 then
					--|#line 1323 "eiffel.y"
				yy_do_action_235
			when 236 then
					--|#line 1327 "eiffel.y"
				yy_do_action_236
			when 237 then
					--|#line 1332 "eiffel.y"
				yy_do_action_237
			when 238 then
					--|#line 1339 "eiffel.y"
				yy_do_action_238
			when 239 then
					--|#line 1341 "eiffel.y"
				yy_do_action_239
			when 240 then
					--|#line 1343 "eiffel.y"
				yy_do_action_240
			when 241 then
					--|#line 1345 "eiffel.y"
				yy_do_action_241
			when 242 then
					--|#line 1347 "eiffel.y"
				yy_do_action_242
			when 243 then
					--|#line 1349 "eiffel.y"
				yy_do_action_243
			when 244 then
					--|#line 1351 "eiffel.y"
				yy_do_action_244
			when 245 then
					--|#line 1353 "eiffel.y"
				yy_do_action_245
			when 246 then
					--|#line 1355 "eiffel.y"
				yy_do_action_246
			when 247 then
					--|#line 1357 "eiffel.y"
				yy_do_action_247
			when 248 then
					--|#line 1359 "eiffel.y"
				yy_do_action_248
			when 249 then
					--|#line 1361 "eiffel.y"
				yy_do_action_249
			when 250 then
					--|#line 1363 "eiffel.y"
				yy_do_action_250
			when 251 then
					--|#line 1365 "eiffel.y"
				yy_do_action_251
			when 252 then
					--|#line 1367 "eiffel.y"
				yy_do_action_252
			when 253 then
					--|#line 1369 "eiffel.y"
				yy_do_action_253
			when 254 then
					--|#line 1371 "eiffel.y"
				yy_do_action_254
			when 255 then
					--|#line 1373 "eiffel.y"
				yy_do_action_255
			when 256 then
					--|#line 1378 "eiffel.y"
				yy_do_action_256
			when 257 then
					--|#line 1380 "eiffel.y"
				yy_do_action_257
			when 258 then
					--|#line 1389 "eiffel.y"
				yy_do_action_258
			when 259 then
					--|#line 1395 "eiffel.y"
				yy_do_action_259
			when 260 then
					--|#line 1397 "eiffel.y"
				yy_do_action_260
			when 261 then
					--|#line 1401 "eiffel.y"
				yy_do_action_261
			when 262 then
					--|#line 1403 "eiffel.y"
				yy_do_action_262
			when 263 then
					--|#line 1403 "eiffel.y"
				yy_do_action_263
			when 264 then
					--|#line 1414 "eiffel.y"
				yy_do_action_264
			when 265 then
					--|#line 1416 "eiffel.y"
				yy_do_action_265
			when 266 then
					--|#line 1418 "eiffel.y"
				yy_do_action_266
			when 267 then
					--|#line 1422 "eiffel.y"
				yy_do_action_267
			when 268 then
					--|#line 1428 "eiffel.y"
				yy_do_action_268
			when 269 then
					--|#line 1430 "eiffel.y"
				yy_do_action_269
			when 270 then
					--|#line 1432 "eiffel.y"
				yy_do_action_270
			when 271 then
					--|#line 1436 "eiffel.y"
				yy_do_action_271
			when 272 then
					--|#line 1441 "eiffel.y"
				yy_do_action_272
			when 273 then
					--|#line 1448 "eiffel.y"
				yy_do_action_273
			when 274 then
					--|#line 1452 "eiffel.y"
				yy_do_action_274
			when 275 then
					--|#line 1454 "eiffel.y"
				yy_do_action_275
			when 276 then
					--|#line 1463 "eiffel.y"
				yy_do_action_276
			when 277 then
					--|#line 1465 "eiffel.y"
				yy_do_action_277
			when 278 then
					--|#line 1469 "eiffel.y"
				yy_do_action_278
			when 279 then
					--|#line 1471 "eiffel.y"
				yy_do_action_279
			when 280 then
					--|#line 1475 "eiffel.y"
				yy_do_action_280
			when 281 then
					--|#line 1477 "eiffel.y"
				yy_do_action_281
			when 282 then
					--|#line 1481 "eiffel.y"
				yy_do_action_282
			when 283 then
					--|#line 1486 "eiffel.y"
				yy_do_action_283
			when 284 then
					--|#line 1493 "eiffel.y"
				yy_do_action_284
			when 285 then
					--|#line 1499 "eiffel.y"
				yy_do_action_285
			when 286 then
					--|#line 1504 "eiffel.y"
				yy_do_action_286
			when 287 then
					--|#line 1509 "eiffel.y"
				yy_do_action_287
			when 288 then
					--|#line 1519 "eiffel.y"
				yy_do_action_288
			when 289 then
					--|#line 1529 "eiffel.y"
				yy_do_action_289
			when 290 then
					--|#line 1541 "eiffel.y"
				yy_do_action_290
			when 291 then
					--|#line 1543 "eiffel.y"
				yy_do_action_291
			when 292 then
					--|#line 1545 "eiffel.y"
				yy_do_action_292
			when 293 then
					--|#line 1563 "eiffel.y"
				yy_do_action_293
			when 294 then
					--|#line 1565 "eiffel.y"
				yy_do_action_294
			when 295 then
					--|#line 1567 "eiffel.y"
				yy_do_action_295
			when 296 then
					--|#line 1569 "eiffel.y"
				yy_do_action_296
			when 297 then
					--|#line 1571 "eiffel.y"
				yy_do_action_297
			when 298 then
					--|#line 1573 "eiffel.y"
				yy_do_action_298
			when 299 then
					--|#line 1575 "eiffel.y"
				yy_do_action_299
			when 300 then
					--|#line 1579 "eiffel.y"
				yy_do_action_300
			when 301 then
					--|#line 1581 "eiffel.y"
				yy_do_action_301
			when 302 then
					--|#line 1583 "eiffel.y"
				yy_do_action_302
			when 303 then
					--|#line 1585 "eiffel.y"
				yy_do_action_303
			when 304 then
					--|#line 1587 "eiffel.y"
				yy_do_action_304
			when 305 then
					--|#line 1589 "eiffel.y"
				yy_do_action_305
			when 306 then
					--|#line 1593 "eiffel.y"
				yy_do_action_306
			when 307 then
					--|#line 1595 "eiffel.y"
				yy_do_action_307
			when 308 then
					--|#line 1597 "eiffel.y"
				yy_do_action_308
			when 309 then
					--|#line 1601 "eiffel.y"
				yy_do_action_309
			when 310 then
					--|#line 1606 "eiffel.y"
				yy_do_action_310
			when 311 then
					--|#line 1613 "eiffel.y"
				yy_do_action_311
			when 312 then
					--|#line 1619 "eiffel.y"
				yy_do_action_312
			when 313 then
					--|#line 1621 "eiffel.y"
				yy_do_action_313
			when 314 then
					--|#line 1623 "eiffel.y"
				yy_do_action_314
			when 315 then
					--|#line 1632 "eiffel.y"
				yy_do_action_315
			when 316 then
					--|#line 1634 "eiffel.y"
				yy_do_action_316
			when 317 then
					--|#line 1636 "eiffel.y"
				yy_do_action_317
			when 318 then
					--|#line 1638 "eiffel.y"
				yy_do_action_318
			when 319 then
					--|#line 1640 "eiffel.y"
				yy_do_action_319
			when 320 then
					--|#line 1642 "eiffel.y"
				yy_do_action_320
			when 321 then
					--|#line 1646 "eiffel.y"
				yy_do_action_321
			when 322 then
					--|#line 1655 "eiffel.y"
				yy_do_action_322
			when 323 then
					--|#line 1657 "eiffel.y"
				yy_do_action_323
			when 324 then
					--|#line 1661 "eiffel.y"
				yy_do_action_324
			when 325 then
					--|#line 1663 "eiffel.y"
				yy_do_action_325
			when 326 then
					--|#line 1674 "eiffel.y"
				yy_do_action_326
			when 327 then
					--|#line 1676 "eiffel.y"
				yy_do_action_327
			when 328 then
					--|#line 1680 "eiffel.y"
				yy_do_action_328
			when 329 then
					--|#line 1682 "eiffel.y"
				yy_do_action_329
			when 330 then
					--|#line 1686 "eiffel.y"
				yy_do_action_330
			when 331 then
					--|#line 1688 "eiffel.y"
				yy_do_action_331
			when 332 then
					--|#line 1696 "eiffel.y"
				yy_do_action_332
			when 333 then
					--|#line 1698 "eiffel.y"
				yy_do_action_333
			when 334 then
					--|#line 1700 "eiffel.y"
				yy_do_action_334
			when 335 then
					--|#line 1702 "eiffel.y"
				yy_do_action_335
			when 336 then
					--|#line 1704 "eiffel.y"
				yy_do_action_336
			when 337 then
					--|#line 1706 "eiffel.y"
				yy_do_action_337
			when 338 then
					--|#line 1708 "eiffel.y"
				yy_do_action_338
			when 339 then
					--|#line 1710 "eiffel.y"
				yy_do_action_339
			when 340 then
					--|#line 1712 "eiffel.y"
				yy_do_action_340
			when 341 then
					--|#line 1716 "eiffel.y"
				yy_do_action_341
			when 342 then
					--|#line 1724 "eiffel.y"
				yy_do_action_342
			when 343 then
					--|#line 1726 "eiffel.y"
				yy_do_action_343
			when 344 then
					--|#line 1728 "eiffel.y"
				yy_do_action_344
			when 345 then
					--|#line 1730 "eiffel.y"
				yy_do_action_345
			when 346 then
					--|#line 1732 "eiffel.y"
				yy_do_action_346
			when 347 then
					--|#line 1734 "eiffel.y"
				yy_do_action_347
			when 348 then
					--|#line 1736 "eiffel.y"
				yy_do_action_348
			when 349 then
					--|#line 1738 "eiffel.y"
				yy_do_action_349
			when 350 then
					--|#line 1740 "eiffel.y"
				yy_do_action_350
			when 351 then
					--|#line 1742 "eiffel.y"
				yy_do_action_351
			when 352 then
					--|#line 1744 "eiffel.y"
				yy_do_action_352
			when 353 then
					--|#line 1746 "eiffel.y"
				yy_do_action_353
			when 354 then
					--|#line 1748 "eiffel.y"
				yy_do_action_354
			when 355 then
					--|#line 1750 "eiffel.y"
				yy_do_action_355
			when 356 then
					--|#line 1752 "eiffel.y"
				yy_do_action_356
			when 357 then
					--|#line 1754 "eiffel.y"
				yy_do_action_357
			when 358 then
					--|#line 1756 "eiffel.y"
				yy_do_action_358
			when 359 then
					--|#line 1758 "eiffel.y"
				yy_do_action_359
			when 360 then
					--|#line 1760 "eiffel.y"
				yy_do_action_360
			when 361 then
					--|#line 1762 "eiffel.y"
				yy_do_action_361
			when 362 then
					--|#line 1764 "eiffel.y"
				yy_do_action_362
			when 363 then
					--|#line 1766 "eiffel.y"
				yy_do_action_363
			when 364 then
					--|#line 1768 "eiffel.y"
				yy_do_action_364
			when 365 then
					--|#line 1770 "eiffel.y"
				yy_do_action_365
			when 366 then
					--|#line 1772 "eiffel.y"
				yy_do_action_366
			when 367 then
					--|#line 1774 "eiffel.y"
				yy_do_action_367
			when 368 then
					--|#line 1776 "eiffel.y"
				yy_do_action_368
			when 369 then
					--|#line 1778 "eiffel.y"
				yy_do_action_369
			when 370 then
					--|#line 1780 "eiffel.y"
				yy_do_action_370
			when 371 then
					--|#line 1782 "eiffel.y"
				yy_do_action_371
			when 372 then
					--|#line 1784 "eiffel.y"
				yy_do_action_372
			when 373 then
					--|#line 1786 "eiffel.y"
				yy_do_action_373
			when 374 then
					--|#line 1788 "eiffel.y"
				yy_do_action_374
			when 375 then
					--|#line 1790 "eiffel.y"
				yy_do_action_375
			when 376 then
					--|#line 1792 "eiffel.y"
				yy_do_action_376
			when 377 then
					--|#line 1794 "eiffel.y"
				yy_do_action_377
			when 378 then
					--|#line 1796 "eiffel.y"
				yy_do_action_378
			when 379 then
					--|#line 1800 "eiffel.y"
				yy_do_action_379
			when 380 then
					--|#line 1808 "eiffel.y"
				yy_do_action_380
			when 381 then
					--|#line 1810 "eiffel.y"
				yy_do_action_381
			when 382 then
					--|#line 1812 "eiffel.y"
				yy_do_action_382
			when 383 then
					--|#line 1814 "eiffel.y"
				yy_do_action_383
			when 384 then
					--|#line 1816 "eiffel.y"
				yy_do_action_384
			when 385 then
					--|#line 1818 "eiffel.y"
				yy_do_action_385
			when 386 then
					--|#line 1820 "eiffel.y"
				yy_do_action_386
			when 387 then
					--|#line 1822 "eiffel.y"
				yy_do_action_387
			when 388 then
					--|#line 1824 "eiffel.y"
				yy_do_action_388
			when 389 then
					--|#line 1826 "eiffel.y"
				yy_do_action_389
			when 390 then
					--|#line 1828 "eiffel.y"
				yy_do_action_390
			when 391 then
					--|#line 1830 "eiffel.y"
				yy_do_action_391
			when 392 then
					--|#line 1834 "eiffel.y"
				yy_do_action_392
			when 393 then
					--|#line 1838 "eiffel.y"
				yy_do_action_393
			when 394 then
					--|#line 1842 "eiffel.y"
				yy_do_action_394
			when 395 then
					--|#line 1846 "eiffel.y"
				yy_do_action_395
			when 396 then
					--|#line 1850 "eiffel.y"
				yy_do_action_396
			when 397 then
					--|#line 1854 "eiffel.y"
				yy_do_action_397
			when 398 then
					--|#line 1856 "eiffel.y"
				yy_do_action_398
			when 399 then
					--|#line 1858 "eiffel.y"
				yy_do_action_399
			when 400 then
					--|#line 1860 "eiffel.y"
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
					--|#line 1864 "eiffel.y"
				yy_do_action_401
			when 402 then
					--|#line 1868 "eiffel.y"
				yy_do_action_402
			when 403 then
					--|#line 1875 "eiffel.y"
				yy_do_action_403
			when 404 then
					--|#line 1883 "eiffel.y"
				yy_do_action_404
			when 405 then
					--|#line 1885 "eiffel.y"
				yy_do_action_405
			when 406 then
					--|#line 1889 "eiffel.y"
				yy_do_action_406
			when 407 then
					--|#line 1891 "eiffel.y"
				yy_do_action_407
			when 408 then
					--|#line 1895 "eiffel.y"
				yy_do_action_408
			when 409 then
					--|#line 1897 "eiffel.y"
				yy_do_action_409
			when 410 then
					--|#line 1899 "eiffel.y"
				yy_do_action_410
			when 411 then
					--|#line 1903 "eiffel.y"
				yy_do_action_411
			when 412 then
					--|#line 1916 "eiffel.y"
				yy_do_action_412
			when 413 then
					--|#line 1920 "eiffel.y"
				yy_do_action_413
			when 414 then
					--|#line 1922 "eiffel.y"
				yy_do_action_414
			when 415 then
					--|#line 1924 "eiffel.y"
				yy_do_action_415
			when 416 then
					--|#line 1928 "eiffel.y"
				yy_do_action_416
			when 417 then
					--|#line 1933 "eiffel.y"
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
					--|#line 1962 "eiffel.y"
				yy_do_action_422
			when 423 then
					--|#line 1971 "eiffel.y"
				yy_do_action_423
			when 424 then
					--|#line 1973 "eiffel.y"
				yy_do_action_424
			when 425 then
					--|#line 1975 "eiffel.y"
				yy_do_action_425
			when 426 then
					--|#line 1977 "eiffel.y"
				yy_do_action_426
			when 427 then
					--|#line 1979 "eiffel.y"
				yy_do_action_427
			when 428 then
					--|#line 1981 "eiffel.y"
				yy_do_action_428
			when 429 then
					--|#line 1985 "eiffel.y"
				yy_do_action_429
			when 430 then
					--|#line 1987 "eiffel.y"
				yy_do_action_430
			when 431 then
					--|#line 1989 "eiffel.y"
				yy_do_action_431
			when 432 then
					--|#line 2004 "eiffel.y"
				yy_do_action_432
			when 433 then
					--|#line 2006 "eiffel.y"
				yy_do_action_433
			when 434 then
					--|#line 2008 "eiffel.y"
				yy_do_action_434
			when 435 then
					--|#line 2010 "eiffel.y"
				yy_do_action_435
			when 436 then
					--|#line 2018 "eiffel.y"
				yy_do_action_436
			when 437 then
					--|#line 2020 "eiffel.y"
				yy_do_action_437
			when 438 then
					--|#line 2024 "eiffel.y"
				yy_do_action_438
			when 439 then
					--|#line 2031 "eiffel.y"
				yy_do_action_439
			when 440 then
					--|#line 2046 "eiffel.y"
				yy_do_action_440
			when 441 then
					--|#line 2061 "eiffel.y"
				yy_do_action_441
			when 442 then
					--|#line 2079 "eiffel.y"
				yy_do_action_442
			when 443 then
					--|#line 2081 "eiffel.y"
				yy_do_action_443
			when 444 then
					--|#line 2083 "eiffel.y"
				yy_do_action_444
			when 445 then
					--|#line 2090 "eiffel.y"
				yy_do_action_445
			when 446 then
					--|#line 2094 "eiffel.y"
				yy_do_action_446
			when 447 then
					--|#line 2096 "eiffel.y"
				yy_do_action_447
			when 448 then
					--|#line 2098 "eiffel.y"
				yy_do_action_448
			when 449 then
					--|#line 2102 "eiffel.y"
				yy_do_action_449
			when 450 then
					--|#line 2104 "eiffel.y"
				yy_do_action_450
			when 451 then
					--|#line 2106 "eiffel.y"
				yy_do_action_451
			when 452 then
					--|#line 2108 "eiffel.y"
				yy_do_action_452
			when 453 then
					--|#line 2110 "eiffel.y"
				yy_do_action_453
			when 454 then
					--|#line 2112 "eiffel.y"
				yy_do_action_454
			when 455 then
					--|#line 2114 "eiffel.y"
				yy_do_action_455
			when 456 then
					--|#line 2116 "eiffel.y"
				yy_do_action_456
			when 457 then
					--|#line 2118 "eiffel.y"
				yy_do_action_457
			when 458 then
					--|#line 2120 "eiffel.y"
				yy_do_action_458
			when 459 then
					--|#line 2122 "eiffel.y"
				yy_do_action_459
			when 460 then
					--|#line 2124 "eiffel.y"
				yy_do_action_460
			when 461 then
					--|#line 2126 "eiffel.y"
				yy_do_action_461
			when 462 then
					--|#line 2128 "eiffel.y"
				yy_do_action_462
			when 463 then
					--|#line 2130 "eiffel.y"
				yy_do_action_463
			when 464 then
					--|#line 2132 "eiffel.y"
				yy_do_action_464
			when 465 then
					--|#line 2134 "eiffel.y"
				yy_do_action_465
			when 466 then
					--|#line 2136 "eiffel.y"
				yy_do_action_466
			when 467 then
					--|#line 2138 "eiffel.y"
				yy_do_action_467
			when 468 then
					--|#line 2140 "eiffel.y"
				yy_do_action_468
			when 469 then
					--|#line 2142 "eiffel.y"
				yy_do_action_469
			when 470 then
					--|#line 2146 "eiffel.y"
				yy_do_action_470
			when 471 then
					--|#line 2148 "eiffel.y"
				yy_do_action_471
			when 472 then
					--|#line 2150 "eiffel.y"
				yy_do_action_472
			when 473 then
					--|#line 2152 "eiffel.y"
				yy_do_action_473
			when 474 then
					--|#line 2156 "eiffel.y"
				yy_do_action_474
			when 475 then
					--|#line 2158 "eiffel.y"
				yy_do_action_475
			when 476 then
					--|#line 2160 "eiffel.y"
				yy_do_action_476
			when 477 then
					--|#line 2162 "eiffel.y"
				yy_do_action_477
			when 478 then
					--|#line 2164 "eiffel.y"
				yy_do_action_478
			when 479 then
					--|#line 2166 "eiffel.y"
				yy_do_action_479
			when 480 then
					--|#line 2168 "eiffel.y"
				yy_do_action_480
			when 481 then
					--|#line 2170 "eiffel.y"
				yy_do_action_481
			when 482 then
					--|#line 2172 "eiffel.y"
				yy_do_action_482
			when 483 then
					--|#line 2174 "eiffel.y"
				yy_do_action_483
			when 484 then
					--|#line 2176 "eiffel.y"
				yy_do_action_484
			when 485 then
					--|#line 2178 "eiffel.y"
				yy_do_action_485
			when 486 then
					--|#line 2180 "eiffel.y"
				yy_do_action_486
			when 487 then
					--|#line 2182 "eiffel.y"
				yy_do_action_487
			when 488 then
					--|#line 2184 "eiffel.y"
				yy_do_action_488
			when 489 then
					--|#line 2186 "eiffel.y"
				yy_do_action_489
			when 490 then
					--|#line 2188 "eiffel.y"
				yy_do_action_490
			when 491 then
					--|#line 2190 "eiffel.y"
				yy_do_action_491
			when 492 then
					--|#line 2194 "eiffel.y"
				yy_do_action_492
			when 493 then
					--|#line 2198 "eiffel.y"
				yy_do_action_493
			when 494 then
					--|#line 2202 "eiffel.y"
				yy_do_action_494
			when 495 then
					--|#line 2206 "eiffel.y"
				yy_do_action_495
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
				yytype92 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype92 (yyvs.item (yyvsp)).first, Void, False, False))
			
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
				yytype92 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype92 (yyvs.item (yyvsp)).first, Void, False, False))
			
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
			yyval63: TYPE_AS
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
			yyval63: TYPE_AS
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


				yyval56 := new_routine_as (yytype60 (yyvs.item (yyvsp - 7)), yytype52 (yyvs.item (yyvsp - 5)), yytype90 (yyvs.item (yyvsp - 4)), yytype55 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp - 1)), fbody_pos, current_position, once_manifest_string_count)
				once_manifest_string_count := 0
			
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
			--|#line 924 "eiffel.y"
		local
			yyval55: ROUT_BODY_AS
		do
--|#line 924 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 924")
end


yyval55 := yytype40 (yyvs.item (yyvsp)) 
			yyval := yyval55
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_146 is
			--|#line 926 "eiffel.y"
		local
			yyval55: ROUT_BODY_AS
		do
--|#line 926 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 926")
end


yyval55 := yytype26 (yyvs.item (yyvsp)) 
			yyval := yyval55
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_147 is
			--|#line 928 "eiffel.y"
		local
			yyval55: ROUT_BODY_AS
		do
--|#line 928 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 928")
end


yyval55 := new_deferred_as 
			yyval := yyval55
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_148 is
			--|#line 932 "eiffel.y"
		local
			yyval26: EXTERNAL_AS
		do
--|#line 932 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 932")
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
			--|#line 939 "eiffel.y"
		local
			yyval27: EXTERNAL_LANG_AS
		do
--|#line 939 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 939")
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
			--|#line 944 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 944 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 944")
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
			--|#line 946 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 946 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 946")
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
			--|#line 950 "eiffel.y"
		local
			yyval40: INTERNAL_AS
		do
--|#line 950 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 950")
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
			--|#line 952 "eiffel.y"
		local
			yyval40: INTERNAL_AS
		do
--|#line 952 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 952")
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
			--|#line 956 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 956 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 956")
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
			--|#line 958 "eiffel.y"
		local
			yyval90: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 958 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 958")
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
			--|#line 962 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 962 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 962")
end



			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_157 is
			--|#line 964 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 964 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 964")
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
			--|#line 968 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 968 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 968")
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
			--|#line 973 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 973 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 973")
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
			--|#line 980 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 980 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 980")
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
			--|#line 984 "eiffel.y"
		do
--|#line 984 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 984")
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
			--|#line 985 "eiffel.y"
		do
--|#line 985 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 985")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_163 is
			--|#line 988 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 988 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 988")
end


yyval38 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_164 is
			--|#line 990 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 990 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 990")
end


yyval38 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_165 is
			--|#line 992 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 992 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 992")
end


yyval38 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_166 is
			--|#line 994 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 994 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 994")
end


yyval38 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_167 is
			--|#line 996 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 996 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 996")
end


yyval38 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_168 is
			--|#line 998 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 998 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 998")
end


yyval38 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_169 is
			--|#line 1000 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 1000 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1000")
end


yyval38 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_170 is
			--|#line 1002 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 1002 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1002")
end


yyval38 := yytype21 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_171 is
			--|#line 1004 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 1004 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1004")
end


yyval38 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_172 is
			--|#line 1006 "eiffel.y"
		local
			yyval38: INSTRUCTION_AS
		do
--|#line 1006 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1006")
end


yyval38 := yytype53 (yyvs.item (yyvsp)) 
			yyval := yyval38
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_173 is
			--|#line 1010 "eiffel.y"
		local
			yyval52: REQUIRE_AS
		do
--|#line 1010 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1010")
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
			--|#line 1012 "eiffel.y"
		local
			yyval52: REQUIRE_AS
		do
--|#line 1012 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1012")
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
			--|#line 1012 "eiffel.y"
		do
--|#line 1012 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1012")
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
			--|#line 1019 "eiffel.y"
		local
			yyval52: REQUIRE_AS
		do
--|#line 1019 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1019")
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

	yy_do_action_178 is
			--|#line 1028 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1028 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1028")
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
			--|#line 1030 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1030 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1030")
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
			--|#line 1030 "eiffel.y"
		do
--|#line 1030 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1030")
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
			--|#line 1037 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1037 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1037")
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
			--|#line 1037 "eiffel.y"
		do
--|#line 1037 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1037")
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
			--|#line 1046 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1046 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1046")
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
			--|#line 1048 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1048 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1048")
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
			--|#line 1057 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1057 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1057")
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
			--|#line 1062 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1062 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1062")
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
			--|#line 1069 "eiffel.y"
		local
			yyval61: TAGGED_AS
		do
--|#line 1069 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1069")
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
			--|#line 1073 "eiffel.y"
		local
			yyval61: TAGGED_AS
		do
--|#line 1073 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1073")
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
			--|#line 1075 "eiffel.y"
		local
			yyval61: TAGGED_AS
		do
--|#line 1075 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1075")
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
			--|#line 1077 "eiffel.y"
		local
			yyval61: TAGGED_AS
		do
--|#line 1077 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1077")
end



			yyval := yyval61
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_191 is
			--|#line 1085 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1085 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1085")
end


yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_192 is
			--|#line 1087 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1087 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1087")
end


yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_193 is
			--|#line 1091 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1091 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1091")
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

	yy_do_action_194 is
			--|#line 1100 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1100 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1100")
end


yyval63 := new_class_type (yytype92 (yyvs.item (yyvsp - 1)), yytype89 (yyvs.item (yyvsp)), False, True) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_195 is
			--|#line 1102 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1102 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1102")
end


yyval63 := new_bits_as (yytype39 (yyvs.item (yyvsp))) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_196 is
			--|#line 1104 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1104 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1104")
end


yyval63 := new_bits_symbol_as (yytype33 (yyvs.item (yyvsp))) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_197 is
			--|#line 1106 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1106 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1106")
end


yyval63 := new_like_id_as (yytype33 (yyvs.item (yyvsp))) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_198 is
			--|#line 1108 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1108 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1108")
end


yyval63 := new_like_current_as 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_199 is
			--|#line 1112 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1112 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1112")
end


yyval63 := new_class_type (yytype92 (yyvs.item (yyvsp - 1)), yytype89 (yyvs.item (yyvsp)), False, False) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_200 is
			--|#line 1116 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_AS]
		do
--|#line 1116 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1116")
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

	yy_do_action_201 is
			--|#line 1118 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_AS]
		do
--|#line 1118 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1118")
end



			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_202 is
			--|#line 1120 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_AS]
		do
--|#line 1120 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1120")
end


yyval89 := yytype89 (yyvs.item (yyvsp - 1)) 
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_203 is
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
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_204 is
			--|#line 1126 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_AS]
		do
--|#line 1126 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1126")
end


yyval89 := yytype89 (yyvs.item (yyvsp - 1)) 
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_205 is
			--|#line 1130 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_AS]
		do
--|#line 1130 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1130")
end


				yyval89 := new_eiffel_list_type (Initial_type_list_size)
				yyval89.extend (yytype63 (yyvs.item (yyvsp)))
			
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_206 is
			--|#line 1135 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_AS]
		do
--|#line 1135 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1135")
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

	yy_do_action_207 is
			--|#line 1146 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1146 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1146")
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

	yy_do_action_208 is
			--|#line 1152 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1152 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1152")
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

	yy_do_action_209 is
			--|#line 1160 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1160 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1160")
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

	yy_do_action_210 is
			--|#line 1162 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1162 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1162")
end


yyval77 := yytype77 (yyvs.item (yyvsp)) 
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_211 is
			--|#line 1166 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1166 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1166")
end


				yyval77 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval77.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_212 is
			--|#line 1171 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1171 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1171")
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

	yy_do_action_213 is
			--|#line 1178 "eiffel.y"
		local
			yyval31: FORMAL_AS
		do
--|#line 1178 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1178")
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

	yy_do_action_214 is
			--|#line 1195 "eiffel.y"
		local
			yyval31: FORMAL_AS
		do
--|#line 1195 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1195")
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

	yy_do_action_215 is
			--|#line 1213 "eiffel.y"
		local
			yyval31: FORMAL_AS
		do
--|#line 1213 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1213")
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

	yy_do_action_216 is
			--|#line 1232 "eiffel.y"
		local
			yyval32: FORMAL_DEC_AS
		do
--|#line 1232 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1232")
end


				yyval32 := new_formal_dec_as (yytype31 (yyvs.item (yyvsp - 2)), yytype96 (yyvs.item (yyvsp)).first, yytype96 (yyvs.item (yyvsp)).second)
			
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_217 is
			--|#line 1232 "eiffel.y"
		do
--|#line 1232 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1232")
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

	yy_do_action_218 is
			--|#line 1245 "eiffel.y"
		local
			yyval96: PAIR [TYPE_AS, EIFFEL_LIST [FEATURE_NAME]]
		do
--|#line 1245 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1245")
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

	yy_do_action_219 is
			--|#line 1247 "eiffel.y"
		local
			yyval96: PAIR [TYPE_AS, EIFFEL_LIST [FEATURE_NAME]]
		do
--|#line 1247 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1247")
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

	yy_do_action_220 is
			--|#line 1255 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 1255 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1255")
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

	yy_do_action_221 is
			--|#line 1257 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 1257 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1257")
end


yyval76 := yytype76 (yyvs.item (yyvsp - 1)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_222 is
			--|#line 1265 "eiffel.y"
		local
			yyval34: IF_AS
		do
--|#line 1265 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1265")
end


				yyval34 := new_if_as (yytype25 (yyvs.item (yyvsp - 5)), yytype82 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 7)), current_position)
			
			yyval := yyval34
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_223 is
			--|#line 1271 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1271 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1271")
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

	yy_do_action_224 is
			--|#line 1273 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1273 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1273")
end


yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_225 is
			--|#line 1277 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1277 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1277")
end


				yyval70 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval70.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_226 is
			--|#line 1282 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1282 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1282")
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

	yy_do_action_227 is
			--|#line 1289 "eiffel.y"
		local
			yyval22: ELSIF_AS
		do
--|#line 1289 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1289")
end


yyval22 := new_elseif_as (yytype25 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 4))) 
			yyval := yyval22
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_228 is
			--|#line 1293 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1293 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1293")
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

	yy_do_action_229 is
			--|#line 1295 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1295 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1295")
end


yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_230 is
			--|#line 1299 "eiffel.y"
		local
			yyval36: INSPECT_AS
		do
--|#line 1299 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1299")
end


				yyval36 := new_inspect_as (yytype25 (yyvs.item (yyvsp - 3)), yytype67 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_231 is
			--|#line 1305 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CASE_AS]
		do
--|#line 1305 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1305")
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

	yy_do_action_232 is
			--|#line 1307 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CASE_AS]
		do
--|#line 1307 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1307")
end


yyval67 := yytype67 (yyvs.item (yyvsp)) 
			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_233 is
			--|#line 1311 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CASE_AS]
		do
--|#line 1311 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1311")
end


				yyval67 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval67.extend (yytype12 (yyvs.item (yyvsp)))
			
			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_234 is
			--|#line 1316 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CASE_AS]
		do
--|#line 1316 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1316")
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

	yy_do_action_235 is
			--|#line 1323 "eiffel.y"
		local
			yyval12: CASE_AS
		do
--|#line 1323 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1323")
end


yyval12 := new_case_as (yytype83 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval12
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_236 is
			--|#line 1327 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line 1327 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1327")
end


				yyval83 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval83.extend (yytype41 (yyvs.item (yyvsp)))
			
			yyval := yyval83
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_237 is
			--|#line 1332 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line 1332 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1332")
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

	yy_do_action_238 is
			--|#line 1339 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1339 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1339")
end


yyval41 := new_interval_as (yytype39 (yyvs.item (yyvsp)), Void) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_239 is
			--|#line 1341 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1341 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1341")
end


yyval41 := new_interval_as (yytype39 (yyvs.item (yyvsp - 2)), yytype39 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_240 is
			--|#line 1343 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1343 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1343")
end


yyval41 := new_interval_as (yytype13 (yyvs.item (yyvsp)), Void) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_241 is
			--|#line 1345 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1345 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1345")
end


yyval41 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_242 is
			--|#line 1347 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1347 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1347")
end


yyval41 := new_interval_as (yytype33 (yyvs.item (yyvsp)), Void) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_243 is
			--|#line 1349 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1349 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1349")
end


yyval41 := new_interval_as (yytype33 (yyvs.item (yyvsp - 2)), yytype33 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_244 is
			--|#line 1351 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1351 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1351")
end


yyval41 := new_interval_as (yytype33 (yyvs.item (yyvsp - 2)), yytype39 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_245 is
			--|#line 1353 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1353 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1353")
end


yyval41 := new_interval_as (yytype39 (yyvs.item (yyvsp - 2)), yytype33 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_246 is
			--|#line 1355 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1355 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1355")
end


yyval41 := new_interval_as (yytype33 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_247 is
			--|#line 1357 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1357 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1357")
end


yyval41 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype33 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_248 is
			--|#line 1359 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1359 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1359")
end


yyval41 := new_interval_as (yytype49 (yyvs.item (yyvsp)), Void) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_249 is
			--|#line 1361 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1361 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1361")
end


yyval41 := new_interval_as (yytype49 (yyvs.item (yyvsp - 2)), yytype33 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_250 is
			--|#line 1363 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1363 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1363")
end


yyval41 := new_interval_as (yytype33 (yyvs.item (yyvsp - 2)), yytype49 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_251 is
			--|#line 1365 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1365 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1365")
end


yyval41 := new_interval_as (yytype49 (yyvs.item (yyvsp - 2)), yytype49 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_252 is
			--|#line 1367 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1367 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1367")
end


yyval41 := new_interval_as (yytype49 (yyvs.item (yyvsp - 2)), yytype39 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_253 is
			--|#line 1369 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1369 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1369")
end


yyval41 := new_interval_as (yytype39 (yyvs.item (yyvsp - 2)), yytype49 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_254 is
			--|#line 1371 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1371 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1371")
end


yyval41 := new_interval_as (yytype49 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_255 is
			--|#line 1373 "eiffel.y"
		local
			yyval41: INTERVAL_AS
		do
--|#line 1373 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1373")
end


yyval41 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype49 (yyvs.item (yyvsp))) 
			yyval := yyval41
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_256 is
			--|#line 1378 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1378 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1378")
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

	yy_do_action_257 is
			--|#line 1380 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1380 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1380")
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

	yy_do_action_258 is
			--|#line 1389 "eiffel.y"
		local
			yyval43: LOOP_AS
		do
--|#line 1389 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1389")
end


				yyval43 := new_loop_as (yytype82 (yyvs.item (yyvsp - 8)), yytype88 (yyvs.item (yyvsp - 7)), yytype65 (yyvs.item (yyvsp - 6)), yytype25 (yyvs.item (yyvsp - 3)), yytype82 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 10
	yyvsp := yyvsp - 9
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_259 is
			--|#line 1395 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1395 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1395")
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

	yy_do_action_260 is
			--|#line 1397 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1397 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1397")
end


yyval88 := yytype88 (yyvs.item (yyvsp)) 
			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_261 is
			--|#line 1401 "eiffel.y"
		local
			yyval42: INVARIANT_AS
		do
--|#line 1401 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1401")
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

	yy_do_action_262 is
			--|#line 1403 "eiffel.y"
		local
			yyval42: INVARIANT_AS
		do
--|#line 1403 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1403")
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

	yy_do_action_263 is
			--|#line 1403 "eiffel.y"
		do
--|#line 1403 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1403")
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

	yy_do_action_264 is
			--|#line 1414 "eiffel.y"
		local
			yyval65: VARIANT_AS
		do
--|#line 1414 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1414")
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

	yy_do_action_265 is
			--|#line 1416 "eiffel.y"
		local
			yyval65: VARIANT_AS
		do
--|#line 1416 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1416")
end


yyval65 := new_variant_as (yytype33 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval65
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_266 is
			--|#line 1418 "eiffel.y"
		local
			yyval65: VARIANT_AS
		do
--|#line 1418 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1418")
end


yyval65 := new_variant_as (Void, yytype25 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval65
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_267 is
			--|#line 1422 "eiffel.y"
		local
			yyval21: DEBUG_AS
		do
--|#line 1422 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1422")
end


				yyval21 := new_debug_as (yytype87 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval21
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_268 is
			--|#line 1428 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1428 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1428")
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

	yy_do_action_269 is
			--|#line 1430 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1430 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1430")
end



			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_270 is
			--|#line 1432 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1432 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1432")
end


yyval87 := yytype87 (yyvs.item (yyvsp - 1)) 
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_271 is
			--|#line 1436 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1436 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1436")
end


				yyval87 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval87.extend (yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_272 is
			--|#line 1441 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [STRING_AS]
		do
--|#line 1441 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1441")
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

	yy_do_action_273 is
			--|#line 1448 "eiffel.y"
		local
			yyval53: RETRY_AS
		do
--|#line 1448 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1448")
end


yyval53 := new_retry_as (current_position) 
			yyval := yyval53
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_274 is
			--|#line 1452 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1452 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1452")
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

	yy_do_action_275 is
			--|#line 1454 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1454 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1454")
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

	yy_do_action_276 is
			--|#line 1463 "eiffel.y"
		local
			yyval6: ASSIGN_AS
		do
--|#line 1463 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1463")
end


yyval6 := new_assign_as (new_access_id_as (yytype33 (yyvs.item (yyvsp - 2)), Void), yytype25 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_277 is
			--|#line 1465 "eiffel.y"
		local
			yyval6: ASSIGN_AS
		do
--|#line 1465 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1465")
end


yyval6 := new_assign_as (new_result_as, yytype25 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_278 is
			--|#line 1469 "eiffel.y"
		local
			yyval54: REVERSE_AS
		do
--|#line 1469 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1469")
end


yyval54 := new_reverse_as (new_access_id_as (yytype33 (yyvs.item (yyvsp - 2)), Void), yytype25 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval54
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_279 is
			--|#line 1471 "eiffel.y"
		local
			yyval54: REVERSE_AS
		do
--|#line 1471 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1471")
end


yyval54 := new_reverse_as (new_result_as, yytype25 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval54
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_280 is
			--|#line 1475 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1475 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1475")
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

	yy_do_action_281 is
			--|#line 1477 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1477 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1477")
end


yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_282 is
			--|#line 1481 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1481 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1481")
end


				yyval69 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval69.extend (yytype18 (yyvs.item (yyvsp)))
			
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_283 is
			--|#line 1486 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1486 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1486")
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

	yy_do_action_284 is
			--|#line 1493 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1493 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1493")
end


				inherit_context := False
				yyval18 := new_create_as (Void, Void)
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_285 is
			--|#line 1499 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1499 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1499")
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

	yy_do_action_286 is
			--|#line 1504 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1504 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1504")
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

	yy_do_action_287 is
			--|#line 1509 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1509 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1509")
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

	yy_do_action_288 is
			--|#line 1519 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1519 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1519")
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

	yy_do_action_289 is
			--|#line 1529 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1529 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1529")
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

	yy_do_action_290 is
			--|#line 1541 "eiffel.y"
		local
			yyval57: ROUTINE_CREATION_AS
		do
--|#line 1541 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1541")
end


yyval57 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), False) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_291 is
			--|#line 1543 "eiffel.y"
		local
			yyval57: ROUTINE_CREATION_AS
		do
--|#line 1543 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1543")
end


yyval57 := new_routine_creation_as (yytype46 (yyvs.item (yyvsp - 3)), yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), True) 
			yyval := yyval57
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_292 is
			--|#line 1545 "eiffel.y"
		local
			yyval57: ROUTINE_CREATION_AS
		do
--|#line 1545 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1545")
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

	yy_do_action_293 is
			--|#line 1563 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1563 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1563")
end


yyval59 := new_old_routine_creation_as (yytype58 (yyvs.item (yyvsp - 2)), new_operand_as (Void, Void, Void), yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), False) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_294 is
			--|#line 1565 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1565 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1565")
end


yyval59 := new_old_routine_creation_as (yytype58 (yyvs.item (yyvsp - 2)), new_operand_as (Void, yytype33 (yyvs.item (yyvsp - 4)), Void), yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), True) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_295 is
			--|#line 1567 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1567 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1567")
end


yyval59 := new_old_routine_creation_as (yytype58 (yyvs.item (yyvsp - 2)), new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp - 5))), yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), True) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_296 is
			--|#line 1569 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1569 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1569")
end


yyval59 := new_old_routine_creation_as (yytype58 (yyvs.item (yyvsp - 2)), new_result_operand_as, yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), True) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_297 is
			--|#line 1571 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1571 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1571")
end


yyval59 := new_old_routine_creation_as (yytype58 (yyvs.item (yyvsp - 2)), new_operand_as (Void, Void, Void), yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), True) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_298 is
			--|#line 1573 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1573 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1573")
end


yyval59 := new_old_routine_creation_as (yytype58 (yyvs.item (yyvsp - 2)), new_operand_as (yytype63 (yyvs.item (yyvsp - 4)), Void, Void), yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), True) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_299 is
			--|#line 1575 "eiffel.y"
		local
			yyval59: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1575 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1575")
end


yyval59 := new_old_routine_creation_as (yytype58 (yyvs.item (yyvsp - 2)), Void, yytype33 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp)), True) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_300 is
			--|#line 1579 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1579 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1579")
end


yyval46 := new_operand_as (Void, yytype33 (yyvs.item (yyvsp)), Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_301 is
			--|#line 1581 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1581 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1581")
end


yyval46 := new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_302 is
			--|#line 1583 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1583 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1583")
end


yyval46 := new_result_operand_as 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_303 is
			--|#line 1585 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1585 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1585")
end


yyval46 := new_operand_as (Void, Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_304 is
			--|#line 1587 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1587 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1587")
end


yyval46 := new_operand_as (yytype63 (yyvs.item (yyvsp - 1)), Void, Void)
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_305 is
			--|#line 1589 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1589 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1589")
end


yyval46 := Void 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_306 is
			--|#line 1593 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1593 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1593")
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

	yy_do_action_307 is
			--|#line 1595 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1595 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1595")
end



			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_308 is
			--|#line 1597 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1597 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1597")
end


yyval84 := yytype84 (yyvs.item (yyvsp - 1)) 
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_309 is
			--|#line 1601 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1601 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1601")
end


				yyval84 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval84.extend (yytype46 (yyvs.item (yyvsp)))
			
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_310 is
			--|#line 1606 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1606 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1606")
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

	yy_do_action_311 is
			--|#line 1613 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1613 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1613")
end


yyval46 := new_operand_as (Void, Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_312 is
			--|#line 1619 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1619 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1619")
end


yyval46 := new_operand_as (new_class_type (yytype92 (yyvs.item (yyvsp - 1)), Void, False, False), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_313 is
			--|#line 1621 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1621 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1621")
end


yyval46 := new_operand_as (new_class_type (yytype92 (yyvs.item (yyvsp - 2)), yytype89 (yyvs.item (yyvsp - 1)), False, False), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_314 is
			--|#line 1623 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1623 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1623")
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

	yy_do_action_315 is
			--|#line 1632 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1632 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1632")
end


yyval46 := new_operand_as (new_class_type (yytype92 (yyvs.item (yyvsp - 2)), yytype89 (yyvs.item (yyvsp - 1)), False, True), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_316 is
			--|#line 1634 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1634 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1634")
end


yyval46 := new_operand_as (new_bits_as (yytype39 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_317 is
			--|#line 1636 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1636 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1636")
end


yyval46 := new_operand_as (new_bits_symbol_as (yytype33 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_318 is
			--|#line 1638 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1638 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1638")
end


yyval46 := new_operand_as (new_like_id_as (yytype33 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_319 is
			--|#line 1640 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1640 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1640")
end


yyval46 := new_operand_as (new_like_current_as, Void, Void) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_320 is
			--|#line 1642 "eiffel.y"
		local
			yyval46: OPERAND_AS
		do
--|#line 1642 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1642")
end


yyval46 := new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval46
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_321 is
			--|#line 1646 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1646 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1646")
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

	yy_do_action_322 is
			--|#line 1655 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1655 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1655")
end


yyval19 := new_creation_as (Void, yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 3))) 
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_323 is
			--|#line 1657 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1657 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1657")
end


yyval19 := new_creation_as (yytype63 (yyvs.item (yyvsp - 3)), yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 6))) 
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_324 is
			--|#line 1661 "eiffel.y"
		local
			yyval20: CREATION_EXPR_AS
		do
--|#line 1661 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1661")
end


yyval20 := new_creation_expr_as (yytype63 (yyvs.item (yyvsp - 3)), yytype4 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval20
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_325 is
			--|#line 1663 "eiffel.y"
		local
			yyval20: CREATION_EXPR_AS
		do
--|#line 1663 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1663")
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

	yy_do_action_326 is
			--|#line 1674 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1674 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1674")
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

	yy_do_action_327 is
			--|#line 1676 "eiffel.y"
		local
			yyval63: TYPE_AS
		do
--|#line 1676 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1676")
end


yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_328 is
			--|#line 1680 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1680 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1680")
end


yyval2 := new_access_id_as (yytype33 (yyvs.item (yyvsp)), Void) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_329 is
			--|#line 1682 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1682 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1682")
end


yyval2 := new_result_as 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_330 is
			--|#line 1686 "eiffel.y"
		local
			yyval4: ACCESS_INV_AS
		do
--|#line 1686 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1686")
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

	yy_do_action_331 is
			--|#line 1688 "eiffel.y"
		local
			yyval4: ACCESS_INV_AS
		do
--|#line 1688 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1688")
end


yyval4 := new_access_inv_as (yytype33 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_332 is
			--|#line 1696 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1696 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1696")
end


yyval37 := new_instr_call_as (yytype2 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_333 is
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

	yy_do_action_334 is
			--|#line 1700 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1700 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1700")
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
			--|#line 1702 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1702 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1702")
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
			--|#line 1704 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1704 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1704")
end


yyval37 := new_instr_call_as (yytype45 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_337 is
			--|#line 1706 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1706 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1706")
end


yyval37 := new_instr_call_as (yytype48 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_338 is
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

	yy_do_action_339 is
			--|#line 1710 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1710 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1710")
end


yyval37 := new_instr_call_as (yytype49 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_340 is
			--|#line 1712 "eiffel.y"
		local
			yyval37: INSTR_CALL_AS
		do
--|#line 1712 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1712")
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
			--|#line 1716 "eiffel.y"
		local
			yyval14: CHECK_AS
		do
--|#line 1716 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1716")
end


yyval14 := new_check_as (yytype88 (yyvs.item (yyvsp - 1)), yytype58 (yyvs.item (yyvsp - 3)), current_position) 
			yyval := yyval14
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_342 is
			--|#line 1724 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1724 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1724")
end


create {VALUE_AS} yyval25.initialize (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_343 is
			--|#line 1726 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1726 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1726")
end


create {VOID_AS} yyval25 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_344 is
			--|#line 1728 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1728 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1728")
end


create {VALUE_AS} yyval25.initialize (yytype5 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_345 is
			--|#line 1730 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1730 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1730")
end


create {VALUE_AS} yyval25.initialize (yytype62 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_346 is
			--|#line 1732 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1732 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1732")
end


yyval25 := new_expr_call_as (yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_347 is
			--|#line 1734 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1734 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1734")
end


yyval25 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_348 is
			--|#line 1736 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1736 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1736")
end


yyval25 := new_paran_as (yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_349 is
			--|#line 1738 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1738 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1738")
end


yyval25 := new_bin_plus_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_350 is
			--|#line 1740 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1740 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1740")
end


yyval25 := new_bin_minus_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_351 is
			--|#line 1742 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1742 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1742")
end


yyval25 := new_bin_star_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_352 is
			--|#line 1744 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1744 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1744")
end


yyval25 := new_bin_slash_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_353 is
			--|#line 1746 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1746 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1746")
end


yyval25 := new_bin_mod_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_354 is
			--|#line 1748 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1748 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1748")
end


yyval25 := new_bin_div_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_355 is
			--|#line 1750 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1750 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1750")
end


yyval25 := new_bin_power_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_356 is
			--|#line 1752 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1752 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1752")
end


yyval25 := new_bin_and_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_357 is
			--|#line 1754 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1754 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1754")
end


yyval25 := new_bin_and_then_as (yytype25 (yyvs.item (yyvsp - 3)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_358 is
			--|#line 1756 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1756 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1756")
end


yyval25 := new_bin_or_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_359 is
			--|#line 1758 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1758 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1758")
end


yyval25 := new_bin_or_else_as (yytype25 (yyvs.item (yyvsp - 3)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_360 is
			--|#line 1760 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1760 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1760")
end


yyval25 := new_bin_implies_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_361 is
			--|#line 1762 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1762 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1762")
end


yyval25 := new_bin_xor_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_362 is
			--|#line 1764 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1764 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1764")
end


yyval25 := new_bin_ge_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_363 is
			--|#line 1766 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1766 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1766")
end


yyval25 := new_bin_gt_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_364 is
			--|#line 1768 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1768 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1768")
end


yyval25 := new_bin_le_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_365 is
			--|#line 1770 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1770 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1770")
end


yyval25 := new_bin_lt_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_366 is
			--|#line 1772 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1772 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1772")
end


yyval25 := new_bin_eq_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_367 is
			--|#line 1774 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1774 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1774")
end


yyval25 := new_bin_ne_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_368 is
			--|#line 1776 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1776 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1776")
end


yyval25 := new_bin_free_as (yytype25 (yyvs.item (yyvsp - 2)), yytype33 (yyvs.item (yyvsp - 1)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_369 is
			--|#line 1778 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1778 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1778")
end


yyval25 := new_un_minus_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_370 is
			--|#line 1780 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1780 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1780")
end


yyval25 := new_un_plus_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_371 is
			--|#line 1782 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1782 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1782")
end


yyval25 := new_un_not_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_372 is
			--|#line 1784 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1784 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1784")
end


yyval25 := new_un_old_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_373 is
			--|#line 1786 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1786 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1786")
end


yyval25 := new_un_free_as (yytype33 (yyvs.item (yyvsp - 1)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_374 is
			--|#line 1788 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1788 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1788")
end


yyval25 := new_un_strip_as (yytype80 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_375 is
			--|#line 1790 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1790 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1790")
end


yyval25 := new_address_as (yytype93 (yyvs.item (yyvsp)).first) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_376 is
			--|#line 1792 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1792 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1792")
end


yyval25 := new_expr_address_as (yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_377 is
			--|#line 1794 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1794 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1794")
end


yyval25 := new_address_current_as 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_378 is
			--|#line 1796 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1796 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1796")
end


yyval25 := new_address_result_as 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_379 is
			--|#line 1800 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1800 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1800")
end


create yyval33.initialize (token_buffer) 
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_380 is
			--|#line 1808 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1808 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1808")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_381 is
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

	yy_do_action_382 is
			--|#line 1812 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1812 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1812")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_383 is
			--|#line 1814 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1814 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1814")
end


yyval11 := new_current_as 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_384 is
			--|#line 1816 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1816 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1816")
end


yyval11 := new_result_as 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_385 is
			--|#line 1818 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1818 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1818")
end


yyval11 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_386 is
			--|#line 1820 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1820 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1820")
end


yyval11 := yytype45 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_387 is
			--|#line 1822 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1822 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1822")
end


yyval11 := yytype48 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_388 is
			--|#line 1824 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1824 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1824")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_389 is
			--|#line 1826 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1826 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1826")
end


yyval11 := yytype49 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_390 is
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

	yy_do_action_391 is
			--|#line 1830 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1830 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1830")
end


yyval11 := yytype20 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_392 is
			--|#line 1834 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1834 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1834")
end


yyval44 := new_nested_as (new_current_as, yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_393 is
			--|#line 1838 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1838 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1838")
end


yyval44 := new_nested_as (new_result_as, yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_394 is
			--|#line 1842 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1842 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1842")
end


yyval44 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_395 is
			--|#line 1846 "eiffel.y"
		local
			yyval45: NESTED_EXPR_AS
		do
--|#line 1846 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1846")
end


yyval45 := new_nested_expr_as (yytype25 (yyvs.item (yyvsp - 3)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_396 is
			--|#line 1850 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1850 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1850")
end


yyval44 := new_nested_as (yytype48 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_397 is
			--|#line 1854 "eiffel.y"
		local
			yyval48: PRECURSOR_AS
		do
--|#line 1854 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1854")
end


yyval48 := new_precursor_as (Void, yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_398 is
			--|#line 1856 "eiffel.y"
		local
			yyval48: PRECURSOR_AS
		do
--|#line 1856 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1856")
end


yyval48 := new_precursor (yytype92 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp)), Void) 
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_399 is
			--|#line 1858 "eiffel.y"
		local
			yyval48: PRECURSOR_AS
		do
--|#line 1858 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1858")
end


yyval48 := new_precursor (yytype92 (yyvs.item (yyvsp - 5)), yytype72 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 2))) 
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_400 is
			--|#line 1860 "eiffel.y"
		local
			yyval48: PRECURSOR_AS
		do
--|#line 1860 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1860")
end


yyval48 := new_precursor (yytype92 (yyvs.item (yyvsp - 4)), yytype72 (yyvs.item (yyvsp)), yytype58 (yyvs.item (yyvsp - 2))) 
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_401 is
			--|#line 1864 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1864 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1864")
end


yyval44 := new_nested_as (yytype49 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_402 is
			--|#line 1868 "eiffel.y"
		local
			yyval49: STATIC_ACCESS_AS
		do
--|#line 1868 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1868")
end


				yyval49 := new_static_access_as (yytype63 (yyvs.item (yyvsp - 4)), yytype33 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp)));
			
			yyval := yyval49
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_403 is
			--|#line 1875 "eiffel.y"
		local
			yyval49: STATIC_ACCESS_AS
		do
--|#line 1875 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1875")
end


				yyval49 := new_static_access_as (yytype63 (yyvs.item (yyvsp - 3)), yytype33 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval49
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_404 is
			--|#line 1883 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1883 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1883")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_405 is
			--|#line 1885 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1885 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1885")
end


yyval11 := yytype3 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_406 is
			--|#line 1889 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1889 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1889")
end


yyval44 := new_nested_as (yytype3 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_407 is
			--|#line 1891 "eiffel.y"
		local
			yyval44: NESTED_AS
		do
--|#line 1891 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1891")
end


yyval44 := new_nested_as (yytype3 (yyvs.item (yyvsp - 2)), yytype44 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_408 is
			--|#line 1895 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1895 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1895")
end


yyval33 := yytype33 (yyvs.item (yyvsp))
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_409 is
			--|#line 1897 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1897 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1897")
end


yyval33 := yytype93 (yyvs.item (yyvsp)).first.internal_name 
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_410 is
			--|#line 1899 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1899 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1899")
end


yyval33 := yytype93 (yyvs.item (yyvsp)).first.internal_name 
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_411 is
			--|#line 1903 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1903 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1903")
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

	yy_do_action_412 is
			--|#line 1916 "eiffel.y"
		local
			yyval3: ACCESS_FEAT_AS
		do
--|#line 1916 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1916")
end


yyval3 := new_access_feat_as (yytype33 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval3
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_413 is
			--|#line 1920 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1920 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1920")
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

	yy_do_action_414 is
			--|#line 1922 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1922 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1922")
end



			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_415 is
			--|#line 1924 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1924 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1924")
end


yyval72 := yytype72 (yyvs.item (yyvsp - 1)) 
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_416 is
			--|#line 1928 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1928 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1928")
end


				yyval72 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval72.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_417 is
			--|#line 1933 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1933 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1933")
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

	yy_do_action_418 is
			--|#line 1940 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1940 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1940")
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

	yy_do_action_419 is
			--|#line 1942 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1942 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1942")
end


yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
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


				yyval72 := new_eiffel_list_expr_as (Initial_expression_list_size)
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
			--|#line 1962 "eiffel.y"
		local
			yyval33: ID_AS
		do
--|#line 1962 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1962")
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

	yy_do_action_423 is
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

	yy_do_action_424 is
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

	yy_do_action_425 is
			--|#line 1975 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1975 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1975")
end


yyval7 := yytype39 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_426 is
			--|#line 1977 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1977 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1977")
end


yyval7 := yytype50 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_427 is
			--|#line 1979 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1979 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1979")
end


yyval7 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_428 is
			--|#line 1981 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1981 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1981")
end


yyval7 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_429 is
			--|#line 1985 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1985 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1985")
end


yyval7 := yytype10 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_430 is
			--|#line 1987 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1987 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1987")
end


yyval7 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_431 is
			--|#line 1989 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1989 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1989")
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

	yy_do_action_432 is
			--|#line 2004 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 2004 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2004")
end


yyval7 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_433 is
			--|#line 2006 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 2006 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2006")
end


yyval7 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_434 is
			--|#line 2008 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 2008 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2008")
end


yyval7 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_435 is
			--|#line 2010 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 2010 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2010")
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

	yy_do_action_436 is
			--|#line 2018 "eiffel.y"
		local
			yyval10: BOOL_AS
		do
--|#line 2018 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2018")
end


yyval10 := new_boolean_as (False) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_437 is
			--|#line 2020 "eiffel.y"
		local
			yyval10: BOOL_AS
		do
--|#line 2020 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2020")
end


yyval10 := new_boolean_as (True) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_438 is
			--|#line 2024 "eiffel.y"
		local
			yyval13: CHAR_AS
		do
--|#line 2024 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2024")
end


				check is_character: not token_buffer.is_empty end
				yyval13 := new_character_as (token_buffer.item (1))
			
			yyval := yyval13
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_439 is
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
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_440 is
			--|#line 2046 "eiffel.y"
		local
			yyval39: INTEGER_CONSTANT
		do
--|#line 2046 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2046")
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

	yy_do_action_441 is
			--|#line 2061 "eiffel.y"
		local
			yyval39: INTEGER_CONSTANT
		do
--|#line 2061 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2061")
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

	yy_do_action_442 is
			--|#line 2079 "eiffel.y"
		local
			yyval50: REAL_AS
		do
--|#line 2079 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2079")
end


yyval50 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval50
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_443 is
			--|#line 2081 "eiffel.y"
		local
			yyval50: REAL_AS
		do
--|#line 2081 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2081")
end


yyval50 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval50
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_444 is
			--|#line 2083 "eiffel.y"
		local
			yyval50: REAL_AS
		do
--|#line 2083 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2083")
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

	yy_do_action_445 is
			--|#line 2090 "eiffel.y"
		local
			yyval8: BIT_CONST_AS
		do
--|#line 2090 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2090")
end


yyval8 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval8
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_446 is
			--|#line 2094 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2094 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2094")
end


yyval60 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_447 is
			--|#line 2096 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2096 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2096")
end


yyval60 := new_empty_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_448 is
			--|#line 2098 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2098 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2098")
end


yyval60 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_449 is
			--|#line 2102 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2102 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2102")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_450 is
			--|#line 2104 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2104 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2104")
end


yyval60 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_451 is
			--|#line 2106 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2106 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2106")
end


yyval60 := new_lt_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_452 is
			--|#line 2108 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2108 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2108")
end


yyval60 := new_le_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_453 is
			--|#line 2110 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2110 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2110")
end


yyval60 := new_gt_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_454 is
			--|#line 2112 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2112 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2112")
end


yyval60 := new_ge_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_455 is
			--|#line 2114 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2114 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2114")
end


yyval60 := new_minus_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_456 is
			--|#line 2116 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2116 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2116")
end


yyval60 := new_plus_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_457 is
			--|#line 2118 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2118 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2118")
end


yyval60 := new_star_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_458 is
			--|#line 2120 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2120 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2120")
end


yyval60 := new_slash_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_459 is
			--|#line 2122 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2122 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2122")
end


yyval60 := new_mod_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_460 is
			--|#line 2124 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2124 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2124")
end


yyval60 := new_div_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_461 is
			--|#line 2126 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2126 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2126")
end


yyval60 := new_power_string_as 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_462 is
			--|#line 2128 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2128 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2128")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_463 is
			--|#line 2130 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2130 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2130")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_464 is
			--|#line 2132 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2132 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2132")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_465 is
			--|#line 2134 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2134 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2134")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_466 is
			--|#line 2136 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2136 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2136")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_467 is
			--|#line 2138 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2138 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2138")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_468 is
			--|#line 2140 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2140 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2140")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_469 is
			--|#line 2142 "eiffel.y"
		local
			yyval60: STRING_AS
		do
--|#line 2142 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2142")
end


yyval60 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_470 is
			--|#line 2146 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2146 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2146")
end


yyval94 := new_clickable_string (new_minus_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_471 is
			--|#line 2148 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2148 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2148")
end


yyval94 := new_clickable_string (new_plus_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_472 is
			--|#line 2150 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2150 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2150")
end


yyval94 := new_clickable_string (new_not_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_473 is
			--|#line 2152 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2152 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2152")
end


yyval94 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_474 is
			--|#line 2156 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2156 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2156")
end


yyval94 := new_clickable_string (new_lt_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_475 is
			--|#line 2158 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2158 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2158")
end


yyval94 := new_clickable_string (new_le_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_476 is
			--|#line 2160 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2160 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2160")
end


yyval94 := new_clickable_string (new_gt_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_477 is
			--|#line 2162 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2162 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2162")
end


yyval94 := new_clickable_string (new_ge_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_478 is
			--|#line 2164 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2164 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2164")
end


yyval94 := new_clickable_string (new_minus_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_479 is
			--|#line 2166 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2166 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2166")
end


yyval94 := new_clickable_string (new_plus_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_480 is
			--|#line 2168 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2168 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2168")
end


yyval94 := new_clickable_string (new_star_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_481 is
			--|#line 2170 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2170 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2170")
end


yyval94 := new_clickable_string (new_slash_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_482 is
			--|#line 2172 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2172 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2172")
end


yyval94 := new_clickable_string (new_mod_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_483 is
			--|#line 2174 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2174 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2174")
end


yyval94 := new_clickable_string (new_div_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_484 is
			--|#line 2176 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2176 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2176")
end


yyval94 := new_clickable_string (new_power_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_485 is
			--|#line 2178 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2178 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2178")
end


yyval94 := new_clickable_string (new_and_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_486 is
			--|#line 2180 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2180 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2180")
end


yyval94 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_487 is
			--|#line 2182 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2182 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2182")
end


yyval94 := new_clickable_string (new_implies_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_488 is
			--|#line 2184 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2184 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2184")
end


yyval94 := new_clickable_string (new_or_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_489 is
			--|#line 2186 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2186 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2186")
end


yyval94 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_490 is
			--|#line 2188 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2188 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2188")
end


yyval94 := new_clickable_string (new_xor_string_as) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_491 is
			--|#line 2190 "eiffel.y"
		local
			yyval94: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2190 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2190")
end


yyval94 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_492 is
			--|#line 2194 "eiffel.y"
		local
			yyval5: ARRAY_AS
		do
--|#line 2194 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2194")
end


yyval5 := new_array_as (yytype72 (yyvs.item (yyvsp - 1))) 
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_493 is
			--|#line 2198 "eiffel.y"
		local
			yyval62: TUPLE_AS
		do
--|#line 2198 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2198")
end


yyval62 := new_tuple_as (yytype72 (yyvs.item (yyvsp - 1))) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_494 is
			--|#line 2202 "eiffel.y"
		do
--|#line 2202 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2202")
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

	yy_do_action_495 is
			--|#line 2206 "eiffel.y"
		local
			yyval58: TOKEN_LOCATION
		do
--|#line 2206 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2206")
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
			when 809 then
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
			  210,  212,  212,  216,  216,  216,  216,  216,  216,  214,

			  276,  276,  276,  275,  275,  277,  277,  247,  247,  248,
			  248,  249,  249,  165,  165,  165,  166,  312,  293,  293,
			  246,  246,  171,  227,  227,  228,  228,  156,  261,  261,
			  173,  221,  221,  222,  222,  144,  263,  263,  179,  179,
			  179,  179,  179,  179,  179,  179,  179,  179,  179,  179,
			  179,  179,  179,  179,  179,  179,  262,  262,  181,  274,
			  274,  180,  180,  313,  219,  219,  219,  155,  270,  270,
			  270,  271,  271,  199,  258,  258,  135,  135,  200,  200,
			  225,  225,  226,  226,  152,  152,  152,  152,  152,  152,
			  203,  203,  203,  204,  204,  204,  204,  204,  204,  204,

			  190,  190,  190,  190,  190,  190,  264,  264,  264,  265,
			  265,  189,  189,  189,  189,  189,  189,  189,  189,  189,
			  189,  153,  153,  153,  154,  154,  215,  215,  130,  130,
			  133,  133,  174,  174,  174,  174,  174,  174,  174,  174,
			  174,  146,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  169,
			  143,  143,  143,  143,  143,  143,  143,  143,  143,  143,
			  143,  143,  186,  185,  184,  188,  183,  193,  193,  193,

			  193,  187,  194,  195,  142,  142,  182,  182,  170,  170,
			  170,  131,  132,  232,  232,  232,  233,  233,  234,  234,
			  235,  235,  167,  137,  137,  137,  137,  137,  137,  138,
			  138,  138,  138,  138,  138,  138,  141,  141,  145,  177,
			  177,  177,  196,  196,  196,  139,  206,  206,  206,  208,
			  208,  208,  208,  208,  208,  208,  208,  208,  208,  208,
			  208,  208,  208,  208,  208,  208,  208,  208,  208,  208,
			  291,  291,  291,  291,  290,  290,  290,  290,  290,  290,
			  290,  290,  290,  290,  290,  290,  290,  290,  290,  290,
			  290,  290,  134,  211,  307,  294>>)
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
			    1,    1,    1,    1,   63,   63,   63,   92,   58,    1,

			    1,    1,    1,   35,   33,   33,    1,    1,    1,    1,
			    1,    1,    1,   94,    1,    1,    1,    1,    1,   33,
			   33,   46,    1,    1,   72,   60,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,   94,    1,    1,    1,    1,    1,
			    1,    1,   92,   93,   93,   93,   25,   72,   72,    1,
			   63,   92,   72,    1,   58,   63,   25,   25,    1,   25,
			   25,   25,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			   33,    1,   25,   72,    1,    1,   92,    1,   33,    1,

			    1,    1,   33,   39,    1,   89,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    7,    7,
			    8,   10,   13,   20,   33,   39,   50,   60,   66,   58,
			   58,    3,   11,   33,   33,   44,   63,   25,    1,   84,
			    1,   92,    1,   25,   72,   63,   58,   11,   25,    1,
			    1,   92,    1,    1,    1,   63,   33,    1,    1,   33,
			   80,   80,   11,   25,   25,   25,   25,   25,   25,   25,
			   25,   25,   25,   25,   25,   25,    1,   25,   25,    1,
			   25,   25,   25,   58,   11,   11,   89,    1,    1,    1,
			   63,   89,   92,   92,    1,    1,    1,    1,    1,   62,

			    1,    1,    1,   33,   33,    1,   72,    1,    1,    1,
			    1,    1,   25,   46,   84,   58,   33,    1,    1,    1,
			    1,   33,    1,   25,    1,   58,   58,    1,   84,   58,
			    1,    1,    1,    1,   25,   25,   33,    1,    1,   89,
			   77,   58,    1,    7,   84,   84,    3,   44,    1,    1,
			    1,   92,    1,    1,    1,   84,   72,   25,    1,   84,
			    1,   33,    1,   58,    1,    4,   58,   11,   33,   84,
			   63,    1,   60,    1,   92,    1,   33,   33,   39,    1,
			    1,   89,   46,    1,   33,   58,   84,   72,    4,   33,
			   33,   60,    1,   60,    1,    1,    1,   31,   32,   77,

			   77,   89,    1,    1,    1,    1,    1,   89,    1,   92,
			   72,    1,   72,   84,   60,    1,   85,    1,    1,    1,
			    1,    1,    1,    1,   89,   72,   47,   85,   58,    1,
			   58,    1,   96,   32,    1,   47,   47,   92,    1,   18,
			   69,   69,   58,   63,    1,   89,    1,   15,   78,    1,
			   68,   18,    1,    1,   76,    1,    1,    1,    1,    1,
			    1,   71,   76,   76,   76,   86,    1,   78,   92,   76,
			   93,   17,   68,   93,    1,   15,   29,   74,   74,   15,
			   78,   76,   76,   76,   51,   86,   93,   76,   24,   71,
			   78,    1,   76,   76,   76,   76,   76,   76,    1,   71,

			   71,    1,    1,    1,    1,    1,    1,    1,    1,   28,
			   73,   93,   95,    1,   58,   29,   76,    1,    1,    1,
			   24,    1,   30,   76,   76,   76,    1,   76,   92,   93,
			   17,    1,    1,   15,   78,   28,    1,    1,    9,   90,
			   93,    1,   42,   51,   93,    1,   76,    1,   76,   89,
			   89,   93,   64,   80,   90,   90,    1,    1,   63,    1,
			   58,    1,   76,    1,    1,   58,    1,   64,    1,   63,
			    1,    1,   16,   81,   61,   88,   88,    1,   81,    1,
			    1,    1,    1,    1,    7,   16,   81,    1,   81,   61,
			   61,   58,    1,    1,    1,    1,   81,   81,   81,   56,

			   60,    1,    1,   25,   33,   33,   63,    1,    1,    1,
			    1,    1,   52,   25,    1,    1,    1,   90,    1,   88,
			   64,   80,   90,   90,    1,    1,    1,    1,   26,   40,
			   55,   88,   58,   64,   82,    1,   27,   58,   82,    1,
			   23,    1,   38,   82,    1,   60,   60,    1,    1,    1,
			   82,   63,   38,    1,    1,    1,    6,   14,   19,   21,
			   34,   36,   37,   38,   43,   53,   54,   58,    1,   88,
			   82,    1,    1,   58,   82,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    2,   33,   44,   44,   44,
			   44,   44,   45,   48,   49,   88,   25,    1,   88,    1,

			    1,   25,    1,   87,   88,   92,    1,    1,    2,   33,
			   63,   63,   25,    1,    1,    1,   12,   67,   67,   88,
			    1,   65,   25,   25,    1,    1,   60,   87,   82,    1,
			   63,    4,    1,    1,   25,   25,   58,    1,   82,   12,
			   25,   33,    1,   82,    1,    1,    1,    1,    2,    1,
			   13,   33,   39,   41,   49,   83,   82,    1,    1,   58,
			   22,   70,   70,   58,   60,    2,    4,    1,    1,    1,
			    1,    1,    1,    1,   25,   25,    1,   82,   22,    1,
			    4,   63,   13,   33,   49,   13,   33,   39,   49,   33,
			   39,   49,   13,   33,   39,   49,   82,   41,    1,   82,

			    1,   25,    1,   82,    1,    1,    1,   82,   33,    1,
			    1,    1>>)
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
			    8,  495,    0,  422,  495,   33,    1,   17,  495,   21,
			  469,  468,  467,  466,  465,  464,  463,  462,  461,  460,
			  459,  458,  457,  456,  455,  454,  453,  452,  451,  343,
			  448,  450,  447,    0,  384,    0,    0,  413,    0,    0,
			    0,  383,    0,  437,  436,  418,  495,  418,    0,  495,
			  495,  445,  449,  432,  438,  431,    0,    0,    0,    0,
			  379,    0,    0,  385,  344,  342,  433,  429,  346,  430,
			  391,    3,  408,    0,  413,  388,  382,  381,  380,  390,
			  386,  387,  389,  347,  292,  434,  446,  345,  409,  410,
			    0,    0,    0,    7,    2,  191,  192,  200,    0,   34,

			   35,    0,   35,   18,    0,    0,  495,  495,    0,  473,
			  472,  471,  470,   67,  305,  302,  303,  495,    0,  408,
			  306,    0,    0,    0,  397,  435,  491,  490,  489,  488,
			  487,  486,  485,  484,  483,  482,  481,  480,  479,  478,
			  477,  476,  475,  474,   66,    0,  495,    0,  378,  377,
			    6,    0,   63,   64,   65,  375,  420,    0,  419,    0,
			    0,  200,    0,  495,    0,    0,    0,  372,  139,  371,
			  369,  370,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  495,  373,  411,    0,    0,  200,  198,  197,  439,

			    0,    0,  196,  195,  495,  199,    0,   36,   30,    0,
			   35,   35,   29,   20,   24,  442,    0,    0,   22,   26,
			  427,  423,  424,    0,   25,  425,  426,  428,   55,    0,
			    0,  405,  393,  408,  413,  404,    0,    0,    0,  290,
			    0,    0,  414,  416,    0,    0,    0,  392,    0,  493,
			    0,    0,  495,  495,  492,    0,  306,  495,  348,  137,
			  140,    0,  394,  355,  354,  353,  352,  351,  350,  349,
			  362,  364,  363,  365,  366,  367,    0,  356,  361,    0,
			  358,  360,  368,    0,  396,  401,  194,  441,  440,  201,
			  205,    0,  200,  495,   32,   31,  444,  443,   27,    0,

			    0,   56,   19,  306,  306,    0,  412,  304,  301,  311,
			  495,  307,  320,  309,    0,    0,  306,  413,  415,    0,
			    0,  306,  376,  421,    0,    0,    0,  495,  293,  330,
			  495,    0,    0,  374,  357,  359,  306,  202,  495,  193,
			  150,    0,   28,   23,  299,  296,  406,  407,    0,    0,
			    0,  200,  308,    0,    0,  291,  398,  417,    0,  297,
			  495,  306,  413,  330,    0,  325,    0,  395,  138,  294,
			  206,    0,   37,  209,  200,  198,  197,  196,  195,  495,
			  495,    0,  310,    0,  413,    0,  298,  400,  324,  413,
			  306,  151,    0,   74,    0,    0,  215,  217,  211,    0,

			  210,  194,  319,  318,  317,  316,  203,    0,  313,  200,
			  402,  413,  331,  295,   38,  495,  495,  213,  214,  218,
			  208,    0,  315,  204,    0,  399,   77,  495,    0,   76,
			  495,    0,  216,  212,  314,   78,   79,  200,  284,  282,
			  103,  495,    0,  220,   80,   81,    0,    0,  286,    0,
			   39,  283,  287,    0,  219,  113,  121,   88,  117,   55,
			   87,  111,  115,  119,    0,   93,   49,    0,   51,  285,
			  109,  105,  104,    0,   46,   61,   41,  495,   40,    0,
			  289,    0,  114,  122,   90,   89,    0,  118,   97,   95,
			  100,   96,  112,  115,  116,  119,  120,    0,   86,   94,

			  111,   50,    0,    0,    0,    0,    0,   47,   62,   53,
			   61,   58,  123,    0,  261,   42,  288,  221,    0,    0,
			   98,  101,   55,  102,  119,    0,   85,  115,   52,  110,
			  106,  495,  495,   45,   48,   54,   61,  125,  161,  141,
			   60,  263,  495,   91,   92,   99,    0,   84,  119,    0,
			    0,   59,  127,  495,    0,  126,   57,  495,   14,  494,
			    8,   83,    0,  108,    0,    0,  124,  128,  162,  142,
			   11,  495,   68,   69,  185,  262,  494,  495,    0,   82,
			  107,  130,   14,  495,   14,   70,   37,   16,  495,  186,
			   55,    0,    5,    4,    0,  495,   72,  495,   71,   73,

			  144,   15,  187,  188,  408,    0,   55,  173,  190,  131,
			  129,  175,  154,  189,  177,  494,  132,    0,  494,  174,
			  134,  495,  155,  133,  161,  495,  161,  147,  146,  145,
			  178,  176,    0,  135,  153,  494,  150,    0,  152,  180,
			  274,  495,  158,  494,  495,  148,  149,  182,  494,  161,
			    0,   55,  159,  273,  495,  161,  165,  171,  163,  170,
			  167,  168,  164,  161,  169,  172,  166,    0,  494,  179,
			  275,  143,  136,    0,  259,  160,    0,    0,  268,    0,
			  494,    0,    0,  495,    0,  332,  408,  338,  334,  333,
			  335,  340,  336,  337,  339,  181,  231,  494,  264,    0,

			    0,    0,    0,  161,    0,    0,  329,  495,  330,  328,
			  327,    0,    0,    0,    0,  495,  233,  256,  232,  260,
			    0,    0,  277,  279,  161,  269,  271,    0,    0,  341,
			    0,  322,    0,    0,  276,  278,    0,  161,    0,  234,
			  266,  408,  495,  495,  270,    0,  267,    0,  330,    0,
			  240,  242,  238,  236,  248,    0,  257,  230,    0,    0,
			  225,  228,  495,    0,  272,  330,  321,    0,    0,    0,
			    0,    0,  161,    0,  265,    0,  161,    0,  226,    0,
			  323,    0,  241,  247,  255,  246,  243,  244,  250,  245,
			  239,  253,  254,  249,  252,  251,  235,  237,  161,  229,

			  222,    0,    0,    0,  161,    0,  258,  227,  403,    0,
			    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  708,   63,  231,  365,   64,  656,  218,  219,   65,   66,
			  538,   67,  232,   68,  716,   69,  657,  447,  475,  572,
			  585,  471,  439,  658,   70,  659,  760,  640,  488,  156,
			  628,  636,  509,  476,  522,  397,  398,   72,  105,   73,
			   74,  660,    7,  661,  662,  642,  663,  225,  629,  753,
			  542,  664,  235,   75,   76,   77,   78,   79,   80,  313,
			  121,  426,  436,   81,   82,  754,  226,  484,  612,  665,
			  666,  630,  599,   83,   84,  393,   85,  372,   86,  574,
			  590,   87,  290,  558,   95,  711,   96,  552,  620,  721,
			  228,  717,  718,  472,  450,  440,  441,  761,  762,  461,

			  500,  489,  124,  244,  157,  158,  510,  477,  478,  469,
			  492,  493,  494,  495,  496,  497,  454,  340,  399,  400,
			  490,  467,  553,  261,    5,    8,  586,  573,  650,  634,
			  643,  777,  738,  755,  239,  314,  416,  427,  465,  485,
			  703,  727,  575,  576,  698,  381,  205,  291,  539,  554,
			  555,  617,  622,  623,   97,  152,   88,   89,  470,  511,
			  144,  113,  512,  432,   98,  809,    6,  101,  593,  302,
			  102,  208,  507,  635,  513,  595,  607,  577,  615,  618,
			  648,  668,  419,  559>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  178,  773, 1340, -32768,  118,  273, -32768, -32768,  626,  219,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,  701,  264,  425,   18,  201, 1479, 1825,
			  761,  253,   51, -32768, -32768, 1340,  188, 1340,  760, -32768,
			  118, -32768, -32768, -32768, -32768, -32768, 1340, 1340,  759, 1340,
			 -32768, 1340, 1340,  489, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, 1951,  743, 1340,  646, -32768, -32768, -32768, -32768, -32768,
			 -32768,  478,  448, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  271,  185,  301, -32768, -32768, -32768, -32768,  605,  711, -32768,

			  678,  720,   52, -32768,  738,  675, -32768, -32768,  126, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  118, 1340,  751,
			  671,  750,  271, 1224, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  271, -32768,  126, -32768, -32768,
			 -32768, 1340, -32768, -32768, -32768, -32768, 1951,  725,  727,  271,
			  652,  469,  713,  118,  219,  721, 1908, -32768,  219, -32768,
			 -32768, -32768,  126, 1340, 1340, 1340, 1340, 1340, 1340, 1340,
			 1340, 1340, 1340, 1340, 1340, 1340, 1108, 1340,  992, 1340,
			 1340, -32768, -32768, -32768,  126,  126,  605, -32768, -32768, -32768,

			  726,  716, -32768, -32768,  112, -32768,  271, -32768, -32768,  271,
			  678,  678, -32768, -32768, -32768, -32768,  367,  363, -32768, -32768,
			 -32768, -32768, -32768,   34, -32768, -32768, -32768, -32768,    3,  219,
			  219,  697, -32768, -32768,  646, -32768,  704, 1890,  876, -32768,
			  126,  703, -32768, 1951,  343,  702,  219, -32768, 1847, -32768,
			 1340,  699, -32768, -32768, -32768,  695,  671, -32768,  234, -32768,
			  516,  698, -32768,  491,  491,  491,  491,  491,  745,  745,
			  958,  958,  958,  958,  958,  958, 1340, 1980, 1966, 1340,
			 1650, 1869, -32768,  219, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  316,  605,  803, -32768, -32768, -32768, -32768, -32768,  674,

			 1505, -32768, -32768,  671,  671,  126, -32768, -32768, -32768,  701,
			  187, -32768, 1951, -32768,  342,  692,  671,  646, -32768, 1340,
			  709,  671, -32768, 1951,  684,  219,  636, -32768, -32768,  294,
			 -32768,  126,  219, -32768, 1980, 1650,  671, -32768,  118, -32768,
			  519,  681, -32768, -32768, -32768, -32768,  697, -32768,  271,  184,
			  301,  453, -32768, 1456,  650, -32768, -32768, 1951,  219, -32768,
			 -32768,  671,  646,  294,  219, -32768,  219, -32768, -32768, -32768,
			 -32768, 1665,  484,    8,  605,  672,  670,  666,  656,   60,
			  332,  655, -32768,  271,  646,  611, -32768, -32768, -32768,  646,
			  671, -32768, 1479,  618,  660,  658, -32768, -32768, -32768,  637,

			  635,  630, -32768, -32768, -32768, -32768,  570,  287, -32768,  605,
			 -32768,  646, -32768, -32768, -32768,  320, -32768, -32768, -32768,  620,
			 -32768,    8, -32768,  560,  616, -32768, -32768,  447,  271, -32768,
			  879,  271, -32768, -32768, -32768, -32768,  628,  605,  195, -32768,
			  603,  813,  606,  600, -32768,  362,   65,   73,   77,   73,
			  551, -32768,  195,   73, -32768,   73,   73,   73,   73,   97,
			 -32768,  529,  520,  505,  584,  575, -32768,  333, -32768,  572,
			 -32768, -32768,  599,  196, -32768,  662, -32768, -32768,  551,   73,
			   77,   89,  572,  572, -32768,  594,  582,  572, -32768,  569,
			  203, -32768, -32768,  520, -32768,  505, -32768,  552, -32768, -32768,

			  529, -32768,  271,   73,   73,  581,  579,  569, -32768, -32768,
			  576, -32768,    7,   73,  534, -32768,  572, -32768,   73,   73,
			 -32768, -32768,  502,  572,  505,  545, -32768,  520, -32768, -32768,
			 -32768,  118,  118, -32768, -32768, -32768,  535,  219, -32768,  567,
			 -32768, -32768, -32768, -32768, -32768, -32768,  539, -32768,  505,  305,
			  210, -32768, -32768,  516,  556,  219,  493,  118,  296,   67,
			  522, -32768,  530, -32768,  537,  546, -32768, -32768, -32768, -32768,
			 1621,  524, -32768, -32768, -32768, -32768,  558, -32768,  517, -32768,
			 -32768,  527,  499,  966,  499, -32768,  484, -32768,  507, -32768,
			  502, 1340, -32768, -32768,  219,  118, -32768,  495, -32768, -32768,

			 -32768, -32768, -32768, 1951,  452,  518,  502,  473, 1340, -32768,
			 -32768,  496,  482, 1951, -32768,  236,  219,  386,  236, -32768,
			 -32768,  516, -32768,  219, -32768, -32768, -32768, -32768, -32768, -32768,
			  492, -32768,  511, -32768, -32768,  468,  519, 1665, -32768,  450,
			  454,  118, -32768,  791,  160, -32768, -32768, -32768,  131, -32768,
			  476,  502, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  543,  131, -32768,
			 -32768, -32768, -32768, 1340,  457,  493,  107, 1340,  501,  498,
			  455,   33,   -9,   20, 1340,  489,  -14, -32768, -32768, -32768,
			 -32768, -32768, -32768,  478,  448, -32768,  808,  383,  366, 1340,

			 1340, 1792, 1643, -32768,  401,  414, -32768,  118,  294, -32768,
			 -32768,  422, 1828, 1340, 1340, -32768, -32768,  379,  346, -32768,
			 1340,  339, 1951, 1951, -32768, -32768, -32768,  277,  373, -32768,
			  388, -32768,   -8,  408, 1951, 1951,  314, -32768,  361, -32768,
			 1951,  391, -32768,  275, -32768, 1665, -32768,   -8,  294,  378,
			  417,  399,  390, -32768,  371,  -24, -32768, -32768, 1340, 1340,
			 -32768,  304,  140,  290, -32768,  294, -32768,  271,   19,  314,
			  280,  314, -32768,  314, 1951, 1810, -32768,  230, -32768, 1340,
			 -32768,  241, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, 1696,  148,  177, -32768,  219, -32768, -32768, -32768,  136,
			  104, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -702,  266,  627, -348, -32768, -32768,  629,  356, -32768,  -86,
			 -32768, -104, -126, -32768,  207, -100, -32768, -426, -32768, -32768,
			 -32768,  419,  477, -32768,  -91, -32768,  151, -32768,  415,    1,
			 -32768, -32768,  393,  418, -32768, -32768,  456,    0, -32768,  141,
			  129, -32768,   -2, -32768, -32768,  258, -32768,  -90, -32768,  113,
			 -32768, -32768,  563,  222,  216,  206,  200,  199,  198,  508,
			 -32768,  424, -32768,  193,  192, -112, -32768,  334, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  263,  -25,  212, -364,  274,
			 -32768,  624,    4, -32768, -141, -32768, -32768,  283,  213, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  375,

			 -32768, -32768,  -36, -32768,  786, -32768, -32768, -32768, -32768,   41,
			  389,  311,  387, -466,  365, -422, -32768, -32768, -32768, -32768,
			 -418, -32768, -158, -32768,  249, -317, -32768, -181, -32768, -511,
			 -32768, -32768, -32768, -32768, -233, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -583, -32768, -32768, -32768, -167, -362, -32768, -32768,
			 -32768, -32768, -32768, -32768,   49, -32768,   25,  -11,    6,  272,
			 -32768, -32768, -32768, -32768,   10, -32768, -32768, -32768, -32768, -387,
			 -32768,  -80, -32768, -526, -32768, -32768, -32768, -361, -32768, -32768,
			 -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    4,  221,  203,   71,  245,  222,  103,  391,   94,  104,
			  260,    9,  556,  125,  223,  388,  773,  407,    9,  220,
			  448,  247,  212,  328,    3,    3,  479,  524,  429,  286,
			  748,  154,  619,  537,  480,  631,  119,  707,  193,  714,
			  301,  396,  713,  300,  118,  765,  262,  536,  155,   54,
			  160,    3,    3,   93,  165, -326,   92,  166,  167,  164,
			  169,  548,  170,  171,  117,  669,   93,  153,  284,  285,
			  344,  345,  491,  525,  192,  772,  395,  151,  116,  159,
			  227,  533,   45,  355,  150,  695,  706,  706,  359,  534,
			  749,  198,  202,   93,   39,  161,   92,  704,   93,  394,

			  298,   91,  546,  369,  811,  224,  150,   35,  233,  406,
			  -48,  149,  466,  115,  719,  638,  229,  230,   90,  237,
			  211,  236,  207,  114,  243,  339,  562,   39,  386,  503,
			  294,  295,  108, -183,  301,  545,  810,  675,  670,  196,
			   35,   91, -183,  446,  674,   93,  148,  233,   92,   39,
			  210,   93,  248,  -48,   92,  517,  246,  413,   90,    3,
			  700,  289,   35,  699,  256,  120,  -48,  255,  259,  549,
			  550,  241,  233,  805,  263,  264,  265,  266,  267,  268,
			  269,  270,  271,  272,  273,  274,  275,  277,  278,  280,
			  281,  282,  728,   91,  233,  233,  221, -183,  306,   91,

			  222,  283,   39,  602, -224,  367, -224,  401,  251,  223,
			   90,    3,  190,  743,  220,   35,   90,    3,    3,  610,
			   93,   93,  506,  350,   92, -183,  756,  123,  -47,  303,
			  304,  521,  655,  159,  159,  505,  150,  234,  654,  312,
			  233,  446,  424,  806,  375,  197,  321,  122,  315,    2,
			  338,  323,    3,    1,  588,  292,  653,  564,  293,  331,
			  378,  796,  325,  326,  672,  799,  597,  329,  349,   91,
			  445,  -47,  330,  646,  644,  227,  234,  334,  147,   39,
			  335,  356,  644,  336,  -47,  348,   90,  803,  802,  108,
			  443,  146,   35,  807,  201,  200,  800,  190, -183, -183,

			  224,  234,  107,  341,   93,  233, -183,  190,  190,  199,
			  190,  190,  190,    3,  160,  201,  200,  745, -183,  364,
			  357, -183,  744,  234,  234,  361,  387,  338,  201,  200,
			  199,  233,  368,  190,    3,  100,  423,  363,  726, -223,
			  366, -223,  370,  199,   54,  338,   99,    3,  410,  376,
			  377,  749,  563,  412,  312,  779,  338,  301,  384,  351,
			  731,  -55,  -55,  315,  389,  337,  390,  414,  776,  316,
			  385,  571, -312,  502,  771,  425,  570, -312,  190,  -55,
			  501,  764,  353,  319,  190,  749,  -55,  352,  318,  190,
			  326,  -55,  288,  770,  297,  -55,  287,  374,  296,  -55,

			  766,  596,  769,  598,  190,  190,  190,  190,  190,  190,
			  190,  190,  190,  190,  190,  190,  190,  780,  190,  190,
			  768,  190,  190,  190,  767,  428,  430,  757,  460,  191,
			  758,  459,  409,  331,  234,  747,  154,  428,  154,  746,
			  442,  742,  154,  737,  154,  154,  154,  154,  627,  626,
			  715,  442,  458,  190,  457,  473,  625,  732,  621,  456,
			  234,  253,  455,  486,  190,  621,  221,  729,  154,  720,
			  222,  624,  153,  195,  153,  190,  190,  437,  153,  154,
			  153,  153,  153,  153,  220, -183, -183,  514,  -75,  -75,
			  191,  608,  154,  154,  481,  468,  482,  483,  190,  487,

			  380,  379,  154,  194,  153,  568,  -75,  154,  154,  529,
			  473,  173,   60,  -75,  172,  153,  253,  204,  -75,  540,
			  516, -183,  -75,  147,  486,  544,  -75,  702,  153,  153,
			  568,  523, -156, -156, -156, -156,  697,  259,  153,  301,
			  112,  111,  671,  153,  153,  227,  371, -156,  649,  647,
			  641,  528,  560,  110,  109,  259,  332,  -12,  -12,  639,
			  614,  569, -156,  565,  616,  -12,  611,  609,  392,  684,
			 -156, -156, -156,  601,  571,  594,    3,  -12,  683,  -12,
			  -12,    9,  580,  592,  682,  581,  103,  591,  -12,  681,
			  587,  604,  603,    9,  605,  103,  579,    1,    9,  606,

			  680,  566,  456,  679,  678,  561,  557,    9,  508,  613,
			  458,  547,  503,  541,   40,  446,  259,  677,  526,   39,
			 -184, -184,  474,  259, -184,  532,  781,  531, -184,  455,
			   37,  632,   35, -184,  518,  637,  750,  519,  676,  504,
			 -184,  453,  -44, -184,  459,  651,  752,  -44,  452,  508,
			  498,  -44, -184,  204,  667,  -44,  784,  788,  791,  795,
			 -184, -184,  449,  434,  673,  444, -202,  686,  782,  785,
			  431,  792,  123,  750,  696,  421, -201,  422,  701,  787,
			  790,  794,  709,  752,   -9,  712,  420,  710,   -9,  217,
			  216,  418,   -9,  417,   -9,  415,   -9,  238,  411,   -9,

			  722,  723,  408,  405,  199,   54,  215,   52,    3,   51,
			   50,  730,  214,  404,  734,  735,   48,  403,  383,  402,
			  741,  740,  305,  362,   -9,  736,   44,   43,  -43,  373,
			  705,  360,  709,  -43,  358,  508,  751,  -43,  354,  106,
			  342,  -43,  327,  333,  190,  288,  324,  709,  207,  320,
			  317,  307,  759,  763,  190,  287,  257,  254,  252,  774,
			  775,  177,  176,  175,  174,  173,   60,  250,  783,  786,
			  789,  793,  763,  751,  249,  240, -300,  213,  209,  206,
			  801,  191,   32,   31,   30,  168,   28,   27,   26,   25,
			   24,   23,   22,   21,   20,   19,   18,   17,   16,   15,

			   14,   13,   12,   11,   10,  808,  163,  145,  551,  578,
			  464,  527,  189,  188,  187,  186,  185,  184,  183,  182,
			  181,  180,  179,  178,  177,  176,  175,  174,  173,   60,
			 -207,  -10,  463,  162,  462,  -10,  633,  190,  567,  -10,
			  499,  -10,  190,  -10, -207, -207,  -10,  299,  645,  600,
			  589,  435,  543,  190,  438, -157, -157, -157, -157,  694,
			  693,  382, -207,  190,  190,  692,  691,  690,  347, -207,
			 -157,  -10, -281,  689, -207,  190,  190,  433, -207, -281,
			 -207,  190, -207,  688, -281, -157,  797, -207, -281,  687,
			   62,   61, -281, -157, -157, -157,  515,   60,   59,   58,

			   57,  652,   56,  535,  520,   55,   54,   53,   52,    3,
			   51,   50,  715,  778,   49,  190,  190,   48,  451,   47,
			  438,  311,  310,  530,   45,  739,  584,   44,   43,  343,
			   42,    0,  346,  685,    0,    0,   41,    0, -280,    0,
			    0,    0,  190,    0,    0, -280,    0,   40,    0,    0,
			 -280,    0,   39,    0, -280,    0,    0,    0, -280,    0,
			    0,    0,   38,   37,   36,   35,    0,    0,    0,    0,
			    0,   34,  179,  178,  177,  176,  175,  174,  173,   60,
			    0,  309,    0,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,   22,   21,   20,   19,   18,   17,   16,

			   15,   14,   13,   12,   11,   10,   62,   61,    0,    0,
			    0,    0,    0,   60,   59,   58,   57,    0,   56,    0,
			    0,   55,   54,   53,   52,    3,   51,   50,  -13,  -13,
			   49,    0,    0,   48,    0,   47,  -13,    0,   46,    0,
			   45,    0,    0,   44,   43,    0,   42,    0,  -13,    0,
			  -13,  -13,   41,    0,    0,    0,  279,    0,    0,  -13,
			    0,    0,    0,   40,    0,    0,    0,    0,   39,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   38,   37,
			   36,   35,    0,    0,    0,    0,    0,   34,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   33,    0,   32,

			   31,   30,   29,   28,   27,   26,   25,   24,   23,   22,
			   21,   20,   19,   18,   17,   16,   15,   14,   13,   12,
			   11,   10,   62,   61,    0,    0,    0,    0,    0,   60,
			   59,   58,   57,    0,   56,    0,    0,   55,   54,   53,
			   52,    3,   51,   50,    0,    0,   49,    0,    0,   48,
			    0,   47,    0,    0,   46,    0,   45,    0,    0,   44,
			   43,    0,   42,    0,    0,    0,    0,    0,   41,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   40,
			    0,    0,    0,    0,   39,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   38,   37,   36,   35,    0,    0,

			    0,    0,    0,   34,    0,    0,    0,  276,    0,    0,
			    0,    0,    0,   33,    0,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,   20,   19,   18,
			   17,   16,   15,   14,   13,   12,   11,   10,   62,   61,
			    0,    0,    0,    0,    0,   60,   59,   58,   57,    0,
			   56,    0,    0,   55,   54,   53,   52,    3,   51,   50,
			    0,    0,   49,    0,    0,   48,    0,   47,    0,  242,
			   46,    0,   45,    0,    0,   44,   43,    0,   42,    0,
			    0,    0,    0,    0,   41,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   40,    0,    0,    0,    0,

			   39,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			   38,   37,   36,   35,    0,    0,    0,    0,    0,   34,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   33,
			    0,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,   20,   19,   18,   17,   16,   15,   14,
			   13,   12,   11,   10,   62,   61,    0,    0,    0,    0,
			    0,   60,   59,   58,   57,    0,   56,    0,    0,   55,
			   54,   53,   52,    3,   51,   50,    0,    0,   49,    0,
			    0,   48,    0,   47,    0,    0,   46,    0,   45,    0,
			    0,   44,   43,    0,   42,    0,    0,    0,    0,    0,

			   41,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   40,    0,    0,    0,    0,   39,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   38,   37,   36,   35,
			    0,    0,    0,    0,    0,   34,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   33,    0,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   22,   21,   20,
			   19,   18,   17,   16,   15,   14,   13,   12,   11,   10,
			   62,   61,    0,    0,    0,    0,    0,   60,   59,   58,
			   57,    0,   56,    0,    0,   55,   54,   53,   52,    3,
			   51,   50,    0,    0,   49,    0,    0,   48,    0,   47,

			    0,    0,  310,    0,   45,    0,    0,   44,   43,    0,
			   42,   52,    0,    0,    0,    0,   41,    0,    0,  217,
			  216,    0,    0,    0,    0,    0,    0,   40,    0,    0,
			    0,    0,   39,    0,  199,   54,  215,   52,    3,   51,
			   50,    0,   38,   37,   36,   35,   48,    0,    0,    0,
			    0,   34,    0,    0,    0,    0,   44,   43,    0,    0,
			    0,  309,    0,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,   22,   21,   20,   19,   18,   17,   16,
			   15,   14,   13,   12,   11,   10,   32,   31,   30,    0,
			   28,   27,   26,   25,   24,   23,   22,   21,   20,   19,

			   18,   17,   16,   15,   14,   13,   12,   11,   10,    0,
			    0,    0,   32,   31,   30,    0,   28,   27,   26,   25,
			   24,   23,   22,   21,   20,   19,   18,   17,   16,   15,
			   14,   13,   12,   11,   10,  217,  216,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  199,   54,  215,   52,    0,   51,  187,  186,  185,  184,
			  183,  182,  181,  180,  179,  178,  177,  176,  175,  174,
			  173,   60,   44,   43,    0,   52,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  725,    0,
			    0,    0,    0,    0,    0,    0,  583,   52,    0,    0,

			  189,  188,  187,  186,  185,  184,  183,  182,  181,  180,
			  179,  178,  177,  176,  175,  174,  173,   60,    0,    0,
			    0,    0,  582,    0,    0,    0,    0,    0,   32,   31,
			   30,    0,   28,   27,   26,   25,   24,   23,   22,   21,
			   20,   19,   18,   17,   16,   15,   14,   13,   12,   11,
			   10,   31,    0,    0,   28,   27,   26,   25,   24,   23,
			   22,   21,   20,   19,   18,   17,   16,   15,   14,   13,
			   12,   11,   10,   31,    0,    0,   28,   27,   26,   25,
			   24,   23,   22,   21,   20,   19,   18,   17,   16,   15,
			   14,   13,   12,   11,   10,  804,  189,  188,  187,  186,

			  185,  184,  183,  182,  181,  180,  179,  178,  177,  176,
			  175,  174,  173,   60,  189,  188,  187,  186,  185,  184,
			  183,  182,  181,  180,  179,  178,  177,  176,  175,  174,
			  173,   60,  189,  188,  187,  186,  185,  184,  183,  182,
			  181,  180,  179,  178,  177,  176,  175,  174,  173,   60,
			    0,  189,  188,  187,  186,  185,  184,  183,  182,  181,
			  180,  179,  178,  177,  176,  175,  174,  173,   60,    0,
			    0,    0,    0,  733,  188,  187,  186,  185,  184,  183,
			  182,  181,  180,  179,  178,  177,  176,  175,  174,  173,
			   60,  724,  322,  798,  189,  188,  187,  186,  185,  184,

			  183,  182,  181,  180,  179,  178,  177,  176,  175,  174,
			  173,   60,  189,  188,  187,  186,  185,  184,  183,  182,
			  181,  180,  179,  178,  177,  176,  175,  174,  173,   60,
			    0,    0,    0,    0,    0,  308,  143,  142,  141,  140,
			  139,  138,  137,  136,  135,  134,  133,  132,  131,  130,
			  129,  128,  127,  258,  126,  189,  188,  187,  186,  185,
			  184,  183,  182,  181,  180,  179,  178,  177,  176,  175,
			  174,  173,   60,  186,  185,  184,  183,  182,  181,  180,
			  179,  178,  177,  176,  175,  174,  173,   60,  185,  184,
			  183,  182,  181,  180,  179,  178,  177,  176,  175,  174,

			  173,   60>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  105,   92,    2,  145,  105,    8,  371,    4,    9,
			  168,    1,  538,   38,  105,  363,   40,  379,    8,  105,
			  438,  147,  102,  256,   33,   33,  452,  493,  415,  196,
			  732,   42,  615,   26,  452,  618,   36,   46,   74,   53,
			   37,   33,   56,   40,   26,  747,  172,   40,   42,   30,
			   46,   33,   33,   33,   50,   35,   36,   56,   57,   49,
			   59,  527,   61,   62,   46,  648,   33,   42,  194,  195,
			  303,  304,  459,  495,   73,   99,   68,   26,   60,   46,
			  105,  507,   48,  316,   33,  668,   95,   95,  321,  507,
			   71,   91,   92,   33,   76,   46,   36,  680,   33,   91,

			   66,   81,  524,  336,    0,  105,   33,   89,  108,   49,
			   33,   60,   47,   95,  697,  626,  106,  107,   98,  118,
			   68,  117,   70,  105,  123,  292,  548,   76,  361,   40,
			  210,  211,   25,   66,   37,  522,    0,  663,  649,   90,
			   89,   81,   75,   46,  655,   33,   95,  147,   36,   76,
			   98,   33,  151,   76,   36,   66,  146,  390,   98,   33,
			   53,   49,   89,   56,  164,   36,   89,  163,  168,  531,
			  532,  122,  172,   25,  173,  174,  175,  176,  177,  178,
			  179,  180,  181,  182,  183,  184,  185,  186,  187,  188,
			  189,  190,  703,   81,  194,  195,  300,   66,  234,   81,

			  300,  191,   76,  590,   64,  331,   66,  374,  159,  300,
			   98,   33,   71,  724,  300,   89,   98,   33,   33,  606,
			   33,   33,   26,   36,   36,   94,  737,   26,   33,  229,
			  230,   28,   72,   46,   46,   39,   33,  108,   78,  238,
			  240,   46,  409,   66,   60,   60,  246,   46,  238,   71,
			   40,  250,   33,   75,  571,  206,   96,   47,  209,   25,
			  350,  772,  252,  253,  651,  776,  583,  257,   81,   81,
			  437,   76,   38,  637,  635,  300,  147,  276,   25,   76,
			  279,  317,  643,  283,   89,   98,   98,  798,   47,   25,
			  431,   38,   89,  804,   14,   15,   66,  156,   62,   63,

			  300,  172,   38,  293,   33,  305,   70,  166,  167,   29,
			  169,  170,  171,   33,  310,   14,   15,   40,   82,   25,
			  319,   85,   45,  194,  195,  325,  362,   40,   14,   15,
			   29,  331,  332,  192,   33,   62,   49,  327,  702,   64,
			  330,   66,  338,   29,   30,   40,   73,   33,  384,  349,
			  350,   71,   47,  389,  353,   65,   40,   37,  358,  310,
			  708,   41,   42,  353,  364,   49,  366,  392,   64,  240,
			  360,   75,   40,   40,    3,  411,   80,   45,  237,   59,
			   47,  745,   40,   40,  243,   71,   66,   45,   45,  248,
			  380,   71,   29,    3,   31,   75,   29,  348,   31,   79,

			  748,  582,    3,  584,  263,  264,  265,  266,  267,  268,
			  269,  270,  271,  272,  273,  274,  275,  765,  277,  278,
			    3,  280,  281,  282,   46,  415,  416,   66,   66,   38,
			   39,   69,  383,   25,  305,   47,  447,  427,  449,   66,
			  430,  102,  453,   64,  455,  456,  457,  458,   62,   63,
			  104,  441,   90,  312,   92,  449,   70,   35,  616,   97,
			  331,   47,  100,  457,  323,  623,  570,   66,  479,  103,
			  570,   85,  447,   25,  449,  334,  335,  428,  453,  490,
			  455,  456,  457,  458,  570,  102,  103,  477,   41,   42,
			   38,   39,  503,  504,  453,  446,  455,  456,  357,  458,

			   47,   48,  513,   25,  479,   37,   59,  518,  519,  503,
			  504,   20,   21,   66,   25,  490,   47,   48,   71,  513,
			  479,   66,   75,   25,  518,  519,   79,   26,  503,  504,
			   37,  490,   64,   65,   66,   67,   79,  537,  513,   37,
			  115,  116,   66,  518,  519,  570,   27,   79,   94,   99,
			   39,  502,  542,  128,  129,  555,   40,   62,   63,   67,
			   64,  557,   94,  553,   82,   70,   93,   49,   84,   26,
			  102,  103,  104,   66,   75,   48,   33,   82,   35,   84,
			   85,  571,   45,   66,   41,   39,  588,  577,   93,   46,
			   66,  591,  591,  583,  594,  597,   66,   75,  588,  595,

			   57,   45,   97,   60,   61,   66,   39,  597,   73,  608,
			   90,   66,   40,   79,   71,   46,  616,   74,   66,   76,
			   62,   63,   71,  623,   66,   46,  767,   46,   70,  100,
			   87,  621,   89,   75,   40,  625,  736,   55,   95,   40,
			   82,   41,   66,   85,   69,  641,  736,   71,   42,   73,
			   66,   75,   94,   48,  644,   79,  768,  769,  770,  771,
			  102,  103,   59,   47,  654,   37,  106,  667,  768,  769,
			   50,  771,   26,  773,  673,   40,  106,   47,  677,  769,
			  770,  771,  682,  773,   58,  684,   49,  683,   62,   14,
			   15,   33,   66,   33,   68,   77,   70,   26,   87,   73,

			  699,  700,   47,   47,   29,   30,   31,   32,   33,   34,
			   35,  707,   37,   47,  713,  714,   41,   47,   68,   47,
			  720,  720,   25,   87,   98,  715,   51,   52,   66,   48,
			  681,   47,  732,   71,   25,   73,  736,   75,   46,   38,
			   66,   79,   47,   45,  603,   29,   47,  747,   70,   47,
			   47,   47,  742,  743,  613,   29,   35,   44,  106,  758,
			  759,   16,   17,   18,   19,   20,   21,   40,  768,  769,
			  770,  771,  762,  773,   49,   25,   25,   39,   58,   68,
			  779,   38,  107,  108,  109,   26,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,

			  125,  126,  127,  128,  129,  805,   46,   46,  536,  560,
			  445,  500,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   27,   58,  445,   47,  445,   62,  623,  696,  555,   66,
			  465,   68,  701,   70,   41,   42,   73,  223,  636,  586,
			  576,  427,  518,  712,   41,   64,   65,   66,   67,  667,
			  667,  353,   59,  722,  723,  667,  667,  667,  305,   66,
			   79,   98,   59,  667,   71,  734,  735,  421,   75,   66,
			   77,  740,   79,  667,   71,   94,  773,   84,   75,  667,
			   14,   15,   79,  102,  103,  104,  478,   21,   22,   23,

			   24,  643,   26,  510,  489,   29,   30,   31,   32,   33,
			   34,   35,  104,  762,   38,  774,  775,   41,  441,   43,
			   41,   45,   46,  504,   48,  718,  570,   51,   52,  300,
			   54,   -1,  305,  667,   -1,   -1,   60,   -1,   59,   -1,
			   -1,   -1,  801,   -1,   -1,   66,   -1,   71,   -1,   -1,
			   71,   -1,   76,   -1,   75,   -1,   -1,   -1,   79,   -1,
			   -1,   -1,   86,   87,   88,   89,   -1,   -1,   -1,   -1,
			   -1,   95,   14,   15,   16,   17,   18,   19,   20,   21,
			   -1,  105,   -1,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,

			  124,  125,  126,  127,  128,  129,   14,   15,   -1,   -1,
			   -1,   -1,   -1,   21,   22,   23,   24,   -1,   26,   -1,
			   -1,   29,   30,   31,   32,   33,   34,   35,   62,   63,
			   38,   -1,   -1,   41,   -1,   43,   70,   -1,   46,   -1,
			   48,   -1,   -1,   51,   52,   -1,   54,   -1,   82,   -1,
			   84,   85,   60,   -1,   -1,   -1,   64,   -1,   -1,   93,
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

			   -1,   -1,   -1,   95,   -1,   -1,   -1,   99,   -1,   -1,
			   -1,   -1,   -1,  105,   -1,  107,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,   14,   15,
			   -1,   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,
			   26,   -1,   -1,   29,   30,   31,   32,   33,   34,   35,
			   -1,   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   45,
			   46,   -1,   48,   -1,   -1,   51,   52,   -1,   54,   -1,
			   -1,   -1,   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   71,   -1,   -1,   -1,   -1,

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

			   60,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   71,   -1,   -1,   -1,   -1,   76,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   86,   87,   88,   89,
			   -1,   -1,   -1,   -1,   -1,   95,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  105,   -1,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			   14,   15,   -1,   -1,   -1,   -1,   -1,   21,   22,   23,
			   24,   -1,   26,   -1,   -1,   29,   30,   31,   32,   33,
			   34,   35,   -1,   -1,   38,   -1,   -1,   41,   -1,   43,

			   -1,   -1,   46,   -1,   48,   -1,   -1,   51,   52,   -1,
			   54,   32,   -1,   -1,   -1,   -1,   60,   -1,   -1,   14,
			   15,   -1,   -1,   -1,   -1,   -1,   -1,   71,   -1,   -1,
			   -1,   -1,   76,   -1,   29,   30,   31,   32,   33,   34,
			   35,   -1,   86,   87,   88,   89,   41,   -1,   -1,   -1,
			   -1,   95,   -1,   -1,   -1,   -1,   51,   52,   -1,   -1,
			   -1,  105,   -1,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  107,  108,  109,   -1,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,

			  121,  122,  123,  124,  125,  126,  127,  128,  129,   -1,
			   -1,   -1,  107,  108,  109,   -1,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,   14,   15,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   29,   30,   31,   32,   -1,   34,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   51,   52,   -1,   32,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   45,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   75,   32,   -1,   -1,

			    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   -1,   -1,
			   -1,   -1,  101,   -1,   -1,   -1,   -1,   -1,  107,  108,
			  109,   -1,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  108,   -1,   -1,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  108,   -1,   -1,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,   99,    4,    5,    6,    7,

			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   -1,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   -1,
			   -1,   -1,   -1,   45,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   99,   45,   83,    4,    5,    6,    7,    8,    9,

			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   -1,   -1,   -1,   -1,   -1,   45,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,   45,  129,    4,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,    8,    9,
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

	yyFinal: INTEGER is 811
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 130
			-- Number of tokens

	yyLast: INTEGER is 2001
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
