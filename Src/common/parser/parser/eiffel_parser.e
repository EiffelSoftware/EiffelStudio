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
					--|#line 175 "eiffel.y"
				yy_do_action_1
			when 2 then
					--|#line 182 "eiffel.y"
				yy_do_action_2
			when 3 then
					--|#line 189 "eiffel.y"
				yy_do_action_3
			when 4 then
					--|#line 198 "eiffel.y"
				yy_do_action_4
			when 5 then
					--|#line 241 "eiffel.y"
				yy_do_action_5
			when 6 then
					--|#line 250 "eiffel.y"
				yy_do_action_6
			when 7 then
					--|#line 258 "eiffel.y"
				yy_do_action_7
			when 8 then
					--|#line 270 "eiffel.y"
				yy_do_action_8
			when 9 then
					--|#line 272 "eiffel.y"
				yy_do_action_9
			when 10 then
					--|#line 274 "eiffel.y"
				yy_do_action_10
			when 11 then
					--|#line 278 "eiffel.y"
				yy_do_action_11
			when 12 then
					--|#line 280 "eiffel.y"
				yy_do_action_12
			when 13 then
					--|#line 282 "eiffel.y"
				yy_do_action_13
			when 14 then
					--|#line 286 "eiffel.y"
				yy_do_action_14
			when 15 then
					--|#line 288 "eiffel.y"
				yy_do_action_15
			when 16 then
					--|#line 290 "eiffel.y"
				yy_do_action_16
			when 17 then
					--|#line 294 "eiffel.y"
				yy_do_action_17
			when 18 then
					--|#line 299 "eiffel.y"
				yy_do_action_18
			when 19 then
					--|#line 306 "eiffel.y"
				yy_do_action_19
			when 20 then
					--|#line 310 "eiffel.y"
				yy_do_action_20
			when 21 then
					--|#line 312 "eiffel.y"
				yy_do_action_21
			when 22 then
					--|#line 324 "eiffel.y"
				yy_do_action_22
			when 23 then
					--|#line 329 "eiffel.y"
				yy_do_action_23
			when 24 then
					--|#line 334 "eiffel.y"
				yy_do_action_24
			when 25 then
					--|#line 341 "eiffel.y"
				yy_do_action_25
			when 26 then
					--|#line 343 "eiffel.y"
				yy_do_action_26
			when 27 then
					--|#line 345 "eiffel.y"
				yy_do_action_27
			when 28 then
					--|#line 349 "eiffel.y"
				yy_do_action_28
			when 29 then
					--|#line 359 "eiffel.y"
				yy_do_action_29
			when 30 then
					--|#line 365 "eiffel.y"
				yy_do_action_30
			when 31 then
					--|#line 372 "eiffel.y"
				yy_do_action_31
			when 32 then
					--|#line 378 "eiffel.y"
				yy_do_action_32
			when 33 then
					--|#line 386 "eiffel.y"
				yy_do_action_33
			when 34 then
					--|#line 390 "eiffel.y"
				yy_do_action_34
			when 35 then
					--|#line 401 "eiffel.y"
				yy_do_action_35
			when 36 then
					--|#line 405 "eiffel.y"
				yy_do_action_36
			when 37 then
					--|#line 420 "eiffel.y"
				yy_do_action_37
			when 38 then
					--|#line 422 "eiffel.y"
				yy_do_action_38
			when 39 then
					--|#line 429 "eiffel.y"
				yy_do_action_39
			when 40 then
					--|#line 431 "eiffel.y"
				yy_do_action_40
			when 41 then
					--|#line 440 "eiffel.y"
				yy_do_action_41
			when 42 then
					--|#line 445 "eiffel.y"
				yy_do_action_42
			when 43 then
					--|#line 452 "eiffel.y"
				yy_do_action_43
			when 44 then
					--|#line 454 "eiffel.y"
				yy_do_action_44
			when 45 then
					--|#line 458 "eiffel.y"
				yy_do_action_45
			when 46 then
					--|#line 458 "eiffel.y"
				yy_do_action_46
			when 47 then
					--|#line 467 "eiffel.y"
				yy_do_action_47
			when 48 then
					--|#line 469 "eiffel.y"
				yy_do_action_48
			when 49 then
					--|#line 473 "eiffel.y"
				yy_do_action_49
			when 50 then
					--|#line 478 "eiffel.y"
				yy_do_action_50
			when 51 then
					--|#line 482 "eiffel.y"
				yy_do_action_51
			when 52 then
					--|#line 488 "eiffel.y"
				yy_do_action_52
			when 53 then
					--|#line 496 "eiffel.y"
				yy_do_action_53
			when 54 then
					--|#line 501 "eiffel.y"
				yy_do_action_54
			when 55 then
					--|#line 508 "eiffel.y"
				yy_do_action_55
			when 56 then
					--|#line 509 "eiffel.y"
				yy_do_action_56
			when 57 then
					--|#line 512 "eiffel.y"
				yy_do_action_57
			when 58 then
					--|#line 525 "eiffel.y"
				yy_do_action_58
			when 59 then
					--|#line 527 "eiffel.y"
				yy_do_action_59
			when 60 then
					--|#line 534 "eiffel.y"
				yy_do_action_60
			when 61 then
					--|#line 538 "eiffel.y"
				yy_do_action_61
			when 62 then
					--|#line 540 "eiffel.y"
				yy_do_action_62
			when 63 then
					--|#line 544 "eiffel.y"
				yy_do_action_63
			when 64 then
					--|#line 546 "eiffel.y"
				yy_do_action_64
			when 65 then
					--|#line 548 "eiffel.y"
				yy_do_action_65
			when 66 then
					--|#line 552 "eiffel.y"
				yy_do_action_66
			when 67 then
					--|#line 557 "eiffel.y"
				yy_do_action_67
			when 68 then
					--|#line 561 "eiffel.y"
				yy_do_action_68
			when 69 then
					--|#line 565 "eiffel.y"
				yy_do_action_69
			when 70 then
					--|#line 567 "eiffel.y"
				yy_do_action_70
			when 71 then
					--|#line 571 "eiffel.y"
				yy_do_action_71
			when 72 then
					--|#line 576 "eiffel.y"
				yy_do_action_72
			when 73 then
					--|#line 581 "eiffel.y"
				yy_do_action_73
			when 74 then
					--|#line 592 "eiffel.y"
				yy_do_action_74
			when 75 then
					--|#line 594 "eiffel.y"
				yy_do_action_75
			when 76 then
					--|#line 596 "eiffel.y"
				yy_do_action_76
			when 77 then
					--|#line 600 "eiffel.y"
				yy_do_action_77
			when 78 then
					--|#line 605 "eiffel.y"
				yy_do_action_78
			when 79 then
					--|#line 612 "eiffel.y"
				yy_do_action_79
			when 80 then
					--|#line 617 "eiffel.y"
				yy_do_action_80
			when 81 then
					--|#line 625 "eiffel.y"
				yy_do_action_81
			when 82 then
					--|#line 630 "eiffel.y"
				yy_do_action_82
			when 83 then
					--|#line 635 "eiffel.y"
				yy_do_action_83
			when 84 then
					--|#line 640 "eiffel.y"
				yy_do_action_84
			when 85 then
					--|#line 645 "eiffel.y"
				yy_do_action_85
			when 86 then
					--|#line 650 "eiffel.y"
				yy_do_action_86
			when 87 then
					--|#line 655 "eiffel.y"
				yy_do_action_87
			when 88 then
					--|#line 663 "eiffel.y"
				yy_do_action_88
			when 89 then
					--|#line 665 "eiffel.y"
				yy_do_action_89
			when 90 then
					--|#line 669 "eiffel.y"
				yy_do_action_90
			when 91 then
					--|#line 674 "eiffel.y"
				yy_do_action_91
			when 92 then
					--|#line 681 "eiffel.y"
				yy_do_action_92
			when 93 then
					--|#line 685 "eiffel.y"
				yy_do_action_93
			when 94 then
					--|#line 687 "eiffel.y"
				yy_do_action_94
			when 95 then
					--|#line 691 "eiffel.y"
				yy_do_action_95
			when 96 then
					--|#line 699 "eiffel.y"
				yy_do_action_96
			when 97 then
					--|#line 703 "eiffel.y"
				yy_do_action_97
			when 98 then
					--|#line 710 "eiffel.y"
				yy_do_action_98
			when 99 then
					--|#line 719 "eiffel.y"
				yy_do_action_99
			when 100 then
					--|#line 727 "eiffel.y"
				yy_do_action_100
			when 101 then
					--|#line 729 "eiffel.y"
				yy_do_action_101
			when 102 then
					--|#line 731 "eiffel.y"
				yy_do_action_102
			when 103 then
					--|#line 735 "eiffel.y"
				yy_do_action_103
			when 104 then
					--|#line 737 "eiffel.y"
				yy_do_action_104
			when 105 then
					--|#line 743 "eiffel.y"
				yy_do_action_105
			when 106 then
					--|#line 748 "eiffel.y"
				yy_do_action_106
			when 107 then
					--|#line 756 "eiffel.y"
				yy_do_action_107
			when 108 then
					--|#line 762 "eiffel.y"
				yy_do_action_108
			when 109 then
					--|#line 770 "eiffel.y"
				yy_do_action_109
			when 110 then
					--|#line 775 "eiffel.y"
				yy_do_action_110
			when 111 then
					--|#line 782 "eiffel.y"
				yy_do_action_111
			when 112 then
					--|#line 784 "eiffel.y"
				yy_do_action_112
			when 113 then
					--|#line 788 "eiffel.y"
				yy_do_action_113
			when 114 then
					--|#line 790 "eiffel.y"
				yy_do_action_114
			when 115 then
					--|#line 794 "eiffel.y"
				yy_do_action_115
			when 116 then
					--|#line 796 "eiffel.y"
				yy_do_action_116
			when 117 then
					--|#line 800 "eiffel.y"
				yy_do_action_117
			when 118 then
					--|#line 802 "eiffel.y"
				yy_do_action_118
			when 119 then
					--|#line 806 "eiffel.y"
				yy_do_action_119
			when 120 then
					--|#line 808 "eiffel.y"
				yy_do_action_120
			when 121 then
					--|#line 812 "eiffel.y"
				yy_do_action_121
			when 122 then
					--|#line 814 "eiffel.y"
				yy_do_action_122
			when 123 then
					--|#line 822 "eiffel.y"
				yy_do_action_123
			when 124 then
					--|#line 824 "eiffel.y"
				yy_do_action_124
			when 125 then
					--|#line 828 "eiffel.y"
				yy_do_action_125
			when 126 then
					--|#line 830 "eiffel.y"
				yy_do_action_126
			when 127 then
					--|#line 834 "eiffel.y"
				yy_do_action_127
			when 128 then
					--|#line 839 "eiffel.y"
				yy_do_action_128
			when 129 then
					--|#line 846 "eiffel.y"
				yy_do_action_129
			when 130 then
					--|#line 850 "eiffel.y"
				yy_do_action_130
			when 131 then
					--|#line 851 "eiffel.y"
				yy_do_action_131
			when 132 then
					--|#line 860 "eiffel.y"
				yy_do_action_132
			when 133 then
					--|#line 862 "eiffel.y"
				yy_do_action_133
			when 134 then
					--|#line 866 "eiffel.y"
				yy_do_action_134
			when 135 then
					--|#line 871 "eiffel.y"
				yy_do_action_135
			when 136 then
					--|#line 878 "eiffel.y"
				yy_do_action_136
			when 137 then
					--|#line 882 "eiffel.y"
				yy_do_action_137
			when 138 then
					--|#line 888 "eiffel.y"
				yy_do_action_138
			when 139 then
					--|#line 896 "eiffel.y"
				yy_do_action_139
			when 140 then
					--|#line 898 "eiffel.y"
				yy_do_action_140
			when 141 then
					--|#line 902 "eiffel.y"
				yy_do_action_141
			when 142 then
					--|#line 904 "eiffel.y"
				yy_do_action_142
			when 143 then
					--|#line 908 "eiffel.y"
				yy_do_action_143
			when 144 then
					--|#line 908 "eiffel.y"
				yy_do_action_144
			when 145 then
					--|#line 920 "eiffel.y"
				yy_do_action_145
			when 146 then
					--|#line 922 "eiffel.y"
				yy_do_action_146
			when 147 then
					--|#line 924 "eiffel.y"
				yy_do_action_147
			when 148 then
					--|#line 928 "eiffel.y"
				yy_do_action_148
			when 149 then
					--|#line 935 "eiffel.y"
				yy_do_action_149
			when 150 then
					--|#line 940 "eiffel.y"
				yy_do_action_150
			when 151 then
					--|#line 942 "eiffel.y"
				yy_do_action_151
			when 152 then
					--|#line 946 "eiffel.y"
				yy_do_action_152
			when 153 then
					--|#line 948 "eiffel.y"
				yy_do_action_153
			when 154 then
					--|#line 952 "eiffel.y"
				yy_do_action_154
			when 155 then
					--|#line 954 "eiffel.y"
				yy_do_action_155
			when 156 then
					--|#line 958 "eiffel.y"
				yy_do_action_156
			when 157 then
					--|#line 960 "eiffel.y"
				yy_do_action_157
			when 158 then
					--|#line 964 "eiffel.y"
				yy_do_action_158
			when 159 then
					--|#line 969 "eiffel.y"
				yy_do_action_159
			when 160 then
					--|#line 976 "eiffel.y"
				yy_do_action_160
			when 161 then
					--|#line 980 "eiffel.y"
				yy_do_action_161
			when 162 then
					--|#line 981 "eiffel.y"
				yy_do_action_162
			when 163 then
					--|#line 984 "eiffel.y"
				yy_do_action_163
			when 164 then
					--|#line 986 "eiffel.y"
				yy_do_action_164
			when 165 then
					--|#line 988 "eiffel.y"
				yy_do_action_165
			when 166 then
					--|#line 990 "eiffel.y"
				yy_do_action_166
			when 167 then
					--|#line 992 "eiffel.y"
				yy_do_action_167
			when 168 then
					--|#line 994 "eiffel.y"
				yy_do_action_168
			when 169 then
					--|#line 996 "eiffel.y"
				yy_do_action_169
			when 170 then
					--|#line 998 "eiffel.y"
				yy_do_action_170
			when 171 then
					--|#line 1000 "eiffel.y"
				yy_do_action_171
			when 172 then
					--|#line 1002 "eiffel.y"
				yy_do_action_172
			when 173 then
					--|#line 1006 "eiffel.y"
				yy_do_action_173
			when 174 then
					--|#line 1008 "eiffel.y"
				yy_do_action_174
			when 175 then
					--|#line 1008 "eiffel.y"
				yy_do_action_175
			when 176 then
					--|#line 1015 "eiffel.y"
				yy_do_action_176
			when 177 then
					--|#line 1015 "eiffel.y"
				yy_do_action_177
			when 178 then
					--|#line 1024 "eiffel.y"
				yy_do_action_178
			when 179 then
					--|#line 1026 "eiffel.y"
				yy_do_action_179
			when 180 then
					--|#line 1026 "eiffel.y"
				yy_do_action_180
			when 181 then
					--|#line 1033 "eiffel.y"
				yy_do_action_181
			when 182 then
					--|#line 1033 "eiffel.y"
				yy_do_action_182
			when 183 then
					--|#line 1042 "eiffel.y"
				yy_do_action_183
			when 184 then
					--|#line 1044 "eiffel.y"
				yy_do_action_184
			when 185 then
					--|#line 1053 "eiffel.y"
				yy_do_action_185
			when 186 then
					--|#line 1058 "eiffel.y"
				yy_do_action_186
			when 187 then
					--|#line 1065 "eiffel.y"
				yy_do_action_187
			when 188 then
					--|#line 1069 "eiffel.y"
				yy_do_action_188
			when 189 then
					--|#line 1071 "eiffel.y"
				yy_do_action_189
			when 190 then
					--|#line 1073 "eiffel.y"
				yy_do_action_190
			when 191 then
					--|#line 1081 "eiffel.y"
				yy_do_action_191
			when 192 then
					--|#line 1083 "eiffel.y"
				yy_do_action_192
			when 193 then
					--|#line 1087 "eiffel.y"
				yy_do_action_193
			when 194 then
					--|#line 1089 "eiffel.y"
				yy_do_action_194
			when 195 then
					--|#line 1091 "eiffel.y"
				yy_do_action_195
			when 196 then
					--|#line 1093 "eiffel.y"
				yy_do_action_196
			when 197 then
					--|#line 1095 "eiffel.y"
				yy_do_action_197
			when 198 then
					--|#line 1097 "eiffel.y"
				yy_do_action_198
			when 199 then
					--|#line 1099 "eiffel.y"
				yy_do_action_199
			when 200 then
					--|#line 1103 "eiffel.y"
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
					--|#line 1107 "eiffel.y"
				yy_do_action_201
			when 202 then
					--|#line 1109 "eiffel.y"
				yy_do_action_202
			when 203 then
					--|#line 1111 "eiffel.y"
				yy_do_action_203
			when 204 then
					--|#line 1115 "eiffel.y"
				yy_do_action_204
			when 205 then
					--|#line 1117 "eiffel.y"
				yy_do_action_205
			when 206 then
					--|#line 1121 "eiffel.y"
				yy_do_action_206
			when 207 then
					--|#line 1126 "eiffel.y"
				yy_do_action_207
			when 208 then
					--|#line 1137 "eiffel.y"
				yy_do_action_208
			when 209 then
					--|#line 1143 "eiffel.y"
				yy_do_action_209
			when 210 then
					--|#line 1151 "eiffel.y"
				yy_do_action_210
			when 211 then
					--|#line 1153 "eiffel.y"
				yy_do_action_211
			when 212 then
					--|#line 1157 "eiffel.y"
				yy_do_action_212
			when 213 then
					--|#line 1162 "eiffel.y"
				yy_do_action_213
			when 214 then
					--|#line 1169 "eiffel.y"
				yy_do_action_214
			when 215 then
					--|#line 1169 "eiffel.y"
				yy_do_action_215
			when 216 then
					--|#line 1194 "eiffel.y"
				yy_do_action_216
			when 217 then
					--|#line 1196 "eiffel.y"
				yy_do_action_217
			when 218 then
					--|#line 1204 "eiffel.y"
				yy_do_action_218
			when 219 then
					--|#line 1206 "eiffel.y"
				yy_do_action_219
			when 220 then
					--|#line 1214 "eiffel.y"
				yy_do_action_220
			when 221 then
					--|#line 1220 "eiffel.y"
				yy_do_action_221
			when 222 then
					--|#line 1222 "eiffel.y"
				yy_do_action_222
			when 223 then
					--|#line 1226 "eiffel.y"
				yy_do_action_223
			when 224 then
					--|#line 1231 "eiffel.y"
				yy_do_action_224
			when 225 then
					--|#line 1238 "eiffel.y"
				yy_do_action_225
			when 226 then
					--|#line 1242 "eiffel.y"
				yy_do_action_226
			when 227 then
					--|#line 1244 "eiffel.y"
				yy_do_action_227
			when 228 then
					--|#line 1248 "eiffel.y"
				yy_do_action_228
			when 229 then
					--|#line 1254 "eiffel.y"
				yy_do_action_229
			when 230 then
					--|#line 1256 "eiffel.y"
				yy_do_action_230
			when 231 then
					--|#line 1260 "eiffel.y"
				yy_do_action_231
			when 232 then
					--|#line 1265 "eiffel.y"
				yy_do_action_232
			when 233 then
					--|#line 1272 "eiffel.y"
				yy_do_action_233
			when 234 then
					--|#line 1276 "eiffel.y"
				yy_do_action_234
			when 235 then
					--|#line 1281 "eiffel.y"
				yy_do_action_235
			when 236 then
					--|#line 1288 "eiffel.y"
				yy_do_action_236
			when 237 then
					--|#line 1290 "eiffel.y"
				yy_do_action_237
			when 238 then
					--|#line 1292 "eiffel.y"
				yy_do_action_238
			when 239 then
					--|#line 1294 "eiffel.y"
				yy_do_action_239
			when 240 then
					--|#line 1296 "eiffel.y"
				yy_do_action_240
			when 241 then
					--|#line 1298 "eiffel.y"
				yy_do_action_241
			when 242 then
					--|#line 1300 "eiffel.y"
				yy_do_action_242
			when 243 then
					--|#line 1302 "eiffel.y"
				yy_do_action_243
			when 244 then
					--|#line 1304 "eiffel.y"
				yy_do_action_244
			when 245 then
					--|#line 1306 "eiffel.y"
				yy_do_action_245
			when 246 then
					--|#line 1308 "eiffel.y"
				yy_do_action_246
			when 247 then
					--|#line 1310 "eiffel.y"
				yy_do_action_247
			when 248 then
					--|#line 1312 "eiffel.y"
				yy_do_action_248
			when 249 then
					--|#line 1314 "eiffel.y"
				yy_do_action_249
			when 250 then
					--|#line 1316 "eiffel.y"
				yy_do_action_250
			when 251 then
					--|#line 1318 "eiffel.y"
				yy_do_action_251
			when 252 then
					--|#line 1320 "eiffel.y"
				yy_do_action_252
			when 253 then
					--|#line 1322 "eiffel.y"
				yy_do_action_253
			when 254 then
					--|#line 1327 "eiffel.y"
				yy_do_action_254
			when 255 then
					--|#line 1329 "eiffel.y"
				yy_do_action_255
			when 256 then
					--|#line 1338 "eiffel.y"
				yy_do_action_256
			when 257 then
					--|#line 1344 "eiffel.y"
				yy_do_action_257
			when 258 then
					--|#line 1346 "eiffel.y"
				yy_do_action_258
			when 259 then
					--|#line 1350 "eiffel.y"
				yy_do_action_259
			when 260 then
					--|#line 1352 "eiffel.y"
				yy_do_action_260
			when 261 then
					--|#line 1352 "eiffel.y"
				yy_do_action_261
			when 262 then
					--|#line 1362 "eiffel.y"
				yy_do_action_262
			when 263 then
					--|#line 1364 "eiffel.y"
				yy_do_action_263
			when 264 then
					--|#line 1366 "eiffel.y"
				yy_do_action_264
			when 265 then
					--|#line 1370 "eiffel.y"
				yy_do_action_265
			when 266 then
					--|#line 1376 "eiffel.y"
				yy_do_action_266
			when 267 then
					--|#line 1378 "eiffel.y"
				yy_do_action_267
			when 268 then
					--|#line 1380 "eiffel.y"
				yy_do_action_268
			when 269 then
					--|#line 1384 "eiffel.y"
				yy_do_action_269
			when 270 then
					--|#line 1389 "eiffel.y"
				yy_do_action_270
			when 271 then
					--|#line 1396 "eiffel.y"
				yy_do_action_271
			when 272 then
					--|#line 1400 "eiffel.y"
				yy_do_action_272
			when 273 then
					--|#line 1402 "eiffel.y"
				yy_do_action_273
			when 274 then
					--|#line 1411 "eiffel.y"
				yy_do_action_274
			when 275 then
					--|#line 1413 "eiffel.y"
				yy_do_action_275
			when 276 then
					--|#line 1417 "eiffel.y"
				yy_do_action_276
			when 277 then
					--|#line 1419 "eiffel.y"
				yy_do_action_277
			when 278 then
					--|#line 1423 "eiffel.y"
				yy_do_action_278
			when 279 then
					--|#line 1425 "eiffel.y"
				yy_do_action_279
			when 280 then
					--|#line 1429 "eiffel.y"
				yy_do_action_280
			when 281 then
					--|#line 1434 "eiffel.y"
				yy_do_action_281
			when 282 then
					--|#line 1441 "eiffel.y"
				yy_do_action_282
			when 283 then
					--|#line 1447 "eiffel.y"
				yy_do_action_283
			when 284 then
					--|#line 1452 "eiffel.y"
				yy_do_action_284
			when 285 then
					--|#line 1457 "eiffel.y"
				yy_do_action_285
			when 286 then
					--|#line 1467 "eiffel.y"
				yy_do_action_286
			when 287 then
					--|#line 1477 "eiffel.y"
				yy_do_action_287
			when 288 then
					--|#line 1489 "eiffel.y"
				yy_do_action_288
			when 289 then
					--|#line 1491 "eiffel.y"
				yy_do_action_289
			when 290 then
					--|#line 1493 "eiffel.y"
				yy_do_action_290
			when 291 then
					--|#line 1511 "eiffel.y"
				yy_do_action_291
			when 292 then
					--|#line 1513 "eiffel.y"
				yy_do_action_292
			when 293 then
					--|#line 1515 "eiffel.y"
				yy_do_action_293
			when 294 then
					--|#line 1517 "eiffel.y"
				yy_do_action_294
			when 295 then
					--|#line 1519 "eiffel.y"
				yy_do_action_295
			when 296 then
					--|#line 1521 "eiffel.y"
				yy_do_action_296
			when 297 then
					--|#line 1523 "eiffel.y"
				yy_do_action_297
			when 298 then
					--|#line 1527 "eiffel.y"
				yy_do_action_298
			when 299 then
					--|#line 1529 "eiffel.y"
				yy_do_action_299
			when 300 then
					--|#line 1531 "eiffel.y"
				yy_do_action_300
			when 301 then
					--|#line 1533 "eiffel.y"
				yy_do_action_301
			when 302 then
					--|#line 1535 "eiffel.y"
				yy_do_action_302
			when 303 then
					--|#line 1537 "eiffel.y"
				yy_do_action_303
			when 304 then
					--|#line 1541 "eiffel.y"
				yy_do_action_304
			when 305 then
					--|#line 1543 "eiffel.y"
				yy_do_action_305
			when 306 then
					--|#line 1545 "eiffel.y"
				yy_do_action_306
			when 307 then
					--|#line 1549 "eiffel.y"
				yy_do_action_307
			when 308 then
					--|#line 1554 "eiffel.y"
				yy_do_action_308
			when 309 then
					--|#line 1561 "eiffel.y"
				yy_do_action_309
			when 310 then
					--|#line 1567 "eiffel.y"
				yy_do_action_310
			when 311 then
					--|#line 1569 "eiffel.y"
				yy_do_action_311
			when 312 then
					--|#line 1571 "eiffel.y"
				yy_do_action_312
			when 313 then
					--|#line 1573 "eiffel.y"
				yy_do_action_313
			when 314 then
					--|#line 1575 "eiffel.y"
				yy_do_action_314
			when 315 then
					--|#line 1577 "eiffel.y"
				yy_do_action_315
			when 316 then
					--|#line 1579 "eiffel.y"
				yy_do_action_316
			when 317 then
					--|#line 1581 "eiffel.y"
				yy_do_action_317
			when 318 then
					--|#line 1583 "eiffel.y"
				yy_do_action_318
			when 319 then
					--|#line 1585 "eiffel.y"
				yy_do_action_319
			when 320 then
					--|#line 1589 "eiffel.y"
				yy_do_action_320
			when 321 then
					--|#line 1598 "eiffel.y"
				yy_do_action_321
			when 322 then
					--|#line 1600 "eiffel.y"
				yy_do_action_322
			when 323 then
					--|#line 1604 "eiffel.y"
				yy_do_action_323
			when 324 then
					--|#line 1606 "eiffel.y"
				yy_do_action_324
			when 325 then
					--|#line 1617 "eiffel.y"
				yy_do_action_325
			when 326 then
					--|#line 1619 "eiffel.y"
				yy_do_action_326
			when 327 then
					--|#line 1623 "eiffel.y"
				yy_do_action_327
			when 328 then
					--|#line 1625 "eiffel.y"
				yy_do_action_328
			when 329 then
					--|#line 1629 "eiffel.y"
				yy_do_action_329
			when 330 then
					--|#line 1631 "eiffel.y"
				yy_do_action_330
			when 331 then
					--|#line 1639 "eiffel.y"
				yy_do_action_331
			when 332 then
					--|#line 1641 "eiffel.y"
				yy_do_action_332
			when 333 then
					--|#line 1643 "eiffel.y"
				yy_do_action_333
			when 334 then
					--|#line 1645 "eiffel.y"
				yy_do_action_334
			when 335 then
					--|#line 1647 "eiffel.y"
				yy_do_action_335
			when 336 then
					--|#line 1649 "eiffel.y"
				yy_do_action_336
			when 337 then
					--|#line 1651 "eiffel.y"
				yy_do_action_337
			when 338 then
					--|#line 1653 "eiffel.y"
				yy_do_action_338
			when 339 then
					--|#line 1655 "eiffel.y"
				yy_do_action_339
			when 340 then
					--|#line 1659 "eiffel.y"
				yy_do_action_340
			when 341 then
					--|#line 1667 "eiffel.y"
				yy_do_action_341
			when 342 then
					--|#line 1669 "eiffel.y"
				yy_do_action_342
			when 343 then
					--|#line 1671 "eiffel.y"
				yy_do_action_343
			when 344 then
					--|#line 1673 "eiffel.y"
				yy_do_action_344
			when 345 then
					--|#line 1675 "eiffel.y"
				yy_do_action_345
			when 346 then
					--|#line 1677 "eiffel.y"
				yy_do_action_346
			when 347 then
					--|#line 1679 "eiffel.y"
				yy_do_action_347
			when 348 then
					--|#line 1681 "eiffel.y"
				yy_do_action_348
			when 349 then
					--|#line 1683 "eiffel.y"
				yy_do_action_349
			when 350 then
					--|#line 1685 "eiffel.y"
				yy_do_action_350
			when 351 then
					--|#line 1687 "eiffel.y"
				yy_do_action_351
			when 352 then
					--|#line 1689 "eiffel.y"
				yy_do_action_352
			when 353 then
					--|#line 1691 "eiffel.y"
				yy_do_action_353
			when 354 then
					--|#line 1693 "eiffel.y"
				yy_do_action_354
			when 355 then
					--|#line 1695 "eiffel.y"
				yy_do_action_355
			when 356 then
					--|#line 1697 "eiffel.y"
				yy_do_action_356
			when 357 then
					--|#line 1699 "eiffel.y"
				yy_do_action_357
			when 358 then
					--|#line 1701 "eiffel.y"
				yy_do_action_358
			when 359 then
					--|#line 1703 "eiffel.y"
				yy_do_action_359
			when 360 then
					--|#line 1705 "eiffel.y"
				yy_do_action_360
			when 361 then
					--|#line 1707 "eiffel.y"
				yy_do_action_361
			when 362 then
					--|#line 1709 "eiffel.y"
				yy_do_action_362
			when 363 then
					--|#line 1711 "eiffel.y"
				yy_do_action_363
			when 364 then
					--|#line 1713 "eiffel.y"
				yy_do_action_364
			when 365 then
					--|#line 1715 "eiffel.y"
				yy_do_action_365
			when 366 then
					--|#line 1717 "eiffel.y"
				yy_do_action_366
			when 367 then
					--|#line 1719 "eiffel.y"
				yy_do_action_367
			when 368 then
					--|#line 1721 "eiffel.y"
				yy_do_action_368
			when 369 then
					--|#line 1723 "eiffel.y"
				yy_do_action_369
			when 370 then
					--|#line 1725 "eiffel.y"
				yy_do_action_370
			when 371 then
					--|#line 1727 "eiffel.y"
				yy_do_action_371
			when 372 then
					--|#line 1729 "eiffel.y"
				yy_do_action_372
			when 373 then
					--|#line 1731 "eiffel.y"
				yy_do_action_373
			when 374 then
					--|#line 1733 "eiffel.y"
				yy_do_action_374
			when 375 then
					--|#line 1735 "eiffel.y"
				yy_do_action_375
			when 376 then
					--|#line 1737 "eiffel.y"
				yy_do_action_376
			when 377 then
					--|#line 1739 "eiffel.y"
				yy_do_action_377
			when 378 then
					--|#line 1743 "eiffel.y"
				yy_do_action_378
			when 379 then
					--|#line 1751 "eiffel.y"
				yy_do_action_379
			when 380 then
					--|#line 1753 "eiffel.y"
				yy_do_action_380
			when 381 then
					--|#line 1755 "eiffel.y"
				yy_do_action_381
			when 382 then
					--|#line 1757 "eiffel.y"
				yy_do_action_382
			when 383 then
					--|#line 1759 "eiffel.y"
				yy_do_action_383
			when 384 then
					--|#line 1761 "eiffel.y"
				yy_do_action_384
			when 385 then
					--|#line 1763 "eiffel.y"
				yy_do_action_385
			when 386 then
					--|#line 1765 "eiffel.y"
				yy_do_action_386
			when 387 then
					--|#line 1767 "eiffel.y"
				yy_do_action_387
			when 388 then
					--|#line 1769 "eiffel.y"
				yy_do_action_388
			when 389 then
					--|#line 1771 "eiffel.y"
				yy_do_action_389
			when 390 then
					--|#line 1773 "eiffel.y"
				yy_do_action_390
			when 391 then
					--|#line 1777 "eiffel.y"
				yy_do_action_391
			when 392 then
					--|#line 1781 "eiffel.y"
				yy_do_action_392
			when 393 then
					--|#line 1785 "eiffel.y"
				yy_do_action_393
			when 394 then
					--|#line 1789 "eiffel.y"
				yy_do_action_394
			when 395 then
					--|#line 1793 "eiffel.y"
				yy_do_action_395
			when 396 then
					--|#line 1797 "eiffel.y"
				yy_do_action_396
			when 397 then
					--|#line 1799 "eiffel.y"
				yy_do_action_397
			when 398 then
					--|#line 1801 "eiffel.y"
				yy_do_action_398
			when 399 then
					--|#line 1803 "eiffel.y"
				yy_do_action_399
			when 400 then
					--|#line 1807 "eiffel.y"
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
					--|#line 1818 "eiffel.y"
				yy_do_action_402
			when 403 then
					--|#line 1826 "eiffel.y"
				yy_do_action_403
			when 404 then
					--|#line 1828 "eiffel.y"
				yy_do_action_404
			when 405 then
					--|#line 1832 "eiffel.y"
				yy_do_action_405
			when 406 then
					--|#line 1834 "eiffel.y"
				yy_do_action_406
			when 407 then
					--|#line 1838 "eiffel.y"
				yy_do_action_407
			when 408 then
					--|#line 1840 "eiffel.y"
				yy_do_action_408
			when 409 then
					--|#line 1842 "eiffel.y"
				yy_do_action_409
			when 410 then
					--|#line 1846 "eiffel.y"
				yy_do_action_410
			when 411 then
					--|#line 1859 "eiffel.y"
				yy_do_action_411
			when 412 then
					--|#line 1863 "eiffel.y"
				yy_do_action_412
			when 413 then
					--|#line 1865 "eiffel.y"
				yy_do_action_413
			when 414 then
					--|#line 1867 "eiffel.y"
				yy_do_action_414
			when 415 then
					--|#line 1871 "eiffel.y"
				yy_do_action_415
			when 416 then
					--|#line 1876 "eiffel.y"
				yy_do_action_416
			when 417 then
					--|#line 1883 "eiffel.y"
				yy_do_action_417
			when 418 then
					--|#line 1885 "eiffel.y"
				yy_do_action_418
			when 419 then
					--|#line 1889 "eiffel.y"
				yy_do_action_419
			when 420 then
					--|#line 1894 "eiffel.y"
				yy_do_action_420
			when 421 then
					--|#line 1905 "eiffel.y"
				yy_do_action_421
			when 422 then
					--|#line 1914 "eiffel.y"
				yy_do_action_422
			when 423 then
					--|#line 1916 "eiffel.y"
				yy_do_action_423
			when 424 then
					--|#line 1918 "eiffel.y"
				yy_do_action_424
			when 425 then
					--|#line 1920 "eiffel.y"
				yy_do_action_425
			when 426 then
					--|#line 1922 "eiffel.y"
				yy_do_action_426
			when 427 then
					--|#line 1924 "eiffel.y"
				yy_do_action_427
			when 428 then
					--|#line 1928 "eiffel.y"
				yy_do_action_428
			when 429 then
					--|#line 1930 "eiffel.y"
				yy_do_action_429
			when 430 then
					--|#line 1932 "eiffel.y"
				yy_do_action_430
			when 431 then
					--|#line 1947 "eiffel.y"
				yy_do_action_431
			when 432 then
					--|#line 1949 "eiffel.y"
				yy_do_action_432
			when 433 then
					--|#line 1951 "eiffel.y"
				yy_do_action_433
			when 434 then
					--|#line 1953 "eiffel.y"
				yy_do_action_434
			when 435 then
					--|#line 1960 "eiffel.y"
				yy_do_action_435
			when 436 then
					--|#line 1962 "eiffel.y"
				yy_do_action_436
			when 437 then
					--|#line 1966 "eiffel.y"
				yy_do_action_437
			when 438 then
					--|#line 1973 "eiffel.y"
				yy_do_action_438
			when 439 then
					--|#line 1988 "eiffel.y"
				yy_do_action_439
			when 440 then
					--|#line 2003 "eiffel.y"
				yy_do_action_440
			when 441 then
					--|#line 2021 "eiffel.y"
				yy_do_action_441
			when 442 then
					--|#line 2023 "eiffel.y"
				yy_do_action_442
			when 443 then
					--|#line 2025 "eiffel.y"
				yy_do_action_443
			when 444 then
					--|#line 2032 "eiffel.y"
				yy_do_action_444
			when 445 then
					--|#line 2036 "eiffel.y"
				yy_do_action_445
			when 446 then
					--|#line 2038 "eiffel.y"
				yy_do_action_446
			when 447 then
					--|#line 2040 "eiffel.y"
				yy_do_action_447
			when 448 then
					--|#line 2044 "eiffel.y"
				yy_do_action_448
			when 449 then
					--|#line 2046 "eiffel.y"
				yy_do_action_449
			when 450 then
					--|#line 2048 "eiffel.y"
				yy_do_action_450
			when 451 then
					--|#line 2050 "eiffel.y"
				yy_do_action_451
			when 452 then
					--|#line 2052 "eiffel.y"
				yy_do_action_452
			when 453 then
					--|#line 2054 "eiffel.y"
				yy_do_action_453
			when 454 then
					--|#line 2056 "eiffel.y"
				yy_do_action_454
			when 455 then
					--|#line 2058 "eiffel.y"
				yy_do_action_455
			when 456 then
					--|#line 2060 "eiffel.y"
				yy_do_action_456
			when 457 then
					--|#line 2062 "eiffel.y"
				yy_do_action_457
			when 458 then
					--|#line 2064 "eiffel.y"
				yy_do_action_458
			when 459 then
					--|#line 2066 "eiffel.y"
				yy_do_action_459
			when 460 then
					--|#line 2068 "eiffel.y"
				yy_do_action_460
			when 461 then
					--|#line 2070 "eiffel.y"
				yy_do_action_461
			when 462 then
					--|#line 2072 "eiffel.y"
				yy_do_action_462
			when 463 then
					--|#line 2074 "eiffel.y"
				yy_do_action_463
			when 464 then
					--|#line 2076 "eiffel.y"
				yy_do_action_464
			when 465 then
					--|#line 2078 "eiffel.y"
				yy_do_action_465
			when 466 then
					--|#line 2080 "eiffel.y"
				yy_do_action_466
			when 467 then
					--|#line 2082 "eiffel.y"
				yy_do_action_467
			when 468 then
					--|#line 2084 "eiffel.y"
				yy_do_action_468
			when 469 then
					--|#line 2088 "eiffel.y"
				yy_do_action_469
			when 470 then
					--|#line 2090 "eiffel.y"
				yy_do_action_470
			when 471 then
					--|#line 2092 "eiffel.y"
				yy_do_action_471
			when 472 then
					--|#line 2094 "eiffel.y"
				yy_do_action_472
			when 473 then
					--|#line 2098 "eiffel.y"
				yy_do_action_473
			when 474 then
					--|#line 2100 "eiffel.y"
				yy_do_action_474
			when 475 then
					--|#line 2102 "eiffel.y"
				yy_do_action_475
			when 476 then
					--|#line 2104 "eiffel.y"
				yy_do_action_476
			when 477 then
					--|#line 2106 "eiffel.y"
				yy_do_action_477
			when 478 then
					--|#line 2108 "eiffel.y"
				yy_do_action_478
			when 479 then
					--|#line 2110 "eiffel.y"
				yy_do_action_479
			when 480 then
					--|#line 2112 "eiffel.y"
				yy_do_action_480
			when 481 then
					--|#line 2114 "eiffel.y"
				yy_do_action_481
			when 482 then
					--|#line 2116 "eiffel.y"
				yy_do_action_482
			when 483 then
					--|#line 2118 "eiffel.y"
				yy_do_action_483
			when 484 then
					--|#line 2120 "eiffel.y"
				yy_do_action_484
			when 485 then
					--|#line 2122 "eiffel.y"
				yy_do_action_485
			when 486 then
					--|#line 2124 "eiffel.y"
				yy_do_action_486
			when 487 then
					--|#line 2126 "eiffel.y"
				yy_do_action_487
			when 488 then
					--|#line 2128 "eiffel.y"
				yy_do_action_488
			when 489 then
					--|#line 2130 "eiffel.y"
				yy_do_action_489
			when 490 then
					--|#line 2132 "eiffel.y"
				yy_do_action_490
			when 491 then
					--|#line 2136 "eiffel.y"
				yy_do_action_491
			when 492 then
					--|#line 2140 "eiffel.y"
				yy_do_action_492
			when 493 then
					--|#line 2144 "eiffel.y"
				yy_do_action_493
			when 494 then
					--|#line 2148 "eiffel.y"
				yy_do_action_494
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
			--|#line 189 "eiffel.y"
		do
--|#line 189 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 189")
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
			--|#line 198 "eiffel.y"
		do
--|#line 198 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 198")
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

	yy_do_action_5 is
			--|#line 241 "eiffel.y"
		do
--|#line 241 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 241")
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
			--|#line 250 "eiffel.y"
		local
			yyval91: PAIR [ID_AS, CLICK_AST]
		do
--|#line 250 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 250")
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

	yy_do_action_7 is
			--|#line 258 "eiffel.y"
		local
			yyval91: PAIR [ID_AS, CLICK_AST]
		do
--|#line 258 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 258")
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

	yy_do_action_8 is
			--|#line 270 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 270 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 270")
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

	yy_do_action_9 is
			--|#line 272 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 272 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 272")
end


yyval80 := yytype80 (yyvs.item (yyvsp)) 
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_10 is
			--|#line 274 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 274 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 274")
end



			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_11 is
			--|#line 278 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 278 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 278")
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

	yy_do_action_12 is
			--|#line 280 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 280 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 280")
end


yyval80 := yytype80 (yyvs.item (yyvsp)) 
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_13 is
			--|#line 282 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 282 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 282")
end


yyval80 := Void 
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_14 is
			--|#line 286 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 286 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 286")
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

	yy_do_action_15 is
			--|#line 288 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 288 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 288")
end


yyval80 := yytype80 (yyvs.item (yyvsp - 1)) 
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_16 is
			--|#line 290 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 290 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 290")
end


yyval80 := Void 
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_17 is
			--|#line 294 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 294 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 294")
end


				yyval80 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval80.extend (yytype34 (yyvs.item (yyvsp)))
			
			yyval := yyval80
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_18 is
			--|#line 299 "eiffel.y"
		local
			yyval80: INDEXING_CLAUSE_AS
		do
--|#line 299 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 299")
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

	yy_do_action_19 is
			--|#line 306 "eiffel.y"
		local
			yyval34: INDEX_AS
		do
--|#line 306 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 306")
end


yyval34 := new_index_as (yytype32 (yyvs.item (yyvsp - 2)), yytype65 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval34
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_20 is
			--|#line 310 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 310 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 310")
end


yyval32 := yytype32 (yyvs.item (yyvsp - 1)) 
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_21 is
			--|#line 312 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 312 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 312")
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

	yy_do_action_22 is
			--|#line 324 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 324 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 324")
end


				yyval65 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval65.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval65
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_23 is
			--|#line 329 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 329 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 329")
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

	yy_do_action_24 is
			--|#line 334 "eiffel.y"
		local
			yyval65: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 334 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 334")
end


-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval65 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval65
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_25 is
			--|#line 341 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 341 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 341")
end


yyval7 := yytype32 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_26 is
			--|#line 343 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 343 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 343")
end


yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_27 is
			--|#line 345 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 345 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 345")
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
			--|#line 349 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 349 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 349")
end


				create {CUSTOM_ATTRIBUTE_AS} yyval7.initialize (yytype20 (yyvs.item (yyvsp - 2)), yytype61 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_29 is
			--|#line 359 "eiffel.y"
		do
--|#line 359 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 359")
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
			--|#line 365 "eiffel.y"
		do
--|#line 365 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 365")
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
			--|#line 372 "eiffel.y"
		do
--|#line 372 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 372")
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
			--|#line 378 "eiffel.y"
		do
--|#line 378 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 378")
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
			--|#line 386 "eiffel.y"
		do
--|#line 386 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 386")
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
			--|#line 390 "eiffel.y"
		do
--|#line 390 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 390")
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
			--|#line 401 "eiffel.y"
		do
--|#line 401 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 401")
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
			--|#line 405 "eiffel.y"
		do
--|#line 405 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 405")
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
			--|#line 420 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 420 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 420")
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

	yy_do_action_38 is
			--|#line 422 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 422 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 422")
end


yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_39 is
			--|#line 429 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 429 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 429")
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

	yy_do_action_40 is
			--|#line 431 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 431 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 431")
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

	yy_do_action_41 is
			--|#line 440 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 440 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 440")
end


				yyval73 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval73, yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval73
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_42 is
			--|#line 445 "eiffel.y"
		local
			yyval73: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line 445 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 445")
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

	yy_do_action_43 is
			--|#line 452 "eiffel.y"
		local
			yyval29: FEATURE_CLAUSE_AS
		do
--|#line 452 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 452")
end


yyval29 := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) 
			yyval := yyval29
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_44 is
			--|#line 454 "eiffel.y"
		local
			yyval29: FEATURE_CLAUSE_AS
		do
--|#line 454 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 454")
end


yyval29 := new_feature_clause_as (yytype15 (yyvs.item (yyvsp - 1)), yytype72 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval29
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_45 is
			--|#line 458 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 458 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 458")
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
			--|#line 458 "eiffel.y"
		do
--|#line 458 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 458")
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
			--|#line 467 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 467 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 467")
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
			--|#line 469 "eiffel.y"
		local
			yyval15: CLIENT_AS
		do
--|#line 469 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 469")
end


yyval15 := new_client_as (yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval15
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_49 is
			--|#line 473 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [ID_AS]
		do
--|#line 473 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 473")
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

	yy_do_action_50 is
			--|#line 478 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [ID_AS]
		do
--|#line 478 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 478")
end


yyval77 := yytype77 (yyvs.item (yyvsp - 1)) 
			yyval := yyval77
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_51 is
			--|#line 482 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [ID_AS]
		do
--|#line 482 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 482")
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

	yy_do_action_52 is
			--|#line 488 "eiffel.y"
		local
			yyval77: EIFFEL_LIST [ID_AS]
		do
--|#line 488 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 488")
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

	yy_do_action_53 is
			--|#line 496 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_AS]
		do
--|#line 496 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 496")
end


				yyval72 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval72.extend (yytype28 (yyvs.item (yyvsp)))
			
			yyval := yyval72
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_54 is
			--|#line 501 "eiffel.y"
		local
			yyval72: EIFFEL_LIST [FEATURE_AS]
		do
--|#line 501 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 501")
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

	yy_do_action_55 is
			--|#line 508 "eiffel.y"
		do
--|#line 508 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 508")
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
			--|#line 509 "eiffel.y"
		do
--|#line 509 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 509")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_57 is
			--|#line 512 "eiffel.y"
		local
			yyval28: FEATURE_AS
		do
--|#line 512 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 512")
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

	yy_do_action_58 is
			--|#line 525 "eiffel.y"
		local
			yyval94: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
--|#line 525 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 525")
end


yyval94 := new_clickable_feature_name_list (yytype92 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval94
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_59 is
			--|#line 527 "eiffel.y"
		local
			yyval94: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
--|#line 527 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 527")
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

	yy_do_action_60 is
			--|#line 534 "eiffel.y"
		local
			yyval92: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 534 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 534")
end


yyval92 := yytype92 (yyvs.item (yyvsp)) 
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_61 is
			--|#line 538 "eiffel.y"
		do
--|#line 538 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 538")
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
			--|#line 540 "eiffel.y"
		do
--|#line 540 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 540")
end

			yyval := yyval_default;
is_frozen := True 

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_63 is
			--|#line 544 "eiffel.y"
		local
			yyval92: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 544 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 544")
end


yyval92 := new_clickable_feature_name (yytype91 (yyvs.item (yyvsp))) 
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_64 is
			--|#line 546 "eiffel.y"
		local
			yyval92: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 546 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 546")
end


yyval92 := yytype92 (yyvs.item (yyvsp)) 
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_65 is
			--|#line 548 "eiffel.y"
		local
			yyval92: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 548 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 548")
end


yyval92 := yytype92 (yyvs.item (yyvsp)) 
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_66 is
			--|#line 552 "eiffel.y"
		local
			yyval92: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 552 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 552")
end


yyval92 := new_clickable_infix (yytype93 (yyvs.item (yyvsp))) 
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_67 is
			--|#line 557 "eiffel.y"
		local
			yyval92: PAIR [FEATURE_NAME, CLICK_AST]
		do
--|#line 557 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 557")
end


yyval92 := new_clickable_prefix (yytype93 (yyvs.item (yyvsp))) 
			yyval := yyval92
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_68 is
			--|#line 561 "eiffel.y"
		local
			yyval9: BODY_AS
		do
--|#line 561 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 561")
end


yyval9 := new_declaration_body (yytype89 (yyvs.item (yyvsp - 2)), yytype62 (yyvs.item (yyvsp - 1)), yytype16 (yyvs.item (yyvsp))) 
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_69 is
			--|#line 565 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 565 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 565")
end


feature_indexes := yytype80 (yyvs.item (yyvsp)) 
			yyval := yyval16
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_70 is
			--|#line 567 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 567 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 567")
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
			--|#line 571 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 571 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 571")
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

	yy_do_action_72 is
			--|#line 576 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 576 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 576")
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

	yy_do_action_73 is
			--|#line 581 "eiffel.y"
		local
			yyval16: CONTENT_AS
		do
--|#line 581 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 581")
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

	yy_do_action_74 is
			--|#line 592 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [PARENT_AS]
		do
--|#line 592 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 592")
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

	yy_do_action_75 is
			--|#line 594 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [PARENT_AS]
		do
--|#line 594 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 594")
end


yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_76 is
			--|#line 596 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [PARENT_AS]
		do
--|#line 596 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 596")
end


yyval84 := new_eiffel_list_parent_as (0) 
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_77 is
			--|#line 600 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [PARENT_AS]
		do
--|#line 600 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 600")
end


				yyval84 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval84.extend (yytype46 (yyvs.item (yyvsp)))
			
			yyval := yyval84
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_78 is
			--|#line 605 "eiffel.y"
		local
			yyval84: EIFFEL_LIST [PARENT_AS]
		do
--|#line 605 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 605")
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

	yy_do_action_79 is
			--|#line 612 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 612 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 612")
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

	yy_do_action_80 is
			--|#line 617 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 617 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 617")
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

	yy_do_action_81 is
			--|#line 625 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 625 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 625")
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

	yy_do_action_82 is
			--|#line 630 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 630 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 630")
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

	yy_do_action_83 is
			--|#line 635 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 635 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 635")
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

	yy_do_action_84 is
			--|#line 640 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 640 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 640")
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

	yy_do_action_85 is
			--|#line 645 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 645 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 645")
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

	yy_do_action_86 is
			--|#line 650 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 650 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 650")
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

	yy_do_action_87 is
			--|#line 655 "eiffel.y"
		local
			yyval46: PARENT_AS
		do
--|#line 655 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 655")
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

	yy_do_action_88 is
			--|#line 663 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [RENAME_AS]
		do
--|#line 663 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 663")
end



			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_89 is
			--|#line 665 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [RENAME_AS]
		do
--|#line 665 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 665")
end


yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_90 is
			--|#line 669 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [RENAME_AS]
		do
--|#line 669 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 669")
end


				yyval85 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval85.extend (yytype50 (yyvs.item (yyvsp)))
			
			yyval := yyval85
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_91 is
			--|#line 674 "eiffel.y"
		local
			yyval85: EIFFEL_LIST [RENAME_AS]
		do
--|#line 674 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 674")
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

	yy_do_action_92 is
			--|#line 681 "eiffel.y"
		local
			yyval50: RENAME_AS
		do
--|#line 681 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 681")
end


yyval50 := new_rename_pair (yytype92 (yyvs.item (yyvsp - 2)), yytype92 (yyvs.item (yyvsp))) 
			yyval := yyval50
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_93 is
			--|#line 685 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 685 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 685")
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

	yy_do_action_94 is
			--|#line 687 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 687 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 687")
end


yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_95 is
			--|#line 691 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 691 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 691")
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

	yy_do_action_96 is
			--|#line 699 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 699 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 699")
end



			yyval := yyval70
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
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

	yy_do_action_98 is
			--|#line 710 "eiffel.y"
		local
			yyval70: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line 710 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 710")
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

	yy_do_action_99 is
			--|#line 719 "eiffel.y"
		local
			yyval24: EXPORT_ITEM_AS
		do
--|#line 719 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 719")
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

	yy_do_action_100 is
			--|#line 727 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 727 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 727")
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
			--|#line 729 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 729 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 729")
end


yyval30 := new_all_as 
			yyval := yyval30
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_102 is
			--|#line 731 "eiffel.y"
		local
			yyval30: FEATURE_SET_AS
		do
--|#line 731 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 731")
end


yyval30 := new_feature_list_as (yytype75 (yyvs.item (yyvsp))) 
			yyval := yyval30
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_103 is
			--|#line 735 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 735 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 735")
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

	yy_do_action_104 is
			--|#line 737 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 737 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 737")
end


			yyval67 := yytype67 (yyvs.item (yyvsp))
		
			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_105 is
			--|#line 743 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 743 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 743")
end


			yyval67 := new_eiffel_list_convert (Initial_convert_list_size)
			yyval67.extend (yytype17 (yyvs.item (yyvsp)))
		
			yyval := yyval67
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_106 is
			--|#line 748 "eiffel.y"
		local
			yyval67: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line 748 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 748")
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

	yy_do_action_107 is
			--|#line 756 "eiffel.y"
		local
			yyval17: CONVERT_FEAT_AS
		do
--|#line 756 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 756")
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

	yy_do_action_108 is
			--|#line 762 "eiffel.y"
		local
			yyval17: CONVERT_FEAT_AS
		do
--|#line 762 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 762")
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

	yy_do_action_109 is
			--|#line 770 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 770 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 770")
end


				yyval75 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval75.extend (yytype92 (yyvs.item (yyvsp)).first)
			
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
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


				yyval75 := yytype75 (yyvs.item (yyvsp - 2))
				yyval75.extend (yytype92 (yyvs.item (yyvsp)).first)
			
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_111 is
			--|#line 782 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 782 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 782")
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

	yy_do_action_112 is
			--|#line 784 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 784 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 784")
end


yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_113 is
			--|#line 788 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 788 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 788")
end



			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_114 is
			--|#line 790 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 790 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 790")
end


yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_115 is
			--|#line 794 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 794 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 794")
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

	yy_do_action_116 is
			--|#line 796 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 796 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 796")
end


yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_117 is
			--|#line 800 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 800 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 800")
end



			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_118 is
			--|#line 802 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 802 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 802")
end


yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_119 is
			--|#line 806 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 806 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 806")
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

	yy_do_action_120 is
			--|#line 808 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 808 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 808")
end


yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_121 is
			--|#line 812 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 812 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 812")
end



			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_122 is
			--|#line 814 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 814 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 814")
end


yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_123 is
			--|#line 822 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 822 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 822")
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

	yy_do_action_124 is
			--|#line 824 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 824 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 824")
end


yyval89 := yytype89 (yyvs.item (yyvsp - 1)) 
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_125 is
			--|#line 828 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 828 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 828")
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

	yy_do_action_126 is
			--|#line 830 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 830 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 830")
end


yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_127 is
			--|#line 834 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 834 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 834")
end


				yyval89 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval89.extend (yytype63 (yyvs.item (yyvsp)))
			
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_128 is
			--|#line 839 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 839 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 839")
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

	yy_do_action_129 is
			--|#line 846 "eiffel.y"
		local
			yyval63: TYPE_DEC_AS
		do
--|#line 846 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 846")
end


yyval63 := new_type_dec_as (yytype79 (yyvs.item (yyvsp - 5)), yytype62 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 4))) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_130 is
			--|#line 850 "eiffel.y"
		do
--|#line 850 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 850")
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
			--|#line 851 "eiffel.y"
		do
--|#line 851 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 851")
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
			--|#line 860 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 860 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 860")
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

	yy_do_action_133 is
			--|#line 862 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 862 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 862")
end


yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_134 is
			--|#line 866 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 866 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 866")
end


				yyval89 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval89.extend (yytype63 (yyvs.item (yyvsp)))
			
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_135 is
			--|#line 871 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 871 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 871")
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

	yy_do_action_136 is
			--|#line 878 "eiffel.y"
		local
			yyval63: TYPE_DEC_AS
		do
--|#line 878 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 878")
end


yyval63 := new_type_dec_as (yytype79 (yyvs.item (yyvsp - 4)), yytype62 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval63
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_137 is
			--|#line 882 "eiffel.y"
		local
			yyval79: ARRAYED_LIST [INTEGER]
		do
--|#line 882 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 882")
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

	yy_do_action_138 is
			--|#line 888 "eiffel.y"
		local
			yyval79: ARRAYED_LIST [INTEGER]
		do
--|#line 888 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 888")
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

	yy_do_action_139 is
			--|#line 896 "eiffel.y"
		local
			yyval79: ARRAYED_LIST [INTEGER]
		do
--|#line 896 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 896")
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

	yy_do_action_140 is
			--|#line 898 "eiffel.y"
		local
			yyval79: ARRAYED_LIST [INTEGER]
		do
--|#line 898 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 898")
end


yyval79 := yytype79 (yyvs.item (yyvsp)) 
			yyval := yyval79
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_141 is
			--|#line 902 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 902 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 902")
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

	yy_do_action_142 is
			--|#line 904 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 904 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 904")
end


yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_143 is
			--|#line 908 "eiffel.y"
		local
			yyval55: ROUTINE_AS
		do
--|#line 908 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 908")
end


yyval55 := new_routine_as (yytype59 (yyvs.item (yyvsp - 7)), yytype51 (yyvs.item (yyvsp - 5)), yytype89 (yyvs.item (yyvsp - 4)), yytype54 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp - 2)), yytype81 (yyvs.item (yyvsp - 1)), fbody_pos, current_position) 
			yyval := yyval55
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_144 is
			--|#line 908 "eiffel.y"
		do
--|#line 908 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 908")
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
			--|#line 920 "eiffel.y"
		local
			yyval54: ROUT_BODY_AS
		do
--|#line 920 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 920")
end


yyval54 := yytype39 (yyvs.item (yyvsp)) 
			yyval := yyval54
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_146 is
			--|#line 922 "eiffel.y"
		local
			yyval54: ROUT_BODY_AS
		do
--|#line 922 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 922")
end


yyval54 := yytype26 (yyvs.item (yyvsp)) 
			yyval := yyval54
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_147 is
			--|#line 924 "eiffel.y"
		local
			yyval54: ROUT_BODY_AS
		do
--|#line 924 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 924")
end


yyval54 := new_deferred_as 
			yyval := yyval54
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_148 is
			--|#line 928 "eiffel.y"
		local
			yyval26: EXTERNAL_AS
		do
--|#line 928 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 928")
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

	yy_do_action_149 is
			--|#line 935 "eiffel.y"
		local
			yyval27: EXTERNAL_LANG_AS
		do
--|#line 935 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 935")
end


yyval27 := new_external_lang_as (yytype59 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval27
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_150 is
			--|#line 940 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 940 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 940")
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

	yy_do_action_151 is
			--|#line 942 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 942 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 942")
end


yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_152 is
			--|#line 946 "eiffel.y"
		local
			yyval39: INTERNAL_AS
		do
--|#line 946 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 946")
end


yyval39 := new_do_as (yytype81 (yyvs.item (yyvsp))) 
			yyval := yyval39
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_153 is
			--|#line 948 "eiffel.y"
		local
			yyval39: INTERNAL_AS
		do
--|#line 948 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 948")
end


yyval39 := new_once_as (yytype81 (yyvs.item (yyvsp))) 
			yyval := yyval39
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_154 is
			--|#line 952 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 952 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 952")
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

	yy_do_action_155 is
			--|#line 954 "eiffel.y"
		local
			yyval89: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line 954 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 954")
end


yyval89 := yytype89 (yyvs.item (yyvsp)) 
			yyval := yyval89
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_156 is
			--|#line 958 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 958 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 958")
end



			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_157 is
			--|#line 960 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 960 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 960")
end


yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_158 is
			--|#line 964 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 964 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 964")
end


				yyval81 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval81.extend (yytype37 (yyvs.item (yyvsp)))
			
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_159 is
			--|#line 969 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 969 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 969")
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

	yy_do_action_160 is
			--|#line 976 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 976 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 976")
end


yyval37 := yytype37 (yyvs.item (yyvsp - 1)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_161 is
			--|#line 980 "eiffel.y"
		do
--|#line 980 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 980")
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
			--|#line 981 "eiffel.y"
		do
--|#line 981 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 981")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_163 is
			--|#line 984 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 984 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 984")
end


yyval37 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_164 is
			--|#line 986 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 986 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 986")
end


yyval37 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_165 is
			--|#line 988 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 988 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 988")
end


yyval37 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_166 is
			--|#line 990 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 990 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 990")
end


yyval37 := yytype53 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_167 is
			--|#line 992 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 992 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 992")
end


yyval37 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_168 is
			--|#line 994 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 994 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 994")
end


yyval37 := yytype35 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_169 is
			--|#line 996 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 996 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 996")
end


yyval37 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_170 is
			--|#line 998 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 998 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 998")
end


yyval37 := yytype21 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_171 is
			--|#line 1000 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 1000 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1000")
end


yyval37 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_172 is
			--|#line 1002 "eiffel.y"
		local
			yyval37: INSTRUCTION_AS
		do
--|#line 1002 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1002")
end


yyval37 := yytype52 (yyvs.item (yyvsp)) 
			yyval := yyval37
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_173 is
			--|#line 1006 "eiffel.y"
		local
			yyval51: REQUIRE_AS
		do
--|#line 1006 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1006")
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

	yy_do_action_174 is
			--|#line 1008 "eiffel.y"
		local
			yyval51: REQUIRE_AS
		do
--|#line 1008 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1008")
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

	yy_do_action_175 is
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

	yy_do_action_176 is
			--|#line 1015 "eiffel.y"
		local
			yyval51: REQUIRE_AS
		do
--|#line 1015 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1015")
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

	yy_do_action_177 is
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

	yy_do_action_178 is
			--|#line 1024 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1024 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1024")
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
			--|#line 1026 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1026 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1026")
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

	yy_do_action_180 is
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

	yy_do_action_181 is
			--|#line 1033 "eiffel.y"
		local
			yyval23: ENSURE_AS
		do
--|#line 1033 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1033")
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

	yy_do_action_182 is
			--|#line 1033 "eiffel.y"
		do
--|#line 1033 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1033")
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
			--|#line 1042 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1042 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1042")
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

	yy_do_action_184 is
			--|#line 1044 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1044 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1044")
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

	yy_do_action_185 is
			--|#line 1053 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1053 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1053")
end


				yyval87 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval87, yytype60 (yyvs.item (yyvsp)))
			
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_186 is
			--|#line 1058 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1058 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1058")
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

	yy_do_action_187 is
			--|#line 1065 "eiffel.y"
		local
			yyval60: TAGGED_AS
		do
--|#line 1065 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1065")
end


yyval60 := yytype60 (yyvs.item (yyvsp - 1)) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_188 is
			--|#line 1069 "eiffel.y"
		local
			yyval60: TAGGED_AS
		do
--|#line 1069 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1069")
end


yyval60 := new_tagged_as (Void, yytype25 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_189 is
			--|#line 1071 "eiffel.y"
		local
			yyval60: TAGGED_AS
		do
--|#line 1071 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1071")
end


yyval60 := new_tagged_as (yytype32 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_190 is
			--|#line 1073 "eiffel.y"
		local
			yyval60: TAGGED_AS
		do
--|#line 1073 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1073")
end



			yyval := yyval60
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_191 is
			--|#line 1081 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1081 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1081")
end


yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_192 is
			--|#line 1083 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1083 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1083")
end


yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_193 is
			--|#line 1087 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1087 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1087")
end


yyval62 := new_class_type (yytype91 (yyvs.item (yyvsp - 1)), yytype88 (yyvs.item (yyvsp)), False, True, False) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_194 is
			--|#line 1089 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1089 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1089")
end


yyval62 := new_class_type (yytype91 (yyvs.item (yyvsp - 1)), yytype88 (yyvs.item (yyvsp)), True, False, False) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_195 is
			--|#line 1091 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1091 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1091")
end


yyval62 := new_class_type (yytype91 (yyvs.item (yyvsp - 1)), yytype88 (yyvs.item (yyvsp)), False, False, True) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_196 is
			--|#line 1093 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1093 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1093")
end


yyval62 := new_bits_as (yytype38 (yyvs.item (yyvsp))) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_197 is
			--|#line 1095 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1095 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1095")
end


yyval62 := new_bits_symbol_as (yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_198 is
			--|#line 1097 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1097 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1097")
end


yyval62 := new_like_id_as (yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_199 is
			--|#line 1099 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1099 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1099")
end


yyval62 := new_like_current_as 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_200 is
			--|#line 1103 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1103 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1103")
end


yyval62 := new_class_type (yytype91 (yyvs.item (yyvsp - 1)), yytype88 (yyvs.item (yyvsp)), False, False, False) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_201 is
			--|#line 1107 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TYPE]
		do
--|#line 1107 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1107")
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

	yy_do_action_202 is
			--|#line 1109 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TYPE]
		do
--|#line 1109 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1109")
end



			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_203 is
			--|#line 1111 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TYPE]
		do
--|#line 1111 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1111")
end


yyval88 := yytype88 (yyvs.item (yyvsp - 1)) 
			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_204 is
			--|#line 1115 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TYPE]
		do
--|#line 1115 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1115")
end



			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_205 is
			--|#line 1117 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TYPE]
		do
--|#line 1117 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1117")
end


yyval88 := yytype88 (yyvs.item (yyvsp - 1)) 
			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_206 is
			--|#line 1121 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TYPE]
		do
--|#line 1121 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1121")
end


				yyval88 := new_eiffel_list_type (Initial_type_list_size)
				yyval88.extend (yytype62 (yyvs.item (yyvsp)))
			
			yyval := yyval88
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_207 is
			--|#line 1126 "eiffel.y"
		local
			yyval88: EIFFEL_LIST [TYPE]
		do
--|#line 1126 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1126")
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

	yy_do_action_208 is
			--|#line 1137 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1137 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1137")
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

	yy_do_action_209 is
			--|#line 1143 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1143 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1143")
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

	yy_do_action_210 is
			--|#line 1151 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1151 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1151")
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

	yy_do_action_211 is
			--|#line 1153 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1153 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1153")
end


yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_212 is
			--|#line 1157 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1157 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1157")
end


				yyval76 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval76.extend (yytype31 (yyvs.item (yyvsp)))
			
			yyval := yyval76
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_213 is
			--|#line 1162 "eiffel.y"
		local
			yyval76: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line 1162 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1162")
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

	yy_do_action_214 is
			--|#line 1169 "eiffel.y"
		local
			yyval31: FORMAL_DEC_AS
		do
--|#line 1169 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1169")
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

	yy_do_action_215 is
			--|#line 1169 "eiffel.y"
		do
--|#line 1169 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1169")
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

	yy_do_action_216 is
			--|#line 1194 "eiffel.y"
		local
			yyval95: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
--|#line 1194 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1194")
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

	yy_do_action_217 is
			--|#line 1196 "eiffel.y"
		local
			yyval95: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
--|#line 1196 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1196")
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

	yy_do_action_218 is
			--|#line 1204 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 1204 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1204")
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

	yy_do_action_219 is
			--|#line 1206 "eiffel.y"
		local
			yyval75: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line 1206 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1206")
end


yyval75 := yytype75 (yyvs.item (yyvsp - 1)) 
			yyval := yyval75
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_220 is
			--|#line 1214 "eiffel.y"
		local
			yyval33: IF_AS
		do
--|#line 1214 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1214")
end


				yyval33 := new_if_as (yytype25 (yyvs.item (yyvsp - 5)), yytype81 (yyvs.item (yyvsp - 3)), yytype69 (yyvs.item (yyvsp - 2)), yytype81 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 7)), current_position)
			
			yyval := yyval33
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_221 is
			--|#line 1220 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1220 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1220")
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

	yy_do_action_222 is
			--|#line 1222 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1222 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1222")
end


yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_223 is
			--|#line 1226 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1226 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1226")
end


				yyval69 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval69.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval69
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_224 is
			--|#line 1231 "eiffel.y"
		local
			yyval69: EIFFEL_LIST [ELSIF_AS]
		do
--|#line 1231 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1231")
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

	yy_do_action_225 is
			--|#line 1238 "eiffel.y"
		local
			yyval22: ELSIF_AS
		do
--|#line 1238 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1238")
end


yyval22 := new_elseif_as (yytype25 (yyvs.item (yyvsp - 2)), yytype81 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 4))) 
			yyval := yyval22
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_226 is
			--|#line 1242 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1242 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1242")
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

	yy_do_action_227 is
			--|#line 1244 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1244 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1244")
end


yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_228 is
			--|#line 1248 "eiffel.y"
		local
			yyval35: INSPECT_AS
		do
--|#line 1248 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1248")
end


				yyval35 := new_inspect_as (yytype25 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp - 2)), yytype81 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval35
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_229 is
			--|#line 1254 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [CASE_AS]
		do
--|#line 1254 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1254")
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

	yy_do_action_230 is
			--|#line 1256 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [CASE_AS]
		do
--|#line 1256 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1256")
end


yyval66 := yytype66 (yyvs.item (yyvsp)) 
			yyval := yyval66
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_231 is
			--|#line 1260 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [CASE_AS]
		do
--|#line 1260 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1260")
end


				yyval66 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval66.extend (yytype12 (yyvs.item (yyvsp)))
			
			yyval := yyval66
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_232 is
			--|#line 1265 "eiffel.y"
		local
			yyval66: EIFFEL_LIST [CASE_AS]
		do
--|#line 1265 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1265")
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

	yy_do_action_233 is
			--|#line 1272 "eiffel.y"
		local
			yyval12: CASE_AS
		do
--|#line 1272 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1272")
end


yyval12 := new_case_as (yytype82 (yyvs.item (yyvsp - 2)), yytype81 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval12
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_234 is
			--|#line 1276 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line 1276 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1276")
end


				yyval82 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval82.extend (yytype40 (yyvs.item (yyvsp)))
			
			yyval := yyval82
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_235 is
			--|#line 1281 "eiffel.y"
		local
			yyval82: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line 1281 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1281")
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

	yy_do_action_236 is
			--|#line 1288 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1288 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1288")
end


yyval40 := new_interval_as (yytype38 (yyvs.item (yyvsp)), Void) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_237 is
			--|#line 1290 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1290 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1290")
end


yyval40 := new_interval_as (yytype38 (yyvs.item (yyvsp - 2)), yytype38 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_238 is
			--|#line 1292 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1292 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1292")
end


yyval40 := new_interval_as (yytype13 (yyvs.item (yyvsp)), Void) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_239 is
			--|#line 1294 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1294 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1294")
end


yyval40 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_240 is
			--|#line 1296 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1296 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1296")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp)), Void) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_241 is
			--|#line 1298 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1298 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1298")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_242 is
			--|#line 1300 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1300 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1300")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp - 2)), yytype38 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_243 is
			--|#line 1302 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1302 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1302")
end


yyval40 := new_interval_as (yytype38 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_244 is
			--|#line 1304 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1304 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1304")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_245 is
			--|#line 1306 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1306 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1306")
end


yyval40 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_246 is
			--|#line 1308 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1308 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1308")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp)), Void) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_247 is
			--|#line 1310 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1310 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1310")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_248 is
			--|#line 1312 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1312 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1312")
end


yyval40 := new_interval_as (yytype32 (yyvs.item (yyvsp - 2)), yytype48 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_249 is
			--|#line 1314 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1314 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1314")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp - 2)), yytype48 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_250 is
			--|#line 1316 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1316 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1316")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp - 2)), yytype38 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_251 is
			--|#line 1318 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1318 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1318")
end


yyval40 := new_interval_as (yytype38 (yyvs.item (yyvsp - 2)), yytype48 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_252 is
			--|#line 1320 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1320 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1320")
end


yyval40 := new_interval_as (yytype48 (yyvs.item (yyvsp - 2)), yytype13 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_253 is
			--|#line 1322 "eiffel.y"
		local
			yyval40: INTERVAL_AS
		do
--|#line 1322 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1322")
end


yyval40 := new_interval_as (yytype13 (yyvs.item (yyvsp - 2)), yytype48 (yyvs.item (yyvsp))) 
			yyval := yyval40
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_254 is
			--|#line 1327 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1327 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1327")
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

	yy_do_action_255 is
			--|#line 1329 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1329 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1329")
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

	yy_do_action_256 is
			--|#line 1338 "eiffel.y"
		local
			yyval42: LOOP_AS
		do
--|#line 1338 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1338")
end


				yyval42 := new_loop_as (yytype81 (yyvs.item (yyvsp - 8)), yytype87 (yyvs.item (yyvsp - 7)), yytype64 (yyvs.item (yyvsp - 6)), yytype25 (yyvs.item (yyvsp - 3)), yytype81 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval42
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 10
	yyvsp := yyvsp - 9
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_257 is
			--|#line 1344 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1344 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1344")
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

	yy_do_action_258 is
			--|#line 1346 "eiffel.y"
		local
			yyval87: EIFFEL_LIST [TAGGED_AS]
		do
--|#line 1346 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1346")
end


yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_259 is
			--|#line 1350 "eiffel.y"
		local
			yyval41: INVARIANT_AS
		do
--|#line 1350 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1350")
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

	yy_do_action_260 is
			--|#line 1352 "eiffel.y"
		local
			yyval41: INVARIANT_AS
		do
--|#line 1352 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1352")
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

	yy_do_action_261 is
			--|#line 1352 "eiffel.y"
		do
--|#line 1352 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1352")
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

	yy_do_action_262 is
			--|#line 1362 "eiffel.y"
		local
			yyval64: VARIANT_AS
		do
--|#line 1362 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1362")
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

	yy_do_action_263 is
			--|#line 1364 "eiffel.y"
		local
			yyval64: VARIANT_AS
		do
--|#line 1364 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1364")
end


yyval64 := new_variant_as (yytype32 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval64
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_264 is
			--|#line 1366 "eiffel.y"
		local
			yyval64: VARIANT_AS
		do
--|#line 1366 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1366")
end


yyval64 := new_variant_as (Void, yytype25 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval64
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_265 is
			--|#line 1370 "eiffel.y"
		local
			yyval21: DEBUG_AS
		do
--|#line 1370 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1370")
end


				yyval21 := new_debug_as (yytype86 (yyvs.item (yyvsp - 2)), yytype81 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 4)), current_position)
			
			yyval := yyval21
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_266 is
			--|#line 1376 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [STRING_AS]
		do
--|#line 1376 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1376")
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

	yy_do_action_267 is
			--|#line 1378 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [STRING_AS]
		do
--|#line 1378 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1378")
end



			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_268 is
			--|#line 1380 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [STRING_AS]
		do
--|#line 1380 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1380")
end


yyval86 := yytype86 (yyvs.item (yyvsp - 1)) 
			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_269 is
			--|#line 1384 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [STRING_AS]
		do
--|#line 1384 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1384")
end


				yyval86 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval86.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval86
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_270 is
			--|#line 1389 "eiffel.y"
		local
			yyval86: EIFFEL_LIST [STRING_AS]
		do
--|#line 1389 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1389")
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

	yy_do_action_271 is
			--|#line 1396 "eiffel.y"
		local
			yyval52: RETRY_AS
		do
--|#line 1396 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1396")
end


yyval52 := new_retry_as (current_position) 
			yyval := yyval52
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_272 is
			--|#line 1400 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1400 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1400")
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

	yy_do_action_273 is
			--|#line 1402 "eiffel.y"
		local
			yyval81: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line 1402 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1402")
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

	yy_do_action_274 is
			--|#line 1411 "eiffel.y"
		local
			yyval6: ASSIGN_AS
		do
--|#line 1411 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1411")
end


yyval6 := new_assign_as (new_access_id_as (yytype32 (yyvs.item (yyvsp - 2)), Void), yytype25 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_275 is
			--|#line 1413 "eiffel.y"
		local
			yyval6: ASSIGN_AS
		do
--|#line 1413 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1413")
end


yyval6 := new_assign_as (new_result_as, yytype25 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_276 is
			--|#line 1417 "eiffel.y"
		local
			yyval53: REVERSE_AS
		do
--|#line 1417 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1417")
end


yyval53 := new_reverse_as (new_access_id_as (yytype32 (yyvs.item (yyvsp - 2)), Void), yytype25 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval53
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_277 is
			--|#line 1419 "eiffel.y"
		local
			yyval53: REVERSE_AS
		do
--|#line 1419 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1419")
end


yyval53 := new_reverse_as (new_result_as, yytype25 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval53
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_278 is
			--|#line 1423 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1423 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1423")
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

	yy_do_action_279 is
			--|#line 1425 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1425 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1425")
end


yyval68 := yytype68 (yyvs.item (yyvsp)) 
			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_280 is
			--|#line 1429 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1429 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1429")
end


				yyval68 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval68.extend (yytype18 (yyvs.item (yyvsp)))
			
			yyval := yyval68
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_281 is
			--|#line 1434 "eiffel.y"
		local
			yyval68: EIFFEL_LIST [CREATE_AS]
		do
--|#line 1434 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1434")
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

	yy_do_action_282 is
			--|#line 1441 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1441 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1441")
end


				inherit_context := False
				yyval18 := new_create_as (Void, Void)
			
			yyval := yyval18
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_283 is
			--|#line 1447 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1447 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1447")
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

	yy_do_action_284 is
			--|#line 1452 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1452 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1452")
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

	yy_do_action_285 is
			--|#line 1457 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1457 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1457")
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

	yy_do_action_286 is
			--|#line 1467 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1467 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1467")
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

	yy_do_action_287 is
			--|#line 1477 "eiffel.y"
		local
			yyval18: CREATE_AS
		do
--|#line 1477 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1477")
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

	yy_do_action_288 is
			--|#line 1489 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1489 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1489")
end


yyval56 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), False) 
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_289 is
			--|#line 1491 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1491 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1491")
end


yyval56 := new_routine_creation_as (yytype45 (yyvs.item (yyvsp - 3)), yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), True) 
			yyval := yyval56
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_290 is
			--|#line 1493 "eiffel.y"
		local
			yyval56: ROUTINE_CREATION_AS
		do
--|#line 1493 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1493")
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

	yy_do_action_291 is
			--|#line 1511 "eiffel.y"
		local
			yyval58: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1511 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1511")
end


yyval58 := new_old_routine_creation_as (yytype57 (yyvs.item (yyvsp - 2)), new_operand_as (Void, Void, Void), yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), False) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_292 is
			--|#line 1513 "eiffel.y"
		local
			yyval58: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1513 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1513")
end


yyval58 := new_old_routine_creation_as (yytype57 (yyvs.item (yyvsp - 2)), new_operand_as (Void, yytype32 (yyvs.item (yyvsp - 4)), Void), yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), True) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_293 is
			--|#line 1515 "eiffel.y"
		local
			yyval58: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1515 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1515")
end


yyval58 := new_old_routine_creation_as (yytype57 (yyvs.item (yyvsp - 2)), new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp - 5))), yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), True) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_294 is
			--|#line 1517 "eiffel.y"
		local
			yyval58: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1517 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1517")
end


yyval58 := new_old_routine_creation_as (yytype57 (yyvs.item (yyvsp - 2)), new_result_operand_as, yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), True) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_295 is
			--|#line 1519 "eiffel.y"
		local
			yyval58: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1519 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1519")
end


yyval58 := new_old_routine_creation_as (yytype57 (yyvs.item (yyvsp - 2)), new_operand_as (Void, Void, Void), yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), True) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_296 is
			--|#line 1521 "eiffel.y"
		local
			yyval58: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1521 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1521")
end


yyval58 := new_old_routine_creation_as (yytype57 (yyvs.item (yyvsp - 2)), new_operand_as (yytype62 (yyvs.item (yyvsp - 4)), Void, Void), yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), True) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_297 is
			--|#line 1523 "eiffel.y"
		local
			yyval58: PAIR [ROUTINE_CREATION_AS, TOKEN_LOCATION]
		do
--|#line 1523 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1523")
end


yyval58 := new_old_routine_creation_as (yytype57 (yyvs.item (yyvsp - 2)), Void, yytype32 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), True) 
			yyval := yyval58
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_298 is
			--|#line 1527 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1527 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1527")
end


yyval45 := new_operand_as (Void, yytype32 (yyvs.item (yyvsp)), Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_299 is
			--|#line 1529 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1529 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1529")
end


yyval45 := new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_300 is
			--|#line 1531 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1531 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1531")
end


yyval45 := new_result_operand_as 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_301 is
			--|#line 1533 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1533 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1533")
end


yyval45 := new_operand_as (Void, Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_302 is
			--|#line 1535 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1535 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1535")
end


yyval45 := new_operand_as (yytype62 (yyvs.item (yyvsp - 1)), Void, Void)
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_303 is
			--|#line 1537 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1537 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1537")
end


yyval45 := Void 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_304 is
			--|#line 1541 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1541 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1541")
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

	yy_do_action_305 is
			--|#line 1543 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1543 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1543")
end



			yyval := yyval83
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_306 is
			--|#line 1545 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1545 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1545")
end


yyval83 := yytype83 (yyvs.item (yyvsp - 1)) 
			yyval := yyval83
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_307 is
			--|#line 1549 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1549 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1549")
end


				yyval83 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval83.extend (yytype45 (yyvs.item (yyvsp)))
			
			yyval := yyval83
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_308 is
			--|#line 1554 "eiffel.y"
		local
			yyval83: EIFFEL_LIST [OPERAND_AS]
		do
--|#line 1554 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1554")
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

	yy_do_action_309 is
			--|#line 1561 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1561 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1561")
end


yyval45 := new_operand_as (Void, Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_310 is
			--|#line 1567 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1567 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1567")
end


yyval45 := new_operand_as (new_class_type (yytype91 (yyvs.item (yyvsp - 1)), Void, False, False, False), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_311 is
			--|#line 1569 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1569 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1569")
end


yyval45 := new_operand_as (new_class_type (yytype91 (yyvs.item (yyvsp - 2)), yytype88 (yyvs.item (yyvsp - 1)), False, False, False), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_312 is
			--|#line 1571 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1571 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1571")
end


yyval45 := new_operand_as (new_class_type (yytype91 (yyvs.item (yyvsp - 2)), yytype88 (yyvs.item (yyvsp - 1)), True, False, False), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_313 is
			--|#line 1573 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1573 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1573")
end


yyval45 := new_operand_as (new_class_type (yytype91 (yyvs.item (yyvsp - 2)), yytype88 (yyvs.item (yyvsp - 1)), False, True, False), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_314 is
			--|#line 1575 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1575 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1575")
end


yyval45 := new_operand_as (new_class_type (yytype91 (yyvs.item (yyvsp - 2)), yytype88 (yyvs.item (yyvsp - 1)), False, False, True), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_315 is
			--|#line 1577 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1577 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1577")
end


yyval45 := new_operand_as (new_bits_as (yytype38 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_316 is
			--|#line 1579 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1579 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1579")
end


yyval45 := new_operand_as (new_bits_symbol_as (yytype32 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_317 is
			--|#line 1581 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1581 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1581")
end


yyval45 := new_operand_as (new_like_id_as (yytype32 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_318 is
			--|#line 1583 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1583 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1583")
end


yyval45 := new_operand_as (new_like_current_as, Void, Void) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_319 is
			--|#line 1585 "eiffel.y"
		local
			yyval45: OPERAND_AS
		do
--|#line 1585 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1585")
end


yyval45 := new_operand_as (Void, Void, yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval45
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_320 is
			--|#line 1589 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1589 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1589")
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

	yy_do_action_321 is
			--|#line 1598 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1598 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1598")
end


yyval19 := new_creation_as (Void, yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 3))) 
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_322 is
			--|#line 1600 "eiffel.y"
		local
			yyval19: CREATION_AS
		do
--|#line 1600 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1600")
end


yyval19 := new_creation_as (yytype62 (yyvs.item (yyvsp - 3)), yytype2 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 6))) 
			yyval := yyval19
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_323 is
			--|#line 1604 "eiffel.y"
		local
			yyval20: CREATION_EXPR_AS
		do
--|#line 1604 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1604")
end


yyval20 := new_creation_expr_as (yytype62 (yyvs.item (yyvsp - 3)), yytype4 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval20
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_324 is
			--|#line 1606 "eiffel.y"
		local
			yyval20: CREATION_EXPR_AS
		do
--|#line 1606 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1606")
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

	yy_do_action_325 is
			--|#line 1617 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1617 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1617")
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

	yy_do_action_326 is
			--|#line 1619 "eiffel.y"
		local
			yyval62: TYPE
		do
--|#line 1619 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1619")
end


yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_327 is
			--|#line 1623 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1623 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1623")
end


yyval2 := new_access_id_as (yytype32 (yyvs.item (yyvsp)), Void) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_328 is
			--|#line 1625 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1625 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1625")
end


yyval2 := new_result_as 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_329 is
			--|#line 1629 "eiffel.y"
		local
			yyval4: ACCESS_INV_AS
		do
--|#line 1629 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1629")
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

	yy_do_action_330 is
			--|#line 1631 "eiffel.y"
		local
			yyval4: ACCESS_INV_AS
		do
--|#line 1631 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1631")
end


yyval4 := new_access_inv_as (yytype32 (yyvs.item (yyvsp - 1)), yytype71 (yyvs.item (yyvsp))) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_331 is
			--|#line 1639 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1639 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1639")
end


yyval36 := new_instr_call_as (yytype2 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_332 is
			--|#line 1641 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1641 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1641")
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
			--|#line 1643 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1643 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1643")
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
			--|#line 1645 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1645 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1645")
end


yyval36 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_335 is
			--|#line 1647 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1647 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1647")
end


yyval36 := new_instr_call_as (yytype44 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_336 is
			--|#line 1649 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1649 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1649")
end


yyval36 := new_instr_call_as (yytype47 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_337 is
			--|#line 1651 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1651 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1651")
end


yyval36 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_338 is
			--|#line 1653 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1653 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1653")
end


yyval36 := new_instr_call_as (yytype48 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_339 is
			--|#line 1655 "eiffel.y"
		local
			yyval36: INSTR_CALL_AS
		do
--|#line 1655 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1655")
end


yyval36 := new_instr_call_as (yytype43 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval36
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_340 is
			--|#line 1659 "eiffel.y"
		local
			yyval14: CHECK_AS
		do
--|#line 1659 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1659")
end


yyval14 := new_check_as (yytype87 (yyvs.item (yyvsp - 1)), yytype57 (yyvs.item (yyvsp - 3)), current_position) 
			yyval := yyval14
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_341 is
			--|#line 1667 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1667 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1667")
end


create {VALUE_AS} yyval25.initialize (yytype7 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_342 is
			--|#line 1669 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1669 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1669")
end


create {VOID_AS} yyval25 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_343 is
			--|#line 1671 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1671 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1671")
end


create {VALUE_AS} yyval25.initialize (yytype5 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_344 is
			--|#line 1673 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1673 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1673")
end


create {VALUE_AS} yyval25.initialize (yytype61 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_345 is
			--|#line 1675 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1675 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1675")
end


yyval25 := new_expr_call_as (yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_346 is
			--|#line 1677 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1677 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1677")
end


yyval25 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_347 is
			--|#line 1679 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1679 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1679")
end


yyval25 := new_paran_as (yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_348 is
			--|#line 1681 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1681 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1681")
end


yyval25 := new_bin_plus_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_349 is
			--|#line 1683 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1683 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1683")
end


yyval25 := new_bin_minus_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_350 is
			--|#line 1685 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1685 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1685")
end


yyval25 := new_bin_star_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_351 is
			--|#line 1687 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1687 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1687")
end


yyval25 := new_bin_slash_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_352 is
			--|#line 1689 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1689 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1689")
end


yyval25 := new_bin_mod_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_353 is
			--|#line 1691 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1691 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1691")
end


yyval25 := new_bin_div_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_354 is
			--|#line 1693 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1693 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1693")
end


yyval25 := new_bin_power_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_355 is
			--|#line 1695 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1695 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1695")
end


yyval25 := new_bin_and_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_356 is
			--|#line 1697 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1697 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1697")
end


yyval25 := new_bin_and_then_as (yytype25 (yyvs.item (yyvsp - 3)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_357 is
			--|#line 1699 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1699 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1699")
end


yyval25 := new_bin_or_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_358 is
			--|#line 1701 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1701 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1701")
end


yyval25 := new_bin_or_else_as (yytype25 (yyvs.item (yyvsp - 3)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_359 is
			--|#line 1703 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1703 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1703")
end


yyval25 := new_bin_implies_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_360 is
			--|#line 1705 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1705 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1705")
end


yyval25 := new_bin_xor_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_361 is
			--|#line 1707 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1707 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1707")
end


yyval25 := new_bin_ge_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_362 is
			--|#line 1709 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1709 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1709")
end


yyval25 := new_bin_gt_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_363 is
			--|#line 1711 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1711 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1711")
end


yyval25 := new_bin_le_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_364 is
			--|#line 1713 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1713 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1713")
end


yyval25 := new_bin_lt_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_365 is
			--|#line 1715 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1715 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1715")
end


yyval25 := new_bin_eq_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_366 is
			--|#line 1717 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1717 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1717")
end


yyval25 := new_bin_ne_as (yytype25 (yyvs.item (yyvsp - 2)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_367 is
			--|#line 1719 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1719 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1719")
end


yyval25 := new_bin_free_as (yytype25 (yyvs.item (yyvsp - 2)), yytype32 (yyvs.item (yyvsp - 1)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_368 is
			--|#line 1721 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1721 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1721")
end


yyval25 := new_un_minus_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_369 is
			--|#line 1723 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1723 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1723")
end


yyval25 := new_un_plus_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_370 is
			--|#line 1725 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1725 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1725")
end


yyval25 := new_un_not_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_371 is
			--|#line 1727 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1727 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1727")
end


yyval25 := new_un_old_as (yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_372 is
			--|#line 1729 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1729 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1729")
end


yyval25 := new_un_free_as (yytype32 (yyvs.item (yyvsp - 1)), yytype25 (yyvs.item (yyvsp))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_373 is
			--|#line 1731 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1731 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1731")
end


yyval25 := new_un_strip_as (yytype79 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_374 is
			--|#line 1733 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1733 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1733")
end


yyval25 := new_address_as (yytype92 (yyvs.item (yyvsp)).first) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_375 is
			--|#line 1735 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1735 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1735")
end


yyval25 := new_expr_address_as (yytype25 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_376 is
			--|#line 1737 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1737 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1737")
end


yyval25 := new_address_current_as 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_377 is
			--|#line 1739 "eiffel.y"
		local
			yyval25: EXPR_AS
		do
--|#line 1739 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1739")
end


yyval25 := new_address_result_as 
			yyval := yyval25
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_378 is
			--|#line 1743 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 1743 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1743")
end


create yyval32.initialize (token_buffer) 
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_379 is
			--|#line 1751 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1751 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1751")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_380 is
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

	yy_do_action_381 is
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

	yy_do_action_382 is
			--|#line 1757 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1757 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1757")
end


yyval11 := new_current_as 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_383 is
			--|#line 1759 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1759 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1759")
end


yyval11 := new_result_as 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_384 is
			--|#line 1761 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1761 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1761")
end


yyval11 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_385 is
			--|#line 1763 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1763 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1763")
end


yyval11 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_386 is
			--|#line 1765 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1765 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1765")
end


yyval11 := yytype47 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_387 is
			--|#line 1767 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1767 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1767")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_388 is
			--|#line 1769 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1769 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1769")
end


yyval11 := yytype48 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_389 is
			--|#line 1771 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1771 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1771")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_390 is
			--|#line 1773 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1773 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1773")
end


yyval11 := yytype20 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_391 is
			--|#line 1777 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1777 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1777")
end


yyval43 := new_nested_as (new_current_as, yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_392 is
			--|#line 1781 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1781 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1781")
end


yyval43 := new_nested_as (new_result_as, yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_393 is
			--|#line 1785 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1785 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1785")
end


yyval43 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_394 is
			--|#line 1789 "eiffel.y"
		local
			yyval44: NESTED_EXPR_AS
		do
--|#line 1789 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1789")
end


yyval44 := new_nested_expr_as (yytype25 (yyvs.item (yyvsp - 3)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval44
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_395 is
			--|#line 1793 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1793 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1793")
end


yyval43 := new_nested_as (yytype47 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_396 is
			--|#line 1797 "eiffel.y"
		local
			yyval47: PRECURSOR_AS
		do
--|#line 1797 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1797")
end


yyval47 := new_precursor_as (Void, yytype71 (yyvs.item (yyvsp))) 
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_397 is
			--|#line 1799 "eiffel.y"
		local
			yyval47: PRECURSOR_AS
		do
--|#line 1799 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1799")
end


yyval47 := new_precursor (yytype91 (yyvs.item (yyvsp - 2)), yytype71 (yyvs.item (yyvsp)), Void) 
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_398 is
			--|#line 1801 "eiffel.y"
		local
			yyval47: PRECURSOR_AS
		do
--|#line 1801 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1801")
end


yyval47 := new_precursor (yytype91 (yyvs.item (yyvsp - 5)), yytype71 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 2))) 
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_399 is
			--|#line 1803 "eiffel.y"
		local
			yyval47: PRECURSOR_AS
		do
--|#line 1803 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1803")
end


yyval47 := new_precursor (yytype91 (yyvs.item (yyvsp - 4)), yytype71 (yyvs.item (yyvsp)), yytype57 (yyvs.item (yyvsp - 2))) 
			yyval := yyval47
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_400 is
			--|#line 1807 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1807 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1807")
end


yyval43 := new_nested_as (yytype48 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
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


				yyval48 := new_static_access_as (yytype62 (yyvs.item (yyvsp - 4)), yytype32 (yyvs.item (yyvsp - 1)), yytype71 (yyvs.item (yyvsp)));
			
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_402 is
			--|#line 1818 "eiffel.y"
		local
			yyval48: STATIC_ACCESS_AS
		do
--|#line 1818 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1818")
end


				yyval48 := new_static_access_as (yytype62 (yyvs.item (yyvsp - 3)), yytype32 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval48
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_403 is
			--|#line 1826 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1826 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1826")
end


yyval11 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_404 is
			--|#line 1828 "eiffel.y"
		local
			yyval11: CALL_AS
		do
--|#line 1828 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1828")
end


yyval11 := yytype3 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_405 is
			--|#line 1832 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1832 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1832")
end


yyval43 := new_nested_as (yytype3 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_406 is
			--|#line 1834 "eiffel.y"
		local
			yyval43: NESTED_AS
		do
--|#line 1834 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1834")
end


yyval43 := new_nested_as (yytype3 (yyvs.item (yyvsp - 2)), yytype43 (yyvs.item (yyvsp))) 
			yyval := yyval43
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_407 is
			--|#line 1838 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 1838 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1838")
end


yyval32 := yytype32 (yyvs.item (yyvsp))
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_408 is
			--|#line 1840 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 1840 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1840")
end


yyval32 := yytype92 (yyvs.item (yyvsp)).first.internal_name 
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_409 is
			--|#line 1842 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 1842 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1842")
end


yyval32 := yytype92 (yyvs.item (yyvsp)).first.internal_name 
			yyval := yyval32
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_410 is
			--|#line 1846 "eiffel.y"
		local
			yyval2: ACCESS_AS
		do
--|#line 1846 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1846")
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

	yy_do_action_411 is
			--|#line 1859 "eiffel.y"
		local
			yyval3: ACCESS_FEAT_AS
		do
--|#line 1859 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1859")
end


yyval3 := new_access_feat_as (yytype32 (yyvs.item (yyvsp - 1)), yytype71 (yyvs.item (yyvsp))) 
			yyval := yyval3
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_412 is
			--|#line 1863 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1863 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1863")
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

	yy_do_action_413 is
			--|#line 1865 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1865 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1865")
end



			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_414 is
			--|#line 1867 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1867 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1867")
end


yyval71 := yytype71 (yyvs.item (yyvsp - 1)) 
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_415 is
			--|#line 1871 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1871 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1871")
end


				yyval71 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval71.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
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


				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_417 is
			--|#line 1883 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1883 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1883")
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

	yy_do_action_418 is
			--|#line 1885 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1885 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1885")
end


yyval71 := yytype71 (yyvs.item (yyvsp)) 
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_419 is
			--|#line 1889 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1889 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1889")
end


				yyval71 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval71.extend (yytype25 (yyvs.item (yyvsp)))
			
			yyval := yyval71
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_420 is
			--|#line 1894 "eiffel.y"
		local
			yyval71: EIFFEL_LIST [EXPR_AS]
		do
--|#line 1894 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1894")
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

	yy_do_action_421 is
			--|#line 1905 "eiffel.y"
		local
			yyval32: ID_AS
		do
--|#line 1905 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1905")
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

	yy_do_action_422 is
			--|#line 1914 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1914 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1914")
end


yyval7 := yytype10 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_423 is
			--|#line 1916 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1916 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1916")
end


yyval7 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_424 is
			--|#line 1918 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1918 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1918")
end


yyval7 := yytype38 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_425 is
			--|#line 1920 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1920 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1920")
end


yyval7 := yytype49 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_426 is
			--|#line 1922 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1922 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1922")
end


yyval7 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_427 is
			--|#line 1924 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1924 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1924")
end


yyval7 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_428 is
			--|#line 1928 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1928 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1928")
end


yyval7 := yytype10 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_429 is
			--|#line 1930 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1930 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1930")
end


yyval7 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_430 is
			--|#line 1932 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1932 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1932")
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

	yy_do_action_431 is
			--|#line 1947 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1947 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1947")
end


yyval7 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_432 is
			--|#line 1949 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1949 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1949")
end


yyval7 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_433 is
			--|#line 1951 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1951 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1951")
end


yyval7 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_434 is
			--|#line 1953 "eiffel.y"
		local
			yyval7: ATOMIC_AS
		do
--|#line 1953 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1953")
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

	yy_do_action_435 is
			--|#line 1960 "eiffel.y"
		local
			yyval10: BOOL_AS
		do
--|#line 1960 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1960")
end


yyval10 := new_boolean_as (False) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_436 is
			--|#line 1962 "eiffel.y"
		local
			yyval10: BOOL_AS
		do
--|#line 1962 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1962")
end


yyval10 := new_boolean_as (True) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_437 is
			--|#line 1966 "eiffel.y"
		local
			yyval13: CHAR_AS
		do
--|#line 1966 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1966")
end


				check is_character: not token_buffer.is_empty end
				yyval13 := new_character_as (token_buffer.item (1))
			
			yyval := yyval13
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_438 is
			--|#line 1973 "eiffel.y"
		local
			yyval38: INTEGER_CONSTANT
		do
--|#line 1973 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1973")
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

	yy_do_action_439 is
			--|#line 1988 "eiffel.y"
		local
			yyval38: INTEGER_CONSTANT
		do
--|#line 1988 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 1988")
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

	yy_do_action_440 is
			--|#line 2003 "eiffel.y"
		local
			yyval38: INTEGER_CONSTANT
		do
--|#line 2003 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2003")
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

	yy_do_action_441 is
			--|#line 2021 "eiffel.y"
		local
			yyval49: REAL_AS
		do
--|#line 2021 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2021")
end


yyval49 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval49
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_442 is
			--|#line 2023 "eiffel.y"
		local
			yyval49: REAL_AS
		do
--|#line 2023 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2023")
end


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
			yyval49: REAL_AS
		do
--|#line 2025 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2025")
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

	yy_do_action_444 is
			--|#line 2032 "eiffel.y"
		local
			yyval8: BIT_CONST_AS
		do
--|#line 2032 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2032")
end


yyval8 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval8
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_445 is
			--|#line 2036 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2036 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2036")
end


yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_446 is
			--|#line 2038 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2038 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2038")
end


yyval59 := new_empty_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_447 is
			--|#line 2040 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2040 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2040")
end


yyval59 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_448 is
			--|#line 2044 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2044 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2044")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_449 is
			--|#line 2046 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2046 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2046")
end


yyval59 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_450 is
			--|#line 2048 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2048 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2048")
end


yyval59 := new_lt_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_451 is
			--|#line 2050 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2050 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2050")
end


yyval59 := new_le_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_452 is
			--|#line 2052 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2052 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2052")
end


yyval59 := new_gt_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_453 is
			--|#line 2054 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2054 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2054")
end


yyval59 := new_ge_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_454 is
			--|#line 2056 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2056 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2056")
end


yyval59 := new_minus_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_455 is
			--|#line 2058 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2058 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2058")
end


yyval59 := new_plus_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_456 is
			--|#line 2060 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2060 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2060")
end


yyval59 := new_star_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_457 is
			--|#line 2062 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2062 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2062")
end


yyval59 := new_slash_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_458 is
			--|#line 2064 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2064 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2064")
end


yyval59 := new_mod_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_459 is
			--|#line 2066 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2066 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2066")
end


yyval59 := new_div_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_460 is
			--|#line 2068 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2068 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2068")
end


yyval59 := new_power_string_as 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_461 is
			--|#line 2070 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2070 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2070")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_462 is
			--|#line 2072 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2072 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2072")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_463 is
			--|#line 2074 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2074 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2074")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_464 is
			--|#line 2076 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2076 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2076")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_465 is
			--|#line 2078 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2078 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2078")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_466 is
			--|#line 2080 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2080 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2080")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_467 is
			--|#line 2082 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2082 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2082")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_468 is
			--|#line 2084 "eiffel.y"
		local
			yyval59: STRING_AS
		do
--|#line 2084 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2084")
end


yyval59 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval59
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_469 is
			--|#line 2088 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2088 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2088")
end


yyval93 := new_clickable_string (new_minus_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_470 is
			--|#line 2090 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2090 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2090")
end


yyval93 := new_clickable_string (new_plus_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_471 is
			--|#line 2092 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2092 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2092")
end


yyval93 := new_clickable_string (new_not_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_472 is
			--|#line 2094 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2094 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2094")
end


yyval93 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_473 is
			--|#line 2098 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2098 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2098")
end


yyval93 := new_clickable_string (new_lt_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_474 is
			--|#line 2100 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2100 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2100")
end


yyval93 := new_clickable_string (new_le_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_475 is
			--|#line 2102 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2102 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2102")
end


yyval93 := new_clickable_string (new_gt_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_476 is
			--|#line 2104 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2104 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2104")
end


yyval93 := new_clickable_string (new_ge_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_477 is
			--|#line 2106 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2106 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2106")
end


yyval93 := new_clickable_string (new_minus_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_478 is
			--|#line 2108 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2108 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2108")
end


yyval93 := new_clickable_string (new_plus_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_479 is
			--|#line 2110 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2110 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2110")
end


yyval93 := new_clickable_string (new_star_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_480 is
			--|#line 2112 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2112 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2112")
end


yyval93 := new_clickable_string (new_slash_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_481 is
			--|#line 2114 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2114 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2114")
end


yyval93 := new_clickable_string (new_mod_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_482 is
			--|#line 2116 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2116 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2116")
end


yyval93 := new_clickable_string (new_div_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_483 is
			--|#line 2118 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2118 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2118")
end


yyval93 := new_clickable_string (new_power_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_484 is
			--|#line 2120 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2120 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2120")
end


yyval93 := new_clickable_string (new_and_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_485 is
			--|#line 2122 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2122 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2122")
end


yyval93 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_486 is
			--|#line 2124 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2124 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2124")
end


yyval93 := new_clickable_string (new_implies_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_487 is
			--|#line 2126 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2126 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2126")
end


yyval93 := new_clickable_string (new_or_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_488 is
			--|#line 2128 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2128 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2128")
end


yyval93 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_489 is
			--|#line 2130 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2130 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2130")
end


yyval93 := new_clickable_string (new_xor_string_as) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_490 is
			--|#line 2132 "eiffel.y"
		local
			yyval93: PAIR [STRING_AS, CLICK_AST]
		do
--|#line 2132 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2132")
end


yyval93 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval93
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_491 is
			--|#line 2136 "eiffel.y"
		local
			yyval5: ARRAY_AS
		do
--|#line 2136 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2136")
end


yyval5 := new_array_as (yytype71 (yyvs.item (yyvsp - 1))) 
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_492 is
			--|#line 2140 "eiffel.y"
		local
			yyval61: TUPLE_AS
		do
--|#line 2140 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2140")
end


yyval61 := new_tuple_as (yytype71 (yyvs.item (yyvsp - 1))) 
			yyval := yyval61
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_493 is
			--|#line 2144 "eiffel.y"
		do
--|#line 2144 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2144")
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

	yy_do_action_494 is
			--|#line 2148 "eiffel.y"
		local
			yyval57: TOKEN_LOCATION
		do
--|#line 2148 "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line 2148")
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
			when 808 then
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
			    0,  294,  294,  294,  295,  297,  284,  283,  253,  253,
			  253,  255,  255,  255,  256,  256,  256,  254,  254,  171,
			  167,  167,  219,  219,  219,  136,  136,  136,  136,  296,
			  296,  296,  296,  299,  299,  300,  300,  204,  204,  236,
			  236,  237,  237,  163,  163,  148,  301,  147,  147,  249,
			  249,  250,  250,  235,  235,  298,  298,  162,  291,  291,
			  288,  303,  303,  287,  287,  287,  285,  286,  140,  149,
			  149,  150,  150,  150,  265,  265,  265,  266,  266,  190,
			  190,  191,  191,  191,  191,  191,  191,  191,  267,  267,
			  268,  268,  196,  229,  229,  228,  228,  230,  230,  158,

			  164,  164,  164,  223,  223,  222,  222,  151,  151,  238,
			  238,  240,  240,  239,  239,  242,  242,  241,  241,  244,
			  244,  243,  243,  277,  277,  278,  278,  279,  279,  216,
			  304,  304,  281,  281,  282,  282,  217,  251,  251,  252,
			  252,  212,  212,  201,  305,  200,  200,  200,  160,  161,
			  206,  206,  177,  177,  280,  280,  258,  258,  259,  259,
			  174,  302,  302,  175,  175,  175,  175,  175,  175,  175,
			  175,  175,  175,  197,  197,  307,  197,  308,  157,  157,
			  309,  157,  310,  271,  271,  272,  272,  208,  209,  209,
			  209,  211,  211,  215,  215,  215,  215,  215,  215,  215,

			  213,  275,  275,  275,  274,  274,  276,  276,  246,  246,
			  247,  247,  248,  248,  165,  311,  292,  292,  245,  245,
			  170,  226,  226,  227,  227,  156,  260,  260,  172,  220,
			  220,  221,  221,  144,  262,  262,  178,  178,  178,  178,
			  178,  178,  178,  178,  178,  178,  178,  178,  178,  178,
			  178,  178,  178,  178,  261,  261,  180,  273,  273,  179,
			  179,  312,  218,  218,  218,  155,  269,  269,  269,  270,
			  270,  198,  257,  257,  135,  135,  199,  199,  224,  224,
			  225,  225,  152,  152,  152,  152,  152,  152,  202,  202,
			  202,  203,  203,  203,  203,  203,  203,  203,  189,  189,

			  189,  189,  189,  189,  263,  263,  263,  264,  264,  188,
			  188,  188,  188,  188,  188,  188,  188,  188,  188,  188,
			  153,  153,  153,  154,  154,  214,  214,  130,  130,  133,
			  133,  173,  173,  173,  173,  173,  173,  173,  173,  173,
			  146,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  168,  143,
			  143,  143,  143,  143,  143,  143,  143,  143,  143,  143,
			  143,  185,  184,  183,  187,  182,  192,  192,  192,  192,

			  186,  193,  194,  142,  142,  181,  181,  169,  169,  169,
			  131,  132,  231,  231,  231,  232,  232,  233,  233,  234,
			  234,  166,  137,  137,  137,  137,  137,  137,  138,  138,
			  138,  138,  138,  138,  138,  141,  141,  145,  176,  176,
			  176,  195,  195,  195,  139,  205,  205,  205,  207,  207,
			  207,  207,  207,  207,  207,  207,  207,  207,  207,  207,
			  207,  207,  207,  207,  207,  207,  207,  207,  207,  290,
			  290,  290,  290,  289,  289,  289,  289,  289,  289,  289,
			  289,  289,  289,  289,  289,  289,  289,  289,  289,  289,
			  289,  134,  210,  306,  293>>)
		end

	yytypes1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,   32,   80,    1,   34,   80,   57,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    2,    5,    7,    8,   10,   11,   13,
			   20,   25,   32,   32,   32,   43,   43,   43,   43,   43,
			   44,   47,   48,   56,   58,   59,   59,   61,   92,   92,
			    1,    1,    1,    1,    1,    1,   62,   62,   62,   91,

			    1,    1,    1,    1,   34,   32,   32,    1,    1,    1,
			    1,    1,    1,    1,   93,    1,    1,    1,    1,    1,
			   32,   32,   45,    1,    1,   71,   59,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,   93,    1,    1,    1,    1,
			    1,    1,    1,   91,   92,   92,   92,   25,   71,   71,
			    1,   62,   91,   71,    1,   57,   62,   25,   25,    1,
			   25,   25,   25,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,   32,    1,   25,   71,    1,    1,   91,   91,    1,

			   32,   91,    1,    1,    1,   32,   38,    1,   88,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    7,    7,    8,   10,   13,   20,   32,   38,   49,   59,
			   65,   57,   57,    3,   11,   32,   32,   43,   62,   25,
			    1,   83,    1,   91,    1,   25,   71,   62,   57,   11,
			   25,    1,    1,   91,    1,    1,    1,   62,   32,    1,
			    1,   32,   79,   79,   11,   25,   25,   25,   25,   25,
			   25,   25,   25,   25,   25,   25,   25,   25,    1,   25,
			   25,    1,   25,   25,   25,   57,   11,   11,   88,   88,
			   88,    1,    1,    1,   62,   88,   91,    1,    1,    1,

			    1,    1,   61,    1,    1,    1,   32,   32,    1,   71,
			    1,    1,    1,    1,    1,   25,   45,   83,   32,    1,
			    1,    1,    1,   32,    1,   25,    1,   57,   57,    1,
			   83,   57,    1,    1,    1,    1,   25,   25,   32,    1,
			    1,   76,   57,    1,    7,   83,   83,    3,   43,    1,
			    1,    1,    1,    1,   91,    1,    1,   83,   71,   25,
			    1,   83,    1,   32,    1,   57,    1,    4,   57,   11,
			   32,   83,   62,    1,   59,    1,   91,   91,    1,   32,
			   91,   32,   38,    1,    1,   88,   45,   32,   57,   83,
			   71,    4,   32,   32,   59,    1,   59,    1,   31,   76,

			   76,   88,   88,    1,    1,   88,    1,    1,    1,   88,
			    1,   71,    1,   71,   83,   59,    1,   84,    1,    1,
			    1,    1,    1,    1,    1,   71,   46,   84,   57,    1,
			   57,    1,   95,   31,   46,   46,   91,    1,   18,   68,
			   68,   57,   62,    1,   88,    1,   15,   77,    1,   67,
			   18,    1,    1,   75,    1,    1,    1,    1,    1,    1,
			   70,   75,   75,   75,   85,    1,   77,   91,   75,   92,
			   17,   67,   92,    1,   15,   29,   73,   73,   15,   77,
			   75,   75,   75,   50,   85,   92,   75,   24,   70,   77,
			    1,   75,   75,   75,   75,   75,   75,    1,   70,   70,

			    1,    1,    1,    1,    1,    1,    1,    1,   28,   72,
			   92,   94,    1,   57,   29,   75,    1,    1,    1,   24,
			    1,   30,   75,   75,   75,    1,   75,   91,   92,   17,
			    1,    1,   15,   77,   28,    1,    1,    9,   89,   92,
			    1,   41,   50,   92,    1,   75,    1,   75,   88,   88,
			   92,   63,   79,   89,   89,    1,    1,   62,    1,   57,
			    1,   75,    1,    1,   57,    1,   63,    1,   62,    1,
			    1,   16,   80,   60,   87,   87,    1,   80,    1,    1,
			    1,    1,    1,    7,   16,   80,    1,   80,   60,   60,
			   57,    1,    1,    1,    1,   80,   80,   80,   55,   59,

			    1,    1,   25,   32,   32,   62,    1,    1,    1,    1,
			    1,   51,   25,    1,    1,    1,   89,    1,   87,   63,
			   79,   89,   89,    1,    1,    1,    1,   26,   39,   54,
			   87,   57,   63,   81,    1,   27,   57,   81,    1,   23,
			    1,   37,   81,    1,   59,   59,    1,    1,    1,   81,
			   62,   37,    1,    1,    1,    6,   14,   19,   21,   33,
			   35,   36,   37,   42,   52,   53,   57,    1,   87,   81,
			    1,    1,   57,   81,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    2,   32,   43,   43,   43,   43,
			   43,   44,   47,   48,   87,   25,    1,   87,    1,    1,

			   25,    1,   86,   87,   91,    1,    1,    2,   32,   62,
			   62,   25,    1,    1,    1,   12,   66,   66,   87,    1,
			   64,   25,   25,    1,    1,   59,   86,   81,    1,   62,
			    4,    1,    1,   25,   25,   57,    1,   81,   12,   25,
			   32,    1,   81,    1,    1,    1,    1,    2,    1,   13,
			   32,   38,   40,   48,   82,   81,    1,    1,   57,   22,
			   69,   69,   57,   59,    2,    4,    1,    1,    1,    1,
			    1,    1,    1,   25,   25,    1,   81,   22,    1,    4,
			   62,   13,   32,   48,   13,   32,   38,   48,   32,   38,
			   48,   13,   32,   38,   48,   81,   40,    1,   81,    1,

			   25,    1,   81,    1,    1,    1,   81,   32,    1,    1,
			    1>>)
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
			    8,  494,    0,  421,    0,   33,    1,   17,  494,   21,
			  468,  467,  466,  465,  464,  463,  462,  461,  460,  459,
			  458,  457,  456,  455,  454,  453,  452,  451,  450,  342,
			  447,  449,  446,    0,  383,    0,    0,  412,    0,    0,
			    0,  382,    0,  436,  435,  417,    0,  417,    0,  494,
			    0,  444,  448,  431,  437,  430,    0,    0,    0,    0,
			  378,    0,    0,  384,  343,  341,  432,  428,  345,  429,
			  390,    3,  407,    0,  412,  387,  381,  380,  379,  389,
			  385,  386,  388,  346,  290,  433,  445,  344,  408,  409,
			    0,    0,    0,    0,    0,    7,    2,  191,  192,  201,

			   34,   35,    0,   35,   18,    0,    0,  494,  494,    0,
			  472,  471,  470,  469,   67,  303,  300,  301,    0,    0,
			  407,  304,    0,    0,    0,  396,  434,  490,  489,  488,
			  487,  486,  485,  484,  483,  482,  481,  480,  479,  478,
			  477,  476,  475,  474,  473,   66,    0,  494,    0,  377,
			  376,    6,    0,   63,   64,   65,  374,  419,    0,  418,
			    0,    0,  201,    0,    0,    0,    0,    0,  371,  139,
			  370,  368,  369,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  494,  372,  410,    0,    0,  201,  201,  199,

			  198,  201,  438,    0,    0,  197,  196,    0,  200,   36,
			   30,    0,   35,   35,   29,   20,   24,  441,    0,    0,
			   22,   26,  426,  422,  423,    0,   25,  424,  425,  427,
			   55,    0,    0,  404,  392,  407,  412,  403,    0,    0,
			    0,  288,    0,    0,  413,  415,    0,    0,    0,  391,
			    0,  492,    0,    0,  494,  494,  491,    0,  304,  494,
			  347,  137,  140,    0,  393,  354,  353,  352,  351,  350,
			  349,  348,  361,  363,  362,  364,  365,  366,    0,  355,
			  360,    0,  357,  359,  367,    0,  395,  400,  195,  194,
			  193,  440,  439,  202,  206,    0,  494,   32,   31,  443,

			  442,   27,    0,    0,   56,   19,  304,  304,    0,  411,
			  302,  299,  309,    0,  305,  319,  307,    0,  304,  412,
			  414,    0,    0,  304,  375,  420,    0,    0,    0,  494,
			  291,  329,  494,    0,    0,  373,  356,  358,  304,  203,
			    0,  150,    0,   28,   23,  297,  294,  405,  406,    0,
			    0,    0,    0,    0,  201,  306,    0,  289,  397,  416,
			    0,  295,  494,  304,  412,  329,    0,  324,    0,  394,
			  138,  292,  207,    0,   37,  210,  201,  201,  199,  198,
			  201,  197,  196,    0,  494,    0,  308,  412,    0,  296,
			  399,  323,  412,  304,  151,    0,   74,  215,  212,    0,

			  211,  195,  194,  318,  317,  193,  316,  315,  204,    0,
			  311,  401,  412,  330,  293,   38,  494,  494,  216,  209,
			    0,  314,  312,  313,  205,  398,   77,  494,    0,   76,
			  494,    0,  214,  213,   78,   79,  201,  282,  280,  103,
			  494,    0,  218,   80,   81,    0,    0,  284,    0,   39,
			  281,  285,    0,  217,  113,  121,   88,  117,   55,   87,
			  111,  115,  119,    0,   93,   49,    0,   51,  283,  109,
			  105,  104,    0,   46,   61,   41,  494,   40,    0,  287,
			    0,  114,  122,   90,   89,    0,  118,   97,   95,  100,
			   96,  112,  115,  116,  119,  120,    0,   86,   94,  111,

			   50,    0,    0,    0,    0,    0,   47,   62,   53,   61,
			   58,  123,    0,  259,   42,  286,  219,    0,    0,   98,
			  101,   55,  102,  119,    0,   85,  115,   52,  110,  106,
			    0,    0,   45,   48,   54,   61,  125,  161,  141,   60,
			  261,  494,   91,   92,   99,    0,   84,  119,    0,    0,
			   59,  127,  494,    0,  126,   57,    0,   14,  493,    8,
			   83,    0,  108,    0,    0,  124,  128,  162,  142,   11,
			  494,   68,   69,  185,  260,  493,  494,    0,   82,  107,
			  130,   14,  494,   14,   70,   37,   16,  494,  186,   55,
			    0,    5,    4,    0,    0,   72,  494,   71,   73,  144,

			   15,  187,  188,  407,    0,   55,  173,  190,  131,  129,
			  175,  154,  189,  177,  493,  132,    0,  493,  174,  134,
			  494,  155,  133,  161,  494,  161,  147,  146,  145,  178,
			  176,    0,  135,  153,  493,  150,    0,  152,  180,  272,
			    0,  158,  493,  494,  148,  149,  182,  493,  161,    0,
			   55,  159,  271,  494,  161,  165,  171,  163,  170,  167,
			  168,  164,  161,  169,  172,  166,    0,  493,  179,  273,
			  143,  136,    0,  257,  160,    0,    0,  266,    0,  493,
			    0,    0,  325,    0,  331,  407,  337,  333,  332,  334,
			  339,  335,  336,  338,  181,  229,  493,  262,    0,    0,

			    0,    0,  161,    0,    0,  328,    0,  329,  327,  326,
			    0,    0,    0,    0,  494,  231,  254,  230,  258,    0,
			    0,  275,  277,  161,  267,  269,    0,    0,  340,    0,
			  321,    0,    0,  274,  276,    0,  161,    0,  232,  264,
			  407,  494,  494,  268,    0,  265,    0,  329,    0,  238,
			  240,  236,  234,  246,    0,  255,  228,    0,    0,  223,
			  226,  494,    0,  270,  329,  320,    0,    0,    0,    0,
			    0,  161,    0,  263,    0,  161,    0,  224,    0,  322,
			    0,  239,  245,  253,  244,  241,  242,  248,  243,  237,
			  251,  252,  247,  250,  249,  233,  235,  161,  227,  220,

			    0,    0,    0,  161,    0,  256,  225,  402,    0,    0,
			    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  707,   63,  233,  367,   64,  655,  220,  221,   65,   66,
			  537,   67,  234,   68,  715,   69,  656,  446,  474,  571,
			  584,  470,  438,  657,   70,  658,  759,  639,  487,  157,
			  627,  635,  508,  475,  521,  398,   72,  106,   73,   74,
			  659,    7,  660,  661,  641,  662,  227,  628,  752,  541,
			  663,  237,   75,   76,   77,   78,   79,   80,  316,  122,
			  426,  435,   81,   82,  753,  228,  483,  611,  664,  665,
			  629,  598,   83,   84,  396,   85,  374,   86,  573,  589,
			   87,  294,  557,   97,  710,   98,  551,  619,  720,  230,
			  716,  717,  471,  449,  439,  440,  760,  761,  460,  499,

			  488,  125,  246,  158,  159,  509,  476,  477,  468,  491,
			  492,  493,  494,  495,  496,  453,  341,  399,  400,  489,
			  466,  552,  263,    5,    8,  585,  572,  649,  633,  642,
			  776,  737,  754,  241,  317,  417,  427,  464,  484,  702,
			  726,  574,  575,  697,  385,  208,  295,  538,  553,  554,
			  616,  621,  622,   99,  153,   88,   89,  469,  510,  145,
			  114,  511,  432,    9,  808,    6,  102,  592,  305,  103,
			  210,  506,  634,  512,  594,  606,  576,  614,  617,  647,
			  667,  418,  558>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    6,  625, 1324, -32768,  138,  242, -32768, -32768,  288,  135,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,  686,  221,  105,   39,   70, 1719, 1898,
			  744,  213,   -5, -32768, -32768, 1324,  232, 1324,  743, -32768,
			  138, -32768, -32768, -32768, -32768, -32768, 1324, 1324,  756, 1324,
			 -32768, 1324, 1324,  483, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, 2029,  742, 1324,  648, -32768, -32768, -32768, -32768, -32768,
			 -32768,  464,  445, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  236,  236,   31,  236,  414, -32768, -32768, -32768, -32768,  593,

			 -32768,  669,  720,   43, -32768,  732, 1556, -32768, -32768,  223,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  138, 1324,
			  738,  675,  736,  236, 1208, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  236, -32768,  223, -32768,
			 -32768, -32768, 1324, -32768, -32768, -32768, -32768, 2029,  708,  713,
			  236,  646,  470,  705,  138,  135,  715, 1987, -32768,  135,
			 -32768, -32768, -32768,  223, 1324, 1324, 1324, 1324, 1324, 1324,
			 1324, 1324, 1324, 1324, 1324, 1324, 1324, 1092, 1324,  976,
			 1324, 1324, -32768, -32768, -32768,  223,  223,  593,  593, -32768,

			 -32768,  593, -32768,  719,  714, -32768, -32768,  190, -32768, -32768,
			 -32768,  236,  669,  669, -32768, -32768, -32768, -32768,  455,  446,
			 -32768, -32768, -32768, -32768, -32768,   89, -32768, -32768, -32768, -32768,
			  308,  135,  135,  690, -32768, -32768,  648, -32768,  695, 1944,
			  860, -32768,  223,  693, -32768, 2029,  342,  689,  135, -32768,
			 1925, -32768, 1324,  687, -32768, -32768, -32768,  683,  675, -32768,
			  202, -32768,  505,  684, -32768,  484,  484,  484,  484,  484,
			  833,  833,  824,  824,  824,  824,  824,  824, 1324, 2058,
			 2044, 1324, 1725, 1966, -32768,  135, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  286,  554, -32768, -32768, -32768,

			 -32768, -32768,  667, 1580, -32768, -32768,  675,  675,  223, -32768,
			 -32768, -32768,  686,  189, -32768, 2029, -32768,  334,  675,  648,
			 -32768, 1324,  697,  675, -32768, 2029,  674,  135,  631, -32768,
			 -32768,  212, -32768,  223,  135, -32768, 2058, 1725,  675, -32768,
			  138,  504,  668, -32768, -32768, -32768, -32768,  690, -32768,  236,
			  236,   -6,  236,  414,  448, -32768, 1440, -32768, -32768, 2029,
			  135, -32768, -32768,  675,  648,  212,  135, -32768,  135, -32768,
			 -32768, -32768, -32768, 1763,  466,  613,  593,  593,  665,  664,
			  593,  663,  659,   65,  330,  655, -32768,  648,  618, -32768,
			 -32768, -32768,  648,  675, -32768, 1719,  620, -32768, -32768,  647,

			  650,  642,  641, -32768, -32768,  639, -32768, -32768,  570,  271,
			 -32768, -32768,  648, -32768, -32768, -32768,  666, -32768,  615, -32768,
			  613, -32768, -32768, -32768,  538, -32768, -32768,  685,  236, -32768,
			  374,  236, -32768, -32768, -32768,  605,  593,   56, -32768,  581,
			  371,  597,  596, -32768,  517,  119,   62,  185,   62,  547,
			 -32768,   56,   62, -32768,   62,   62,   62,   62,  208, -32768,
			  506,  509,  476,  558,  565, -32768,  284, -32768,  560, -32768,
			 -32768,  579,  175, -32768,  557, -32768, -32768,  547,   62,  185,
			  -15,  560,  560, -32768,  572,  561,  560, -32768,  555,   28,
			 -32768, -32768,  509, -32768,  476, -32768,  545, -32768, -32768,  506,

			 -32768,  236,   62,   62,  559,  556,  555, -32768, -32768,  495,
			 -32768,  204,   62,  515, -32768,  560, -32768,   62,   62, -32768,
			 -32768,  488,  560,  476,  522, -32768,  509, -32768, -32768, -32768,
			  138,  138, -32768, -32768, -32768,  514,  135, -32768,  546, -32768,
			 -32768, -32768, -32768, -32768, -32768,  518, -32768,  476,  267,  215,
			 -32768, -32768,  505,  526,  135,  486,  138,  292,  -25,  497,
			 -32768,  503, -32768,  520,  521, -32768, -32768, -32768, -32768, 1696,
			  496, -32768, -32768, -32768, -32768,  721, -32768,  487, -32768, -32768,
			  508,  480,  794,  480, -32768,  466, -32768,  485, -32768,  488,
			 1324, -32768, -32768,  135,  138, -32768,  692, -32768, -32768, -32768,

			 -32768, -32768, 2029,  427,  498,  488,  453, 1324, -32768, -32768,
			  478,  462, 2029, -32768,  255,  135,  394,  255, -32768, -32768,
			  505, -32768,  135, -32768, -32768, -32768, -32768, -32768, -32768,  467,
			 -32768,  502, -32768, -32768,  473,  504, 1763, -32768,  430,  434,
			  138, -32768,  767,   58, -32768, -32768, -32768,   63, -32768,  460,
			  488, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  740,   63, -32768, -32768,
			 -32768, -32768, 1324,  441,  486,  239, 1324,  454,  494,  449,
			   77,  -17,  138, 1324,  483,  276, -32768, -32768, -32768, -32768,
			 -32768, -32768,  464,  445, -32768,  643,  188,  355, 1324, 1324,

			 1889, 1741, -32768,  388,  397, -32768,  138,  212, -32768, -32768,
			  404, 1748, 1324, 1324, -32768, -32768,  367,  319, -32768, 1324,
			  312, 2029, 2029, -32768, -32768, -32768,  102,  345, -32768,  360,
			 -32768,   -9,  364, 2029, 2029,  348, -32768,  318, -32768, 2029,
			    9, -32768,  372, -32768, 1763, -32768,   -9,  212,  327,  352,
			  349,  333, -32768,  325,   -2, -32768, -32768, 1324, 1324, -32768,
			  245,  324,  210, -32768,  212, -32768,  236,   12,  348,  195,
			  348, -32768,  348, 2029, 1907, -32768,  151, -32768, 1324, -32768,
			  164, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 1630,  182,  106, -32768,  135, -32768, -32768, -32768,  143,  118,
			 -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -596,  241,  601, -343, -32768, -32768,  599,  335, -32768,  -95,
			 -32768,  -98, -129, -32768,  180, -100, -32768, -431, -32768, -32768,
			 -32768,  385,  456, -32768, -101, -32768,  124, -32768,  392,    1,
			 -32768, -32768,  368,  396, -32768,  410,    0, -32768,  126,  384,
			 -32768,    2, -32768, -32768,  226, -32768,  -90, -32768,   83, -32768,
			 -32768,  564,  201,  200,  197,  196,  192,  170,  472, -32768,
			  390, -32768,  159,  156, -256, -32768,  303, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  234,  -36,  183, -359,  238, -32768,
			  584,    3, -32768, -145, -32768, -32768,  256,  186, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  343, -32768,

			 -32768,  -43, -32768,  758, -32768, -32768, -32768, -32768, -205,  358,
			  300,  354, -423,  351, -471, -32768, -32768, -32768, -32768, -419,
			 -32768, -139, -32768,  235, -281, -32768,  -84, -32768, -193, -32768,
			 -32768, -32768, -32768, -199, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -574, -32768, -32768, -32768, -164, -370, -32768, -32768, -32768,
			 -32768, -32768, -32768,  -11, -32768,   46,  -30,    4,  253, -32768,
			 -32768, -32768, -32768,   51, -32768, -32768, -32768, -32768, -390, -32768,
			  -86, -32768, -522, -32768, -32768, -32768, -472, -32768, -32768, -32768,
			 -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    4,  247,  126,   71,  206,  225,  224,   96,  223,  105,
			  104,  222,  155,  409,  394,  555,    3,  214,  447,  249,
			  478,  152,  391,  524,    3,  502,  429,    3,  151,  706,
			  262,  194,  479,  288,  289,  162,  120,  290,  772,    3,
			  618, -183,   54,  630,  264,    3,  156,  192,  757,  161,
			 -183,  516,  545,  166,  378,  150,  520,  167,  168,  330,
			  170,  151,  171,  172,    3,  119,  286,  287,  490,  523,
			  229,   39,    3,  668,  193,  532,  561,    2,  705,  197,
			  198,    1,  201,  748,   35,  118,  705,  533,  154,  -47,
			  149,  199,  200,  694,  205,  151,  124,  771,   95,  117,

			  165,   94,  445,  547,   39,  703,  226,  345,  346,  235,
			   95,  213,  243,  209,  408,   39,  123,   35,  810,  357,
			  239,  238,  718,  160,  361,  245,  297,  298,   35, -183,
			  654,  544,  -47,   93,  116,  747,  653,   45,   39,  371,
			  674,  212,  744,  809,  115,  -47,   92,  743,  235,  253,
			  764,   35,   95,  250,  652,  301,   91, -183,  231,  232,
			  548,  549,  643,   90,  389,  258,  465,  257,    3,  261,
			  643,   95,  805,  235,   94,  265,  266,  267,  268,  269,
			  270,  271,  272,  273,  274,  275,  276,  277,  279,  280,
			  282,  283,  284,  309,  414,  235,  235,  191,  248,  601,

			  296,  505,  225,  224,  369,  223,   93,  804,  222,  204,
			  203,  801,  401,  402,  504,  609,  405,  799,  -48,   92,
			  113,  112,   95,   95,  202,  353,   94,  333,    3,   91,
			  536,  306,  307,  111,  110,  160,   90,  366,  148,  293,
			  332,  315,  235,  285,  535,  304,  109,  480,  323,  481,
			  482,  147,  486,  325,  445,  340,    3,  352,   93,  108,
			  671,  -48,  563,  382,  109,   95,  748,  229,   94,   95,
			  351,   92,  444,  515,  -48,  778,  358,  645,  160,  336,
			  350,   91,  337,  191,  522,  338,  442,  349,   90,  587,
			 -183, -183,  699,  191,  191,  698,  191,  191,  191,   39,

			   93,  596,  354,  226,  101,  327,  328,  340,  235,  775,
			  331,  340,   35,   92,  562,  100,  161, -183, -183,  191,
			  424,  390,  359,   91,  501, -183,  340,  363,  770,  713,
			   90,  500,  712,  235,  370,  339,  769, -183,  376,  377,
			 -183,  380,  725,  372,  411,  304,   -9,  342,  303,  413,
			   -9,  379,  768,  381,   -9,  767,   -9,  315,   -9,  415,
			  387,   -9,  204,  203,  730,  191,  392,  570,  393,  425,
			 -310,  191,  569,  766,  356, -310,  191,  202,   54,  355,
			  365,    3,  321,  368,  756,  763,   -9,  320, -222,  333,
			 -222,  191,  191,  191,  191,  191,  191,  191,  191,  191,

			  191,  191,  191,  191,  765,  191,  191,  746,  191,  191,
			  191,  745,  437,  388,  741,  437,  155,  436,  155,  748,
			  121,  779,  155,  714,  155,  155,  155,  155,  204,  203,
			 -279,  736,  637, -278,  467,  328, -221, -279, -221,  731,
			 -278,  191, -279,  202,  255, -278, -279,    3,  155, -278,
			 -279,  191,  472, -278,  728,  669,  626,  625,  719,  155,
			  485,  673,  191,  191,  624,  192,  607,  428,  430,  224,
			  196,  223,  155,  155,  222,  292,  620,  300,  428,  623,
			  701,  441,  155,  620,  291,  191,  299,  155,  155,  195,
			  527,  441,  154,  236,  154,  384,  383,  595,  154,  597,

			  154,  154,  154,  154,  174,   60,  528,  472,  173,  727,
			  567,  783,  787,  790,  794, -183,  539,  255,  207,  148,
			  696,  485,  543,  567,  154,  304,  670,  513,  648,  646,
			  742,  373,  236,  229,  638,  154,  261, -156, -156, -156,
			 -156,  640,  613,  755,  615,  334,  610,  608,  154,  154,
			  395,  600, -156,  591,  261,  570,  593,  236,  154,  568,
			  580,  -44,  586,  154,  154,  579,  -44, -156,  507,  578,
			  -44,  565,    1,  455,  -44, -156, -156, -156,  795,  236,
			  236, -208,  798,  459,  560,  556,  458,  507,  546,  104,
			  603,  602,  559,  604,  540, -208, -208,  605,  104,  457,

			  502,  445,  531,  564,  802,  530,  454,  457,  612,  456,
			  806,  525,  517, -208,  455,  261,  518,  454,  473,  503,
			 -208,  780,  261,  -43,  497, -208,  318,  590,  -43, -208,
			  507, -208,  -43, -208,  458,  749,  -43,  452, -208,  451,
			  448,  207,  443,  650, -203,  751,  397,  190,  189,  188,
			  187,  186,  185,  184,  183,  182,  181,  180,  179,  178,
			  177,  176,  175,  174,   60,  431,  685,  781,  784,  704,
			  791,  631,  749,  695,  124,  636, -202,  700,  786,  789,
			  793,  708,  751,  -10,  711,  709,  423,  -10,  422,  421,
			  420,  -10,  236,  -10,  666,  -10,  419,  416,  -10,  721,

			  722,  240,  410,  304,  672,  412,  407,  -55,  -55,  729,
			  406,  404,  403,  733,  734,  308,  375,  236,  364,  740,
			  739,  362,  360,  -10,  107,  -55,  -75,  -75,  191,  335,
			  329,  708,  -55,  343,  326,  750,  322,  -55,  191,  209,
			  319,  -55,  310,  292,  -75,  -55,  708,  714,  291,  256,
			  259,  -75,  254,  252,  -12,  -12,  -75,  251,  773,  774,
			  -75,  242,  -12, -298,  -75,  735,  683,  782,  785,  788,
			  792,  215,  750,    3,  -12,  682,  -12,  -12,  211,  800,
			  192,  681,  169, -184, -184,  -12,  680, -184,  550,  164,
			  146, -184,  758,  762,  577,  463, -184,  679,  462,  526,

			  678,  677,  461, -184,  807,  163, -184,  498,  632,  302,
			  566,   40,  762,  588,  676, -184,   39,  434,  644,  599,
			  542,  191,  693, -184, -184,  692,  191,   37,  386,   35,
			  433, -157, -157, -157, -157,  675,  691,  191,  180,  179,
			  178,  177,  176,  175,  174,   60, -157,  191,  191,  178,
			  177,  176,  175,  174,   60,  796,  -13,  -13,  690,  191,
			  191, -157,  689,  688,  -13,  191,  687,  686,  651, -157,
			 -157, -157,  348,  514,   62,   61,  -13,  534,  -13,  -13,
			  519,   60,   59,   58,   57,  777,   56,  -13,  529,   55,
			   54,   53,   52,    3,   51,   50,  450,  738,   49,  191,

			  191,   48,  344,   47,  583,  314,  313,  684,   45,  347,
			    0,   44,   43,    0,   42,    0,    0,    0,    0,    0,
			   41,    0,    0,    0,    0,    0,  191,    0,    0,    0,
			    0,   40,    0,    0,    0,    0,   39,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   38,   37,   36,   35,
			    0,    0,    0,    0,    0,   34,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  312,    0,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   22,   21,   20,
			   19,   18,   17,   16,   15,   14,   13,   12,   11,   10,
			   62,   61,    0,    0,    0,    0,    0,   60,   59,   58,

			   57,    0,   56,    0,    0,   55,   54,   53,   52,    3,
			   51,   50,    0,    0,   49,    0,    0,   48,    0,   47,
			    0,    0,   46,    0,   45,    0,    0,   44,   43,    0,
			   42,    0,    0,    0,    0,    0,   41,    0,    0,    0,
			  281,    0,    0,    0,    0,    0,    0,   40,    0,    0,
			    0,    0,   39,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   38,   37,   36,   35,    0,    0,    0,    0,
			    0,   34,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   33,    0,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,   22,   21,   20,   19,   18,   17,   16,

			   15,   14,   13,   12,   11,   10,   62,   61,    0,    0,
			    0,    0,    0,   60,   59,   58,   57,    0,   56,    0,
			    0,   55,   54,   53,   52,    3,   51,   50,    0,    0,
			   49,    0,    0,   48,    0,   47,    0,    0,   46,    0,
			   45,    0,    0,   44,   43,    0,   42,    0,    0,    0,
			    0,    0,   41,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   40,    0,    0,    0,    0,   39,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   38,   37,
			   36,   35,    0,    0,    0,    0,    0,   34,    0,    0,
			    0,  278,    0,    0,    0,    0,    0,   33,    0,   32,

			   31,   30,   29,   28,   27,   26,   25,   24,   23,   22,
			   21,   20,   19,   18,   17,   16,   15,   14,   13,   12,
			   11,   10,   62,   61,    0,    0,    0,    0,    0,   60,
			   59,   58,   57,    0,   56,    0,    0,   55,   54,   53,
			   52,    3,   51,   50,    0,    0,   49,    0,    0,   48,
			    0,   47,    0,  244,   46,    0,   45,    0,    0,   44,
			   43,    0,   42,    0,    0,    0,    0,    0,   41,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   40,
			    0,    0,    0,    0,   39,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   38,   37,   36,   35,    0,    0,

			    0,    0,    0,   34,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   33,    0,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,   20,   19,   18,
			   17,   16,   15,   14,   13,   12,   11,   10,   62,   61,
			    0,    0,    0,    0,    0,   60,   59,   58,   57,    0,
			   56,    0,    0,   55,   54,   53,   52,    3,   51,   50,
			    0,    0,   49,    0,    0,   48,    0,   47,    0,    0,
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
			    0,   48,    0,   47,    0,    0,  313,    0,   45,    0,
			    0,   44,   43,    0,   42,    0,    0,    0,    0,    0,

			   41,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   40,    0,    0,    0,    0,   39,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   38,   37,   36,   35,
			    0,    0,    0,    0,    0,   34,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  312,    0,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   22,   21,   20,
			   19,   18,   17,   16,   15,   14,   13,   12,   11,   10,
			  219,  218,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  202,   54,  217,   52,    3,
			   51,   50,    0,  216,  219,  218,    0,   48,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,   44,   43,  202,
			   54,  217,   52,    3,   51,   50,    0,    0,    0,    0,
			    0,   48,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   44,   43,    0,  190,  189,  188,  187,  186,  185,
			  184,  183,  182,  181,  180,  179,  178,  177,  176,  175,
			  174,   60,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   32,   31,   30,    0,   28,   27,   26,
			   25,   24,   23,   22,   21,   20,   19,   18,   17,   16,
			   15,   14,   13,   12,   11,   10,    0,   32,   31,   30,
			    0,   28,   27,   26,   25,   24,   23,   22,   21,   20,

			   19,   18,   17,   16,   15,   14,   13,   12,   11,   10,
			  219,  218,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  202,   54,  217,   52,  803,
			   51,  188,  187,  186,  185,  184,  183,  182,  181,  180,
			  179,  178,  177,  176,  175,  174,   60,   44,   43,    0,
			    0,   52,  190,  189,  188,  187,  186,  185,  184,  183,
			  182,  181,  180,  179,  178,  177,  176,  175,  174,   60,
			    0,  582,    0,   52,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  724,    0,    0,    0,
			    0,    0,    0,  732,    0,   52,    0,  581,    0,    0,

			    0,    0,    0,   32,   31,   30,    0,   28,   27,   26,
			   25,   24,   23,   22,   21,   20,   19,   18,   17,   16,
			   15,   14,   13,   12,   11,   10,   32,   31,   30,    0,
			   28,   27,   26,   25,   24,   23,   22,   21,   20,   19,
			   18,   17,   16,   15,   14,   13,   12,   11,   10,   31,
			    0,    0,   28,   27,   26,   25,   24,   23,   22,   21,
			   20,   19,   18,   17,   16,   15,   14,   13,   12,   11,
			   10,   31,    0,    0,   28,   27,   26,   25,   24,   23,
			   22,   21,   20,   19,   18,   17,   16,   15,   14,   13,
			   12,   11,   10,  190,  189,  188,  187,  186,  185,  184,

			  183,  182,  181,  180,  179,  178,  177,  176,  175,  174,
			   60,  190,  189,  188,  187,  186,  185,  184,  183,  182,
			  181,  180,  179,  178,  177,  176,  175,  174,   60,  190,
			  189,  188,  187,  186,  185,  184,  183,  182,  181,  180,
			  179,  178,  177,  176,  175,  174,   60,    0,  190,  189,
			  188,  187,  186,  185,  184,  183,  182,  181,  180,  179,
			  178,  177,  176,  175,  174,   60,    0,    0,    0,    0,
			  324,  189,  188,  187,  186,  185,  184,  183,  182,  181,
			  180,  179,  178,  177,  176,  175,  174,   60,  723,  311,
			  797,  190,  189,  188,  187,  186,  185,  184,  183,  182,

			  181,  180,  179,  178,  177,  176,  175,  174,   60,  144,
			  143,  142,  141,  140,  139,  138,  137,  136,  135,  134,
			  133,  132,  131,  130,  129,  128,    0,  127,    0,    0,
			    0,    0,  260,  190,  189,  188,  187,  186,  185,  184,
			  183,  182,  181,  180,  179,  178,  177,  176,  175,  174,
			   60,  187,  186,  185,  184,  183,  182,  181,  180,  179,
			  178,  177,  176,  175,  174,   60,  186,  185,  184,  183,
			  182,  181,  180,  179,  178,  177,  176,  175,  174,   60>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  146,   38,    2,   94,  106,  106,    4,  106,    9,
			    8,  106,   42,  383,  373,  537,   33,  103,  437,  148,
			  451,   26,  365,  494,   33,   40,  416,   33,   33,   46,
			  169,   74,  451,  197,  198,   46,   36,  201,   40,   33,
			  614,   66,   30,  617,  173,   33,   42,   38,   39,   46,
			   75,   66,  523,   50,   60,   60,   28,   56,   57,  258,
			   59,   33,   61,   62,   33,   26,  195,  196,  458,  492,
			  106,   76,   33,  647,   73,  506,  547,   71,   95,   90,
			   91,   75,   93,   71,   89,   46,   95,  506,   42,   33,
			   95,   60,   92,  667,   94,   33,   26,   99,   33,   60,

			   49,   36,   46,  526,   76,  679,  106,  306,  307,  109,
			   33,   68,  123,   70,   49,   76,   46,   89,    0,  318,
			  119,  118,  696,   46,  323,  124,  212,  213,   89,   66,
			   72,  521,   76,   68,   95,  731,   78,   48,   76,  338,
			  662,   98,   40,    0,  105,   89,   81,   45,  148,  160,
			  746,   89,   33,  152,   96,   66,   91,   94,  107,  108,
			  530,  531,  634,   98,  363,  165,   47,  164,   33,  169,
			  642,   33,   66,  173,   36,  174,  175,  176,  177,  178,
			  179,  180,  181,  182,  183,  184,  185,  186,  187,  188,
			  189,  190,  191,  236,  393,  195,  196,   71,  147,  589,

			  211,   26,  303,  303,  333,  303,   68,   25,  303,   14,
			   15,   47,  376,  377,   39,  605,  380,   66,   33,   81,
			  115,  116,   33,   33,   29,   36,   36,   25,   33,   91,
			   26,  231,  232,  128,  129,   46,   98,   25,   25,   49,
			   38,  240,  242,  192,   40,   37,   25,  452,  248,  454,
			  455,   38,  457,  252,   46,   40,   33,   68,   68,   38,
			  650,   76,   47,  353,   25,   33,   71,  303,   36,   33,
			   81,   81,  436,  478,   89,   65,  319,  636,   46,  278,
			   91,   91,  281,  157,  489,  285,  431,   98,   98,  570,
			  102,  103,   53,  167,  168,   56,  170,  171,  172,   76,

			   68,  582,  313,  303,   62,  254,  255,   40,  308,   64,
			  259,   40,   89,   81,   47,   73,  313,   62,   63,  193,
			   49,  364,  321,   91,   40,   70,   40,  327,    3,   53,
			   98,   47,   56,  333,  334,   49,    3,   82,  349,  350,
			   85,  352,  701,  340,  387,   37,   58,  296,   40,  392,
			   62,  351,    3,  353,   66,    3,   68,  356,   70,  395,
			  360,   73,   14,   15,  707,  239,  366,   75,  368,  412,
			   40,  245,   80,   46,   40,   45,  250,   29,   30,   45,
			  329,   33,   40,  332,   66,  744,   98,   45,   64,   25,
			   66,  265,  266,  267,  268,  269,  270,  271,  272,  273,

			  274,  275,  276,  277,  747,  279,  280,   47,  282,  283,
			  284,   66,   41,  362,  102,   41,  446,  428,  448,   71,
			   36,  764,  452,  104,  454,  455,  456,  457,   14,   15,
			   59,   64,  625,   59,  445,  384,   64,   66,   66,   35,
			   66,  315,   71,   29,   47,   71,   75,   33,  478,   75,
			   79,  325,  448,   79,   66,  648,   62,   63,  103,  489,
			  456,  654,  336,  337,   70,   38,   39,  416,  417,  569,
			   25,  569,  502,  503,  569,   29,  615,   31,  427,   85,
			   26,  430,  512,  622,   29,  359,   31,  517,  518,   25,
			  501,  440,  446,  109,  448,   47,   48,  581,  452,  583,

			  454,  455,  456,  457,   20,   21,  502,  503,   25,  702,
			   37,  767,  768,  769,  770,   66,  512,   47,   48,   25,
			   79,  517,  518,   37,  478,   37,   66,  476,   94,   99,
			  723,   27,  148,  569,   67,  489,  536,   64,   65,   66,
			   67,   39,   64,  736,   82,   40,   93,   49,  502,  503,
			   84,   66,   79,   66,  554,   75,   48,  173,  512,  556,
			   39,   66,   66,  517,  518,   45,   71,   94,   73,   66,
			   75,   45,   75,   97,   79,  102,  103,  104,  771,  195,
			  196,   27,  775,   66,   66,   39,   69,   73,   66,  587,
			  590,  590,  541,  593,   79,   41,   42,  594,  596,   90,

			   40,   46,   46,  552,  797,   46,  100,   90,  607,   92,
			  803,   66,   40,   59,   97,  615,   55,  100,   71,   40,
			   66,  766,  622,   66,   66,   71,  242,  576,   71,   75,
			   73,   77,   75,   79,   69,  735,   79,   41,   84,   42,
			   59,   48,   37,  640,  106,  735,   33,    4,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   50,  666,  767,  768,  680,
			  770,  620,  772,  672,   26,  624,  106,  676,  768,  769,
			  770,  681,  772,   58,  683,  682,   47,   62,   47,   47,
			   40,   66,  308,   68,  643,   70,   49,   77,   73,  698,

			  699,   26,   47,   37,  653,   87,   47,   41,   42,  706,
			   47,   47,   47,  712,  713,   25,   48,  333,   87,  719,
			  719,   47,   25,   98,   38,   59,   41,   42,  602,   45,
			   47,  731,   66,   66,   47,  735,   47,   71,  612,   70,
			   47,   75,   47,   29,   59,   79,  746,  104,   29,   44,
			   35,   66,  106,   40,   62,   63,   71,   49,  757,  758,
			   75,   25,   70,   25,   79,  714,   26,  767,  768,  769,
			  770,   39,  772,   33,   82,   35,   84,   85,   58,  778,
			   38,   41,   26,   62,   63,   93,   46,   66,  535,   46,
			   46,   70,  741,  742,  559,  444,   75,   57,  444,  499,

			   60,   61,  444,   82,  804,   47,   85,  464,  622,  225,
			  554,   71,  761,  575,   74,   94,   76,  427,  635,  585,
			  517,  695,  666,  102,  103,  666,  700,   87,  356,   89,
			  420,   64,   65,   66,   67,   95,  666,  711,   14,   15,
			   16,   17,   18,   19,   20,   21,   79,  721,  722,   16,
			   17,   18,   19,   20,   21,  772,   62,   63,  666,  733,
			  734,   94,  666,  666,   70,  739,  666,  666,  642,  102,
			  103,  104,  308,  477,   14,   15,   82,  509,   84,   85,
			  488,   21,   22,   23,   24,  761,   26,   93,  503,   29,
			   30,   31,   32,   33,   34,   35,  440,  717,   38,  773,

			  774,   41,  303,   43,  569,   45,   46,  666,   48,  308,
			   -1,   51,   52,   -1,   54,   -1,   -1,   -1,   -1,   -1,
			   60,   -1,   -1,   -1,   -1,   -1,  800,   -1,   -1,   -1,
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
			   54,   -1,   -1,   -1,   -1,   -1,   60,   -1,   -1,   -1,
			   64,   -1,   -1,   -1,   -1,   -1,   -1,   71,   -1,   -1,
			   -1,   -1,   76,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   86,   87,   88,   89,   -1,   -1,   -1,   -1,
			   -1,   95,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  105,   -1,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,

			  124,  125,  126,  127,  128,  129,   14,   15,   -1,   -1,
			   -1,   -1,   -1,   21,   22,   23,   24,   -1,   26,   -1,
			   -1,   29,   30,   31,   32,   33,   34,   35,   -1,   -1,
			   38,   -1,   -1,   41,   -1,   43,   -1,   -1,   46,   -1,
			   48,   -1,   -1,   51,   52,   -1,   54,   -1,   -1,   -1,
			   -1,   -1,   60,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   71,   -1,   -1,   -1,   -1,   76,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   86,   87,
			   88,   89,   -1,   -1,   -1,   -1,   -1,   95,   -1,   -1,
			   -1,   99,   -1,   -1,   -1,   -1,   -1,  105,   -1,  107,

			  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,   14,   15,   -1,   -1,   -1,   -1,   -1,   21,
			   22,   23,   24,   -1,   26,   -1,   -1,   29,   30,   31,
			   32,   33,   34,   35,   -1,   -1,   38,   -1,   -1,   41,
			   -1,   43,   -1,   45,   46,   -1,   48,   -1,   -1,   51,
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
			   14,   15,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   29,   30,   31,   32,   33,
			   34,   35,   -1,   37,   14,   15,   -1,   41,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   51,   52,   29,
			   30,   31,   32,   33,   34,   35,   -1,   -1,   -1,   -1,
			   -1,   41,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   51,   52,   -1,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  107,  108,  109,   -1,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,   -1,  107,  108,  109,
			   -1,  111,  112,  113,  114,  115,  116,  117,  118,  119,

			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			   14,   15,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   29,   30,   31,   32,   99,
			   34,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   51,   52,   -1,
			   -1,   32,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   -1,   75,   -1,   32,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   45,   -1,   -1,   -1,
			   -1,   -1,   -1,   45,   -1,   32,   -1,  101,   -1,   -1,

			   -1,   -1,   -1,  107,  108,  109,   -1,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  107,  108,  109,   -1,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  108,
			   -1,   -1,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  108,   -1,   -1,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,    4,    5,    6,    7,    8,    9,   10,

			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   -1,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   -1,   -1,   -1,   -1,
			   45,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   99,   45,
			   83,    4,    5,    6,    7,    8,    9,   10,   11,   12,

			   13,   14,   15,   16,   17,   18,   19,   20,   21,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,   -1,  129,   -1,   -1,
			   -1,   -1,   45,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21>>)
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

	yyFinal: INTEGER is 810
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 130
			-- Number of tokens

	yyLast: INTEGER is 2079
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
