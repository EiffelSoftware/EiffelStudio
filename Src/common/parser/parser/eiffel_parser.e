indexing

	description: "Eiffel parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_PARSER

inherit

	EIFFEL_PARSER_SKELETON

creation

	make


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
			inspect yy_act
when 1 then
--|#line 157
	yy_do_action_1
when 2 then
--|#line 185
	yy_do_action_2
when 3 then
--|#line 187
	yy_do_action_3
when 4 then
--|#line 189
	yy_do_action_4
when 5 then
--|#line 191
	yy_do_action_5
when 6 then
--|#line 193
	yy_do_action_6
when 7 then
--|#line 195
	yy_do_action_7
when 8 then
--|#line 197
	yy_do_action_8
when 9 then
--|#line 199
	yy_do_action_9
when 10 then
--|#line 203
	yy_do_action_10
when 11 then
--|#line 214
	yy_do_action_11
when 12 then
--|#line 224
	yy_do_action_12
when 13 then
--|#line 234
	yy_do_action_13
when 14 then
--|#line 244
	yy_do_action_14
when 15 then
--|#line 254
	yy_do_action_15
when 16 then
--|#line 264
	yy_do_action_16
when 17 then
--|#line 274
	yy_do_action_17
when 18 then
--|#line 288
	yy_do_action_18
when 19 then
--|#line 293
	yy_do_action_19
when 20 then
--|#line 298
	yy_do_action_20
when 21 then
--|#line 305
	yy_do_action_21
when 22 then
--|#line 311
	yy_do_action_22
when 23 then
--|#line 319
	yy_do_action_23
when 24 then
--|#line 326
	yy_do_action_24
when 25 then
--|#line 328
	yy_do_action_25
when 26 then
--|#line 335
	yy_do_action_26
when 27 then
--|#line 341
	yy_do_action_27
when 28 then
--|#line 343
	yy_do_action_28
when 29 then
--|#line 350
	yy_do_action_29
when 30 then
--|#line 356
	yy_do_action_30
when 31 then
--|#line 364
	yy_do_action_31
when 32 then
--|#line 366
	yy_do_action_32
when 33 then
--|#line 374
	yy_do_action_33
when 34 then
--|#line 381
	yy_do_action_34
when 35 then
--|#line 388
	yy_do_action_35
when 36 then
--|#line 395
	yy_do_action_36
when 37 then
--|#line 408
	yy_do_action_37
when 38 then
--|#line 413
	yy_do_action_38
when 39 then
--|#line 424
	yy_do_action_39
when 40 then
--|#line 429
	yy_do_action_40
when 41 then
--|#line 439
	yy_do_action_41
when 42 then
--|#line 447
	yy_do_action_42
when 43 then
--|#line 457
	yy_do_action_43
when 44 then
--|#line 457
	yy_do_action_44
when 45 then
--|#line 474
	yy_do_action_45
when 46 then
--|#line 479
	yy_do_action_46
when 47 then
--|#line 486
	yy_do_action_47
when 48 then
--|#line 494
	yy_do_action_48
when 49 then
--|#line 499
	yy_do_action_49
when 50 then
--|#line 505
	yy_do_action_50
when 51 then
--|#line 513
	yy_do_action_51
when 52 then
--|#line 519
	yy_do_action_52
when 53 then
--|#line 523
	yy_do_action_53
when 54 then
--|#line 529
	yy_do_action_54
when 55 then
--|#line 535
	yy_do_action_55
when 56 then
--|#line 541
	yy_do_action_56
when 57 then
--|#line 549
	yy_do_action_57
when 58 then
--|#line 553
	yy_do_action_58
when 59 then
--|#line 558
	yy_do_action_59
when 60 then
--|#line 564
	yy_do_action_60
when 61 then
--|#line 568
	yy_do_action_61
when 62 then
--|#line 575
	yy_do_action_62
when 65 then
--|#line 587
	yy_do_action_65
when 66 then
--|#line 594
	yy_do_action_66
when 67 then
--|#line 602
	yy_do_action_67
when 68 then
--|#line 606
	yy_do_action_68
when 69 then
--|#line 615
	yy_do_action_69
when 70 then
--|#line 622
	yy_do_action_70
when 71 then
--|#line 629
	yy_do_action_71
when 72 then
--|#line 634
	yy_do_action_72
when 73 then
--|#line 641
	yy_do_action_73
when 74 then
--|#line 649
	yy_do_action_74
when 75 then
--|#line 651
	yy_do_action_75
when 76 then
--|#line 655
	yy_do_action_76
when 77 then
--|#line 666
	yy_do_action_77
when 78 then
--|#line 676
	yy_do_action_78
when 79 then
--|#line 693
	yy_do_action_79
when 80 then
--|#line 710
	yy_do_action_80
when 81 then
--|#line 731
	yy_do_action_81
when 82 then
--|#line 736
	yy_do_action_82
when 83 then
--|#line 743
	yy_do_action_83
when 84 then
--|#line 750
	yy_do_action_84
when 85 then
--|#line 758
	yy_do_action_85
when 86 then
--|#line 766
	yy_do_action_86
when 87 then
--|#line 771
	yy_do_action_87
when 88 then
--|#line 776
	yy_do_action_88
when 89 then
--|#line 783
	yy_do_action_89
when 90 then
--|#line 789
	yy_do_action_90
when 91 then
--|#line 795
	yy_do_action_91
when 92 then
--|#line 799
	yy_do_action_92
when 93 then
--|#line 806
	yy_do_action_93
when 94 then
--|#line 814
	yy_do_action_94
when 95 then
--|#line 816
	yy_do_action_95
when 96 then
--|#line 823
	yy_do_action_96
when 97 then
--|#line 831
	yy_do_action_97
when 98 then
--|#line 838
	yy_do_action_98
when 99 then
--|#line 845
	yy_do_action_99
when 100 then
--|#line 852
	yy_do_action_100
when 101 then
--|#line 859
	yy_do_action_101
when 102 then
--|#line 866
	yy_do_action_102
when 103 then
--|#line 875
	yy_do_action_103
when 104 then
--|#line 880
	yy_do_action_104
when 105 then
--|#line 887
	yy_do_action_105
when 106 then
--|#line 893
	yy_do_action_106
when 107 then
--|#line 899
	yy_do_action_107
when 108 then
--|#line 903
	yy_do_action_108
when 109 then
--|#line 910
	yy_do_action_109
when 110 then
--|#line 918
	yy_do_action_110
when 111 then
--|#line 926
	yy_do_action_111
when 112 then
--|#line 931
	yy_do_action_112
when 113 then
--|#line 935
	yy_do_action_113
when 114 then
--|#line 940
	yy_do_action_114
when 115 then
--|#line 947
	yy_do_action_115
when 116 then
--|#line 953
	yy_do_action_116
when 117 then
--|#line 957
	yy_do_action_117
when 118 then
--|#line 963
	yy_do_action_118
when 119 then
--|#line 971
	yy_do_action_119
when 120 then
--|#line 981
	yy_do_action_120
when 121 then
--|#line 986
	yy_do_action_121
when 122 then
--|#line 992
	yy_do_action_122
when 123 then
--|#line 998
	yy_do_action_123
when 124 then
--|#line 1004
	yy_do_action_124
when 125 then
--|#line 1008
	yy_do_action_125
when 126 then
--|#line 1015
	yy_do_action_126
when 127 then
--|#line 1023
	yy_do_action_127
when 128 then
--|#line 1028
	yy_do_action_128
when 129 then
--|#line 1032
	yy_do_action_129
when 130 then
--|#line 1037
	yy_do_action_130
when 131 then
--|#line 1044
	yy_do_action_131
when 132 then
--|#line 1049
	yy_do_action_132
when 133 then
--|#line 1053
	yy_do_action_133
when 134 then
--|#line 1058
	yy_do_action_134
when 135 then
--|#line 1065
	yy_do_action_135
when 136 then
--|#line 1070
	yy_do_action_136
when 137 then
--|#line 1074
	yy_do_action_137
when 138 then
--|#line 1079
	yy_do_action_138
when 139 then
--|#line 1090
	yy_do_action_139
when 140 then
--|#line 1100
	yy_do_action_140
when 141 then
--|#line 1107
	yy_do_action_141
when 142 then
--|#line 1111
	yy_do_action_142
when 143 then
--|#line 1116
	yy_do_action_143
when 144 then
--|#line 1122
	yy_do_action_144
when 145 then
--|#line 1129
	yy_do_action_145
when 146 then
--|#line 1133
	yy_do_action_146
when 147 then
--|#line 1141
	yy_do_action_147
when 148 then
--|#line 1149
	yy_do_action_148
when 149 then
--|#line 1156
	yy_do_action_149
when 150 then
--|#line 1162
	yy_do_action_150
when 151 then
--|#line 1168
	yy_do_action_151
when 152 then
--|#line 1172
	yy_do_action_152
when 153 then
--|#line 1179
	yy_do_action_153
when 154 then
--|#line 1187
	yy_do_action_154
when 155 then
--|#line 1191
	yy_do_action_155
when 156 then
--|#line 1195
	yy_do_action_156
when 157 then
--|#line 1200
	yy_do_action_157
when 158 then
--|#line 1208
	yy_do_action_158
when 159 then
--|#line 1208
	yy_do_action_159
when 160 then
--|#line 1221
	yy_do_action_160
when 161 then
--|#line 1223
	yy_do_action_161
when 162 then
--|#line 1225
	yy_do_action_162
when 163 then
--|#line 1232
	yy_do_action_163
when 164 then
--|#line 1239
	yy_do_action_164
when 165 then
--|#line 1239
	yy_do_action_165
when 166 then
--|#line 1251
	yy_do_action_166
when 167 then
--|#line 1256
	yy_do_action_167
when 168 then
--|#line 1263
	yy_do_action_168
when 169 then
--|#line 1268
	yy_do_action_169
when 170 then
--|#line 1275
	yy_do_action_170
when 171 then
--|#line 1280
	yy_do_action_171
when 172 then
--|#line 1287
	yy_do_action_172
when 173 then
--|#line 1291
	yy_do_action_173
when 174 then
--|#line 1296
	yy_do_action_174
when 175 then
--|#line 1302
	yy_do_action_175
when 176 then
--|#line 1309
	yy_do_action_176
when 177 then
--|#line 1317
	yy_do_action_177
when 178 then
--|#line 1323
	yy_do_action_178
when 179 then
--|#line 1332
	yy_do_action_179
when 180 then
--|#line 1339
	yy_do_action_180
when 183 then
--|#line 1349
	yy_do_action_183
when 184 then
--|#line 1351
	yy_do_action_184
when 185 then
--|#line 1353
	yy_do_action_185
when 186 then
--|#line 1355
	yy_do_action_186
when 187 then
--|#line 1357
	yy_do_action_187
when 188 then
--|#line 1359
	yy_do_action_188
when 189 then
--|#line 1361
	yy_do_action_189
when 190 then
--|#line 1363
	yy_do_action_190
when 191 then
--|#line 1365
	yy_do_action_191
when 192 then
--|#line 1367
	yy_do_action_192
when 193 then
--|#line 1371
	yy_do_action_193
when 194 then
--|#line 1376
	yy_do_action_194
when 195 then
--|#line 1376
	yy_do_action_195
when 196 then
--|#line 1387
	yy_do_action_196
when 197 then
--|#line 1387
	yy_do_action_197
when 198 then
--|#line 1400
	yy_do_action_198
when 199 then
--|#line 1405
	yy_do_action_199
when 200 then
--|#line 1405
	yy_do_action_200
when 201 then
--|#line 1416
	yy_do_action_201
when 202 then
--|#line 1416
	yy_do_action_202
when 203 then
--|#line 1429
	yy_do_action_203
when 204 then
--|#line 1433
	yy_do_action_204
when 205 then
--|#line 1442
	yy_do_action_205
when 206 then
--|#line 1450
	yy_do_action_206
when 207 then
--|#line 1466
	yy_do_action_207
when 208 then
--|#line 1470
	yy_do_action_208
when 209 then
--|#line 1483
	yy_do_action_209
when 210 then
--|#line 1493
	yy_do_action_210
when 211 then
--|#line 1499
	yy_do_action_211
when 212 then
--|#line 1504
	yy_do_action_212
when 213 then
--|#line 1509
	yy_do_action_213
when 214 then
--|#line 1520
	yy_do_action_214
when 215 then
--|#line 1522
	yy_do_action_215
when 216 then
--|#line 1530
	yy_do_action_216
when 217 then
--|#line 1538
	yy_do_action_217
when 218 then
--|#line 1543
	yy_do_action_218
when 219 then
--|#line 1548
	yy_do_action_219
when 220 then
--|#line 1553
	yy_do_action_220
when 221 then
--|#line 1560
	yy_do_action_221
when 222 then
--|#line 1566
	yy_do_action_222
when 223 then
--|#line 1572
	yy_do_action_223
when 224 then
--|#line 1578
	yy_do_action_224
when 225 then
--|#line 1584
	yy_do_action_225
when 226 then
--|#line 1590
	yy_do_action_226
when 227 then
--|#line 1596
	yy_do_action_227
when 228 then
--|#line 1602
	yy_do_action_228
when 229 then
--|#line 1610
	yy_do_action_229
when 230 then
--|#line 1614
	yy_do_action_230
when 231 then
--|#line 1619
	yy_do_action_231
when 232 then
--|#line 1626
	yy_do_action_232
when 233 then
--|#line 1632
	yy_do_action_233
when 234 then
--|#line 1638
	yy_do_action_234
when 235 then
--|#line 1642
	yy_do_action_235
when 236 then
--|#line 1649
	yy_do_action_236
when 237 then
--|#line 1661
	yy_do_action_237
when 238 then
--|#line 1666
	yy_do_action_238
when 239 then
--|#line 1673
	yy_do_action_239
when 240 then
--|#line 1677
	yy_do_action_240
when 241 then
--|#line 1683
	yy_do_action_241
when 242 then
--|#line 1687
	yy_do_action_242
when 243 then
--|#line 1693
	yy_do_action_243
when 244 then
--|#line 1701
	yy_do_action_244
when 245 then
--|#line 1701
	yy_do_action_245
when 246 then
--|#line 1717
	yy_do_action_246
when 247 then
--|#line 1722
	yy_do_action_247
when 248 then
--|#line 1729
	yy_do_action_248
when 249 then
--|#line 1734
	yy_do_action_249
when 250 then
--|#line 1745
	yy_do_action_250
when 251 then
--|#line 1753
	yy_do_action_251
when 252 then
--|#line 1757
	yy_do_action_252
when 253 then
--|#line 1762
	yy_do_action_253
when 254 then
--|#line 1766
	yy_do_action_254
when 255 then
--|#line 1773
	yy_do_action_255
when 256 then
--|#line 1781
	yy_do_action_256
when 257 then
--|#line 1788
	yy_do_action_257
when 258 then
--|#line 1793
	yy_do_action_258
when 259 then
--|#line 1803
	yy_do_action_259
when 260 then
--|#line 1808
	yy_do_action_260
when 261 then
--|#line 1815
	yy_do_action_261
when 262 then
--|#line 1823
	yy_do_action_262
when 263 then
--|#line 1827
	yy_do_action_263
when 264 then
--|#line 1832
	yy_do_action_264
when 265 then
--|#line 1836
	yy_do_action_265
when 266 then
--|#line 1842
	yy_do_action_266
when 267 then
--|#line 1850
	yy_do_action_267
when 268 then
--|#line 1857
	yy_do_action_268
when 269 then
--|#line 1863
	yy_do_action_269
when 270 then
--|#line 1867
	yy_do_action_270
when 271 then
--|#line 1873
	yy_do_action_271
when 272 then
--|#line 1881
	yy_do_action_272
when 273 then
--|#line 1886
	yy_do_action_273
when 274 then
--|#line 1891
	yy_do_action_274
when 275 then
--|#line 1896
	yy_do_action_275
when 276 then
--|#line 1901
	yy_do_action_276
when 277 then
--|#line 1906
	yy_do_action_277
when 278 then
--|#line 1911
	yy_do_action_278
when 279 then
--|#line 1916
	yy_do_action_279
when 280 then
--|#line 1921
	yy_do_action_280
when 281 then
--|#line 1926
	yy_do_action_281
when 282 then
--|#line 1933
	yy_do_action_282
when 283 then
--|#line 1941
	yy_do_action_283
when 284 then
--|#line 1946
	yy_do_action_284
when 285 then
--|#line 1953
	yy_do_action_285
when 286 then
--|#line 1958
	yy_do_action_286
when 287 then
--|#line 1958
	yy_do_action_287
when 288 then
--|#line 1972
	yy_do_action_288
when 289 then
--|#line 1977
	yy_do_action_289
when 290 then
--|#line 1982
	yy_do_action_290
when 291 then
--|#line 1989
	yy_do_action_291
when 292 then
--|#line 1997
	yy_do_action_292
when 293 then
--|#line 2002
	yy_do_action_293
when 294 then
--|#line 2007
	yy_do_action_294
when 295 then
--|#line 2014
	yy_do_action_295
when 296 then
--|#line 2020
	yy_do_action_296
when 297 then
--|#line 2024
	yy_do_action_297
when 298 then
--|#line 2030
	yy_do_action_298
when 299 then
--|#line 2038
	yy_do_action_299
when 300 then
--|#line 2045
	yy_do_action_300
when 301 then
--|#line 2050
	yy_do_action_301
when 302 then
--|#line 2060
	yy_do_action_302
when 303 then
--|#line 2067
	yy_do_action_303
when 304 then
--|#line 2076
	yy_do_action_304
when 305 then
--|#line 2083
	yy_do_action_305
when 306 then
--|#line 2092
	yy_do_action_306
when 307 then
--|#line 2097
	yy_do_action_307
when 308 then
--|#line 2101
	yy_do_action_308
when 309 then
--|#line 2107
	yy_do_action_309
when 310 then
--|#line 2111
	yy_do_action_310
when 311 then
--|#line 2117
	yy_do_action_311
when 312 then
--|#line 2125
	yy_do_action_312
when 313 then
--|#line 2131
	yy_do_action_313
when 314 then
--|#line 2137
	yy_do_action_314
when 315 then
--|#line 2147
	yy_do_action_315
when 316 then
--|#line 2151
	yy_do_action_316
when 317 then
--|#line 2157
	yy_do_action_317
when 318 then
--|#line 2162
	yy_do_action_318
when 319 then
--|#line 2167
	yy_do_action_319
when 320 then
--|#line 2174
	yy_do_action_320
when 321 then
--|#line 2178
	yy_do_action_321
when 322 then
--|#line 2184
	yy_do_action_322
when 323 then
--|#line 2189
	yy_do_action_323
when 324 then
--|#line 2193
	yy_do_action_324
when 325 then
--|#line 2198
	yy_do_action_325
when 326 then
--|#line 2205
	yy_do_action_326
when 327 then
--|#line 2210
	yy_do_action_327
when 328 then
--|#line 2221
	yy_do_action_328
when 329 then
--|#line 2226
	yy_do_action_329
when 330 then
--|#line 2231
	yy_do_action_330
when 331 then
--|#line 2236
	yy_do_action_331
when 332 then
--|#line 2241
	yy_do_action_332
when 333 then
--|#line 2246
	yy_do_action_333
when 334 then
--|#line 2251
	yy_do_action_334
when 335 then
--|#line 2258
	yy_do_action_335
when 336 then
--|#line 2269
	yy_do_action_336
when 337 then
--|#line 2275
	yy_do_action_337
when 338 then
--|#line 2281
	yy_do_action_338
when 339 then
--|#line 2287
	yy_do_action_339
when 341 then
--|#line 2293
	yy_do_action_341
when 342 then
--|#line 2298
	yy_do_action_342
when 343 then
--|#line 2304
	yy_do_action_343
when 344 then
--|#line 2310
	yy_do_action_344
when 345 then
--|#line 2316
	yy_do_action_345
when 346 then
--|#line 2322
	yy_do_action_346
when 347 then
--|#line 2328
	yy_do_action_347
when 348 then
--|#line 2334
	yy_do_action_348
when 349 then
--|#line 2340
	yy_do_action_349
when 350 then
--|#line 2346
	yy_do_action_350
when 351 then
--|#line 2352
	yy_do_action_351
when 352 then
--|#line 2358
	yy_do_action_352
when 353 then
--|#line 2364
	yy_do_action_353
when 354 then
--|#line 2370
	yy_do_action_354
when 355 then
--|#line 2376
	yy_do_action_355
when 356 then
--|#line 2382
	yy_do_action_356
when 357 then
--|#line 2388
	yy_do_action_357
when 358 then
--|#line 2394
	yy_do_action_358
when 359 then
--|#line 2400
	yy_do_action_359
when 360 then
--|#line 2406
	yy_do_action_360
when 361 then
--|#line 2412
	yy_do_action_361
when 362 then
--|#line 2418
	yy_do_action_362
when 363 then
--|#line 2424
	yy_do_action_363
when 364 then
--|#line 2430
	yy_do_action_364
when 365 then
--|#line 2436
	yy_do_action_365
when 366 then
--|#line 2442
	yy_do_action_366
when 367 then
--|#line 2448
	yy_do_action_367
when 368 then
--|#line 2456
	yy_do_action_368
when 369 then
--|#line 2458
	yy_do_action_369
when 370 then
--|#line 2464
	yy_do_action_370
when 371 then
--|#line 2470
	yy_do_action_371
when 372 then
--|#line 2476
	yy_do_action_372
when 373 then
--|#line 2484
	yy_do_action_373
when 374 then
--|#line 2495
	yy_do_action_374
when 375 then
--|#line 2497
	yy_do_action_375
when 376 then
--|#line 2499
	yy_do_action_376
when 377 then
--|#line 2501
	yy_do_action_377
when 378 then
--|#line 2506
	yy_do_action_378
when 379 then
--|#line 2511
	yy_do_action_379
when 380 then
--|#line 2513
	yy_do_action_380
when 381 then
--|#line 2515
	yy_do_action_381
when 382 then
--|#line 2517
	yy_do_action_382
when 383 then
--|#line 2519
	yy_do_action_383
when 384 then
--|#line 2523
	yy_do_action_384
when 385 then
--|#line 2532
	yy_do_action_385
when 386 then
--|#line 2541
	yy_do_action_386
when 387 then
--|#line 2548
	yy_do_action_387
when 388 then
--|#line 2555
	yy_do_action_388
when 389 then
--|#line 2562
	yy_do_action_389
when 390 then
--|#line 2567
	yy_do_action_390
when 391 then
--|#line 2573
	yy_do_action_391
when 392 then
--|#line 2579
	yy_do_action_392
when 393 then
--|#line 2587
	yy_do_action_393
when 394 then
--|#line 2589
	yy_do_action_394
when 395 then
--|#line 2593
	yy_do_action_395
when 396 then
--|#line 2598
	yy_do_action_396
when 397 then
--|#line 2605
	yy_do_action_397
when 398 then
--|#line 2621
	yy_do_action_398
when 399 then
--|#line 2628
	yy_do_action_399
when 400 then
--|#line 2633
	yy_do_action_400
when 401 then
--|#line 2638
	yy_do_action_401
when 402 then
--|#line 2645
	yy_do_action_402
when 403 then
--|#line 2651
	yy_do_action_403
when 404 then
--|#line 2657
	yy_do_action_404
when 405 then
--|#line 2664
	yy_do_action_405
when 406 then
--|#line 2672
	yy_do_action_406
when 407 then
--|#line 2677
	yy_do_action_407
when 408 then
--|#line 2686
	yy_do_action_408
when 409 then
--|#line 2694
	yy_do_action_409
when 410 then
--|#line 2698
	yy_do_action_410
when 411 then
--|#line 2704
	yy_do_action_411
when 412 then
--|#line 2710
	yy_do_action_412
when 413 then
--|#line 2717
	yy_do_action_413
when 414 then
--|#line 2721
	yy_do_action_414
when 415 then
--|#line 2729
	yy_do_action_415
when 416 then
--|#line 2741
	yy_do_action_416
when 417 then
--|#line 2746
	yy_do_action_417
when 418 then
--|#line 2750
	yy_do_action_418
when 419 then
--|#line 2754
	yy_do_action_419
when 420 then
--|#line 2758
	yy_do_action_420
when 421 then
--|#line 2762
	yy_do_action_421
when 422 then
--|#line 2766
	yy_do_action_422
when 423 then
--|#line 2770
	yy_do_action_423
when 424 then
--|#line 2776
	yy_do_action_424
when 425 then
--|#line 2778
	yy_do_action_425
when 426 then
--|#line 2780
	yy_do_action_426
when 427 then
--|#line 2782
	yy_do_action_427
when 428 then
--|#line 2784
	yy_do_action_428
when 429 then
--|#line 2786
	yy_do_action_429
when 430 then
--|#line 2790
	yy_do_action_430
when 431 then
--|#line 2792
	yy_do_action_431
when 432 then
--|#line 2794
	yy_do_action_432
when 433 then
--|#line 2803
	yy_do_action_433
when 434 then
--|#line 2808
	yy_do_action_434
when 435 then
--|#line 2810
	yy_do_action_435
when 436 then
--|#line 2814
	yy_do_action_436
when 437 then
--|#line 2819
	yy_do_action_437
when 438 then
--|#line 2826
	yy_do_action_438
when 439 then
--|#line 2834
	yy_do_action_439
when 440 then
--|#line 2843
	yy_do_action_440
when 441 then
--|#line 2852
	yy_do_action_441
when 442 then
--|#line 2863
	yy_do_action_442
when 443 then
--|#line 2868
	yy_do_action_443
when 444 then
--|#line 2873
	yy_do_action_444
when 445 then
--|#line 2881
	yy_do_action_445
when 446 then
--|#line 2890
	yy_do_action_446
when 447 then
--|#line 2895
	yy_do_action_447
when 448 then
--|#line 2902
	yy_do_action_448
when 449 then
--|#line 2909
	yy_do_action_449
when 450 then
--|#line 2916
	yy_do_action_450
when 451 then
--|#line 2923
	yy_do_action_451
when 452 then
--|#line 2930
	yy_do_action_452
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 157
		local

		do
			yyval := yyval_default;
				!! root_node.make (yytype81 (yyvs.item (yyvsp - 7)).first,
					is_deferred, is_expanded, is_separate,
					yytype71 (yyvs.item (yyvsp - 10)), yytype69 (yyvs.item (yyvsp - 6)), yytype74 (yyvs.item (yyvsp - 4)), yytype61 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp - 2)), yytype39 (yyvs.item (yyvsp - 1)), suppliers, yytype53 (yyvs.item (yyvsp - 5)), click_list,
					current_position.start_position)
				yytype81 (yyvs.item (yyvsp - 7)).second.set_node (root_node)
				yacc_error_code := 2
--!! f.make_open_append ("gibi.txt")
--f.put_string (filename)
--f.put_string ("     ")
--f.put_integer (click_list.count)
--f.new_line
--f.close
			

		end

	yy_do_action_2 is
			--|#line 185
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_3 is
			--|#line 187
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_4 is
			--|#line 189
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_5 is
			--|#line 191
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_6 is
			--|#line 193
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_7 is
			--|#line 195
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_8 is
			--|#line 197
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_9 is
			--|#line 199
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_10 is
			--|#line 203
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

				!! id_as.make (token_buffer)
				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! yyval81
				yyval81.set_first (id_as)
				yyval81.set_second (clickable)
			
			yyval := yyval81
		end

	yy_do_action_11 is
			--|#line 214
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! yyval81
				yyval81.set_first (Boolean_id_as)
				yyval81.set_second (clickable)
			
			yyval := yyval81
		end

	yy_do_action_12 is
			--|#line 224
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! yyval81
				yyval81.set_first (Character_id_as)
				yyval81.set_second (clickable)
			
			yyval := yyval81
		end

	yy_do_action_13 is
			--|#line 234
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! yyval81
				yyval81.set_first (Double_id_as)
				yyval81.set_second (clickable)
			
			yyval := yyval81
		end

	yy_do_action_14 is
			--|#line 244
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! yyval81
				yyval81.set_first (Integer_id_as)
				yyval81.set_second (clickable)
			
			yyval := yyval81
		end

	yy_do_action_15 is
			--|#line 254
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! yyval81
				yyval81.set_first (None_id_as)
				yyval81.set_second (clickable)
			
			yyval := yyval81
		end

	yy_do_action_16 is
			--|#line 264
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! yyval81
				yyval81.set_first (Pointer_id_as)
				yyval81.set_second (clickable)
			
			yyval := yyval81
		end

	yy_do_action_17 is
			--|#line 274
		local
			yyval81: PAIR [ID_AS, CLICK_AST]
		do

				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! yyval81
				yyval81.set_first (Real_id_as)
				yyval81.set_second (clickable)
			
			yyval := yyval81
		end

	yy_do_action_18 is
			--|#line 288
		local
			yyval71: EIFFEL_LIST [INDEX_AS]
		do

				yyval71 := Void
				yacc_error_code := 5
			
			yyval := yyval71
		end

	yy_do_action_19 is
			--|#line 293
		local
			yyval71: EIFFEL_LIST [INDEX_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp))
				yacc_error_code := 7
			
			yyval := yyval71
		end

	yy_do_action_20 is
			--|#line 298
		local
			yyval71: EIFFEL_LIST [INDEX_AS]
		do

				yyval71 := Void
				yacc_error_code := 8
			
			yyval := yyval71
		end

	yy_do_action_21 is
			--|#line 305
		local
			yyval71: EIFFEL_LIST [INDEX_AS]
		do

				!! yyval71.make (Initial_index_list_size)
				yyval71.extend (yytype32 (yyvs.item (yyvsp)))
				yacc_error_code := 9
			
			yyval := yyval71
		end

	yy_do_action_22 is
			--|#line 311
		local
			yyval71: EIFFEL_LIST [INDEX_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 1))
				yyval71.extend (yytype32 (yyvs.item (yyvsp)))
				yacc_error_code := 10
			
			yyval := yyval71
		end

	yy_do_action_23 is
			--|#line 319
		local
			yyval32: INDEX_AS
		do

				!! yyval32.make (yytype30 (yyvs.item (yyvsp - 2)), yytype59 (yyvs.item (yyvsp - 1)))
				yacc_error_code := 12
			
			yyval := yyval32
		end

	yy_do_action_24 is
			--|#line 326
		local
			yyval30: ID_AS
		do

yyval30 := yytype30 (yyvs.item (yyvsp - 1)) 
			yyval := yyval30
		end

	yy_do_action_25 is
			--|#line 328
		local
			yyval30: ID_AS
		do

				yyval30 := Void
				yacc_error_code := 14
			
			yyval := yyval30
		end

	yy_do_action_26 is
			--|#line 335
		local
			yyval59: EIFFEL_LIST [ATOMIC_AS]
		do

				!! yyval59.make (1)
				yyval59.extend (yytype6 (yyvs.item (yyvsp)))
				yacc_error_code := 15
			
			yyval := yyval59
		end

	yy_do_action_27 is
			--|#line 341
		local
			yyval59: EIFFEL_LIST [ATOMIC_AS]
		do

yyval59 := yytype59 (yyvs.item (yyvsp)) 
			yyval := yyval59
		end

	yy_do_action_28 is
			--|#line 343
		local
			yyval59: EIFFEL_LIST [ATOMIC_AS]
		do

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				!! yyval59.make (0)
			
			yyval := yyval59
		end

	yy_do_action_29 is
			--|#line 350
		local
			yyval59: EIFFEL_LIST [ATOMIC_AS]
		do

				!! yyval59.make (Initial_index_terms_size)
				yyval59.extend (yytype6 (yyvs.item (yyvsp - 2)))
				yyval59.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval59
		end

	yy_do_action_30 is
			--|#line 356
		local
			yyval59: EIFFEL_LIST [ATOMIC_AS]
		do

				yyval59 := yytype59 (yyvs.item (yyvsp - 2))
				yyval59.extend (yytype6 (yyvs.item (yyvsp)))
				yacc_error_code := 16
			
			yyval := yyval59
		end

	yy_do_action_31 is
			--|#line 364
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype30 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_32 is
			--|#line 366
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_33 is
			--|#line 374
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := False
				yacc_error_code := 19
			

		end

	yy_do_action_34 is
			--|#line 381
		local

		do
			yyval := yyval_default;
				is_deferred := True
				is_expanded := False
				is_separate := False
				yacc_error_code := 20
			

		end

	yy_do_action_35 is
			--|#line 388
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := True
				is_separate := False
				yacc_error_code := 21
			

		end

	yy_do_action_36 is
			--|#line 395
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := True
				yacc_error_code := 22
			

		end

	yy_do_action_37 is
			--|#line 408
		local
			yyval53: STRING_AS
		do

				yyval53 := Void
				yacc_error_code := 23
			
			yyval := yyval53
		end

	yy_do_action_38 is
			--|#line 413
		local
			yyval53: STRING_AS
		do

				yyval53 := yytype53 (yyvs.item (yyvsp))
				yacc_error_code := 24
			
			yyval := yyval53
		end

	yy_do_action_39 is
			--|#line 424
		local
			yyval66: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval66 := Void
				yacc_error_code := 25
			
			yyval := yyval66
		end

	yy_do_action_40 is
			--|#line 429
		local
			yyval66: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval66 := yytype66 (yyvs.item (yyvsp))
				if yyval66.empty then
					yyval66 := Void
				end
				yacc_error_code := 27
			
			yyval := yyval66
		end

	yy_do_action_41 is
			--|#line 439
		local
			yyval66: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				!! yyval66.make (Initial_feature_clause_list_size)
				if yytype27 (yyvs.item (yyvsp)) /= Void then
					yyval66.extend (yytype27 (yyvs.item (yyvsp)))
				end
				yacc_error_code := 28
			
			yyval := yyval66
		end

	yy_do_action_42 is
			--|#line 447
		local
			yyval66: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval66 := yytype66 (yyvs.item (yyvsp - 1))
				if yytype27 (yyvs.item (yyvsp)) /= Void then
					yyval66.extend (yytype27 (yyvs.item (yyvsp)))
				end
				yacc_error_code := 29
			
			yyval := yyval66
		end

	yy_do_action_43 is
			--|#line 457
		local
			yyval27: FEATURE_CLAUSE_AS
		do

				if yytype65 (yyvs.item (yyvsp)) = Void then
					yyval27 := Void
				else
					!! yyval27.make (yytype14 (yyvs.item (yyvsp - 1)), yytype65 (yyvs.item (yyvsp)), fclause_pos)
				end
				yacc_error_code := 32
			
			yyval := yyval27
		end

	yy_do_action_44 is
			--|#line 457
		local

		do
			yyval := yyval_default;
				inherit_context := False
				fclause_pos := current_position.end_position
				yacc_error_code := 30
			

		end

	yy_do_action_45 is
			--|#line 474
		local
			yyval14: CLIENT_AS
		do

				yyval14 := Void
				yacc_error_code := 33
			
			yyval := yyval14
		end

	yy_do_action_46 is
			--|#line 479
		local
			yyval14: CLIENT_AS
		do

				!! yyval14.make (yytype70 (yyvs.item (yyvsp)))
				yacc_error_code:= 34
			
			yyval := yyval14
		end

	yy_do_action_47 is
			--|#line 486
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

				!! yyval70.make (1)
!! id_as.make ("none")
yyval70.extend (id_as)
--				dollar_list ($$).extend (create {ID_AS}.make ("none"))
				yacc_error_code := 35
			
			yyval := yyval70
		end

	yy_do_action_48 is
			--|#line 494
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

				yyval70 := yytype70 (yyvs.item (yyvsp - 1))
				yacc_error_code := 37
			
			yyval := yyval70
		end

	yy_do_action_49 is
			--|#line 499
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

				yacc_error_code := 9999
				print ("error 9999%N")
				report_error ("")
			
			yyval := yyval70
		end

	yy_do_action_50 is
			--|#line 505
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

				yacc_error_code := 8888
				print ("error 88888%N")
				report_error ("")
			
			yyval := yyval70
		end

	yy_do_action_51 is
			--|#line 513
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

				!! yyval70.make (1)
				yyval70.extend (yytype30 (yyvs.item (yyvsp)))
				yacc_error_code := 38
			
			yyval := yyval70
		end

	yy_do_action_52 is
			--|#line 519
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_53 is
			--|#line 523
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

				!! yyval70.make (Initial_class_list_size)
				yyval70.extend (yytype30 (yyvs.item (yyvsp - 2)))
				yyval70.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_54 is
			--|#line 529
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

				yyval70 := yytype70 (yyvs.item (yyvsp - 2))
				yyval70.extend (yytype30 (yyvs.item (yyvsp)))
				yacc_error_code := 39
			
			yyval := yyval70
		end

	yy_do_action_55 is
			--|#line 535
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

				yacc_error_code := 77777
				print ("error 77777%N")
				report_error ("")
			
			yyval := yyval70
		end

	yy_do_action_56 is
			--|#line 541
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

				yacc_error_code := 66666
				print ("error 6666%N")
				report_error ("")
			
			yyval := yyval70
		end

	yy_do_action_57 is
			--|#line 549
		local
			yyval65: EIFFEL_LIST [FEATURE_AS]
		do

				yyval65 := Void
			
			yyval := yyval65
		end

	yy_do_action_58 is
			--|#line 553
		local
			yyval65: EIFFEL_LIST [FEATURE_AS]
		do

				!! yyval65.make (1)
				yyval65.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_59 is
			--|#line 558
		local
			yyval65: EIFFEL_LIST [FEATURE_AS]
		do

				!! yyval65.make (2)
				yyval65.extend (yytype26 (yyvs.item (yyvsp - 1)))
				yyval65.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_60 is
			--|#line 564
		local
			yyval65: EIFFEL_LIST [FEATURE_AS]
		do

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_61 is
			--|#line 568
		local
			yyval65: EIFFEL_LIST [FEATURE_AS]
		do

				!! yyval65.make (Initial_feature_declaration_list_size)
				yyval65.extend (yytype26 (yyvs.item (yyvsp - 2)))
				yyval65.extend (yytype26 (yyvs.item (yyvsp - 1)))
				yyval65.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_62 is
			--|#line 575
		local
			yyval65: EIFFEL_LIST [FEATURE_AS]
		do

				yyval65 := yytype65 (yyvs.item (yyvsp - 1))
				yyval65.extend (yytype26 (yyvs.item (yyvsp)))
				yacc_error_code := 40
			
			yyval := yyval65
		end

	yy_do_action_65 is
			--|#line 587
		local
			yyval26: FEATURE_AS
		do

				!! yyval26.make (yytype84 (yyvs.item (yyvsp - 2)).first, yytype8 (yyvs.item (yyvsp - 1)), yytype84 (yyvs.item (yyvsp - 2)).second.start_position, current_position.start_position)
				yytype84 (yyvs.item (yyvsp - 2)).second.set_node (yyval26)
			
			yyval := yyval26
		end

	yy_do_action_66 is
			--|#line 594
		local
			yyval84: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

				!! feature_name_list.make (1)
				feature_name_list.extend (yytype82 (yyvs.item (yyvsp)).first)
				!! yyval84
				yyval84.set_first (feature_name_list)
				yyval84.set_second (yytype82 (yyvs.item (yyvsp)).second)
			
			yyval := yyval84
		end

	yy_do_action_67 is
			--|#line 602
		local
			yyval84: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_68 is
			--|#line 606
		local
			yyval84: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

				!! feature_name_list.make (Initial_new_feature_list_size)
				feature_name_list.extend (yytype82 (yyvs.item (yyvsp - 2)).first)
				feature_name_list.extend (yytype82 (yyvs.item (yyvsp)).first)
				!! yyval84
				yyval84.set_first (feature_name_list)
				yyval84.set_second (yytype82 (yyvs.item (yyvsp - 2)).second)
			
			yyval := yyval84
		end

	yy_do_action_69 is
			--|#line 615
		local
			yyval84: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

				yyval84 := yytype84 (yyvs.item (yyvsp - 2))
				yyval84.first.extend (yytype82 (yyvs.item (yyvsp)).first)
			
			yyval := yyval84
		end

	yy_do_action_70 is
			--|#line 622
		local
			yyval82: PAIR [FEATURE_NAME, CLICK_AST]
		do

				yyval82 := yytype82 (yyvs.item (yyvsp))
				yacc_error_code := 46
			
			yyval := yyval82
		end

	yy_do_action_71 is
			--|#line 629
		local

		do
			yyval := yyval_default;
				is_frozen := False
				yacc_error_code := 47
			

		end

	yy_do_action_72 is
			--|#line 634
		local

		do
			yyval := yyval_default;
				is_frozen := True
				yacc_error_code := 48
			

		end

	yy_do_action_73 is
			--|#line 641
		local
			yyval82: PAIR [FEATURE_NAME, CLICK_AST]
		do

				!FEAT_NAME_ID_AS! feature_name.make (yytype81 (yyvs.item (yyvsp)).first, is_frozen)
				yytype81 (yyvs.item (yyvsp)).second.set_node (feature_name)
				!! yyval82
				yyval82.set_first (feature_name)
				yyval82.set_second (yytype81 (yyvs.item (yyvsp)).second)
			
			yyval := yyval82
		end

	yy_do_action_74 is
			--|#line 649
		local
			yyval82: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
		end

	yy_do_action_75 is
			--|#line 651
		local
			yyval82: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
		end

	yy_do_action_76 is
			--|#line 655
		local
			yyval82: PAIR [FEATURE_NAME, CLICK_AST]
		do

				!INFIX_AS! feature_name.make (yytype83 (yyvs.item (yyvsp)).first, is_frozen)
				yytype83 (yyvs.item (yyvsp)).second.set_node (feature_name)
				!! yyval82
				yyval82.set_first (feature_name)
				yyval82.set_second (yytype83 (yyvs.item (yyvsp)).second)
			
			yyval := yyval82
		end

	yy_do_action_77 is
			--|#line 666
		local
			yyval82: PAIR [FEATURE_NAME, CLICK_AST]
		do

				!PREFIX_AS! feature_name.make (yytype83 (yyvs.item (yyvsp)).first, is_frozen)
				yytype83 (yyvs.item (yyvsp)).second.set_node (feature_name)
				!! yyval82
				yyval82.set_first (feature_name)
				yyval82.set_second (yytype83 (yyvs.item (yyvsp)).second)
			
			yyval := yyval82
		end

	yy_do_action_78 is
			--|#line 676
		local
			yyval83: PAIR [STRING_AS, CLICK_AST]
		do

				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! yyval83
				yyval83.set_first (yytype53 (yyvs.item (yyvsp)))
				yyval83.set_second (clickable)

-- TO DO
--				if not is_infix (token_buffer) then
--						-- Check infixed declaration.
--					report_error ("")
--				end
				yacc_error_code := 54
			
			yyval := yyval83
		end

	yy_do_action_79 is
			--|#line 693
		local
			yyval83: PAIR [STRING_AS, CLICK_AST]
		do

				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! yyval83
				yyval83.set_first (yytype53 (yyvs.item (yyvsp)))
				yyval83.set_second (clickable)

-- TO DO
--				if not is_prefix (token_buffer) then
--						-- Check prefixed declaration.
--					report_error ("")
--				end
				yacc_error_code := 55
			
			yyval := yyval83
		end

	yy_do_action_80 is
			--|#line 710
		local
			yyval8: BODY_AS
		do

				!! yyval8.make (yytype79 (yyvs.item (yyvsp - 2)), yytype56 (yyvs.item (yyvsp - 1)), yytype15 (yyvs.item (yyvsp)))
					-- Validity test for feature declaration
				if 
						-- Either arguments or type or body
					((yytype79 (yyvs.item (yyvsp - 2)) = Void) and (yytype56 (yyvs.item (yyvsp - 1)) = Void) and (yytype15 (yyvs.item (yyvsp)) = Void))
				or
						-- constant implies no argument but type
					((dollar_constant_as (yytype15 (yyvs.item (yyvsp))) /= Void) and ((yytype79 (yyvs.item (yyvsp - 2)) /= Void) or (yytype56 (yyvs.item (yyvsp - 1)) = Void)))
				or
						-- arguments implies non-void routine
					((yytype79 (yyvs.item (yyvsp - 2)) /= Void) and ((dollar_routine_as (yytype15 (yyvs.item (yyvsp))) = Void) or (yytype15 (yyvs.item (yyvsp)) = Void)))
				then
					report_error ("")
				end
				yacc_error_code := 56
			
			yyval := yyval8
		end

	yy_do_action_81 is
			--|#line 731
		local
			yyval15: CONTENT_AS
		do

				yyval15 := Void
				yacc_error_code := 57
			
			yyval := yyval15
		end

	yy_do_action_82 is
			--|#line 736
		local
			yyval15: CONTENT_AS
		do

				yyval15 := yytype15 (yyvs.item (yyvsp))
				yacc_error_code := 58
			
			yyval := yyval15
		end

	yy_do_action_83 is
			--|#line 743
		local
			yyval15: CONTENT_AS
		do

!! value_as.make (yytype6 (yyvs.item (yyvsp)))
!CONSTANT_AS! yyval15.make (value_as)
--				!CONSTANT_AS! $$.make (create {VALUE_AS} .make (dollar_atomic_as ($1)))
				yacc_error_code := 59
			
			yyval := yyval15
		end

	yy_do_action_84 is
			--|#line 750
		local
			yyval15: CONTENT_AS
		do

!! unique_as.make
!! value_as.make (unique_as)
!CONSTANT_AS! yyval15.make (value_as)
--				!CONSTANT_AS! $$.make (create {VALUE_AS} .make (create {UNIQUE_AS} .make))
				yacc_error_code := 60
			
			yyval := yyval15
		end

	yy_do_action_85 is
			--|#line 758
		local
			yyval15: CONTENT_AS
		do

yyval15 := yytype51 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_86 is
			--|#line 766
		local
			yyval74: EIFFEL_LIST [PARENT_AS]
		do

				yyval74 := Void
				yacc_error_code := 62
			
			yyval := yyval74
		end

	yy_do_action_87 is
			--|#line 771
		local
			yyval74: EIFFEL_LIST [PARENT_AS]
		do

				yyval74 := yytype74 (yyvs.item (yyvsp))
				yacc_error_code := 64
			
			yyval := yyval74
		end

	yy_do_action_88 is
			--|#line 776
		local
			yyval74: EIFFEL_LIST [PARENT_AS]
		do

				yyval74 := Void
				yacc_error_code := 65
			
			yyval := yyval74
		end

	yy_do_action_89 is
			--|#line 783
		local
			yyval74: EIFFEL_LIST [PARENT_AS]
		do

				!! yyval74.make (1)
				yyval74.extend (yytype43 (yyvs.item (yyvsp)))
				yacc_error_code := 66
			
			yyval := yyval74
		end

	yy_do_action_90 is
			--|#line 789
		local
			yyval74: EIFFEL_LIST [PARENT_AS]
		do

				!! yyval74.make (2)
				yyval74.extend (yytype43 (yyvs.item (yyvsp - 1)))
				yyval74.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval74
		end

	yy_do_action_91 is
			--|#line 795
		local
			yyval74: EIFFEL_LIST [PARENT_AS]
		do

yyval74 := yytype74 (yyvs.item (yyvsp)) 
			yyval := yyval74
		end

	yy_do_action_92 is
			--|#line 799
		local
			yyval74: EIFFEL_LIST [PARENT_AS]
		do

				!! yyval74.make (Initial_parent_list_size)
				yyval74.extend (yytype43 (yyvs.item (yyvsp - 2)))
				yyval74.extend (yytype43 (yyvs.item (yyvsp - 1)))
				yyval74.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval74
		end

	yy_do_action_93 is
			--|#line 806
		local
			yyval74: EIFFEL_LIST [PARENT_AS]
		do

				yyval74 := yytype74 (yyvs.item (yyvsp - 1))
				yyval74.extend (yytype43 (yyvs.item (yyvsp)))
				yacc_error_code := 67
			
			yyval := yyval74
		end

	yy_do_action_94 is
			--|#line 814
		local
			yyval43: PARENT_AS
		do

yyval43 := yytype43 (yyvs.item (yyvsp)) 
			yyval := yyval43
		end

	yy_do_action_95 is
			--|#line 816
		local
			yyval43: PARENT_AS
		do

				yyval43 := yytype43 (yyvs.item (yyvsp - 1))
				inherit_context := False
			
			yyval := yyval43
		end

	yy_do_action_96 is
			--|#line 823
		local
			yyval43: PARENT_AS
		do

				inherit_context := False
				!! class_type_as.make (yytype81 (yyvs.item (yyvsp - 1)).first, yytype78 (yyvs.item (yyvsp)))
				yytype81 (yyvs.item (yyvsp - 1)).second.set_node (class_type_as)
				!! yyval43.make (class_type_as, Void, Void, Void, Void, Void)
				yacc_error_code := 68
			
			yyval := yyval43
		end

	yy_do_action_97 is
			--|#line 831
		local
			yyval43: PARENT_AS
		do

				inherit_context := False
				!! class_type_as.make (yytype81 (yyvs.item (yyvsp - 7)).first, yytype78 (yyvs.item (yyvsp - 6)))
				yytype81 (yyvs.item (yyvsp - 7)).second.set_node (class_type_as)
				!! yyval43.make (class_type_as, yytype75 (yyvs.item (yyvsp - 5)), yytype63 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp - 3)), yytype68 (yyvs.item (yyvsp - 2)), yytype68 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval43
		end

	yy_do_action_98 is
			--|#line 838
		local
			yyval43: PARENT_AS
		do

				inherit_context := False
				!! class_type_as.make (yytype81 (yyvs.item (yyvsp - 6)).first, yytype78 (yyvs.item (yyvsp - 5)))
				yytype81 (yyvs.item (yyvsp - 6)).second.set_node (class_type_as)
				!! yyval43.make (class_type_as, Void, yytype63 (yyvs.item (yyvsp - 4)), yytype68 (yyvs.item (yyvsp - 3)), yytype68 (yyvs.item (yyvsp - 2)), yytype68 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval43
		end

	yy_do_action_99 is
			--|#line 845
		local
			yyval43: PARENT_AS
		do

				inherit_context := False
				!! class_type_as.make (yytype81 (yyvs.item (yyvsp - 5)).first, yytype78 (yyvs.item (yyvsp - 4)))
				yytype81 (yyvs.item (yyvsp - 5)).second.set_node (class_type_as)
				!! yyval43.make (class_type_as, Void, Void, yytype68 (yyvs.item (yyvsp - 3)), yytype68 (yyvs.item (yyvsp - 2)), yytype68 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval43
		end

	yy_do_action_100 is
			--|#line 852
		local
			yyval43: PARENT_AS
		do

				inherit_context := False
				!! class_type_as.make (yytype81 (yyvs.item (yyvsp - 4)).first, yytype78 (yyvs.item (yyvsp - 3)))
				yytype81 (yyvs.item (yyvsp - 4)).second.set_node (class_type_as)
				!! yyval43.make (class_type_as, Void, Void, Void, yytype68 (yyvs.item (yyvsp - 2)), yytype68 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval43
		end

	yy_do_action_101 is
			--|#line 859
		local
			yyval43: PARENT_AS
		do

				inherit_context := False
				!! class_type_as.make (yytype81 (yyvs.item (yyvsp - 3)).first, yytype78 (yyvs.item (yyvsp - 2)))
				yytype81 (yyvs.item (yyvsp - 3)).second.set_node (class_type_as)
				!! yyval43.make (class_type_as, Void, Void, Void, Void, yytype68 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval43
		end

	yy_do_action_102 is
			--|#line 866
		local
			yyval43: PARENT_AS
		do

				inherit_context := True
				!! class_type_as.make (yytype81 (yyvs.item (yyvsp - 2)).first, yytype78 (yyvs.item (yyvsp - 1)))
				yytype81 (yyvs.item (yyvsp - 2)).second.set_node (class_type_as)
				!! yyval43.make (class_type_as, Void, Void, Void, Void, Void)
			
			yyval := yyval43
		end

	yy_do_action_103 is
			--|#line 875
		local
			yyval75: EIFFEL_LIST [RENAME_AS]
		do

				yyval75 := Void
				yacc_error_code := 74
			
			yyval := yyval75
		end

	yy_do_action_104 is
			--|#line 880
		local
			yyval75: EIFFEL_LIST [RENAME_AS]
		do

				yyval75 := yytype75 (yyvs.item (yyvsp))
				yacc_error_code := 76
			
			yyval := yyval75
		end

	yy_do_action_105 is
			--|#line 887
		local
			yyval75: EIFFEL_LIST [RENAME_AS]
		do

				!! yyval75.make (1)
				yyval75.extend (yytype46 (yyvs.item (yyvsp)))
				yacc_error_code := 77
			
			yyval := yyval75
		end

	yy_do_action_106 is
			--|#line 893
		local
			yyval75: EIFFEL_LIST [RENAME_AS]
		do

				!! yyval75.make (2)
				yyval75.extend (yytype46 (yyvs.item (yyvsp - 2)))
				yyval75.extend (yytype46 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_107 is
			--|#line 899
		local
			yyval75: EIFFEL_LIST [RENAME_AS]
		do

yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
		end

	yy_do_action_108 is
			--|#line 903
		local
			yyval75: EIFFEL_LIST [RENAME_AS]
		do

				!! yyval75.make (Initial_rename_list_size)
				yyval75.extend (yytype46 (yyvs.item (yyvsp - 4)))
				yyval75.extend (yytype46 (yyvs.item (yyvsp - 2)))
				yyval75.extend (yytype46 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_109 is
			--|#line 910
		local
			yyval75: EIFFEL_LIST [RENAME_AS]
		do

				yyval75 := yytype75 (yyvs.item (yyvsp - 2))
				yyval75.extend (yytype46 (yyvs.item (yyvsp)))
				yacc_error_code := 78
			
			yyval := yyval75
		end

	yy_do_action_110 is
			--|#line 918
		local
			yyval46: RENAME_AS
		do

				!! yyval46.make (yytype82 (yyvs.item (yyvsp - 2)).first, yytype82 (yyvs.item (yyvsp)).first)
				yytype82 (yyvs.item (yyvsp - 2)).second.set_node (yytype82 (yyvs.item (yyvsp)).first)
				yacc_error_code := 79
			
			yyval := yyval46
		end

	yy_do_action_111 is
			--|#line 926
		local
			yyval63: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval63  := Void
				yacc_error_code := 80
			
			yyval := yyval63
		end

	yy_do_action_112 is
			--|#line 931
		local
			yyval63: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_113 is
			--|#line 935
		local
			yyval63: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval63 := yytype63 (yyvs.item (yyvsp))
				yacc_error_code := 82
			
			yyval := yyval63
		end

	yy_do_action_114 is
			--|#line 940
		local
			yyval63: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval63 := Void
				yacc_error_code := 83
			
			yyval := yyval63
		end

	yy_do_action_115 is
			--|#line 947
		local
			yyval63: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				!! yyval63.make (1)
				yyval63.extend (yytype22 (yyvs.item (yyvsp)))
				yacc_error_code := 84
			
			yyval := yyval63
		end

	yy_do_action_116 is
			--|#line 953
		local
			yyval63: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_117 is
			--|#line 957
		local
			yyval63: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				!! yyval63.make (Initial_new_export_list_size)
				yyval63.extend (yytype22 (yyvs.item (yyvsp - 1)))
				yyval63.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_118 is
			--|#line 963
		local
			yyval63: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval63 := yytype63 (yyvs.item (yyvsp - 1))
				yyval63.extend (yytype22 (yyvs.item (yyvsp)))
				yacc_error_code := 85
			
			yyval := yyval63
		end

	yy_do_action_119 is
			--|#line 971
		local
			yyval22: EXPORT_ITEM_AS
		do

!! client_as.make (yytype70 (yyvs.item (yyvsp - 2)))
!! yyval22.make (client_as, yytype28 (yyvs.item (yyvsp - 1)))
--				!EXPORT_ITEM_AS! $$.make (create {CLIENT_AS} .make (dollar_eiffel_list_id_as ($1)),
--					dollar_feature_set_as ($2))
				yacc_error_code := 86
			
			yyval := yyval22
		end

	yy_do_action_120 is
			--|#line 981
		local
			yyval28: FEATURE_SET_AS
		do

				!ALL_AS! yyval28.make
				yacc_error_code := 87
			
			yyval := yyval28
		end

	yy_do_action_121 is
			--|#line 986
		local
			yyval28: FEATURE_SET_AS
		do

				!FEATURE_LIST_AS! yyval28.make (yytype68 (yyvs.item (yyvsp)))
			
			yyval := yyval28
		end

	yy_do_action_122 is
			--|#line 992
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				!! yyval68.make (1)
				yyval68.extend (yytype82 (yyvs.item (yyvsp)).first)
				yacc_error_code := 90
			
			yyval := yyval68
		end

	yy_do_action_123 is
			--|#line 998
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				!! yyval68.make (2)
				yyval68.extend (yytype82 (yyvs.item (yyvsp - 2)).first)
				yyval68.extend (yytype82 (yyvs.item (yyvsp)).first)
			
			yyval := yyval68
		end

	yy_do_action_124 is
			--|#line 1004
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

yyval68 := yytype68 (yyvs.item (yyvsp)) 
			yyval := yyval68
		end

	yy_do_action_125 is
			--|#line 1008
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				!! yyval68.make (Initial_feature_list_size)
				yyval68.extend (yytype82 (yyvs.item (yyvsp - 4)).first)
				yyval68.extend (yytype82 (yyvs.item (yyvsp - 2)).first)
				yyval68.extend (yytype82 (yyvs.item (yyvsp)).first)
			
			yyval := yyval68
		end

	yy_do_action_126 is
			--|#line 1015
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval68 := yytype68 (yyvs.item (yyvsp - 2))
				yyval68.extend (yytype82 (yyvs.item (yyvsp)).first)
				yacc_error_code := 91
			
			yyval := yyval68
		end

	yy_do_action_127 is
			--|#line 1023
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval68 := Void
				yacc_error_code := 92
			
			yyval := yyval68
		end

	yy_do_action_128 is
			--|#line 1028
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

yyval68 := yytype68 (yyvs.item (yyvsp)) 
			yyval := yyval68
		end

	yy_do_action_129 is
			--|#line 1032
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval68 := Void
				yacc_error_code := 93
			
			yyval := yyval68
		end

	yy_do_action_130 is
			--|#line 1037
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval68 := yytype68 (yyvs.item (yyvsp))
				yacc_error_code := 95
			
			yyval := yyval68
		end

	yy_do_action_131 is
			--|#line 1044
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval68 := Void
				yacc_error_code := 96
			
			yyval := yyval68
		end

	yy_do_action_132 is
			--|#line 1049
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

yyval68 := yytype68 (yyvs.item (yyvsp)) 
			yyval := yyval68
		end

	yy_do_action_133 is
			--|#line 1053
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval68 := Void
				yacc_error_code := 97
			
			yyval := yyval68
		end

	yy_do_action_134 is
			--|#line 1058
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval68 := yytype68 (yyvs.item (yyvsp))
				yacc_error_code := 99
			
			yyval := yyval68
		end

	yy_do_action_135 is
			--|#line 1065
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval68 := Void
				yacc_error_code := 100
			
			yyval := yyval68
		end

	yy_do_action_136 is
			--|#line 1070
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

yyval68 := yytype68 (yyvs.item (yyvsp)) 
			yyval := yyval68
		end

	yy_do_action_137 is
			--|#line 1074
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval68 := Void
				yacc_error_code := 101
			
			yyval := yyval68
		end

	yy_do_action_138 is
			--|#line 1079
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval68 := yytype68 (yyvs.item (yyvsp))
				yacc_error_code := 103
			
			yyval := yyval68
		end

	yy_do_action_139 is
			--|#line 1090
		local
			yyval79: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval79 := Void
				yacc_error_code := 104
			
			yyval := yyval79
		end

	yy_do_action_140 is
			--|#line 1100
		local
			yyval79: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval79 := yytype79 (yyvs.item (yyvsp - 1))
				yacc_error_code := 107
			
			yyval := yyval79
		end

	yy_do_action_141 is
			--|#line 1107
		local
			yyval79: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval79 := Void
			
			yyval := yyval79
		end

	yy_do_action_142 is
			--|#line 1111
		local
			yyval79: EIFFEL_LIST [TYPE_DEC_AS]
		do

				!! yyval79.make (1)
				yyval79.extend (yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_143 is
			--|#line 1116
		local
			yyval79: EIFFEL_LIST [TYPE_DEC_AS]
		do

				!! yyval79.make (2)
				yyval79.extend (yytype57 (yyvs.item (yyvsp - 1)))
				yyval79.extend (yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_144 is
			--|#line 1122
		local
			yyval79: EIFFEL_LIST [TYPE_DEC_AS]
		do

				!! yyval79.make (3)
				yyval79.extend (yytype57 (yyvs.item (yyvsp - 2)))
				yyval79.extend (yytype57 (yyvs.item (yyvsp - 1)))
				yyval79.extend (yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_145 is
			--|#line 1129
		local
			yyval79: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval79 := yytype79 (yyvs.item (yyvsp)) 
			yyval := yyval79
		end

	yy_do_action_146 is
			--|#line 1133
		local
			yyval79: EIFFEL_LIST [TYPE_DEC_AS]
		do

				!! yyval79.make (Initial_entity_declaration_list_size)
				yyval79.extend (yytype57 (yyvs.item (yyvsp - 3)))
				yyval79.extend (yytype57 (yyvs.item (yyvsp - 2)))
				yyval79.extend (yytype57 (yyvs.item (yyvsp - 1)))
				yyval79.extend (yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_147 is
			--|#line 1141
		local
			yyval79: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval79 := yytype79 (yyvs.item (yyvsp - 1))
				yyval79.extend (yytype57 (yyvs.item (yyvsp)))
				yacc_error_code := 108
			
			yyval := yyval79
		end

	yy_do_action_148 is
			--|#line 1149
		local
			yyval57: TYPE_DEC_AS
		do

				!! yyval57.make (yytype70 (yyvs.item (yyvsp - 3)), yytype56 (yyvs.item (yyvsp - 1)))
				yacc_error_code := 111
			
			yyval := yyval57
		end

	yy_do_action_149 is
			--|#line 1156
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

				!! yyval70.make (1)
				yyval70.extend (yytype30 (yyvs.item (yyvsp)))
				yacc_error_code := 112
			
			yyval := yyval70
		end

	yy_do_action_150 is
			--|#line 1162
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

				!! yyval70.make (2)
				yyval70.extend (yytype30 (yyvs.item (yyvsp - 2)))
				yyval70.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_151 is
			--|#line 1168
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_152 is
			--|#line 1172
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

				!! yyval70.make (Initial_identifier_list_size)
				yyval70.extend (yytype30 (yyvs.item (yyvsp - 4)))
				yyval70.extend (yytype30 (yyvs.item (yyvsp - 2)))
				yyval70.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_153 is
			--|#line 1179
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

				yyval70 := yytype70 (yyvs.item (yyvsp - 2))
				yyval70.extend (yytype30 (yyvs.item (yyvsp)))
				yacc_error_code := 113
			
			yyval := yyval70
		end

	yy_do_action_154 is
			--|#line 1187
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

				!! yyval70.make (0)
			
			yyval := yyval70
		end

	yy_do_action_155 is
			--|#line 1191
		local
			yyval70: EIFFEL_LIST [ID_AS]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_156 is
			--|#line 1195
		local
			yyval56: TYPE
		do

				yyval56 := Void
				yacc_error_code := 114
			
			yyval := yyval56
		end

	yy_do_action_157 is
			--|#line 1200
		local
			yyval56: TYPE
		do

				yyval56 := yytype56 (yyvs.item (yyvsp))
				yacc_error_code := 115
			
			yyval := yyval56
		end

	yy_do_action_158 is
			--|#line 1208
		local
			yyval51: ROUTINE_AS
		do

				!! yyval51.make (yytype53 (yyvs.item (yyvsp - 7)), yytype47 (yyvs.item (yyvsp - 5)), yytype79 (yyvs.item (yyvsp - 4)), yytype50 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)), fbody_pos)
				yacc_error_code := 117
			
			yyval := yyval51
		end

	yy_do_action_159 is
			--|#line 1208
		local

		do
			yyval := yyval_default;
				fbody_pos := current_position.start_position
				yacc_error_code := 116
			

		end

	yy_do_action_160 is
			--|#line 1221
		local
			yyval50: ROUT_BODY_AS
		do

yyval50 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval50
		end

	yy_do_action_161 is
			--|#line 1223
		local
			yyval50: ROUT_BODY_AS
		do

yyval50 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval50
		end

	yy_do_action_162 is
			--|#line 1225
		local
			yyval50: ROUT_BODY_AS
		do

				!DEFERRED_AS! yyval50.make
				yacc_error_code := 120
			
			yyval := yyval50
		end

	yy_do_action_163 is
			--|#line 1232
		local
			yyval24: EXTERNAL_AS
		do

				!! yyval24.make (yytype25 (yyvs.item (yyvsp - 1)), yytype53 (yyvs.item (yyvsp)))
				yacc_error_code := 121
			
			yyval := yyval24
		end

	yy_do_action_164 is
			--|#line 1239
		local
			yyval25: EXTERNAL_LANG_AS
		do

				!! yyval25.make (yytype53 (yyvs.item (yyvsp)), yacc_position)
				yacc_error_code := 123
			
			yyval := yyval25
		end

	yy_do_action_165 is
			--|#line 1239
		local

		do
			yyval := yyval_default;
				set_position (current_position)
				yacc_error_code := 122
			

		end

	yy_do_action_166 is
			--|#line 1251
		local
			yyval53: STRING_AS
		do

				yyval53 := Void
				yacc_error_code := 124
			
			yyval := yyval53
		end

	yy_do_action_167 is
			--|#line 1256
		local
			yyval53: STRING_AS
		do

				yyval53 := yytype53 (yyvs.item (yyvsp))
				yacc_error_code := 125
			
			yyval := yyval53
		end

	yy_do_action_168 is
			--|#line 1263
		local
			yyval37: INTERNAL_AS
		do

				!DO_AS! yyval37.make (yytype72 (yyvs.item (yyvsp)))
				yacc_error_code := 127
			
			yyval := yyval37
		end

	yy_do_action_169 is
			--|#line 1268
		local
			yyval37: INTERNAL_AS
		do

				!ONCE_AS! yyval37.make (yytype72 (yyvs.item (yyvsp)))
				yacc_error_code := 129
			
			yyval := yyval37
		end

	yy_do_action_170 is
			--|#line 1275
		local
			yyval79: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval79 := Void
				yacc_error_code := 130
			
			yyval := yyval79
		end

	yy_do_action_171 is
			--|#line 1280
		local
			yyval79: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval79 := yytype79 (yyvs.item (yyvsp))
				yacc_error_code := 132
			
			yyval := yyval79
		end

	yy_do_action_172 is
			--|#line 1287
		local
			yyval72: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval72 := Void
			
			yyval := yyval72
		end

	yy_do_action_173 is
			--|#line 1291
		local
			yyval72: EIFFEL_LIST [INSTRUCTION_AS]
		do

				!! yyval72.make (1)
				yyval72.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval72
		end

	yy_do_action_174 is
			--|#line 1296
		local
			yyval72: EIFFEL_LIST [INSTRUCTION_AS]
		do

				!! yyval72.make (2)
				yyval72.extend (yytype35 (yyvs.item (yyvsp - 1)))
				yyval72.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval72
		end

	yy_do_action_175 is
			--|#line 1302
		local
			yyval72: EIFFEL_LIST [INSTRUCTION_AS]
		do

				!! yyval72.make (3)
				yyval72.extend (yytype35 (yyvs.item (yyvsp - 2)))
				yyval72.extend (yytype35 (yyvs.item (yyvsp - 1)))
				yyval72.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval72
		end

	yy_do_action_176 is
			--|#line 1309
		local
			yyval72: EIFFEL_LIST [INSTRUCTION_AS]
		do

				!! yyval72.make (4)
				yyval72.extend (yytype35 (yyvs.item (yyvsp - 3)))
				yyval72.extend (yytype35 (yyvs.item (yyvsp - 2)))
				yyval72.extend (yytype35 (yyvs.item (yyvsp - 1)))
				yyval72.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval72
		end

	yy_do_action_177 is
			--|#line 1317
		local
			yyval72: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval72 := yytype72 (yyvs.item (yyvsp))
			
			yyval := yyval72
		end

	yy_do_action_178 is
			--|#line 1323
		local
			yyval72: EIFFEL_LIST [INSTRUCTION_AS]
		do

				!! yyval72.make (Initial_compound_size)
				yyval72.extend (yytype35 (yyvs.item (yyvsp - 4)))
				yyval72.extend (yytype35 (yyvs.item (yyvsp - 3)))
				yyval72.extend (yytype35 (yyvs.item (yyvsp - 2)))
				yyval72.extend (yytype35 (yyvs.item (yyvsp - 1)))
				yyval72.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval72
		end

	yy_do_action_179 is
			--|#line 1332
		local
			yyval72: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval72 := yytype72 (yyvs.item (yyvsp - 1))
				yyval72.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval72
		end

	yy_do_action_180 is
			--|#line 1339
		local
			yyval35: INSTRUCTION_AS
		do

				yyval35 := yytype35 (yyvs.item (yyvsp - 1))
			
			yyval := yyval35
		end

	yy_do_action_183 is
			--|#line 1349
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_184 is
			--|#line 1351
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_185 is
			--|#line 1353
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_186 is
			--|#line 1355
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype49 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_187 is
			--|#line 1357
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype31 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_188 is
			--|#line 1359
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_189 is
			--|#line 1361
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype40 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_190 is
			--|#line 1363
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_191 is
			--|#line 1365
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_192 is
			--|#line 1367
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype48 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_193 is
			--|#line 1371
		local
			yyval47: REQUIRE_AS
		do

				yyval47 := Void
				yacc_error_code := 145
			
			yyval := yyval47
		end

	yy_do_action_194 is
			--|#line 1376
		local
			yyval47: REQUIRE_AS
		do

				id_level := Normal_level
				!! yyval47.make (yytype77 (yyvs.item (yyvsp)))
				yacc_error_code := 147
			
			yyval := yyval47
		end

	yy_do_action_195 is
			--|#line 1376
		local

		do
			yyval := yyval_default;
				id_level := Assert_level
				yacc_error_code := 146
			

		end

	yy_do_action_196 is
			--|#line 1387
		local
			yyval47: REQUIRE_AS
		do

				id_level := Normal_level
				!REQUIRE_ELSE_AS! yyval47.make (yytype77 (yyvs.item (yyvsp)))
				yacc_error_code := 149
			
			yyval := yyval47
		end

	yy_do_action_197 is
			--|#line 1387
		local

		do
			yyval := yyval_default;
				id_level := Assert_level
				yacc_error_code := 148
			

		end

	yy_do_action_198 is
			--|#line 1400
		local
			yyval21: ENSURE_AS
		do

				yyval21 := Void
				yacc_error_code := 150
			
			yyval := yyval21
		end

	yy_do_action_199 is
			--|#line 1405
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				!! yyval21.make (yytype77 (yyvs.item (yyvsp)))
				yacc_error_code := 152
			
			yyval := yyval21
		end

	yy_do_action_200 is
			--|#line 1405
		local

		do
			yyval := yyval_default;
				id_level := Assert_level
				yacc_error_code := 151
			

		end

	yy_do_action_201 is
			--|#line 1416
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				!ENSURE_THEN_AS! yyval21.make (yytype77 (yyvs.item (yyvsp)))
				yacc_error_code := 154
			
			yyval := yyval21
		end

	yy_do_action_202 is
			--|#line 1416
		local

		do
			yyval := yyval_default;
				id_level := Assert_level
				yacc_error_code := 153
			

		end

	yy_do_action_203 is
			--|#line 1429
		local
			yyval77: EIFFEL_LIST [TAGGED_AS]
		do

				yyval77 := Void
			
			yyval := yyval77
		end

	yy_do_action_204 is
			--|#line 1433
		local
			yyval77: EIFFEL_LIST [TAGGED_AS]
		do

				yyval77 := yytype77 (yyvs.item (yyvsp))
				if yyval77 /= Void and then yyval77.empty then
					yyval77 := Void
				end
			
			yyval := yyval77
		end

	yy_do_action_205 is
			--|#line 1442
		local
			yyval77: EIFFEL_LIST [TAGGED_AS]
		do

				if yytype54 (yyvs.item (yyvsp)) /= Void then
					!! yyval77.make (1)
					yyval77.extend (yytype54 (yyvs.item (yyvsp)))
				end
				yacc_error_code := 157
			
			yyval := yyval77
		end

	yy_do_action_206 is
			--|#line 1450
		local
			yyval77: EIFFEL_LIST [TAGGED_AS]
		do

				if yytype54 (yyvs.item (yyvsp - 1)) /= Void then
					if yytype54 (yyvs.item (yyvsp)) /= Void then
						!! yyval77.make (2)
						yyval77.extend (yytype54 (yyvs.item (yyvsp - 1)))
						yyval77.extend (yytype54 (yyvs.item (yyvsp)))
					else
						!! yyval77.make (1)
						yyval77.extend (yytype54 (yyvs.item (yyvsp - 1)))
					end
				elseif yytype54 (yyvs.item (yyvsp)) /= Void then
					!! yyval77.make (1)
					yyval77.extend (yytype54 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval77
		end

	yy_do_action_207 is
			--|#line 1466
		local
			yyval77: EIFFEL_LIST [TAGGED_AS]
		do

yyval77 := yytype77 (yyvs.item (yyvsp)) 
			yyval := yyval77
		end

	yy_do_action_208 is
			--|#line 1470
		local
			yyval77: EIFFEL_LIST [TAGGED_AS]
		do

				!! yyval77.make (Initial_assertion_list_size)
				if yytype54 (yyvs.item (yyvsp - 2)) /= Void then
					yyval77.extend (yytype54 (yyvs.item (yyvsp - 2)))
				end
				if yytype54 (yyvs.item (yyvsp - 1)) /= Void then
					yyval77.extend (yytype54 (yyvs.item (yyvsp - 1)))
				end
				if yytype54 (yyvs.item (yyvsp)) /= Void then
					yyval77.extend (yytype54 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval77
		end

	yy_do_action_209 is
			--|#line 1483
		local
			yyval77: EIFFEL_LIST [TAGGED_AS]
		do

				yyval77 := yytype77 (yyvs.item (yyvsp - 1))
				if yytype54 (yyvs.item (yyvsp)) /= Void then
					yyval77.extend (yytype54 (yyvs.item (yyvsp)))
				end
				yacc_error_code := 158
			
			yyval := yyval77
		end

	yy_do_action_210 is
			--|#line 1493
		local
			yyval54: TAGGED_AS
		do

				yyval54 := yytype54 (yyvs.item (yyvsp - 1))
			
			yyval := yyval54
		end

	yy_do_action_211 is
			--|#line 1499
		local
			yyval54: TAGGED_AS
		do

				!! yyval54.make (Void, yytype23 (yyvs.item (yyvsp)), yacc_position)
				yacc_error_code := 159
			
			yyval := yyval54
		end

	yy_do_action_212 is
			--|#line 1504
		local
			yyval54: TAGGED_AS
		do

				!! yyval54.make (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), yacc_position)
				yacc_error_code := 160
			
			yyval := yyval54
		end

	yy_do_action_213 is
			--|#line 1509
		local
			yyval54: TAGGED_AS
		do

				yyval54 := Void
				yacc_error_code := 161
			
			yyval := yyval54
		end

	yy_do_action_214 is
			--|#line 1520
		local
			yyval56: TYPE
		do

yyval56 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval56
		end

	yy_do_action_215 is
			--|#line 1522
		local
			yyval56: TYPE
		do

				id_as := yytype81 (yyvs.item (yyvsp - 1)).first
				!EXP_TYPE_AS! yyval56.make (id_as, yytype78 (yyvs.item (yyvsp)))
--				$2.second.set_node ($$)
				suppliers.insert_supplier_id (id_as)
				yacc_error_code := 165
			
			yyval := yyval56
		end

	yy_do_action_216 is
			--|#line 1530
		local
			yyval56: TYPE
		do

				id_as := yytype81 (yyvs.item (yyvsp - 1)).first
				!SEPARATE_TYPE_AS! yyval56.make (id_as, yytype78 (yyvs.item (yyvsp)))
--				$2.second.set_node ($$)
				suppliers.insert_supplier_id (id_as)
				yacc_error_code := 167
			
			yyval := yyval56
		end

	yy_do_action_217 is
			--|#line 1538
		local
			yyval56: TYPE
		do

				!BITS_AS! yyval56.make (yytype36 (yyvs.item (yyvsp)))
				yacc_error_code := 168
			
			yyval := yyval56
		end

	yy_do_action_218 is
			--|#line 1543
		local
			yyval56: TYPE
		do

				!BITS_SYMBOL_AS! yyval56.make (yytype30 (yyvs.item (yyvsp)))
				yacc_error_code := 169
			
			yyval := yyval56
		end

	yy_do_action_219 is
			--|#line 1548
		local
			yyval56: TYPE
		do

				!LIKE_ID_AS! yyval56.make (yytype30 (yyvs.item (yyvsp)))
				yacc_error_code := 170
			
			yyval := yyval56
		end

	yy_do_action_220 is
			--|#line 1553
		local
			yyval56: TYPE
		do

				!LIKE_CUR_AS! yyval56.make
				yacc_error_code := 171
			
			yyval := yyval56
		end

	yy_do_action_221 is
			--|#line 1560
		local
			yyval56: TYPE
		do

				clickable := yytype81 (yyvs.item (yyvsp - 1)).second
				clickable.set_node (new_class_type (yytype81 (yyvs.item (yyvsp - 1)).first, yytype78 (yyvs.item (yyvsp))))
				yyval56 ?= clickable.node
			
			yyval := yyval56
		end

	yy_do_action_222 is
			--|#line 1566
		local
			yyval56: TYPE
		do

				clickable := yytype81 (yyvs.item (yyvsp - 1)).second
				clickable.set_node (new_boolean_type (yytype78 (yyvs.item (yyvsp)) /= Void))
				yyval56 ?= clickable.node
			
			yyval := yyval56
		end

	yy_do_action_223 is
			--|#line 1572
		local
			yyval56: TYPE
		do

				clickable := yytype81 (yyvs.item (yyvsp - 1)).second
				clickable.set_node (new_character_type (yytype78 (yyvs.item (yyvsp)) /= Void))
				yyval56 ?= clickable.node
			
			yyval := yyval56
		end

	yy_do_action_224 is
			--|#line 1578
		local
			yyval56: TYPE
		do

				clickable := yytype81 (yyvs.item (yyvsp - 1)).second
				clickable.set_node (new_double_type (yytype78 (yyvs.item (yyvsp)) /= Void))
				yyval56 ?= clickable.node
			
			yyval := yyval56
		end

	yy_do_action_225 is
			--|#line 1584
		local
			yyval56: TYPE
		do

				clickable := yytype81 (yyvs.item (yyvsp - 1)).second
				clickable.set_node (new_integer_type (yytype78 (yyvs.item (yyvsp)) /= Void))
				yyval56 ?= clickable.node
			
			yyval := yyval56
		end

	yy_do_action_226 is
			--|#line 1590
		local
			yyval56: TYPE
		do

				clickable := yytype81 (yyvs.item (yyvsp - 1)).second
				clickable.set_node (new_none_type (yytype78 (yyvs.item (yyvsp)) /= Void))
				yyval56 ?= clickable.node
			
			yyval := yyval56
		end

	yy_do_action_227 is
			--|#line 1596
		local
			yyval56: TYPE
		do

				clickable := yytype81 (yyvs.item (yyvsp - 1)).second
				clickable.set_node (new_pointer_type (yytype78 (yyvs.item (yyvsp)) /= Void))
				yyval56 ?= clickable.node
			
			yyval := yyval56
		end

	yy_do_action_228 is
			--|#line 1602
		local
			yyval56: TYPE
		do

				clickable := yytype81 (yyvs.item (yyvsp - 1)).second
				clickable.set_node (new_real_type (yytype78 (yyvs.item (yyvsp)) /= Void))
				yyval56 ?= clickable.node
			
			yyval := yyval56
		end

	yy_do_action_229 is
			--|#line 1610
		local
			yyval78: EIFFEL_LIST [TYPE]
		do

				yyval78 := Void
			
			yyval := yyval78
		end

	yy_do_action_230 is
			--|#line 1614
		local
			yyval78: EIFFEL_LIST [TYPE]
		do

				yyval78 := Void
				yacc_error_code := 174
			
			yyval := yyval78
		end

	yy_do_action_231 is
			--|#line 1619
		local
			yyval78: EIFFEL_LIST [TYPE]
		do

				yyval78 := yytype78 (yyvs.item (yyvsp - 1))
				yacc_error_code := 176
			
			yyval := yyval78
		end

	yy_do_action_232 is
			--|#line 1626
		local
			yyval78: EIFFEL_LIST [TYPE]
		do

				!! yyval78.make (1)
				yyval78.extend (yytype56 (yyvs.item (yyvsp)))
				yacc_error_code := 177
			
			yyval := yyval78
		end

	yy_do_action_233 is
			--|#line 1632
		local
			yyval78: EIFFEL_LIST [TYPE]
		do

				!! yyval78.make (2)
				yyval78.extend (yytype56 (yyvs.item (yyvsp - 2)))
				yyval78.extend (yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_234 is
			--|#line 1638
		local
			yyval78: EIFFEL_LIST [TYPE]
		do

yyval78 := yytype78 (yyvs.item (yyvsp)) 
			yyval := yyval78
		end

	yy_do_action_235 is
			--|#line 1642
		local
			yyval78: EIFFEL_LIST [TYPE]
		do

				!! yyval78.make (Initial_type_list_size)
				yyval78.extend (yytype56 (yyvs.item (yyvsp - 4)))
				yyval78.extend (yytype56 (yyvs.item (yyvsp - 2)))
				yyval78.extend (yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_236 is
			--|#line 1649
		local
			yyval78: EIFFEL_LIST [TYPE]
		do

				yyval78 := yytype78 (yyvs.item (yyvsp - 2))
				yyval78.extend (yytype56 (yyvs.item (yyvsp)))
				yacc_error_code := 178
			
			yyval := yyval78
		end

	yy_do_action_237 is
			--|#line 1661
		local
			yyval69: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval69 := Void
				yacc_error_code := 179
			
			yyval := yyval69
		end

	yy_do_action_238 is
			--|#line 1666
		local
			yyval69: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval69 := yytype69 (yyvs.item (yyvsp - 1))
				yacc_error_code := 181
			
			yyval := yyval69
		end

	yy_do_action_239 is
			--|#line 1673
		local
			yyval69: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval69 := Void
			
			yyval := yyval69
		end

	yy_do_action_240 is
			--|#line 1677
		local
			yyval69: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				!! yyval69.make (1)
				yyval69.extend (yytype29 (yyvs.item (yyvsp)))
				yacc_error_code := 182
			
			yyval := yyval69
		end

	yy_do_action_241 is
			--|#line 1683
		local
			yyval69: EIFFEL_LIST [FORMAL_DEC_AS]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_242 is
			--|#line 1687
		local
			yyval69: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				!! yyval69.make (Initial_formal_generic_list_size)
				yyval69.extend (yytype29 (yyvs.item (yyvsp - 2)))
				yyval69.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval69
		end

	yy_do_action_243 is
			--|#line 1693
		local
			yyval69: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval69 := yytype69 (yyvs.item (yyvsp - 2))
				yyval69.extend (yytype29 (yyvs.item (yyvsp)))
				yacc_error_code := 183
			
			yyval := yyval69
		end

	yy_do_action_244 is
			--|#line 1701
		local
			yyval29: FORMAL_DEC_AS
		do

				check formal_exists: not formal_parameters.empty end
				!! yyval29.make (formal_parameters.last, yytype56 (yyvs.item (yyvsp - 1)), yytype68 (yyvs.item (yyvsp)), formal_parameters.count)
				yacc_error_code := 185
			
			yyval := yyval29
		end

	yy_do_action_245 is
			--|#line 1701
		local

		do
			yyval := yyval_default;
!! id_as.make (token_buffer)
formal_parameters.extend (id_as)
--				formal_parameters.extend (create {ID_AS} .make (token_buffer))
				yacc_error_code := 184
			

		end

	yy_do_action_246 is
			--|#line 1717
		local
			yyval56: TYPE
		do

				yyval56 := Void
				yacc_error_code := 186
			
			yyval := yyval56
		end

	yy_do_action_247 is
			--|#line 1722
		local
			yyval56: TYPE
		do

				yyval56 := yytype56 (yyvs.item (yyvsp))
				yacc_error_code := 187
			
			yyval := yyval56
		end

	yy_do_action_248 is
			--|#line 1729
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval68 := Void
				yacc_error_code := 188
			
			yyval := yyval68
		end

	yy_do_action_249 is
			--|#line 1734
		local
			yyval68: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval68 := yytype68 (yyvs.item (yyvsp - 1))
				yacc_error_code := 190
			
			yyval := yyval68
		end

	yy_do_action_250 is
			--|#line 1745
		local
			yyval31: IF_AS
		do

				set_position (dollar_position (yyvs.item (yyvsp - 7)))
				!! yyval31.make (yytype23 (yyvs.item (yyvsp - 5)), yytype72 (yyvs.item (yyvsp - 3)), yytype62 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
				yacc_error_code := 194
			
			yyval := yyval31
		end

	yy_do_action_251 is
			--|#line 1753
		local
			yyval62: EIFFEL_LIST [ELSIF_AS]
		do

				yyval62 := Void
			
			yyval := yyval62
		end

	yy_do_action_252 is
			--|#line 1757
		local
			yyval62: EIFFEL_LIST [ELSIF_AS]
		do

				!! yyval62.make (1)
				yyval62.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_253 is
			--|#line 1762
		local
			yyval62: EIFFEL_LIST [ELSIF_AS]
		do

yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
		end

	yy_do_action_254 is
			--|#line 1766
		local
			yyval62: EIFFEL_LIST [ELSIF_AS]
		do

				!! yyval62.make (Initial_elseif_list_size)
				yyval62.extend (yytype20 (yyvs.item (yyvsp - 1)))
				yyval62.extend (yytype20 (yyvs.item (yyvsp)))
				yacc_error_code := 198
			
			yyval := yyval62
		end

	yy_do_action_255 is
			--|#line 1773
		local
			yyval62: EIFFEL_LIST [ELSIF_AS]
		do

				yyval62 := yytype62 (yyvs.item (yyvsp - 1))
				yyval62.extend (yytype20 (yyvs.item (yyvsp)))
				yacc_error_code := 199
			
			yyval := yyval62
		end

	yy_do_action_256 is
			--|#line 1781
		local
			yyval20: ELSIF_AS
		do

				!! yyval20.make (yytype23 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp)), yacc_line_number)
				yacc_error_code := 201
			
			yyval := yyval20
		end

	yy_do_action_257 is
			--|#line 1788
		local
			yyval72: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval72 := Void
				yacc_error_code := 202
			
			yyval := yyval72
		end

	yy_do_action_258 is
			--|#line 1793
		local
			yyval72: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval72 := yytype72 (yyvs.item (yyvsp))
				if yyval72 = Void then
					!! yyval72.make (0)
				end
				yacc_error_code := 204
			
			yyval := yyval72
		end

	yy_do_action_259 is
			--|#line 1803
		local
			yyval72: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval72 := Void
				yacc_error_code := 205
			
			yyval := yyval72
		end

	yy_do_action_260 is
			--|#line 1808
		local
			yyval72: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval72 := yytype72 (yyvs.item (yyvsp))
				yacc_error_code := 207
			
			yyval := yyval72
		end

	yy_do_action_261 is
			--|#line 1815
		local
			yyval33: INSPECT_AS
		do

				set_position (dollar_position (yyvs.item (yyvsp - 5)))
				!! yyval33.make (yytype23 (yyvs.item (yyvsp - 3)), yytype60 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
				yacc_error_code := 211
			
			yyval := yyval33
		end

	yy_do_action_262 is
			--|#line 1823
		local
			yyval60: EIFFEL_LIST [CASE_AS]
		do

				yyval60 := Void
			
			yyval := yyval60
		end

	yy_do_action_263 is
			--|#line 1827
		local
			yyval60: EIFFEL_LIST [CASE_AS]
		do

				!! yyval60.make (1)
				yyval60.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval60
		end

	yy_do_action_264 is
			--|#line 1832
		local
			yyval60: EIFFEL_LIST [CASE_AS]
		do

yyval60 := yytype60 (yyvs.item (yyvsp)) 
			yyval := yyval60
		end

	yy_do_action_265 is
			--|#line 1836
		local
			yyval60: EIFFEL_LIST [CASE_AS]
		do

				!! yyval60.make (Initial_when_part_list_size)
				yyval60.extend (yytype11 (yyvs.item (yyvsp - 1)))
				yyval60.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval60
		end

	yy_do_action_266 is
			--|#line 1842
		local
			yyval60: EIFFEL_LIST [CASE_AS]
		do

				yyval60 := yytype60 (yyvs.item (yyvsp - 1))
				yyval60.extend (yytype11 (yyvs.item (yyvsp)))
				yacc_error_code := 214
			
			yyval := yyval60
		end

	yy_do_action_267 is
			--|#line 1850
		local
			yyval11: CASE_AS
		do

				!! yyval11.make (yytype73 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp)), yacc_line_number)
				yacc_error_code := 218
			
			yyval := yyval11
		end

	yy_do_action_268 is
			--|#line 1857
		local
			yyval73: EIFFEL_LIST [INTERVAL_AS]
		do

				!! yyval73.make (1)
				yyval73.extend (yytype38 (yyvs.item (yyvsp)))
				yacc_error_code := 219
			
			yyval := yyval73
		end

	yy_do_action_269 is
			--|#line 1863
		local
			yyval73: EIFFEL_LIST [INTERVAL_AS]
		do

yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
		end

	yy_do_action_270 is
			--|#line 1867
		local
			yyval73: EIFFEL_LIST [INTERVAL_AS]
		do

				!! yyval73.make (Initial_choices_size)
				yyval73.extend (yytype38 (yyvs.item (yyvsp - 2)))
				yyval73.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval73
		end

	yy_do_action_271 is
			--|#line 1873
		local
			yyval73: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval73 := yytype73 (yyvs.item (yyvsp - 2))
				yyval73.extend (yytype38 (yyvs.item (yyvsp)))
				yacc_error_code := 220
			
			yyval := yyval73
		end

	yy_do_action_272 is
			--|#line 1881
		local
			yyval38: INTERVAL_AS
		do

				!! yyval38.make (yytype36 (yyvs.item (yyvsp)), Void)
				yacc_error_code := 221
			
			yyval := yyval38
		end

	yy_do_action_273 is
			--|#line 1886
		local
			yyval38: INTERVAL_AS
		do

				!! yyval38.make (yytype12 (yyvs.item (yyvsp)), Void)
				yacc_error_code := 222
			
			yyval := yyval38
		end

	yy_do_action_274 is
			--|#line 1891
		local
			yyval38: INTERVAL_AS
		do

				!! yyval38.make (yytype30 (yyvs.item (yyvsp)), Void)
				yacc_error_code := 223
			
			yyval := yyval38
		end

	yy_do_action_275 is
			--|#line 1896
		local
			yyval38: INTERVAL_AS
		do

				!! yyval38.make (yytype36 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp)))
				yacc_error_code := 224
			
			yyval := yyval38
		end

	yy_do_action_276 is
			--|#line 1901
		local
			yyval38: INTERVAL_AS
		do

				!! yyval38.make (yytype36 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp)))
				yacc_error_code := 225
			
			yyval := yyval38
		end

	yy_do_action_277 is
			--|#line 1906
		local
			yyval38: INTERVAL_AS
		do

				!! yyval38.make (yytype30 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp)))
				yacc_error_code := 226
			
			yyval := yyval38
		end

	yy_do_action_278 is
			--|#line 1911
		local
			yyval38: INTERVAL_AS
		do

				!! yyval38.make (yytype30 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp)))
				yacc_error_code := 227
			
			yyval := yyval38
		end

	yy_do_action_279 is
			--|#line 1916
		local
			yyval38: INTERVAL_AS
		do

				!! yyval38.make (yytype12 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp)))
				yacc_error_code := 228
			
			yyval := yyval38
		end

	yy_do_action_280 is
			--|#line 1921
		local
			yyval38: INTERVAL_AS
		do

				!! yyval38.make (yytype30 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp)))
				yacc_error_code := 229
			
			yyval := yyval38
		end

	yy_do_action_281 is
			--|#line 1926
		local
			yyval38: INTERVAL_AS
		do

				!! yyval38.make (yytype12 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp)))
				yacc_error_code := 230
			
			yyval := yyval38
		end

	yy_do_action_282 is
			--|#line 1933
		local
			yyval40: LOOP_AS
		do

				set_position (dollar_position (yyvs.item (yyvsp - 9)))
				!! yyval40.make (yytype72 (yyvs.item (yyvsp - 7)), yytype77 (yyvs.item (yyvsp - 6)), yytype58 (yyvs.item (yyvsp - 5)), yytype23 (yyvs.item (yyvsp - 3)), yytype72 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
				yacc_error_code := 235
			
			yyval := yyval40
		end

	yy_do_action_283 is
			--|#line 1941
		local
			yyval77: EIFFEL_LIST [TAGGED_AS]
		do

				yyval77 := Void
				yacc_error_code := 236
			
			yyval := yyval77
		end

	yy_do_action_284 is
			--|#line 1946
		local
			yyval77: EIFFEL_LIST [TAGGED_AS]
		do

				yyval77 := yytype77 (yyvs.item (yyvsp))
				yacc_error_code := 237
			
			yyval := yyval77
		end

	yy_do_action_285 is
			--|#line 1953
		local
			yyval39: INVARIANT_AS
		do

				yyval39 := Void
				yacc_error_code := 238
			
			yyval := yyval39
		end

	yy_do_action_286 is
			--|#line 1958
		local
			yyval39: INVARIANT_AS
		do

				id_level := Normal_level
				!! yyval39.make (yytype77 (yyvs.item (yyvsp)))
				yacc_error_code := 240
			
			yyval := yyval39
		end

	yy_do_action_287 is
			--|#line 1958
		local

		do
			yyval := yyval_default;
				inherit_context := False
				id_level := Invariant_level
				yacc_error_code := 239
			

		end

	yy_do_action_288 is
			--|#line 1972
		local
			yyval58: VARIANT_AS
		do

				yyval58 := Void
				yacc_error_code := 241
			
			yyval := yyval58
		end

	yy_do_action_289 is
			--|#line 1977
		local
			yyval58: VARIANT_AS
		do

				!! yyval58.make (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), yacc_position)
				yacc_error_code := 242
			
			yyval := yyval58
		end

	yy_do_action_290 is
			--|#line 1982
		local
			yyval58: VARIANT_AS
		do

				!! yyval58.make (Void, yytype23 (yyvs.item (yyvsp)), yacc_position)
				yacc_error_code := 243
			
			yyval := yyval58
		end

	yy_do_action_291 is
			--|#line 1989
		local
			yyval19: DEBUG_AS
		do

				set_position (dollar_position (yyvs.item (yyvsp - 4)))
				!! yyval19.make (yytype76 (yyvs.item (yyvsp - 2)), yytype72 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
				yacc_error_code := 246
			
			yyval := yyval19
		end

	yy_do_action_292 is
			--|#line 1997
		local
			yyval76: EIFFEL_LIST [STRING_AS]
		do

				yyval76 := Void
				yacc_error_code := 247
			
			yyval := yyval76
		end

	yy_do_action_293 is
			--|#line 2002
		local
			yyval76: EIFFEL_LIST [STRING_AS]
		do

				yyval76 := Void
				yacc_error_code := 248
			
			yyval := yyval76
		end

	yy_do_action_294 is
			--|#line 2007
		local
			yyval76: EIFFEL_LIST [STRING_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp - 1))
				yacc_error_code := 250
			
			yyval := yyval76
		end

	yy_do_action_295 is
			--|#line 2014
		local
			yyval76: EIFFEL_LIST [STRING_AS]
		do

				!! yyval76.make (1)
				yyval76.extend (yytype53 (yyvs.item (yyvsp)))
				yacc_error_code := 251
			
			yyval := yyval76
		end

	yy_do_action_296 is
			--|#line 2020
		local
			yyval76: EIFFEL_LIST [STRING_AS]
		do

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_297 is
			--|#line 2024
		local
			yyval76: EIFFEL_LIST [STRING_AS]
		do

				!! yyval76.make (Initial_debug_key_list_size)
				yyval76.extend (yytype53 (yyvs.item (yyvsp - 2)))
				yyval76.extend (yytype53 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_298 is
			--|#line 2030
		local
			yyval76: EIFFEL_LIST [STRING_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp - 2))
				yyval76.extend (yytype53 (yyvs.item (yyvsp)))
				yacc_error_code := 252
			
			yyval := yyval76
		end

	yy_do_action_299 is
			--|#line 2038
		local
			yyval48: RETRY_AS
		do

				!! yyval48.make (yacc_line_number)
				yacc_error_code := 253
			
			yyval := yyval48
		end

	yy_do_action_300 is
			--|#line 2045
		local
			yyval72: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval72 := Void
				yacc_error_code := 254
			
			yyval := yyval72
		end

	yy_do_action_301 is
			--|#line 2050
		local
			yyval72: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval72 := yytype72 (yyvs.item (yyvsp))
				if yyval72 = Void then
					!! yyval72.make (0)
				end
				yacc_error_code := 256
			
			yyval := yyval72
		end

	yy_do_action_302 is
			--|#line 2060
		local
			yyval5: ASSIGN_AS
		do

!ACCESS_ID_AS! access_as.make (yytype30 (yyvs.item (yyvsp - 2)), Void)
!! yyval5.make (access_as, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
--				!ASSIGN_AS! $$.make (create {ACCESS_ID_AS} .make (dollar_id_as ($1), Void), dollar_expr_as ($3), yacc_position, yacc_line_number)
				yacc_error_code := 261
			
			yyval := yyval5
		end

	yy_do_action_303 is
			--|#line 2067
		local
			yyval5: ASSIGN_AS
		do

!RESULT_AS! access_as.make
!! yyval5.make (access_as, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
--				!ASSIGN_AS! $$.make (create {RESULT_AS} .make , dollar_expr_as ($3), yacc_position, yacc_line_number)
				yacc_error_code := 262
			
			yyval := yyval5
		end

	yy_do_action_304 is
			--|#line 2076
		local
			yyval49: REVERSE_AS
		do

!ACCESS_ID_AS! access_as.make (yytype30 (yyvs.item (yyvsp - 2)), Void)
!! yyval49.make (access_as, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
--				!REVERSE_AS! $$.make (create {ACCESS_ID_AS} .make (dollar_id_as ($1), Void), dollar_expr_as ($3), yacc_position, yacc_line_number)
				yacc_error_code := 263
			
			yyval := yyval49
		end

	yy_do_action_305 is
			--|#line 2083
		local
			yyval49: REVERSE_AS
		do

!RESULT_AS! access_as.make
!! yyval49.make (access_as, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
--				!REVERSE_AS! $$.make (create {RESULT_AS} .make, dollar_expr_as ($3), yacc_position, yacc_line_number)
				yacc_error_code := 264
			
			yyval := yyval49
		end

	yy_do_action_306 is
			--|#line 2092
		local
			yyval61: EIFFEL_LIST [CREATE_AS]
		do

				yyval61 := Void
				yacc_error_code := 265
			
			yyval := yyval61
		end

	yy_do_action_307 is
			--|#line 2097
		local
			yyval61: EIFFEL_LIST [CREATE_AS]
		do

yyval61 := yytype61 (yyvs.item (yyvsp)) 
			yyval := yyval61
		end

	yy_do_action_308 is
			--|#line 2101
		local
			yyval61: EIFFEL_LIST [CREATE_AS]
		do

				!! yyval61.make (1)
				yyval61.extend (yytype16 (yyvs.item (yyvsp)))
				yacc_error_code := 268
			
			yyval := yyval61
		end

	yy_do_action_309 is
			--|#line 2107
		local
			yyval61: EIFFEL_LIST [CREATE_AS]
		do

yyval61 := yytype61 (yyvs.item (yyvsp)) 
			yyval := yyval61
		end

	yy_do_action_310 is
			--|#line 2111
		local
			yyval61: EIFFEL_LIST [CREATE_AS]
		do

				!! yyval61.make (Initial_creation_clause_list_size)
				yyval61.extend (yytype16 (yyvs.item (yyvsp - 1)))
				yyval61.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_311 is
			--|#line 2117
		local
			yyval61: EIFFEL_LIST [CREATE_AS]
		do

				yyval61 := yytype61 (yyvs.item (yyvsp - 1))
				yyval61.extend (yytype16 (yyvs.item (yyvsp)))
				yacc_error_code := 269
			
			yyval := yyval61
		end

	yy_do_action_312 is
			--|#line 2125
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				!! yyval16.make (Void, Void)
				yacc_error_code := 270
			
			yyval := yyval16
		end

	yy_do_action_313 is
			--|#line 2131
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				!! yyval16.make (yytype14 (yyvs.item (yyvsp - 1)), yytype68 (yyvs.item (yyvsp)))
				yacc_error_code := 272
			
			yyval := yyval16
		end

	yy_do_action_314 is
			--|#line 2137
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
!! client_as.make (yytype70 (yyvs.item (yyvsp)))
!! yyval16.make (client_as, Void)
--				!CREATE_AS! $$.make (create {CLIENT_AS} .make (dollar_eiffel_list_id_as ($2)), Void)
				yacc_error_code := 273
			
			yyval := yyval16
		end

	yy_do_action_315 is
			--|#line 2147
		local
			yyval52: ROUTINE_CREATION_AS
		do

				!! yyval52.make (yytype56 (yyvs.item (yyvsp - 3)), yytype82 (yyvs.item (yyvsp - 1)).first, yytype64 (yyvs.item (yyvsp)), nb_tilde)
			
			yyval := yyval52
		end

	yy_do_action_316 is
			--|#line 2151
		local
			yyval52: ROUTINE_CREATION_AS
		do

				!! yyval52.make (Void, yytype82 (yyvs.item (yyvsp - 1)).first, yytype64 (yyvs.item (yyvsp)), nb_tilde)
			
			yyval := yyval52
		end

	yy_do_action_317 is
			--|#line 2157
		local
			yyval17: CREATION_AS
		do

				!! yyval17.make (yytype56 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
				yacc_error_code := 274
			
			yyval := yyval17
		end

	yy_do_action_318 is
			--|#line 2162
		local
			yyval17: CREATION_AS
		do

				!! yyval17.make (Void, yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
				yacc_error_code := 274
			
			yyval := yyval17
		end

	yy_do_action_319 is
			--|#line 2167
		local
			yyval17: CREATION_AS
		do

				!! yyval17.make (yytype56 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
				yacc_error_code := 274
			
			yyval := yyval17
		end

	yy_do_action_320 is
			--|#line 2174
		local
			yyval18: CREATION_EXPR_AS
		do

				!! yyval18.make (yytype56 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp)))
			
			yyval := yyval18
		end

	yy_do_action_321 is
			--|#line 2178
		local
			yyval18: CREATION_EXPR_AS
		do

				!! yyval18.make (yytype56 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp)))
			
			yyval := yyval18
		end

	yy_do_action_322 is
			--|#line 2184
		local
			yyval56: TYPE
		do

				yyval56 := Void
				yacc_error_code := 275
			
			yyval := yyval56
		end

	yy_do_action_323 is
			--|#line 2189
		local
			yyval56: TYPE
		do

yyval56 := yytype56 (yyvs.item (yyvsp)) 
			yyval := yyval56
		end

	yy_do_action_324 is
			--|#line 2193
		local
			yyval1: ACCESS_AS
		do

				!ACCESS_ID_AS! yyval1.make (yytype30 (yyvs.item (yyvsp)), Void)
				yacc_error_code := 277
			
			yyval := yyval1
		end

	yy_do_action_325 is
			--|#line 2198
		local
			yyval1: ACCESS_AS
		do

				!RESULT_AS! yyval1.make
				yacc_error_code := 278
			
			yyval := yyval1
		end

	yy_do_action_326 is
			--|#line 2205
		local
			yyval3: ACCESS_INV_AS
		do

				yyval3 := Void
				yacc_error_code := 279
			
			yyval := yyval3
		end

	yy_do_action_327 is
			--|#line 2210
		local
			yyval3: ACCESS_INV_AS
		do

				!! yyval3.make (yytype30 (yyvs.item (yyvsp - 1)), yytype64 (yyvs.item (yyvsp)))
				yacc_error_code := 280
			
			yyval := yyval3
		end

	yy_do_action_328 is
			--|#line 2221
		local
			yyval34: INSTR_CALL_AS
		do

				!! yyval34.make (yytype1 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
				yacc_error_code := 281
			
			yyval := yyval34
		end

	yy_do_action_329 is
			--|#line 2226
		local
			yyval34: INSTR_CALL_AS
		do

				!! yyval34.make (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
				yacc_error_code := 282
			
			yyval := yyval34
		end

	yy_do_action_330 is
			--|#line 2231
		local
			yyval34: INSTR_CALL_AS
		do

				!! yyval34.make (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
				yacc_error_code := 283
			
			yyval := yyval34
		end

	yy_do_action_331 is
			--|#line 2236
		local
			yyval34: INSTR_CALL_AS
		do

				!! yyval34.make (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
				yacc_error_code := 284
			
			yyval := yyval34
		end

	yy_do_action_332 is
			--|#line 2241
		local
			yyval34: INSTR_CALL_AS
		do

				!! yyval34.make (yytype42 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
				yacc_error_code := 285
			
			yyval := yyval34
		end

	yy_do_action_333 is
			--|#line 2246
		local
			yyval34: INSTR_CALL_AS
		do

				!! yyval34.make (yytype44 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
				yacc_error_code := 286
			
			yyval := yyval34
		end

	yy_do_action_334 is
			--|#line 2251
		local
			yyval34: INSTR_CALL_AS
		do

				!! yyval34.make (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
				yacc_error_code := 287
			
			yyval := yyval34
		end

	yy_do_action_335 is
			--|#line 2258
		local
			yyval13: CHECK_AS
		do

				set_position (dollar_position (yyvs.item (yyvsp - 3)))
				!! yyval13.make (yytype77 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
				yacc_error_code := 289
			
			yyval := yyval13
		end

	yy_do_action_336 is
			--|#line 2269
		local
			yyval23: EXPR_AS
		do

				recover
				!VALUE_AS! yyval23.make (yytype6 (yyvs.item (yyvsp)))
				yacc_error_code := 290
			
			yyval := yyval23
		end

	yy_do_action_337 is
			--|#line 2275
		local
			yyval23: EXPR_AS
		do

				recover
				!VALUE_AS! yyval23.make (yytype4 (yyvs.item (yyvsp)))
				yacc_error_code := 291
			
			yyval := yyval23
		end

	yy_do_action_338 is
			--|#line 2281
		local
			yyval23: EXPR_AS
		do

				recover
				!VALUE_AS! yyval23.make (yytype55 (yyvs.item (yyvsp)))
				yacc_error_code := 291
			
			yyval := yyval23
		end

	yy_do_action_339 is
			--|#line 2287
		local
			yyval23: EXPR_AS
		do

				!EXPR_CALL_AS! yyval23.make (yytype10 (yyvs.item (yyvsp)))
				yacc_error_code := 292
			
			yyval := yyval23
		end

	yy_do_action_341 is
			--|#line 2293
		local
			yyval23: EXPR_AS
		do

				!PARAN_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 1)))
				yacc_error_code := 293
			
			yyval := yyval23
		end

	yy_do_action_342 is
			--|#line 2298
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_PLUS_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 294
			
			yyval := yyval23
		end

	yy_do_action_343 is
			--|#line 2304
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_MINUS_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 295
			
			yyval := yyval23
		end

	yy_do_action_344 is
			--|#line 2310
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_STAR_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 296
			
			yyval := yyval23
		end

	yy_do_action_345 is
			--|#line 2316
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_SLASH_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 297
			
			yyval := yyval23
		end

	yy_do_action_346 is
			--|#line 2322
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_MOD_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 298
			
			yyval := yyval23
		end

	yy_do_action_347 is
			--|#line 2328
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_DIV_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 299
			
			yyval := yyval23
		end

	yy_do_action_348 is
			--|#line 2334
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_POWER_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 300
			
			yyval := yyval23
		end

	yy_do_action_349 is
			--|#line 2340
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_AND_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 301
			
			yyval := yyval23
		end

	yy_do_action_350 is
			--|#line 2346
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_AND_THEN_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 302
			
			yyval := yyval23
		end

	yy_do_action_351 is
			--|#line 2352
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_OR_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 303
			
			yyval := yyval23
		end

	yy_do_action_352 is
			--|#line 2358
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_OR_ELSE_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 304
			
			yyval := yyval23
		end

	yy_do_action_353 is
			--|#line 2364
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_IMPLIES_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 304
			
			yyval := yyval23
		end

	yy_do_action_354 is
			--|#line 2370
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_XOR_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 305
			
			yyval := yyval23
		end

	yy_do_action_355 is
			--|#line 2376
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_GE_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 306
			
			yyval := yyval23
		end

	yy_do_action_356 is
			--|#line 2382
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_GT_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 307
			
			yyval := yyval23
		end

	yy_do_action_357 is
			--|#line 2388
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_LE_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 308
			
			yyval := yyval23
		end

	yy_do_action_358 is
			--|#line 2394
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_LT_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 309
			
			yyval := yyval23
		end

	yy_do_action_359 is
			--|#line 2400
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_EQ_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 310
			
			yyval := yyval23
		end

	yy_do_action_360 is
			--|#line 2406
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_NE_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 311
			
			yyval := yyval23
		end

	yy_do_action_361 is
			--|#line 2412
		local
			yyval23: EXPR_AS
		do

				recover
				!BIN_FREE_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 312
			
			yyval := yyval23
		end

	yy_do_action_362 is
			--|#line 2418
		local
			yyval23: EXPR_AS
		do

				recover
				!UN_MINUS_AS! yyval23.make (yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 313
			
			yyval := yyval23
		end

	yy_do_action_363 is
			--|#line 2424
		local
			yyval23: EXPR_AS
		do

				recover
				!UN_PLUS_AS! yyval23.make (yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 314
			
			yyval := yyval23
		end

	yy_do_action_364 is
			--|#line 2430
		local
			yyval23: EXPR_AS
		do

				recover
				!UN_NOT_AS! yyval23.make (yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 315
			
			yyval := yyval23
		end

	yy_do_action_365 is
			--|#line 2436
		local
			yyval23: EXPR_AS
		do

				recover
				!UN_OLD_AS! yyval23.make (yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 316
			
			yyval := yyval23
		end

	yy_do_action_366 is
			--|#line 2442
		local
			yyval23: EXPR_AS
		do

				recover
				!UN_FREE_AS! yyval23.make (yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 317
			
			yyval := yyval23
		end

	yy_do_action_367 is
			--|#line 2448
		local
			yyval23: EXPR_AS
		do

				recover
				!UN_STRIP_AS! yyval23.make (yytype70 (yyvs.item (yyvsp - 1)))
				yacc_error_code := 319
			
			yyval := yyval23
		end

	yy_do_action_368 is
			--|#line 2456
		local
			yyval23: EXPR_AS
		do

yyval23 := yytype23 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_369 is
			--|#line 2458
		local
			yyval23: EXPR_AS
		do

				recover
				!ADDRESS_AS! yyval23.make (yytype82 (yyvs.item (yyvsp)).first)
				yacc_error_code := 321
			
			yyval := yyval23
		end

	yy_do_action_370 is
			--|#line 2464
		local
			yyval23: EXPR_AS
		do

				recover
				!EXPR_ADDRESS_AS! yyval23.make (yytype23 (yyvs.item (yyvsp - 1)))
				yacc_error_code := 322
			
			yyval := yyval23
		end

	yy_do_action_371 is
			--|#line 2470
		local
			yyval23: EXPR_AS
		do

				recover
				!ADDRESS_CURRENT_AS! yyval23.make
				yacc_error_code := 323
			
			yyval := yyval23
		end

	yy_do_action_372 is
			--|#line 2476
		local
			yyval23: EXPR_AS
		do

				recover
				!ADDRESS_RESULT_AS! yyval23.make
				yacc_error_code := 324
			
			yyval := yyval23
		end

	yy_do_action_373 is
			--|#line 2484
		local
			yyval30: ID_AS
		do

				!! yyval30.make (token_buffer)
				yacc_error_code := 325
			
			yyval := yyval30
		end

	yy_do_action_374 is
			--|#line 2495
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_375 is
			--|#line 2497
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_376 is
			--|#line 2499
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_377 is
			--|#line 2501
		local
			yyval10: CALL_AS
		do

				!CURRENT_AS! yyval10.make
				yacc_error_code := 329
			
			yyval := yyval10
		end

	yy_do_action_378 is
			--|#line 2506
		local
			yyval10: CALL_AS
		do

				!RESULT_AS! yyval10.make
				yacc_error_code := 330
			
			yyval := yyval10
		end

	yy_do_action_379 is
			--|#line 2511
		local
			yyval10: CALL_AS
		do

yyval10 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_380 is
			--|#line 2513
		local
			yyval10: CALL_AS
		do

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_381 is
			--|#line 2515
		local
			yyval10: CALL_AS
		do

yyval10 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_382 is
			--|#line 2517
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_383 is
			--|#line 2519
		local
			yyval10: CALL_AS
		do

yyval10 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_384 is
			--|#line 2523
		local
			yyval41: NESTED_AS
		do

!CURRENT_AS! access_as.make
!! yyval41.make (access_as, yytype10 (yyvs.item (yyvsp)))
--				!NESTED_AS! $$.make (create {CURRENT_AS} .make, dollar_call_as ($3))
				yacc_error_code := 335
			
			yyval := yyval41
		end

	yy_do_action_385 is
			--|#line 2532
		local
			yyval41: NESTED_AS
		do

!RESULT_AS! access_as.make
!! yyval41.make (access_as, yytype10 (yyvs.item (yyvsp)))
--				!NESTED_AS! $$.make (create {RESULT_AS} .make, dollar_call_as ($3))
				yacc_error_code := 336
			
			yyval := yyval41
		end

	yy_do_action_386 is
			--|#line 2541
		local
			yyval41: NESTED_AS
		do

				!! yyval41.make (yytype1 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp)))
				yacc_error_code := 337
			
			yyval := yyval41
		end

	yy_do_action_387 is
			--|#line 2548
		local
			yyval42: NESTED_EXPR_AS
		do

				!! yyval42.make (yytype23 (yyvs.item (yyvsp - 3)), yytype10 (yyvs.item (yyvsp)))
				yacc_error_code := 338
			
			yyval := yyval42
		end

	yy_do_action_388 is
			--|#line 2555
		local
			yyval41: NESTED_AS
		do

				!! yyval41.make (yytype44 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp)))
				yacc_error_code := 339
			
			yyval := yyval41
		end

	yy_do_action_389 is
			--|#line 2562
		local
			yyval44: PRECURSOR_AS
		do

				!! yyval44.make (Void, yytype64 (yyvs.item (yyvsp)))
				yacc_error_code := 340
			
			yyval := yyval44
		end

	yy_do_action_390 is
			--|#line 2567
		local
			yyval44: PRECURSOR_AS
		do

				!! yyval44.make (yytype81 (yyvs.item (yyvsp - 3)).first, yytype64 (yyvs.item (yyvsp)))
				yytype81 (yyvs.item (yyvsp - 3)).second.set_node (yyval44)
				yacc_error_code := 341
			
			yyval := yyval44
		end

	yy_do_action_391 is
			--|#line 2573
		local
			yyval44: PRECURSOR_AS
		do

				!! yyval44.make (yytype81 (yyvs.item (yyvsp - 4)).first, yytype64 (yyvs.item (yyvsp)))
				yytype81 (yyvs.item (yyvsp - 4)).second.set_node (yyval44)
				yacc_error_code := 342
			
			yyval := yyval44
		end

	yy_do_action_392 is
			--|#line 2579
		local
			yyval44: PRECURSOR_AS
		do

				!! yyval44.make (yytype81 (yyvs.item (yyvsp - 2)).first, yytype64 (yyvs.item (yyvsp)))
				yytype81 (yyvs.item (yyvsp - 2)).second.set_node (yyval44)
				yacc_error_code := 341
			
			yyval := yyval44
		end

	yy_do_action_393 is
			--|#line 2587
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_394 is
			--|#line 2589
		local
			yyval10: CALL_AS
		do

yyval10 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_395 is
			--|#line 2593
		local
			yyval41: NESTED_AS
		do

				!! yyval41.make (yytype2 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp)))
				yacc_error_code := 345
			
			yyval := yyval41
		end

	yy_do_action_396 is
			--|#line 2598
		local
			yyval41: NESTED_AS
		do

				!! yyval41.make (yytype2 (yyvs.item (yyvsp - 2)), yytype41 (yyvs.item (yyvsp)))
				yacc_error_code := 346
			
			yyval := yyval41
		end

	yy_do_action_397 is
			--|#line 2605
		local
			yyval1: ACCESS_AS
		do

				inspect id_level
				when Normal_level then
					!ACCESS_ID_AS! yyval1.make (yytype30 (yyvs.item (yyvsp - 1)), yytype64 (yyvs.item (yyvsp)))
				when Assert_level then
					!ACCESS_ASSERT_AS! yyval1.make (yytype30 (yyvs.item (yyvsp - 1)), yytype64 (yyvs.item (yyvsp)))
				when Invariant_level then
					!ACCESS_INV_AS! yyval1.make (yytype30 (yyvs.item (yyvsp - 1)), yytype64 (yyvs.item (yyvsp)))
				else
					-- ??
				end
				yacc_error_code := 347
			
			yyval := yyval1
		end

	yy_do_action_398 is
			--|#line 2621
		local
			yyval2: ACCESS_FEAT_AS
		do

				!! yyval2.make (yytype30 (yyvs.item (yyvsp - 1)), yytype64 (yyvs.item (yyvsp)))
				yacc_error_code := 348
			
			yyval := yyval2
		end

	yy_do_action_399 is
			--|#line 2628
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				yyval64 := Void
				yacc_error_code := 349
			
			yyval := yyval64
		end

	yy_do_action_400 is
			--|#line 2633
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				yyval64 := Void
				yacc_error_code := 350
			
			yyval := yyval64
		end

	yy_do_action_401 is
			--|#line 2638
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				yyval64 := yytype64 (yyvs.item (yyvsp - 1))
				yacc_error_code := 352
			
			yyval := yyval64
		end

	yy_do_action_402 is
			--|#line 2645
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				!! yyval64.make (1)
				yyval64.extend (yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 353
			
			yyval := yyval64
		end

	yy_do_action_403 is
			--|#line 2651
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				!! yyval64.make (2)
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 2)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_404 is
			--|#line 2657
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				!! yyval64.make (3)
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 4)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 2)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_405 is
			--|#line 2664
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				!! yyval64.make (4)
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 6)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 4)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 2)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_406 is
			--|#line 2672
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_407 is
			--|#line 2677
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				!! yyval64.make (Initial_parameter_list_size)
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 8)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 6)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 4)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 2)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_408 is
			--|#line 2686
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				yyval64 := yytype64 (yyvs.item (yyvsp - 2))
				yyval64.extend (yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 354
			
			yyval := yyval64
		end

	yy_do_action_409 is
			--|#line 2694
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				!! yyval64.make (0)
			
			yyval := yyval64
		end

	yy_do_action_410 is
			--|#line 2698
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				!! yyval64.make (1)
				yyval64.extend (yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 355
			
			yyval := yyval64
		end

	yy_do_action_411 is
			--|#line 2704
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				!! yyval64.make (2)
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 2)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_412 is
			--|#line 2710
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				!! yyval64.make (3)
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 4)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 2)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_413 is
			--|#line 2717
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_414 is
			--|#line 2721
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				!! yyval64.make (Initial_expression_list_size)
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 6)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 4)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp - 2)))
				yyval64.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_415 is
			--|#line 2729
		local
			yyval64: EIFFEL_LIST [EXPR_AS]
		do

				yyval64 := yytype64 (yyvs.item (yyvsp - 2))
				yyval64.extend (yytype23 (yyvs.item (yyvsp)))
				yacc_error_code := 356
			
			yyval := yyval64
		end

	yy_do_action_416 is
			--|#line 2741
		local
			yyval30: ID_AS
		do

				!! yyval30.make (token_buffer)
				yacc_error_code := 357
			
			yyval := yyval30
		end

	yy_do_action_417 is
			--|#line 2746
		local
			yyval30: ID_AS
		do

				yyval30 := Boolean_id_as
			
			yyval := yyval30
		end

	yy_do_action_418 is
			--|#line 2750
		local
			yyval30: ID_AS
		do

				yyval30 := Character_id_as
			
			yyval := yyval30
		end

	yy_do_action_419 is
			--|#line 2754
		local
			yyval30: ID_AS
		do

				yyval30 := Double_id_as
			
			yyval := yyval30
		end

	yy_do_action_420 is
			--|#line 2758
		local
			yyval30: ID_AS
		do

				yyval30 := Integer_id_as
			
			yyval := yyval30
		end

	yy_do_action_421 is
			--|#line 2762
		local
			yyval30: ID_AS
		do

				yyval30 := None_id_as
			
			yyval := yyval30
		end

	yy_do_action_422 is
			--|#line 2766
		local
			yyval30: ID_AS
		do

				yyval30 := Pointer_id_as
			
			yyval := yyval30
		end

	yy_do_action_423 is
			--|#line 2770
		local
			yyval30: ID_AS
		do

				yyval30 := Real_id_as
			
			yyval := yyval30
		end

	yy_do_action_424 is
			--|#line 2776
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_425 is
			--|#line 2778
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_426 is
			--|#line 2780
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_427 is
			--|#line 2782
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype45 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_428 is
			--|#line 2784
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_429 is
			--|#line 2786
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype53 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_430 is
			--|#line 2790
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_431 is
			--|#line 2792
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_432 is
			--|#line 2794
		local
			yyval6: ATOMIC_AS
		do

				if token_buffer.is_integer then
					!INTEGER_AS! yyval6.make (token_buffer.to_integer)
				else
-- TO DO!
				end
				yacc_error_code := 366
			
			yyval := yyval6
		end

	yy_do_action_433 is
			--|#line 2803
		local
			yyval6: ATOMIC_AS
		do

				!REAL_AS! yyval6.make (cloned_string (token_buffer))
				yacc_error_code := 367
			
			yyval := yyval6
		end

	yy_do_action_434 is
			--|#line 2808
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_435 is
			--|#line 2810
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype53 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_436 is
			--|#line 2814
		local
			yyval9: BOOL_AS
		do

				!! yyval9.make (False)
				yacc_error_code := 370
			
			yyval := yyval9
		end

	yy_do_action_437 is
			--|#line 2819
		local
			yyval9: BOOL_AS
		do

				!! yyval9.make (True)
				yacc_error_code := 371
			
			yyval := yyval9
		end

	yy_do_action_438 is
			--|#line 2826
		local
			yyval12: CHAR_AS
		do

				check is_character: not token_buffer.empty end
				!! yyval12.make (token_buffer.item (1))
				yacc_error_code := 372
			
			yyval := yyval12
		end

	yy_do_action_439 is
			--|#line 2834
		local
			yyval36: INTEGER_AS
		do

				if token_buffer.is_integer then
					!! yyval36.make (token_buffer.to_integer)
				else
-- TO DO!
				end
				yacc_error_code := 373
			
			yyval := yyval36
		end

	yy_do_action_440 is
			--|#line 2843
		local
			yyval36: INTEGER_AS
		do

				if token_buffer.is_integer then
					!! yyval36.make (token_buffer.to_integer)
				else
-- TO DO!
				end
				yacc_error_code := 373
			
			yyval := yyval36
		end

	yy_do_action_441 is
			--|#line 2852
		local
			yyval36: INTEGER_AS
		do

				if token_buffer.is_integer then
					!! yyval36.make (- token_buffer.to_integer)
				else
-- TO DO!
				end
				yacc_error_code := 373
			
			yyval := yyval36
		end

	yy_do_action_442 is
			--|#line 2863
		local
			yyval45: REAL_AS
		do

				!! yyval45.make (cloned_string (token_buffer))
				yacc_error_code := 377
			
			yyval := yyval45
		end

	yy_do_action_443 is
			--|#line 2868
		local
			yyval45: REAL_AS
		do

				!! yyval45.make (cloned_string (token_buffer))
				yacc_error_code := 377
			
			yyval := yyval45
		end

	yy_do_action_444 is
			--|#line 2873
		local
			yyval45: REAL_AS
		do

				token_buffer.precede ('-')
				!! yyval45.make (cloned_string (token_buffer))
				yacc_error_code := 377
			
			yyval := yyval45
		end

	yy_do_action_445 is
			--|#line 2881
		local
			yyval7: BIT_CONST_AS
		do

!! id_as.make (token_buffer)
!! yyval7.make (id_as)
--				!BIT_CONST_AS! $$.make (create {ID_AS} .make (token_buffer))
				yacc_error_code := 378
			
			yyval := yyval7
		end

	yy_do_action_446 is
			--|#line 2890
		local
			yyval53: STRING_AS
		do

				!! yyval53.make (cloned_string (token_buffer))
				yacc_error_code := 379
			
			yyval := yyval53
		end

	yy_do_action_447 is
			--|#line 2895
		local
			yyval53: STRING_AS
		do

				!! yyval53.make (cloned_string (token_buffer))
				yacc_error_code := 380
			
			yyval := yyval53
		end

	yy_do_action_448 is
			--|#line 2902
		local
			yyval53: STRING_AS
		do

				!! yyval53.make (cloned_string (token_buffer))
				yacc_error_code := 381
			
			yyval := yyval53
		end

	yy_do_action_449 is
			--|#line 2909
		local
			yyval4: ARRAY_AS
		do

				!! yyval4.make (yytype64 (yyvs.item (yyvsp - 1)))
				yacc_error_code := 383
			
			yyval := yyval4
		end

	yy_do_action_450 is
			--|#line 2916
		local
			yyval55: TUPLE_AS
		do

				!! yyval55.make (yytype64 (yyvs.item (yyvsp - 1)))
				yacc_error_code := 383
			
			yyval := yyval55
		end

	yy_do_action_451 is
			--|#line 2923
		local

		do
			yyval := yyval_default;
				set_position (current_position)
				yyval := current_position
			

		end

	yy_do_action_452 is
			--|#line 2930
		local

		do
			yyval := yyval_default;
				yyval := current_position
			

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
			  105,  106,  107,  108,  109,  110,  111,  112,  113>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  280,  263,  263,  263,  263,  263,  263,  263,  263,
			  264,  265,  266,  267,  268,  269,  270,  271,  234,  234,
			  234,  235,  235,  153,  150,  150,  194,  194,  194,  195,
			  195,  120,  120,  281,  281,  281,  281,  180,  180,  214,
			  214,  215,  215,  146,  283,  131,  131,  228,  228,  228,
			  228,  229,  229,  230,  230,  230,  230,  212,  212,  212,
			  212,  213,  213,  282,  282,  145,  278,  278,  279,  279,
			  275,  284,  284,  274,  274,  274,  272,  273,  276,  277,
			  124,  132,  132,  133,  133,  133,  243,  243,  243,  244,
			  244,  244,  245,  245,  169,  169,  170,  170,  170,  170,

			  170,  170,  170,  246,  246,  247,  247,  247,  248,  248,
			  173,  204,  204,  203,  203,  205,  205,  206,  206,  140,
			  147,  147,  216,  216,  216,  217,  217,  219,  219,  218,
			  218,  221,  221,  220,  220,  223,  223,  222,  222,  259,
			  259,  260,  260,  260,  260,  260,  261,  261,  192,  231,
			  231,  231,  232,  232,  233,  233,  188,  188,  178,  285,
			  177,  177,  177,  143,  144,  286,  182,  182,  159,  159,
			  262,  262,  237,  237,  237,  237,  237,  237,  238,  238,
			  156,  287,  287,  157,  157,  157,  157,  157,  157,  157,
			  157,  157,  157,  174,  174,  289,  174,  290,  139,  139,

			  291,  139,  292,  252,  252,  253,  253,  253,  254,  254,
			  184,  185,  185,  185,  187,  187,  187,  187,  187,  187,
			  187,  189,  189,  189,  189,  189,  189,  189,  189,  256,
			  256,  256,  257,  257,  257,  258,  258,  225,  225,  226,
			  226,  226,  227,  227,  148,  293,  190,  190,  224,  224,
			  152,  201,  201,  201,  202,  202,  138,  240,  240,  239,
			  239,  154,  196,  196,  196,  197,  197,  128,  241,  241,
			  242,  242,  160,  160,  160,  160,  160,  160,  160,  160,
			  160,  160,  162,  255,  255,  161,  161,  295,  193,  193,
			  193,  137,  249,  249,  249,  250,  250,  251,  251,  175,

			  236,  236,  119,  119,  176,  176,  198,  198,  199,  199,
			  200,  200,  134,  134,  134,  179,  179,  135,  135,  135,
			  136,  136,  191,  191,  114,  114,  117,  117,  155,  155,
			  155,  155,  155,  155,  155,  130,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  142,  142,
			  142,  142,  142,  151,  127,  127,  127,  127,  127,  127,
			  127,  127,  127,  127,  167,  166,  165,  168,  164,  171,
			  171,  171,  171,  126,  126,  163,  163,  115,  116,  207,

			  207,  207,  208,  208,  208,  208,  208,  209,  209,  210,
			  210,  210,  210,  210,  211,  211,  149,  149,  149,  149,
			  149,  149,  149,  149,  121,  121,  121,  121,  121,  121,
			  122,  122,  122,  122,  122,  122,  125,  125,  129,  158,
			  158,  158,  172,  172,  172,  123,  181,  181,  183,  118,
			  186,  288,  294>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   11,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    0,    2,
			    1,    1,    2,    3,    2,    0,    1,    1,    1,    3,
			    3,    1,    1,    0,    1,    1,    1,    0,    2,    0,
			    1,    1,    2,    4,    0,    0,    1,    2,    3,    2,
			    3,    1,    1,    3,    3,    3,    3,    0,    1,    2,
			    1,    3,    2,    0,    1,    3,    1,    1,    3,    3,
			    2,    0,    1,    1,    1,    1,    2,    2,    1,    1,
			    3,    0,    2,    1,    1,    1,    0,    2,    2,    1,
			    2,    1,    3,    2,    1,    2,    2,    8,    7,    6,

			    5,    4,    3,    1,    2,    1,    3,    1,    5,    3,
			    3,    0,    1,    2,    2,    1,    1,    2,    2,    3,
			    1,    1,    1,    3,    1,    5,    3,    0,    1,    1,
			    2,    0,    1,    1,    2,    0,    1,    1,    2,    0,
			    3,    0,    1,    2,    3,    1,    4,    2,    4,    1,
			    3,    1,    5,    3,    0,    1,    0,    2,    8,    0,
			    1,    1,    1,    3,    2,    0,    0,    2,    2,    2,
			    0,    2,    1,    2,    3,    4,    5,    2,    5,    2,
			    3,    0,    2,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    0,    3,    0,    4,    0,    0,    3,

			    0,    4,    0,    0,    1,    1,    2,    1,    3,    2,
			    3,    1,    3,    2,    1,    3,    3,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    0,
			    2,    3,    1,    3,    1,    5,    3,    0,    3,    0,
			    1,    1,    3,    3,    4,    0,    0,    2,    0,    3,
			    8,    0,    1,    1,    2,    2,    4,    0,    2,    0,
			    2,    6,    0,    1,    1,    2,    2,    4,    1,    1,
			    3,    3,    1,    1,    1,    3,    3,    3,    3,    3,
			    3,    3,   10,    0,    2,    0,    3,    0,    0,    4,
			    2,    5,    0,    2,    3,    1,    1,    3,    3,    1,

			    0,    2,    3,    3,    3,    3,    0,    1,    1,    1,
			    2,    2,    1,    3,    2,    6,    3,    5,    3,    6,
			    5,    4,    0,    1,    1,    1,    0,    3,    1,    1,
			    1,    1,    1,    1,    1,    4,    1,    1,    1,    1,
			    1,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    4,    3,    4,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    2,    2,    2,    2,    2,    4,    1,    2,
			    4,    2,    2,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    3,    3,    3,    5,    3,    2,
			    5,    7,    5,    1,    1,    3,    3,    2,    2,    0,

			    2,    3,    1,    3,    5,    7,    1,    9,    3,    0,
			    1,    3,    5,    1,    7,    3,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    2,    2,    1,    2,    2,    1,    1,    1,    1,    3,
			    3,    0,    0>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   18,   25,   33,  423,  422,  421,  420,  419,  418,  417,
			  416,    0,    0,   21,   25,   36,   35,   34,    0,   24,
			  447,  437,  436,   28,  445,  446,  442,  438,  439,    0,
			    0,   26,   32,  428,  424,  425,   31,  426,  427,  429,
			   63,   27,   22,    0,  444,  441,  443,  440,    0,   64,
			   23,    0,   17,   16,   15,   14,   13,   12,   11,   10,
			  237,    2,    3,    4,    5,    6,    7,    8,    9,   29,
			   30,  239,   37,  245,  240,    0,  241,    0,   86,  246,
			    0,  238,    0,   38,   63,  306,    0,  248,  242,  243,
			   89,   94,   87,   91,  229,   88,  312,  308,   39,  307,

			  309,  247,  229,  229,  229,  229,  229,  229,  229,  229,
			    0,  244,   90,   95,   93,    0,   96,    0,    0,  314,
			  310,   44,   41,  285,   40,  311,  221,  222,  223,  224,
			  225,  226,  227,  228,    0,    0,    0,  124,   73,   74,
			   75,  122,   92,    0,    0,    0,  230,    0,  232,  214,
			    0,  234,  129,  137,  103,  133,   63,  102,  127,  131,
			  135,    0,  111,   47,   49,   51,    0,   52,  313,   45,
			  287,    0,   42,   79,   77,   78,   76,  249,    0,    0,
			  229,  220,  219,  229,    0,    0,  218,  217,    0,  231,
			    0,  130,  138,  105,  104,  107,    0,  134,  115,  113,

			  116,    0,  114,  128,  131,  132,  135,  136,    0,  101,
			  112,  127,    0,   48,   50,    0,   71,   46,  451,    1,
			  126,  123,  216,  215,  233,  236,    0,    0,    0,  117,
			  118,  120,   63,  121,  135,    0,  100,  131,   55,   53,
			   56,   54,   72,   71,   43,   71,   66,  139,   67,    0,
			  451,  286,  204,  451,    0,    0,    0,  106,  109,  110,
			  119,    0,   99,  135,   71,   62,   71,  141,   63,  156,
			   71,   70,  451,  209,  378,  399,  377,  409,    0,  409,
			    0,    0,    0,  433,  432,    0,    0,    0,    0,  373,
			    0,    0,  379,  337,  336,  434,  430,  339,  431,  383,

			  211,  399,    0,  382,  376,  375,  374,  380,  381,  340,
			  435,   63,  338,  125,  235,    0,   98,    0,   61,   68,
			  149,  142,    0,  151,    0,  145,   65,    0,   81,   69,
			  208,    0,    0,    0,  389,    0,  410,  399,    0,  413,
			    0,    0,    0,    0,    0,  399,    0,    0,  365,  154,
			  364,  362,  363,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  213,  397,  366,    0,  210,  108,   97,    0,
			  143,    0,    0,  140,  147,  157,   37,   80,  394,  385,
			  399,  393,    0,    0,  400,  368,  402,    0,  406,  384,

			    0,  450,    0,    0,    0,  449,    0,    0,  316,  326,
			  341,  155,    0,  386,  348,  347,  346,  345,  344,  343,
			  342,  355,  357,  356,  358,  359,  360,    0,  349,  354,
			    0,  351,  353,  361,  212,  388,  150,  144,   63,  153,
			   84,   83,   82,   85,  159,    0,  398,  399,  372,  371,
			    0,  369,    0,  401,    0,  411,  415,    0,  399,  326,
			    0,    0,  321,    0,  367,  350,  352,    0,  146,  148,
			  193,  395,  396,  392,    0,  403,  408,    0,    0,  390,
			  320,  399,  399,  387,  152,  195,  170,  370,    0,  412,
			  399,  315,  327,  197,  451,  141,    0,  404,    0,  391,

			  451,  194,  171,  181,  165,  181,  162,  161,  160,  198,
			    0,  414,  196,  169,  451,  166,    0,  168,  200,  300,
			  405,  182,  451,  451,  452,    0,  163,  448,  164,  202,
			  451,  181,    0,    0,  451,  179,  299,    0,    0,    0,
			  322,    0,  328,  185,  191,  183,  190,  399,  187,  188,
			  184,  181,  189,  334,  330,  329,  331,  332,  333,  192,
			  186,    0,  167,  451,  199,  301,  158,  407,  451,    0,
			    0,  325,    0,  326,  324,  323,    0,    0,    0,    0,
			  180,    0,    0,  181,  292,  451,  201,  451,  303,  305,
			    0,  318,    0,    0,  302,  304,  262,    0,  283,    0,

			  181,    0,  178,    0,  326,    0,  263,  257,  264,  181,
			  451,  288,  293,  295,    0,  296,    0,  335,  326,  317,
			  273,  274,  272,  268,    0,  269,  265,  181,    0,  266,
			  251,  284,    0,    0,    0,  294,    0,  291,  319,    0,
			    0,    0,    0,  181,    0,  258,  261,    0,  252,  259,
			  253,  290,  399,    0,  297,  298,  279,  281,  280,  278,
			  277,  276,  275,  270,  267,  271,    0,  254,  181,    0,
			  255,    0,    0,  181,  260,  250,  289,  181,  256,    0,
			  282,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  573,  292,  388,  462,  293,  543,   31,   32,  294,  295,
			  268,  296,  389,  297,  606,  298,  544,  118,  387,  442,
			   97,  545,  299,  546,  648,  519,  198,  395,  396,  507,
			  515,  243,  122,  232,   74,  337,   12,  302,  548,   13,
			  549,  550,  522,  551,   37,  508,  623,  171,  552,  391,
			  303,  304,  305,  306,  307,   90,   91,  308,   38,  193,
			  486,  559,  560,  509,  443,  309,   78,  310,  526,  528,
			  250,  311,  312,  148,  328,  149,   87,  576,  321,  633,
			   40,   41,  607,  608,   98,   99,  100,  649,  650,  158,
			  211,  199,  200,  373,  397,  398,  338,  339,  244,  245,

			  123,  124,  136,  137,  203,  204,  205,  206,  207,  208,
			  111,   72,   75,   76,  201,  166,  167,  322,  323,  412,
			    2,   14,  532,  513,  523,  669,  628,  624,  625,   85,
			   92,   93,  162,  194,  195,  600,  614,  615,  251,  252,
			  253,  611,  116,  150,  151,  269,  324,  325,  496,  138,
			   61,   62,   63,   64,   65,   66,   67,   68,  139,  140,
			  141,  246,  176,  174,  247,  248,  681,   18,   50,  169,
			  249,  470,  516,  514,  254,  494,  500,  530,  563,   79,
			  561,  218>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  476, 1397,   -8, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  509,  546, -32768,  744, -32768, -32768, -32768,  490, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  162,
			   98,  504, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  318,  502, -32768, 1444, -32768, -32768, -32768, -32768,  688, -32768,
			 -32768,  688, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  492, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  488,  454, -32768,  496,  487,  493,  -23,  448,  473,
			  488, -32768,  488, -32768, 1423,  475, 1444,  478, -32768, -32768,
			 1444,  481, -32768, 1444,  428, -32768, 1248,  475,  444, -32768,

			  475, -32768,  428,  428,  428,  428,  428,  428,  428,  428,
			 1404, -32768, 1444, -32768, -32768, 1381,  153,  292, 1404, 1437,
			 -32768, -32768, -32768,  436,  444, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  -23,  -23,  429,  467, -32768, -32768,
			 -32768,  464, -32768, 1444, 1413, 1444, -32768,  570,  463, -32768,
			  453,  451, 1404, 1404, 1404, 1404,  198, -32768,  371,  363,
			  350,  425,  416, -32768, -32768,  446,   19,  437, -32768,  423,
			 -32768,  420, -32768, -32768, -32768, -32768, -32768, -32768, 1404, 1404,
			  428, -32768, -32768,  428,  445,  443, -32768, -32768, 1063, -32768,
			 1063, -32768, -32768,  431, -32768,  419,  415, -32768,  423, -32768,

			  423,  424, -32768, -32768,  363, -32768,  350, -32768,  392, -32768,
			 -32768,  371,  326, -32768, -32768,  299,  264, -32768,  233, -32768,
			 -32768,  414, -32768, -32768,  413, -32768, 1404, 1404, 1404, -32768,
			 -32768, -32768,  318, -32768,  350,  387, -32768,  363, -32768, -32768,
			 -32768, -32768, -32768,  238, -32768,  200,  409,  422,  406, 1404,
			 1614, -32768, -32768, 1612, 1183, 1404, 1063,  405, -32768, -32768,
			 -32768,  377, -32768,  350,  160, -32768,  366,  716,  318,  401,
			  366, -32768,  745, -32768,  410,   17,  290, 1183, 1337, 1183,
			  379,  924, 1063, -32768, -32768, 1183, 1183,  399, 1183, -32768,
			 1183, 1183,  287, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 1795,   48, 1183, -32768, -32768, -32768, -32768, -32768,  281, -32768,
			 -32768,  318, -32768, -32768, -32768, 1404, -32768,  359, -32768, -32768,
			  382,  716,  381,  372,  367,  716, -32768, 1063,  331, -32768,
			 -32768,  716, 1444,  859, -32768,  716, 1777,  313,  360,  348,
			 1444,  361,  344, 1063, 1063,  313,  351, 1650, -32768,  716,
			 -32768, -32768, -32768,  716, 1183, 1183, 1183, 1183, 1183, 1183,
			 1183, 1183, 1183, 1183, 1183, 1183, 1183, 1089, 1183, 1047,
			 1183, 1183, 1183, -32768, -32768,  716, -32768, -32768, -32768,  716,
			  716, 1063,  716, -32768, -32768, -32768,  630, -32768,  328, -32768,
			  313, -32768,  339, 1288, -32768, 1795,  343,  338,  337, -32768,

			 1183, -32768, 1183,  329,  295, -32768,  327,  325, -32768,  194,
			  261, -32768,  314, -32768,  136,  136,  136,  136,  136,  398,
			  398, 1405, 1405, 1405, 1405, 1405, 1405, 1183, 1825, 1811,
			 1183, 1757, 1631, -32768, 1795, -32768,  330,  716,  318, -32768,
			 -32768, -32768, -32768, -32768, -32768,  716, -32768,  313, -32768, -32768,
			 1183, -32768,  953, -32768,  953, 1740, 1795,  308,  313,  194,
			 1404,  716, -32768,  716, -32768, 1825, 1757,  716, -32768, -32768,
			  262,  328, -32768, -32768, 1609,  309, -32768, 1183,  265, -32768,
			 -32768,  313,  313, -32768, -32768,  285,  260, -32768,  953, 1722,
			  313, -32768, -32768, -32768,   91,  716,   41,  300, 1183, -32768,

			   91, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  272,
			  953, 1795, -32768, -32768, 1494,  304,  118, -32768,  228,  232,
			  279, -32768, 1625, 1490, 1234,  118, -32768, -32768, -32768, -32768,
			  -20, -32768,  254,  953, 1266, -32768, -32768,   12,  290,  678,
			 1063, 1183,  287, -32768, -32768, -32768, -32768,   40, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  281, -32768,
			 -32768,  231, -32768,  -20, -32768, -32768, -32768, -32768,  636, 1183,
			 1183, -32768, 1063,  194, -32768, -32768,  263, 1591, 1183, 1183,
			  273, 1183, 1183, -32768,  269,  233, -32768,  508, 1795, 1795,
			  248, -32768,  945,  261, 1795, 1795,  851, 1292,  178,   39,

			 -32768,  221, -32768,  945,  194,  449,  165,  220,  165, -32768,
			  -22,  156, -32768,  211,  192,  186,  168, -32768,  194, -32768,
			  213,  207,  173,  148,    9,  133, -32768, -32768,  105, -32768,
			   54, -32768, 1183,   64,  118, -32768,  118, -32768, -32768,  462,
			  449,  570,  449, -32768,  449, -32768, -32768, 1183,   54,   72,
			   54, 1795,  -12, 1183, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, 1238, -32768, -32768,   49,
			 -32768, 1183, 1392, -32768, -32768, -32768, 1795, -32768, -32768,   26,
			 -32768,   81,   42, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -512,  132,  201, -451, -32768, -32768,   63,  268, -32768,    6,
			 -32768,   -2, -314, -32768, -354,  -10, -32768,  468, -32768, -32768,
			  -25, -32768, -32768, -32768, -400, -32768,   25,  255, -289, -32768,
			 -32768,  -79,  512, -32768,  127,   -1, -32768,  342, -32768,  591,
			 -32768, -32768, -340, -32768, -144, -32768, -439, -32768, -32768,  190,
			  109,  104,   77,   76,   70,   65, -32768,   69, -32768, -203,
			 -32768, -32768, -32768, -32768, -32768, -32768,  204,    5, -32768, -489,
			 -153, -32768, -32768, -183, -32768,  506, -32768, -32768, -296, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  426,
			 -32768, -32768, -32768, -177, -32768, -32768,  310, -32768, -32768, -32768,

			 -32768, -32768,  -59, -32768,  466,  376,  465, -169,  458, -194,
			 -32768, -32768, -32768, -32768,  -81, -32768, -32768,  210, -32768, -32768,
			 -32768, -32768, -32768, -162, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -415, -32768,
			 -32768, -32768,  259, -32768, -32768, -32768,   67, -32768, -32768,   94,
			  -52,  -55,  -60,  -64,  -67,  -70,  -82,  -85, -32768, -32768,
			  -47, -238, -32768, -32768, -32768, -32768, -32768, -32768,  -78, -32768,
			 -32768, -32768, -32768,    7, -178, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   11,  109,   35,  187,  108,  224,   95,  225,  480,   25,
			   34,   36,  235,   11,  333,  119,  107,   39,   33,  106,
			  214,  399,  105,  257,  258,  380,  104,  671,  319,  384,
			  109,  103,  329,  108,  102,  234,  562,  331,   35,  413,
			  261,   35,  683,  333, -203,  107,   34,   36,  106,   34,
			   36,  105,   17,   39,   33,  104,   39,   33,   16,  168,
			  103,  435,  332,  102,  570,  213,  333,  569,  263,  317,
			 -203,  527,  120,  314,  333,  125, -203, -203,  202,  501,
			  604,  682,   83,  612,  437,  512,   15,  372,  217,   20,
			  680,  618,  579,  191,  192,  578,  197,  272,  334,  346,

			  273,  506,  505,  109,  643,  109,  108,  196,  108,  504,
			  613,   69,  377,  675,   70,  564,  165,  647,  107,  330,
			  107,  106,  591,  106,  105,  503,  105,   47,  104,   46,
			  104,  220,  221,  103,  668,  103,  102,   60,  102,  173,
			  175,  468,  233,  182,  385,  654,  186,  655,  586,  483,
			  527, -203, -203,  619,  260,  112,  354,  289,  114, -203,
			  406,  407,  653,  475,  264,  476,  265,  638,  408,  646,
			  601,  109, -203,  644,  108, -203,  641,  142,   94,  196,
			  196,  259,  534,  535,   94,  318,  107,   94,  642,  106,
			  326,   45,  105,   44,  568,  631,  104,  109,  438,  497,

			  108,  103,  271,  663,  102,  665,   94,   88,  313,   89,
			  640,  239,  107,  446,  241,  106,  639,  157,  105,  461,
			  156,  520,  104,  229,  -59,  230,  636,  103,  587,  -59,
			  102,  242,  637,  376,  345,   49,  635,  180,  -59,  183,
			  155,  154,  109,  117,  567,  108,  153,  602,  667,  152,
			  670,  634,  626,  301,  629,  632,  610,  107,  109,  109,
			  106,  108,  108,  105,  -60,  605,  320,  104,  196,  -60,
			  473,  242,  103,  107,  107,  102,  106,  106,  -60,  105,
			  105,  479,  627,  104,  104,  617,  463,  585,  103,  103,
			  584,  102,  102,  164,  603,  599,  109, -203,  592,  108,

			  240,  583,  -58,  582,  491,  492,  375,  -58,  581,  242,
			  521,  107,  353,  499,  106,  335,  -58,  105,  566,  533,
			  320,  104,  531,  529,  320,   10,  103,  238,  -57,  102,
			  390,  525,   10,  -57,  390,  242,  524,  518,  163,  333,
			  510,  495,  -57,  517,  524,  524,  451,  493,  320,  488,
			  490,  485,  390,  445,  478,   49,  524,  575,  464,   10,
			  469,  126,  127,  128,  129,  130,  131,  132,  133,  565,
			  467,  460,  341,  459,  390,  457,   35,  454,  436,  320,
			  458,  439,  453,  452,   34,  447,  409,  405,  402,  590,
			  524,   39,   33,    9,    8,    7,    6,    5,    4,    3,

			    9,    8,    7,    6,    5,    4,    3,  404,  401,  524,
			  386,  383,  382,  481,  358,  357,  356,  355,  354,  289,
			  381,  598,  379,  378,  343,  349,  392,    9,    8,    7,
			    6,    5,    4,    3,  403,  331,  320,  242,  616,  222,
			  327,  316,  223,  153,  390,  315,  270,  630,  267,  266,
			  155,  262,  231,  256,  255,  109,  236,   59,  108,  227,
			  482,  622,  390,  185,  184,  645,  484,  152,  117,  228,
			  107,  226,   47,  106,   45,  115,  105,  215,   28,   27,
			  104,  664,   10,  156,  219,  103,  212,  109,  102,  209,
			  108,  190,   27,  177,  320,   10,  660,  662,  622,  135,

			  622,  189,  107,  188,  179,  106,  674,  178,  105,  300,
			  134,  678,  104,  121,  170,  679,   96,  103,  113,  110,
			  102,   73,   86,  547,   84,   58,   57,   56,   55,   54,
			   53,   52,  336,   82,  336,   81,   80,   77,  574,   71,
			  347,  348,   51,  350,   48,  351,  352,   43,   19,    1,
			    9,    8,    7,    6,    5,    4,    3,  374,  580,  411,
			   30,   29,  502,    9,    8,    7,    6,    5,    4,    3,
			 -176, -176, -176, -176,  161,   28,   27,   26,   25,   10,
			   24,  160,  159,   23,  185,  184, -176,  237,  210,  342,
			  444,  574,  101,  558,  557,  620,   22,   21, -176,   28,

			  556,  555,  574,   10,  621,   42, -176, -176, -176,  414,
			  415,  416,  417,  418,  419,  420,  421,  422,  423,  424,
			  425,  426,  428,  429,  431,  432,  433,  434,  554,  656,
			  658,  652,  620,  553,  620,  472,  172,  216,  657,  659,
			  661,  621,  371,  621,   30,   29,  471,    9,    8,    7,
			    6,    5,    4,    3,  441,  455,  542,  456,   20,   28,
			   27,   26,   25,    0,   24,    0,    0,    0,    0,    0,
			    0,    9,    8,    7,    6,    5,    4,    3,  371,    0,
			   22,   21,  465,    0,    0,  466,    0,    0,    0,  371,
			  371,    0,  371,  371,  371,    0,    0,    0, -175, -175,

			 -175, -175,   30,   29,    0,  474,    0,    0,    0,    0,
			    0,   10,    0,   77, -175,    0,  371,   28,   27,   26,
			   25,   10,   24,  572,    0,    0, -175,  440,    0,    0,
			    0,    0,  489,    0, -175, -175, -175,  371,   22,   21,
			    0,    0,   20,    0,    0,    0,    0,    0,    0,   10,
			    0,    0,    0,  511,    0,    0,  371,  371,  371,  371,
			  371,  371,  371,  371,  371,  371,  371,  371,  371,  571,
			  371,  371,    0,  371,  371,  371,  371,   10,    0,    9,
			    8,    7,    6,    5,    4,    3,    0,    0,    0,    9,
			    8,    7,    6,    5,    4,    3,  577,  371,  371,    0,

			   20,  -19,    0,    0,  -19, -206, -206,  371,  371, -206,
			  -19,    0,    0, -206,    0,    0,  371,    9,    8,    7,
			    6,    5,    4,    3,  588,  589, -206,    0,    0, -206,
			    0,  371,    0,  594,  595, -206,  596,  597,  -19,    0,
			    0,    0,    0, -206, -206,    9,    8,    7,    6,    5,
			    4,    3,    0,  371,    0,  370,  369,  368,  367,  366,
			  365,  364,  363,  362,  361,  360,  359,  358,  357,  356,
			  355,  354,  289,  291,  290,    0,    0,    0,    0,    0,
			  289,  288,  287,  286,    0,  285,    0,  651,  284,   27,
			  283,   25,   10,   24,  282,    0,    0,  281,    0,    0,

			  280,  279,  666,  394,  278,    0,  277,    0,  672,   22,
			   21,    0,  393,    0,    0,    0,    0,  276,    0,  371,
			    0,    0,    0,    0,    0,    0,  676,    0,    0,    0,
			  371,  371,    0,    0,    0,    0,  371,  371,  371,  371,
			    0,    0,    0,    0,  275,    0,    0,    0,    0,    0,
			  274,  605,    0,    0,    0,    0,    0,   59,    0,    0,
			    9,    8,    7,    6,    5,    4,    3,  291,  290,  344,
			    0,   20,    0,    0,  289,  288,  287,  286,   10,  285,
			    0,    0,  284,   27,  283,   25,   10,   24,  282,    0,
			    0,  281,    0,  371,  280,  279,    0,    0,  278,  135,

			  277,    0,    0,   22,   21,    0,  393,    0,  371,    0,
			  134,  276,    0,    0,  371,    0,    0,    0,  371,    0,
			    0,    0,    0,    0,    0,   58,   57,   56,   55,   54,
			   53,   52,    0,    0,    0,    0,  571,    0,  275,    0,
			    0,    0,    0,    0,  274,    0,    9,    8,    7,    6,
			    5,    4,    3,    0,    9,    8,    7,    6,    5,    4,
			    3,  291,  290,    0,    0,   20,    0,    0,  289,  288,
			  287,  286,    0,  285,    0,    0,  284,   27,  283,   25,
			   10,   24,  282,    0,    0,  281,    0,    0,  280,  279,
			    0,    0,  278,    0,  277,    0,   59,   22,   21,  147,

			    0,    0,    0,  291,  290,  276,    0,    0,    0,  430,
			  289,  288,  287,  286,    0,  285,    0,    0,  284,   27,
			  283,   25,   10,   24,  282,    0,    0,  281,    0,  145,
			  280,  279,  275,    0,  278,    0,  277,    0,  274,   22,
			   21,    0,    0,  144,    0,    0,    0,  276,    9,    8,
			    7,    6,    5,    4,    3,    0,    0,  143,    0,   20,
			    0,    0,    0,    0,   58,   57,   56,   55,   54,   53,
			   52,    0,    0,    0,  275,    0,    0,    0,    0,    0,
			  274,    0,    0,    0,  427,    0,    0,    0,    0,    0,
			    9,    8,    7,    6,    5,    4,    3,  291,  290,    0,

			    0,   20,    0,    0,  289,  288,  287,  286,    0,  285,
			    0,    0,  284,   27,  283,   25,   10,   24,  282,    0,
			    0,  281,    0,    0,  280,  279,    0,    0,  278,    0,
			  277,    0,    0,   22,   21,    0,    0,    0,    0,    0,
			    0,  276,  370,  369,  368,  367,  366,  365,  364,  363,
			  362,  361,  360,  359,  358,  357,  356,  355,  354,  289,
			  541,    0,    0,    0,    0,    0,    0,   10,  275,  540,
			    0,    0,    0,    0,  274,  539,    0,    0,    0,  278,
			    0,  -45,    0,    0,    9,    8,    7,    6,    5,    4,
			    3,    0,  538,  117,    0,   20,  370,  369,  368,  367,

			  366,  365,  364,  363,  362,  361,  360,  359,  358,  357,
			  356,  355,  354,  289,  450,    0,    0,    0,    0,  275,
			    0,   59,    0,  -45,    0,  537,  536,    0, -174, -174,
			 -174, -174,    0,  673,  -45,    9,    8,    7,    6,    5,
			    4,    3,    0,    0, -174,    0,  449,    0,    0,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45, -174,    0,    0,    0,
			    0,    0,    0,  135, -174, -174, -174,    0,    0,    0,
			   59,    0,    0,    0,  134,    0,    0,    0,    0,  448,
			    0,    0,  340,    0,    0,    0,    0,  609,    0,   58,
			   57,   56,   55,   54,   53,   52,  370,  369,  368,  367,

			  366,  365,  364,  363,  362,  361,  360,  359,  358,  357,
			  356,  355,  354,  289,   59,    0,    0,  147,    0,  360,
			  359,  358,  357,  356,  355,  354,  289,    0,    0,  146,
			   10,    0,    0,    0,    0,    0,    0,   59,   58,   57,
			   56,   55,   54,   53,   52,    0,   10,  145,    0,    0,
			    0,    0,    0,    0,  -20,    0,   59,  -20,    0,    0,
			   49,  144,    0,  -20,    0,    0,    0,    0,    0,    0,
			  -46,  181,    0,    0,  677,  143,    0,   59,    0,  135,
			    0,    0,   58,   57,   56,   55,   54,   53,   52,    0,
			  134,  -20,    0,    0,    0,    0,    0,    0,    9,    8,

			    7,    6,    5,    4,    3,   58,   57,   56,   55,   54,
			   53,   52,  -46,    0,    9,    8,    7,    6,    5,    4,
			    3,    0,    0,  -46,   58,   57,   56,   55,   54,   53,
			   52,  521,    0,    0,    0,    0,    0,    0,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,   58,   57,   56,   55,   54,
			   53,   52, -177, -177, -177, -177, -172, -172, -172, -172,
			    0,    0,    0,    0,    0,    0,    0,    0, -177,    0,
			    0,    0, -172,    0,    0,    0,    0,    0,    0,    0,
			 -177,    0,    0,    0, -172,    0,    0,    0, -177, -177,
			 -177,    0, -172, -172, -172,  370,  369,  368,  367,  366,

			  365,  364,  363,  362,  361,  360,  359,  358,  357,  356,
			  355,  354,  289,  370,  369,  368,  367,  366,  365,  364,
			  363,  362,  361,  360,  359,  358,  357,  356,  355,  354,
			  289,    0,    0,    0,    0,  593,  369,  368,  367,  366,
			  365,  364,  363,  362,  361,  360,  359,  358,  357,  356,
			  355,  354,  289,  487,  370,  369,  368,  367,  366,  365,
			  364,  363,  362,  361,  360,  359,  358,  357,  356,  355,
			  354,  289, -207, -207, -205, -205, -207,    0, -205,    0,
			 -207,    0, -205,    0,    0,    0,    0, -173, -173, -173,
			 -173,    0,    0, -207,  410, -205, -207,    0, -205,    0,

			    0,    0, -207, -173, -205,    0,    0,    0,    0,    0,
			 -207, -207, -205, -205,    0, -173,    0,    0,    0,    0,
			    0,    0,    0, -173, -173, -173,  370,  369,  368,  367,
			  366,  365,  364,  363,  362,  361,  360,  359,  358,  357,
			  356,  355,  354,  289,  370,  369,  368,  367,  366,  365,
			  364,  363,  362,  361,  360,  359,  358,  357,  356,  355,
			  354,  289,  498,  368,  367,  366,  365,  364,  363,  362,
			  361,  360,  359,  358,  357,  356,  355,  354,  289,    0,
			  477,  370,  369,  368,  367,  366,  365,  364,  363,  362,
			  361,  360,  359,  358,  357,  356,  355,  354,  289,  370,

			  369,  368,  367,  366,  365,  364,  363,  362,  361,  360,
			  359,  358,  357,  356,  355,  354,  289,  400,  367,  366,
			  365,  364,  363,  362,  361,  360,  359,  358,  357,  356,
			  355,  354,  289,  366,  365,  364,  363,  362,  361,  360,
			  359,  358,  357,  356,  355,  354,  289>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,   86,   12,  147,   86,  188,   84,  190,  459,   32,
			   12,   12,  206,   14,   26,   96,   86,   12,   12,   86,
			    1,  335,   86,  226,  227,  321,   86,   39,  266,  325,
			  115,   86,  270,  115,   86,  204,  525,   25,   48,  353,
			  234,   51,    0,   26,   64,  115,   48,   48,  115,   51,
			   51,  115,   60,   48,   48,  115,   51,   51,   66,  118,
			  115,  375,   45,  115,   52,   46,   26,   55,  237,  263,
			   90,   32,   97,  256,   26,  100,   98,   99,  156,  494,
			  592,    0,   77,   44,  380,  500,   94,   39,  169,  112,
			   64,  603,   52,  152,  153,   55,  155,  250,  275,  282,

			  253,   60,   61,  188,   95,  190,  188,  154,  190,   68,
			  599,   48,  315,   64,   51,  530,  117,   63,  188,  272,
			  190,  188,  573,  190,  188,   84,  190,   29,  188,   31,
			  190,  178,  179,  188,   62,  190,  188,   43,  190,  134,
			  135,  437,  201,  144,  327,  634,  147,  636,  563,  463,
			   32,   60,   61,  604,  232,   90,   20,   21,   93,   68,
			  343,  344,   98,  452,  243,  454,  245,  618,  345,   64,
			  585,  256,   81,   40,  256,   84,    3,  112,   84,  226,
			  227,  228,  522,  523,   90,  264,  256,   93,   40,  256,
			  268,   29,  256,   31,  534,  610,  256,  282,  381,  488,

			  282,  256,  249,  642,  256,  644,  112,   80,  255,   82,
			    3,  212,  282,  390,  215,  282,    3,   64,  282,   25,
			   67,  510,  282,  198,   64,  200,   40,  282,  568,   69,
			  282,   71,   64,  311,  281,   37,   44,  143,   78,  145,
			   87,   88,  327,   45,  533,  327,   93,  587,  648,   96,
			  650,   40,  606,  254,  608,   99,   78,  327,  343,  344,
			  327,  343,  344,  327,   64,  100,  267,  327,  315,   69,
			  447,   71,  327,  343,  344,  327,  343,  344,   78,  343,
			  344,  458,   62,  343,  344,   64,   25,   56,  343,  344,
			   59,  343,  344,    1,   46,   26,  381,   64,   35,  381,

			    1,   70,   64,   72,  481,  482,   25,   69,   77,   71,
			   37,  381,   25,  490,  381,   25,   78,  381,   64,   40,
			  321,  381,   90,   95,  325,   33,  381,    1,   64,  381,
			  331,   27,   33,   69,  335,   71,  514,   65,   46,   26,
			   40,   81,   78,  505,  522,  523,  393,   62,  349,   40,
			   85,   89,  353,   25,   46,   37,  534,  540,   44,   33,
			  438,  102,  103,  104,  105,  106,  107,  108,  109,  531,
			   40,   46,  278,   46,  375,   46,  386,   40,  379,  380,
			   85,  382,   44,   40,  386,   46,   35,   43,   40,  572,
			  568,  386,  386,  101,  102,  103,  104,  105,  106,  107,

			  101,  102,  103,  104,  105,  106,  107,   46,   48,  587,
			   79,   44,   40,  460,   16,   17,   18,   19,   20,   21,
			   39,  583,   40,   64,   45,   26,  332,  101,  102,  103,
			  104,  105,  106,  107,  340,   25,  437,   71,  600,  180,
			   39,   64,  183,   93,  445,   40,   40,  609,   26,   40,
			   87,   64,   28,   40,   40,  540,   64,   33,  540,   40,
			  461,  605,  463,   14,   15,  627,  467,   96,   45,   54,
			  540,   40,   29,  540,   29,   47,  540,   40,   29,   30,
			  540,  643,   33,   67,   64,  540,   40,  572,  540,   64,
			  572,   40,   30,   64,  495,   33,  640,  641,  642,   75,

			  644,   48,  572,   40,   40,  572,  668,   40,  572,  254,
			   86,  673,  572,   69,   78,  677,   41,  572,   37,   41,
			  572,   33,   49,  524,   76,  101,  102,  103,  104,  105,
			  106,  107,  277,   40,  279,   48,   40,   83,  539,   47,
			  285,  286,   40,  288,   40,  290,  291,   57,   39,   73,
			  101,  102,  103,  104,  105,  106,  107,  302,  551,  349,
			   14,   15,  495,  101,  102,  103,  104,  105,  106,  107,
			   62,   63,   64,   65,  116,   29,   30,   31,   32,   33,
			   34,  116,  116,   37,   14,   15,   78,  211,  162,  279,
			  386,  592,   86,  524,  524,  605,   50,   51,   90,   29,

			  524,  524,  603,   33,  605,   14,   98,   99,  100,  354,
			  355,  356,  357,  358,  359,  360,  361,  362,  363,  364,
			  365,  366,  367,  368,  369,  370,  371,  372,  524,  639,
			  640,  632,  642,  524,  644,  445,  124,  169,  639,  640,
			  641,  642,  300,  644,   14,   15,  445,  101,  102,  103,
			  104,  105,  106,  107,  386,  400,  524,  402,  112,   29,
			   30,   31,   32,    0,   34,    0,    0,    0,    0,    0,
			    0,  101,  102,  103,  104,  105,  106,  107,  336,    0,
			   50,   51,  427,    0,    0,  430,    0,    0,    0,  347,
			  348,    0,  350,  351,  352,    0,    0,    0,   62,   63,

			   64,   65,   14,   15,    0,  450,    0,    0,    0,    0,
			    0,   33,    0,   83,   78,    0,  374,   29,   30,   31,
			   32,   33,   34,   45,    0,    0,   90,   97,    0,    0,
			    0,    0,  477,    0,   98,   99,  100,  395,   50,   51,
			    0,    0,  112,    0,    0,    0,    0,    0,    0,   33,
			    0,    0,    0,  498,    0,    0,  414,  415,  416,  417,
			  418,  419,  420,  421,  422,  423,  424,  425,  426,   91,
			  428,  429,    0,  431,  432,  433,  434,   33,    0,  101,
			  102,  103,  104,  105,  106,  107,    0,    0,    0,  101,
			  102,  103,  104,  105,  106,  107,  541,  455,  456,    0,

			  112,   57,    0,    0,   60,   60,   61,  465,  466,   64,
			   66,    0,    0,   68,    0,    0,  474,  101,  102,  103,
			  104,  105,  106,  107,  569,  570,   81,    0,    0,   84,
			    0,  489,    0,  578,  579,   90,  581,  582,   94,    0,
			    0,    0,    0,   98,   99,  101,  102,  103,  104,  105,
			  106,  107,    0,  511,    0,    4,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   14,   15,    0,    0,    0,    0,    0,
			   21,   22,   23,   24,    0,   26,    0,  632,   29,   30,
			   31,   32,   33,   34,   35,    0,    0,   38,    0,    0,

			   41,   42,  647,   44,   45,    0,   47,    0,  653,   50,
			   51,    0,   53,    0,    0,    0,    0,   58,    0,  577,
			    0,    0,    0,    0,    0,    0,  671,    0,    0,    0,
			  588,  589,    0,    0,    0,    0,  594,  595,  596,  597,
			    0,    0,    0,    0,   85,    0,    0,    0,    0,    0,
			   91,  100,    0,    0,    0,    0,    0,   33,    0,    0,
			  101,  102,  103,  104,  105,  106,  107,   14,   15,   45,
			    0,  112,    0,    0,   21,   22,   23,   24,   33,   26,
			    0,    0,   29,   30,   31,   32,   33,   34,   35,    0,
			    0,   38,    0,  651,   41,   42,    0,    0,   45,   75,

			   47,    0,    0,   50,   51,    0,   53,    0,  666,    0,
			   86,   58,    0,    0,  672,    0,    0,    0,  676,    0,
			    0,    0,    0,    0,    0,  101,  102,  103,  104,  105,
			  106,  107,    0,    0,    0,    0,   91,    0,   85,    0,
			    0,    0,    0,    0,   91,    0,  101,  102,  103,  104,
			  105,  106,  107,    0,  101,  102,  103,  104,  105,  106,
			  107,   14,   15,    0,    0,  112,    0,    0,   21,   22,
			   23,   24,    0,   26,    0,    0,   29,   30,   31,   32,
			   33,   34,   35,    0,    0,   38,    0,    0,   41,   42,
			    0,    0,   45,    0,   47,    0,   33,   50,   51,   36,

			    0,    0,    0,   14,   15,   58,    0,    0,    0,   62,
			   21,   22,   23,   24,    0,   26,    0,    0,   29,   30,
			   31,   32,   33,   34,   35,    0,    0,   38,    0,   66,
			   41,   42,   85,    0,   45,    0,   47,    0,   91,   50,
			   51,    0,    0,   80,    0,    0,    0,   58,  101,  102,
			  103,  104,  105,  106,  107,    0,    0,   94,    0,  112,
			    0,    0,    0,    0,  101,  102,  103,  104,  105,  106,
			  107,    0,    0,    0,   85,    0,    0,    0,    0,    0,
			   91,    0,    0,    0,   95,    0,    0,    0,    0,    0,
			  101,  102,  103,  104,  105,  106,  107,   14,   15,    0,

			    0,  112,    0,    0,   21,   22,   23,   24,    0,   26,
			    0,    0,   29,   30,   31,   32,   33,   34,   35,    0,
			    0,   38,    0,    0,   41,   42,    0,    0,   45,    0,
			   47,    0,    0,   50,   51,    0,    0,    0,    0,    0,
			    0,   58,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   26,    0,    0,    0,    0,    0,    0,   33,   85,   35,
			    0,    0,    0,    0,   91,   41,    0,    0,    0,   45,
			    0,   33,    0,    0,  101,  102,  103,  104,  105,  106,
			  107,    0,   58,   45,    0,  112,    4,    5,    6,    7,

			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   26,    0,    0,    0,    0,   85,
			    0,   33,    0,   75,    0,   91,   92,    0,   62,   63,
			   64,   65,    0,   95,   86,  101,  102,  103,  104,  105,
			  106,  107,    0,    0,   78,    0,   58,    0,    0,  101,
			  102,  103,  104,  105,  106,  107,   90,    0,    0,    0,
			    0,    0,    0,   75,   98,   99,  100,    0,    0,    0,
			   33,    0,    0,    0,   86,    0,    0,    0,    0,   91,
			    0,    0,   45,    0,    0,    0,    0,   95,    0,  101,
			  102,  103,  104,  105,  106,  107,    4,    5,    6,    7,

			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   33,    0,    0,   36,    0,   14,
			   15,   16,   17,   18,   19,   20,   21,    0,    0,   48,
			   33,    0,    0,    0,    0,    0,    0,   33,  101,  102,
			  103,  104,  105,  106,  107,    0,   33,   66,    0,    0,
			    0,    0,    0,    0,   57,    0,   33,   60,    0,    0,
			   37,   80,    0,   66,    0,    0,    0,    0,    0,    0,
			   33,   58,    0,    0,   82,   94,    0,   33,    0,   75,
			    0,    0,  101,  102,  103,  104,  105,  106,  107,    0,
			   86,   94,    0,    0,    0,    0,    0,    0,  101,  102,

			  103,  104,  105,  106,  107,  101,  102,  103,  104,  105,
			  106,  107,   75,    0,  101,  102,  103,  104,  105,  106,
			  107,    0,    0,   86,  101,  102,  103,  104,  105,  106,
			  107,   37,    0,    0,    0,    0,    0,    0,  101,  102,
			  103,  104,  105,  106,  107,  101,  102,  103,  104,  105,
			  106,  107,   62,   63,   64,   65,   62,   63,   64,   65,
			    0,    0,    0,    0,    0,    0,    0,    0,   78,    0,
			    0,    0,   78,    0,    0,    0,    0,    0,    0,    0,
			   90,    0,    0,    0,   90,    0,    0,    0,   98,   99,
			  100,    0,   98,   99,  100,    4,    5,    6,    7,    8,

			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,    0,    0,    0,    0,   44,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   44,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   60,   61,   60,   61,   64,    0,   64,    0,
			   68,    0,   68,    0,    0,    0,    0,   62,   63,   64,
			   65,    0,    0,   81,   44,   81,   84,    0,   84,    0,

			    0,    0,   90,   78,   90,    0,    0,    0,    0,    0,
			   98,   99,   98,   99,    0,   90,    0,    0,    0,    0,
			    0,    0,    0,   98,   99,  100,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   40,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,    0,
			   40,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,    4,

			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   40,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,    8,    9,   10,   11,   12,   13,   14,
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

	yytype36 (v: ANY): INTEGER_AS is
		require
			valid_type: yyis_type36 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type36 (v: ANY): BOOLEAN is
		local
			u: INTEGER_AS
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

	yytype43 (v: ANY): PARENT_AS is
		require
			valid_type: yyis_type43 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type43 (v: ANY): BOOLEAN is
		local
			u: PARENT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype44 (v: ANY): PRECURSOR_AS is
		require
			valid_type: yyis_type44 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type44 (v: ANY): BOOLEAN is
		local
			u: PRECURSOR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype45 (v: ANY): REAL_AS is
		require
			valid_type: yyis_type45 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type45 (v: ANY): BOOLEAN is
		local
			u: REAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype46 (v: ANY): RENAME_AS is
		require
			valid_type: yyis_type46 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type46 (v: ANY): BOOLEAN is
		local
			u: RENAME_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype47 (v: ANY): REQUIRE_AS is
		require
			valid_type: yyis_type47 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type47 (v: ANY): BOOLEAN is
		local
			u: REQUIRE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype48 (v: ANY): RETRY_AS is
		require
			valid_type: yyis_type48 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type48 (v: ANY): BOOLEAN is
		local
			u: RETRY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype49 (v: ANY): REVERSE_AS is
		require
			valid_type: yyis_type49 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type49 (v: ANY): BOOLEAN is
		local
			u: REVERSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype50 (v: ANY): ROUT_BODY_AS is
		require
			valid_type: yyis_type50 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type50 (v: ANY): BOOLEAN is
		local
			u: ROUT_BODY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype51 (v: ANY): ROUTINE_AS is
		require
			valid_type: yyis_type51 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type51 (v: ANY): BOOLEAN is
		local
			u: ROUTINE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype52 (v: ANY): ROUTINE_CREATION_AS is
		require
			valid_type: yyis_type52 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type52 (v: ANY): BOOLEAN is
		local
			u: ROUTINE_CREATION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype53 (v: ANY): STRING_AS is
		require
			valid_type: yyis_type53 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type53 (v: ANY): BOOLEAN is
		local
			u: STRING_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype54 (v: ANY): TAGGED_AS is
		require
			valid_type: yyis_type54 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type54 (v: ANY): BOOLEAN is
		local
			u: TAGGED_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype55 (v: ANY): TUPLE_AS is
		require
			valid_type: yyis_type55 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type55 (v: ANY): BOOLEAN is
		local
			u: TUPLE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype56 (v: ANY): TYPE is
		require
			valid_type: yyis_type56 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type56 (v: ANY): BOOLEAN is
		local
			u: TYPE
		do
			u ?= v
			Result := (u = v)
		end

	yytype57 (v: ANY): TYPE_DEC_AS is
		require
			valid_type: yyis_type57 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type57 (v: ANY): BOOLEAN is
		local
			u: TYPE_DEC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype58 (v: ANY): VARIANT_AS is
		require
			valid_type: yyis_type58 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type58 (v: ANY): BOOLEAN is
		local
			u: VARIANT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype59 (v: ANY): EIFFEL_LIST [ATOMIC_AS] is
		require
			valid_type: yyis_type59 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type59 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ATOMIC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype60 (v: ANY): EIFFEL_LIST [CASE_AS] is
		require
			valid_type: yyis_type60 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type60 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CASE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype61 (v: ANY): EIFFEL_LIST [CREATE_AS] is
		require
			valid_type: yyis_type61 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type61 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CREATE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype62 (v: ANY): EIFFEL_LIST [ELSIF_AS] is
		require
			valid_type: yyis_type62 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type62 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ELSIF_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype63 (v: ANY): EIFFEL_LIST [EXPORT_ITEM_AS] is
		require
			valid_type: yyis_type63 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type63 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype64 (v: ANY): EIFFEL_LIST [EXPR_AS] is
		require
			valid_type: yyis_type64 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type64 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXPR_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype65 (v: ANY): EIFFEL_LIST [FEATURE_AS] is
		require
			valid_type: yyis_type65 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type65 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype66 (v: ANY): EIFFEL_LIST [FEATURE_CLAUSE_AS] is
		require
			valid_type: yyis_type66 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type66 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype67 (v: ANY): FEATURE_NAME is
		require
			valid_type: yyis_type67 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type67 (v: ANY): BOOLEAN is
		local
			u: FEATURE_NAME
		do
			u ?= v
			Result := (u = v)
		end

	yytype68 (v: ANY): EIFFEL_LIST [FEATURE_NAME] is
		require
			valid_type: yyis_type68 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type68 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_NAME]
		do
			u ?= v
			Result := (u = v)
		end

	yytype69 (v: ANY): EIFFEL_LIST [FORMAL_DEC_AS] is
		require
			valid_type: yyis_type69 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type69 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FORMAL_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype70 (v: ANY): EIFFEL_LIST [ID_AS] is
		require
			valid_type: yyis_type70 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type70 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ID_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype71 (v: ANY): EIFFEL_LIST [INDEX_AS] is
		require
			valid_type: yyis_type71 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type71 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INDEX_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype72 (v: ANY): EIFFEL_LIST [INSTRUCTION_AS] is
		require
			valid_type: yyis_type72 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type72 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INSTRUCTION_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype73 (v: ANY): EIFFEL_LIST [INTERVAL_AS] is
		require
			valid_type: yyis_type73 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type73 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INTERVAL_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype74 (v: ANY): EIFFEL_LIST [PARENT_AS] is
		require
			valid_type: yyis_type74 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type74 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [PARENT_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype75 (v: ANY): EIFFEL_LIST [RENAME_AS] is
		require
			valid_type: yyis_type75 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type75 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [RENAME_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype76 (v: ANY): EIFFEL_LIST [STRING_AS] is
		require
			valid_type: yyis_type76 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type76 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [STRING_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype77 (v: ANY): EIFFEL_LIST [TAGGED_AS] is
		require
			valid_type: yyis_type77 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type77 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TAGGED_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype78 (v: ANY): EIFFEL_LIST [TYPE] is
		require
			valid_type: yyis_type78 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type78 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE]
		do
			u ?= v
			Result := (u = v)
		end

	yytype79 (v: ANY): EIFFEL_LIST [TYPE_DEC_AS] is
		require
			valid_type: yyis_type79 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type79 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype80 (v: ANY): CLICK_AST is
		require
			valid_type: yyis_type80 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type80 (v: ANY): BOOLEAN is
		local
			u: CLICK_AST
		do
			u ?= v
			Result := (u = v)
		end

	yytype81 (v: ANY): PAIR [ID_AS, CLICK_AST] is
		require
			valid_type: yyis_type81 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type81 (v: ANY): BOOLEAN is
		local
			u: PAIR [ID_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype82 (v: ANY): PAIR [FEATURE_NAME, CLICK_AST] is
		require
			valid_type: yyis_type82 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type82 (v: ANY): BOOLEAN is
		local
			u: PAIR [FEATURE_NAME, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype83 (v: ANY): PAIR [STRING_AS, CLICK_AST] is
		require
			valid_type: yyis_type83 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type83 (v: ANY): BOOLEAN is
		local
			u: PAIR [STRING_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype84 (v: ANY): PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST] is
		require
			valid_type: yyis_type84 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type84 (v: ANY): BOOLEAN is
		local
			u: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 683
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 114
			-- Number of tokens

	yyLast: INTEGER is 1846
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 368
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 296
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



feature {NONE} -- Local variables

	id_as: ID_AS
	clickable: CLICK_AST
	clickable_as: CLICKABLE_AST
	class_type_as: CLASS_TYPE_AS
	feature_name: FEATURE_NAME
	feature_name_list: EIFFEL_LIST [FEATURE_NAME]

access_as: ACCESS_AS
value_as: VALUE_AS
unique_as: UNIQUE_AS
client_as: CLIENT_AS

f: PLAIN_TEXT_FILE

	Initial_assertion_list_size: INTEGER is 8
	Initial_choices_size: INTEGER is 2
	Initial_class_list_size: INTEGER is 4
	Initial_compound_size: INTEGER is 25
	Initial_creation_clause_list_size: INTEGER is 2
	Initial_debug_key_list_size: INTEGER is 2
	Initial_elseif_list_size: INTEGER is 5
	Initial_entity_declaration_list_size: INTEGER is 10
	Initial_expression_list_size: INTEGER is 8
	Initial_feature_clause_list_size: INTEGER is 10
	Initial_feature_declaration_list_size: INTEGER is 20
	Initial_feature_list_size: INTEGER is 11
	Initial_formal_generic_list_size: INTEGER is 4
	Initial_identifier_list_size: INTEGER is 6
	Initial_index_list_size: INTEGER is 10
	Initial_index_terms_size: INTEGER is 5
	Initial_new_export_list_size: INTEGER is 3
	Initial_new_feature_list_size: INTEGER is 4
	Initial_parameter_list_size: INTEGER is 9
	Initial_parent_list_size: INTEGER is 10
	Initial_rename_list_size: INTEGER is 10
	Initial_type_list_size: INTEGER is 4
	Initial_when_part_list_size: INTEGER is 3
			-- Initial capacity for lists

end -- class EIFFEL_PARSER


--|----------------------------------------------------------------
--| Copyright (C) 1992-1999, Interactive Software Engineering Inc.
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
