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
--|#line 164
	yy_do_action_1
when 2 then
--|#line 184
	yy_do_action_2
when 3 then
--|#line 186
	yy_do_action_3
when 4 then
--|#line 188
	yy_do_action_4
when 5 then
--|#line 190
	yy_do_action_5
when 6 then
--|#line 192
	yy_do_action_6
when 7 then
--|#line 194
	yy_do_action_7
when 8 then
--|#line 196
	yy_do_action_8
when 9 then
--|#line 198
	yy_do_action_9
when 10 then
--|#line 202
	yy_do_action_10
when 11 then
--|#line 208
	yy_do_action_11
when 12 then
--|#line 214
	yy_do_action_12
when 13 then
--|#line 220
	yy_do_action_13
when 14 then
--|#line 226
	yy_do_action_14
when 15 then
--|#line 232
	yy_do_action_15
when 16 then
--|#line 238
	yy_do_action_16
when 17 then
--|#line 244
	yy_do_action_17
when 18 then
--|#line 254
	yy_do_action_18
when 19 then
--|#line 258
	yy_do_action_19
when 20 then
--|#line 262
	yy_do_action_20
when 21 then
--|#line 268
	yy_do_action_21
when 22 then
--|#line 273
	yy_do_action_22
when 23 then
--|#line 280
	yy_do_action_23
when 24 then
--|#line 286
	yy_do_action_24
when 25 then
--|#line 288
	yy_do_action_25
when 26 then
--|#line 294
	yy_do_action_26
when 27 then
--|#line 299
	yy_do_action_27
when 28 then
--|#line 304
	yy_do_action_28
when 29 then
--|#line 311
	yy_do_action_29
when 30 then
--|#line 313
	yy_do_action_30
when 31 then
--|#line 321
	yy_do_action_31
when 32 then
--|#line 327
	yy_do_action_32
when 33 then
--|#line 333
	yy_do_action_33
when 34 then
--|#line 339
	yy_do_action_34
when 35 then
--|#line 351
	yy_do_action_35
when 36 then
--|#line 355
	yy_do_action_36
when 37 then
--|#line 365
	yy_do_action_37
when 38 then
--|#line 369
	yy_do_action_38
when 39 then
--|#line 378
	yy_do_action_39
when 40 then
--|#line 383
	yy_do_action_40
when 41 then
--|#line 390
	yy_do_action_41
when 42 then
--|#line 394
	yy_do_action_42
when 43 then
--|#line 400
	yy_do_action_43
when 44 then
--|#line 400
	yy_do_action_44
when 45 then
--|#line 411
	yy_do_action_45
when 46 then
--|#line 415
	yy_do_action_46
when 47 then
--|#line 421
	yy_do_action_47
when 48 then
--|#line 426
	yy_do_action_48
when 49 then
--|#line 432
	yy_do_action_49
when 50 then
--|#line 437
	yy_do_action_50
when 51 then
--|#line 444
	yy_do_action_51
when 52 then
--|#line 449
	yy_do_action_52
when 55 then
--|#line 460
	yy_do_action_55
when 56 then
--|#line 466
	yy_do_action_56
when 57 then
--|#line 470
	yy_do_action_57
when 58 then
--|#line 477
	yy_do_action_58
when 59 then
--|#line 483
	yy_do_action_59
when 60 then
--|#line 487
	yy_do_action_60
when 61 then
--|#line 493
	yy_do_action_61
when 62 then
--|#line 497
	yy_do_action_62
when 63 then
--|#line 499
	yy_do_action_63
when 64 then
--|#line 503
	yy_do_action_64
when 65 then
--|#line 510
	yy_do_action_65
when 66 then
--|#line 516
	yy_do_action_66
when 67 then
--|#line 522
	yy_do_action_67
when 68 then
--|#line 526
	yy_do_action_68
when 69 then
--|#line 532
	yy_do_action_69
when 70 then
--|#line 536
	yy_do_action_70
when 71 then
--|#line 540
	yy_do_action_71
when 72 then
--|#line 548
	yy_do_action_72
when 73 then
--|#line 552
	yy_do_action_73
when 74 then
--|#line 556
	yy_do_action_74
when 75 then
--|#line 562
	yy_do_action_75
when 76 then
--|#line 567
	yy_do_action_76
when 77 then
--|#line 574
	yy_do_action_77
when 78 then
--|#line 576
	yy_do_action_78
when 79 then
--|#line 583
	yy_do_action_79
when 80 then
--|#line 588
	yy_do_action_80
when 81 then
--|#line 593
	yy_do_action_81
when 82 then
--|#line 598
	yy_do_action_82
when 83 then
--|#line 603
	yy_do_action_83
when 84 then
--|#line 608
	yy_do_action_84
when 85 then
--|#line 613
	yy_do_action_85
when 86 then
--|#line 620
	yy_do_action_86
when 87 then
--|#line 624
	yy_do_action_87
when 88 then
--|#line 630
	yy_do_action_88
when 89 then
--|#line 635
	yy_do_action_89
when 90 then
--|#line 642
	yy_do_action_90
when 91 then
--|#line 648
	yy_do_action_91
when 92 then
--|#line 652
	yy_do_action_92
when 93 then
--|#line 656
	yy_do_action_93
when 94 then
--|#line 660
	yy_do_action_94
when 95 then
--|#line 666
	yy_do_action_95
when 96 then
--|#line 671
	yy_do_action_96
when 97 then
--|#line 678
	yy_do_action_97
when 98 then
--|#line 684
	yy_do_action_98
when 99 then
--|#line 688
	yy_do_action_99
when 100 then
--|#line 694
	yy_do_action_100
when 101 then
--|#line 699
	yy_do_action_101
when 102 then
--|#line 706
	yy_do_action_102
when 103 then
--|#line 710
	yy_do_action_103
when 104 then
--|#line 714
	yy_do_action_104
when 105 then
--|#line 718
	yy_do_action_105
when 106 then
--|#line 724
	yy_do_action_106
when 107 then
--|#line 728
	yy_do_action_107
when 108 then
--|#line 732
	yy_do_action_108
when 109 then
--|#line 736
	yy_do_action_109
when 110 then
--|#line 742
	yy_do_action_110
when 111 then
--|#line 746
	yy_do_action_111
when 112 then
--|#line 750
	yy_do_action_112
when 113 then
--|#line 754
	yy_do_action_113
when 114 then
--|#line 764
	yy_do_action_114
when 115 then
--|#line 768
	yy_do_action_115
when 116 then
--|#line 774
	yy_do_action_116
when 117 then
--|#line 778
	yy_do_action_117
when 118 then
--|#line 782
	yy_do_action_118
when 119 then
--|#line 787
	yy_do_action_119
when 120 then
--|#line 794
	yy_do_action_120
when 121 then
--|#line 800
	yy_do_action_121
when 122 then
--|#line 805
	yy_do_action_122
when 123 then
--|#line 812
	yy_do_action_123
when 124 then
--|#line 816
	yy_do_action_124
when 125 then
--|#line 820
	yy_do_action_125
when 126 then
--|#line 824
	yy_do_action_126
when 127 then
--|#line 830
	yy_do_action_127
when 128 then
--|#line 830
	yy_do_action_128
when 129 then
--|#line 841
	yy_do_action_129
when 130 then
--|#line 843
	yy_do_action_130
when 131 then
--|#line 845
	yy_do_action_131
when 132 then
--|#line 851
	yy_do_action_132
when 133 then
--|#line 857
	yy_do_action_133
when 134 then
--|#line 857
	yy_do_action_134
when 135 then
--|#line 867
	yy_do_action_135
when 136 then
--|#line 871
	yy_do_action_136
when 137 then
--|#line 877
	yy_do_action_137
when 138 then
--|#line 881
	yy_do_action_138
when 139 then
--|#line 887
	yy_do_action_139
when 140 then
--|#line 891
	yy_do_action_140
when 141 then
--|#line 897
	yy_do_action_141
when 142 then
--|#line 901
	yy_do_action_142
when 143 then
--|#line 907
	yy_do_action_143
when 144 then
--|#line 912
	yy_do_action_144
when 145 then
--|#line 919
	yy_do_action_145
when 148 then
--|#line 929
	yy_do_action_148
when 149 then
--|#line 931
	yy_do_action_149
when 150 then
--|#line 933
	yy_do_action_150
when 151 then
--|#line 935
	yy_do_action_151
when 152 then
--|#line 937
	yy_do_action_152
when 153 then
--|#line 939
	yy_do_action_153
when 154 then
--|#line 941
	yy_do_action_154
when 155 then
--|#line 943
	yy_do_action_155
when 156 then
--|#line 945
	yy_do_action_156
when 157 then
--|#line 947
	yy_do_action_157
when 158 then
--|#line 951
	yy_do_action_158
when 159 then
--|#line 955
	yy_do_action_159
when 160 then
--|#line 955
	yy_do_action_160
when 161 then
--|#line 964
	yy_do_action_161
when 162 then
--|#line 964
	yy_do_action_162
when 163 then
--|#line 975
	yy_do_action_163
when 164 then
--|#line 979
	yy_do_action_164
when 165 then
--|#line 979
	yy_do_action_165
when 166 then
--|#line 988
	yy_do_action_166
when 167 then
--|#line 988
	yy_do_action_167
when 168 then
--|#line 999
	yy_do_action_168
when 169 then
--|#line 1003
	yy_do_action_169
when 170 then
--|#line 1012
	yy_do_action_170
when 171 then
--|#line 1017
	yy_do_action_171
when 172 then
--|#line 1024
	yy_do_action_172
when 173 then
--|#line 1030
	yy_do_action_173
when 174 then
--|#line 1034
	yy_do_action_174
when 175 then
--|#line 1038
	yy_do_action_175
when 176 then
--|#line 1048
	yy_do_action_176
when 177 then
--|#line 1050
	yy_do_action_177
when 178 then
--|#line 1054
	yy_do_action_178
when 179 then
--|#line 1058
	yy_do_action_179
when 180 then
--|#line 1062
	yy_do_action_180
when 181 then
--|#line 1066
	yy_do_action_181
when 182 then
--|#line 1070
	yy_do_action_182
when 183 then
--|#line 1074
	yy_do_action_183
when 184 then
--|#line 1080
	yy_do_action_184
when 185 then
--|#line 1084
	yy_do_action_185
when 186 then
--|#line 1088
	yy_do_action_186
when 187 then
--|#line 1092
	yy_do_action_187
when 188 then
--|#line 1096
	yy_do_action_188
when 189 then
--|#line 1100
	yy_do_action_189
when 190 then
--|#line 1104
	yy_do_action_190
when 191 then
--|#line 1108
	yy_do_action_191
when 192 then
--|#line 1114
	yy_do_action_192
when 193 then
--|#line 1118
	yy_do_action_193
when 194 then
--|#line 1122
	yy_do_action_194
when 195 then
--|#line 1128
	yy_do_action_195
when 196 then
--|#line 1133
	yy_do_action_196
when 197 then
--|#line 1144
	yy_do_action_197
when 198 then
--|#line 1148
	yy_do_action_198
when 199 then
--|#line 1154
	yy_do_action_199
when 200 then
--|#line 1158
	yy_do_action_200
when 201 then
--|#line 1162
	yy_do_action_201
when 202 then
--|#line 1167
	yy_do_action_202
when 203 then
--|#line 1174
	yy_do_action_203
when 204 then
--|#line 1174
	yy_do_action_204
when 205 then
--|#line 1186
	yy_do_action_205
when 206 then
--|#line 1190
	yy_do_action_206
when 207 then
--|#line 1196
	yy_do_action_207
when 208 then
--|#line 1200
	yy_do_action_208
when 209 then
--|#line 1210
	yy_do_action_209
when 210 then
--|#line 1217
	yy_do_action_210
when 211 then
--|#line 1221
	yy_do_action_211
when 212 then
--|#line 1225
	yy_do_action_212
when 213 then
--|#line 1230
	yy_do_action_213
when 214 then
--|#line 1237
	yy_do_action_214
when 215 then
--|#line 1243
	yy_do_action_215
when 216 then
--|#line 1247
	yy_do_action_216
when 217 then
--|#line 1253
	yy_do_action_217
when 218 then
--|#line 1260
	yy_do_action_218
when 219 then
--|#line 1264
	yy_do_action_219
when 220 then
--|#line 1268
	yy_do_action_220
when 221 then
--|#line 1273
	yy_do_action_221
when 222 then
--|#line 1280
	yy_do_action_222
when 223 then
--|#line 1286
	yy_do_action_223
when 224 then
--|#line 1291
	yy_do_action_224
when 225 then
--|#line 1298
	yy_do_action_225
when 226 then
--|#line 1302
	yy_do_action_226
when 227 then
--|#line 1306
	yy_do_action_227
when 228 then
--|#line 1310
	yy_do_action_228
when 229 then
--|#line 1314
	yy_do_action_229
when 230 then
--|#line 1318
	yy_do_action_230
when 231 then
--|#line 1322
	yy_do_action_231
when 232 then
--|#line 1326
	yy_do_action_232
when 233 then
--|#line 1330
	yy_do_action_233
when 234 then
--|#line 1334
	yy_do_action_234
when 235 then
--|#line 1340
	yy_do_action_235
when 236 then
--|#line 1344
	yy_do_action_236
when 237 then
--|#line 1353
	yy_do_action_237
when 238 then
--|#line 1360
	yy_do_action_238
when 239 then
--|#line 1364
	yy_do_action_239
when 240 then
--|#line 1370
	yy_do_action_240
when 241 then
--|#line 1374
	yy_do_action_241
when 242 then
--|#line 1374
	yy_do_action_242
when 243 then
--|#line 1386
	yy_do_action_243
when 244 then
--|#line 1390
	yy_do_action_244
when 245 then
--|#line 1394
	yy_do_action_245
when 246 then
--|#line 1400
	yy_do_action_246
when 247 then
--|#line 1407
	yy_do_action_247
when 248 then
--|#line 1411
	yy_do_action_248
when 249 then
--|#line 1415
	yy_do_action_249
when 250 then
--|#line 1421
	yy_do_action_250
when 251 then
--|#line 1426
	yy_do_action_251
when 252 then
--|#line 1433
	yy_do_action_252
when 253 then
--|#line 1439
	yy_do_action_253
when 254 then
--|#line 1443
	yy_do_action_254
when 255 then
--|#line 1452
	yy_do_action_255
when 256 then
--|#line 1456
	yy_do_action_256
when 257 then
--|#line 1462
	yy_do_action_257
when 258 then
--|#line 1466
	yy_do_action_258
when 259 then
--|#line 1472
	yy_do_action_259
when 260 then
--|#line 1476
	yy_do_action_260
when 261 then
--|#line 1480
	yy_do_action_261
when 262 then
--|#line 1485
	yy_do_action_262
when 263 then
--|#line 1492
	yy_do_action_263
when 264 then
--|#line 1497
	yy_do_action_264
when 265 then
--|#line 1502
	yy_do_action_265
when 266 then
--|#line 1509
	yy_do_action_266
when 267 then
--|#line 1515
	yy_do_action_267
when 268 then
--|#line 1519
	yy_do_action_268
when 269 then
--|#line 1523
	yy_do_action_269
when 270 then
--|#line 1527
	yy_do_action_270
when 271 then
--|#line 1531
	yy_do_action_271
when 272 then
--|#line 1537
	yy_do_action_272
when 273 then
--|#line 1541
	yy_do_action_273
when 274 then
--|#line 1547
	yy_do_action_274
when 275 then
--|#line 1552
	yy_do_action_275
when 276 then
--|#line 1559
	yy_do_action_276
when 277 then
--|#line 1563
	yy_do_action_277
when 278 then
--|#line 1567
	yy_do_action_278
when 279 then
--|#line 1571
	yy_do_action_279
when 280 then
--|#line 1575
	yy_do_action_280
when 281 then
--|#line 1579
	yy_do_action_281
when 282 then
--|#line 1583
	yy_do_action_282
when 283 then
--|#line 1587
	yy_do_action_283
when 284 then
--|#line 1591
	yy_do_action_284
when 285 then
--|#line 1595
	yy_do_action_285
when 286 then
--|#line 1599
	yy_do_action_286
when 287 then
--|#line 1605
	yy_do_action_287
when 288 then
--|#line 1609
	yy_do_action_288
when 289 then
--|#line 1613
	yy_do_action_289
when 290 then
--|#line 1619
	yy_do_action_290
when 291 then
--|#line 1623
	yy_do_action_291
when 292 then
--|#line 1629
	yy_do_action_292
when 293 then
--|#line 1633
	yy_do_action_293
when 294 then
--|#line 1637
	yy_do_action_294
when 295 then
--|#line 1641
	yy_do_action_295
when 296 then
--|#line 1647
	yy_do_action_296
when 297 then
--|#line 1651
	yy_do_action_297
when 298 then
--|#line 1661
	yy_do_action_298
when 299 then
--|#line 1665
	yy_do_action_299
when 300 then
--|#line 1669
	yy_do_action_300
when 301 then
--|#line 1673
	yy_do_action_301
when 302 then
--|#line 1677
	yy_do_action_302
when 303 then
--|#line 1681
	yy_do_action_303
when 304 then
--|#line 1685
	yy_do_action_304
when 305 then
--|#line 1691
	yy_do_action_305
when 306 then
--|#line 1702
	yy_do_action_306
when 307 then
--|#line 1706
	yy_do_action_307
when 308 then
--|#line 1710
	yy_do_action_308
when 309 then
--|#line 1714
	yy_do_action_309
when 310 then
--|#line 1718
	yy_do_action_310
when 311 then
--|#line 1720
	yy_do_action_311
when 312 then
--|#line 1724
	yy_do_action_312
when 313 then
--|#line 1728
	yy_do_action_313
when 314 then
--|#line 1732
	yy_do_action_314
when 315 then
--|#line 1736
	yy_do_action_315
when 316 then
--|#line 1740
	yy_do_action_316
when 317 then
--|#line 1744
	yy_do_action_317
when 318 then
--|#line 1748
	yy_do_action_318
when 319 then
--|#line 1752
	yy_do_action_319
when 320 then
--|#line 1756
	yy_do_action_320
when 321 then
--|#line 1760
	yy_do_action_321
when 322 then
--|#line 1764
	yy_do_action_322
when 323 then
--|#line 1768
	yy_do_action_323
when 324 then
--|#line 1772
	yy_do_action_324
when 325 then
--|#line 1776
	yy_do_action_325
when 326 then
--|#line 1780
	yy_do_action_326
when 327 then
--|#line 1784
	yy_do_action_327
when 328 then
--|#line 1788
	yy_do_action_328
when 329 then
--|#line 1792
	yy_do_action_329
when 330 then
--|#line 1796
	yy_do_action_330
when 331 then
--|#line 1800
	yy_do_action_331
when 332 then
--|#line 1804
	yy_do_action_332
when 333 then
--|#line 1808
	yy_do_action_333
when 334 then
--|#line 1812
	yy_do_action_334
when 335 then
--|#line 1816
	yy_do_action_335
when 336 then
--|#line 1820
	yy_do_action_336
when 337 then
--|#line 1824
	yy_do_action_337
when 338 then
--|#line 1830
	yy_do_action_338
when 339 then
--|#line 1832
	yy_do_action_339
when 340 then
--|#line 1836
	yy_do_action_340
when 341 then
--|#line 1840
	yy_do_action_341
when 342 then
--|#line 1844
	yy_do_action_342
when 343 then
--|#line 1850
	yy_do_action_343
when 344 then
--|#line 1860
	yy_do_action_344
when 345 then
--|#line 1862
	yy_do_action_345
when 346 then
--|#line 1864
	yy_do_action_346
when 347 then
--|#line 1866
	yy_do_action_347
when 348 then
--|#line 1870
	yy_do_action_348
when 349 then
--|#line 1874
	yy_do_action_349
when 350 then
--|#line 1876
	yy_do_action_350
when 351 then
--|#line 1878
	yy_do_action_351
when 352 then
--|#line 1880
	yy_do_action_352
when 353 then
--|#line 1882
	yy_do_action_353
when 354 then
--|#line 1886
	yy_do_action_354
when 355 then
--|#line 1892
	yy_do_action_355
when 356 then
--|#line 1898
	yy_do_action_356
when 357 then
--|#line 1904
	yy_do_action_357
when 358 then
--|#line 1910
	yy_do_action_358
when 359 then
--|#line 1916
	yy_do_action_359
when 360 then
--|#line 1920
	yy_do_action_360
when 361 then
--|#line 1924
	yy_do_action_361
when 362 then
--|#line 1928
	yy_do_action_362
when 363 then
--|#line 1932
	yy_do_action_363
when 364 then
--|#line 1936
	yy_do_action_364
when 365 then
--|#line 1940
	yy_do_action_365
when 366 then
--|#line 1944
	yy_do_action_366
when 367 then
--|#line 1948
	yy_do_action_367
when 368 then
--|#line 1952
	yy_do_action_368
when 369 then
--|#line 1956
	yy_do_action_369
when 370 then
--|#line 1962
	yy_do_action_370
when 371 then
--|#line 1964
	yy_do_action_371
when 372 then
--|#line 1968
	yy_do_action_372
when 373 then
--|#line 1972
	yy_do_action_373
when 374 then
--|#line 1978
	yy_do_action_374
when 375 then
--|#line 1991
	yy_do_action_375
when 376 then
--|#line 1997
	yy_do_action_376
when 377 then
--|#line 2001
	yy_do_action_377
when 378 then
--|#line 2005
	yy_do_action_378
when 379 then
--|#line 2011
	yy_do_action_379
when 380 then
--|#line 2016
	yy_do_action_380
when 381 then
--|#line 2023
	yy_do_action_381
when 382 then
--|#line 2027
	yy_do_action_382
when 383 then
--|#line 2031
	yy_do_action_383
when 384 then
--|#line 2036
	yy_do_action_384
when 385 then
--|#line 2047
	yy_do_action_385
when 386 then
--|#line 2051
	yy_do_action_386
when 387 then
--|#line 2055
	yy_do_action_387
when 388 then
--|#line 2059
	yy_do_action_388
when 389 then
--|#line 2063
	yy_do_action_389
when 390 then
--|#line 2067
	yy_do_action_390
when 391 then
--|#line 2071
	yy_do_action_391
when 392 then
--|#line 2075
	yy_do_action_392
when 393 then
--|#line 2081
	yy_do_action_393
when 394 then
--|#line 2083
	yy_do_action_394
when 395 then
--|#line 2085
	yy_do_action_395
when 396 then
--|#line 2087
	yy_do_action_396
when 397 then
--|#line 2089
	yy_do_action_397
when 398 then
--|#line 2091
	yy_do_action_398
when 399 then
--|#line 2095
	yy_do_action_399
when 400 then
--|#line 2097
	yy_do_action_400
when 401 then
--|#line 2099
	yy_do_action_401
when 402 then
--|#line 2109
	yy_do_action_402
when 403 then
--|#line 2113
	yy_do_action_403
when 404 then
--|#line 2115
	yy_do_action_404
when 405 then
--|#line 2119
	yy_do_action_405
when 406 then
--|#line 2123
	yy_do_action_406
when 407 then
--|#line 2129
	yy_do_action_407
when 408 then
--|#line 2136
	yy_do_action_408
when 409 then
--|#line 2146
	yy_do_action_409
when 410 then
--|#line 2156
	yy_do_action_410
when 411 then
--|#line 2169
	yy_do_action_411
when 412 then
--|#line 2173
	yy_do_action_412
when 413 then
--|#line 2177
	yy_do_action_413
when 414 then
--|#line 2184
	yy_do_action_414
when 415 then
--|#line 2190
	yy_do_action_415
when 416 then
--|#line 2194
	yy_do_action_416
when 417 then
--|#line 2200
	yy_do_action_417
when 418 then
--|#line 2204
	yy_do_action_418
when 419 then
--|#line 2208
	yy_do_action_419
when 420 then
--|#line 2212
	yy_do_action_420
when 421 then
--|#line 2216
	yy_do_action_421
when 422 then
--|#line 2220
	yy_do_action_422
when 423 then
--|#line 2224
	yy_do_action_423
when 424 then
--|#line 2228
	yy_do_action_424
when 425 then
--|#line 2232
	yy_do_action_425
when 426 then
--|#line 2236
	yy_do_action_426
when 427 then
--|#line 2240
	yy_do_action_427
when 428 then
--|#line 2244
	yy_do_action_428
when 429 then
--|#line 2248
	yy_do_action_429
when 430 then
--|#line 2252
	yy_do_action_430
when 431 then
--|#line 2256
	yy_do_action_431
when 432 then
--|#line 2260
	yy_do_action_432
when 433 then
--|#line 2264
	yy_do_action_433
when 434 then
--|#line 2268
	yy_do_action_434
when 435 then
--|#line 2272
	yy_do_action_435
when 436 then
--|#line 2276
	yy_do_action_436
when 437 then
--|#line 2282
	yy_do_action_437
when 438 then
--|#line 2286
	yy_do_action_438
when 439 then
--|#line 2290
	yy_do_action_439
when 440 then
--|#line 2294
	yy_do_action_440
when 441 then
--|#line 2300
	yy_do_action_441
when 442 then
--|#line 2304
	yy_do_action_442
when 443 then
--|#line 2308
	yy_do_action_443
when 444 then
--|#line 2312
	yy_do_action_444
when 445 then
--|#line 2316
	yy_do_action_445
when 446 then
--|#line 2320
	yy_do_action_446
when 447 then
--|#line 2324
	yy_do_action_447
when 448 then
--|#line 2328
	yy_do_action_448
when 449 then
--|#line 2332
	yy_do_action_449
when 450 then
--|#line 2336
	yy_do_action_450
when 451 then
--|#line 2340
	yy_do_action_451
when 452 then
--|#line 2344
	yy_do_action_452
when 453 then
--|#line 2348
	yy_do_action_453
when 454 then
--|#line 2352
	yy_do_action_454
when 455 then
--|#line 2356
	yy_do_action_455
when 456 then
--|#line 2360
	yy_do_action_456
when 457 then
--|#line 2364
	yy_do_action_457
when 458 then
--|#line 2368
	yy_do_action_458
when 459 then
--|#line 2374
	yy_do_action_459
when 460 then
--|#line 2380
	yy_do_action_460
when 461 then
--|#line 2386
	yy_do_action_461
when 462 then
--|#line 2392
	yy_do_action_462
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 164
		local

		do
			yyval := yyval_default;
				root_node := new_class_description (yytype83 (yyvs.item (yyvsp - 7)),
					is_deferred, is_expanded, is_separate,
					yytype72 (yyvs.item (yyvsp - 10)), yytype70 (yyvs.item (yyvsp - 6)), yytype76 (yyvs.item (yyvsp - 4)), yytype62 (yyvs.item (yyvsp - 3)), yytype67 (yyvs.item (yyvsp - 2)), yytype39 (yyvs.item (yyvsp - 1)), suppliers, yytype54 (yyvs.item (yyvsp - 5)), click_list,
					current_position.start_position)
			

		end

	yy_do_action_2 is
			--|#line 184
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_3 is
			--|#line 186
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_4 is
			--|#line 188
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_5 is
			--|#line 190
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_6 is
			--|#line 192
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_7 is
			--|#line 194
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_8 is
			--|#line 196
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_9 is
			--|#line 198
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_10 is
			--|#line 202
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

				yyval83 := new_clickable_id (new_id_as (token_buffer))
			
			yyval := yyval83
		end

	yy_do_action_11 is
			--|#line 208
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

				yyval83 := new_clickable_id (new_boolean_id_as)
			
			yyval := yyval83
		end

	yy_do_action_12 is
			--|#line 214
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

				yyval83 := new_clickable_id (new_character_id_as)
			
			yyval := yyval83
		end

	yy_do_action_13 is
			--|#line 220
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

				yyval83 := new_clickable_id (new_double_id_as)
			
			yyval := yyval83
		end

	yy_do_action_14 is
			--|#line 226
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

				yyval83 := new_clickable_id (new_integer_id_as)
			
			yyval := yyval83
		end

	yy_do_action_15 is
			--|#line 232
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

				yyval83 := new_clickable_id (new_none_id_as)
			
			yyval := yyval83
		end

	yy_do_action_16 is
			--|#line 238
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

				yyval83 := new_clickable_id (new_pointer_id_as)
			
			yyval := yyval83
		end

	yy_do_action_17 is
			--|#line 244
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

				yyval83 := new_clickable_id (new_real_id_as)
			
			yyval := yyval83
		end

	yy_do_action_18 is
			--|#line 254
		local
			yyval72: EIFFEL_LIST [INDEX_AS]
		do

				-- $$ := Void
			
			yyval := yyval72
		end

	yy_do_action_19 is
			--|#line 258
		local
			yyval72: EIFFEL_LIST [INDEX_AS]
		do

				yyval72 := yytype72 (yyvs.item (yyvsp))
			
			yyval := yyval72
		end

	yy_do_action_20 is
			--|#line 262
		local
			yyval72: EIFFEL_LIST [INDEX_AS]
		do

				-- $$ := Void
			
			yyval := yyval72
		end

	yy_do_action_21 is
			--|#line 268
		local
			yyval72: EIFFEL_LIST [INDEX_AS]
		do

				yyval72 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval72.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval72
		end

	yy_do_action_22 is
			--|#line 273
		local
			yyval72: EIFFEL_LIST [INDEX_AS]
		do

				yyval72 := yytype72 (yyvs.item (yyvsp - 1))
				yyval72.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval72
		end

	yy_do_action_23 is
			--|#line 280
		local
			yyval32: INDEX_AS
		do

				yyval32 := new_index_as (yytype30 (yyvs.item (yyvsp - 2)), yytype60 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval32
		end

	yy_do_action_24 is
			--|#line 286
		local
			yyval30: ID_AS
		do

yyval30 := yytype30 (yyvs.item (yyvsp - 1)) 
			yyval := yyval30
		end

	yy_do_action_25 is
			--|#line 288
		local
			yyval30: ID_AS
		do

				-- $$ := Void
			
			yyval := yyval30
		end

	yy_do_action_26 is
			--|#line 294
		local
			yyval60: EIFFEL_LIST [ATOMIC_AS]
		do

				yyval60 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval60.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval60
		end

	yy_do_action_27 is
			--|#line 299
		local
			yyval60: EIFFEL_LIST [ATOMIC_AS]
		do

				yyval60 := yytype60 (yyvs.item (yyvsp - 2))
				yyval60.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval60
		end

	yy_do_action_28 is
			--|#line 304
		local
			yyval60: EIFFEL_LIST [ATOMIC_AS]
		do

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval60 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval60
		end

	yy_do_action_29 is
			--|#line 311
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype30 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_30 is
			--|#line 313
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_31 is
			--|#line 321
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_32 is
			--|#line 327
		local

		do
			yyval := yyval_default;
				is_deferred := True
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_33 is
			--|#line 333
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := True
				is_separate := False
			

		end

	yy_do_action_34 is
			--|#line 339
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := True
			

		end

	yy_do_action_35 is
			--|#line 351
		local
			yyval54: STRING_AS
		do

				-- $$ := Void
			
			yyval := yyval54
		end

	yy_do_action_36 is
			--|#line 355
		local
			yyval54: STRING_AS
		do

				yyval54 := yytype54 (yyvs.item (yyvsp))
			
			yyval := yyval54
		end

	yy_do_action_37 is
			--|#line 365
		local
			yyval67: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				-- $$ := Void
			
			yyval := yyval67
		end

	yy_do_action_38 is
			--|#line 369
		local
			yyval67: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval67 := yytype67 (yyvs.item (yyvsp))
				if yyval67.empty then
					yyval67 := Void
				end
			
			yyval := yyval67
		end

	yy_do_action_39 is
			--|#line 378
		local
			yyval67: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval67 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval67, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_40 is
			--|#line 383
		local
			yyval67: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval67 := yytype67 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval67, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_41 is
			--|#line 390
		local
			yyval27: FEATURE_CLAUSE_AS
		do

				yyval27 := Void
			
			yyval := yyval27
		end

	yy_do_action_42 is
			--|#line 394
		local
			yyval27: FEATURE_CLAUSE_AS
		do

				yyval27 := new_feature_clause_as (yytype14 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp)), fclause_pos)
			
			yyval := yyval27
		end

	yy_do_action_43 is
			--|#line 400
		local
			yyval14: CLIENT_AS
		do

				yyval14 := yytype14 (yyvs.item (yyvsp))
			
			yyval := yyval14
		end

	yy_do_action_44 is
			--|#line 400
		local

		do
			yyval := yyval_default;
				inherit_context := False
				fclause_pos := current_position.end_position
			

		end

	yy_do_action_45 is
			--|#line 411
		local
			yyval14: CLIENT_AS
		do

				yyval14 := Void
			
			yyval := yyval14
		end

	yy_do_action_46 is
			--|#line 415
		local
			yyval14: CLIENT_AS
		do

				yyval14 := new_client_as (yytype71 (yyvs.item (yyvsp)))
			
			yyval := yyval14
		end

	yy_do_action_47 is
			--|#line 421
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := new_eiffel_list_id_as (1)
				yyval71.extend (new_none_id_as)
			
			yyval := yyval71
		end

	yy_do_action_48 is
			--|#line 426
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 1))
			
			yyval := yyval71
		end

	yy_do_action_49 is
			--|#line 432
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval71.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_50 is
			--|#line 437
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_51 is
			--|#line 444
		local
			yyval66: EIFFEL_LIST [FEATURE_AS]
		do

				yyval66 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval66.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_52 is
			--|#line 449
		local
			yyval66: EIFFEL_LIST [FEATURE_AS]
		do

				yyval66 := yytype66 (yyvs.item (yyvsp - 1))
				yyval66.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_55 is
			--|#line 460
		local
			yyval26: FEATURE_AS
		do

				yyval26 := new_feature_declaration (yytype86 (yyvs.item (yyvsp - 2)), yytype8 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval26
		end

	yy_do_action_56 is
			--|#line 466
		local
			yyval86: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

				yyval86 := new_clickable_feature_name_list (yytype84 (yyvs.item (yyvsp)), Initial_new_feature_list_size)
			
			yyval := yyval86
		end

	yy_do_action_57 is
			--|#line 470
		local
			yyval86: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

				yyval86 := yytype86 (yyvs.item (yyvsp - 2))
				yyval86.first.extend (yytype84 (yyvs.item (yyvsp)).first)
			
			yyval := yyval86
		end

	yy_do_action_58 is
			--|#line 477
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

				yyval84 := yytype84 (yyvs.item (yyvsp))
			
			yyval := yyval84
		end

	yy_do_action_59 is
			--|#line 483
		local

		do
			yyval := yyval_default;
				is_frozen := False
			

		end

	yy_do_action_60 is
			--|#line 487
		local

		do
			yyval := yyval_default;
				is_frozen := True
			

		end

	yy_do_action_61 is
			--|#line 493
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

				yyval84 := new_clickable_feature_name (yytype83 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_62 is
			--|#line 497
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_63 is
			--|#line 499
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_64 is
			--|#line 503
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

				yyval84 := new_clickable_infix (yytype85 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_65 is
			--|#line 510
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

				yyval84 := new_clickable_prefix (yytype85 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_66 is
			--|#line 516
		local
			yyval8: BODY_AS
		do

				yyval8 := new_declaration_body (yytype81 (yyvs.item (yyvsp - 2)), yytype57 (yyvs.item (yyvsp - 1)), yytype15 (yyvs.item (yyvsp)))
			
			yyval := yyval8
		end

	yy_do_action_67 is
			--|#line 522
		local
			yyval15: CONTENT_AS
		do

				-- $$ := Void
			
			yyval := yyval15
		end

	yy_do_action_68 is
			--|#line 526
		local
			yyval15: CONTENT_AS
		do

				yyval15 := yytype15 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_69 is
			--|#line 532
		local
			yyval15: CONTENT_AS
		do

				yyval15 := new_constant_as (new_value_as (yytype6 (yyvs.item (yyvsp))))
			
			yyval := yyval15
		end

	yy_do_action_70 is
			--|#line 536
		local
			yyval15: CONTENT_AS
		do

				yyval15 := new_constant_as (new_value_as (new_unique_as))
			
			yyval := yyval15
		end

	yy_do_action_71 is
			--|#line 540
		local
			yyval15: CONTENT_AS
		do

yyval15 := yytype52 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_72 is
			--|#line 548
		local
			yyval76: EIFFEL_LIST [PARENT_AS]
		do

				-- $$ := Void
			
			yyval := yyval76
		end

	yy_do_action_73 is
			--|#line 552
		local
			yyval76: EIFFEL_LIST [PARENT_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp))
			
			yyval := yyval76
		end

	yy_do_action_74 is
			--|#line 556
		local
			yyval76: EIFFEL_LIST [PARENT_AS]
		do

				-- $$ := Void
			
			yyval := yyval76
		end

	yy_do_action_75 is
			--|#line 562
		local
			yyval76: EIFFEL_LIST [PARENT_AS]
		do

				yyval76 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval76.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_76 is
			--|#line 567
		local
			yyval76: EIFFEL_LIST [PARENT_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp - 1))
				yyval76.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_77 is
			--|#line 574
		local
			yyval44: PARENT_AS
		do

yyval44 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval44
		end

	yy_do_action_78 is
			--|#line 576
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := yytype44 (yyvs.item (yyvsp - 1))
			
			yyval := yyval44
		end

	yy_do_action_79 is
			--|#line 583
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_80 is
			--|#line 588
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 7)), yytype80 (yyvs.item (yyvsp - 6)), yytype77 (yyvs.item (yyvsp - 5)), yytype64 (yyvs.item (yyvsp - 4)), yytype69 (yyvs.item (yyvsp - 3)), yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_81 is
			--|#line 593
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 6)), yytype80 (yyvs.item (yyvsp - 5)), Void, yytype64 (yyvs.item (yyvsp - 4)), yytype69 (yyvs.item (yyvsp - 3)), yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_82 is
			--|#line 598
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 5)), yytype80 (yyvs.item (yyvsp - 4)), Void, Void, yytype69 (yyvs.item (yyvsp - 3)), yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_83 is
			--|#line 603
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 4)), yytype80 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_84 is
			--|#line 608
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 3)), yytype80 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_85 is
			--|#line 613
		local
			yyval44: PARENT_AS
		do

				inherit_context := True
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 2)), yytype80 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_86 is
			--|#line 620
		local
			yyval77: EIFFEL_LIST [RENAME_AS]
		do

				-- $$ := Void
			
			yyval := yyval77
		end

	yy_do_action_87 is
			--|#line 624
		local
			yyval77: EIFFEL_LIST [RENAME_AS]
		do

				yyval77 := yytype77 (yyvs.item (yyvsp))
			
			yyval := yyval77
		end

	yy_do_action_88 is
			--|#line 630
		local
			yyval77: EIFFEL_LIST [RENAME_AS]
		do

				yyval77 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval77.extend (yytype47 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_89 is
			--|#line 635
		local
			yyval77: EIFFEL_LIST [RENAME_AS]
		do

				yyval77 := yytype77 (yyvs.item (yyvsp - 2))
				yyval77.extend (yytype47 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_90 is
			--|#line 642
		local
			yyval47: RENAME_AS
		do

				yyval47 := new_rename_pair (yytype84 (yyvs.item (yyvsp - 2)), yytype84 (yyvs.item (yyvsp)))
			
			yyval := yyval47
		end

	yy_do_action_91 is
			--|#line 648
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				-- $$  := Void
			
			yyval := yyval64
		end

	yy_do_action_92 is
			--|#line 652
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_93 is
			--|#line 656
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval64 := yytype64 (yyvs.item (yyvsp))
			
			yyval := yyval64
		end

	yy_do_action_94 is
			--|#line 660
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				-- $$ := Void
			
			yyval := yyval64
		end

	yy_do_action_95 is
			--|#line 666
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval64 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				yyval64.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_96 is
			--|#line 671
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval64 := yytype64 (yyvs.item (yyvsp - 1))
				yyval64.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_97 is
			--|#line 678
		local
			yyval22: EXPORT_ITEM_AS
		do

				yyval22 := new_export_item_as (new_client_as (yytype71 (yyvs.item (yyvsp - 2))), yytype28 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval22
		end

	yy_do_action_98 is
			--|#line 684
		local
			yyval28: FEATURE_SET_AS
		do

				yyval28 := new_all_as
			
			yyval := yyval28
		end

	yy_do_action_99 is
			--|#line 688
		local
			yyval28: FEATURE_SET_AS
		do

				yyval28 := new_feature_list_as (yytype69 (yyvs.item (yyvsp)))
			
			yyval := yyval28
		end

	yy_do_action_100 is
			--|#line 694
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval69 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval69.extend (yytype84 (yyvs.item (yyvsp)).first)
			
			yyval := yyval69
		end

	yy_do_action_101 is
			--|#line 699
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval69 := yytype69 (yyvs.item (yyvsp - 2))
				yyval69.extend (yytype84 (yyvs.item (yyvsp)).first)
			
			yyval := yyval69
		end

	yy_do_action_102 is
			--|#line 706
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				-- $$ := Void
			
			yyval := yyval69
		end

	yy_do_action_103 is
			--|#line 710
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_104 is
			--|#line 714
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				-- $$ := Void
			
			yyval := yyval69
		end

	yy_do_action_105 is
			--|#line 718
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval69 := yytype69 (yyvs.item (yyvsp))
			
			yyval := yyval69
		end

	yy_do_action_106 is
			--|#line 724
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				-- $$ := Void
			
			yyval := yyval69
		end

	yy_do_action_107 is
			--|#line 728
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_108 is
			--|#line 732
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				-- $$ := Void
			
			yyval := yyval69
		end

	yy_do_action_109 is
			--|#line 736
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval69 := yytype69 (yyvs.item (yyvsp))
			
			yyval := yyval69
		end

	yy_do_action_110 is
			--|#line 742
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				-- $$ := Void
			
			yyval := yyval69
		end

	yy_do_action_111 is
			--|#line 746
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_112 is
			--|#line 750
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				-- $$ := Void
			
			yyval := yyval69
		end

	yy_do_action_113 is
			--|#line 754
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval69 := yytype69 (yyvs.item (yyvsp))
			
			yyval := yyval69
		end

	yy_do_action_114 is
			--|#line 764
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

				-- $$ := Void
			
			yyval := yyval81
		end

	yy_do_action_115 is
			--|#line 768
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval81 := yytype81 (yyvs.item (yyvsp - 1))
			
			yyval := yyval81
		end

	yy_do_action_116 is
			--|#line 774
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

				-- $$ := Void
			
			yyval := yyval81
		end

	yy_do_action_117 is
			--|#line 778
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_118 is
			--|#line 782
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval81 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval81.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_119 is
			--|#line 787
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval81 := yytype81 (yyvs.item (yyvsp - 1))
				yyval81.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_120 is
			--|#line 794
		local
			yyval58: TYPE_DEC_AS
		do

				yyval58 := new_type_dec_as (yytype71 (yyvs.item (yyvsp - 3)), yytype57 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval58
		end

	yy_do_action_121 is
			--|#line 800
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := new_eiffel_list_id_as (Initial_identifier_list_size)
				yyval71.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_122 is
			--|#line 805
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_123 is
			--|#line 812
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := new_eiffel_list_id_as (0)
			
			yyval := yyval71
		end

	yy_do_action_124 is
			--|#line 816
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

yyval71 := yytype71 (yyvs.item (yyvsp)) 
			yyval := yyval71
		end

	yy_do_action_125 is
			--|#line 820
		local
			yyval57: TYPE
		do

				-- $$ := Void
			
			yyval := yyval57
		end

	yy_do_action_126 is
			--|#line 824
		local
			yyval57: TYPE
		do

				yyval57 := yytype57 (yyvs.item (yyvsp))
			
			yyval := yyval57
		end

	yy_do_action_127 is
			--|#line 830
		local
			yyval52: ROUTINE_AS
		do

				yyval52 := new_routine_as (yytype54 (yyvs.item (yyvsp - 7)), yytype48 (yyvs.item (yyvsp - 5)), yytype81 (yyvs.item (yyvsp - 4)), yytype51 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)), fbody_pos)
			
			yyval := yyval52
		end

	yy_do_action_128 is
			--|#line 830
		local

		do
			yyval := yyval_default;
				fbody_pos := current_position.start_position
			

		end

	yy_do_action_129 is
			--|#line 841
		local
			yyval51: ROUT_BODY_AS
		do

yyval51 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval51
		end

	yy_do_action_130 is
			--|#line 843
		local
			yyval51: ROUT_BODY_AS
		do

yyval51 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval51
		end

	yy_do_action_131 is
			--|#line 845
		local
			yyval51: ROUT_BODY_AS
		do

				yyval51 := new_deferred_as
			
			yyval := yyval51
		end

	yy_do_action_132 is
			--|#line 851
		local
			yyval24: EXTERNAL_AS
		do

				yyval24 := new_external_as (yytype25 (yyvs.item (yyvsp - 1)), yytype54 (yyvs.item (yyvsp)))
			
			yyval := yyval24
		end

	yy_do_action_133 is
			--|#line 857
		local
			yyval25: EXTERNAL_LANG_AS
		do

				yyval25 := new_external_lang_as (yytype54 (yyvs.item (yyvsp)), yacc_position)
			
			yyval := yyval25
		end

	yy_do_action_134 is
			--|#line 857
		local

		do
			yyval := yyval_default;
				set_position (current_position)
			

		end

	yy_do_action_135 is
			--|#line 867
		local
			yyval54: STRING_AS
		do

				-- $$ := Void
			
			yyval := yyval54
		end

	yy_do_action_136 is
			--|#line 871
		local
			yyval54: STRING_AS
		do

				yyval54 := yytype54 (yyvs.item (yyvsp))
			
			yyval := yyval54
		end

	yy_do_action_137 is
			--|#line 877
		local
			yyval37: INTERNAL_AS
		do

				yyval37 := new_do_as (yytype73 (yyvs.item (yyvsp)))
			
			yyval := yyval37
		end

	yy_do_action_138 is
			--|#line 881
		local
			yyval37: INTERNAL_AS
		do

				yyval37 := new_once_as (yytype73 (yyvs.item (yyvsp)))
			
			yyval := yyval37
		end

	yy_do_action_139 is
			--|#line 887
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

				-- $$ := Void
			
			yyval := yyval81
		end

	yy_do_action_140 is
			--|#line 891
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval81 := yytype81 (yyvs.item (yyvsp))
			
			yyval := yyval81
		end

	yy_do_action_141 is
			--|#line 897
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				-- $$ := Void
			
			yyval := yyval73
		end

	yy_do_action_142 is
			--|#line 901
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval73 := yytype73 (yyvs.item (yyvsp))
			
			yyval := yyval73
		end

	yy_do_action_143 is
			--|#line 907
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval73 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval73.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval73
		end

	yy_do_action_144 is
			--|#line 912
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval73 := yytype73 (yyvs.item (yyvsp - 1))
				yyval73.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval73
		end

	yy_do_action_145 is
			--|#line 919
		local
			yyval35: INSTRUCTION_AS
		do

				yyval35 := yytype35 (yyvs.item (yyvsp - 1))
			
			yyval := yyval35
		end

	yy_do_action_148 is
			--|#line 929
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_149 is
			--|#line 931
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_150 is
			--|#line 933
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_151 is
			--|#line 935
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype50 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_152 is
			--|#line 937
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype31 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_153 is
			--|#line 939
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_154 is
			--|#line 941
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype40 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_155 is
			--|#line 943
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_156 is
			--|#line 945
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_157 is
			--|#line 947
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype49 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_158 is
			--|#line 951
		local
			yyval48: REQUIRE_AS
		do

				-- $$ := Void
			
			yyval := yyval48
		end

	yy_do_action_159 is
			--|#line 955
		local
			yyval48: REQUIRE_AS
		do

				id_level := Normal_level
				yyval48 := new_require_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval48
		end

	yy_do_action_160 is
			--|#line 955
		local

		do
			yyval := yyval_default;
				id_level := Assert_level
			

		end

	yy_do_action_161 is
			--|#line 964
		local
			yyval48: REQUIRE_AS
		do

				id_level := Normal_level
				yyval48 := new_require_else_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval48
		end

	yy_do_action_162 is
			--|#line 964
		local

		do
			yyval := yyval_default;
				id_level := Assert_level
			

		end

	yy_do_action_163 is
			--|#line 975
		local
			yyval21: ENSURE_AS
		do

				-- $$ := Void
			
			yyval := yyval21
		end

	yy_do_action_164 is
			--|#line 979
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_165 is
			--|#line 979
		local

		do
			yyval := yyval_default;
				id_level := Assert_level
			

		end

	yy_do_action_166 is
			--|#line 988
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_then_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_167 is
			--|#line 988
		local

		do
			yyval := yyval_default;
				id_level := Assert_level
			

		end

	yy_do_action_168 is
			--|#line 999
		local
			yyval79: EIFFEL_LIST [TAGGED_AS]
		do

				-- $$ := Void
			
			yyval := yyval79
		end

	yy_do_action_169 is
			--|#line 1003
		local
			yyval79: EIFFEL_LIST [TAGGED_AS]
		do

				yyval79 := yytype79 (yyvs.item (yyvsp))
				if yyval79.empty then
					yyval79 := Void
				end
			
			yyval := yyval79
		end

	yy_do_action_170 is
			--|#line 1012
		local
			yyval79: EIFFEL_LIST [TAGGED_AS]
		do

				yyval79 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval79, yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_171 is
			--|#line 1017
		local
			yyval79: EIFFEL_LIST [TAGGED_AS]
		do

				yyval79 := yytype79 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval79, yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_172 is
			--|#line 1024
		local
			yyval55: TAGGED_AS
		do

				yyval55 := yytype55 (yyvs.item (yyvsp - 1))
			
			yyval := yyval55
		end

	yy_do_action_173 is
			--|#line 1030
		local
			yyval55: TAGGED_AS
		do

				yyval55 := new_tagged_as (Void, yytype23 (yyvs.item (yyvsp)), yacc_position)
			
			yyval := yyval55
		end

	yy_do_action_174 is
			--|#line 1034
		local
			yyval55: TAGGED_AS
		do

				yyval55 := new_tagged_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), yacc_position)
			
			yyval := yyval55
		end

	yy_do_action_175 is
			--|#line 1038
		local
			yyval55: TAGGED_AS
		do

				-- $$ := Void
			
			yyval := yyval55
		end

	yy_do_action_176 is
			--|#line 1048
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_177 is
			--|#line 1050
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_178 is
			--|#line 1054
		local
			yyval57: TYPE
		do

				yyval57 := new_expanded_type (yytype83 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			
			yyval := yyval57
		end

	yy_do_action_179 is
			--|#line 1058
		local
			yyval57: TYPE
		do

				yyval57 := new_separate_type (yytype83 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			
			yyval := yyval57
		end

	yy_do_action_180 is
			--|#line 1062
		local
			yyval57: TYPE
		do

				yyval57 := new_bits_as (yytype36 (yyvs.item (yyvsp)))
			
			yyval := yyval57
		end

	yy_do_action_181 is
			--|#line 1066
		local
			yyval57: TYPE
		do

				yyval57 := new_bits_symbol_as (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval57
		end

	yy_do_action_182 is
			--|#line 1070
		local
			yyval57: TYPE
		do

				yyval57 := new_like_id_as (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval57
		end

	yy_do_action_183 is
			--|#line 1074
		local
			yyval57: TYPE
		do

				yyval57 := new_like_current_as
			
			yyval := yyval57
		end

	yy_do_action_184 is
			--|#line 1080
		local
			yyval57: TYPE
		do

				yyval57 := new_class_type (yytype83 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)))
			
			yyval := yyval57
		end

	yy_do_action_185 is
			--|#line 1084
		local
			yyval57: TYPE
		do

				yyval57 := new_boolean_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void)
			
			yyval := yyval57
		end

	yy_do_action_186 is
			--|#line 1088
		local
			yyval57: TYPE
		do

				yyval57 := new_character_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void)
			
			yyval := yyval57
		end

	yy_do_action_187 is
			--|#line 1092
		local
			yyval57: TYPE
		do

				yyval57 := new_double_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void)
			
			yyval := yyval57
		end

	yy_do_action_188 is
			--|#line 1096
		local
			yyval57: TYPE
		do

				yyval57 := new_integer_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void)
			
			yyval := yyval57
		end

	yy_do_action_189 is
			--|#line 1100
		local
			yyval57: TYPE
		do

				yyval57 := new_none_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void)
			
			yyval := yyval57
		end

	yy_do_action_190 is
			--|#line 1104
		local
			yyval57: TYPE
		do

				yyval57 := new_pointer_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void)
			
			yyval := yyval57
		end

	yy_do_action_191 is
			--|#line 1108
		local
			yyval57: TYPE
		do

				yyval57 := new_real_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void)
			
			yyval := yyval57
		end

	yy_do_action_192 is
			--|#line 1114
		local
			yyval80: EIFFEL_LIST [TYPE]
		do

				-- $$ := Void
			
			yyval := yyval80
		end

	yy_do_action_193 is
			--|#line 1118
		local
			yyval80: EIFFEL_LIST [TYPE]
		do

				-- $$ := Void
			
			yyval := yyval80
		end

	yy_do_action_194 is
			--|#line 1122
		local
			yyval80: EIFFEL_LIST [TYPE]
		do

				yyval80 := yytype80 (yyvs.item (yyvsp - 1))
			
			yyval := yyval80
		end

	yy_do_action_195 is
			--|#line 1128
		local
			yyval80: EIFFEL_LIST [TYPE]
		do

				yyval80 := new_eiffel_list_type (Initial_type_list_size)
				yyval80.extend (yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_196 is
			--|#line 1133
		local
			yyval80: EIFFEL_LIST [TYPE]
		do

				yyval80 := yytype80 (yyvs.item (yyvsp - 2))
				yyval80.extend (yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_197 is
			--|#line 1144
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				-- $$ := Void
			
			yyval := yyval70
		end

	yy_do_action_198 is
			--|#line 1148
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval70 := yytype70 (yyvs.item (yyvsp - 1))
			
			yyval := yyval70
		end

	yy_do_action_199 is
			--|#line 1154
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				-- $$ := Void
			
			yyval := yyval70
		end

	yy_do_action_200 is
			--|#line 1158
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_201 is
			--|#line 1162
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval70 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval70.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_202 is
			--|#line 1167
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval70 := yytype70 (yyvs.item (yyvsp - 2))
				yyval70.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_203 is
			--|#line 1174
		local
			yyval29: FORMAL_DEC_AS
		do

				check formal_exists: not formal_parameters.empty end
				yyval29 := new_formal_dec_as (formal_parameters.last, yytype57 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)), formal_parameters.count)
			
			yyval := yyval29
		end

	yy_do_action_204 is
			--|#line 1174
		local

		do
			yyval := yyval_default;
				formal_parameters.extend (new_id_as (token_buffer))
			

		end

	yy_do_action_205 is
			--|#line 1186
		local
			yyval57: TYPE
		do

				-- $$ := Void
			
			yyval := yyval57
		end

	yy_do_action_206 is
			--|#line 1190
		local
			yyval57: TYPE
		do

				yyval57 := yytype57 (yyvs.item (yyvsp))
			
			yyval := yyval57
		end

	yy_do_action_207 is
			--|#line 1196
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				-- $$ := Void
			
			yyval := yyval69
		end

	yy_do_action_208 is
			--|#line 1200
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval69 := yytype69 (yyvs.item (yyvsp - 1))
			
			yyval := yyval69
		end

	yy_do_action_209 is
			--|#line 1210
		local
			yyval31: IF_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 7)))
				yyval31 := new_if_as (yytype23 (yyvs.item (yyvsp - 5)), yytype73 (yyvs.item (yyvsp - 3)), yytype63 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval31
		end

	yy_do_action_210 is
			--|#line 1217
		local
			yyval63: EIFFEL_LIST [ELSIF_AS]
		do

				-- $$ := Void
			
			yyval := yyval63
		end

	yy_do_action_211 is
			--|#line 1221
		local
			yyval63: EIFFEL_LIST [ELSIF_AS]
		do

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_212 is
			--|#line 1225
		local
			yyval63: EIFFEL_LIST [ELSIF_AS]
		do

				yyval63 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval63.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_213 is
			--|#line 1230
		local
			yyval63: EIFFEL_LIST [ELSIF_AS]
		do

				yyval63 := yytype63 (yyvs.item (yyvsp - 1))
				yyval63.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_214 is
			--|#line 1237
		local
			yyval20: ELSIF_AS
		do

				yyval20 := new_elseif_as (yytype23 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp)), yacc_line_number)
			
			yyval := yyval20
		end

	yy_do_action_215 is
			--|#line 1243
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				-- $$ := Void
			
			yyval := yyval73
		end

	yy_do_action_216 is
			--|#line 1247
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval73 := yytype73 (yyvs.item (yyvsp))
			
			yyval := yyval73
		end

	yy_do_action_217 is
			--|#line 1253
		local
			yyval33: INSPECT_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 5)))
				yyval33 := new_inspect_as (yytype23 (yyvs.item (yyvsp - 3)), yytype61 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval33
		end

	yy_do_action_218 is
			--|#line 1260
		local
			yyval61: EIFFEL_LIST [CASE_AS]
		do

				-- $$ := Void
			
			yyval := yyval61
		end

	yy_do_action_219 is
			--|#line 1264
		local
			yyval61: EIFFEL_LIST [CASE_AS]
		do

yyval61 := yytype61 (yyvs.item (yyvsp)) 
			yyval := yyval61
		end

	yy_do_action_220 is
			--|#line 1268
		local
			yyval61: EIFFEL_LIST [CASE_AS]
		do

				yyval61 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval61.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_221 is
			--|#line 1273
		local
			yyval61: EIFFEL_LIST [CASE_AS]
		do

				yyval61 := yytype61 (yyvs.item (yyvsp - 1))
				yyval61.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_222 is
			--|#line 1280
		local
			yyval11: CASE_AS
		do

				yyval11 := new_case_as (yytype74 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp)), yacc_line_number)
			
			yyval := yyval11
		end

	yy_do_action_223 is
			--|#line 1286
		local
			yyval74: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval74 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval74.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval74
		end

	yy_do_action_224 is
			--|#line 1291
		local
			yyval74: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval74 := yytype74 (yyvs.item (yyvsp - 2))
				yyval74.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval74
		end

	yy_do_action_225 is
			--|#line 1298
		local
			yyval38: INTERVAL_AS
		do

				yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp)), Void)
			
			yyval := yyval38
		end

	yy_do_action_226 is
			--|#line 1302
		local
			yyval38: INTERVAL_AS
		do

				yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp)), Void)
			
			yyval := yyval38
		end

	yy_do_action_227 is
			--|#line 1306
		local
			yyval38: INTERVAL_AS
		do

				yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp)), Void)
			
			yyval := yyval38
		end

	yy_do_action_228 is
			--|#line 1310
		local
			yyval38: INTERVAL_AS
		do

				yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp)))
			
			yyval := yyval38
		end

	yy_do_action_229 is
			--|#line 1314
		local
			yyval38: INTERVAL_AS
		do

				yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval38
		end

	yy_do_action_230 is
			--|#line 1318
		local
			yyval38: INTERVAL_AS
		do

				yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp)))
			
			yyval := yyval38
		end

	yy_do_action_231 is
			--|#line 1322
		local
			yyval38: INTERVAL_AS
		do

				yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval38
		end

	yy_do_action_232 is
			--|#line 1326
		local
			yyval38: INTERVAL_AS
		do

				yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp)))
			
			yyval := yyval38
		end

	yy_do_action_233 is
			--|#line 1330
		local
			yyval38: INTERVAL_AS
		do

				yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp)))
			
			yyval := yyval38
		end

	yy_do_action_234 is
			--|#line 1334
		local
			yyval38: INTERVAL_AS
		do

				yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval38
		end

	yy_do_action_235 is
			--|#line 1340
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				-- $$ := Void
			
			yyval := yyval73
		end

	yy_do_action_236 is
			--|#line 1344
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval73 := yytype73 (yyvs.item (yyvsp))
				if yyval73 = Void then
					yyval73 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval73
		end

	yy_do_action_237 is
			--|#line 1353
		local
			yyval40: LOOP_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 9)))
				yyval40 := new_loop_as (yytype73 (yyvs.item (yyvsp - 7)), yytype79 (yyvs.item (yyvsp - 6)), yytype59 (yyvs.item (yyvsp - 5)), yytype23 (yyvs.item (yyvsp - 3)), yytype73 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval40
		end

	yy_do_action_238 is
			--|#line 1360
		local
			yyval79: EIFFEL_LIST [TAGGED_AS]
		do

				-- $$ := Void
			
			yyval := yyval79
		end

	yy_do_action_239 is
			--|#line 1364
		local
			yyval79: EIFFEL_LIST [TAGGED_AS]
		do

				yyval79 := yytype79 (yyvs.item (yyvsp))
			
			yyval := yyval79
		end

	yy_do_action_240 is
			--|#line 1370
		local
			yyval39: INVARIANT_AS
		do

				-- $$ := Void
			
			yyval := yyval39
		end

	yy_do_action_241 is
			--|#line 1374
		local
			yyval39: INVARIANT_AS
		do

				id_level := Normal_level
				inherit_context := False
				yyval39 := new_invariant_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval39
		end

	yy_do_action_242 is
			--|#line 1374
		local

		do
			yyval := yyval_default;
				id_level := Invariant_level
			

		end

	yy_do_action_243 is
			--|#line 1386
		local
			yyval59: VARIANT_AS
		do

				-- $$ := Void
			
			yyval := yyval59
		end

	yy_do_action_244 is
			--|#line 1390
		local
			yyval59: VARIANT_AS
		do

				yyval59 := new_variant_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), yacc_position)
			
			yyval := yyval59
		end

	yy_do_action_245 is
			--|#line 1394
		local
			yyval59: VARIANT_AS
		do

				yyval59 := new_variant_as (Void, yytype23 (yyvs.item (yyvsp)), yacc_position)
			
			yyval := yyval59
		end

	yy_do_action_246 is
			--|#line 1400
		local
			yyval19: DEBUG_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 4)))
				yyval19 := new_debug_as (yytype78 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval19
		end

	yy_do_action_247 is
			--|#line 1407
		local
			yyval78: EIFFEL_LIST [STRING_AS]
		do

				-- $$ := Void
			
			yyval := yyval78
		end

	yy_do_action_248 is
			--|#line 1411
		local
			yyval78: EIFFEL_LIST [STRING_AS]
		do

				-- $$ := Void
			
			yyval := yyval78
		end

	yy_do_action_249 is
			--|#line 1415
		local
			yyval78: EIFFEL_LIST [STRING_AS]
		do

				yyval78 := yytype78 (yyvs.item (yyvsp - 1))
			
			yyval := yyval78
		end

	yy_do_action_250 is
			--|#line 1421
		local
			yyval78: EIFFEL_LIST [STRING_AS]
		do

				yyval78 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval78.extend (yytype54 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_251 is
			--|#line 1426
		local
			yyval78: EIFFEL_LIST [STRING_AS]
		do

				yyval78 := yytype78 (yyvs.item (yyvsp - 2))
				yyval78.extend (yytype54 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_252 is
			--|#line 1433
		local
			yyval49: RETRY_AS
		do

				yyval49 := new_retry_as (yacc_line_number)
			
			yyval := yyval49
		end

	yy_do_action_253 is
			--|#line 1439
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				-- $$ := Void
			
			yyval := yyval73
		end

	yy_do_action_254 is
			--|#line 1443
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval73 := yytype73 (yyvs.item (yyvsp))
				if yyval73 = Void then
					yyval73 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval73
		end

	yy_do_action_255 is
			--|#line 1452
		local
			yyval5: ASSIGN_AS
		do

				yyval5 := new_assign_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
			
			yyval := yyval5
		end

	yy_do_action_256 is
			--|#line 1456
		local
			yyval5: ASSIGN_AS
		do

				yyval5 := new_assign_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
			
			yyval := yyval5
		end

	yy_do_action_257 is
			--|#line 1462
		local
			yyval50: REVERSE_AS
		do

				yyval50 := new_reverse_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
			
			yyval := yyval50
		end

	yy_do_action_258 is
			--|#line 1466
		local
			yyval50: REVERSE_AS
		do

				 yyval50 := new_reverse_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
			
			yyval := yyval50
		end

	yy_do_action_259 is
			--|#line 1472
		local
			yyval62: EIFFEL_LIST [CREATE_AS]
		do

				-- $$ := Void
			
			yyval := yyval62
		end

	yy_do_action_260 is
			--|#line 1476
		local
			yyval62: EIFFEL_LIST [CREATE_AS]
		do

yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
		end

	yy_do_action_261 is
			--|#line 1480
		local
			yyval62: EIFFEL_LIST [CREATE_AS]
		do

				yyval62 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval62.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_262 is
			--|#line 1485
		local
			yyval62: EIFFEL_LIST [CREATE_AS]
		do

				yyval62 := yytype62 (yyvs.item (yyvsp - 1))
				yyval62.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_263 is
			--|#line 1492
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_264 is
			--|#line 1497
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_265 is
			--|#line 1502
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype71 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_266 is
			--|#line 1509
		local
			yyval53: ROUTINE_CREATION_AS
		do

				yyval53 := new_routine_creation_as (yytype43 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp - 1)), yytype75 (yyvs.item (yyvsp)))
			
			yyval := yyval53
		end

	yy_do_action_267 is
			--|#line 1515
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 1)), Void)
			
			yyval := yyval43
		end

	yy_do_action_268 is
			--|#line 1519
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 2)))
			
			yyval := yyval43
		end

	yy_do_action_269 is
			--|#line 1523
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (yytype57 (yyvs.item (yyvsp - 1)), Void, Void)
			
			yyval := yyval43
		end

	yy_do_action_270 is
			--|#line 1527
		local
			yyval43: OPERAND_AS
		do

				-- $$ := Void
			
			yyval := yyval43
		end

	yy_do_action_271 is
			--|#line 1531
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (Void, Void, Void)
			
			yyval := yyval43
		end

	yy_do_action_272 is
			--|#line 1537
		local
			yyval75: EIFFEL_LIST [OPERAND_AS]
		do

				-- $$ := Void
			
			yyval := yyval75
		end

	yy_do_action_273 is
			--|#line 1541
		local
			yyval75: EIFFEL_LIST [OPERAND_AS]
		do

				yyval75 := yytype75 (yyvs.item (yyvsp - 1))
			
			yyval := yyval75
		end

	yy_do_action_274 is
			--|#line 1547
		local
			yyval75: EIFFEL_LIST [OPERAND_AS]
		do

				yyval75 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval75.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_275 is
			--|#line 1552
		local
			yyval75: EIFFEL_LIST [OPERAND_AS]
		do

				yyval75 := yytype75 (yyvs.item (yyvsp - 2))
				yyval75.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_276 is
			--|#line 1559
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (Void, Void, Void)
			
			yyval := yyval43
		end

	yy_do_action_277 is
			--|#line 1563
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval43
		end

	yy_do_action_278 is
			--|#line 1567
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (new_class_type (yytype83 (yyvs.item (yyvsp - 2)), yytype80 (yyvs.item (yyvsp - 1))), Void, Void)
			
			yyval := yyval43
		end

	yy_do_action_279 is
			--|#line 1571
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (new_boolean_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void)
			
			yyval := yyval43
		end

	yy_do_action_280 is
			--|#line 1575
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (new_character_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void)
			
			yyval := yyval43
		end

	yy_do_action_281 is
			--|#line 1579
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (new_double_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void)
			
			yyval := yyval43
		end

	yy_do_action_282 is
			--|#line 1583
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (new_integer_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void)
			
			yyval := yyval43
		end

	yy_do_action_283 is
			--|#line 1587
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (new_none_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void)
			
			yyval := yyval43
		end

	yy_do_action_284 is
			--|#line 1591
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (new_pointer_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void)
			
			yyval := yyval43
		end

	yy_do_action_285 is
			--|#line 1595
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (new_real_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void)
			
			yyval := yyval43
		end

	yy_do_action_286 is
			--|#line 1599
		local
			yyval43: OPERAND_AS
		do

				yyval43 := new_operand_as (yytype57 (yyvs.item (yyvsp - 1)), Void, Void)
			
			yyval := yyval43
		end

	yy_do_action_287 is
			--|#line 1605
		local
			yyval17: CREATION_AS
		do

				yyval17 := new_creation_as (yytype57 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
			
			yyval := yyval17
		end

	yy_do_action_288 is
			--|#line 1609
		local
			yyval17: CREATION_AS
		do

				yyval17 := new_creation_as (Void, yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
			
			yyval := yyval17
		end

	yy_do_action_289 is
			--|#line 1613
		local
			yyval17: CREATION_AS
		do

				yyval17 := new_creation_as (yytype57 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
			
			yyval := yyval17
		end

	yy_do_action_290 is
			--|#line 1619
		local
			yyval18: CREATION_EXPR_AS
		do

				yyval18 := new_creation_expr_as (yytype57 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp)))
			
			yyval := yyval18
		end

	yy_do_action_291 is
			--|#line 1623
		local
			yyval18: CREATION_EXPR_AS
		do

				yyval18 := new_creation_expr_as (yytype57 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp)))
			
			yyval := yyval18
		end

	yy_do_action_292 is
			--|#line 1629
		local
			yyval57: TYPE
		do

				-- $$ := Void
			
			yyval := yyval57
		end

	yy_do_action_293 is
			--|#line 1633
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_294 is
			--|#line 1637
		local
			yyval1: ACCESS_AS
		do

				yyval1 := new_access_id_as (yytype30 (yyvs.item (yyvsp)), Void)
			
			yyval := yyval1
		end

	yy_do_action_295 is
			--|#line 1641
		local
			yyval1: ACCESS_AS
		do

				yyval1 := new_result_as
			
			yyval := yyval1
		end

	yy_do_action_296 is
			--|#line 1647
		local
			yyval3: ACCESS_INV_AS
		do

				-- $$ := Void
			
			yyval := yyval3
		end

	yy_do_action_297 is
			--|#line 1651
		local
			yyval3: ACCESS_INV_AS
		do

				yyval3 := new_access_inv_as (yytype30 (yyvs.item (yyvsp - 1)), yytype65 (yyvs.item (yyvsp)))
			
			yyval := yyval3
		end

	yy_do_action_298 is
			--|#line 1661
		local
			yyval34: INSTR_CALL_AS
		do

				yyval34 := new_instr_call_as (yytype1 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
			
			yyval := yyval34
		end

	yy_do_action_299 is
			--|#line 1665
		local
			yyval34: INSTR_CALL_AS
		do

				yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
			
			yyval := yyval34
		end

	yy_do_action_300 is
			--|#line 1669
		local
			yyval34: INSTR_CALL_AS
		do

				yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
			
			yyval := yyval34
		end

	yy_do_action_301 is
			--|#line 1673
		local
			yyval34: INSTR_CALL_AS
		do

				yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
			
			yyval := yyval34
		end

	yy_do_action_302 is
			--|#line 1677
		local
			yyval34: INSTR_CALL_AS
		do

				yyval34 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
			
			yyval := yyval34
		end

	yy_do_action_303 is
			--|#line 1681
		local
			yyval34: INSTR_CALL_AS
		do

				yyval34 := new_instr_call_as (yytype45 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
			
			yyval := yyval34
		end

	yy_do_action_304 is
			--|#line 1685
		local
			yyval34: INSTR_CALL_AS
		do

				yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number)
			
			yyval := yyval34
		end

	yy_do_action_305 is
			--|#line 1691
		local
			yyval13: CHECK_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 3)))
				yyval13 := new_check_as (yytype79 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval13
		end

	yy_do_action_306 is
			--|#line 1702
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_value_as (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_307 is
			--|#line 1706
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_value_as (yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_308 is
			--|#line 1710
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_value_as (yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_309 is
			--|#line 1714
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_expr_call_as (yytype10 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_310 is
			--|#line 1718
		local
			yyval23: EXPR_AS
		do

yyval23 := yytype53 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_311 is
			--|#line 1720
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_paran_as (yytype23 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval23
		end

	yy_do_action_312 is
			--|#line 1724
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_plus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_313 is
			--|#line 1728
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_minus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_314 is
			--|#line 1732
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_star_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_315 is
			--|#line 1736
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_slash_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_316 is
			--|#line 1740
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_mod_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_317 is
			--|#line 1744
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_div_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_318 is
			--|#line 1748
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_power_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_319 is
			--|#line 1752
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_and_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_320 is
			--|#line 1756
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_and_then_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_321 is
			--|#line 1760
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_or_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_322 is
			--|#line 1764
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_or_else_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_323 is
			--|#line 1768
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_implies_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_324 is
			--|#line 1772
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_xor_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_325 is
			--|#line 1776
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_ge_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_326 is
			--|#line 1780
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_gt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_327 is
			--|#line 1784
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_le_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_328 is
			--|#line 1788
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_lt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_329 is
			--|#line 1792
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_eq_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_330 is
			--|#line 1796
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_ne_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_331 is
			--|#line 1800
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_bin_free_as (yytype23 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_332 is
			--|#line 1804
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_un_minus_as (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_333 is
			--|#line 1808
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_un_plus_as (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_334 is
			--|#line 1812
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_un_not_as (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_335 is
			--|#line 1816
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_un_old_as (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_336 is
			--|#line 1820
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_un_free_as (yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval23
		end

	yy_do_action_337 is
			--|#line 1824
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_un_strip_as (yytype71 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval23
		end

	yy_do_action_338 is
			--|#line 1830
		local
			yyval23: EXPR_AS
		do

yyval23 := yytype23 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_339 is
			--|#line 1832
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_address_as (yytype84 (yyvs.item (yyvsp)).first)
			
			yyval := yyval23
		end

	yy_do_action_340 is
			--|#line 1836
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_expr_address_as (yytype23 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval23
		end

	yy_do_action_341 is
			--|#line 1840
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_address_current_as
			
			yyval := yyval23
		end

	yy_do_action_342 is
			--|#line 1844
		local
			yyval23: EXPR_AS
		do

				yyval23 := new_address_result_as
			
			yyval := yyval23
		end

	yy_do_action_343 is
			--|#line 1850
		local
			yyval30: ID_AS
		do

				yyval30 := new_id_as (token_buffer)
			
			yyval := yyval30
		end

	yy_do_action_344 is
			--|#line 1860
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_345 is
			--|#line 1862
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_346 is
			--|#line 1864
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_347 is
			--|#line 1866
		local
			yyval10: CALL_AS
		do

				yyval10 := new_current_as
			
			yyval := yyval10
		end

	yy_do_action_348 is
			--|#line 1870
		local
			yyval10: CALL_AS
		do

				yyval10 := new_result_as
			
			yyval := yyval10
		end

	yy_do_action_349 is
			--|#line 1874
		local
			yyval10: CALL_AS
		do

yyval10 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_350 is
			--|#line 1876
		local
			yyval10: CALL_AS
		do

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_351 is
			--|#line 1878
		local
			yyval10: CALL_AS
		do

yyval10 := yytype45 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_352 is
			--|#line 1880
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_353 is
			--|#line 1882
		local
			yyval10: CALL_AS
		do

yyval10 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_354 is
			--|#line 1886
		local
			yyval41: NESTED_AS
		do

				yyval41 := new_nested_as (new_current_as, yytype10 (yyvs.item (yyvsp)))
			
			yyval := yyval41
		end

	yy_do_action_355 is
			--|#line 1892
		local
			yyval41: NESTED_AS
		do

				yyval41 := new_nested_as (new_result_as, yytype10 (yyvs.item (yyvsp)))
			
			yyval := yyval41
		end

	yy_do_action_356 is
			--|#line 1898
		local
			yyval41: NESTED_AS
		do

				yyval41 := new_nested_as (yytype1 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp)))
			
			yyval := yyval41
		end

	yy_do_action_357 is
			--|#line 1904
		local
			yyval42: NESTED_EXPR_AS
		do

				yyval42 := new_nested_expr_as (yytype23 (yyvs.item (yyvsp - 3)), yytype10 (yyvs.item (yyvsp)))
			
			yyval := yyval42
		end

	yy_do_action_358 is
			--|#line 1910
		local
			yyval41: NESTED_AS
		do

				yyval41 := new_nested_as (yytype45 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp)))
			
			yyval := yyval41
		end

	yy_do_action_359 is
			--|#line 1916
		local
			yyval45: PRECURSOR_AS
		do

				yyval45 := new_precursor_as (Void, yytype65 (yyvs.item (yyvsp)))
			
			yyval := yyval45
		end

	yy_do_action_360 is
			--|#line 1920
		local
			yyval45: PRECURSOR_AS
		do

				yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 4)), yytype65 (yyvs.item (yyvsp)))
			
			yyval := yyval45
		end

	yy_do_action_361 is
			--|#line 1924
		local
			yyval45: PRECURSOR_AS
		do

				yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 2)), yytype65 (yyvs.item (yyvsp)))
			
			yyval := yyval45
		end

	yy_do_action_362 is
			--|#line 1928
		local
			yyval45: PRECURSOR_AS
		do

				yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp)))
			
			yyval := yyval45
		end

	yy_do_action_363 is
			--|#line 1932
		local
			yyval45: PRECURSOR_AS
		do

				yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp)))
			
			yyval := yyval45
		end

	yy_do_action_364 is
			--|#line 1936
		local
			yyval45: PRECURSOR_AS
		do

				yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp)))
			
			yyval := yyval45
		end

	yy_do_action_365 is
			--|#line 1940
		local
			yyval45: PRECURSOR_AS
		do

				yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp)))
			
			yyval := yyval45
		end

	yy_do_action_366 is
			--|#line 1944
		local
			yyval45: PRECURSOR_AS
		do

				yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp)))
			
			yyval := yyval45
		end

	yy_do_action_367 is
			--|#line 1948
		local
			yyval45: PRECURSOR_AS
		do

				yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp)))
			
			yyval := yyval45
		end

	yy_do_action_368 is
			--|#line 1952
		local
			yyval45: PRECURSOR_AS
		do

				yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp)))
			
			yyval := yyval45
		end

	yy_do_action_369 is
			--|#line 1956
		local
			yyval45: PRECURSOR_AS
		do

				yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp)))
			
			yyval := yyval45
		end

	yy_do_action_370 is
			--|#line 1962
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_371 is
			--|#line 1964
		local
			yyval10: CALL_AS
		do

yyval10 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_372 is
			--|#line 1968
		local
			yyval41: NESTED_AS
		do

				yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp)))
			
			yyval := yyval41
		end

	yy_do_action_373 is
			--|#line 1972
		local
			yyval41: NESTED_AS
		do

				yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype41 (yyvs.item (yyvsp)))
			
			yyval := yyval41
		end

	yy_do_action_374 is
			--|#line 1978
		local
			yyval1: ACCESS_AS
		do

				inspect id_level
				when Normal_level then
					yyval1 := new_access_id_as (yytype30 (yyvs.item (yyvsp - 1)), yytype65 (yyvs.item (yyvsp)))
				when Assert_level then
					yyval1 := new_access_assert_as (yytype30 (yyvs.item (yyvsp - 1)), yytype65 (yyvs.item (yyvsp)))
				when Invariant_level then
					yyval1 := new_access_inv_as (yytype30 (yyvs.item (yyvsp - 1)), yytype65 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval1
		end

	yy_do_action_375 is
			--|#line 1991
		local
			yyval2: ACCESS_FEAT_AS
		do

				yyval2 := new_access_feat_as (yytype30 (yyvs.item (yyvsp - 1)), yytype65 (yyvs.item (yyvsp)))
			
			yyval := yyval2
		end

	yy_do_action_376 is
			--|#line 1997
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				-- $$ := Void
			
			yyval := yyval65
		end

	yy_do_action_377 is
			--|#line 2001
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				-- $$ := Void
			
			yyval := yyval65
		end

	yy_do_action_378 is
			--|#line 2005
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := yytype65 (yyvs.item (yyvsp - 1))
			
			yyval := yyval65
		end

	yy_do_action_379 is
			--|#line 2011
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_380 is
			--|#line 2016
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := yytype65 (yyvs.item (yyvsp - 2))
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_381 is
			--|#line 2023
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := new_eiffel_list_expr_as (0)
			
			yyval := yyval65
		end

	yy_do_action_382 is
			--|#line 2027
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_383 is
			--|#line 2031
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_384 is
			--|#line 2036
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := yytype65 (yyvs.item (yyvsp - 2))
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_385 is
			--|#line 2047
		local
			yyval30: ID_AS
		do

				yyval30 := new_id_as (token_buffer)
			
			yyval := yyval30
		end

	yy_do_action_386 is
			--|#line 2051
		local
			yyval30: ID_AS
		do

				yyval30 := new_boolean_id_as
			
			yyval := yyval30
		end

	yy_do_action_387 is
			--|#line 2055
		local
			yyval30: ID_AS
		do

				yyval30 := new_character_id_as
			
			yyval := yyval30
		end

	yy_do_action_388 is
			--|#line 2059
		local
			yyval30: ID_AS
		do

				yyval30 := new_double_id_as
			
			yyval := yyval30
		end

	yy_do_action_389 is
			--|#line 2063
		local
			yyval30: ID_AS
		do

				yyval30 := new_integer_id_as
			
			yyval := yyval30
		end

	yy_do_action_390 is
			--|#line 2067
		local
			yyval30: ID_AS
		do

				yyval30 := new_none_id_as
			
			yyval := yyval30
		end

	yy_do_action_391 is
			--|#line 2071
		local
			yyval30: ID_AS
		do

				yyval30 := new_pointer_id_as
			
			yyval := yyval30
		end

	yy_do_action_392 is
			--|#line 2075
		local
			yyval30: ID_AS
		do

				yyval30 := new_real_id_as
			
			yyval := yyval30
		end

	yy_do_action_393 is
			--|#line 2081
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_394 is
			--|#line 2083
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_395 is
			--|#line 2085
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_396 is
			--|#line 2087
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype46 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_397 is
			--|#line 2089
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_398 is
			--|#line 2091
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_399 is
			--|#line 2095
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_400 is
			--|#line 2097
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_401 is
			--|#line 2099
		local
			yyval6: ATOMIC_AS
		do

				if token_buffer.is_integer then
					yyval6 := new_integer_as (token_buffer.to_integer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval6 := new_integer_as (0)
				end
			
			yyval := yyval6
		end

	yy_do_action_402 is
			--|#line 2109
		local
			yyval6: ATOMIC_AS
		do

				yyval6 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval6
		end

	yy_do_action_403 is
			--|#line 2113
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_404 is
			--|#line 2115
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_405 is
			--|#line 2119
		local
			yyval9: BOOL_AS
		do

				yyval9 := new_boolean_as (False)
			
			yyval := yyval9
		end

	yy_do_action_406 is
			--|#line 2123
		local
			yyval9: BOOL_AS
		do

				yyval9 := new_boolean_as (True)
			
			yyval := yyval9
		end

	yy_do_action_407 is
			--|#line 2129
		local
			yyval12: CHAR_AS
		do

				check is_character: not token_buffer.empty end
				yyval12 := new_character_as (token_buffer.item (1))
			
			yyval := yyval12
		end

	yy_do_action_408 is
			--|#line 2136
		local
			yyval36: INTEGER_AS
		do

				if token_buffer.is_integer then
					yyval36 := new_integer_as (token_buffer.to_integer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval36 := new_integer_as (0)
				end
			
			yyval := yyval36
		end

	yy_do_action_409 is
			--|#line 2146
		local
			yyval36: INTEGER_AS
		do

				if token_buffer.is_integer then
					yyval36 := new_integer_as (token_buffer.to_integer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval36 := new_integer_as (0)
				end
			
			yyval := yyval36
		end

	yy_do_action_410 is
			--|#line 2156
		local
			yyval36: INTEGER_AS
		do

				if token_buffer.is_integer then
					yyval36 := new_integer_as (- token_buffer.to_integer)
				else
					token_buffer.precede ('-')
					report_integer_too_small_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval36 := new_integer_as (0)
				end
			
			yyval := yyval36
		end

	yy_do_action_411 is
			--|#line 2169
		local
			yyval46: REAL_AS
		do

				yyval46 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval46
		end

	yy_do_action_412 is
			--|#line 2173
		local
			yyval46: REAL_AS
		do

				yyval46 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval46
		end

	yy_do_action_413 is
			--|#line 2177
		local
			yyval46: REAL_AS
		do

				token_buffer.precede ('-')
				yyval46 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval46
		end

	yy_do_action_414 is
			--|#line 2184
		local
			yyval7: BIT_CONST_AS
		do

				yyval7 := new_bit_const_as (new_id_as (token_buffer))
			
			yyval := yyval7
		end

	yy_do_action_415 is
			--|#line 2190
		local
			yyval54: STRING_AS
		do

				yyval54 := yytype54 (yyvs.item (yyvsp))
			
			yyval := yyval54
		end

	yy_do_action_416 is
			--|#line 2194
		local
			yyval54: STRING_AS
		do

				yyval54 := new_empty_string_as
			
			yyval := yyval54
		end

	yy_do_action_417 is
			--|#line 2200
		local
			yyval54: STRING_AS
		do

				yyval54 := new_string_as (cloned_string (token_buffer))
			
			yyval := yyval54
		end

	yy_do_action_418 is
			--|#line 2204
		local
			yyval54: STRING_AS
		do

				yyval54 := new_lt_string_as
			
			yyval := yyval54
		end

	yy_do_action_419 is
			--|#line 2208
		local
			yyval54: STRING_AS
		do

				yyval54 := new_le_string_as
			
			yyval := yyval54
		end

	yy_do_action_420 is
			--|#line 2212
		local
			yyval54: STRING_AS
		do

				yyval54 := new_gt_string_as
			
			yyval := yyval54
		end

	yy_do_action_421 is
			--|#line 2216
		local
			yyval54: STRING_AS
		do

				yyval54 := new_ge_string_as
			
			yyval := yyval54
		end

	yy_do_action_422 is
			--|#line 2220
		local
			yyval54: STRING_AS
		do

				yyval54 := new_minus_string_as
			
			yyval := yyval54
		end

	yy_do_action_423 is
			--|#line 2224
		local
			yyval54: STRING_AS
		do

				yyval54 := new_plus_string_as
			
			yyval := yyval54
		end

	yy_do_action_424 is
			--|#line 2228
		local
			yyval54: STRING_AS
		do

				yyval54 := new_star_string_as
			
			yyval := yyval54
		end

	yy_do_action_425 is
			--|#line 2232
		local
			yyval54: STRING_AS
		do

				yyval54 := new_slash_string_as
			
			yyval := yyval54
		end

	yy_do_action_426 is
			--|#line 2236
		local
			yyval54: STRING_AS
		do

				yyval54 := new_mod_string_as
			
			yyval := yyval54
		end

	yy_do_action_427 is
			--|#line 2240
		local
			yyval54: STRING_AS
		do

				yyval54 := new_div_string_as
			
			yyval := yyval54
		end

	yy_do_action_428 is
			--|#line 2244
		local
			yyval54: STRING_AS
		do

				yyval54 := new_power_string_as
			
			yyval := yyval54
		end

	yy_do_action_429 is
			--|#line 2248
		local
			yyval54: STRING_AS
		do

				yyval54 := new_string_as (cloned_string (token_buffer))
			
			yyval := yyval54
		end

	yy_do_action_430 is
			--|#line 2252
		local
			yyval54: STRING_AS
		do

				yyval54 := new_string_as (cloned_string (token_buffer))
			
			yyval := yyval54
		end

	yy_do_action_431 is
			--|#line 2256
		local
			yyval54: STRING_AS
		do

				yyval54 := new_string_as (cloned_string (token_buffer))
			
			yyval := yyval54
		end

	yy_do_action_432 is
			--|#line 2260
		local
			yyval54: STRING_AS
		do

				yyval54 := new_string_as (cloned_string (token_buffer))
			
			yyval := yyval54
		end

	yy_do_action_433 is
			--|#line 2264
		local
			yyval54: STRING_AS
		do

				yyval54 := new_string_as (cloned_string (token_buffer))
			
			yyval := yyval54
		end

	yy_do_action_434 is
			--|#line 2268
		local
			yyval54: STRING_AS
		do

				yyval54 := new_string_as (cloned_string (token_buffer))
			
			yyval := yyval54
		end

	yy_do_action_435 is
			--|#line 2272
		local
			yyval54: STRING_AS
		do

				yyval54 := new_string_as (cloned_string (token_buffer))
			
			yyval := yyval54
		end

	yy_do_action_436 is
			--|#line 2276
		local
			yyval54: STRING_AS
		do

				yyval54 := new_string_as (cloned_string (token_buffer))
			
			yyval := yyval54
		end

	yy_do_action_437 is
			--|#line 2282
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_minus_string_as)
			
			yyval := yyval85
		end

	yy_do_action_438 is
			--|#line 2286
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_plus_string_as)
			
			yyval := yyval85
		end

	yy_do_action_439 is
			--|#line 2290
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_not_string_as)
			
			yyval := yyval85
		end

	yy_do_action_440 is
			--|#line 2294
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer)))
			
			yyval := yyval85
		end

	yy_do_action_441 is
			--|#line 2300
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_lt_string_as)
			
			yyval := yyval85
		end

	yy_do_action_442 is
			--|#line 2304
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_le_string_as)
			
			yyval := yyval85
		end

	yy_do_action_443 is
			--|#line 2308
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_gt_string_as)
			
			yyval := yyval85
		end

	yy_do_action_444 is
			--|#line 2312
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_ge_string_as)
			
			yyval := yyval85
		end

	yy_do_action_445 is
			--|#line 2316
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_minus_string_as)
			
			yyval := yyval85
		end

	yy_do_action_446 is
			--|#line 2320
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_plus_string_as)
			
			yyval := yyval85
		end

	yy_do_action_447 is
			--|#line 2324
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_star_string_as)
			
			yyval := yyval85
		end

	yy_do_action_448 is
			--|#line 2328
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_slash_string_as)
			
			yyval := yyval85
		end

	yy_do_action_449 is
			--|#line 2332
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_mod_string_as)
			
			yyval := yyval85
		end

	yy_do_action_450 is
			--|#line 2336
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_div_string_as)
			
			yyval := yyval85
		end

	yy_do_action_451 is
			--|#line 2340
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_power_string_as)
			
			yyval := yyval85
		end

	yy_do_action_452 is
			--|#line 2344
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_and_string_as)
			
			yyval := yyval85
		end

	yy_do_action_453 is
			--|#line 2348
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_and_then_string_as)
			
			yyval := yyval85
		end

	yy_do_action_454 is
			--|#line 2352
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_implies_string_as)
			
			yyval := yyval85
		end

	yy_do_action_455 is
			--|#line 2356
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_or_string_as)
			
			yyval := yyval85
		end

	yy_do_action_456 is
			--|#line 2360
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_or_else_string_as)
			
			yyval := yyval85
		end

	yy_do_action_457 is
			--|#line 2364
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_xor_string_as)
			
			yyval := yyval85
		end

	yy_do_action_458 is
			--|#line 2368
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

				yyval85 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer)))
			
			yyval := yyval85
		end

	yy_do_action_459 is
			--|#line 2374
		local
			yyval4: ARRAY_AS
		do

				yyval4 := new_array_as (yytype65 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval4
		end

	yy_do_action_460 is
			--|#line 2380
		local
			yyval56: TUPLE_AS
		do

				yyval56 := new_tuple_as (yytype65 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval56
		end

	yy_do_action_461 is
			--|#line 2386
		local

		do
			yyval := yyval_default;
				set_position (current_position)
			

		end

	yy_do_action_462 is
			--|#line 2392
		local
			yyval87: TOKEN_LOCATION
		do

				yyval87 := clone (current_position)
			
			yyval := yyval87
		end

feature {NONE} -- Table templates

	yytranslate_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,    2,    2,    2,    2,   96,    2,    2,    2,    2,
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
			   95,   97,   98,   99,  100,  101,  102,  103,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  289,  272,  272,  272,  272,  272,  272,  272,  272,
			  273,  274,  275,  276,  277,  278,  279,  280,  247,  247,
			  247,  248,  248,  171,  168,  168,  215,  215,  215,  137,
			  137,  290,  290,  290,  290,  200,  200,  230,  230,  231,
			  231,  164,  164,  149,  292,  148,  148,  243,  243,  244,
			  244,  229,  229,  291,  291,  163,  287,  287,  284,  293,
			  293,  283,  283,  283,  281,  282,  141,  150,  150,  151,
			  151,  151,  257,  257,  257,  258,  258,  189,  189,  190,
			  190,  190,  190,  190,  190,  190,  259,  259,  260,  260,
			  193,  223,  223,  222,  222,  224,  224,  158,  165,  165,

			  232,  232,  234,  234,  233,  233,  236,  236,  235,  235,
			  238,  238,  237,  237,  268,  268,  269,  269,  270,  270,
			  213,  245,  245,  246,  246,  208,  208,  198,  294,  197,
			  197,  197,  161,  162,  295,  202,  202,  177,  177,  271,
			  271,  250,  250,  251,  251,  174,  296,  296,  175,  175,
			  175,  175,  175,  175,  175,  175,  175,  175,  194,  194,
			  298,  194,  299,  157,  157,  300,  157,  301,  263,  263,
			  264,  264,  204,  205,  205,  205,  207,  207,  212,  212,
			  212,  212,  212,  212,  209,  209,  209,  209,  209,  209,
			  209,  209,  266,  266,  266,  267,  267,  240,  240,  241,

			  241,  242,  242,  166,  302,  210,  210,  239,  239,  170,
			  220,  220,  221,  221,  156,  252,  252,  172,  216,  216,
			  217,  217,  145,  254,  254,  178,  178,  178,  178,  178,
			  178,  178,  178,  178,  178,  253,  253,  180,  265,  265,
			  179,  179,  303,  214,  214,  214,  155,  261,  261,  261,
			  262,  262,  195,  249,  249,  136,  136,  196,  196,  218,
			  218,  219,  219,  152,  152,  152,  199,  187,  187,  187,
			  187,  187,  255,  255,  256,  256,  188,  188,  188,  188,
			  188,  188,  188,  188,  188,  188,  188,  153,  153,  153,
			  154,  154,  211,  211,  131,  131,  134,  134,  173,  173,

			  173,  173,  173,  173,  173,  147,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  160,  160,
			  160,  160,  160,  169,  144,  144,  144,  144,  144,  144,
			  144,  144,  144,  144,  185,  184,  183,  186,  182,  191,
			  191,  191,  191,  191,  191,  191,  191,  191,  191,  191,
			  143,  143,  181,  181,  132,  133,  225,  225,  225,  226,
			  226,  227,  227,  228,  228,  167,  167,  167,  167,  167,
			  167,  167,  167,  138,  138,  138,  138,  138,  138,  139,

			  139,  139,  139,  139,  139,  142,  142,  146,  176,  176,
			  176,  192,  192,  192,  140,  201,  201,  203,  203,  203,
			  203,  203,  203,  203,  203,  203,  203,  203,  203,  203,
			  203,  203,  203,  203,  203,  203,  203,  286,  286,  286,
			  286,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  135,
			  206,  297,  288>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   11,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    0,    2,
			    1,    1,    2,    3,    2,    0,    1,    3,    1,    1,
			    1,    0,    1,    1,    1,    0,    2,    0,    1,    1,
			    2,    1,    2,    3,    0,    0,    1,    2,    3,    1,
			    3,    1,    2,    0,    1,    3,    1,    3,    2,    0,
			    1,    1,    1,    1,    2,    2,    3,    0,    2,    1,
			    1,    1,    0,    2,    2,    1,    2,    1,    2,    2,
			    8,    7,    6,    5,    4,    3,    1,    2,    1,    3,
			    3,    0,    1,    2,    2,    1,    2,    3,    1,    1,

			    1,    3,    0,    1,    1,    2,    0,    1,    1,    2,
			    0,    1,    1,    2,    0,    3,    0,    1,    1,    2,
			    4,    1,    3,    0,    1,    0,    2,    8,    0,    1,
			    1,    1,    3,    2,    0,    0,    2,    2,    2,    0,
			    2,    1,    2,    1,    2,    3,    0,    2,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    0,    3,
			    0,    4,    0,    0,    3,    0,    4,    0,    0,    1,
			    1,    2,    3,    1,    3,    2,    1,    1,    3,    3,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    0,    2,    3,    1,    3,    0,    3,    0,

			    1,    1,    3,    4,    0,    0,    2,    0,    3,    8,
			    0,    1,    1,    2,    4,    0,    2,    6,    0,    1,
			    1,    2,    4,    1,    3,    1,    1,    1,    3,    3,
			    3,    3,    3,    3,    3,    0,    2,   10,    0,    2,
			    0,    3,    0,    0,    4,    2,    5,    0,    2,    3,
			    1,    3,    1,    0,    2,    3,    3,    3,    3,    0,
			    1,    1,    2,    1,    3,    2,    3,    2,    4,    3,
			    2,    1,    0,    3,    1,    3,    1,    1,    4,    4,
			    4,    4,    4,    4,    4,    4,    3,    5,    3,    6,
			    5,    4,    0,    1,    1,    1,    0,    3,    1,    1,

			    1,    1,    1,    1,    1,    4,    1,    1,    1,    1,
			    1,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    4,    3,    4,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    2,    2,    2,    2,    2,    4,    1,    2,
			    4,    2,    2,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    3,    3,    3,    5,    3,    2,
			    7,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    1,    1,    3,    3,    2,    2,    0,    2,    3,    1,
			    3,    0,    1,    1,    3,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    2,    1,    2,    2,    1,    1,    1,    1,    1,    1,
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
			   18,   25,   31,  392,  391,  390,  389,  388,  387,  386,
			  385,    0,    0,   21,   25,   34,   33,   32,    0,   24,
			  436,  435,  434,  433,  432,  431,  430,  429,  428,  427,
			  426,  425,  424,  423,  422,  421,  420,  419,  418,  416,
			  406,  405,   28,  414,  417,  411,  407,  408,    0,    0,
			   26,   30,  397,  393,  394,   29,  395,  396,  398,  415,
			   53,   22,    0,  413,  410,  412,  409,    0,   54,   23,
			   17,   16,   15,   14,   13,   12,   11,   10,  197,    2,
			    3,    4,    5,    6,    7,    8,    9,   27,  199,   35,
			  204,  201,    0,  200,    0,   72,  205,  198,    0,   36,

			   53,  259,    0,  207,  202,   75,   77,   73,  192,   74,
			  263,  261,   37,  260,  206,  192,  192,  192,  192,  192,
			  192,  192,  192,    0,  203,   78,   76,    0,   79,    0,
			    0,  265,   44,   59,   39,  240,   38,  262,  184,  185,
			  186,  187,  188,  189,  190,  191,    0,    0,    0,   61,
			   62,   63,  100,    0,    0,    0,  193,    0,  195,  176,
			  177,    0,  104,  112,   86,  108,   53,   85,  102,  106,
			  110,    0,   91,   47,   49,    0,  264,   45,   60,   51,
			   59,   56,  114,    0,  242,    0,   40,  440,  439,  438,
			  437,   65,  458,  457,  456,  455,  454,  453,  452,  451,

			  450,  449,  448,  447,  446,  445,  444,  443,  442,  441,
			   64,  208,    0,  192,  183,  182,  192,    0,    0,  181,
			  180,  194,    0,  105,  113,   88,   87,    0,  109,   95,
			   93,    0,   94,  103,  106,  107,  110,  111,    0,   84,
			   92,  102,   48,    0,   43,   46,   52,   59,  116,   53,
			  125,   58,  461,    1,  101,  179,  178,  196,    0,    0,
			   96,   98,   53,   99,  110,    0,   83,  106,   50,   57,
			  121,  118,    0,    0,  117,   55,    0,   67,  170,  241,
			  461,    0,   89,   90,   97,    0,   82,  110,    0,    0,
			  115,  119,  126,   35,   66,  171,    0,  348,  376,  347,

			  381,    0,  381,    0,  271,    0,  402,  401,    0,    0,
			    0,    0,  343,    0,    0,  349,  307,  306,  403,  399,
			  309,  400,  353,  173,  376,    0,  352,  346,  345,  344,
			  350,    0,  351,  310,  404,   53,  308,   81,    0,  122,
			   53,   70,   69,   68,   71,  128,  270,    0,    0,    0,
			  359,    0,  383,  376,    0,  382,    0,    0,  192,  192,
			  192,  192,  192,  192,  192,  192,    0,    0,    0,    0,
			  335,  123,  334,  332,  333,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  175,  267,  374,  336,  272,    0,

			  172,   80,  120,  158,  371,  355,  376,  370,    0,    0,
			  377,  338,  379,    0,  354,  460,    0,    0,  269,    0,
			    0,    0,    0,    0,    0,    0,    0,  459,    0,  296,
			  311,  124,    0,  356,  318,  317,  316,  315,  314,  313,
			  312,  325,  327,  326,  328,  329,  330,    0,  319,  324,
			    0,  321,  323,  331,  174,    0,  266,  358,  160,  139,
			    0,  375,  376,  342,  341,    0,  339,  378,    0,  384,
			    0,  376,  376,  376,  376,  376,  376,  376,  376,  296,
			    0,  291,  268,    0,  337,  320,  322,  276,    0,  277,
			  274,    0,  162,  461,  116,    0,  372,  373,  361,    0,

			  380,    0,  362,  363,  364,  365,  366,  367,  368,  369,
			  290,  376,  357,  177,  192,  192,  192,  192,  192,  192,
			  192,  192,  273,    0,  461,  159,  140,  146,  134,  146,
			  131,  130,  129,  163,  340,  376,  297,  286,  184,  185,
			  186,  187,  188,  189,  190,  191,  275,  161,  138,  461,
			  135,    0,  137,  165,  253,  360,  278,  279,  280,  281,
			  282,  283,  284,  285,  147,  143,  461,  462,    0,  132,
			  133,  167,  461,  146,    0,  144,  252,    0,    0,    0,
			    0,  292,    0,  298,  150,  156,  148,  155,  376,  152,
			  153,  149,  146,  154,  304,  300,  299,  301,  302,  303,

			  157,  151,    0,  136,  461,  164,  254,  127,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  295,    0,
			  296,  294,  293,    0,    0,    0,    0,  145,    0,    0,
			  146,  247,  461,  166,  256,  258,    0,  288,    0,    0,
			  255,  257,  218,    0,  238,    0,  146,    0,    0,  296,
			    0,  220,  235,  219,  146,  461,  243,  248,  250,    0,
			    0,  305,  296,  287,  226,  227,  225,  223,    0,  146,
			    0,  221,  210,  239,    0,    0,  249,    0,  246,  289,
			    0,    0,    0,  146,    0,  236,  217,    0,  212,  215,
			  211,  245,  376,    0,  251,  232,  234,  233,  231,  230,

			  229,  228,  222,  224,    0,  146,    0,  213,    0,    0,
			  146,  216,  209,  244,  146,  214,    0,  237,    0,    0,
			    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  620,  315,  404,  481,  316,  584,   50,   51,  317,  318,
			  249,  319,  405,  320,  651,  321,  585,  130,  133,  294,
			  343,  111,  586,  322,  587,  688,  554,  229,  411,  489,
			  531,  550,  179,  134,  262,   91,  353,   12,  325,  589,
			   13,  590,  591,  565,  592,   56,  532,  667,  185,  593,
			  407,  326,  327,  328,  329,  330,  331,  490,  105,  106,
			  332,   57,  225,  459,  600,  601,  533,  344,  333,   95,
			  334,  569,   59,  278,  335,  336,  357,  277,  159,  103,
			  623,  160,  271,  675,   60,  652,  653,  112,  113,  689,
			  690,  168,  241,  230,  396,  413,  354,  355,  180,  135,

			  136,  148,  233,  234,  235,  236,  237,  238,  124,   89,
			   92,   93,  231,  175,  272,  432,    2,   14,  574,  548,
			  566,  706,  670,  668,  456,  491,  101,  107,  172,  226,
			  646,  659,  279,  280,  656,  138,  161,  250,  273,  274,
			  495,  149,   79,   80,   81,   82,   83,   84,   85,   86,
			  150,  151,  152,  181,  210,  191,  182,  602,  718,   18,
			   69,  177,  183,  403,  551,  549,  281,  493,  524,  572,
			  604,   96,  252>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  582, 1754,  -13, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  612, 1515, -32768,  748, -32768, -32768, -32768,  591, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  289,  224,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			    8, -32768,  905, -32768, -32768, -32768, -32768, 1632, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  605, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  609,  571,
			 -32768, -32768,  597,  604,  476,  570,  594, -32768,  609, -32768,

			  889,  595,  905,  600, -32768, -32768,  601,  905,  564, -32768,
			 1737, -32768,  566,  595, -32768,  564,  564,  564,  564,  564,
			  564,  564,  564, 1582, -32768, -32768, -32768,  425,   47,  358,
			 1582, 1746, -32768,  210, -32768,  556,  566, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  184, 1910,   75, -32768,
			 -32768, -32768, -32768,  905,  -18,  905, -32768,  217, -32768, -32768,
			 -32768,  188, 1582, 1582, 1582, 1582,   81, -32768,  473,  477,
			  465,  569,  565, -32768, -32768,   30,  525,  533, -32768, -32768,
			  174, -32768,  126, 1582, -32768,  548, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 1582,  564, -32768, -32768,  564,  581,  580, -32768,
			 -32768, -32768, 1619,  525,  525, -32768,  568,  553,  525, -32768,
			  533,   -2, -32768, -32768,  477, -32768,  465, -32768,  513, -32768,
			 -32768,  473, -32768,  896, -32768, -32768, -32768,  497,  896,  512,
			  528, -32768,  264, -32768, -32768, -32768, -32768, -32768, 1582, 1582,
			 -32768, -32768,  512,  525,  465,  499, -32768,  477, -32768, -32768,
			 -32768, -32768,  328,  517,  896, -32768, 1619,  480, -32768, -32768,
			   61, 1477, -32768, -32768, -32768,  496, -32768,  465,  896, 1619,
			 -32768, -32768, -32768, 1680, -32768, -32768,  422,  531,   16,  372,

			 1477,  321, 1477,  509, -32768, 1619, -32768, -32768, 1477, 1477,
			  526, 1477, -32768, 1477, 1477,  370, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, 2037,  218, 1477, -32768, -32768, -32768, -32768,
			 -32768,  896,  359, -32768, -32768,  512, -32768, -32768,  489, -32768,
			  512, -32768, -32768, -32768, -32768, -32768, -32768,  896,  905,  862,
			 -32768,  896, 2037,  149,  495,  502,  905,  437,  314,  309,
			  305,  301,  288,  286,  251,  230,  493, 1619,  488, 1960,
			 -32768,  896, -32768, -32768, -32768,  896, 1477, 1477, 1477, 1477,
			 1477, 1477, 1477, 1477, 1477, 1477, 1477, 1477, 1477, 1360,
			 1477, 1243, 1477, 1477, 1477, -32768, -32768, -32768,  494,  896,

			 -32768, -32768, -32768,  433,  413, -32768,  379, -32768,  470,  688,
			 -32768, 2037, -32768,  226, -32768, -32768, 1477,  468, -32768,  428,
			  427,  417,  412,  411,  407,  400,  395, -32768,  432,  180,
			   85,  436,  431, -32768,  247,  247,  247,  247,  247,  401,
			  401,  677,  677,  677,  677,  677,  677, 1477, 2082, 2068,
			 1477, 2053, 1941, -32768, 2037, 1009, -32768, -32768,  409,  389,
			  896, -32768,  379, -32768, -32768, 1477, -32768, -32768, 1126, 2037,
			  423,  379,  379,  379,  379,  379,  379,  379,  379,  180,
			  896, -32768, -32768,  896, -32768, 2082, 2053,  422,  321, -32768,
			 -32768,  175, -32768,  304,  896,  132,  413, -32768, -32768, 1919,

			 -32768,  350, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  379, -32768,  387,  314,  309,  305,  301,  288,  286,
			  251,  230, -32768, 1009,  304, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,  371, -32768,  379, -32768, -32768,  386,  377,
			  368,  366,  365,  363,  362,  360, -32768, -32768, -32768, 1803,
			  373,  711, -32768,  308,  312, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, 1920,  624,  711, -32768,
			 -32768, -32768,  -30, -32768,  335, -32768, -32768,   57,  372,  271,
			  466, 1619, 1477,  370, -32768, -32768, -32768, -32768,    7, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  359,

			 -32768, -32768,  418, -32768,  -30, -32768, -32768, -32768, 1477, 1477,
			  348,  346,  343,  340,  337,  336,  317,  303, -32768, 1619,
			  180, -32768, -32768,  338, 1901, 1477, 1477,  307, 1477, 1477,
			 -32768,  310,  264, -32768, 2037, 2037,  269, -32768,  827,  260,
			 2037, 2037, 1064, 1302,  204,  327, -32768,  255,  827,  180,
			   64, -32768,  209,  138, -32768,   90,  148, -32768, -32768,  139,
			  154, -32768,  180, -32768,  199,  162,  159, -32768,  -12, -32768,
			   82, -32768,   70, -32768, 1477,   56, -32768,  711, -32768, -32768,
			  155,   64,  217, -32768,   64, -32768, -32768, 1477, -32768,   58,
			   70, 2037,  196, 1477, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, 1184, -32768,   53, -32768, 1477, 1415,
			 -32768, -32768, -32768, 2037, -32768, -32768,   13, -32768,   74,   37,
			 -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -484,  182,  306, -463, -32768, -32768,  680,  452, -32768,    0,
			 -32768,   -3, -334, -32768,   72,  -10, -32768,  549, -32768, -32768,
			 -32768,  611, -32768, -32768, -32768,   33, -32768,  514,  237, -330,
			 -32768, -32768,  542,  584, -32768,  621,   -1, -32768,  316, -32768,
			  704, -32768, -32768,  151, -32768, -156, -32768,   22, -32768, -32768,
			  245,  145,  144,  143,  141,  140, -32768,  181,  596, -32768,
			  134, -32768,  442, -32768, -32768, -32768, -32768, -32768, -32768,  406,
			   -9, -32768, -529,  398, -32768, -32768, -109, -32768,  575, -32768,
			 -32768,  187,  402, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  500, -32768, -32768, -166, -32768,  364, -32768, -32768, -32768,

			 -32768,  -94,  536,  426,  535, -211,  534, -192, -32768, -32768,
			 -32768, -32768, -102, -32768,  285, -32768, -32768, -32768, -32768, -352,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -473, -32768, -32768,  221, -32768, -32768,  166, -32768,
			 -32768,  -57,  -64,  -72,  -75,  -78,  -81,  -92,  -95,  -98,
			 -32768, -32768, -158,  414, -32768, -32768, -32768, -32768, -32768, -32768,
			  -86, -32768, -32768, -32768, -32768,   66, -430, -32768, -32768, -32768,
			 -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   11,  220,   54,   58,  122,   78,  227,  121,  131,   53,
			  120,   55,   52,   11,  109,   10,  510,  414,  158,  412,
			  525,  119,  570,  264,  118,  251,  261,  117,  684,  122,
			  116,   77,  121,  349, -168,  120,  176,  720,  115,  603,
			  214,  433,  349,  108,  265,   68,  119,   17,   67,  118,
			  108,  547,  117,   16,  254,  116,  287,   54,   58,  626,
			 -168,  348,  625,  115,   53,  457,   55,   52,  223,  224,
			  243,  228,  285,  147,  719,  245,  242,  717,  218,  217,
			  232,   15,  347,  683,  146,   99,    9,    8,    7,    6,
			    5,    4,    3,   47,   46,  338,  213,   10,  216,  605,

			  227,  283,   76,   75,   74,   73,   72,   71,   70,  609,
			  483,  167,  608,  257,  166,  212,  658,  712,   68,  567,
			  705, -169, -169,  482,  122, -169,  129,  121,  174, -169,
			  120,  633,  350,  687,  165,  164,  567,  263,  500,  211,
			  163,  119, -169,  162,  118, -169,  686,  117,  694,  512,
			  116, -169,  248,  215,  649,  693,  219,  637,  115,  647,
			 -169, -169,  682,  275,  662,  681,  247,  292,    9,    8,
			    7,    6,    5,    4,    3,  349,  284,  552,  122,  677,
			  340,  121,  673,  676,  120,   46,  663,  395,   10, -168,
			 -168,  122,  530,  529,  121,  119,  368,  120,  118,  679,

			  528,  117,  680,  365,  116,  480,  364,  122,  119,  363,
			  121,  118,  115,  120,  117,  523,  527,  116,  678,  522,
			  362,  606,  349,  361,  119,  115,  360,  118,  222,  359,
			  117,  218,  217,  116,  395,  708,  221,  358,  -42,  650,
			  461,  115,  268,  -42,  349,  178,   47,  270,  674,  400,
			   10,  466,  -42,   66,  402,   65,  395,  394,  428,    9,
			    8,    7,    6,    5,    4,    3,  468,  376,  312,  122,
			  467,  669,  121,  270,  -41,  120,  426,  127,  644,  -41,
			  324,  178,  655,   54,   58,  483,  119,  339,  -41,  118,
			   53,  408,  117,   52,  660,  116,  498,  425,  127,  417,

			  190,  189,  672,  115,   77,  502,  503,  504,  505,  506,
			  507,  508,  509,  188,  187,  648,  356,  685,   64,  661,
			   63,    9,    8,    7,    6,    5,    4,    3, -168,  128,
			  398,  702,  424,  127,  423,  127,  645,  139,  140,  141,
			  142,  143,  144,  145,  564,  536,  406,  422,  127,  426,
			  406,  421,  127,  711,   77,  420,  127,  157,  715,   44,
			  419,  127,  716,  425, -168, -168,  356,  289,  288,  555,
			  270,  657, -168,  638,  406,   76,   75,   74,   73,   72,
			   71,   70,  424,  423,  399, -168,  422,  155, -168,  421,
			  521,   10,  420,  520,  419,  375,  519,  351,  406,  607,

			  568,  154,  573,  571,  173,  349,  563,  518,  562,  561,
			  517,  560,  559,  516,  558,  153,  515,  380,  379,  378,
			  377,  376,  312,  557,  514,   76,   75,   74,   73,   72,
			   71,   70,  556,  537,  255,  535,  553,  256,  460,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,   20,   77,  406,
			  346,  157,    9,    8,    7,    6,    5,    4,    3,  501,
			  494,  492,  622,  156,  632,  484,  288,  631,  479,  511,
			  478,  617,  406,  122,  616,  477,  121,  615,  630,  120,
			  629,  155,  476,  270,  666,  628,  475,  474,  614,   10,

			  119,  613,  473,  118,  612,  154,  117,  611,   44,  116,
			  636,  619,  472,  471,  470,  610,  462,  115,  323,  153,
			  455,  122,  458,  429,  121,  699,  701,  120,  666,   76,
			   75,   74,   73,   72,   71,   70,  427,  352,  119,  352,
			  418,  118,  416,  415,  117,  369,  370,  116,  372,   68,
			  373,  374,  371,  401,  367,  115,  347,  618,  163,  293,
			  337,  290,  397,  286,  165,  212,  588,  276,  178,  162,
			    9,    8,    7,    6,    5,    4,    3,  266,  129,  621,
			  139,  140,  141,  142,  143,  144,  145,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,

			   26,   25,   24,   23,   22,   21,   20,  259,  258,   66,
			   64,  127,  253,  434,  435,  436,  437,  438,  439,  440,
			  441,  442,  443,  444,  445,  446,  448,  449,  451,  452,
			  453,  454,  166,  239,  184,  132,  110,  621,  125,  393,
			  664,  123,   90,  102,   98,   97,  100,  621,   62,  665,
			  582,   19,   88,  469,   94,    1,  431,   10,  627,  581,
			  526,  269,  171,  170,  169,  580,  366,  267,  393,  579,
			  695,  697,  240,  692,  664,  513,  291,  114,  295,  696,
			  698,  700,  578,  665,  485,  393,  393,  486,  393,  393,
			  393,  382,  381,  380,  379,  378,  377,  376,  312,  345,

			  282,  599,  499,  126,  546,  497,  703,  598,  597,  298,
			  596,  595,  594,  393,  465,  577,  576,  575,   61,  104,
			  186,   77,  246,  707,  137,  671,  244,  393,    9,    8,
			    7,    6,    5,    4,    3,  538,  539,  540,  541,  542,
			  543,  544,  545,   44,  260,  342,  464,   87,    0,  583,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,  147,  393,  393,  496,  393,  393,  393,
			  393,    0,    0,    0,  146,    0,    0,    0,    0,  463,
			    0,   10,    0,    0,    0,  393,    0,    0,    0,    0,
			    0,    0,   76,   75,   74,   73,   72,   71,   70,    0,

			    0,  393,  393,    0,    0,  -19,    0,    0,  -19,    0,
			    0,    0,    0,    0,  -19,  393,    0,    0,    0,  624,
			    0,    0,    0,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   22,
			   21,   20,  -19,    0,    0,  634,  635,    0,    0,    0,
			    0,    0,    9,    8,    7,    6,    5,    4,    3,    0,
			   10,    0,  640,  641,    0,  642,  643,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  314,  313,    0,    0,
			    0,    0,    0,  312,  311,  310,  309,    0,  308,    0,
			    0,  307,   46,  306,   44,   10,   43,  305,    0,    0,

			  304,    0,    0,  303,  302,    0,  410,  301,    0,  300,
			    0,  691,   41,   40,    0,  409,    0,    0,  618,    0,
			  299,    0,   77,    0,  704,    0,   68,    0,    0,   10,
			  709,    9,    8,    7,    6,    5,    4,    3,   77,    0,
			  393,    0,    0,    0,    0,  713,    0,  298,    0,    0,
			  393,  393,    0,  297,    0,    0,  393,  393,  393,  393,
			    0,    0,    0,    0,  296,    0,    9,    8,    7,    6,
			    5,    4,    3,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   22,   21,   20,   76,   75,   74,   73,   72,   71,   70,

			    9,    8,    7,    6,    5,    4,    3,  393,    0,   76,
			   75,   74,   73,   72,   71,   70,    0,    0,    0,    0,
			  393,    0,    0,  314,  313,  393,    0,    0,    0,  393,
			  312,  311,  310,  309,    0,  308,    0,    0,  307,   46,
			  306,   44,   10,   43,  305,    0,    0,  304,    0,    0,
			  303,  302,    0,    0,  488,    0,  300,    0,    0,   41,
			   40,    0,  409,    0,    0,    0,    0,  299,  392,  391,
			  390,  389,  388,  387,  386,  385,  384,  383,  382,  381,
			  380,  379,  378,  377,  376,  312,    0,    0,    0,    0,
			    0,    0,    0,    0,  298,    0,    0,    0,    0,    0,

			  297,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  487,    0,    9,    8,    7,    6,    5,    4,    3,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   22,   21,   20,
			  314,  313,    0,    0,    0,    0,    0,  312,  311,  310,
			  309,    0,  308,    0,    0,  307,   46,  306,   44,   10,
			   43,  305,    0,    0,  304,  650,    0,  303,  302,    0,
			    0,  301,    0,  300,    0,    0,   41,   40,    0,  409,
			    0,    0,    0,    0,  299,    0,    0,    0,  392,  391,
			  390,  389,  388,  387,  386,  385,  384,  383,  382,  381,

			  380,  379,  378,  377,  376,  312,    0,    0,    0,    0,
			    0,  298,    0,    0,    0,    0,    0,  297,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  296,    0,
			    9,    8,    7,    6,    5,    4,    3,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   22,   21,   20,  314,  313,    0,
			    0,    0,    0,    0,  312,  311,  310,  309,    0,  308,
			    0,    0,  307,   46,  306,   44,   10,   43,  305,  710,
			    0,  304,    0,    0,  303,  302,    0,    0,  301,    0,
			  300,    0,    0,   41,   40,    0,    0,    0,    0,    0,

			    0,  299,    0,    0,    0,  450,  392,  391,  390,  389,
			  388,  387,  386,  385,  384,  383,  382,  381,  380,  379,
			  378,  377,  376,  312,    0,    0,    0,    0,  298,    0,
			    0,    0,    0,    0,  297,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  296,    0,    9,    8,    7,
			    6,    5,    4,    3,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,   20,  314,  313,    0,    0,    0,    0,
			    0,  312,  311,  310,  309,    0,  308,    0,    0,  307,
			   46,  306,   44,   10,   43,  305,    0,  654,  304,    0,

			    0,  303,  302,    0,    0,  301,    0,  300,    0,    0,
			   41,   40,    0,    0,    0,    0,    0,    0,  299,  392,
			  391,  390,  389,  388,  387,  386,  385,  384,  383,  382,
			  381,  380,  379,  378,  377,  376,  312,    0,    0,    0,
			    0,    0,    0,    0,    0,  298,    0,    0,    0,    0,
			    0,  297,    0,    0,    0,  447,    0,    0,    0,    0,
			    0,    0,  296,    0,    9,    8,    7,    6,    5,    4,
			    3,   39,   38,   37,   36,   35,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,
			   20,  314,  313,    0,    0,    0,    0,  714,  312,  311,

			  310,  309,    0,  308,    0,    0,  307,   46,  306,   44,
			   10,   43,  305,    0,    0,  304,    0,    0,  303,  302,
			    0,    0,  301,    0,  300,    0,    0,   41,   40,   49,
			   48,    0,    0,    0,    0,  299,    0,    0,    0,    0,
			    0,    0,    0,    0,   47,   46,   45,   44,   10,   43,
			    0,    0,   42,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  298,    0,    0,   41,   40,    0,  297,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  296,
			    0,    9,    8,    7,    6,    5,    4,    3,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,

			   27,   26,   25,   24,   23,   22,   21,   20,    0,    0,
			    0,    0,    0,    0,    0,   77,    0,    0,    0,    9,
			    8,    7,    6,    5,    4,    3,   39,   38,   37,   36,
			   35,   34,   33,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,   22,   21,   20,   49,   48,    0,    0,
			    0,    0,   77,    0,    0,  157,    0,  147,    0,    0,
			    0,   47,   46,   45,   44,   10,   43,    0,  146,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   41,   40,    0,  155,   76,   75,   74,   73,
			   72,   71,   70,    0,   49,   48,    0,    0,    0,  154,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,   47,
			   46,   45,   44,  153,   43,    0,    0,    0,    0,    0,
			    0,    0,    0,   76,   75,   74,   73,   72,   71,   70,
			   41,   40,    0,    0,    0,    0,    9,    8,    7,    6,
			    5,    4,    3,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   22,   21,   20,   94,    0,    0,    0,    0,    0,    0,
			  -45,    0,    0,    0,    0,    0,    0,    0,  341,  -46,
			    0,    0,  129,    0,    0,    0,    0,   10,    0,    0,
			    0,   39,   38,   37,   36,   35,   34,   33,   32,   31,

			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,
			   20,  -20,  -45,    0,  -20,    0,    0,    0,    0,    0,
			  -20,  -46,    0,  -45,    0,    0,    0,    0,    0,    0,
			    0,    0,  -46,    0,    0,    0,    0,    0,    0,    0,
			  564,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -20,    0,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,    0,    9,    8,
			    7,    6,    5,    4,    3, -141, -141, -141, -141,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0, -141,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0, -141,    0,    0,    0,    0,    0,    0,

			    0,    0, -141, -141, -141,  392,  391,  390,  389,  388,
			  387,  386,  385,  384,  383,  382,  381,  380,  379,  378,
			  377,  376,  312,  392,  391,  390,  389,  388,  387,  386,
			  385,  384,  383,  382,  381,  380,  379,  378,  377,  376,
			  312,    0,    0,    0,    0,  639,  391,  390,  389,  388,
			  387,  386,  385,  384,  383,  382,  381,  380,  379,  378,
			  377,  376,  312,  534,  392,  391,  390,  389,  388,  387,
			  386,  385,  384,  383,  382,  381,  380,  379,  378,  377,
			  376,  312, -142, -142, -142, -142,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0, -142,    0,

			    0,    0,    0,    0,  430,    0,    0,    0,    0,    0,
			 -142,    0,    0,    0,    0,    0,    0,    0,    0, -142,
			 -142, -142,  209,  208,  207,  206,  205,  204,  203,  202,
			  201,  200,  199,  198,  197,  196,  195,  194,  193,    0,
			  192,  392,  391,  390,  389,  388,  387,  386,  385,  384,
			  383,  382,  381,  380,  379,  378,  377,  376,  312,  390,
			  389,  388,  387,  386,  385,  384,  383,  382,  381,  380,
			  379,  378,  377,  376,  312,  389,  388,  387,  386,  385,
			  384,  383,  382,  381,  380,  379,  378,  377,  376,  312,
			  388,  387,  386,  385,  384,  383,  382,  381,  380,  379,

			  378,  377,  376,  312>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,  157,   12,   12,  102,   62,  164,  102,  110,   12,
			  102,   12,   12,   14,  100,   33,  479,  351,  127,  349,
			  493,  102,  551,  234,  102,  183,   28,  102,   40,  127,
			  102,   33,  127,   26,   64,  127,  130,    0,  102,  568,
			   58,  375,   26,  100,  236,   37,  127,   60,   40,  127,
			  107,  524,  127,   66,  212,  127,  267,   67,   67,   52,
			   90,   45,   55,  127,   67,  399,   67,   67,  162,  163,
			   40,  165,  264,   75,    0,  177,   46,   64,   14,   15,
			  166,   94,   25,   95,   86,   94,  104,  105,  106,  107,
			  108,  109,  110,   29,   30,  287,  153,   33,  155,  572,

			  258,  259,  104,  105,  106,  107,  108,  109,  110,   52,
			   25,   64,   55,  222,   67,   40,  645,   64,   37,  549,
			   62,   60,   61,   38,  222,   64,   45,  222,  129,   68,
			  222,  604,  298,   63,   87,   88,  566,  231,  468,   64,
			   93,  222,   81,   96,  222,   84,   64,  222,  677,  483,
			  222,   90,   26,  154,  638,   99,  157,  620,  222,  632,
			   99,  100,    3,  249,  648,    3,   40,  276,  104,  105,
			  106,  107,  108,  109,  110,   26,  262,  529,  276,   40,
			  289,  276,  655,   44,  276,   30,  649,   38,   33,   99,
			  100,  289,   60,   61,  289,  276,  305,  289,  276,  662,

			   68,  276,    3,  301,  276,   25,  301,  305,  289,  301,
			  305,  289,  276,  305,  289,   40,   84,  289,   64,   44,
			  301,  573,   26,  301,  305,  289,  301,  305,   40,  301,
			  305,   14,   15,  305,   38,   39,   48,  301,   64,  101,
			  406,  305,  243,   69,   26,   71,   29,  248,  100,  335,
			   33,  409,   78,   29,  340,   31,   38,   39,  367,  104,
			  105,  106,  107,  108,  109,  110,   40,   20,   21,  367,
			   44,   62,  367,  274,   64,  367,   46,   47,  630,   69,
			  281,   71,   78,  293,  293,   25,  367,  288,   78,  367,
			  293,  348,  367,  293,  646,  367,  462,   46,   47,  356,

			  116,  117,  654,  367,   33,  471,  472,  473,  474,  475,
			  476,  477,  478,  129,  130,   46,   45,  669,   29,   64,
			   31,  104,  105,  106,  107,  108,  109,  110,   64,  108,
			  331,  683,   46,   47,   46,   47,   26,  116,  117,  118,
			  119,  120,  121,  122,   37,  511,  347,   46,   47,   46,
			  351,   46,   47,  705,   33,   46,   47,   36,  710,   32,
			   46,   47,  714,   46,   60,   61,   45,   39,   40,  535,
			  371,   44,   68,   35,  375,  104,  105,  106,  107,  108,
			  109,  110,   46,   46,   25,   81,   46,   66,   84,   46,
			  488,   33,   46,  488,   46,   25,  488,   25,  399,   64,

			   27,   80,   90,   95,   46,   26,   46,  488,   46,   46,
			  488,   46,   46,  488,   46,   94,  488,   16,   17,   18,
			   19,   20,   21,   46,  488,  104,  105,  106,  107,  108,
			  109,  110,   46,   46,  213,   85,   65,  216,   25,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,   33,  460,
			   38,   36,  104,  105,  106,  107,  108,  109,  110,   46,
			   81,   62,  581,   48,   56,   44,   40,   59,   46,  480,
			   85,  579,  483,  581,  579,   85,  581,  579,   70,  581,
			   72,   66,   85,  494,  650,   77,   85,   85,  579,   33,

			  581,  579,   85,  581,  579,   80,  581,  579,   32,  581,
			  619,   45,   85,   85,   46,  579,   46,  581,  281,   94,
			   26,  619,   89,   35,  619,  681,  682,  619,  684,  104,
			  105,  106,  107,  108,  109,  110,   43,  300,  619,  302,
			  103,  619,   40,   48,  619,  308,  309,  619,  311,   37,
			  313,  314,   26,   64,   45,  619,   25,   91,   93,   79,
			   64,   44,  325,   64,   87,   40,  567,   39,   71,   96,
			  104,  105,  106,  107,  108,  109,  110,   64,   45,  580,
			  359,  360,  361,  362,  363,  364,  365,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,

			  124,  125,  126,  127,  128,  129,  130,   54,   40,   29,
			   29,   47,   64,  376,  377,  378,  379,  380,  381,  382,
			  383,  384,  385,  386,  387,  388,  389,  390,  391,  392,
			  393,  394,   67,   64,   78,   69,   41,  638,   37,  323,
			  650,   41,   33,   49,   40,   48,   76,  648,   57,  650,
			   26,   39,   47,  416,   83,   73,  371,   33,  592,   35,
			  494,  247,  128,  128,  128,   41,  302,  241,  352,   45,
			  680,  681,  172,  674,  684,  488,  274,  102,  280,  680,
			  681,  682,   58,  684,  447,  369,  370,  450,  372,  373,
			  374,   14,   15,   16,   17,   18,   19,   20,   21,  293,

			  258,  567,  465,  107,  523,  460,  684,  567,  567,   85,
			  567,  567,  567,  397,   26,   91,   92,  566,   14,   98,
			  136,   33,  180,  690,  113,  653,  177,  411,  104,  105,
			  106,  107,  108,  109,  110,  514,  515,  516,  517,  518,
			  519,  520,  521,   32,  230,  293,   58,   67,    0,  567,
			  434,  435,  436,  437,  438,  439,  440,  441,  442,  443,
			  444,  445,  446,   75,  448,  449,  460,  451,  452,  453,
			  454,    0,    0,    0,   86,    0,    0,    0,    0,   91,
			    0,   33,    0,    0,    0,  469,    0,    0,    0,    0,
			    0,    0,  104,  105,  106,  107,  108,  109,  110,    0,

			    0,  485,  486,    0,    0,   57,    0,    0,   60,    0,
			    0,    0,    0,    0,   66,  499,    0,    0,    0,  582,
			    0,    0,    0,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,   94,    0,    0,  608,  609,    0,    0,    0,
			    0,    0,  104,  105,  106,  107,  108,  109,  110,    0,
			   33,    0,  625,  626,    0,  628,  629,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   14,   15,    0,    0,
			    0,    0,    0,   21,   22,   23,   24,    0,   26,    0,
			    0,   29,   30,   31,   32,   33,   34,   35,    0,    0,

			   38,    0,    0,   41,   42,    0,   44,   45,    0,   47,
			    0,  674,   50,   51,    0,   53,    0,    0,   91,    0,
			   58,    0,   33,    0,  687,    0,   37,    0,    0,   33,
			  693,  104,  105,  106,  107,  108,  109,  110,   33,    0,
			  624,    0,    0,    0,    0,  708,    0,   85,    0,    0,
			  634,  635,    0,   91,    0,    0,  640,  641,  642,  643,
			    0,    0,    0,    0,  102,    0,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,  104,  105,  106,  107,  108,  109,  110,

			  104,  105,  106,  107,  108,  109,  110,  691,    0,  104,
			  105,  106,  107,  108,  109,  110,    0,    0,    0,    0,
			  704,    0,    0,   14,   15,  709,    0,    0,    0,  713,
			   21,   22,   23,   24,    0,   26,    0,    0,   29,   30,
			   31,   32,   33,   34,   35,    0,    0,   38,    0,    0,
			   41,   42,    0,    0,   45,    0,   47,    0,    0,   50,
			   51,    0,   53,    0,    0,    0,    0,   58,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,    0,    0,    0,    0,
			    0,    0,    0,    0,   85,    0,    0,    0,    0,    0,

			   91,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  102,    0,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			   14,   15,    0,    0,    0,    0,    0,   21,   22,   23,
			   24,    0,   26,    0,    0,   29,   30,   31,   32,   33,
			   34,   35,    0,    0,   38,  101,    0,   41,   42,    0,
			    0,   45,    0,   47,    0,    0,   50,   51,    0,   53,
			    0,    0,    0,    0,   58,    0,    0,    0,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,

			   16,   17,   18,   19,   20,   21,    0,    0,    0,    0,
			    0,   85,    0,    0,    0,    0,    0,   91,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  102,    0,
			  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,   14,   15,    0,
			    0,    0,    0,    0,   21,   22,   23,   24,    0,   26,
			    0,    0,   29,   30,   31,   32,   33,   34,   35,   95,
			    0,   38,    0,    0,   41,   42,    0,    0,   45,    0,
			   47,    0,    0,   50,   51,    0,    0,    0,    0,    0,

			    0,   58,    0,    0,    0,   62,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,    0,    0,    0,    0,   85,    0,
			    0,    0,    0,    0,   91,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  102,    0,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,   14,   15,    0,    0,    0,    0,
			    0,   21,   22,   23,   24,    0,   26,    0,    0,   29,
			   30,   31,   32,   33,   34,   35,    0,   95,   38,    0,

			    0,   41,   42,    0,    0,   45,    0,   47,    0,    0,
			   50,   51,    0,    0,    0,    0,    0,    0,   58,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,    0,    0,    0,
			    0,    0,    0,    0,    0,   85,    0,    0,    0,    0,
			    0,   91,    0,    0,    0,   95,    0,    0,    0,    0,
			    0,    0,  102,    0,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,   14,   15,    0,    0,    0,    0,   82,   21,   22,

			   23,   24,    0,   26,    0,    0,   29,   30,   31,   32,
			   33,   34,   35,    0,    0,   38,    0,    0,   41,   42,
			    0,    0,   45,    0,   47,    0,    0,   50,   51,   14,
			   15,    0,    0,    0,    0,   58,    0,    0,    0,    0,
			    0,    0,    0,    0,   29,   30,   31,   32,   33,   34,
			    0,    0,   37,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   85,    0,    0,   50,   51,    0,   91,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  102,
			    0,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,

			  123,  124,  125,  126,  127,  128,  129,  130,    0,    0,
			    0,    0,    0,    0,    0,   33,    0,    0,    0,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,   14,   15,    0,    0,
			    0,    0,   33,    0,    0,   36,    0,   75,    0,    0,
			    0,   29,   30,   31,   32,   33,   34,    0,   86,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   50,   51,    0,   66,  104,  105,  106,  107,
			  108,  109,  110,    0,   14,   15,    0,    0,    0,   80,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,   29,
			   30,   31,   32,   94,   34,    0,    0,    0,    0,    0,
			    0,    0,    0,  104,  105,  106,  107,  108,  109,  110,
			   50,   51,    0,    0,    0,    0,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,   83,    0,    0,    0,    0,    0,    0,
			   33,    0,    0,    0,    0,    0,    0,    0,   98,   33,
			    0,    0,   45,    0,    0,    0,    0,   33,    0,    0,
			    0,  111,  112,  113,  114,  115,  116,  117,  118,  119,

			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,   57,   75,    0,   60,    0,    0,    0,    0,    0,
			   66,   75,    0,   86,    0,    0,    0,    0,    0,    0,
			    0,    0,   86,    0,    0,    0,    0,    0,    0,    0,
			   37,  104,  105,  106,  107,  108,  109,  110,   94,    0,
			  104,  105,  106,  107,  108,  109,  110,    0,  104,  105,
			  106,  107,  108,  109,  110,   62,   63,   64,   65,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   78,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   90,    0,    0,    0,    0,    0,    0,

			    0,    0,   99,  100,  101,    4,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,    0,    0,    0,    0,   44,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   44,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   62,   63,   64,   65,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   78,    0,

			    0,    0,    0,    0,   44,    0,    0,    0,    0,    0,
			   90,    0,    0,    0,    0,    0,    0,    0,    0,   99,
			  100,  101,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,    0,
			  130,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,

			   18,   19,   20,   21>>)
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

	yytype46 (v: ANY): REAL_AS is
		require
			valid_type: yyis_type46 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type46 (v: ANY): BOOLEAN is
		local
			u: REAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype47 (v: ANY): RENAME_AS is
		require
			valid_type: yyis_type47 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type47 (v: ANY): BOOLEAN is
		local
			u: RENAME_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype48 (v: ANY): REQUIRE_AS is
		require
			valid_type: yyis_type48 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type48 (v: ANY): BOOLEAN is
		local
			u: REQUIRE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype49 (v: ANY): RETRY_AS is
		require
			valid_type: yyis_type49 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type49 (v: ANY): BOOLEAN is
		local
			u: RETRY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype50 (v: ANY): REVERSE_AS is
		require
			valid_type: yyis_type50 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type50 (v: ANY): BOOLEAN is
		local
			u: REVERSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype51 (v: ANY): ROUT_BODY_AS is
		require
			valid_type: yyis_type51 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type51 (v: ANY): BOOLEAN is
		local
			u: ROUT_BODY_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype52 (v: ANY): ROUTINE_AS is
		require
			valid_type: yyis_type52 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type52 (v: ANY): BOOLEAN is
		local
			u: ROUTINE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype53 (v: ANY): ROUTINE_CREATION_AS is
		require
			valid_type: yyis_type53 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type53 (v: ANY): BOOLEAN is
		local
			u: ROUTINE_CREATION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype54 (v: ANY): STRING_AS is
		require
			valid_type: yyis_type54 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type54 (v: ANY): BOOLEAN is
		local
			u: STRING_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype55 (v: ANY): TAGGED_AS is
		require
			valid_type: yyis_type55 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type55 (v: ANY): BOOLEAN is
		local
			u: TAGGED_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype56 (v: ANY): TUPLE_AS is
		require
			valid_type: yyis_type56 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type56 (v: ANY): BOOLEAN is
		local
			u: TUPLE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype57 (v: ANY): TYPE is
		require
			valid_type: yyis_type57 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type57 (v: ANY): BOOLEAN is
		local
			u: TYPE
		do
			u ?= v
			Result := (u = v)
		end

	yytype58 (v: ANY): TYPE_DEC_AS is
		require
			valid_type: yyis_type58 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type58 (v: ANY): BOOLEAN is
		local
			u: TYPE_DEC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype59 (v: ANY): VARIANT_AS is
		require
			valid_type: yyis_type59 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type59 (v: ANY): BOOLEAN is
		local
			u: VARIANT_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype60 (v: ANY): EIFFEL_LIST [ATOMIC_AS] is
		require
			valid_type: yyis_type60 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type60 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ATOMIC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype61 (v: ANY): EIFFEL_LIST [CASE_AS] is
		require
			valid_type: yyis_type61 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type61 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CASE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype62 (v: ANY): EIFFEL_LIST [CREATE_AS] is
		require
			valid_type: yyis_type62 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type62 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [CREATE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype63 (v: ANY): EIFFEL_LIST [ELSIF_AS] is
		require
			valid_type: yyis_type63 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type63 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ELSIF_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype64 (v: ANY): EIFFEL_LIST [EXPORT_ITEM_AS] is
		require
			valid_type: yyis_type64 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type64 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype65 (v: ANY): EIFFEL_LIST [EXPR_AS] is
		require
			valid_type: yyis_type65 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type65 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXPR_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype66 (v: ANY): EIFFEL_LIST [FEATURE_AS] is
		require
			valid_type: yyis_type66 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type66 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype67 (v: ANY): EIFFEL_LIST [FEATURE_CLAUSE_AS] is
		require
			valid_type: yyis_type67 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type67 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype68 (v: ANY): FEATURE_NAME is
		require
			valid_type: yyis_type68 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type68 (v: ANY): BOOLEAN is
		local
			u: FEATURE_NAME
		do
			u ?= v
			Result := (u = v)
		end

	yytype69 (v: ANY): EIFFEL_LIST [FEATURE_NAME] is
		require
			valid_type: yyis_type69 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type69 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FEATURE_NAME]
		do
			u ?= v
			Result := (u = v)
		end

	yytype70 (v: ANY): EIFFEL_LIST [FORMAL_DEC_AS] is
		require
			valid_type: yyis_type70 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type70 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [FORMAL_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype71 (v: ANY): EIFFEL_LIST [ID_AS] is
		require
			valid_type: yyis_type71 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type71 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ID_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype72 (v: ANY): EIFFEL_LIST [INDEX_AS] is
		require
			valid_type: yyis_type72 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type72 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INDEX_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype73 (v: ANY): EIFFEL_LIST [INSTRUCTION_AS] is
		require
			valid_type: yyis_type73 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type73 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INSTRUCTION_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype74 (v: ANY): EIFFEL_LIST [INTERVAL_AS] is
		require
			valid_type: yyis_type74 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type74 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INTERVAL_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype75 (v: ANY): EIFFEL_LIST [OPERAND_AS] is
		require
			valid_type: yyis_type75 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type75 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [OPERAND_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype76 (v: ANY): EIFFEL_LIST [PARENT_AS] is
		require
			valid_type: yyis_type76 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type76 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [PARENT_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype77 (v: ANY): EIFFEL_LIST [RENAME_AS] is
		require
			valid_type: yyis_type77 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type77 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [RENAME_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype78 (v: ANY): EIFFEL_LIST [STRING_AS] is
		require
			valid_type: yyis_type78 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type78 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [STRING_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype79 (v: ANY): EIFFEL_LIST [TAGGED_AS] is
		require
			valid_type: yyis_type79 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type79 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TAGGED_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype80 (v: ANY): EIFFEL_LIST [TYPE] is
		require
			valid_type: yyis_type80 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type80 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE]
		do
			u ?= v
			Result := (u = v)
		end

	yytype81 (v: ANY): EIFFEL_LIST [TYPE_DEC_AS] is
		require
			valid_type: yyis_type81 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type81 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype82 (v: ANY): CLICK_AST is
		require
			valid_type: yyis_type82 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type82 (v: ANY): BOOLEAN is
		local
			u: CLICK_AST
		do
			u ?= v
			Result := (u = v)
		end

	yytype83 (v: ANY): PAIR [ID_AS, CLICK_AST] is
		require
			valid_type: yyis_type83 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type83 (v: ANY): BOOLEAN is
		local
			u: PAIR [ID_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype84 (v: ANY): PAIR [FEATURE_NAME, CLICK_AST] is
		require
			valid_type: yyis_type84 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type84 (v: ANY): BOOLEAN is
		local
			u: PAIR [FEATURE_NAME, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype85 (v: ANY): PAIR [STRING_AS, CLICK_AST] is
		require
			valid_type: yyis_type85 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type85 (v: ANY): BOOLEAN is
		local
			u: PAIR [STRING_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype86 (v: ANY): PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST] is
		require
			valid_type: yyis_type86 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type86 (v: ANY): BOOLEAN is
		local
			u: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype87 (v: ANY): TOKEN_LOCATION is
		require
			valid_type: yyis_type87 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type87 (v: ANY): BOOLEAN is
		local
			u: TOKEN_LOCATION
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 720
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 131
			-- Number of tokens

	yyLast: INTEGER is 2103
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 384
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 304
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



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
