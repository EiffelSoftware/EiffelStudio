indexing

	description: "Eiffel parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_PARSER

inherit

	EIFFEL_PARSER_SKELETON

	SHARED_NAMES_HEAP

creation

	make, make_il_parser


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
--|#line 176
	yy_do_action_1
when 2 then
--|#line 218
	yy_do_action_2
when 3 then
--|#line 227
	yy_do_action_3
when 4 then
--|#line 229
	yy_do_action_4
when 5 then
--|#line 231
	yy_do_action_5
when 6 then
--|#line 233
	yy_do_action_6
when 7 then
--|#line 235
	yy_do_action_7
when 8 then
--|#line 237
	yy_do_action_8
when 9 then
--|#line 239
	yy_do_action_9
when 10 then
--|#line 241
	yy_do_action_10
when 11 then
--|#line 243
	yy_do_action_11
when 12 then
--|#line 245
	yy_do_action_12
when 13 then
--|#line 247
	yy_do_action_13
when 14 then
--|#line 249
	yy_do_action_14
when 15 then
--|#line 253
	yy_do_action_15
when 16 then
--|#line 257
	yy_do_action_16
when 17 then
--|#line 261
	yy_do_action_17
when 18 then
--|#line 265
	yy_do_action_18
when 19 then
--|#line 269
	yy_do_action_19
when 20 then
--|#line 273
	yy_do_action_20
when 21 then
--|#line 277
	yy_do_action_21
when 22 then
--|#line 281
	yy_do_action_22
when 23 then
--|#line 285
	yy_do_action_23
when 24 then
--|#line 289
	yy_do_action_24
when 25 then
--|#line 293
	yy_do_action_25
when 26 then
--|#line 297
	yy_do_action_26
when 28 then
--|#line 307
	yy_do_action_28
when 31 then
--|#line 315
	yy_do_action_31
when 32 then
--|#line 317
	yy_do_action_32
when 34 then
--|#line 323
	yy_do_action_34
when 35 then
--|#line 325
	yy_do_action_35
when 36 then
--|#line 329
	yy_do_action_36
when 37 then
--|#line 334
	yy_do_action_37
when 38 then
--|#line 341
	yy_do_action_38
when 39 then
--|#line 345
	yy_do_action_39
when 41 then
--|#line 351
	yy_do_action_41
when 42 then
--|#line 356
	yy_do_action_42
when 43 then
--|#line 361
	yy_do_action_43
when 44 then
--|#line 368
	yy_do_action_44
when 45 then
--|#line 370
	yy_do_action_45
when 46 then
--|#line 372
	yy_do_action_46
when 47 then
--|#line 382
	yy_do_action_47
when 48 then
--|#line 388
	yy_do_action_48
when 49 then
--|#line 395
	yy_do_action_49
when 50 then
--|#line 401
	yy_do_action_50
when 51 then
--|#line 409
	yy_do_action_51
when 52 then
--|#line 413
	yy_do_action_52
when 53 then
--|#line 424
	yy_do_action_53
when 54 then
--|#line 428
	yy_do_action_54
when 56 then
--|#line 445
	yy_do_action_56
when 58 then
--|#line 454
	yy_do_action_58
when 59 then
--|#line 463
	yy_do_action_59
when 60 then
--|#line 468
	yy_do_action_60
when 61 then
--|#line 475
	yy_do_action_61
when 62 then
--|#line 477
	yy_do_action_62
when 63 then
--|#line 481
	yy_do_action_63
when 64 then
--|#line 481
	yy_do_action_64
when 66 then
--|#line 492
	yy_do_action_66
when 67 then
--|#line 496
	yy_do_action_67
when 68 then
--|#line 501
	yy_do_action_68
when 69 then
--|#line 505
	yy_do_action_69
when 70 then
--|#line 511
	yy_do_action_70
when 71 then
--|#line 519
	yy_do_action_71
when 72 then
--|#line 524
	yy_do_action_72
when 75 then
--|#line 535
	yy_do_action_75
when 76 then
--|#line 548
	yy_do_action_76
when 77 then
--|#line 550
	yy_do_action_77
when 78 then
--|#line 557
	yy_do_action_78
when 79 then
--|#line 561
	yy_do_action_79
when 80 then
--|#line 563
	yy_do_action_80
when 81 then
--|#line 567
	yy_do_action_81
when 82 then
--|#line 569
	yy_do_action_82
when 83 then
--|#line 571
	yy_do_action_83
when 84 then
--|#line 575
	yy_do_action_84
when 85 then
--|#line 580
	yy_do_action_85
when 86 then
--|#line 584
	yy_do_action_86
when 87 then
--|#line 588
	yy_do_action_87
when 88 then
--|#line 590
	yy_do_action_88
when 89 then
--|#line 594
	yy_do_action_89
when 90 then
--|#line 599
	yy_do_action_90
when 91 then
--|#line 604
	yy_do_action_91
when 93 then
--|#line 617
	yy_do_action_93
when 94 then
--|#line 619
	yy_do_action_94
when 95 then
--|#line 623
	yy_do_action_95
when 96 then
--|#line 628
	yy_do_action_96
when 97 then
--|#line 635
	yy_do_action_97
when 98 then
--|#line 640
	yy_do_action_98
when 99 then
--|#line 648
	yy_do_action_99
when 100 then
--|#line 653
	yy_do_action_100
when 101 then
--|#line 658
	yy_do_action_101
when 102 then
--|#line 663
	yy_do_action_102
when 103 then
--|#line 668
	yy_do_action_103
when 104 then
--|#line 673
	yy_do_action_104
when 105 then
--|#line 678
	yy_do_action_105
when 107 then
--|#line 688
	yy_do_action_107
when 108 then
--|#line 692
	yy_do_action_108
when 109 then
--|#line 697
	yy_do_action_109
when 110 then
--|#line 704
	yy_do_action_110
when 112 then
--|#line 710
	yy_do_action_112
when 113 then
--|#line 714
	yy_do_action_113
when 115 then
--|#line 720
	yy_do_action_115
when 116 then
--|#line 725
	yy_do_action_116
when 117 then
--|#line 732
	yy_do_action_117
when 118 then
--|#line 736
	yy_do_action_118
when 119 then
--|#line 738
	yy_do_action_119
when 120 then
--|#line 742
	yy_do_action_120
when 121 then
--|#line 747
	yy_do_action_121
when 123 then
--|#line 756
	yy_do_action_123
when 125 then
--|#line 762
	yy_do_action_125
when 127 then
--|#line 768
	yy_do_action_127
when 129 then
--|#line 774
	yy_do_action_129
when 131 then
--|#line 780
	yy_do_action_131
when 133 then
--|#line 786
	yy_do_action_133
when 135 then
--|#line 796
	yy_do_action_135
when 137 then
--|#line 802
	yy_do_action_137
when 138 then
--|#line 806
	yy_do_action_138
when 139 then
--|#line 811
	yy_do_action_139
when 140 then
--|#line 818
	yy_do_action_140
when 142 then
--|#line 823
	yy_do_action_142
when 144 then
--|#line 834
	yy_do_action_144
when 145 then
--|#line 838
	yy_do_action_145
when 146 then
--|#line 843
	yy_do_action_146
when 147 then
--|#line 850
	yy_do_action_147
when 148 then
--|#line 854
	yy_do_action_148
when 149 then
--|#line 860
	yy_do_action_149
when 150 then
--|#line 868
	yy_do_action_150
when 151 then
--|#line 870
	yy_do_action_151
when 153 then
--|#line 876
	yy_do_action_153
when 154 then
--|#line 880
	yy_do_action_154
when 155 then
--|#line 880
	yy_do_action_155
when 156 then
--|#line 892
	yy_do_action_156
when 157 then
--|#line 894
	yy_do_action_157
when 158 then
--|#line 896
	yy_do_action_158
when 159 then
--|#line 900
	yy_do_action_159
when 160 then
--|#line 904
	yy_do_action_160
when 161 then
--|#line 904
	yy_do_action_161
when 163 then
--|#line 912
	yy_do_action_163
when 164 then
--|#line 916
	yy_do_action_164
when 165 then
--|#line 918
	yy_do_action_165
when 167 then
--|#line 924
	yy_do_action_167
when 169 then
--|#line 930
	yy_do_action_169
when 170 then
--|#line 934
	yy_do_action_170
when 171 then
--|#line 939
	yy_do_action_171
when 172 then
--|#line 946
	yy_do_action_172
when 175 then
--|#line 954
	yy_do_action_175
when 176 then
--|#line 956
	yy_do_action_176
when 177 then
--|#line 958
	yy_do_action_177
when 178 then
--|#line 960
	yy_do_action_178
when 179 then
--|#line 962
	yy_do_action_179
when 180 then
--|#line 964
	yy_do_action_180
when 181 then
--|#line 966
	yy_do_action_181
when 182 then
--|#line 968
	yy_do_action_182
when 183 then
--|#line 970
	yy_do_action_183
when 184 then
--|#line 972
	yy_do_action_184
when 186 then
--|#line 978
	yy_do_action_186
when 187 then
--|#line 978
	yy_do_action_187
when 188 then
--|#line 985
	yy_do_action_188
when 189 then
--|#line 985
	yy_do_action_189
when 191 then
--|#line 996
	yy_do_action_191
when 192 then
--|#line 996
	yy_do_action_192
when 193 then
--|#line 1003
	yy_do_action_193
when 194 then
--|#line 1003
	yy_do_action_194
when 196 then
--|#line 1014
	yy_do_action_196
when 197 then
--|#line 1023
	yy_do_action_197
when 198 then
--|#line 1028
	yy_do_action_198
when 199 then
--|#line 1035
	yy_do_action_199
when 200 then
--|#line 1039
	yy_do_action_200
when 201 then
--|#line 1041
	yy_do_action_201
when 203 then
--|#line 1051
	yy_do_action_203
when 204 then
--|#line 1053
	yy_do_action_204
when 205 then
--|#line 1057
	yy_do_action_205
when 206 then
--|#line 1059
	yy_do_action_206
when 207 then
--|#line 1061
	yy_do_action_207
when 208 then
--|#line 1063
	yy_do_action_208
when 209 then
--|#line 1065
	yy_do_action_209
when 210 then
--|#line 1067
	yy_do_action_210
when 211 then
--|#line 1071
	yy_do_action_211
when 212 then
--|#line 1073
	yy_do_action_212
when 213 then
--|#line 1075
	yy_do_action_213
when 214 then
--|#line 1077
	yy_do_action_214
when 215 then
--|#line 1079
	yy_do_action_215
when 216 then
--|#line 1081
	yy_do_action_216
when 217 then
--|#line 1083
	yy_do_action_217
when 218 then
--|#line 1085
	yy_do_action_218
when 219 then
--|#line 1087
	yy_do_action_219
when 220 then
--|#line 1089
	yy_do_action_220
when 221 then
--|#line 1091
	yy_do_action_221
when 222 then
--|#line 1093
	yy_do_action_222
when 225 then
--|#line 1101
	yy_do_action_225
when 226 then
--|#line 1105
	yy_do_action_226
when 227 then
--|#line 1110
	yy_do_action_227
when 228 then
--|#line 1121
	yy_do_action_228
when 229 then
--|#line 1127
	yy_do_action_229
when 231 then
--|#line 1137
	yy_do_action_231
when 232 then
--|#line 1141
	yy_do_action_232
when 233 then
--|#line 1146
	yy_do_action_233
when 234 then
--|#line 1153
	yy_do_action_234
when 235 then
--|#line 1153
	yy_do_action_235
when 236 then
--|#line 1163
	yy_do_action_236
when 237 then
--|#line 1165
	yy_do_action_237
when 239 then
--|#line 1175
	yy_do_action_239
when 240 then
--|#line 1183
	yy_do_action_240
when 242 then
--|#line 1192
	yy_do_action_242
when 243 then
--|#line 1196
	yy_do_action_243
when 244 then
--|#line 1201
	yy_do_action_244
when 245 then
--|#line 1208
	yy_do_action_245
when 247 then
--|#line 1214
	yy_do_action_247
when 248 then
--|#line 1218
	yy_do_action_248
when 250 then
--|#line 1227
	yy_do_action_250
when 251 then
--|#line 1231
	yy_do_action_251
when 252 then
--|#line 1236
	yy_do_action_252
when 253 then
--|#line 1243
	yy_do_action_253
when 254 then
--|#line 1247
	yy_do_action_254
when 255 then
--|#line 1252
	yy_do_action_255
when 256 then
--|#line 1259
	yy_do_action_256
when 257 then
--|#line 1261
	yy_do_action_257
when 258 then
--|#line 1263
	yy_do_action_258
when 259 then
--|#line 1265
	yy_do_action_259
when 260 then
--|#line 1267
	yy_do_action_260
when 261 then
--|#line 1269
	yy_do_action_261
when 262 then
--|#line 1271
	yy_do_action_262
when 263 then
--|#line 1273
	yy_do_action_263
when 264 then
--|#line 1275
	yy_do_action_264
when 265 then
--|#line 1277
	yy_do_action_265
when 266 then
--|#line 1279
	yy_do_action_266
when 267 then
--|#line 1281
	yy_do_action_267
when 268 then
--|#line 1283
	yy_do_action_268
when 269 then
--|#line 1285
	yy_do_action_269
when 270 then
--|#line 1287
	yy_do_action_270
when 271 then
--|#line 1289
	yy_do_action_271
when 272 then
--|#line 1291
	yy_do_action_272
when 273 then
--|#line 1293
	yy_do_action_273
when 275 then
--|#line 1300
	yy_do_action_275
when 276 then
--|#line 1309
	yy_do_action_276
when 278 then
--|#line 1318
	yy_do_action_278
when 280 then
--|#line 1324
	yy_do_action_280
when 281 then
--|#line 1324
	yy_do_action_281
when 283 then
--|#line 1336
	yy_do_action_283
when 284 then
--|#line 1338
	yy_do_action_284
when 285 then
--|#line 1342
	yy_do_action_285
when 288 then
--|#line 1353
	yy_do_action_288
when 289 then
--|#line 1357
	yy_do_action_289
when 290 then
--|#line 1362
	yy_do_action_290
when 291 then
--|#line 1369
	yy_do_action_291
when 293 then
--|#line 1375
	yy_do_action_293
when 294 then
--|#line 1384
	yy_do_action_294
when 295 then
--|#line 1386
	yy_do_action_295
when 296 then
--|#line 1390
	yy_do_action_296
when 297 then
--|#line 1392
	yy_do_action_297
when 299 then
--|#line 1398
	yy_do_action_299
when 300 then
--|#line 1402
	yy_do_action_300
when 301 then
--|#line 1407
	yy_do_action_301
when 302 then
--|#line 1414
	yy_do_action_302
when 303 then
--|#line 1420
	yy_do_action_303
when 304 then
--|#line 1425
	yy_do_action_304
when 305 then
--|#line 1430
	yy_do_action_305
when 306 then
--|#line 1435
	yy_do_action_306
when 307 then
--|#line 1440
	yy_do_action_307
when 308 then
--|#line 1447
	yy_do_action_308
when 309 then
--|#line 1450
	yy_do_action_309
when 310 then
--|#line 1452
	yy_do_action_310
when 311 then
--|#line 1454
	yy_do_action_311
when 312 then
--|#line 1456
	yy_do_action_312
when 313 then
--|#line 1458
	yy_do_action_313
when 314 then
--|#line 1460
	yy_do_action_314
when 315 then
--|#line 1462
	yy_do_action_315
when 316 then
--|#line 1464
	yy_do_action_316
when 317 then
--|#line 1466
	yy_do_action_317
when 318 then
--|#line 1468
	yy_do_action_318
when 319 then
--|#line 1470
	yy_do_action_319
when 320 then
--|#line 1472
	yy_do_action_320
when 321 then
--|#line 1474
	yy_do_action_321
when 323 then
--|#line 1480
	yy_do_action_323
when 324 then
--|#line 1484
	yy_do_action_324
when 325 then
--|#line 1489
	yy_do_action_325
when 326 then
--|#line 1496
	yy_do_action_326
when 327 then
--|#line 1498
	yy_do_action_327
when 328 then
--|#line 1500
	yy_do_action_328
when 329 then
--|#line 1502
	yy_do_action_329
when 330 then
--|#line 1504
	yy_do_action_330
when 331 then
--|#line 1506
	yy_do_action_331
when 332 then
--|#line 1508
	yy_do_action_332
when 333 then
--|#line 1510
	yy_do_action_333
when 334 then
--|#line 1512
	yy_do_action_334
when 335 then
--|#line 1514
	yy_do_action_335
when 336 then
--|#line 1516
	yy_do_action_336
when 337 then
--|#line 1518
	yy_do_action_337
when 338 then
--|#line 1520
	yy_do_action_338
when 339 then
--|#line 1522
	yy_do_action_339
when 340 then
--|#line 1524
	yy_do_action_340
when 341 then
--|#line 1528
	yy_do_action_341
when 342 then
--|#line 1530
	yy_do_action_342
when 343 then
--|#line 1532
	yy_do_action_343
when 344 then
--|#line 1536
	yy_do_action_344
when 345 then
--|#line 1538
	yy_do_action_345
when 347 then
--|#line 1544
	yy_do_action_347
when 348 then
--|#line 1548
	yy_do_action_348
when 349 then
--|#line 1550
	yy_do_action_349
when 351 then
--|#line 1556
	yy_do_action_351
when 352 then
--|#line 1564
	yy_do_action_352
when 353 then
--|#line 1566
	yy_do_action_353
when 354 then
--|#line 1568
	yy_do_action_354
when 355 then
--|#line 1570
	yy_do_action_355
when 356 then
--|#line 1572
	yy_do_action_356
when 357 then
--|#line 1574
	yy_do_action_357
when 358 then
--|#line 1576
	yy_do_action_358
when 359 then
--|#line 1578
	yy_do_action_359
when 360 then
--|#line 1580
	yy_do_action_360
when 361 then
--|#line 1584
	yy_do_action_361
when 362 then
--|#line 1595
	yy_do_action_362
when 363 then
--|#line 1597
	yy_do_action_363
when 364 then
--|#line 1599
	yy_do_action_364
when 365 then
--|#line 1601
	yy_do_action_365
when 366 then
--|#line 1603
	yy_do_action_366
when 367 then
--|#line 1605
	yy_do_action_367
when 368 then
--|#line 1607
	yy_do_action_368
when 369 then
--|#line 1609
	yy_do_action_369
when 370 then
--|#line 1611
	yy_do_action_370
when 371 then
--|#line 1613
	yy_do_action_371
when 372 then
--|#line 1615
	yy_do_action_372
when 373 then
--|#line 1617
	yy_do_action_373
when 374 then
--|#line 1619
	yy_do_action_374
when 375 then
--|#line 1621
	yy_do_action_375
when 376 then
--|#line 1623
	yy_do_action_376
when 377 then
--|#line 1625
	yy_do_action_377
when 378 then
--|#line 1627
	yy_do_action_378
when 379 then
--|#line 1629
	yy_do_action_379
when 380 then
--|#line 1631
	yy_do_action_380
when 381 then
--|#line 1633
	yy_do_action_381
when 382 then
--|#line 1635
	yy_do_action_382
when 383 then
--|#line 1637
	yy_do_action_383
when 384 then
--|#line 1639
	yy_do_action_384
when 385 then
--|#line 1641
	yy_do_action_385
when 386 then
--|#line 1643
	yy_do_action_386
when 387 then
--|#line 1645
	yy_do_action_387
when 388 then
--|#line 1647
	yy_do_action_388
when 389 then
--|#line 1649
	yy_do_action_389
when 390 then
--|#line 1651
	yy_do_action_390
when 391 then
--|#line 1653
	yy_do_action_391
when 392 then
--|#line 1655
	yy_do_action_392
when 393 then
--|#line 1657
	yy_do_action_393
when 394 then
--|#line 1659
	yy_do_action_394
when 395 then
--|#line 1661
	yy_do_action_395
when 396 then
--|#line 1663
	yy_do_action_396
when 397 then
--|#line 1665
	yy_do_action_397
when 398 then
--|#line 1669
	yy_do_action_398
when 399 then
--|#line 1677
	yy_do_action_399
when 400 then
--|#line 1679
	yy_do_action_400
when 401 then
--|#line 1681
	yy_do_action_401
when 402 then
--|#line 1683
	yy_do_action_402
when 403 then
--|#line 1685
	yy_do_action_403
when 404 then
--|#line 1687
	yy_do_action_404
when 405 then
--|#line 1689
	yy_do_action_405
when 406 then
--|#line 1691
	yy_do_action_406
when 407 then
--|#line 1693
	yy_do_action_407
when 408 then
--|#line 1695
	yy_do_action_408
when 409 then
--|#line 1697
	yy_do_action_409
when 410 then
--|#line 1699
	yy_do_action_410
when 411 then
--|#line 1703
	yy_do_action_411
when 412 then
--|#line 1707
	yy_do_action_412
when 413 then
--|#line 1711
	yy_do_action_413
when 414 then
--|#line 1715
	yy_do_action_414
when 415 then
--|#line 1719
	yy_do_action_415
when 416 then
--|#line 1723
	yy_do_action_416
when 417 then
--|#line 1725
	yy_do_action_417
when 418 then
--|#line 1727
	yy_do_action_418
when 419 then
--|#line 1729
	yy_do_action_419
when 420 then
--|#line 1731
	yy_do_action_420
when 421 then
--|#line 1733
	yy_do_action_421
when 422 then
--|#line 1735
	yy_do_action_422
when 423 then
--|#line 1737
	yy_do_action_423
when 424 then
--|#line 1739
	yy_do_action_424
when 425 then
--|#line 1741
	yy_do_action_425
when 426 then
--|#line 1743
	yy_do_action_426
when 427 then
--|#line 1745
	yy_do_action_427
when 428 then
--|#line 1747
	yy_do_action_428
when 429 then
--|#line 1749
	yy_do_action_429
when 430 then
--|#line 1753
	yy_do_action_430
when 431 then
--|#line 1757
	yy_do_action_431
when 432 then
--|#line 1764
	yy_do_action_432
when 433 then
--|#line 1772
	yy_do_action_433
when 434 then
--|#line 1774
	yy_do_action_434
when 435 then
--|#line 1778
	yy_do_action_435
when 436 then
--|#line 1780
	yy_do_action_436
when 437 then
--|#line 1784
	yy_do_action_437
when 438 then
--|#line 1797
	yy_do_action_438
when 441 then
--|#line 1805
	yy_do_action_441
when 442 then
--|#line 1809
	yy_do_action_442
when 443 then
--|#line 1814
	yy_do_action_443
when 444 then
--|#line 1821
	yy_do_action_444
when 445 then
--|#line 1823
	yy_do_action_445
when 446 then
--|#line 1827
	yy_do_action_446
when 447 then
--|#line 1832
	yy_do_action_447
when 448 then
--|#line 1843
	yy_do_action_448
when 449 then
--|#line 1845
	yy_do_action_449
when 450 then
--|#line 1847
	yy_do_action_450
when 451 then
--|#line 1849
	yy_do_action_451
when 452 then
--|#line 1851
	yy_do_action_452
when 453 then
--|#line 1853
	yy_do_action_453
when 454 then
--|#line 1855
	yy_do_action_454
when 455 then
--|#line 1857
	yy_do_action_455
when 456 then
--|#line 1859
	yy_do_action_456
when 457 then
--|#line 1861
	yy_do_action_457
when 458 then
--|#line 1863
	yy_do_action_458
when 459 then
--|#line 1865
	yy_do_action_459
when 460 then
--|#line 1869
	yy_do_action_460
when 461 then
--|#line 1871
	yy_do_action_461
when 462 then
--|#line 1873
	yy_do_action_462
when 463 then
--|#line 1875
	yy_do_action_463
when 464 then
--|#line 1877
	yy_do_action_464
when 465 then
--|#line 1879
	yy_do_action_465
when 466 then
--|#line 1883
	yy_do_action_466
when 467 then
--|#line 1885
	yy_do_action_467
when 468 then
--|#line 1887
	yy_do_action_468
when 469 then
--|#line 1902
	yy_do_action_469
when 470 then
--|#line 1904
	yy_do_action_470
when 471 then
--|#line 1906
	yy_do_action_471
when 472 then
--|#line 1910
	yy_do_action_472
when 473 then
--|#line 1912
	yy_do_action_473
when 474 then
--|#line 1916
	yy_do_action_474
when 475 then
--|#line 1923
	yy_do_action_475
when 476 then
--|#line 1938
	yy_do_action_476
when 477 then
--|#line 1953
	yy_do_action_477
when 478 then
--|#line 1971
	yy_do_action_478
when 479 then
--|#line 1973
	yy_do_action_479
when 480 then
--|#line 1975
	yy_do_action_480
when 481 then
--|#line 1982
	yy_do_action_481
when 482 then
--|#line 1986
	yy_do_action_482
when 483 then
--|#line 1988
	yy_do_action_483
when 484 then
--|#line 1990
	yy_do_action_484
when 485 then
--|#line 1994
	yy_do_action_485
when 486 then
--|#line 1996
	yy_do_action_486
when 487 then
--|#line 1998
	yy_do_action_487
when 488 then
--|#line 2000
	yy_do_action_488
when 489 then
--|#line 2002
	yy_do_action_489
when 490 then
--|#line 2004
	yy_do_action_490
when 491 then
--|#line 2006
	yy_do_action_491
when 492 then
--|#line 2008
	yy_do_action_492
when 493 then
--|#line 2010
	yy_do_action_493
when 494 then
--|#line 2012
	yy_do_action_494
when 495 then
--|#line 2014
	yy_do_action_495
when 496 then
--|#line 2016
	yy_do_action_496
when 497 then
--|#line 2018
	yy_do_action_497
when 498 then
--|#line 2020
	yy_do_action_498
when 499 then
--|#line 2022
	yy_do_action_499
when 500 then
--|#line 2024
	yy_do_action_500
when 501 then
--|#line 2026
	yy_do_action_501
when 502 then
--|#line 2028
	yy_do_action_502
when 503 then
--|#line 2030
	yy_do_action_503
when 504 then
--|#line 2032
	yy_do_action_504
when 505 then
--|#line 2034
	yy_do_action_505
when 506 then
--|#line 2038
	yy_do_action_506
when 507 then
--|#line 2040
	yy_do_action_507
when 508 then
--|#line 2042
	yy_do_action_508
when 509 then
--|#line 2044
	yy_do_action_509
when 510 then
--|#line 2048
	yy_do_action_510
when 511 then
--|#line 2050
	yy_do_action_511
when 512 then
--|#line 2052
	yy_do_action_512
when 513 then
--|#line 2054
	yy_do_action_513
when 514 then
--|#line 2056
	yy_do_action_514
when 515 then
--|#line 2058
	yy_do_action_515
when 516 then
--|#line 2060
	yy_do_action_516
when 517 then
--|#line 2062
	yy_do_action_517
when 518 then
--|#line 2064
	yy_do_action_518
when 519 then
--|#line 2066
	yy_do_action_519
when 520 then
--|#line 2068
	yy_do_action_520
when 521 then
--|#line 2070
	yy_do_action_521
when 522 then
--|#line 2072
	yy_do_action_522
when 523 then
--|#line 2074
	yy_do_action_523
when 524 then
--|#line 2076
	yy_do_action_524
when 525 then
--|#line 2078
	yy_do_action_525
when 526 then
--|#line 2080
	yy_do_action_526
when 527 then
--|#line 2082
	yy_do_action_527
when 528 then
--|#line 2086
	yy_do_action_528
when 529 then
--|#line 2090
	yy_do_action_529
when 530 then
--|#line 2094
	yy_do_action_530
when 531 then
--|#line 2098
	yy_do_action_531
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 176
		local

		do
			yyval := yyval_default;
				root_node := new_class_description (yytype86 (yyvs.item (yyvsp - 12)), yytype55 (yyvs.item (yyvsp - 10)),
					is_deferred, is_expanded, is_separate, is_frozen_class, is_external_class,
					yytype75 (yyvs.item (yyvsp - 15)), yytype75 (yyvs.item (yyvsp - 1)), yytype71 (yyvs.item (yyvsp - 11)), yytype79 (yyvs.item (yyvsp - 8)), yytype63 (yyvs.item (yyvsp - 6)), yytype68 (yyvs.item (yyvsp - 5)), yytype39 (yyvs.item (yyvsp - 3)), suppliers, yytype55 (yyvs.item (yyvsp - 9)), click_list
				)

				if real_class_end_position = 0 then
					root_node.set_text_positions (
						start_position,
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

	yy_do_action_2 is
			--|#line 218
		local

		do
			yyval := yyval_default;
				if inherit_context then
					inherit_context := False
					real_class_end_position := 0
				end
			

		end

	yy_do_action_3 is
			--|#line 227
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_4 is
			--|#line 229
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_5 is
			--|#line 231
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_6 is
			--|#line 233
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_7 is
			--|#line 235
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_8 is
			--|#line 237
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_9 is
			--|#line 239
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_10 is
			--|#line 241
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_11 is
			--|#line 243
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_12 is
			--|#line 245
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_13 is
			--|#line 247
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_14 is
			--|#line 249
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_15 is
			--|#line 253
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_id_as (token_buffer)) 
			yyval := yyval86
		end

	yy_do_action_16 is
			--|#line 257
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_boolean_id_as) 
			yyval := yyval86
		end

	yy_do_action_17 is
			--|#line 261
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_character_id_as (False)) 
			yyval := yyval86
		end

	yy_do_action_18 is
			--|#line 265
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_character_id_as (True)) 
			yyval := yyval86
		end

	yy_do_action_19 is
			--|#line 269
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_double_id_as) 
			yyval := yyval86
		end

	yy_do_action_20 is
			--|#line 273
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_integer_id_as (8)) 
			yyval := yyval86
		end

	yy_do_action_21 is
			--|#line 277
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_integer_id_as (16)) 
			yyval := yyval86
		end

	yy_do_action_22 is
			--|#line 281
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_integer_id_as (32)) 
			yyval := yyval86
		end

	yy_do_action_23 is
			--|#line 285
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_integer_id_as (64)) 
			yyval := yyval86
		end

	yy_do_action_24 is
			--|#line 289
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_none_id_as) 
			yyval := yyval86
		end

	yy_do_action_25 is
			--|#line 293
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_pointer_id_as) 
			yyval := yyval86
		end

	yy_do_action_26 is
			--|#line 297
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_real_id_as) 
			yyval := yyval86
		end

	yy_do_action_28 is
			--|#line 307
		local
			yyval75: INDEXING_CLAUSE_AS
		do

yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
		end

	yy_do_action_31 is
			--|#line 315
		local
			yyval75: INDEXING_CLAUSE_AS
		do

yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
		end

	yy_do_action_32 is
			--|#line 317
		local
			yyval75: INDEXING_CLAUSE_AS
		do

yyval75 := Void 
			yyval := yyval75
		end

	yy_do_action_34 is
			--|#line 323
		local
			yyval75: INDEXING_CLAUSE_AS
		do

yyval75 := yytype75 (yyvs.item (yyvsp - 1)) 
			yyval := yyval75
		end

	yy_do_action_35 is
			--|#line 325
		local
			yyval75: INDEXING_CLAUSE_AS
		do

yyval75 := Void 
			yyval := yyval75
		end

	yy_do_action_36 is
			--|#line 329
		local
			yyval75: INDEXING_CLAUSE_AS
		do

				yyval75 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval75.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_37 is
			--|#line 334
		local
			yyval75: INDEXING_CLAUSE_AS
		do

				yyval75 := yytype75 (yyvs.item (yyvsp - 1))
				yyval75.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_38 is
			--|#line 341
		local
			yyval32: INDEX_AS
		do

yyval32 := new_index_as (yytype30 (yyvs.item (yyvsp - 2)), yytype61 (yyvs.item (yyvsp - 1))) 
			yyval := yyval32
		end

	yy_do_action_39 is
			--|#line 345
		local
			yyval30: ID_AS
		do

yyval30 := yytype30 (yyvs.item (yyvsp - 1)) 
			yyval := yyval30
		end

	yy_do_action_41 is
			--|#line 351
		local
			yyval61: EIFFEL_LIST [ATOMIC_AS]
		do

				yyval61 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval61.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_42 is
			--|#line 356
		local
			yyval61: EIFFEL_LIST [ATOMIC_AS]
		do

				yyval61 := yytype61 (yyvs.item (yyvsp - 2))
				yyval61.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_43 is
			--|#line 361
		local
			yyval61: EIFFEL_LIST [ATOMIC_AS]
		do

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval61 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval61
		end

	yy_do_action_44 is
			--|#line 368
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype30 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_45 is
			--|#line 370
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_46 is
			--|#line 372
		local
			yyval6: ATOMIC_AS
		do

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype18 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval6
		end

	yy_do_action_47 is
			--|#line 382
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_48 is
			--|#line 388
		local

		do
			yyval := yyval_default;
				is_frozen_class := False
				is_deferred := True
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_49 is
			--|#line 395
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := True
				is_separate := False
			

		end

	yy_do_action_50 is
			--|#line 401
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := True
			

		end

	yy_do_action_51 is
			--|#line 409
		local

		do
			yyval := yyval_default;
				is_frozen_class := False
			

		end

	yy_do_action_52 is
			--|#line 413
		local

		do
			yyval := yyval_default;
				if il_parser then
					is_frozen_class := True
				else
						-- Trigger a syntax error.
					raise_error
				end
			

		end

	yy_do_action_53 is
			--|#line 424
		local

		do
			yyval := yyval_default;
				is_external_class := False
			

		end

	yy_do_action_54 is
			--|#line 428
		local

		do
			yyval := yyval_default;
				if il_parser then
					is_external_class := True
				else
						-- Trigger a syntax error.
					raise_error
				end
			

		end

	yy_do_action_56 is
			--|#line 445
		local
			yyval55: STRING_AS
		do

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_58 is
			--|#line 454
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval68 := yytype68 (yyvs.item (yyvsp))
				if yyval68.is_empty then
					yyval68 := Void
				end
			
			yyval := yyval68
		end

	yy_do_action_59 is
			--|#line 463
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval68 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval68, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_60 is
			--|#line 468
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval68 := yytype68 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval68, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_61 is
			--|#line 475
		local
			yyval27: FEATURE_CLAUSE_AS
		do

yyval27 := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) 
			yyval := yyval27
		end

	yy_do_action_62 is
			--|#line 477
		local
			yyval27: FEATURE_CLAUSE_AS
		do

yyval27 := new_feature_clause_as (yytype14 (yyvs.item (yyvsp - 1)), yytype67 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval27
		end

	yy_do_action_63 is
			--|#line 481
		local
			yyval14: CLIENT_AS
		do

yyval14 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval14
		end

	yy_do_action_64 is
			--|#line 481
		local

		do
			yyval := yyval_default;
				inherit_context := False
				fclause_pos := current_position.end_position
			

		end

	yy_do_action_66 is
			--|#line 492
		local
			yyval14: CLIENT_AS
		do

yyval14 := new_client_as (yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval14
		end

	yy_do_action_67 is
			--|#line 496
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do

				yyval72 := new_eiffel_list_id_as (1)
				yyval72.extend (new_none_id_as)
			
			yyval := yyval72
		end

	yy_do_action_68 is
			--|#line 501
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do

yyval72 := yytype72 (yyvs.item (yyvsp - 1)) 
			yyval := yyval72
		end

	yy_do_action_69 is
			--|#line 505
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do

				yyval72 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval72.extend (yytype86 (yyvs.item (yyvsp)).first)
				yytype86 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype86 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval72
		end

	yy_do_action_70 is
			--|#line 511
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do

				yyval72 := yytype72 (yyvs.item (yyvsp - 2))
				yyval72.extend (yytype86 (yyvs.item (yyvsp)).first)
				yytype86 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype86 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval72
		end

	yy_do_action_71 is
			--|#line 519
		local
			yyval67: EIFFEL_LIST [FEATURE_AS]
		do

				yyval67 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval67.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_72 is
			--|#line 524
		local
			yyval67: EIFFEL_LIST [FEATURE_AS]
		do

				yyval67 := yytype67 (yyvs.item (yyvsp - 1))
				yyval67.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_75 is
			--|#line 535
		local
			yyval26: FEATURE_AS
		do

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

	yy_do_action_76 is
			--|#line 548
		local
			yyval89: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

yyval89 := new_clickable_feature_name_list (yytype87 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval89
		end

	yy_do_action_77 is
			--|#line 550
		local
			yyval89: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

				yyval89 := yytype89 (yyvs.item (yyvsp - 2))
				yyval89.first.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval89
		end

	yy_do_action_78 is
			--|#line 557
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
		end

	yy_do_action_79 is
			--|#line 561
		local

		do
			yyval := yyval_default;
is_frozen := False 

		end

	yy_do_action_80 is
			--|#line 563
		local

		do
			yyval := yyval_default;
is_frozen := True 

		end

	yy_do_action_81 is
			--|#line 567
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := new_clickable_feature_name (yytype86 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_82 is
			--|#line 569
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
		end

	yy_do_action_83 is
			--|#line 571
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
		end

	yy_do_action_84 is
			--|#line 575
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := new_clickable_infix (yytype88 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_85 is
			--|#line 580
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := new_clickable_prefix (yytype88 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_86 is
			--|#line 584
		local
			yyval8: BODY_AS
		do

yyval8 := new_declaration_body (yytype84 (yyvs.item (yyvsp - 2)), yytype58 (yyvs.item (yyvsp - 1)), yytype15 (yyvs.item (yyvsp))) 
			yyval := yyval8
		end

	yy_do_action_87 is
			--|#line 588
		local
			yyval15: CONTENT_AS
		do

feature_indexes := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_88 is
			--|#line 590
		local
			yyval15: CONTENT_AS
		do

yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_89 is
			--|#line 594
		local
			yyval15: CONTENT_AS
		do

				yyval15 := new_constant_as (new_value_as (yytype6 (yyvs.item (yyvsp - 1))))
				feature_indexes := yytype75 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_90 is
			--|#line 599
		local
			yyval15: CONTENT_AS
		do

				yyval15 := new_constant_as (new_value_as (new_unique_as))
				feature_indexes := yytype75 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_91 is
			--|#line 604
		local
			yyval15: CONTENT_AS
		do

				yyval15 := yytype53 (yyvs.item (yyvsp))
				feature_indexes := yytype75 (yyvs.item (yyvsp - 1))
			
			yyval := yyval15
		end

	yy_do_action_93 is
			--|#line 617
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do

yyval79 := yytype79 (yyvs.item (yyvsp)) 
			yyval := yyval79
		end

	yy_do_action_94 is
			--|#line 619
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do

yyval79 := new_eiffel_list_parent_as (0) 
			yyval := yyval79
		end

	yy_do_action_95 is
			--|#line 623
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do

				yyval79 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval79.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_96 is
			--|#line 628
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do

				yyval79 := yytype79 (yyvs.item (yyvsp - 1))
				yyval79.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_97 is
			--|#line 635
		local
			yyval44: PARENT_AS
		do

				yyval44 := yytype44 (yyvs.item (yyvsp))
				yytype44 (yyvs.item (yyvsp)).set_text_positions (yytype91 (yyvs.item (yyvsp - 1)).start_position)
			
			yyval := yyval44
		end

	yy_do_action_98 is
			--|#line 640
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := yytype44 (yyvs.item (yyvsp - 1))
				yytype44 (yyvs.item (yyvsp - 1)).set_text_positions (yytype91 (yyvs.item (yyvsp - 2)).start_position)
			
			yyval := yyval44
		end

	yy_do_action_99 is
			--|#line 648
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_100 is
			--|#line 653
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 7)), yytype83 (yyvs.item (yyvsp - 6)), yytype80 (yyvs.item (yyvsp - 5)), yytype65 (yyvs.item (yyvsp - 4)), yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_101 is
			--|#line 658
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 6)), yytype83 (yyvs.item (yyvsp - 5)), Void, yytype65 (yyvs.item (yyvsp - 4)), yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_102 is
			--|#line 663
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 5)), yytype83 (yyvs.item (yyvsp - 4)), Void, Void, yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_103 is
			--|#line 668
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 4)), yytype83 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_104 is
			--|#line 673
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 3)), yytype83 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_105 is
			--|#line 678
		local
			yyval44: PARENT_AS
		do

				inherit_context := True
				real_class_end_position := end_position - 3
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 2)), yytype83 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_107 is
			--|#line 688
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do

yyval80 := yytype80 (yyvs.item (yyvsp)) 
			yyval := yyval80
		end

	yy_do_action_108 is
			--|#line 692
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do

				yyval80 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval80.extend (yytype48 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_109 is
			--|#line 697
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do

				yyval80 := yytype80 (yyvs.item (yyvsp - 2))
				yyval80.extend (yytype48 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_110 is
			--|#line 704
		local
			yyval48: RENAME_AS
		do

yyval48 := new_rename_pair (yytype87 (yyvs.item (yyvsp - 2)), yytype87 (yyvs.item (yyvsp))) 
			yyval := yyval48
		end

	yy_do_action_112 is
			--|#line 710
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_113 is
			--|#line 714
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_115 is
			--|#line 720
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval65 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				yyval65.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_116 is
			--|#line 725
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval65 := yytype65 (yyvs.item (yyvsp - 1))
				yyval65.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_117 is
			--|#line 732
		local
			yyval22: EXPORT_ITEM_AS
		do

yyval22 := new_export_item_as (new_client_as (yytype72 (yyvs.item (yyvsp - 2))), yytype28 (yyvs.item (yyvsp - 1))) 
			yyval := yyval22
		end

	yy_do_action_118 is
			--|#line 736
		local
			yyval28: FEATURE_SET_AS
		do

yyval28 := new_all_as 
			yyval := yyval28
		end

	yy_do_action_119 is
			--|#line 738
		local
			yyval28: FEATURE_SET_AS
		do

yyval28 := new_feature_list_as (yytype70 (yyvs.item (yyvsp))) 
			yyval := yyval28
		end

	yy_do_action_120 is
			--|#line 742
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval70 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval70.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval70
		end

	yy_do_action_121 is
			--|#line 747
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval70 := yytype70 (yyvs.item (yyvsp - 2))
				yyval70.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval70
		end

	yy_do_action_123 is
			--|#line 756
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_125 is
			--|#line 762
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_127 is
			--|#line 768
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_129 is
			--|#line 774
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_131 is
			--|#line 780
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_133 is
			--|#line 786
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_135 is
			--|#line 796
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval84 := yytype84 (yyvs.item (yyvsp - 1)) 
			yyval := yyval84
		end

	yy_do_action_137 is
			--|#line 802
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_138 is
			--|#line 806
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval84 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_139 is
			--|#line 811
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval84 := yytype84 (yyvs.item (yyvsp - 1))
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_140 is
			--|#line 818
		local
			yyval59: TYPE_DEC_AS
		do

yyval59 := new_type_dec_as (yytype74 (yyvs.item (yyvsp - 4)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval59
		end

	yy_do_action_142 is
			--|#line 823
		local

		do
			yyval := yyval_default;
				if il_parser then
						-- Trigger a syntax error.
					raise_error
				end
			

		end

	yy_do_action_144 is
			--|#line 834
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_145 is
			--|#line 838
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval84 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_146 is
			--|#line 843
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval84 := yytype84 (yyvs.item (yyvsp - 1))
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_147 is
			--|#line 850
		local
			yyval59: TYPE_DEC_AS
		do

yyval59 := new_type_dec_as (yytype74 (yyvs.item (yyvsp - 3)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval59
		end

	yy_do_action_148 is
			--|#line 854
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do

				create yyval74.make (Initial_identifier_list_size)
				Names_heap.put (yytype30 (yyvs.item (yyvsp)))
				yyval74.extend (Names_heap.found_item)
			
			yyval := yyval74
		end

	yy_do_action_149 is
			--|#line 860
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do

				yyval74 := yytype74 (yyvs.item (yyvsp - 2))
				Names_heap.put (yytype30 (yyvs.item (yyvsp)))
				yyval74.extend (Names_heap.found_item)
			
			yyval := yyval74
		end

	yy_do_action_150 is
			--|#line 868
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do

create yyval74.make (0) 
			yyval := yyval74
		end

	yy_do_action_151 is
			--|#line 870
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do

yyval74 := yytype74 (yyvs.item (yyvsp)) 
			yyval := yyval74
		end

	yy_do_action_153 is
			--|#line 876
		local
			yyval58: TYPE
		do

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_154 is
			--|#line 880
		local
			yyval53: ROUTINE_AS
		do

yyval53 := new_routine_as (yytype55 (yyvs.item (yyvsp - 7)), yytype49 (yyvs.item (yyvsp - 5)), yytype84 (yyvs.item (yyvsp - 4)), yytype52 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), fbody_pos) 
			yyval := yyval53
		end

	yy_do_action_155 is
			--|#line 880
		local

		do
			yyval := yyval_default;
fbody_pos := current_position.start_position 

		end

	yy_do_action_156 is
			--|#line 892
		local
			yyval52: ROUT_BODY_AS
		do

yyval52 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval52
		end

	yy_do_action_157 is
			--|#line 894
		local
			yyval52: ROUT_BODY_AS
		do

yyval52 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval52
		end

	yy_do_action_158 is
			--|#line 896
		local
			yyval52: ROUT_BODY_AS
		do

yyval52 := new_deferred_as 
			yyval := yyval52
		end

	yy_do_action_159 is
			--|#line 900
		local
			yyval24: EXTERNAL_AS
		do

yyval24 := new_external_as (yytype25 (yyvs.item (yyvsp - 1)), yytype55 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_160 is
			--|#line 904
		local
			yyval25: EXTERNAL_LANG_AS
		do

yyval25 := new_external_lang_as (yytype55 (yyvs.item (yyvsp)), yacc_position) 
			yyval := yyval25
		end

	yy_do_action_161 is
			--|#line 904
		local

		do
			yyval := yyval_default;
set_position (current_position) 

		end

	yy_do_action_163 is
			--|#line 912
		local
			yyval55: STRING_AS
		do

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_164 is
			--|#line 916
		local
			yyval37: INTERNAL_AS
		do

yyval37 := new_do_as (yytype76 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_165 is
			--|#line 918
		local
			yyval37: INTERNAL_AS
		do

yyval37 := new_once_as (yytype76 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_167 is
			--|#line 924
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_169 is
			--|#line 930
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_170 is
			--|#line 934
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval76.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_171 is
			--|#line 939
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp - 1))
				yyval76.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_172 is
			--|#line 946
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype35 (yyvs.item (yyvsp - 1)) 
			yyval := yyval35
		end

	yy_do_action_175 is
			--|#line 954
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_176 is
			--|#line 956
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_177 is
			--|#line 958
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_178 is
			--|#line 960
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype51 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_179 is
			--|#line 962
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype31 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_180 is
			--|#line 964
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_181 is
			--|#line 966
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype40 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_182 is
			--|#line 968
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_183 is
			--|#line 970
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_184 is
			--|#line 972
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype50 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_186 is
			--|#line 978
		local
			yyval49: REQUIRE_AS
		do

				id_level := Normal_level
				yyval49 := new_require_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval49
		end

	yy_do_action_187 is
			--|#line 978
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_188 is
			--|#line 985
		local
			yyval49: REQUIRE_AS
		do

				id_level := Normal_level
				yyval49 := new_require_else_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval49
		end

	yy_do_action_189 is
			--|#line 985
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_191 is
			--|#line 996
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_192 is
			--|#line 996
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_193 is
			--|#line 1003
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_then_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_194 is
			--|#line 1003
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_196 is
			--|#line 1014
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

				yyval82 := yytype82 (yyvs.item (yyvsp))
				if yyval82.is_empty then
					yyval82 := Void
				end
			
			yyval := yyval82
		end

	yy_do_action_197 is
			--|#line 1023
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

				yyval82 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval82, yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_198 is
			--|#line 1028
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

				yyval82 := yytype82 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval82, yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_199 is
			--|#line 1035
		local
			yyval56: TAGGED_AS
		do

yyval56 := yytype56 (yyvs.item (yyvsp - 1)) 
			yyval := yyval56
		end

	yy_do_action_200 is
			--|#line 1039
		local
			yyval56: TAGGED_AS
		do

yyval56 := new_tagged_as (Void, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval56
		end

	yy_do_action_201 is
			--|#line 1041
		local
			yyval56: TAGGED_AS
		do

yyval56 := new_tagged_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval56
		end

	yy_do_action_203 is
			--|#line 1051
		local
			yyval58: TYPE
		do

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_204 is
			--|#line 1053
		local
			yyval58: TYPE
		do

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_205 is
			--|#line 1057
		local
			yyval58: TYPE
		do

yyval58 := new_expanded_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_206 is
			--|#line 1059
		local
			yyval58: TYPE
		do

yyval58 := new_separate_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_207 is
			--|#line 1061
		local
			yyval58: TYPE
		do

yyval58 := new_bits_as (yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_208 is
			--|#line 1063
		local
			yyval58: TYPE
		do

yyval58 := new_bits_symbol_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_209 is
			--|#line 1065
		local
			yyval58: TYPE
		do

yyval58 := new_like_id_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_210 is
			--|#line 1067
		local
			yyval58: TYPE
		do

yyval58 := new_like_current_as 
			yyval := yyval58
		end

	yy_do_action_211 is
			--|#line 1071
		local
			yyval58: TYPE
		do

yyval58 := new_class_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_212 is
			--|#line 1073
		local
			yyval58: TYPE
		do

yyval58 := new_boolean_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_213 is
			--|#line 1075
		local
			yyval58: TYPE
		do

yyval58 := new_character_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, False) 
			yyval := yyval58
		end

	yy_do_action_214 is
			--|#line 1077
		local
			yyval58: TYPE
		do

yyval58 := new_character_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, True) 
			yyval := yyval58
		end

	yy_do_action_215 is
			--|#line 1079
		local
			yyval58: TYPE
		do

yyval58 := new_double_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_216 is
			--|#line 1081
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 8) 
			yyval := yyval58
		end

	yy_do_action_217 is
			--|#line 1083
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 16) 
			yyval := yyval58
		end

	yy_do_action_218 is
			--|#line 1085
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 32) 
			yyval := yyval58
		end

	yy_do_action_219 is
			--|#line 1087
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 64) 
			yyval := yyval58
		end

	yy_do_action_220 is
			--|#line 1089
		local
			yyval58: TYPE
		do

yyval58 := new_none_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_221 is
			--|#line 1091
		local
			yyval58: TYPE
		do

yyval58 := new_pointer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_222 is
			--|#line 1093
		local
			yyval58: TYPE
		do

yyval58 := new_real_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_225 is
			--|#line 1101
		local
			yyval83: EIFFEL_LIST [TYPE]
		do

yyval83 := yytype83 (yyvs.item (yyvsp - 1)) 
			yyval := yyval83
		end

	yy_do_action_226 is
			--|#line 1105
		local
			yyval83: EIFFEL_LIST [TYPE]
		do

				yyval83 := new_eiffel_list_type (Initial_type_list_size)
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_227 is
			--|#line 1110
		local
			yyval83: EIFFEL_LIST [TYPE]
		do

				yyval83 := yytype83 (yyvs.item (yyvsp - 2))
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_228 is
			--|#line 1121
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				-- $$ := Void
				formal_generics_start_position := start_position
				formal_generics_end_position := 0
			
			yyval := yyval71
		end

	yy_do_action_229 is
			--|#line 1127
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 1))
				formal_generics_start_position := yytype91 (yyvs.item (yyvsp - 3)).start_position
				formal_generics_end_position := start_position
			
			yyval := yyval71
		end

	yy_do_action_231 is
			--|#line 1137
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

yyval71 := yytype71 (yyvs.item (yyvsp)) 
			yyval := yyval71
		end

	yy_do_action_232 is
			--|#line 1141
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval71 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval71.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_233 is
			--|#line 1146
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_234 is
			--|#line 1153
		local
			yyval29: FORMAL_DEC_AS
		do

				check formal_exists: not formal_parameters.is_empty end
				yyval29 := new_formal_dec_as (formal_parameters.last, yytype90 (yyvs.item (yyvsp)).first, yytype90 (yyvs.item (yyvsp)).second, formal_parameters.count)
			
			yyval := yyval29
		end

	yy_do_action_235 is
			--|#line 1153
		local

		do
			yyval := yyval_default;
formal_parameters.extend (new_id_as (token_buffer)) 

		end

	yy_do_action_236 is
			--|#line 1163
		local
			yyval90: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do

create yyval90 
			yyval := yyval90
		end

	yy_do_action_237 is
			--|#line 1165
		local
			yyval90: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do

				create yyval90
				yyval90.set_first (yytype58 (yyvs.item (yyvsp - 1)))
				yyval90.set_second (yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval90
		end

	yy_do_action_239 is
			--|#line 1175
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp - 1)) 
			yyval := yyval70
		end

	yy_do_action_240 is
			--|#line 1183
		local
			yyval31: IF_AS
		do

				set_position (yytype91 (yyvs.item (yyvsp - 7)))
				yyval31 := new_if_as (yytype23 (yyvs.item (yyvsp - 5)), yytype76 (yyvs.item (yyvsp - 3)), yytype64 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval31
		end

	yy_do_action_242 is
			--|#line 1192
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_243 is
			--|#line 1196
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do

				yyval64 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval64.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_244 is
			--|#line 1201
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do

				yyval64 := yytype64 (yyvs.item (yyvsp - 1))
				yyval64.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_245 is
			--|#line 1208
		local
			yyval20: ELSIF_AS
		do

yyval20 := new_elseif_as (yytype23 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp)), yacc_line_number) 
			yyval := yyval20
		end

	yy_do_action_247 is
			--|#line 1214
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_248 is
			--|#line 1218
		local
			yyval33: INSPECT_AS
		do

				set_position (yytype91 (yyvs.item (yyvsp - 5)))
				yyval33 := new_inspect_as (yytype23 (yyvs.item (yyvsp - 3)), yytype62 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval33
		end

	yy_do_action_250 is
			--|#line 1227
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do

yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
		end

	yy_do_action_251 is
			--|#line 1231
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do

				yyval62 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval62.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_252 is
			--|#line 1236
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do

				yyval62 := yytype62 (yyvs.item (yyvsp - 1))
				yyval62.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_253 is
			--|#line 1243
		local
			yyval11: CASE_AS
		do

yyval11 := new_case_as (yytype77 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp)), yacc_line_number) 
			yyval := yyval11
		end

	yy_do_action_254 is
			--|#line 1247
		local
			yyval77: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval77 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval77.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_255 is
			--|#line 1252
		local
			yyval77: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval77 := yytype77 (yyvs.item (yyvsp - 2))
				yyval77.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_256 is
			--|#line 1259
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_257 is
			--|#line 1261
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_258 is
			--|#line 1263
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_259 is
			--|#line 1265
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_260 is
			--|#line 1267
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_261 is
			--|#line 1269
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_262 is
			--|#line 1271
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_263 is
			--|#line 1273
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_264 is
			--|#line 1275
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_265 is
			--|#line 1277
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_266 is
			--|#line 1279
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_267 is
			--|#line 1281
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_268 is
			--|#line 1283
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_269 is
			--|#line 1285
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_270 is
			--|#line 1287
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_271 is
			--|#line 1289
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_272 is
			--|#line 1291
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_273 is
			--|#line 1293
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_275 is
			--|#line 1300
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp))
				if yyval76 = Void then
					yyval76 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval76
		end

	yy_do_action_276 is
			--|#line 1309
		local
			yyval40: LOOP_AS
		do

				set_position (yytype91 (yyvs.item (yyvsp - 9)))
				yyval40 := new_loop_as (yytype76 (yyvs.item (yyvsp - 7)), yytype82 (yyvs.item (yyvsp - 6)), yytype60 (yyvs.item (yyvsp - 5)), yytype23 (yyvs.item (yyvsp - 3)), yytype76 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval40
		end

	yy_do_action_278 is
			--|#line 1318
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
		end

	yy_do_action_280 is
			--|#line 1324
		local
			yyval39: INVARIANT_AS
		do

				id_level := Normal_level
				inherit_context := False
				yyval39 := new_invariant_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval39
		end

	yy_do_action_281 is
			--|#line 1324
		local

		do
			yyval := yyval_default;
id_level := Invariant_level 

		end

	yy_do_action_283 is
			--|#line 1336
		local
			yyval60: VARIANT_AS
		do

yyval60 := new_variant_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval60
		end

	yy_do_action_284 is
			--|#line 1338
		local
			yyval60: VARIANT_AS
		do

yyval60 := new_variant_as (Void, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval60
		end

	yy_do_action_285 is
			--|#line 1342
		local
			yyval19: DEBUG_AS
		do

				set_position (yytype91 (yyvs.item (yyvsp - 4)))
				yyval19 := new_debug_as (yytype81 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval19
		end

	yy_do_action_288 is
			--|#line 1353
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do

yyval81 := yytype81 (yyvs.item (yyvsp - 1)) 
			yyval := yyval81
		end

	yy_do_action_289 is
			--|#line 1357
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do

				yyval81 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval81.extend (yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_290 is
			--|#line 1362
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do

				yyval81 := yytype81 (yyvs.item (yyvsp - 2))
				yyval81.extend (yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_291 is
			--|#line 1369
		local
			yyval50: RETRY_AS
		do

yyval50 := new_retry_as (yacc_line_number) 
			yyval := yyval50
		end

	yy_do_action_293 is
			--|#line 1375
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp))
				if yyval76 = Void then
					yyval76 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval76
		end

	yy_do_action_294 is
			--|#line 1384
		local
			yyval5: ASSIGN_AS
		do

yyval5 := new_assign_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval5
		end

	yy_do_action_295 is
			--|#line 1386
		local
			yyval5: ASSIGN_AS
		do

yyval5 := new_assign_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval5
		end

	yy_do_action_296 is
			--|#line 1390
		local
			yyval51: REVERSE_AS
		do

yyval51 := new_reverse_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval51
		end

	yy_do_action_297 is
			--|#line 1392
		local
			yyval51: REVERSE_AS
		do

yyval51 := new_reverse_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval51
		end

	yy_do_action_299 is
			--|#line 1398
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_300 is
			--|#line 1402
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do

				yyval63 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval63.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_301 is
			--|#line 1407
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do

				yyval63 := yytype63 (yyvs.item (yyvsp - 1))
				yyval63.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_302 is
			--|#line 1414
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_303 is
			--|#line 1420
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_304 is
			--|#line 1425
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype72 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_305 is
			--|#line 1430
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_306 is
			--|#line 1435
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_307 is
			--|#line 1440
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype72 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_308 is
			--|#line 1447
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_result_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_309 is
			--|#line 1450
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_310 is
			--|#line 1452
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 3)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_311 is
			--|#line 1454
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 4))), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_312 is
			--|#line 1456
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (yytype58 (yyvs.item (yyvsp - 4)), Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_313 is
			--|#line 1458
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (Void, yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_314 is
			--|#line 1460
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_315 is
			--|#line 1462
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_result_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_316 is
			--|#line 1464
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_317 is
			--|#line 1466
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 3)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_318 is
			--|#line 1468
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_As (new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 4))), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_319 is
			--|#line 1470
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (yytype58 (yyvs.item (yyvsp - 3)), Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_320 is
			--|#line 1472
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (Void, yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_321 is
			--|#line 1474
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_323 is
			--|#line 1480
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do

yyval78 := yytype78 (yyvs.item (yyvsp - 1)) 
			yyval := yyval78
		end

	yy_do_action_324 is
			--|#line 1484
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do

				yyval78 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval78.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_325 is
			--|#line 1489
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do

				yyval78 := yytype78 (yyvs.item (yyvsp - 2))
				yyval78.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_326 is
			--|#line 1496
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, Void) 
			yyval := yyval43
		end

	yy_do_action_327 is
			--|#line 1498
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval43
		end

	yy_do_action_328 is
			--|#line 1500
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_class_type (yytype86 (yyvs.item (yyvsp - 2)), yytype83 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_329 is
			--|#line 1502
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_boolean_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_330 is
			--|#line 1504
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_character_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, False), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_331 is
			--|#line 1506
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_character_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, True), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_332 is
			--|#line 1508
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_double_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_333 is
			--|#line 1510
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 8), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_334 is
			--|#line 1512
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 16), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_335 is
			--|#line 1514
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 32), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_336 is
			--|#line 1516
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 64), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_337 is
			--|#line 1518
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_none_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_338 is
			--|#line 1520
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_pointer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_339 is
			--|#line 1522
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_real_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_340 is
			--|#line 1524
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (yytype58 (yyvs.item (yyvsp - 1)), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_341 is
			--|#line 1528
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (yytype58 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval17
		end

	yy_do_action_342 is
			--|#line 1530
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (Void, yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval17
		end

	yy_do_action_343 is
			--|#line 1532
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (yytype58 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval17
		end

	yy_do_action_344 is
			--|#line 1536
		local
			yyval18: CREATION_EXPR_AS
		do

yyval18 := new_creation_expr_as (yytype58 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval18
		end

	yy_do_action_345 is
			--|#line 1538
		local
			yyval18: CREATION_EXPR_AS
		do

yyval18 := new_creation_expr_as (yytype58 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval18
		end

	yy_do_action_347 is
			--|#line 1544
		local
			yyval58: TYPE
		do

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_348 is
			--|#line 1548
		local
			yyval1: ACCESS_AS
		do

yyval1 := new_access_id_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval1
		end

	yy_do_action_349 is
			--|#line 1550
		local
			yyval1: ACCESS_AS
		do

yyval1 := new_result_as 
			yyval := yyval1
		end

	yy_do_action_351 is
			--|#line 1556
		local
			yyval3: ACCESS_INV_AS
		do

yyval3 := new_access_inv_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_352 is
			--|#line 1564
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype1 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_353 is
			--|#line 1566
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_354 is
			--|#line 1568
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_355 is
			--|#line 1570
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_356 is
			--|#line 1572
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_357 is
			--|#line 1574
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype45 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_358 is
			--|#line 1576
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_359 is
			--|#line 1578
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype46 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_360 is
			--|#line 1580
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_361 is
			--|#line 1584
		local
			yyval13: CHECK_AS
		do

				set_position (yytype91 (yyvs.item (yyvsp - 3)))
				yyval13 := new_check_as (yytype82 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval13
		end

	yy_do_action_362 is
			--|#line 1595
		local
			yyval23: EXPR_AS
		do

yyval23 := new_value_as (yytype6 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_363 is
			--|#line 1597
		local
			yyval23: EXPR_AS
		do

yyval23 := new_value_as (yytype4 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_364 is
			--|#line 1599
		local
			yyval23: EXPR_AS
		do

yyval23 := new_value_as (yytype57 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_365 is
			--|#line 1601
		local
			yyval23: EXPR_AS
		do

yyval23 := new_expr_call_as (yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_366 is
			--|#line 1603
		local
			yyval23: EXPR_AS
		do

yyval23 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_367 is
			--|#line 1605
		local
			yyval23: EXPR_AS
		do

yyval23 := new_paran_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_368 is
			--|#line 1607
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_plus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_369 is
			--|#line 1609
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_minus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_370 is
			--|#line 1611
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_star_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_371 is
			--|#line 1613
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_slash_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_372 is
			--|#line 1615
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_mod_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_373 is
			--|#line 1617
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_div_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_374 is
			--|#line 1619
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_power_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_375 is
			--|#line 1621
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_and_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_376 is
			--|#line 1623
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_and_then_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_377 is
			--|#line 1625
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_or_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_378 is
			--|#line 1627
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_or_else_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_379 is
			--|#line 1629
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_implies_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_380 is
			--|#line 1631
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_xor_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_381 is
			--|#line 1633
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_ge_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_382 is
			--|#line 1635
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_gt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_383 is
			--|#line 1637
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_le_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_384 is
			--|#line 1639
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_lt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_385 is
			--|#line 1641
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_eq_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_386 is
			--|#line 1643
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_ne_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_387 is
			--|#line 1645
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_free_as (yytype23 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_388 is
			--|#line 1647
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_minus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_389 is
			--|#line 1649
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_plus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_390 is
			--|#line 1651
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_not_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_391 is
			--|#line 1653
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_old_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_392 is
			--|#line 1655
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_free_as (yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_393 is
			--|#line 1657
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_strip_as (yytype74 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_394 is
			--|#line 1659
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_as (yytype87 (yyvs.item (yyvsp)).first) 
			yyval := yyval23
		end

	yy_do_action_395 is
			--|#line 1661
		local
			yyval23: EXPR_AS
		do

yyval23 := new_expr_address_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_396 is
			--|#line 1663
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_current_as 
			yyval := yyval23
		end

	yy_do_action_397 is
			--|#line 1665
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_result_as 
			yyval := yyval23
		end

	yy_do_action_398 is
			--|#line 1669
		local
			yyval30: ID_AS
		do

yyval30 := new_id_as (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_399 is
			--|#line 1677
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_400 is
			--|#line 1679
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_401 is
			--|#line 1681
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_402 is
			--|#line 1683
		local
			yyval10: CALL_AS
		do

yyval10 := new_current_as 
			yyval := yyval10
		end

	yy_do_action_403 is
			--|#line 1685
		local
			yyval10: CALL_AS
		do

yyval10 := new_result_as 
			yyval := yyval10
		end

	yy_do_action_404 is
			--|#line 1687
		local
			yyval10: CALL_AS
		do

yyval10 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_405 is
			--|#line 1689
		local
			yyval10: CALL_AS
		do

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_406 is
			--|#line 1691
		local
			yyval10: CALL_AS
		do

yyval10 := yytype45 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_407 is
			--|#line 1693
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_408 is
			--|#line 1695
		local
			yyval10: CALL_AS
		do

yyval10 := yytype46 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_409 is
			--|#line 1697
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_410 is
			--|#line 1699
		local
			yyval10: CALL_AS
		do

yyval10 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_411 is
			--|#line 1703
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (new_current_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_412 is
			--|#line 1707
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (new_result_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_413 is
			--|#line 1711
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype1 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_414 is
			--|#line 1715
		local
			yyval42: NESTED_EXPR_AS
		do

yyval42 := new_nested_expr_as (yytype23 (yyvs.item (yyvsp - 3)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_415 is
			--|#line 1719
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype45 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_416 is
			--|#line 1723
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor_as (Void, yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_417 is
			--|#line 1725
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_418 is
			--|#line 1727
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 2)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_419 is
			--|#line 1729
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_420 is
			--|#line 1731
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_421 is
			--|#line 1733
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_422 is
			--|#line 1735
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_423 is
			--|#line 1737
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_424 is
			--|#line 1739
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_425 is
			--|#line 1741
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_426 is
			--|#line 1743
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_427 is
			--|#line 1745
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_428 is
			--|#line 1747
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_429 is
			--|#line 1749
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_430 is
			--|#line 1753
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype46 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_431 is
			--|#line 1757
		local
			yyval46: STATIC_ACCESS_AS
		do

				yyval46 := new_static_access_as (new_class_type (yytype86 (yyvs.item (yyvsp - 4)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp)));
			
			yyval := yyval46
		end

	yy_do_action_432 is
			--|#line 1764
		local
			yyval46: STATIC_ACCESS_AS
		do

				yyval46 := new_static_access_as (new_class_type (yytype86 (yyvs.item (yyvsp - 3)), Void), yytype30 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval46
		end

	yy_do_action_433 is
			--|#line 1772
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_434 is
			--|#line 1774
		local
			yyval10: CALL_AS
		do

yyval10 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_435 is
			--|#line 1778
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_436 is
			--|#line 1780
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype41 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_437 is
			--|#line 1784
		local
			yyval1: ACCESS_AS
		do

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

	yy_do_action_438 is
			--|#line 1797
		local
			yyval2: ACCESS_FEAT_AS
		do

yyval2 := new_access_feat_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval2
		end

	yy_do_action_441 is
			--|#line 1805
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

yyval66 := yytype66 (yyvs.item (yyvsp - 1)) 
			yyval := yyval66
		end

	yy_do_action_442 is
			--|#line 1809
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_443 is
			--|#line 1814
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := yytype66 (yyvs.item (yyvsp - 2))
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_444 is
			--|#line 1821
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

yyval66 := new_eiffel_list_expr_as (0) 
			yyval := yyval66
		end

	yy_do_action_445 is
			--|#line 1823
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

yyval66 := yytype66 (yyvs.item (yyvsp)) 
			yyval := yyval66
		end

	yy_do_action_446 is
			--|#line 1827
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_447 is
			--|#line 1832
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := yytype66 (yyvs.item (yyvsp - 2))
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_448 is
			--|#line 1843
		local
			yyval30: ID_AS
		do

yyval30 := new_id_as (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_449 is
			--|#line 1845
		local
			yyval30: ID_AS
		do

yyval30 := new_boolean_id_as 
			yyval := yyval30
		end

	yy_do_action_450 is
			--|#line 1847
		local
			yyval30: ID_AS
		do

yyval30 := new_character_id_as (False) 
			yyval := yyval30
		end

	yy_do_action_451 is
			--|#line 1849
		local
			yyval30: ID_AS
		do

yyval30 := new_character_id_as (True) 
			yyval := yyval30
		end

	yy_do_action_452 is
			--|#line 1851
		local
			yyval30: ID_AS
		do

yyval30 := new_double_id_as 
			yyval := yyval30
		end

	yy_do_action_453 is
			--|#line 1853
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (8) 
			yyval := yyval30
		end

	yy_do_action_454 is
			--|#line 1855
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (16) 
			yyval := yyval30
		end

	yy_do_action_455 is
			--|#line 1857
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (32) 
			yyval := yyval30
		end

	yy_do_action_456 is
			--|#line 1859
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (64) 
			yyval := yyval30
		end

	yy_do_action_457 is
			--|#line 1861
		local
			yyval30: ID_AS
		do

yyval30 := new_none_id_as 
			yyval := yyval30
		end

	yy_do_action_458 is
			--|#line 1863
		local
			yyval30: ID_AS
		do

yyval30 := new_pointer_id_as 
			yyval := yyval30
		end

	yy_do_action_459 is
			--|#line 1865
		local
			yyval30: ID_AS
		do

yyval30 := new_real_id_as 
			yyval := yyval30
		end

	yy_do_action_460 is
			--|#line 1869
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_461 is
			--|#line 1871
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_462 is
			--|#line 1873
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_463 is
			--|#line 1875
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype47 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_464 is
			--|#line 1877
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_465 is
			--|#line 1879
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_466 is
			--|#line 1883
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_467 is
			--|#line 1885
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_468 is
			--|#line 1887
		local
			yyval6: ATOMIC_AS
		do

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

	yy_do_action_469 is
			--|#line 1902
		local
			yyval6: ATOMIC_AS
		do

yyval6 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval6
		end

	yy_do_action_470 is
			--|#line 1904
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_471 is
			--|#line 1906
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_472 is
			--|#line 1910
		local
			yyval9: BOOL_AS
		do

yyval9 := new_boolean_as (False) 
			yyval := yyval9
		end

	yy_do_action_473 is
			--|#line 1912
		local
			yyval9: BOOL_AS
		do

yyval9 := new_boolean_as (True) 
			yyval := yyval9
		end

	yy_do_action_474 is
			--|#line 1916
		local
			yyval12: CHAR_AS
		do

				check is_character: not token_buffer.is_empty end
				yyval12 := new_character_as (token_buffer.item (1))
			
			yyval := yyval12
		end

	yy_do_action_475 is
			--|#line 1923
		local
			yyval36: INTEGER_CONSTANT
		do

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

	yy_do_action_476 is
			--|#line 1938
		local
			yyval36: INTEGER_CONSTANT
		do

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

	yy_do_action_477 is
			--|#line 1953
		local
			yyval36: INTEGER_CONSTANT
		do

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

	yy_do_action_478 is
			--|#line 1971
		local
			yyval47: REAL_AS
		do

yyval47 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval47
		end

	yy_do_action_479 is
			--|#line 1973
		local
			yyval47: REAL_AS
		do

yyval47 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval47
		end

	yy_do_action_480 is
			--|#line 1975
		local
			yyval47: REAL_AS
		do

				token_buffer.precede ('-')
				yyval47 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval47
		end

	yy_do_action_481 is
			--|#line 1982
		local
			yyval7: BIT_CONST_AS
		do

yyval7 := new_bit_const_as (new_id_as (token_buffer)) 
			yyval := yyval7
		end

	yy_do_action_482 is
			--|#line 1986
		local
			yyval55: STRING_AS
		do

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_483 is
			--|#line 1988
		local
			yyval55: STRING_AS
		do

yyval55 := new_empty_string_as 
			yyval := yyval55
		end

	yy_do_action_484 is
			--|#line 1990
		local
			yyval55: STRING_AS
		do

yyval55 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval55
		end

	yy_do_action_485 is
			--|#line 1994
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_486 is
			--|#line 1996
		local
			yyval55: STRING_AS
		do

yyval55 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval55
		end

	yy_do_action_487 is
			--|#line 1998
		local
			yyval55: STRING_AS
		do

yyval55 := new_lt_string_as 
			yyval := yyval55
		end

	yy_do_action_488 is
			--|#line 2000
		local
			yyval55: STRING_AS
		do

yyval55 := new_le_string_as 
			yyval := yyval55
		end

	yy_do_action_489 is
			--|#line 2002
		local
			yyval55: STRING_AS
		do

yyval55 := new_gt_string_as 
			yyval := yyval55
		end

	yy_do_action_490 is
			--|#line 2004
		local
			yyval55: STRING_AS
		do

yyval55 := new_ge_string_as 
			yyval := yyval55
		end

	yy_do_action_491 is
			--|#line 2006
		local
			yyval55: STRING_AS
		do

yyval55 := new_minus_string_as 
			yyval := yyval55
		end

	yy_do_action_492 is
			--|#line 2008
		local
			yyval55: STRING_AS
		do

yyval55 := new_plus_string_as 
			yyval := yyval55
		end

	yy_do_action_493 is
			--|#line 2010
		local
			yyval55: STRING_AS
		do

yyval55 := new_star_string_as 
			yyval := yyval55
		end

	yy_do_action_494 is
			--|#line 2012
		local
			yyval55: STRING_AS
		do

yyval55 := new_slash_string_as 
			yyval := yyval55
		end

	yy_do_action_495 is
			--|#line 2014
		local
			yyval55: STRING_AS
		do

yyval55 := new_mod_string_as 
			yyval := yyval55
		end

	yy_do_action_496 is
			--|#line 2016
		local
			yyval55: STRING_AS
		do

yyval55 := new_div_string_as 
			yyval := yyval55
		end

	yy_do_action_497 is
			--|#line 2018
		local
			yyval55: STRING_AS
		do

yyval55 := new_power_string_as 
			yyval := yyval55
		end

	yy_do_action_498 is
			--|#line 2020
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_499 is
			--|#line 2022
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_500 is
			--|#line 2024
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_501 is
			--|#line 2026
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_502 is
			--|#line 2028
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_503 is
			--|#line 2030
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_504 is
			--|#line 2032
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_505 is
			--|#line 2034
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_506 is
			--|#line 2038
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_minus_string_as) 
			yyval := yyval88
		end

	yy_do_action_507 is
			--|#line 2040
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_plus_string_as) 
			yyval := yyval88
		end

	yy_do_action_508 is
			--|#line 2042
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_not_string_as) 
			yyval := yyval88
		end

	yy_do_action_509 is
			--|#line 2044
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval88
		end

	yy_do_action_510 is
			--|#line 2048
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_lt_string_as) 
			yyval := yyval88
		end

	yy_do_action_511 is
			--|#line 2050
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_le_string_as) 
			yyval := yyval88
		end

	yy_do_action_512 is
			--|#line 2052
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_gt_string_as) 
			yyval := yyval88
		end

	yy_do_action_513 is
			--|#line 2054
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_ge_string_as) 
			yyval := yyval88
		end

	yy_do_action_514 is
			--|#line 2056
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_minus_string_as) 
			yyval := yyval88
		end

	yy_do_action_515 is
			--|#line 2058
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_plus_string_as) 
			yyval := yyval88
		end

	yy_do_action_516 is
			--|#line 2060
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_star_string_as) 
			yyval := yyval88
		end

	yy_do_action_517 is
			--|#line 2062
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_slash_string_as) 
			yyval := yyval88
		end

	yy_do_action_518 is
			--|#line 2064
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_mod_string_as) 
			yyval := yyval88
		end

	yy_do_action_519 is
			--|#line 2066
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_div_string_as) 
			yyval := yyval88
		end

	yy_do_action_520 is
			--|#line 2068
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_power_string_as) 
			yyval := yyval88
		end

	yy_do_action_521 is
			--|#line 2070
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_and_string_as) 
			yyval := yyval88
		end

	yy_do_action_522 is
			--|#line 2072
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval88
		end

	yy_do_action_523 is
			--|#line 2074
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_implies_string_as) 
			yyval := yyval88
		end

	yy_do_action_524 is
			--|#line 2076
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_or_string_as) 
			yyval := yyval88
		end

	yy_do_action_525 is
			--|#line 2078
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval88
		end

	yy_do_action_526 is
			--|#line 2080
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_xor_string_as) 
			yyval := yyval88
		end

	yy_do_action_527 is
			--|#line 2082
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval88
		end

	yy_do_action_528 is
			--|#line 2086
		local
			yyval4: ARRAY_AS
		do

yyval4 := new_array_as (yytype66 (yyvs.item (yyvsp - 1))) 
			yyval := yyval4
		end

	yy_do_action_529 is
			--|#line 2090
		local
			yyval57: TUPLE_AS
		do

yyval57 := new_tuple_as (yytype66 (yyvs.item (yyvsp - 1))) 
			yyval := yyval57
		end

	yy_do_action_530 is
			--|#line 2094
		local

		do
			yyval := yyval_default;
set_position (current_position) 

		end

	yy_do_action_531 is
			--|#line 2098
		local
			yyval91: TOKEN_LOCATION
		do

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
			    0,  305,  307,  283,  283,  283,  283,  283,  283,  283,
			  283,  283,  283,  283,  283,  284,  285,  286,  292,  287,
			  289,  290,  288,  291,  293,  294,  295,  254,  254,  254,
			  256,  256,  256,  257,  257,  257,  255,  255,  176,  173,
			  173,  222,  222,  222,  143,  143,  143,  306,  306,  306,
			  306,  309,  309,  310,  310,  207,  207,  237,  237,  238,
			  238,  169,  169,  155,  311,  154,  154,  250,  250,  251,
			  251,  236,  236,  308,  308,  168,  302,  302,  299,  313,
			  313,  298,  298,  298,  296,  297,  147,  156,  156,  157,
			  157,  157,  266,  266,  266,  267,  267,  194,  194,  195,

			  195,  195,  195,  195,  195,  195,  268,  268,  269,  269,
			  200,  230,  230,  229,  229,  231,  231,  164,  170,  170,
			  239,  239,  241,  241,  240,  240,  243,  243,  242,  242,
			  245,  245,  244,  244,  277,  277,  278,  278,  279,  279,
			  219,  314,  314,  281,  281,  282,  282,  220,  252,  252,
			  253,  253,  215,  215,  205,  315,  204,  204,  204,  166,
			  167,  316,  209,  209,  182,  182,  280,  280,  259,  259,
			  260,  260,  179,  312,  312,  180,  180,  180,  180,  180,
			  180,  180,  180,  180,  180,  201,  201,  318,  201,  319,
			  163,  163,  320,  163,  321,  272,  272,  273,  273,  211,

			  212,  212,  212,  214,  214,  218,  218,  218,  218,  218,
			  218,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  275,  275,  275,  276,  276,  247,  247,
			  248,  248,  249,  249,  171,  322,  303,  303,  246,  246,
			  175,  227,  227,  228,  228,  162,  261,  261,  177,  223,
			  223,  224,  224,  151,  263,  263,  183,  183,  183,  183,
			  183,  183,  183,  183,  183,  183,  183,  183,  183,  183,
			  183,  183,  183,  183,  262,  262,  185,  274,  274,  184,
			  184,  323,  221,  221,  221,  161,  270,  270,  270,  271,
			  271,  202,  258,  258,  142,  142,  203,  203,  225,  225,

			  226,  226,  158,  158,  158,  158,  158,  158,  206,  206,
			  206,  206,  206,  206,  206,  206,  206,  206,  206,  206,
			  206,  206,  264,  264,  265,  265,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  159,  159,  159,  160,  160,  217,  217,  137,  137,
			  140,  140,  178,  178,  178,  178,  178,  178,  178,  178,
			  178,  153,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  174,  150,

			  150,  150,  150,  150,  150,  150,  150,  150,  150,  150,
			  150,  190,  189,  188,  192,  187,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  191,  197,  198,  149,  149,  186,  186,  138,  139,  232,
			  232,  232,  233,  233,  234,  234,  235,  235,  172,  172,
			  172,  172,  172,  172,  172,  172,  172,  172,  172,  172,
			  144,  144,  144,  144,  144,  144,  145,  145,  145,  145,
			  145,  145,  148,  148,  152,  181,  181,  181,  199,  199,
			  199,  146,  208,  208,  208,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,

			  210,  210,  210,  210,  210,  210,  301,  301,  301,  301,
			  300,  300,  300,  300,  300,  300,  300,  300,  300,  300,
			  300,  300,  300,  300,  300,  300,  300,  300,  141,  213,
			  317,  304>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   16,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    0,    2,    1,
			    0,    2,    1,    0,    3,    2,    1,    2,    3,    2,
			    0,    1,    3,    1,    1,    1,    2,    2,    2,    3,
			    3,    0,    1,    0,    1,    0,    2,    0,    1,    1,
			    2,    1,    2,    3,    0,    0,    1,    2,    3,    1,
			    3,    1,    2,    0,    1,    3,    1,    3,    2,    0,
			    1,    1,    1,    1,    2,    2,    3,    1,    2,    2,
			    2,    2,    0,    2,    2,    1,    2,    2,    3,    2,

			    8,    7,    6,    5,    4,    3,    1,    2,    1,    3,
			    3,    0,    1,    2,    2,    1,    2,    3,    1,    1,
			    1,    3,    0,    1,    1,    2,    0,    1,    1,    2,
			    0,    1,    1,    2,    0,    3,    0,    1,    1,    2,
			    5,    0,    3,    0,    1,    1,    2,    4,    1,    3,
			    0,    1,    0,    2,    8,    0,    1,    1,    1,    3,
			    2,    0,    0,    2,    2,    2,    0,    2,    1,    2,
			    1,    2,    3,    0,    2,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    0,    3,    0,    4,    0,
			    0,    3,    0,    4,    0,    0,    1,    1,    2,    3,

			    1,    3,    2,    1,    1,    3,    3,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    0,    2,    3,    1,    3,    0,    4,
			    0,    1,    1,    3,    3,    0,    0,    3,    0,    3,
			    8,    0,    1,    1,    2,    4,    0,    2,    6,    0,
			    1,    1,    2,    4,    1,    3,    1,    3,    1,    3,
			    1,    3,    3,    3,    3,    3,    1,    3,    3,    3,
			    3,    3,    3,    3,    0,    2,   10,    0,    2,    0,
			    3,    0,    0,    4,    2,    5,    0,    2,    3,    1,
			    3,    1,    0,    2,    3,    3,    3,    3,    0,    1,

			    1,    2,    1,    3,    2,    1,    3,    2,    5,    5,
			    5,    7,    7,    5,    3,    4,    4,    4,    6,    5,
			    4,    3,    0,    3,    1,    3,    1,    1,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    3,    5,    3,    6,    5,    4,    0,    1,    1,    1,
			    0,    3,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    4,    1,    1,    1,    1,    1,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    4,    3,    4,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    2,    2,
			    2,    2,    2,    4,    2,    4,    2,    2,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    3,    3,    3,    5,    3,    2,    7,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    3,    7,    6,    1,    1,    3,    3,    2,    2,    0,
			    2,    3,    1,    3,    0,    1,    1,    3,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    2,    2,    1,    2,
			    2,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    3,    3,
			    0,    0>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   27,   40,   51,  459,  458,  457,  451,  456,  454,  453,
			  455,  452,  450,  449,  448,    0,    0,   36,   40,   52,
			   53,    0,   53,   39,  505,  504,  503,  502,  501,  500,
			  499,  498,  497,  496,  495,  494,  493,  492,  491,  490,
			  489,  488,  487,  484,  486,  483,  473,  472,    0,   43,
			    0,  481,  485,  478,  474,  475,    0,    0,   41,   45,
			  464,  460,  461,    0,   44,  462,  463,  465,  482,   73,
			   37,   54,   48,    0,   53,   53,   47,    0,   26,   25,
			   24,   18,   23,   21,   20,   22,   19,   17,   16,    0,
			    0,    0,    0,   15,    0,  203,  204,  223,  223,  223,

			  223,  223,  223,  223,  223,  223,  223,  223,  223,  480,
			  477,  479,  476,   46,    0,   74,   38,  531,    3,    4,
			    6,    7,   10,    8,    9,   11,    5,   12,   13,   14,
			   50,   49,    0,  223,  210,  209,  223,    0,    0,  208,
			  207,  350,    0,  211,  212,  213,  215,  218,  216,  217,
			  219,  214,  220,  221,  222,   42,  162,    0,  350,  206,
			  205,    0,  345,  224,  226,    0,    0,   55,  230,  344,
			  439,  225,    0,  163,    0,   92,  235,  232,    0,  231,
			    0,  351,  227,   56,  531,  531,  236,  229,    0,    0,
			  403,    0,  439,    0,  402,    0,  444,    0,  440,  444,

			    0,  469,  468,    0,    0,    0,    0,  398,    0,    0,
			  404,  363,  362,  470,  466,  365,  467,  410,  442,  439,
			    0,  407,  401,  400,  399,  409,  405,  406,  408,  366,
			  471,  364,    0,   95,  531,    0,   94,  298,    0,  234,
			  233,    0,    0,    0,    0,    0,    0,    0,    0,  322,
			    0,  416,    0,    0,    0,  397,    0,    0,  396,    0,
			   81,   82,   83,  394,  446,    0,  445,    0,    0,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			    0,  322,    0,  391,  150,  390,  388,  389,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,  437,  392,
			    0,    0,  441,    0,   96,   97,  223,  305,  302,  300,
			   57,  299,  238,  322,  322,  434,  412,  439,  433,    0,
			    0,    0,    0,    0,    0,    0,  314,    0,    0,  322,
			  411,  509,  508,  507,  506,   85,  527,  526,  525,  524,
			  523,  522,  521,  520,  519,  518,  517,  516,  515,  514,
			  513,  512,  511,  510,   84,    0,  529,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  528,  321,  367,  148,  151,    0,  413,  374,  373,
			  372,  371,  370,  369,  368,  381,  383,  382,  384,  385,

			  386,    0,  375,  380,    0,  377,  379,  387,  322,  415,
			  430,  443,   98,   99,    0,    0,  307,    0,  304,   64,
			   79,   59,  531,   58,  301,    0,  237,  320,  315,    0,
			  438,  322,  322,  322,    0,    0,  326,    0,  327,  324,
			    0,  322,  439,    0,  316,  395,  447,    0,  322,  439,
			  439,  439,  439,  439,  439,  439,  439,  439,  439,  439,
			    0,    0,    0,  393,  376,  378,  317,  124,  132,  106,
			  128,   73,  105,  122,  126,  130,    0,  111,   67,    0,
			   69,  306,  120,  303,   65,   80,   71,   79,   76,  134,
			    0,  279,   60,    0,  435,  436,  313,  308,  309,    0,

			    0,  204,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  323,    0,  310,  418,    0,    0,
			  319,  419,  420,  421,  422,  425,  423,  424,  426,  427,
			  428,  429,  322,  414,  149,  125,  133,  108,  107,    0,
			  129,  115,  113,    0,  114,  123,  126,  127,  130,  131,
			    0,  104,  112,  122,   68,    0,    0,   63,   66,   72,
			   79,  136,  173,  152,   78,  281,  531,  239,  322,  322,
			  340,  211,  212,  213,  215,  218,  216,  217,  219,  214,
			  220,  221,  222,  325,  439,  439,  318,    0,    0,  116,
			  118,   73,  119,  130,    0,  103,  126,   70,  121,   77,

			  138,    0,    0,  137,   75,    0,   33,  530,   27,  312,
			  311,  328,  329,  330,  332,  335,  333,  334,  336,  331,
			  337,  338,  339,  431,  417,  109,  110,  117,    0,  102,
			  130,  141,  135,  139,  174,  153,   30,   40,   86,   87,
			  197,  280,  530,    0,    0,  101,    0,    0,    0,   33,
			   40,   33,   88,   55,   35,   40,  198,  200,  439,   73,
			    2,    1,  100,    0,   73,   90,   40,   89,   91,  155,
			   34,  202,  199,  142,  140,  185,  201,  187,  166,  189,
			  530,  143,    0,  530,  186,  145,    0,  167,  144,  173,
			  161,  173,  158,  157,  156,  190,  188,    0,  146,  165,

			  530,  162,    0,  164,  192,  292,   73,  170,  530,  531,
			  159,  160,  194,  530,  173,    0,  147,  171,  291,    0,
			    0,    0,    0,  346,    0,  352,  177,  183,  175,  182,
			  439,  179,  180,  176,  173,  181,  358,  354,  353,  355,
			  360,  356,  357,  359,  184,  178,    0,  530,  191,  293,
			  154,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  349,    0,  350,  348,  347,    0,
			    0,    0,    0,  172,    0,    0,  173,  286,  530,  193,
			  295,  297,    0,  342,    0,    0,  294,  296,  249,    0,
			  277,    0,  173,    0,    0,  350,    0,  251,  274,  250,

			  173,  530,  282,  287,  289,    0,    0,  361,  350,  341,
			    0,  258,  260,  256,  254,  266,    0,  173,    0,  252,
			  241,  278,    0,    0,  288,    0,  285,  343,    0,    0,
			    0,    0,    0,  173,    0,  275,  248,    0,  243,  246,
			  242,  284,  439,    0,  290,    0,  259,  265,  273,  264,
			  261,  262,  268,  263,  257,  271,  272,  267,  270,  269,
			  253,  255,    0,  173,    0,  244,    0,    0,    0,  173,
			  247,  240,  283,  173,    0,  245,    0,  432,  276,    0,
			    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  766,  210,  325,  162,  211,  726,   58,   59,  212,  213,
			  562,  214,  326,  215,  797,  216,  727,  415,  420,  638,
			  652,  319,  728,  217,  729,  838,  705,  541,  264,  693,
			  701,  486,  421,  591,  177,  219,   16,  220,  731,   17,
			  732,  733,  707,  734,   65,  694,  814,  566,  735,  328,
			  221,  222,  223,  224,  225,  226,  439,  233,  315,  227,
			  228,  815,   66,  537,  678,  744,  745,  695,  668,  229,
			  175,  230,  167,   68,  640,  659,  231,  268,  606,   95,
			  769,   96,  600,  685,  823,   69,  798,  799,  320,  321,
			  839,  840,  473,  553,  542,  308,  232,  265,  266,  487,

			  422,  423,  481,  545,  546,  547,  548,  549,  550,  426,
			  156,  178,  179,  543,  479,  601,  386,    2,   18,  653,
			  639,  715,  699,  708,  864,  818,  816,  336,  440,  185,
			  234,  477,  538,  792,  805,  641,  642,  802,  143,  165,
			  563,  602,  603,  682,  687,  688,  260,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  261,
			  262,  482,  488,  364,  345,  489,  239,  235,  879,   21,
			  661,  116,   22,   72,  484,  700,  490,  648,  675,  702,
			  643,  680,  683,  713,  747,  186,  607>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  383, 2344,   37, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  593, 1156, -32768, 2286, -32768,
			  556,  575,  -14, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  585, -32768,
			 2462, -32768, -32768, -32768, -32768, -32768,  158,   89, -32768, -32768,
			 -32768, -32768, -32768,  565, -32768, -32768, -32768, -32768, -32768,  169,
			 -32768, -32768, -32768, 2595,  556,  556, -32768, 2462, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2595,
			 2018, 2595,  899, -32768,  584, -32768, -32768,  461,  461,  461,

			  461,  461,  461,  461,  461,  461,  461,  461,  461, -32768,
			 -32768, -32768, -32768, -32768, 1816, -32768, -32768,   59, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  577,  461, -32768, -32768,  461,  589,  587, -32768,
			 -32768,  254, 2427, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  403,  567,  254, -32768,
			 -32768, 2580, -32768, -32768, -32768,  114, 1982,  356,  574, -32768,
			  437, -32768, 2462, -32768, 1262,  538, -32768, -32768,  563,  569,
			 1528, -32768, -32768, -32768,  311, -32768,  560, -32768,  574,  481,
			   87, 1934,   24,  559,   26, 1374, 1651, 2379, -32768, 1651,

			 2580, -32768, -32768, 1651, 1651,  580, 1651, -32768, 1651, 1651,
			  390, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2808,   21,
			 1651, -32768, -32768, -32768, -32768, -32768, -32768,  385,  365, -32768,
			 -32768, -32768,  216, -32768,  207, 2595, -32768,  363, 2595, -32768,
			 -32768, 2580, 2580, 2580,  579,  572,  571, 2462, 1651,  381,
			 2595, -32768, 2595, 2580, 2580, -32768,  -39, 2670, -32768, 1651,
			 -32768, -32768, -32768, -32768, 2808,  554,  555, 2595,  490,  348,
			  345,  336,  330,  319,  309,  307,  302,  298,  278,  272,
			  547,  443, 2766, -32768, 2580, -32768, -32768, -32768, 2580, 1651,
			 1651, 1651, 1651, 1651, 1651, 1651, 1651, 1651, 1651, 1651,

			 1651, 1651, 1405, 1651, 1114, 1651, 1651, 2580, -32768, -32768,
			 2580, 2580, -32768, 1651, -32768,  553,  461, 2473, 2473, -32768,
			  484,  363,  548,  443,  443,  488, -32768,  437, -32768, 2580,
			 2580, 2580,  539, 2724, 1774, 2580, -32768,  526,  522,  443,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, 2706, -32768, 1651,  511, 2580,
			  503,  502,  498,  494,  491,  487,  486,  483,  482,  476,
			  474, -32768, -32768,   23, -32768,  516,  510, -32768,  382,  382,
			  382,  382,  382,  343,  343,  699,  699,  699,  699,  699,

			  699, 1651, 1591, 1355, 1651, 2746, 1290, -32768,  443, -32768,
			 -32768, 2808, -32768,  208, 2565,  984, 2513,  984, 2513, -32768,
			  266, -32768, -32768,  484, -32768,  984, -32768, -32768, -32768, 2580,
			 -32768,  443,  443,  443,  496,  495,  481, 2379, 2808, -32768,
			  148,  443,  437,  493, -32768, -32768, 2808,  469,  443,  437,
			  437,  437,  437,  437,  437,  437,  437,  437,  437,  437,
			 2580, 2580, 2580, -32768, 1591, 2746, -32768,  984,  984,  984,
			  984,  122, -32768,  400,  378,  346,  450,  446, -32768,  145,
			 -32768,  422, -32768,  422,  455, -32768, -32768,  243, -32768,   17,
			  984,  473, -32768,    0,  488, -32768, -32768, -32768, -32768, 2580,

			 2580,  465,  348,  345,  336,  330,  319,  309,  307,  302,
			  461,  298,  278,  272, -32768, 1774, -32768, -32768, 2580,  425,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  443, -32768, -32768,  422,  422, -32768,  462,  449,
			  422, -32768,  455,  418, -32768, -32768,  378, -32768,  346, -32768,
			  435, -32768, -32768,  400, -32768, 2595,  984, -32768, -32768, -32768,
			  424, 2580, -32768,  426, -32768, -32768, -32768, -32768,  443,  443,
			 -32768,  448,  447,  444,  442,  441,  440,  439,  438,  436,
			  423,  421,  420, -32768,  437,  437, -32768,  984,  984, -32768,
			 -32768,  392,  422,  346,  393, -32768,  378, -32768, -32768, -32768,

			 -32768,  219,  410, 2580,  300, 2462,  149,   71,  383, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  389, -32768,
			  346,  395, -32768, -32768, -32768, -32768, 1939, 2525, -32768, -32768,
			 -32768, -32768,  501, 1651,  377, -32768,  376, 2580, 2462,  375,
			 2262,  375, -32768,  356, -32768, 2194, -32768, 2808,  117,  392,
			 -32768, -32768, -32768,  388,  392, -32768, 2228, -32768, -32768, -32768,
			 -32768, 1651, -32768, -32768, -32768,  344, 2808,  369,  355, -32768,
			   65, 2580,  113,   65, -32768, -32768,  162, -32768, 2580, -32768,
			 -32768, -32768, -32768, -32768, -32768,  367, -32768, 2462, -32768, -32768,

			  166,  403, 1982, -32768,  331,  340,  392, -32768,  735, 2162,
			 -32768, -32768, -32768,  -29, -32768,  358, -32768, -32768, -32768,    7,
			  397,  368, 2497, 2462, 1651,  390, -32768, -32768, -32768, -32768,
			   16, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  385,  365, -32768, -32768,  211,  -29, -32768, -32768,
			 -32768, 1651, 1651,  374,  370,  366,  364,  353,  351,  339,
			  332,  328,  326,  295, -32768, 2462,  254, -32768, -32768,  316,
			 2636, 1651, 1651,  300, 1651, 1651, -32768,  306,  270, -32768,
			 2808, 2808,  280, -32768, 2404,  282, 2808, 2808, 1309, 2153,
			  245, 1960, -32768,  246, 2404,  254,  944, -32768,  251,  203,

			 -32768,   -6,  198, -32768, -32768,   50,  225, -32768,  254, -32768,
			  229,  267,  248,  242, -32768,  240,  -16, -32768,  147, -32768,
			  151, -32768, 1651,  138, -32768, 1982, -32768, -32768, 2595, 2174,
			  944, 2105,  944, -32768,  944, -32768, -32768, 1651, -32768,  171,
			  151, 2808,   84, 1651, -32768,  123, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 2135, -32768,   93, -32768, 1651, 1327,   91, -32768,
			 -32768, -32768, 2808, -32768, 2580, -32768,    6, -32768, -32768,   54,
			   38, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -646,   18,  299, -144, -32768, -32768,  612,   88, -32768,   -7,
			 -32768,  -10, -243, -32768,  -76,  -15, -32768, -306, -32768, -32768,
			 -32768,  401, -32768,   14, -32768, -137, -32768,  167,  244, -32768,
			 -32768,  217,  276, -32768,  506,   -1, -32768,  636, -32768,   -5,
			 -32768, -32768,  -24, -32768,  -89, -32768, -146, -32768, -32768,  249,
			    2,   -3,  -12,  -18,  -20,  -27,  156,  451, -32768,  -30,
			  -35, -537, -32768,   86, -32768, -32768, -32768, -32768, -32768, -32768,
			   15,   -8,  -38, -150,   28, -32768, -32768,  -31, -32768,  429,
			 -32768,  223,   56,  -26, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  176, -32768, -32768,  485, -32768,  453, -32768, -32768,

			 -32768, -32768, -391,  231,   90,  227, -523,  226, -515, -32768,
			 -32768, -32768, -32768, -313, -32768, -263, -32768,   30, -497, -32768,
			 -416, -32768, -609, -32768, -32768, -32768, -32768,  -61, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -639, -32768, -32768,  848, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  -71,  161,  144,  127,
			   53,   42,    8,  -11,  -21,  197,  -25,  -28,  -40, -32768,
			 -32768, -168,   75, -32768, -32768, -32768, -32768, -110, -32768, -32768,
			 -32768, -153, -32768,   13, -32768, -534, -32768, -32768, -32768, -32768,
			 -535, -32768, -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   15,   62,  117,  140,  416,  418,   61,  157,   67,   60,
			  108,  340,  417,   70,  169,   64,  173,   15,  133,   94,
			  136,  385,  107,  593,  834,  106,  483,  263,  604,  104,
			   63,  236,  243,  594,  493,   76, -195,  108,  881,  103,
			  556,  684,  180,  561,  696,  387,  132,  180,  461,  107,
			  180,  254,  106,   75,  880,   71,  104,  560,  102,  307,
			  752,  460, -195,  751,  253,  567,  103,  409,  410,  772,
			  250,  878,  771,  630,  748,  237,  535,  536,  628,  540,
			  833,   74,  703,  344,  343,  102, -228,  130,  131,  135,
			  825,  139,  101, -195, -195,  824,  342,  341,   20,   62,

			 -228, -228,  108,  100,   61,  749,   67,   60,  779,   19,
			  180,  164,  243,   64,  107,  646,  874,  106,  112,  101,
			  111,  104,  307,  866, -228,  242, -195, -195,   63, -228,
			  100,  103,  108, -228, -195, -228, -195, -228,  795,  793,
			  655,  182, -228,  180,  107, -195, -195,  106,  808, -195,
			  102,  104,  592,  666,  172,  307,  671,  279,  871,  115,
			  170,  103,  821,  171,  316,  709,  183,  790,  414,  278,
			  868,  558,  277,  709,  692,  691,  276,   99,  557,  337,
			  102,  338,  690,  806,  101,  555,  275,  110,  515,  109,
			  249,  820,  554,  514,   98,  100,  368,  689,  108,  281,

			  773,  697,  462,  634,   99,  274,  115,  108,  835,  114,
			  107,   97,  836,  106,  101,  837,  332,  104,  533,  107,
			  382,   98,  106,  637,  860,  100,  104,  103,  636, -168,
			 -168, -168, -168,  665,  863,  667,  103,  843,   97,  273,
			  323,  324,  327,  832, -168,  831,  102,  105,  -93,  -93,
			  272,  830,  339,  327,  870,  102,  313, -168,  631,  462,
			  875,  312,  427,  428,  876, -168, -168, -168,  778,   99,
			  829,  777,  -93,  472,  105,  828,  471,  -93,  444,  161,
			  101,  -93,  776,  384,  775,  -93,   98,  327,  774,  101,
			  826,  100,  848,  852,  855,  859,  470,  469,  822,   99,

			  100,  539,  468,   97,  796,  467,  408,  461,  -62,  327,
			  327,  807,  491,  -62,  817,  485,   98,  -62,  544,  380,
			  142,  -62,  564,  801,  271,  379,  142,  794,  431,  432,
			  433,  -61,  791,   97,  441, -195,  -61,  634,  485,  105,
			  -61,  270,  380,  480,  -61,  378,  142,  466,  115,  377,
			  142,  784,  -73,  -73,  376,  142,  375,  142,  269,  293,
			  292,  291,  290,  289,  207,   99,  374,  142,  448,  105,
			  496,  497,  498,  379,   99,  378,  -73,  373,  142,  377,
			  516,  -73,   98,  372,  142,  -73,  376,  520,  598,  -73,
			  311,   98,  371,  142,  105,  370,  142,  513,  375,   97,

			  374,   93,  289,  207,  318,  317,  335,  334,   97,  512,
			  310,  373,  511,  372,  267,  288,  509,  371,  686,  539,
			  626,  370,  254,  750,  218,  686,  508,  712,  327,  115,
			  166,  714,  679,  704,  677,  105,  681,  673,  627,  174,
			  468,  662,  660,  647,  105,  507,  590,  282,  283,  637,
			  285,   93,  286,  287,  645,  632,  608,    1,  629,  532,
			  327,  534,  556,  180,  309,  605,  470,  622,  621,  334,
			  620,  586,   88,   87,   86,   85,   84,   83,   82,  506,
			   80,   79,   78,  619,  597,  618,  617,  616,  615,  614,
			  505,  613,  333,  257,  612,  611,  485,  467,  568,  569,

			  595,  414,  587,  365,  588,  256,  672,  609,  610,  142,
			  585,  674,  570,  429,  471,  551,  519,  584,  518,  241,
			  500,  499,   88,   87,   86,   85,   84,   83,   82,   81,
			   80,   79,   78,  388,  389,  390,  391,  392,  393,  394,
			  395,  396,  397,  398,  399,  400,  402,  403,  405,  406,
			  407,  565,  711,  716,  419,  463,  462,  411,  447,  459,
			  384,  458, -196, -196,  504,  108, -196,  457,  456,  443,
			 -196,  455,  454,  442,  635, -196,  453,  107,  438,  452,
			  106,  503, -196,  451,  104, -196,  434,  450,  449,  425,
			  412,  381, -196,  369,  103,  367,  331,  330,  502,  746,

			 -196, -196,  384,  366,  329,  252,  284,  176,  108,  188,
			  238,  446,  187,  102,  184,  168,  112,  664,  110,  141,
			  107,   62,  783,  106,  158,   71,   61,  104,   67,   60,
			  113,   77,   23,   73,  510,  599,   15,  103,  644,  476,
			  475,  804,  658,  596,  474,  464,  663,  101,  465,   15,
			   70,  809,  280,  552,   15,  181,  102,  108,  100,  633,
			  501,   70,  698,  710,  827,   15,  706,  322,  669,  107,
			  656,  583,  106,  625,  743,  844,  104,  251,  495,  742,
			  384,  763,  741,  108,  717,  314,  103,  384,  861,  740,
			  101,  739,  768,  762,  240,  107,  761,  738,  106,  492,

			  760,  100,  104,  865,  559,  102,  737,  813,  730,  589,
			  759,  736,  103,  295,  294,  293,  292,  291,  290,  289,
			  207,  767,  424,  819,  651,  108,  155,  725,  494,  758,
			    0,  102,   99,    0,  782,    0,    0,  107,    0,  101,
			  106,  851,  854,  858,  104,  813,    0,    0,    0,   98,
			  100,    0,    0,    0,  103,    0,    0,  845,    0,  438,
			    0,    0,    0,  757,    0,  101,   97,    0,    0,    0,
			    0,    0,    0,  102,  756,   99,  100,    0,    0,    0,
			    0,  811,    0,  767,    0,    0,    0,    0,    0,    0,
			    0,    0,   98,  767,    0,  812,    0,    0, -169, -169,

			 -169, -169,  105,    0,    0,    0,    0,  101,    0,   97,
			    0,    0,  430, -169,  846,  849,    0,  856,  100,  811,
			    0,  842,    0,    0,   99,    0, -169,    0,  847,  850,
			  853,  857,    0,  812, -169, -169, -169,    0,    0,    0,
			    0,   98,    0,    0,    0,  105,    0,    0,  755,    0,
			   99,    0,    0,    0,  306,    0,    0,    0,   97,    0,
			    0,    0,    0,    0,    0,  754,    0,   98,    0,    0,
			    0,    0,    0,  877,    0,    0,    0,    0,    0,    0,
			    0,    0,  753,    0,   97,    0,    0,  657,    0,    0,
			    0,    0,   99,    0,  105,    0,    0,    0,    0,    0,

			  306,    0,    0,    0,    0,    0,    0,    0,    0,   98,
			    0,    0,    0,  138,  137,  676,    0,    0,  306,  306,
			  105,  306,  306,  306,    0,    0,   97,  517,   55,    0,
			    0,    0,   14,    0,  521,  522,  523,  524,  525,  526,
			  527,  528,  529,  530,  531,  306,  144,  145,  146,  147,
			  148,  149,  150,  151,  152,  153,  154,    0,  138,  137,
			    0,    0,  105,    0,    0,    0,    0,    0,  770,  306,
			    0,    0,    0,   55,   54,    0,    0,   14,    0,    0,
			    0,  159,    0,    0,  160,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  780,  781,    0,    0,    0,

			    0,  306,    0,   13,   12,   11,   10,    9,    8,    7,
			    6,    5,    4,    3,  810,  786,  787,   93,  788,  789,
			    0,    0,    0,    0,  306,  306,  306,  306,  306,  306,
			  306,  306,  306,  306,  306,  306,  306,    0,  306,  306,
			    0,  306,  306,  306,    0,    0,    0,  306,   13,   12,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,  257,
			    0,    0,    0,    0,    0,    0,  841,    0,    0,  623,
			  624,  256,    0,    0,  306,    0,    0,    0,    0,    0,
			    0,  862,  306,    0,    0,    0,    0,  867,   88,   87,
			   86,   85,   84,   83,   82,   81,   80,   79,   78,    0,

			  306,  306,    0,    0,    0,    0,    0,    0,    0,    0,
			  872,    0,    0,    0,    0,    0,    0,    0,  144,  145,
			  146,  147,  148,  149,  150,  152,  153,  154,  209,  208,
			    0,    0,    0,    0,    0,  207,  206,  205,  204,    0,
			  203,    0,    0,  202,   54,  201,   52,   14,   51,   50,
			    0,    0,  200,    0,    0,   48,    0,  199,    0,    0,
			  197,    0,  196,    0,  413,   47,   46,    0,  195,    0,
			   57,   56,    0,  194,    0,    0,    0,  404,    0,    0,
			    0,    0,    0,    0,  193,   55,   54,   53,   52,   14,
			   51,   50,    0,   49,    0,    0,    0,   48,    0,  192,

			  191,    0,    0,    0,    0,    0,  190,   47,   46,    0,
			    0,    0,    0,    0,    0,    0,  189,    0,   13,   12,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			   13,   12,   11,   10,    9,    8,    7,    6,    5,    4,
			    3,   45,   44,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,  306,   52,  304,  303,  302,  301,  300,

			  299,  298,  297,  296,  295,  294,  293,  292,  291,  290,
			  289,  207,  306,  305,  304,  303,  302,  301,  300,  299,
			  298,  297,  296,  295,  294,  293,  292,  291,  290,  289,
			  207,  305,  304,  303,  302,  301,  300,  299,  298,  297,
			  296,  295,  294,  293,  292,  291,  290,  289,  207,    0,
			  571,  572,  573,  574,  575,  576,  577,  578,  579,  580,
			  581,  582,  302,  301,  300,  299,  298,  297,  296,  295,
			  294,  293,  292,  291,  290,  289,  207,   45,   44,   43,
			   42,   41,   40,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,    0,

			  259,    0,    0,    0,    0,    0,  306,   93,    0,  873,
			  796,    0,    0,    0,    0,    0,  306,  306,    0,  209,
			  208,    0,  306,  306,  306,  306,  207,  206,  205,  204,
			    0,  203,    0,  258,  202,   54,  201,   52,   14,   51,
			   50,    0,    0,  200,    0,    0,   48,    0,  199,  257,
			    0,  197,    0,  196,    0,    0,   47,   46,    0,  195,
			    0,  256,    0,    0,  194,    0,  255,    0,    0,    0,
			    0,    0,    0,    0,    0,  193,    0,  306,   88,   87,
			   86,   85,   84,   83,   82,   81,   80,   79,   78,    0,
			  192,  191,    0,    0,    0,    0,    0,  190,  306,    0,

			    0,  401,    0,  306,    0,    0,    0,  189,  306,   13,
			   12,   11,   10,    9,    8,    7,    6,    5,    4,    3,
			   45,   44,   43,   42,   41,   40,   39,   38,   37,   36,
			   35,   34,   33,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,  209,  208,    0,    0,    0,    0,    0,  207,
			  206,  205,  204,    0,  203,    0,    0,  202,   54,  201,
			   52,   14,   51,   50,    0,    0,  200,    0,    0,   48,
			    0,  199,    0,  198,  197,    0,  196,    0,    0,   47,
			   46,    0,  195,    0,    0,    0,    0,  194,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  193,  301,

			  300,  299,  298,  297,  296,  295,  294,  293,  292,  291,
			  290,  289,  207,  192,  191,    0,    0,    0,    0,    0,
			  190,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  189,    0,   13,   12,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,  209,  208,    0,    0,    0,
			    0,    0,  207,  206,  205,  204,    0,  203,    0,    0,
			  202,   54,  201,   52,   14,   51,   50,    0,    0,  200,
			    0,    0,   48,    0,  199,    0,    0,  197,    0,  196,

			    0,    0,   47,   46,    0,  195,    0,    0,    0,    0,
			  194,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  193,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  192,  191,    0,    0,
			    0,    0,    0,  190,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  189,    0,   13,   12,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,   45,   44,   43,   42,
			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,  209,  208,
			    0,    0,    0,    0,    0,  207,  206,  205,  204,    0,

			  203,    0,    0,  202,   54,  201,   52,   14,   51,   50,
			    0,    0,  200,    0,    0,   48,    0,  199,    0,    0,
			  437,    0,  196,    0,    0,   47,   46,    0,  195,    0,
			   57,   56,    0,  194,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  193,   55,   54,   53,   52,   14,
			   51,   50,    0,    0,    0,    0,    0,   48,    0,  192,
			  191,    0,    0,    0,    0,    0,  190,   47,   46,    0,
			    0,    0,    0,    0,    0,    0,  436,    0,   13,   12,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,

			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			   13,   12,   11,   10,    9,    8,    7,    6,    5,    4,
			    3,   45,   44,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   57,   56,    0,    0,    0,    0,    0,
			  248,    0,    0,    0,    0,    0,    0,   14,   55,   54,
			   53,   52,    0,   51,    0,    0,    0,    0,    0,    0,
			  247,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			   47,   46,   52,  246,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,  803,    0,    0,    0,    0,
			    0,    0,    0,  650,   52,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  245,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  244,  649,   13,   12,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,    0,
			    0,   14,    0,    0,   45,   44,   43,   42,   41,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   44,  134,   42,   41,
			   40,   39,   38,   37,   36,   35,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,    0,   44,    0,

			   42,   41,   40,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,  138,
			  137,    0,   13,   12,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,    0,   55,    0,    0,    0,   14,  305,
			  304,  303,  302,  301,  300,  299,  298,  297,  296,  295,
			  294,  293,  292,  291,  290,  289,  207,  305,  304,  303,
			  302,  301,  300,  299,  298,  297,  296,  295,  294,  293,
			  292,  291,  290,  289,  207,  810,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  724,    0,
			    0,    0,    0,    0,    0,   14,    0,  723,    0,    0,

			    0,    0,    0,  722,   54,    0,    0,   14,  721,   13,
			   12,   11,   10,    9,    8,    7,    6,    5,    4,    3,
			    0,  720,    0,    0,    0,    0,    0,   14,    0,    0,
			    0,  869,  193,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  810,    0,    0,  192,    0,  800,
			    0,    0,    0,    0,  719,  718,    0,    0,    0,  670,
			    0,   14,    0,    0,    0,    0,   13,   12,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,    0,   13,   12,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,  -31,
			  -31,    0,    0,    0,    0,   14,    0,  -31,   13,   12,

			   11,   10,    9,    8,    7,    6,    5,    4,    3,  -31,
			    0,  -31,  -31,    0,    0,    0,    0,    0,  -31,   14,
			    0,    0,    0,  -32,  -32,    0,    0,    0,    0,    0,
			    0,  -32,   13,   12,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,  -32,  -28,  -32,  -32,  -28,    0,    0,
			    0,  -28,  -32,  -28,    0,  -28,    0,    0,  -28,    0,
			    0,    0,    0,    0,    0,    0,   13,   12,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,   14,    0,    0,
			    0,  -28,    0,    0,    0,    0,    0,    0,    0,    0,
			   13,   12,   11,   10,    9,    8,    7,    6,    5,    4,

			    3,    0,  -29,    0,    0,  -29,    0,    0,    0,  -29,
			    0,  -29,   93,  -29,    0,   92,  -29,    0,    0,    0,
			    0,    0,    0,    0,    0,  267,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   14,    0,  -29,
			    0,    0,    0,    0,    0,    0,   91,    0,   13,   12,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,   90,
			   93,    0,    0,   92,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   89,    0,  163,    0,    0,    0,
			    0,    0,    0,   88,   87,   86,   85,   84,   83,   82,
			   81,   80,   79,   78,   91,   93,  764,    0,   92,    0,

			    0,    0,    0,    0,    0,    0,  -65,   90,   13,   12,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,  414,
			    0,    0,   89,    0,    0,    0,    0,    0,    0,   91,
			   14,   88,   87,   86,   85,   84,   83,   82,   81,   80,
			   79,   78,   90,  765,    0,    0,  -66,    0,  -65,    0,
			    0,    0,    0,    0,    0,    0,    0,   89,   14,    0,
			  -65,    0,    0,    0,    0,    0,   88,   87,   86,   85,
			   84,   83,   82,   81,   80,   79,   78,  -65,  -65,  -65,
			  -65,  -65,  -65,  -65,  -65,  -65,  -65,  -65,  -66,  764,
			  654,    0,    0,    0,    0,    0,    0,    0,   93,    0,

			  -66,   13,   12,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,  478,   14,    0,    0,    0,  -66,  -66,  -66,
			  -66,  -66,  -66,  -66,  -66,  -66,  -66,  -66,   93,   13,
			   12,   11,   10,    9,    8,    7,    6,    5,    4,    3,
			  305,  304,  303,  302,  301,  300,  299,  298,  297,  296,
			  295,  294,  293,  292,  291,  290,  289,  207,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   88,
			   87,   86,   85,   84,   83,   82,   81,   80,   79,   78,
			    0,  785,    0,    0,   13,   12,   11,   10,    9,    8,
			    7,    6,    5,    4,    3,    0,    0,    0,    0,   88,

			   87,   86,   85,   84,   83,   82,   81,   80,   79,   78,
			  305,  304,  303,  302,  301,  300,  299,  298,  297,  296,
			  295,  294,  293,  292,  291,  290,  289,  207,  305,  304,
			  303,  302,  301,  300,  299,  298,  297,  296,  295,  294,
			  293,  292,  291,  290,  289,  207,    0,    0,    0,    0,
			    0,  445,  303,  302,  301,  300,  299,  298,  297,  296,
			  295,  294,  293,  292,  291,  290,  289,  207,    0,  435,
			  305,  304,  303,  302,  301,  300,  299,  298,  297,  296,
			  295,  294,  293,  292,  291,  290,  289,  207,  363,  362,
			  361,  360,  359,  358,  357,  356,  355,  354,  353,  352,

			  351,  350,  349,  348,  347,    0,  346,    0,    0,    0,
			    0,  383,  305,  304,  303,  302,  301,  300,  299,  298,
			  297,  296,  295,  294,  293,  292,  291,  290,  289,  207>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,   16,   73,   92,  317,  318,   16,  117,   16,   16,
			   50,  254,  318,   18,  158,   16,  166,   18,   89,   50,
			   91,  284,   50,  546,   40,   50,  417,  195,  562,   50,
			   16,  184,   25,  548,  425,   22,   65,   77,    0,   50,
			   40,  680,   26,   26,  683,  288,   77,   26,   25,   77,
			   26,   25,   77,   67,    0,   69,   77,   40,   50,   38,
			   53,   38,   91,   56,   38,   65,   77,  310,  311,   53,
			   46,   65,   56,  596,  713,  185,  467,  468,  593,  470,
			   96,   95,  691,  122,  123,   77,   27,   74,   75,   90,
			   40,   92,   50,   99,  100,   45,  135,  136,   61,  114,

			   41,   42,  142,   50,  114,  714,  114,  114,  747,   72,
			   26,  142,   25,  114,  142,  630,   25,  142,   29,   77,
			   31,  142,   38,   39,   65,   38,   61,   62,  114,   70,
			   77,  142,  172,   74,   69,   76,   65,   78,  784,  778,
			  637,  172,   83,   26,  172,   74,   81,  172,  794,   84,
			  142,  172,  543,  650,   40,   38,   39,  197,   65,   37,
			  161,  172,  801,   49,  235,  700,  174,  776,   46,  197,
			   47,  484,  197,  708,   61,   62,  197,   50,  484,  250,
			  172,  252,   69,  792,  142,   40,  197,   29,   40,   31,
			  191,  800,   47,   45,   50,  142,  267,   84,  238,  200,

			  734,   39,   40,   37,   77,  197,   37,  247,  817,   40,
			  238,   50,   65,  238,  172,   64,  247,  238,  461,  247,
			  281,   77,  247,   74,  833,  172,  247,  238,   79,   63,
			   64,   65,   66,  649,   63,  651,  247,   99,   77,  197,
			  241,  242,  243,    3,   78,    3,  238,   50,   41,   42,
			  197,    3,  253,  254,  863,  247,   40,   91,   39,   40,
			  869,   45,  323,  324,  873,   99,  100,  101,   57,  142,
			    3,   60,   65,   65,   77,   46,   68,   70,  339,   25,
			  238,   74,   71,  284,   73,   78,  142,  288,   77,  247,
			   65,  238,  829,  830,  831,  832,   88,   89,  100,  172,

			  247,  469,   94,  142,  101,   97,  307,   25,   65,  310,
			  311,   65,  422,   70,   63,   72,  172,   74,  471,   47,
			   48,   78,  490,   78,  197,   47,   48,   47,  329,  330,
			  331,   65,   26,  172,  335,   65,   70,   37,   72,  142,
			   74,  197,   47,  414,   78,   47,   48,  408,   37,   47,
			   48,   35,   41,   42,   47,   48,   47,   48,  197,   16,
			   17,   18,   19,   20,   21,  238,   47,   48,  369,  172,
			  431,  432,  433,   47,  247,   47,   65,   47,   48,   47,
			  441,   70,  238,   47,   48,   74,   47,  448,  556,   78,
			   25,  247,   47,   48,  197,   47,   48,  437,   47,  238,

			   47,   33,   20,   21,   41,   42,   25,   26,  247,  437,
			   25,   47,  437,   47,   46,   25,  437,   47,  681,  587,
			  588,   47,   25,   65,  180,  688,  437,   96,  429,   37,
			   27,   91,   63,   66,   90,  238,   81,   49,  591,   83,
			   94,   65,   65,   48,  247,  437,   28,  203,  204,   74,
			  206,   33,  208,  209,   65,   45,  566,   74,   65,  460,
			  461,  462,   40,   26,  220,   39,   88,   47,   47,   26,
			   47,  532,  104,  105,  106,  107,  108,  109,  110,  437,
			  112,  113,  114,   47,  555,   47,   47,   47,   47,   47,
			  437,   47,  248,   75,   47,   47,   72,   97,  499,  500,

			   65,   46,   40,  259,   55,   87,  659,  568,  569,   48,
			   85,  664,   47,   25,   68,   65,   47,  518,   25,   38,
			   25,   25,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  289,  290,  291,  292,  293,  294,  295,
			  296,  297,  298,  299,  300,  301,  302,  303,  304,  305,
			  306,   78,  702,  706,   70,   45,   40,  313,   47,   85,
			  561,   85,   61,   62,  437,  605,   65,   85,   85,   47,
			   69,   85,   85,   47,  605,   74,   85,  605,  334,   85,
			  605,  437,   81,   85,  605,   84,   47,   85,   85,   41,
			   37,   44,   91,  103,  605,   40,   25,   25,  437,  709,

			   99,  100,  603,   49,   25,   46,   26,   33,  648,   40,
			   50,  367,   49,  605,   76,   48,   29,  648,   29,   35,
			  648,  636,  766,  648,   47,   69,  636,  648,  636,  636,
			   65,   46,   39,   58,  437,  560,  637,  648,  608,  413,
			  413,  791,  643,  553,  413,  401,  647,  605,  404,  650,
			  655,  795,  199,  477,  655,  170,  648,  697,  605,  603,
			  437,  666,  688,  701,  808,  666,  697,  238,  653,  697,
			  642,  515,  697,  587,  709,  825,  697,  192,  429,  709,
			  681,  721,  709,  723,  708,  234,  697,  688,  834,  709,
			  648,  709,  723,  721,  188,  723,  721,  709,  723,  423,

			  721,  648,  723,  840,  487,  697,  709,  796,  709,  542,
			  721,  709,  723,   14,   15,   16,   17,   18,   19,   20,
			   21,  722,  321,  799,  636,  765,  114,  709,  429,  721,
			   -1,  723,  605,   -1,  765,   -1,   -1,  765,   -1,  697,
			  765,  830,  831,  832,  765,  834,   -1,   -1,   -1,  605,
			  697,   -1,   -1,   -1,  765,   -1,   -1,  828,   -1,  515,
			   -1,   -1,   -1,  721,   -1,  723,  605,   -1,   -1,   -1,
			   -1,   -1,   -1,  765,  721,  648,  723,   -1,   -1,   -1,
			   -1,  796,   -1,  784,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  648,  794,   -1,  796,   -1,   -1,   63,   64,

			   65,   66,  605,   -1,   -1,   -1,   -1,  765,   -1,  648,
			   -1,   -1,  327,   78,  829,  830,   -1,  832,  765,  834,
			   -1,  822,   -1,   -1,  697,   -1,   91,   -1,  829,  830,
			  831,  832,   -1,  834,   99,  100,  101,   -1,   -1,   -1,
			   -1,  697,   -1,   -1,   -1,  648,   -1,   -1,  721,   -1,
			  723,   -1,   -1,   -1,  218,   -1,   -1,   -1,  697,   -1,
			   -1,   -1,   -1,   -1,   -1,  721,   -1,  723,   -1,   -1,
			   -1,   -1,   -1,  874,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  721,   -1,  723,   -1,   -1,  643,   -1,   -1,
			   -1,   -1,  765,   -1,  697,   -1,   -1,   -1,   -1,   -1,

			  264,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  765,
			   -1,   -1,   -1,   14,   15,  671,   -1,   -1,  282,  283,
			  723,  285,  286,  287,   -1,   -1,  765,  442,   29,   -1,
			   -1,   -1,   33,   -1,  449,  450,  451,  452,  453,  454,
			  455,  456,  457,  458,  459,  309,   98,   99,  100,  101,
			  102,  103,  104,  105,  106,  107,  108,   -1,   14,   15,
			   -1,   -1,  765,   -1,   -1,   -1,   -1,   -1,  724,  333,
			   -1,   -1,   -1,   29,   30,   -1,   -1,   33,   -1,   -1,
			   -1,  133,   -1,   -1,  136,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  751,  752,   -1,   -1,   -1,

			   -1,  365,   -1,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,   70,  771,  772,   33,  774,  775,
			   -1,   -1,   -1,   -1,  388,  389,  390,  391,  392,  393,
			  394,  395,  396,  397,  398,  399,  400,   -1,  402,  403,
			   -1,  405,  406,  407,   -1,   -1,   -1,  411,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   75,
			   -1,   -1,   -1,   -1,   -1,   -1,  822,   -1,   -1,  584,
			  585,   87,   -1,   -1,  438,   -1,   -1,   -1,   -1,   -1,
			   -1,  837,  446,   -1,   -1,   -1,   -1,  843,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   -1,

			  464,  465,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  866,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  270,  271,
			  272,  273,  274,  275,  276,  277,  278,  279,   14,   15,
			   -1,   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,
			   26,   -1,   -1,   29,   30,   31,   32,   33,   34,   35,
			   -1,   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   -1,
			   46,   -1,   48,   -1,  316,   51,   52,   -1,   54,   -1,
			   14,   15,   -1,   59,   -1,   -1,   -1,   63,   -1,   -1,
			   -1,   -1,   -1,   -1,   70,   29,   30,   31,   32,   33,
			   34,   35,   -1,   37,   -1,   -1,   -1,   41,   -1,   85,

			   86,   -1,   -1,   -1,   -1,   -1,   92,   51,   52,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  102,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,  657,   32,    5,    6,    7,    8,    9,

			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,  676,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   -1,
			  502,  503,  504,  505,  506,  507,  508,  509,  510,  511,
			  512,  513,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,  131,  132,  133,  134,  135,  136,   -1,

			   26,   -1,   -1,   -1,   -1,   -1,  770,   33,   -1,   82,
			  101,   -1,   -1,   -1,   -1,   -1,  780,  781,   -1,   14,
			   15,   -1,  786,  787,  788,  789,   21,   22,   23,   24,
			   -1,   26,   -1,   59,   29,   30,   31,   32,   33,   34,
			   35,   -1,   -1,   38,   -1,   -1,   41,   -1,   43,   75,
			   -1,   46,   -1,   48,   -1,   -1,   51,   52,   -1,   54,
			   -1,   87,   -1,   -1,   59,   -1,   92,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   70,   -1,  841,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   -1,
			   85,   86,   -1,   -1,   -1,   -1,   -1,   92,  862,   -1,

			   -1,   96,   -1,  867,   -1,   -1,   -1,  102,  872,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,   14,   15,   -1,   -1,   -1,   -1,   -1,   21,
			   22,   23,   24,   -1,   26,   -1,   -1,   29,   30,   31,
			   32,   33,   34,   35,   -1,   -1,   38,   -1,   -1,   41,
			   -1,   43,   -1,   45,   46,   -1,   48,   -1,   -1,   51,
			   52,   -1,   54,   -1,   -1,   -1,   -1,   59,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   70,    8,

			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   85,   86,   -1,   -1,   -1,   -1,   -1,
			   92,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  102,   -1,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,
			  132,  133,  134,  135,  136,   14,   15,   -1,   -1,   -1,
			   -1,   -1,   21,   22,   23,   24,   -1,   26,   -1,   -1,
			   29,   30,   31,   32,   33,   34,   35,   -1,   -1,   38,
			   -1,   -1,   41,   -1,   43,   -1,   -1,   46,   -1,   48,

			   -1,   -1,   51,   52,   -1,   54,   -1,   -1,   -1,   -1,
			   59,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   70,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   85,   86,   -1,   -1,
			   -1,   -1,   -1,   92,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  102,   -1,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,   14,   15,
			   -1,   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,

			   26,   -1,   -1,   29,   30,   31,   32,   33,   34,   35,
			   -1,   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   -1,
			   46,   -1,   48,   -1,   -1,   51,   52,   -1,   54,   -1,
			   14,   15,   -1,   59,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   70,   29,   30,   31,   32,   33,
			   34,   35,   -1,   -1,   -1,   -1,   -1,   41,   -1,   85,
			   86,   -1,   -1,   -1,   -1,   -1,   92,   51,   52,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  102,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,

			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,   14,   15,   -1,   -1,   -1,   -1,   -1,
			   26,   -1,   -1,   -1,   -1,   -1,   -1,   33,   29,   30,
			   31,   32,   -1,   34,   -1,   -1,   -1,   -1,   -1,   -1,
			   46,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   51,   52,   32,   59,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   45,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   74,   32,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   92,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  102,   98,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   -1,
			   -1,   33,   -1,   -1,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,  116,   59,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,  132,  133,  134,  135,  136,   -1,  116,   -1,

			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,  131,  132,  133,  134,  135,  136,   14,
			   15,   -1,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   -1,   29,   -1,   -1,   -1,   33,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,    4,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   70,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   26,   -1,
			   -1,   -1,   -1,   -1,   -1,   33,   -1,   35,   -1,   -1,

			   -1,   -1,   -1,   41,   30,   -1,   -1,   33,   46,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			   -1,   59,   -1,   -1,   -1,   -1,   -1,   33,   -1,   -1,
			   -1,   96,   70,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   70,   -1,   -1,   85,   -1,   96,
			   -1,   -1,   -1,   -1,   92,   93,   -1,   -1,   -1,   65,
			   -1,   33,   -1,   -1,   -1,   -1,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   61,
			   62,   -1,   -1,   -1,   -1,   33,   -1,   69,  104,  105,

			  106,  107,  108,  109,  110,  111,  112,  113,  114,   81,
			   -1,   83,   84,   -1,   -1,   -1,   -1,   -1,   90,   33,
			   -1,   -1,   -1,   61,   62,   -1,   -1,   -1,   -1,   -1,
			   -1,   69,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   81,   58,   83,   84,   61,   -1,   -1,
			   -1,   65,   90,   67,   -1,   69,   -1,   -1,   72,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   33,   -1,   -1,
			   -1,   95,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,

			  114,   -1,   58,   -1,   -1,   61,   -1,   -1,   -1,   65,
			   -1,   67,   33,   69,   -1,   36,   72,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   46,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   33,   -1,   95,
			   -1,   -1,   -1,   -1,   -1,   -1,   67,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   80,
			   33,   -1,   -1,   36,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   95,   -1,   49,   -1,   -1,   -1,
			   -1,   -1,   -1,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,   67,   33,   92,   -1,   36,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   33,   80,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   46,
			   -1,   -1,   95,   -1,   -1,   -1,   -1,   -1,   -1,   67,
			   33,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   80,   46,   -1,   -1,   33,   -1,   75,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   95,   33,   -1,
			   87,   -1,   -1,   -1,   -1,   -1,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,   75,   92,
			   65,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   33,   -1,

			   87,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   47,   33,   -1,   -1,   -1,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,   33,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			   -1,   45,   -1,   -1,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,   -1,   -1,   -1,   -1,  104,

			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   -1,   -1,   -1,   -1,
			   -1,   45,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   -1,   45,
			    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,

			  130,  131,  132,  133,  134,   -1,  136,   -1,   -1,   -1,
			   -1,   45,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21>>)
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

	yytype69 (v: ANY): FEATURE_NAME is
		require
			valid_type: yyis_type69 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type69 (v: ANY): BOOLEAN is
		local
			u: FEATURE_NAME
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

	yytype73 (v: ANY): INTEGER is
		require
			valid_type: yyis_type73 (v)
		local
			ref: INTEGER_REF
		do
			ref ?= v
			Result := ref.item
		end

	yyis_type73 (v: ANY): BOOLEAN is
		local
			u: INTEGER_REF
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

	yytype85 (v: ANY): CLICK_AST is
		require
			valid_type: yyis_type85 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type85 (v: ANY): BOOLEAN is
		local
			u: CLICK_AST
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

	yyFinal: INTEGER is 881
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 137
			-- Number of tokens

	yyLast: INTEGER is 2829
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
