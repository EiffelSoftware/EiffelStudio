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
--|#line 175
	yy_do_action_1
when 2 then
--|#line 217
	yy_do_action_2
when 3 then
--|#line 226
	yy_do_action_3
when 4 then
--|#line 228
	yy_do_action_4
when 5 then
--|#line 230
	yy_do_action_5
when 6 then
--|#line 232
	yy_do_action_6
when 7 then
--|#line 234
	yy_do_action_7
when 8 then
--|#line 236
	yy_do_action_8
when 9 then
--|#line 238
	yy_do_action_9
when 10 then
--|#line 240
	yy_do_action_10
when 11 then
--|#line 242
	yy_do_action_11
when 12 then
--|#line 244
	yy_do_action_12
when 13 then
--|#line 246
	yy_do_action_13
when 14 then
--|#line 248
	yy_do_action_14
when 15 then
--|#line 252
	yy_do_action_15
when 16 then
--|#line 256
	yy_do_action_16
when 17 then
--|#line 260
	yy_do_action_17
when 18 then
--|#line 264
	yy_do_action_18
when 19 then
--|#line 268
	yy_do_action_19
when 20 then
--|#line 272
	yy_do_action_20
when 21 then
--|#line 276
	yy_do_action_21
when 22 then
--|#line 280
	yy_do_action_22
when 23 then
--|#line 284
	yy_do_action_23
when 24 then
--|#line 288
	yy_do_action_24
when 25 then
--|#line 292
	yy_do_action_25
when 26 then
--|#line 296
	yy_do_action_26
when 28 then
--|#line 306
	yy_do_action_28
when 31 then
--|#line 314
	yy_do_action_31
when 32 then
--|#line 316
	yy_do_action_32
when 34 then
--|#line 322
	yy_do_action_34
when 35 then
--|#line 324
	yy_do_action_35
when 36 then
--|#line 328
	yy_do_action_36
when 37 then
--|#line 333
	yy_do_action_37
when 38 then
--|#line 340
	yy_do_action_38
when 39 then
--|#line 344
	yy_do_action_39
when 41 then
--|#line 350
	yy_do_action_41
when 42 then
--|#line 355
	yy_do_action_42
when 43 then
--|#line 360
	yy_do_action_43
when 44 then
--|#line 367
	yy_do_action_44
when 45 then
--|#line 369
	yy_do_action_45
when 46 then
--|#line 371
	yy_do_action_46
when 47 then
--|#line 381
	yy_do_action_47
when 48 then
--|#line 387
	yy_do_action_48
when 49 then
--|#line 394
	yy_do_action_49
when 50 then
--|#line 400
	yy_do_action_50
when 51 then
--|#line 408
	yy_do_action_51
when 52 then
--|#line 412
	yy_do_action_52
when 53 then
--|#line 423
	yy_do_action_53
when 54 then
--|#line 427
	yy_do_action_54
when 56 then
--|#line 444
	yy_do_action_56
when 58 then
--|#line 453
	yy_do_action_58
when 59 then
--|#line 462
	yy_do_action_59
when 60 then
--|#line 467
	yy_do_action_60
when 61 then
--|#line 474
	yy_do_action_61
when 62 then
--|#line 476
	yy_do_action_62
when 63 then
--|#line 480
	yy_do_action_63
when 64 then
--|#line 480
	yy_do_action_64
when 66 then
--|#line 491
	yy_do_action_66
when 67 then
--|#line 495
	yy_do_action_67
when 68 then
--|#line 500
	yy_do_action_68
when 69 then
--|#line 504
	yy_do_action_69
when 70 then
--|#line 510
	yy_do_action_70
when 71 then
--|#line 518
	yy_do_action_71
when 72 then
--|#line 523
	yy_do_action_72
when 77 then
--|#line 538
	yy_do_action_77
when 78 then
--|#line 551
	yy_do_action_78
when 79 then
--|#line 553
	yy_do_action_79
when 80 then
--|#line 560
	yy_do_action_80
when 81 then
--|#line 564
	yy_do_action_81
when 82 then
--|#line 566
	yy_do_action_82
when 83 then
--|#line 570
	yy_do_action_83
when 84 then
--|#line 572
	yy_do_action_84
when 85 then
--|#line 574
	yy_do_action_85
when 86 then
--|#line 578
	yy_do_action_86
when 87 then
--|#line 583
	yy_do_action_87
when 88 then
--|#line 587
	yy_do_action_88
when 89 then
--|#line 591
	yy_do_action_89
when 90 then
--|#line 593
	yy_do_action_90
when 91 then
--|#line 597
	yy_do_action_91
when 92 then
--|#line 602
	yy_do_action_92
when 93 then
--|#line 607
	yy_do_action_93
when 95 then
--|#line 620
	yy_do_action_95
when 96 then
--|#line 622
	yy_do_action_96
when 97 then
--|#line 626
	yy_do_action_97
when 98 then
--|#line 631
	yy_do_action_98
when 99 then
--|#line 638
	yy_do_action_99
when 100 then
--|#line 643
	yy_do_action_100
when 101 then
--|#line 651
	yy_do_action_101
when 102 then
--|#line 656
	yy_do_action_102
when 103 then
--|#line 661
	yy_do_action_103
when 104 then
--|#line 666
	yy_do_action_104
when 105 then
--|#line 671
	yy_do_action_105
when 106 then
--|#line 676
	yy_do_action_106
when 107 then
--|#line 681
	yy_do_action_107
when 109 then
--|#line 691
	yy_do_action_109
when 110 then
--|#line 695
	yy_do_action_110
when 111 then
--|#line 700
	yy_do_action_111
when 112 then
--|#line 707
	yy_do_action_112
when 114 then
--|#line 713
	yy_do_action_114
when 115 then
--|#line 717
	yy_do_action_115
when 117 then
--|#line 723
	yy_do_action_117
when 118 then
--|#line 728
	yy_do_action_118
when 119 then
--|#line 735
	yy_do_action_119
when 120 then
--|#line 739
	yy_do_action_120
when 121 then
--|#line 741
	yy_do_action_121
when 122 then
--|#line 745
	yy_do_action_122
when 123 then
--|#line 750
	yy_do_action_123
when 125 then
--|#line 759
	yy_do_action_125
when 127 then
--|#line 765
	yy_do_action_127
when 129 then
--|#line 771
	yy_do_action_129
when 131 then
--|#line 777
	yy_do_action_131
when 133 then
--|#line 783
	yy_do_action_133
when 135 then
--|#line 789
	yy_do_action_135
when 137 then
--|#line 799
	yy_do_action_137
when 139 then
--|#line 805
	yy_do_action_139
when 140 then
--|#line 809
	yy_do_action_140
when 141 then
--|#line 814
	yy_do_action_141
when 142 then
--|#line 821
	yy_do_action_142
when 144 then
--|#line 826
	yy_do_action_144
when 146 then
--|#line 837
	yy_do_action_146
when 147 then
--|#line 841
	yy_do_action_147
when 148 then
--|#line 846
	yy_do_action_148
when 149 then
--|#line 853
	yy_do_action_149
when 150 then
--|#line 857
	yy_do_action_150
when 151 then
--|#line 863
	yy_do_action_151
when 152 then
--|#line 871
	yy_do_action_152
when 153 then
--|#line 873
	yy_do_action_153
when 155 then
--|#line 879
	yy_do_action_155
when 156 then
--|#line 883
	yy_do_action_156
when 157 then
--|#line 883
	yy_do_action_157
when 158 then
--|#line 895
	yy_do_action_158
when 159 then
--|#line 897
	yy_do_action_159
when 160 then
--|#line 899
	yy_do_action_160
when 161 then
--|#line 903
	yy_do_action_161
when 162 then
--|#line 907
	yy_do_action_162
when 163 then
--|#line 907
	yy_do_action_163
when 165 then
--|#line 915
	yy_do_action_165
when 166 then
--|#line 919
	yy_do_action_166
when 167 then
--|#line 921
	yy_do_action_167
when 169 then
--|#line 927
	yy_do_action_169
when 171 then
--|#line 933
	yy_do_action_171
when 172 then
--|#line 937
	yy_do_action_172
when 173 then
--|#line 942
	yy_do_action_173
when 174 then
--|#line 949
	yy_do_action_174
when 177 then
--|#line 957
	yy_do_action_177
when 178 then
--|#line 959
	yy_do_action_178
when 179 then
--|#line 961
	yy_do_action_179
when 180 then
--|#line 963
	yy_do_action_180
when 181 then
--|#line 965
	yy_do_action_181
when 182 then
--|#line 967
	yy_do_action_182
when 183 then
--|#line 969
	yy_do_action_183
when 184 then
--|#line 971
	yy_do_action_184
when 185 then
--|#line 973
	yy_do_action_185
when 186 then
--|#line 975
	yy_do_action_186
when 188 then
--|#line 981
	yy_do_action_188
when 189 then
--|#line 981
	yy_do_action_189
when 190 then
--|#line 988
	yy_do_action_190
when 191 then
--|#line 988
	yy_do_action_191
when 193 then
--|#line 999
	yy_do_action_193
when 194 then
--|#line 999
	yy_do_action_194
when 195 then
--|#line 1006
	yy_do_action_195
when 196 then
--|#line 1006
	yy_do_action_196
when 198 then
--|#line 1017
	yy_do_action_198
when 199 then
--|#line 1026
	yy_do_action_199
when 200 then
--|#line 1031
	yy_do_action_200
when 201 then
--|#line 1038
	yy_do_action_201
when 202 then
--|#line 1042
	yy_do_action_202
when 203 then
--|#line 1044
	yy_do_action_203
when 205 then
--|#line 1054
	yy_do_action_205
when 206 then
--|#line 1056
	yy_do_action_206
when 207 then
--|#line 1060
	yy_do_action_207
when 208 then
--|#line 1062
	yy_do_action_208
when 209 then
--|#line 1064
	yy_do_action_209
when 210 then
--|#line 1066
	yy_do_action_210
when 211 then
--|#line 1068
	yy_do_action_211
when 212 then
--|#line 1070
	yy_do_action_212
when 213 then
--|#line 1074
	yy_do_action_213
when 214 then
--|#line 1076
	yy_do_action_214
when 215 then
--|#line 1078
	yy_do_action_215
when 216 then
--|#line 1080
	yy_do_action_216
when 217 then
--|#line 1082
	yy_do_action_217
when 218 then
--|#line 1084
	yy_do_action_218
when 219 then
--|#line 1086
	yy_do_action_219
when 220 then
--|#line 1088
	yy_do_action_220
when 221 then
--|#line 1090
	yy_do_action_221
when 222 then
--|#line 1092
	yy_do_action_222
when 223 then
--|#line 1094
	yy_do_action_223
when 224 then
--|#line 1096
	yy_do_action_224
when 227 then
--|#line 1104
	yy_do_action_227
when 228 then
--|#line 1108
	yy_do_action_228
when 229 then
--|#line 1113
	yy_do_action_229
when 230 then
--|#line 1124
	yy_do_action_230
when 231 then
--|#line 1130
	yy_do_action_231
when 233 then
--|#line 1140
	yy_do_action_233
when 234 then
--|#line 1144
	yy_do_action_234
when 235 then
--|#line 1149
	yy_do_action_235
when 236 then
--|#line 1156
	yy_do_action_236
when 237 then
--|#line 1156
	yy_do_action_237
when 238 then
--|#line 1166
	yy_do_action_238
when 239 then
--|#line 1168
	yy_do_action_239
when 241 then
--|#line 1178
	yy_do_action_241
when 242 then
--|#line 1186
	yy_do_action_242
when 244 then
--|#line 1195
	yy_do_action_244
when 245 then
--|#line 1199
	yy_do_action_245
when 246 then
--|#line 1204
	yy_do_action_246
when 247 then
--|#line 1211
	yy_do_action_247
when 249 then
--|#line 1217
	yy_do_action_249
when 250 then
--|#line 1221
	yy_do_action_250
when 252 then
--|#line 1230
	yy_do_action_252
when 253 then
--|#line 1234
	yy_do_action_253
when 254 then
--|#line 1239
	yy_do_action_254
when 255 then
--|#line 1246
	yy_do_action_255
when 256 then
--|#line 1250
	yy_do_action_256
when 257 then
--|#line 1255
	yy_do_action_257
when 258 then
--|#line 1262
	yy_do_action_258
when 259 then
--|#line 1264
	yy_do_action_259
when 260 then
--|#line 1266
	yy_do_action_260
when 261 then
--|#line 1268
	yy_do_action_261
when 262 then
--|#line 1270
	yy_do_action_262
when 263 then
--|#line 1272
	yy_do_action_263
when 264 then
--|#line 1274
	yy_do_action_264
when 265 then
--|#line 1276
	yy_do_action_265
when 266 then
--|#line 1278
	yy_do_action_266
when 267 then
--|#line 1280
	yy_do_action_267
when 269 then
--|#line 1286
	yy_do_action_269
when 270 then
--|#line 1295
	yy_do_action_270
when 272 then
--|#line 1304
	yy_do_action_272
when 274 then
--|#line 1310
	yy_do_action_274
when 275 then
--|#line 1310
	yy_do_action_275
when 277 then
--|#line 1322
	yy_do_action_277
when 278 then
--|#line 1324
	yy_do_action_278
when 279 then
--|#line 1328
	yy_do_action_279
when 282 then
--|#line 1339
	yy_do_action_282
when 283 then
--|#line 1343
	yy_do_action_283
when 284 then
--|#line 1348
	yy_do_action_284
when 285 then
--|#line 1355
	yy_do_action_285
when 287 then
--|#line 1361
	yy_do_action_287
when 288 then
--|#line 1370
	yy_do_action_288
when 289 then
--|#line 1372
	yy_do_action_289
when 290 then
--|#line 1376
	yy_do_action_290
when 291 then
--|#line 1378
	yy_do_action_291
when 293 then
--|#line 1384
	yy_do_action_293
when 294 then
--|#line 1388
	yy_do_action_294
when 295 then
--|#line 1393
	yy_do_action_295
when 296 then
--|#line 1400
	yy_do_action_296
when 297 then
--|#line 1406
	yy_do_action_297
when 298 then
--|#line 1411
	yy_do_action_298
when 299 then
--|#line 1416
	yy_do_action_299
when 300 then
--|#line 1421
	yy_do_action_300
when 301 then
--|#line 1426
	yy_do_action_301
when 302 then
--|#line 1433
	yy_do_action_302
when 303 then
--|#line 1436
	yy_do_action_303
when 304 then
--|#line 1438
	yy_do_action_304
when 305 then
--|#line 1440
	yy_do_action_305
when 306 then
--|#line 1442
	yy_do_action_306
when 307 then
--|#line 1444
	yy_do_action_307
when 308 then
--|#line 1446
	yy_do_action_308
when 309 then
--|#line 1448
	yy_do_action_309
when 310 then
--|#line 1450
	yy_do_action_310
when 311 then
--|#line 1452
	yy_do_action_311
when 312 then
--|#line 1454
	yy_do_action_312
when 313 then
--|#line 1456
	yy_do_action_313
when 314 then
--|#line 1458
	yy_do_action_314
when 315 then
--|#line 1460
	yy_do_action_315
when 317 then
--|#line 1466
	yy_do_action_317
when 318 then
--|#line 1470
	yy_do_action_318
when 319 then
--|#line 1475
	yy_do_action_319
when 320 then
--|#line 1482
	yy_do_action_320
when 321 then
--|#line 1484
	yy_do_action_321
when 322 then
--|#line 1486
	yy_do_action_322
when 323 then
--|#line 1488
	yy_do_action_323
when 324 then
--|#line 1490
	yy_do_action_324
when 325 then
--|#line 1492
	yy_do_action_325
when 326 then
--|#line 1494
	yy_do_action_326
when 327 then
--|#line 1496
	yy_do_action_327
when 328 then
--|#line 1498
	yy_do_action_328
when 329 then
--|#line 1500
	yy_do_action_329
when 330 then
--|#line 1502
	yy_do_action_330
when 331 then
--|#line 1504
	yy_do_action_331
when 332 then
--|#line 1506
	yy_do_action_332
when 333 then
--|#line 1508
	yy_do_action_333
when 334 then
--|#line 1510
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
--|#line 1522
	yy_do_action_338
when 339 then
--|#line 1524
	yy_do_action_339
when 341 then
--|#line 1530
	yy_do_action_341
when 342 then
--|#line 1534
	yy_do_action_342
when 343 then
--|#line 1536
	yy_do_action_343
when 345 then
--|#line 1542
	yy_do_action_345
when 346 then
--|#line 1550
	yy_do_action_346
when 347 then
--|#line 1552
	yy_do_action_347
when 348 then
--|#line 1554
	yy_do_action_348
when 349 then
--|#line 1556
	yy_do_action_349
when 350 then
--|#line 1558
	yy_do_action_350
when 351 then
--|#line 1560
	yy_do_action_351
when 352 then
--|#line 1562
	yy_do_action_352
when 353 then
--|#line 1566
	yy_do_action_353
when 354 then
--|#line 1577
	yy_do_action_354
when 355 then
--|#line 1579
	yy_do_action_355
when 356 then
--|#line 1581
	yy_do_action_356
when 357 then
--|#line 1583
	yy_do_action_357
when 358 then
--|#line 1585
	yy_do_action_358
when 359 then
--|#line 1587
	yy_do_action_359
when 360 then
--|#line 1589
	yy_do_action_360
when 361 then
--|#line 1591
	yy_do_action_361
when 362 then
--|#line 1593
	yy_do_action_362
when 363 then
--|#line 1595
	yy_do_action_363
when 364 then
--|#line 1597
	yy_do_action_364
when 365 then
--|#line 1599
	yy_do_action_365
when 366 then
--|#line 1601
	yy_do_action_366
when 367 then
--|#line 1603
	yy_do_action_367
when 368 then
--|#line 1605
	yy_do_action_368
when 369 then
--|#line 1607
	yy_do_action_369
when 370 then
--|#line 1609
	yy_do_action_370
when 371 then
--|#line 1611
	yy_do_action_371
when 372 then
--|#line 1613
	yy_do_action_372
when 373 then
--|#line 1615
	yy_do_action_373
when 374 then
--|#line 1617
	yy_do_action_374
when 375 then
--|#line 1619
	yy_do_action_375
when 376 then
--|#line 1621
	yy_do_action_376
when 377 then
--|#line 1623
	yy_do_action_377
when 378 then
--|#line 1625
	yy_do_action_378
when 379 then
--|#line 1627
	yy_do_action_379
when 380 then
--|#line 1629
	yy_do_action_380
when 381 then
--|#line 1631
	yy_do_action_381
when 382 then
--|#line 1633
	yy_do_action_382
when 383 then
--|#line 1635
	yy_do_action_383
when 384 then
--|#line 1637
	yy_do_action_384
when 385 then
--|#line 1639
	yy_do_action_385
when 386 then
--|#line 1641
	yy_do_action_386
when 387 then
--|#line 1643
	yy_do_action_387
when 388 then
--|#line 1645
	yy_do_action_388
when 389 then
--|#line 1647
	yy_do_action_389
when 390 then
--|#line 1651
	yy_do_action_390
when 391 then
--|#line 1659
	yy_do_action_391
when 392 then
--|#line 1661
	yy_do_action_392
when 393 then
--|#line 1663
	yy_do_action_393
when 394 then
--|#line 1665
	yy_do_action_394
when 395 then
--|#line 1667
	yy_do_action_395
when 396 then
--|#line 1669
	yy_do_action_396
when 397 then
--|#line 1671
	yy_do_action_397
when 398 then
--|#line 1673
	yy_do_action_398
when 399 then
--|#line 1675
	yy_do_action_399
when 400 then
--|#line 1677
	yy_do_action_400
when 401 then
--|#line 1681
	yy_do_action_401
when 402 then
--|#line 1685
	yy_do_action_402
when 403 then
--|#line 1689
	yy_do_action_403
when 404 then
--|#line 1693
	yy_do_action_404
when 405 then
--|#line 1697
	yy_do_action_405
when 406 then
--|#line 1701
	yy_do_action_406
when 407 then
--|#line 1703
	yy_do_action_407
when 408 then
--|#line 1705
	yy_do_action_408
when 409 then
--|#line 1707
	yy_do_action_409
when 410 then
--|#line 1709
	yy_do_action_410
when 411 then
--|#line 1711
	yy_do_action_411
when 412 then
--|#line 1713
	yy_do_action_412
when 413 then
--|#line 1715
	yy_do_action_413
when 414 then
--|#line 1717
	yy_do_action_414
when 415 then
--|#line 1719
	yy_do_action_415
when 416 then
--|#line 1721
	yy_do_action_416
when 417 then
--|#line 1723
	yy_do_action_417
when 418 then
--|#line 1725
	yy_do_action_418
when 419 then
--|#line 1727
	yy_do_action_419
when 420 then
--|#line 1731
	yy_do_action_420
when 421 then
--|#line 1733
	yy_do_action_421
when 422 then
--|#line 1737
	yy_do_action_422
when 423 then
--|#line 1739
	yy_do_action_423
when 424 then
--|#line 1743
	yy_do_action_424
when 425 then
--|#line 1756
	yy_do_action_425
when 428 then
--|#line 1764
	yy_do_action_428
when 429 then
--|#line 1768
	yy_do_action_429
when 430 then
--|#line 1773
	yy_do_action_430
when 431 then
--|#line 1780
	yy_do_action_431
when 432 then
--|#line 1782
	yy_do_action_432
when 433 then
--|#line 1786
	yy_do_action_433
when 434 then
--|#line 1791
	yy_do_action_434
when 435 then
--|#line 1802
	yy_do_action_435
when 436 then
--|#line 1804
	yy_do_action_436
when 437 then
--|#line 1806
	yy_do_action_437
when 438 then
--|#line 1808
	yy_do_action_438
when 439 then
--|#line 1810
	yy_do_action_439
when 440 then
--|#line 1812
	yy_do_action_440
when 441 then
--|#line 1814
	yy_do_action_441
when 442 then
--|#line 1816
	yy_do_action_442
when 443 then
--|#line 1818
	yy_do_action_443
when 444 then
--|#line 1820
	yy_do_action_444
when 445 then
--|#line 1822
	yy_do_action_445
when 446 then
--|#line 1824
	yy_do_action_446
when 447 then
--|#line 1828
	yy_do_action_447
when 448 then
--|#line 1830
	yy_do_action_448
when 449 then
--|#line 1832
	yy_do_action_449
when 450 then
--|#line 1834
	yy_do_action_450
when 451 then
--|#line 1836
	yy_do_action_451
when 452 then
--|#line 1838
	yy_do_action_452
when 453 then
--|#line 1842
	yy_do_action_453
when 454 then
--|#line 1844
	yy_do_action_454
when 455 then
--|#line 1846
	yy_do_action_455
when 456 then
--|#line 1861
	yy_do_action_456
when 457 then
--|#line 1863
	yy_do_action_457
when 458 then
--|#line 1865
	yy_do_action_458
when 459 then
--|#line 1869
	yy_do_action_459
when 460 then
--|#line 1871
	yy_do_action_460
when 461 then
--|#line 1875
	yy_do_action_461
when 462 then
--|#line 1882
	yy_do_action_462
when 463 then
--|#line 1897
	yy_do_action_463
when 464 then
--|#line 1912
	yy_do_action_464
when 465 then
--|#line 1930
	yy_do_action_465
when 466 then
--|#line 1932
	yy_do_action_466
when 467 then
--|#line 1934
	yy_do_action_467
when 468 then
--|#line 1941
	yy_do_action_468
when 469 then
--|#line 1945
	yy_do_action_469
when 470 then
--|#line 1947
	yy_do_action_470
when 471 then
--|#line 1949
	yy_do_action_471
when 472 then
--|#line 1953
	yy_do_action_472
when 473 then
--|#line 1955
	yy_do_action_473
when 474 then
--|#line 1957
	yy_do_action_474
when 475 then
--|#line 1959
	yy_do_action_475
when 476 then
--|#line 1961
	yy_do_action_476
when 477 then
--|#line 1963
	yy_do_action_477
when 478 then
--|#line 1965
	yy_do_action_478
when 479 then
--|#line 1967
	yy_do_action_479
when 480 then
--|#line 1969
	yy_do_action_480
when 481 then
--|#line 1971
	yy_do_action_481
when 482 then
--|#line 1973
	yy_do_action_482
when 483 then
--|#line 1975
	yy_do_action_483
when 484 then
--|#line 1977
	yy_do_action_484
when 485 then
--|#line 1979
	yy_do_action_485
when 486 then
--|#line 1981
	yy_do_action_486
when 487 then
--|#line 1983
	yy_do_action_487
when 488 then
--|#line 1985
	yy_do_action_488
when 489 then
--|#line 1987
	yy_do_action_489
when 490 then
--|#line 1989
	yy_do_action_490
when 491 then
--|#line 1991
	yy_do_action_491
when 492 then
--|#line 1993
	yy_do_action_492
when 493 then
--|#line 1997
	yy_do_action_493
when 494 then
--|#line 1999
	yy_do_action_494
when 495 then
--|#line 2001
	yy_do_action_495
when 496 then
--|#line 2003
	yy_do_action_496
when 497 then
--|#line 2007
	yy_do_action_497
when 498 then
--|#line 2009
	yy_do_action_498
when 499 then
--|#line 2011
	yy_do_action_499
when 500 then
--|#line 2013
	yy_do_action_500
when 501 then
--|#line 2015
	yy_do_action_501
when 502 then
--|#line 2017
	yy_do_action_502
when 503 then
--|#line 2019
	yy_do_action_503
when 504 then
--|#line 2021
	yy_do_action_504
when 505 then
--|#line 2023
	yy_do_action_505
when 506 then
--|#line 2025
	yy_do_action_506
when 507 then
--|#line 2027
	yy_do_action_507
when 508 then
--|#line 2029
	yy_do_action_508
when 509 then
--|#line 2031
	yy_do_action_509
when 510 then
--|#line 2033
	yy_do_action_510
when 511 then
--|#line 2035
	yy_do_action_511
when 512 then
--|#line 2037
	yy_do_action_512
when 513 then
--|#line 2039
	yy_do_action_513
when 514 then
--|#line 2041
	yy_do_action_514
when 515 then
--|#line 2045
	yy_do_action_515
when 516 then
--|#line 2049
	yy_do_action_516
when 517 then
--|#line 2053
	yy_do_action_517
when 518 then
--|#line 2057
	yy_do_action_518
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 175
		local

		do
			yyval := yyval_default;
				root_node := new_class_description (yytype85 (yyvs.item (yyvsp - 12)), yytype54 (yyvs.item (yyvsp - 10)),
					is_deferred, is_expanded, is_separate, is_frozen_class, is_external_class,
					yytype74 (yyvs.item (yyvsp - 15)), yytype74 (yyvs.item (yyvsp - 1)), yytype70 (yyvs.item (yyvsp - 11)), yytype78 (yyvs.item (yyvsp - 8)), yytype62 (yyvs.item (yyvsp - 6)), yytype67 (yyvs.item (yyvsp - 5)), yytype39 (yyvs.item (yyvsp - 3)), suppliers, yytype54 (yyvs.item (yyvsp - 9)), click_list
				)

				if real_class_end_position = 0 then
					root_node.set_text_positions (
						start_position,
						yytype90 (yyvs.item (yyvsp - 4)).start_position,
						yytype90 (yyvs.item (yyvsp - 7)).start_position,
						formal_generics_start_position,
						formal_generics_end_position,
						yytype90 (yyvs.item (yyvsp - 2)).start_position
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
			--|#line 217
		local

		do
			yyval := yyval_default;
				if inherit_context then
					inherit_context := False
					real_class_end_position := 0
				end
			

		end

	yy_do_action_3 is
			--|#line 226
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
		end

	yy_do_action_4 is
			--|#line 228
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
		end

	yy_do_action_5 is
			--|#line 230
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
		end

	yy_do_action_6 is
			--|#line 232
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
		end

	yy_do_action_7 is
			--|#line 234
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
		end

	yy_do_action_8 is
			--|#line 236
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
		end

	yy_do_action_9 is
			--|#line 238
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
		end

	yy_do_action_10 is
			--|#line 240
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
		end

	yy_do_action_11 is
			--|#line 242
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
		end

	yy_do_action_12 is
			--|#line 244
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
		end

	yy_do_action_13 is
			--|#line 246
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
		end

	yy_do_action_14 is
			--|#line 248
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := yytype85 (yyvs.item (yyvsp)) 
			yyval := yyval85
		end

	yy_do_action_15 is
			--|#line 252
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := new_clickable_id (new_id_as (token_buffer)) 
			yyval := yyval85
		end

	yy_do_action_16 is
			--|#line 256
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := new_clickable_id (new_boolean_id_as) 
			yyval := yyval85
		end

	yy_do_action_17 is
			--|#line 260
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := new_clickable_id (new_character_id_as (False)) 
			yyval := yyval85
		end

	yy_do_action_18 is
			--|#line 264
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := new_clickable_id (new_character_id_as (True)) 
			yyval := yyval85
		end

	yy_do_action_19 is
			--|#line 268
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := new_clickable_id (new_double_id_as) 
			yyval := yyval85
		end

	yy_do_action_20 is
			--|#line 272
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := new_clickable_id (new_integer_id_as (8)) 
			yyval := yyval85
		end

	yy_do_action_21 is
			--|#line 276
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := new_clickable_id (new_integer_id_as (16)) 
			yyval := yyval85
		end

	yy_do_action_22 is
			--|#line 280
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := new_clickable_id (new_integer_id_as (32)) 
			yyval := yyval85
		end

	yy_do_action_23 is
			--|#line 284
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := new_clickable_id (new_integer_id_as (64)) 
			yyval := yyval85
		end

	yy_do_action_24 is
			--|#line 288
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := new_clickable_id (new_none_id_as) 
			yyval := yyval85
		end

	yy_do_action_25 is
			--|#line 292
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := new_clickable_id (new_pointer_id_as) 
			yyval := yyval85
		end

	yy_do_action_26 is
			--|#line 296
		local
			yyval85: PAIR [ID_AS, CLICK_AST]
		do

yyval85 := new_clickable_id (new_real_id_as) 
			yyval := yyval85
		end

	yy_do_action_28 is
			--|#line 306
		local
			yyval74: INDEXING_CLAUSE_AS
		do

yyval74 := yytype74 (yyvs.item (yyvsp)) 
			yyval := yyval74
		end

	yy_do_action_31 is
			--|#line 314
		local
			yyval74: INDEXING_CLAUSE_AS
		do

yyval74 := yytype74 (yyvs.item (yyvsp)) 
			yyval := yyval74
		end

	yy_do_action_32 is
			--|#line 316
		local
			yyval74: INDEXING_CLAUSE_AS
		do

yyval74 := Void 
			yyval := yyval74
		end

	yy_do_action_34 is
			--|#line 322
		local
			yyval74: INDEXING_CLAUSE_AS
		do

yyval74 := yytype74 (yyvs.item (yyvsp - 1)) 
			yyval := yyval74
		end

	yy_do_action_35 is
			--|#line 324
		local
			yyval74: INDEXING_CLAUSE_AS
		do

yyval74 := Void 
			yyval := yyval74
		end

	yy_do_action_36 is
			--|#line 328
		local
			yyval74: INDEXING_CLAUSE_AS
		do

				yyval74 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval74.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval74
		end

	yy_do_action_37 is
			--|#line 333
		local
			yyval74: INDEXING_CLAUSE_AS
		do

				yyval74 := yytype74 (yyvs.item (yyvsp - 1))
				yyval74.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval74
		end

	yy_do_action_38 is
			--|#line 340
		local
			yyval32: INDEX_AS
		do

yyval32 := new_index_as (yytype30 (yyvs.item (yyvsp - 2)), yytype60 (yyvs.item (yyvsp - 1))) 
			yyval := yyval32
		end

	yy_do_action_39 is
			--|#line 344
		local
			yyval30: ID_AS
		do

yyval30 := yytype30 (yyvs.item (yyvsp - 1)) 
			yyval := yyval30
		end

	yy_do_action_41 is
			--|#line 350
		local
			yyval60: EIFFEL_LIST [ATOMIC_AS]
		do

				yyval60 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval60.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval60
		end

	yy_do_action_42 is
			--|#line 355
		local
			yyval60: EIFFEL_LIST [ATOMIC_AS]
		do

				yyval60 := yytype60 (yyvs.item (yyvsp - 2))
				yyval60.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval60
		end

	yy_do_action_43 is
			--|#line 360
		local
			yyval60: EIFFEL_LIST [ATOMIC_AS]
		do

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval60 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval60
		end

	yy_do_action_44 is
			--|#line 367
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype30 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_45 is
			--|#line 369
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_46 is
			--|#line 371
		local
			yyval6: ATOMIC_AS
		do

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype18 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval6
		end

	yy_do_action_47 is
			--|#line 381
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_48 is
			--|#line 387
		local

		do
			yyval := yyval_default;
				is_frozen_class := False
				is_deferred := True
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_49 is
			--|#line 394
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := True
				is_separate := False
			

		end

	yy_do_action_50 is
			--|#line 400
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := True
			

		end

	yy_do_action_51 is
			--|#line 408
		local

		do
			yyval := yyval_default;
				is_frozen_class := False
			

		end

	yy_do_action_52 is
			--|#line 412
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
			--|#line 423
		local

		do
			yyval := yyval_default;
				is_external_class := False
			

		end

	yy_do_action_54 is
			--|#line 427
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
			--|#line 444
		local
			yyval54: STRING_AS
		do

yyval54 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval54
		end

	yy_do_action_58 is
			--|#line 453
		local
			yyval67: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval67 := yytype67 (yyvs.item (yyvsp))
				if yyval67.is_empty then
					yyval67 := Void
				end
			
			yyval := yyval67
		end

	yy_do_action_59 is
			--|#line 462
		local
			yyval67: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval67 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval67, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_60 is
			--|#line 467
		local
			yyval67: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval67 := yytype67 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval67, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_61 is
			--|#line 474
		local
			yyval27: FEATURE_CLAUSE_AS
		do

yyval27 := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) 
			yyval := yyval27
		end

	yy_do_action_62 is
			--|#line 476
		local
			yyval27: FEATURE_CLAUSE_AS
		do

yyval27 := new_feature_clause_as (yytype14 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval27
		end

	yy_do_action_63 is
			--|#line 480
		local
			yyval14: CLIENT_AS
		do

yyval14 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval14
		end

	yy_do_action_64 is
			--|#line 480
		local

		do
			yyval := yyval_default;
				inherit_context := False
				fclause_pos := current_position.end_position
			

		end

	yy_do_action_66 is
			--|#line 491
		local
			yyval14: CLIENT_AS
		do

yyval14 := new_client_as (yytype71 (yyvs.item (yyvsp))) 
			yyval := yyval14
		end

	yy_do_action_67 is
			--|#line 495
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := new_eiffel_list_id_as (1)
				yyval71.extend (new_none_id_as)
			
			yyval := yyval71
		end

	yy_do_action_68 is
			--|#line 500
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

yyval71 := yytype71 (yyvs.item (yyvsp - 1)) 
			yyval := yyval71
		end

	yy_do_action_69 is
			--|#line 504
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval71.extend (yytype85 (yyvs.item (yyvsp)).first)
				yytype85 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype85 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval71
		end

	yy_do_action_70 is
			--|#line 510
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype85 (yyvs.item (yyvsp)).first)
				yytype85 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype85 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval71
		end

	yy_do_action_71 is
			--|#line 518
		local
			yyval66: EIFFEL_LIST [FEATURE_AS]
		do

				yyval66 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval66.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_72 is
			--|#line 523
		local
			yyval66: EIFFEL_LIST [FEATURE_AS]
		do

				yyval66 := yytype66 (yyvs.item (yyvsp - 1))
				yyval66.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_77 is
			--|#line 538
		local
			yyval26: FEATURE_AS
		do

					-- Generate a syntax error when `feature_indexes' is not
					-- Void and it applies to synonyms of the current feature
					-- declaration.
				if (il_parser and feature_indexes /= Void and yytype88 (yyvs.item (yyvsp - 2)).first.count /= 1) then
					raise_error
				end
				yyval26 := new_feature_declaration (yytype88 (yyvs.item (yyvsp - 2)), yytype8 (yyvs.item (yyvsp - 1)), feature_indexes)
				feature_indexes := Void
			
			yyval := yyval26
		end

	yy_do_action_78 is
			--|#line 551
		local
			yyval88: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

yyval88 := new_clickable_feature_name_list (yytype86 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval88
		end

	yy_do_action_79 is
			--|#line 553
		local
			yyval88: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

				yyval88 := yytype88 (yyvs.item (yyvsp - 2))
				yyval88.first.extend (yytype86 (yyvs.item (yyvsp)).first)
			
			yyval := yyval88
		end

	yy_do_action_80 is
			--|#line 560
		local
			yyval86: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_81 is
			--|#line 564
		local

		do
			yyval := yyval_default;
is_frozen := False 

		end

	yy_do_action_82 is
			--|#line 566
		local

		do
			yyval := yyval_default;
is_frozen := True 

		end

	yy_do_action_83 is
			--|#line 570
		local
			yyval86: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval86 := new_clickable_feature_name (yytype85 (yyvs.item (yyvsp))) 
			yyval := yyval86
		end

	yy_do_action_84 is
			--|#line 572
		local
			yyval86: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_85 is
			--|#line 574
		local
			yyval86: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_86 is
			--|#line 578
		local
			yyval86: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval86 := new_clickable_infix (yytype87 (yyvs.item (yyvsp))) 
			yyval := yyval86
		end

	yy_do_action_87 is
			--|#line 583
		local
			yyval86: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval86 := new_clickable_prefix (yytype87 (yyvs.item (yyvsp))) 
			yyval := yyval86
		end

	yy_do_action_88 is
			--|#line 587
		local
			yyval8: BODY_AS
		do

yyval8 := new_declaration_body (yytype83 (yyvs.item (yyvsp - 2)), yytype57 (yyvs.item (yyvsp - 1)), yytype15 (yyvs.item (yyvsp))) 
			yyval := yyval8
		end

	yy_do_action_89 is
			--|#line 591
		local
			yyval15: CONTENT_AS
		do

feature_indexes := yytype74 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_90 is
			--|#line 593
		local
			yyval15: CONTENT_AS
		do

yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_91 is
			--|#line 597
		local
			yyval15: CONTENT_AS
		do

				yyval15 := new_constant_as (new_value_as (yytype6 (yyvs.item (yyvsp - 1))))
				feature_indexes := yytype74 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_92 is
			--|#line 602
		local
			yyval15: CONTENT_AS
		do

				yyval15 := new_constant_as (new_value_as (new_unique_as))
				feature_indexes := yytype74 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_93 is
			--|#line 607
		local
			yyval15: CONTENT_AS
		do

				yyval15 := yytype52 (yyvs.item (yyvsp))
				feature_indexes := yytype74 (yyvs.item (yyvsp - 1))
			
			yyval := yyval15
		end

	yy_do_action_95 is
			--|#line 620
		local
			yyval78: EIFFEL_LIST [PARENT_AS]
		do

yyval78 := yytype78 (yyvs.item (yyvsp)) 
			yyval := yyval78
		end

	yy_do_action_96 is
			--|#line 622
		local
			yyval78: EIFFEL_LIST [PARENT_AS]
		do

yyval78 := new_eiffel_list_parent_as (0) 
			yyval := yyval78
		end

	yy_do_action_97 is
			--|#line 626
		local
			yyval78: EIFFEL_LIST [PARENT_AS]
		do

				yyval78 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval78.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_98 is
			--|#line 631
		local
			yyval78: EIFFEL_LIST [PARENT_AS]
		do

				yyval78 := yytype78 (yyvs.item (yyvsp - 1))
				yyval78.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_99 is
			--|#line 638
		local
			yyval44: PARENT_AS
		do

				yyval44 := yytype44 (yyvs.item (yyvsp))
				yytype44 (yyvs.item (yyvsp)).set_text_positions (yytype90 (yyvs.item (yyvsp - 1)).start_position)
			
			yyval := yyval44
		end

	yy_do_action_100 is
			--|#line 643
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := yytype44 (yyvs.item (yyvsp - 1))
				yytype44 (yyvs.item (yyvsp - 1)).set_text_positions (yytype90 (yyvs.item (yyvsp - 2)).start_position)
			
			yyval := yyval44
		end

	yy_do_action_101 is
			--|#line 651
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype85 (yyvs.item (yyvsp - 1)), yytype82 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_102 is
			--|#line 656
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype85 (yyvs.item (yyvsp - 7)), yytype82 (yyvs.item (yyvsp - 6)), yytype79 (yyvs.item (yyvsp - 5)), yytype64 (yyvs.item (yyvsp - 4)), yytype69 (yyvs.item (yyvsp - 3)), yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_103 is
			--|#line 661
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype85 (yyvs.item (yyvsp - 6)), yytype82 (yyvs.item (yyvsp - 5)), Void, yytype64 (yyvs.item (yyvsp - 4)), yytype69 (yyvs.item (yyvsp - 3)), yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_104 is
			--|#line 666
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype85 (yyvs.item (yyvsp - 5)), yytype82 (yyvs.item (yyvsp - 4)), Void, Void, yytype69 (yyvs.item (yyvsp - 3)), yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_105 is
			--|#line 671
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype85 (yyvs.item (yyvsp - 4)), yytype82 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_106 is
			--|#line 676
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype85 (yyvs.item (yyvsp - 3)), yytype82 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_107 is
			--|#line 681
		local
			yyval44: PARENT_AS
		do

				inherit_context := True
				real_class_end_position := end_position - 3
				yyval44 := new_parent_clause (yytype85 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_109 is
			--|#line 691
		local
			yyval79: EIFFEL_LIST [RENAME_AS]
		do

yyval79 := yytype79 (yyvs.item (yyvsp)) 
			yyval := yyval79
		end

	yy_do_action_110 is
			--|#line 695
		local
			yyval79: EIFFEL_LIST [RENAME_AS]
		do

				yyval79 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval79.extend (yytype47 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_111 is
			--|#line 700
		local
			yyval79: EIFFEL_LIST [RENAME_AS]
		do

				yyval79 := yytype79 (yyvs.item (yyvsp - 2))
				yyval79.extend (yytype47 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_112 is
			--|#line 707
		local
			yyval47: RENAME_AS
		do

yyval47 := new_rename_pair (yytype86 (yyvs.item (yyvsp - 2)), yytype86 (yyvs.item (yyvsp))) 
			yyval := yyval47
		end

	yy_do_action_114 is
			--|#line 713
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_115 is
			--|#line 717
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_117 is
			--|#line 723
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval64 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				yyval64.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_118 is
			--|#line 728
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval64 := yytype64 (yyvs.item (yyvsp - 1))
				yyval64.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_119 is
			--|#line 735
		local
			yyval22: EXPORT_ITEM_AS
		do

yyval22 := new_export_item_as (new_client_as (yytype71 (yyvs.item (yyvsp - 2))), yytype28 (yyvs.item (yyvsp - 1))) 
			yyval := yyval22
		end

	yy_do_action_120 is
			--|#line 739
		local
			yyval28: FEATURE_SET_AS
		do

yyval28 := new_all_as 
			yyval := yyval28
		end

	yy_do_action_121 is
			--|#line 741
		local
			yyval28: FEATURE_SET_AS
		do

yyval28 := new_feature_list_as (yytype69 (yyvs.item (yyvsp))) 
			yyval := yyval28
		end

	yy_do_action_122 is
			--|#line 745
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval69 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval69.extend (yytype86 (yyvs.item (yyvsp)).first)
			
			yyval := yyval69
		end

	yy_do_action_123 is
			--|#line 750
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval69 := yytype69 (yyvs.item (yyvsp - 2))
				yyval69.extend (yytype86 (yyvs.item (yyvsp)).first)
			
			yyval := yyval69
		end

	yy_do_action_125 is
			--|#line 759
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_127 is
			--|#line 765
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_129 is
			--|#line 771
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_131 is
			--|#line 777
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_133 is
			--|#line 783
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_135 is
			--|#line 789
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_137 is
			--|#line 799
		local
			yyval83: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval83 := yytype83 (yyvs.item (yyvsp - 1)) 
			yyval := yyval83
		end

	yy_do_action_139 is
			--|#line 805
		local
			yyval83: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_140 is
			--|#line 809
		local
			yyval83: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval83 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_141 is
			--|#line 814
		local
			yyval83: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval83 := yytype83 (yyvs.item (yyvsp - 1))
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_142 is
			--|#line 821
		local
			yyval58: TYPE_DEC_AS
		do

yyval58 := new_type_dec_as (yytype73 (yyvs.item (yyvsp - 4)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval58
		end

	yy_do_action_144 is
			--|#line 826
		local

		do
			yyval := yyval_default;
				if il_parser then
						-- Trigger a syntax error.
					raise_error
				end
			

		end

	yy_do_action_146 is
			--|#line 837
		local
			yyval83: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_147 is
			--|#line 841
		local
			yyval83: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval83 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_148 is
			--|#line 846
		local
			yyval83: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval83 := yytype83 (yyvs.item (yyvsp - 1))
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_149 is
			--|#line 853
		local
			yyval58: TYPE_DEC_AS
		do

yyval58 := new_type_dec_as (yytype73 (yyvs.item (yyvsp - 3)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval58
		end

	yy_do_action_150 is
			--|#line 857
		local
			yyval73: ARRAYED_LIST [INTEGER]
		do

				create yyval73.make (Initial_identifier_list_size)
				Names_heap.put (yytype30 (yyvs.item (yyvsp)))
				yyval73.extend (Names_heap.found_item)
			
			yyval := yyval73
		end

	yy_do_action_151 is
			--|#line 863
		local
			yyval73: ARRAYED_LIST [INTEGER]
		do

				yyval73 := yytype73 (yyvs.item (yyvsp - 2))
				Names_heap.put (yytype30 (yyvs.item (yyvsp)))
				yyval73.extend (Names_heap.found_item)
			
			yyval := yyval73
		end

	yy_do_action_152 is
			--|#line 871
		local
			yyval73: ARRAYED_LIST [INTEGER]
		do

create yyval73.make (0) 
			yyval := yyval73
		end

	yy_do_action_153 is
			--|#line 873
		local
			yyval73: ARRAYED_LIST [INTEGER]
		do

yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
		end

	yy_do_action_155 is
			--|#line 879
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_156 is
			--|#line 883
		local
			yyval52: ROUTINE_AS
		do

yyval52 := new_routine_as (yytype54 (yyvs.item (yyvsp - 7)), yytype48 (yyvs.item (yyvsp - 5)), yytype83 (yyvs.item (yyvsp - 4)), yytype51 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype75 (yyvs.item (yyvsp - 1)), fbody_pos) 
			yyval := yyval52
		end

	yy_do_action_157 is
			--|#line 883
		local

		do
			yyval := yyval_default;
fbody_pos := current_position.start_position 

		end

	yy_do_action_158 is
			--|#line 895
		local
			yyval51: ROUT_BODY_AS
		do

yyval51 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval51
		end

	yy_do_action_159 is
			--|#line 897
		local
			yyval51: ROUT_BODY_AS
		do

yyval51 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval51
		end

	yy_do_action_160 is
			--|#line 899
		local
			yyval51: ROUT_BODY_AS
		do

yyval51 := new_deferred_as 
			yyval := yyval51
		end

	yy_do_action_161 is
			--|#line 903
		local
			yyval24: EXTERNAL_AS
		do

yyval24 := new_external_as (yytype25 (yyvs.item (yyvsp - 1)), yytype54 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_162 is
			--|#line 907
		local
			yyval25: EXTERNAL_LANG_AS
		do

yyval25 := new_external_lang_as (yytype54 (yyvs.item (yyvsp)), yacc_position) 
			yyval := yyval25
		end

	yy_do_action_163 is
			--|#line 907
		local

		do
			yyval := yyval_default;
set_position (current_position) 

		end

	yy_do_action_165 is
			--|#line 915
		local
			yyval54: STRING_AS
		do

yyval54 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval54
		end

	yy_do_action_166 is
			--|#line 919
		local
			yyval37: INTERNAL_AS
		do

yyval37 := new_do_as (yytype75 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_167 is
			--|#line 921
		local
			yyval37: INTERNAL_AS
		do

yyval37 := new_once_as (yytype75 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_169 is
			--|#line 927
		local
			yyval83: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_171 is
			--|#line 933
		local
			yyval75: EIFFEL_LIST [INSTRUCTION_AS]
		do

yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
		end

	yy_do_action_172 is
			--|#line 937
		local
			yyval75: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval75 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval75.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_173 is
			--|#line 942
		local
			yyval75: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval75 := yytype75 (yyvs.item (yyvsp - 1))
				yyval75.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_174 is
			--|#line 949
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype35 (yyvs.item (yyvsp - 1)) 
			yyval := yyval35
		end

	yy_do_action_177 is
			--|#line 957
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_178 is
			--|#line 959
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_179 is
			--|#line 961
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_180 is
			--|#line 963
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype50 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_181 is
			--|#line 965
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype31 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_182 is
			--|#line 967
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_183 is
			--|#line 969
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype40 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_184 is
			--|#line 971
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_185 is
			--|#line 973
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_186 is
			--|#line 975
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype49 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_188 is
			--|#line 981
		local
			yyval48: REQUIRE_AS
		do

				id_level := Normal_level
				yyval48 := new_require_as (yytype81 (yyvs.item (yyvsp)))
			
			yyval := yyval48
		end

	yy_do_action_189 is
			--|#line 981
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_190 is
			--|#line 988
		local
			yyval48: REQUIRE_AS
		do

				id_level := Normal_level
				yyval48 := new_require_else_as (yytype81 (yyvs.item (yyvsp)))
			
			yyval := yyval48
		end

	yy_do_action_191 is
			--|#line 988
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_193 is
			--|#line 999
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_as (yytype81 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_194 is
			--|#line 999
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_195 is
			--|#line 1006
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_then_as (yytype81 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_196 is
			--|#line 1006
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_198 is
			--|#line 1017
		local
			yyval81: EIFFEL_LIST [TAGGED_AS]
		do

				yyval81 := yytype81 (yyvs.item (yyvsp))
				if yyval81.is_empty then
					yyval81 := Void
				end
			
			yyval := yyval81
		end

	yy_do_action_199 is
			--|#line 1026
		local
			yyval81: EIFFEL_LIST [TAGGED_AS]
		do

				yyval81 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval81, yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_200 is
			--|#line 1031
		local
			yyval81: EIFFEL_LIST [TAGGED_AS]
		do

				yyval81 := yytype81 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval81, yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_201 is
			--|#line 1038
		local
			yyval55: TAGGED_AS
		do

yyval55 := yytype55 (yyvs.item (yyvsp - 1)) 
			yyval := yyval55
		end

	yy_do_action_202 is
			--|#line 1042
		local
			yyval55: TAGGED_AS
		do

yyval55 := new_tagged_as (Void, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval55
		end

	yy_do_action_203 is
			--|#line 1044
		local
			yyval55: TAGGED_AS
		do

yyval55 := new_tagged_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval55
		end

	yy_do_action_205 is
			--|#line 1054
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_206 is
			--|#line 1056
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_207 is
			--|#line 1060
		local
			yyval57: TYPE
		do

yyval57 := new_expanded_type (yytype85 (yyvs.item (yyvsp - 1)), yytype82 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_208 is
			--|#line 1062
		local
			yyval57: TYPE
		do

yyval57 := new_separate_type (yytype85 (yyvs.item (yyvsp - 1)), yytype82 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_209 is
			--|#line 1064
		local
			yyval57: TYPE
		do

yyval57 := new_bits_as (yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_210 is
			--|#line 1066
		local
			yyval57: TYPE
		do

yyval57 := new_bits_symbol_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_211 is
			--|#line 1068
		local
			yyval57: TYPE
		do

yyval57 := new_like_id_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_212 is
			--|#line 1070
		local
			yyval57: TYPE
		do

yyval57 := new_like_current_as 
			yyval := yyval57
		end

	yy_do_action_213 is
			--|#line 1074
		local
			yyval57: TYPE
		do

yyval57 := new_class_type (yytype85 (yyvs.item (yyvsp - 1)), yytype82 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_214 is
			--|#line 1076
		local
			yyval57: TYPE
		do

yyval57 := new_boolean_type (yytype85 (yyvs.item (yyvsp - 1)).second, yytype82 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_215 is
			--|#line 1078
		local
			yyval57: TYPE
		do

yyval57 := new_character_type (yytype85 (yyvs.item (yyvsp - 1)).second, yytype82 (yyvs.item (yyvsp)) /= Void, False) 
			yyval := yyval57
		end

	yy_do_action_216 is
			--|#line 1080
		local
			yyval57: TYPE
		do

yyval57 := new_character_type (yytype85 (yyvs.item (yyvsp - 1)).second, yytype82 (yyvs.item (yyvsp)) /= Void, True) 
			yyval := yyval57
		end

	yy_do_action_217 is
			--|#line 1082
		local
			yyval57: TYPE
		do

yyval57 := new_double_type (yytype85 (yyvs.item (yyvsp - 1)).second, yytype82 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_218 is
			--|#line 1084
		local
			yyval57: TYPE
		do

yyval57 := new_integer_type (yytype85 (yyvs.item (yyvsp - 1)).second, yytype82 (yyvs.item (yyvsp)) /= Void, 8) 
			yyval := yyval57
		end

	yy_do_action_219 is
			--|#line 1086
		local
			yyval57: TYPE
		do

yyval57 := new_integer_type (yytype85 (yyvs.item (yyvsp - 1)).second, yytype82 (yyvs.item (yyvsp)) /= Void, 16) 
			yyval := yyval57
		end

	yy_do_action_220 is
			--|#line 1088
		local
			yyval57: TYPE
		do

yyval57 := new_integer_type (yytype85 (yyvs.item (yyvsp - 1)).second, yytype82 (yyvs.item (yyvsp)) /= Void, 32) 
			yyval := yyval57
		end

	yy_do_action_221 is
			--|#line 1090
		local
			yyval57: TYPE
		do

yyval57 := new_integer_type (yytype85 (yyvs.item (yyvsp - 1)).second, yytype82 (yyvs.item (yyvsp)) /= Void, 64) 
			yyval := yyval57
		end

	yy_do_action_222 is
			--|#line 1092
		local
			yyval57: TYPE
		do

yyval57 := new_none_type (yytype85 (yyvs.item (yyvsp - 1)).second, yytype82 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_223 is
			--|#line 1094
		local
			yyval57: TYPE
		do

yyval57 := new_pointer_type (yytype85 (yyvs.item (yyvsp - 1)).second, yytype82 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_224 is
			--|#line 1096
		local
			yyval57: TYPE
		do

yyval57 := new_real_type (yytype85 (yyvs.item (yyvsp - 1)).second, yytype82 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_227 is
			--|#line 1104
		local
			yyval82: EIFFEL_LIST [TYPE]
		do

yyval82 := yytype82 (yyvs.item (yyvsp - 1)) 
			yyval := yyval82
		end

	yy_do_action_228 is
			--|#line 1108
		local
			yyval82: EIFFEL_LIST [TYPE]
		do

				yyval82 := new_eiffel_list_type (Initial_type_list_size)
				yyval82.extend (yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_229 is
			--|#line 1113
		local
			yyval82: EIFFEL_LIST [TYPE]
		do

				yyval82 := yytype82 (yyvs.item (yyvsp - 2))
				yyval82.extend (yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_230 is
			--|#line 1124
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				-- $$ := Void
				formal_generics_start_position := start_position
				formal_generics_end_position := 0
			
			yyval := yyval70
		end

	yy_do_action_231 is
			--|#line 1130
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval70 := yytype70 (yyvs.item (yyvsp - 1))
				formal_generics_start_position := yytype90 (yyvs.item (yyvsp - 3)).start_position
				formal_generics_end_position := start_position
			
			yyval := yyval70
		end

	yy_do_action_233 is
			--|#line 1140
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_234 is
			--|#line 1144
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval70 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval70.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_235 is
			--|#line 1149
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval70 := yytype70 (yyvs.item (yyvsp - 2))
				yyval70.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_236 is
			--|#line 1156
		local
			yyval29: FORMAL_DEC_AS
		do

				check formal_exists: not formal_parameters.is_empty end
				yyval29 := new_formal_dec_as (formal_parameters.last, yytype89 (yyvs.item (yyvsp)).first, yytype89 (yyvs.item (yyvsp)).second, formal_parameters.count)
			
			yyval := yyval29
		end

	yy_do_action_237 is
			--|#line 1156
		local

		do
			yyval := yyval_default;
formal_parameters.extend (new_id_as (token_buffer)) 

		end

	yy_do_action_238 is
			--|#line 1166
		local
			yyval89: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do

create yyval89 
			yyval := yyval89
		end

	yy_do_action_239 is
			--|#line 1168
		local
			yyval89: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do

				create yyval89
				yyval89.set_first (yytype57 (yyvs.item (yyvsp - 1)))
				yyval89.set_second (yytype69 (yyvs.item (yyvsp)))
			
			yyval := yyval89
		end

	yy_do_action_241 is
			--|#line 1178
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp - 1)) 
			yyval := yyval69
		end

	yy_do_action_242 is
			--|#line 1186
		local
			yyval31: IF_AS
		do

				set_position (yytype90 (yyvs.item (yyvsp - 7)))
				yyval31 := new_if_as (yytype23 (yyvs.item (yyvsp - 5)), yytype75 (yyvs.item (yyvsp - 3)), yytype63 (yyvs.item (yyvsp - 2)), yytype75 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval31
		end

	yy_do_action_244 is
			--|#line 1195
		local
			yyval63: EIFFEL_LIST [ELSIF_AS]
		do

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_245 is
			--|#line 1199
		local
			yyval63: EIFFEL_LIST [ELSIF_AS]
		do

				yyval63 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval63.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_246 is
			--|#line 1204
		local
			yyval63: EIFFEL_LIST [ELSIF_AS]
		do

				yyval63 := yytype63 (yyvs.item (yyvsp - 1))
				yyval63.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_247 is
			--|#line 1211
		local
			yyval20: ELSIF_AS
		do

yyval20 := new_elseif_as (yytype23 (yyvs.item (yyvsp - 2)), yytype75 (yyvs.item (yyvsp)), yacc_line_number) 
			yyval := yyval20
		end

	yy_do_action_249 is
			--|#line 1217
		local
			yyval75: EIFFEL_LIST [INSTRUCTION_AS]
		do

yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
		end

	yy_do_action_250 is
			--|#line 1221
		local
			yyval33: INSPECT_AS
		do

				set_position (yytype90 (yyvs.item (yyvsp - 5)))
				yyval33 := new_inspect_as (yytype23 (yyvs.item (yyvsp - 3)), yytype61 (yyvs.item (yyvsp - 2)), yytype75 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval33
		end

	yy_do_action_252 is
			--|#line 1230
		local
			yyval61: EIFFEL_LIST [CASE_AS]
		do

yyval61 := yytype61 (yyvs.item (yyvsp)) 
			yyval := yyval61
		end

	yy_do_action_253 is
			--|#line 1234
		local
			yyval61: EIFFEL_LIST [CASE_AS]
		do

				yyval61 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval61.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_254 is
			--|#line 1239
		local
			yyval61: EIFFEL_LIST [CASE_AS]
		do

				yyval61 := yytype61 (yyvs.item (yyvsp - 1))
				yyval61.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_255 is
			--|#line 1246
		local
			yyval11: CASE_AS
		do

yyval11 := new_case_as (yytype76 (yyvs.item (yyvsp - 2)), yytype75 (yyvs.item (yyvsp)), yacc_line_number) 
			yyval := yyval11
		end

	yy_do_action_256 is
			--|#line 1250
		local
			yyval76: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval76 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval76.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_257 is
			--|#line 1255
		local
			yyval76: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp - 2))
				yyval76.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_258 is
			--|#line 1262
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_259 is
			--|#line 1264
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_260 is
			--|#line 1266
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_261 is
			--|#line 1268
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_262 is
			--|#line 1270
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_263 is
			--|#line 1272
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_264 is
			--|#line 1274
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_265 is
			--|#line 1276
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_266 is
			--|#line 1278
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_267 is
			--|#line 1280
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_269 is
			--|#line 1286
		local
			yyval75: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval75 := yytype75 (yyvs.item (yyvsp))
				if yyval75 = Void then
					yyval75 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval75
		end

	yy_do_action_270 is
			--|#line 1295
		local
			yyval40: LOOP_AS
		do

				set_position (yytype90 (yyvs.item (yyvsp - 9)))
				yyval40 := new_loop_as (yytype75 (yyvs.item (yyvsp - 7)), yytype81 (yyvs.item (yyvsp - 6)), yytype59 (yyvs.item (yyvsp - 5)), yytype23 (yyvs.item (yyvsp - 3)), yytype75 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval40
		end

	yy_do_action_272 is
			--|#line 1304
		local
			yyval81: EIFFEL_LIST [TAGGED_AS]
		do

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_274 is
			--|#line 1310
		local
			yyval39: INVARIANT_AS
		do

				id_level := Normal_level
				inherit_context := False
				yyval39 := new_invariant_as (yytype81 (yyvs.item (yyvsp)))
			
			yyval := yyval39
		end

	yy_do_action_275 is
			--|#line 1310
		local

		do
			yyval := yyval_default;
id_level := Invariant_level 

		end

	yy_do_action_277 is
			--|#line 1322
		local
			yyval59: VARIANT_AS
		do

yyval59 := new_variant_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval59
		end

	yy_do_action_278 is
			--|#line 1324
		local
			yyval59: VARIANT_AS
		do

yyval59 := new_variant_as (Void, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval59
		end

	yy_do_action_279 is
			--|#line 1328
		local
			yyval19: DEBUG_AS
		do

				set_position (yytype90 (yyvs.item (yyvsp - 4)))
				yyval19 := new_debug_as (yytype80 (yyvs.item (yyvsp - 2)), yytype75 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval19
		end

	yy_do_action_282 is
			--|#line 1339
		local
			yyval80: EIFFEL_LIST [STRING_AS]
		do

yyval80 := yytype80 (yyvs.item (yyvsp - 1)) 
			yyval := yyval80
		end

	yy_do_action_283 is
			--|#line 1343
		local
			yyval80: EIFFEL_LIST [STRING_AS]
		do

				yyval80 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval80.extend (yytype54 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_284 is
			--|#line 1348
		local
			yyval80: EIFFEL_LIST [STRING_AS]
		do

				yyval80 := yytype80 (yyvs.item (yyvsp - 2))
				yyval80.extend (yytype54 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_285 is
			--|#line 1355
		local
			yyval49: RETRY_AS
		do

yyval49 := new_retry_as (yacc_line_number) 
			yyval := yyval49
		end

	yy_do_action_287 is
			--|#line 1361
		local
			yyval75: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval75 := yytype75 (yyvs.item (yyvsp))
				if yyval75 = Void then
					yyval75 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval75
		end

	yy_do_action_288 is
			--|#line 1370
		local
			yyval5: ASSIGN_AS
		do

yyval5 := new_assign_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval5
		end

	yy_do_action_289 is
			--|#line 1372
		local
			yyval5: ASSIGN_AS
		do

yyval5 := new_assign_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval5
		end

	yy_do_action_290 is
			--|#line 1376
		local
			yyval50: REVERSE_AS
		do

yyval50 := new_reverse_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval50
		end

	yy_do_action_291 is
			--|#line 1378
		local
			yyval50: REVERSE_AS
		do

yyval50 := new_reverse_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval50
		end

	yy_do_action_293 is
			--|#line 1384
		local
			yyval62: EIFFEL_LIST [CREATE_AS]
		do

yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
		end

	yy_do_action_294 is
			--|#line 1388
		local
			yyval62: EIFFEL_LIST [CREATE_AS]
		do

				yyval62 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval62.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_295 is
			--|#line 1393
		local
			yyval62: EIFFEL_LIST [CREATE_AS]
		do

				yyval62 := yytype62 (yyvs.item (yyvsp - 1))
				yyval62.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_296 is
			--|#line 1400
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_297 is
			--|#line 1406
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_298 is
			--|#line 1411
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype71 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_299 is
			--|#line 1416
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_300 is
			--|#line 1421
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_301 is
			--|#line 1426
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype71 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_302 is
			--|#line 1433
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (new_result_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_303 is
			--|#line 1436
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_304 is
			--|#line 1438
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 3)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_305 is
			--|#line 1440
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 4))), yytype30 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_306 is
			--|#line 1442
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (new_operand_as (yytype57 (yyvs.item (yyvsp - 4)), Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_307 is
			--|#line 1444
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (Void, yytype30 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_308 is
			--|#line 1446
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_309 is
			--|#line 1448
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (new_result_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_310 is
			--|#line 1450
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_311 is
			--|#line 1452
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 3)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_312 is
			--|#line 1454
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_As (new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 4))), yytype30 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_313 is
			--|#line 1456
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (new_operand_as (yytype57 (yyvs.item (yyvsp - 3)), Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_314 is
			--|#line 1458
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (Void, yytype30 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_315 is
			--|#line 1460
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype77 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_317 is
			--|#line 1466
		local
			yyval77: EIFFEL_LIST [OPERAND_AS]
		do

yyval77 := yytype77 (yyvs.item (yyvsp - 1)) 
			yyval := yyval77
		end

	yy_do_action_318 is
			--|#line 1470
		local
			yyval77: EIFFEL_LIST [OPERAND_AS]
		do

				yyval77 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval77.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_319 is
			--|#line 1475
		local
			yyval77: EIFFEL_LIST [OPERAND_AS]
		do

				yyval77 := yytype77 (yyvs.item (yyvsp - 2))
				yyval77.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_320 is
			--|#line 1482
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, Void) 
			yyval := yyval43
		end

	yy_do_action_321 is
			--|#line 1484
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval43
		end

	yy_do_action_322 is
			--|#line 1486
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_class_type (yytype85 (yyvs.item (yyvsp - 2)), yytype82 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_323 is
			--|#line 1488
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_boolean_type (yytype85 (yyvs.item (yyvsp - 2)).second, yytype82 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_324 is
			--|#line 1490
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_character_type (yytype85 (yyvs.item (yyvsp - 2)).second, yytype82 (yyvs.item (yyvsp - 1)) /= Void, False), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_325 is
			--|#line 1492
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_character_type (yytype85 (yyvs.item (yyvsp - 2)).second, yytype82 (yyvs.item (yyvsp - 1)) /= Void, True), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_326 is
			--|#line 1494
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_double_type (yytype85 (yyvs.item (yyvsp - 2)).second, yytype82 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_327 is
			--|#line 1496
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype85 (yyvs.item (yyvsp - 2)).second, yytype82 (yyvs.item (yyvsp - 1)) /= Void, 8), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_328 is
			--|#line 1498
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype85 (yyvs.item (yyvsp - 2)).second, yytype82 (yyvs.item (yyvsp - 1)) /= Void, 16), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_329 is
			--|#line 1500
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype85 (yyvs.item (yyvsp - 2)).second, yytype82 (yyvs.item (yyvsp - 1)) /= Void, 32), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_330 is
			--|#line 1502
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype85 (yyvs.item (yyvsp - 2)).second, yytype82 (yyvs.item (yyvsp - 1)) /= Void, 64), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_331 is
			--|#line 1504
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_none_type (yytype85 (yyvs.item (yyvsp - 2)).second, yytype82 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_332 is
			--|#line 1506
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_pointer_type (yytype85 (yyvs.item (yyvsp - 2)).second, yytype82 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_333 is
			--|#line 1508
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_real_type (yytype85 (yyvs.item (yyvsp - 2)).second, yytype82 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_334 is
			--|#line 1510
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (yytype57 (yyvs.item (yyvsp - 1)), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_335 is
			--|#line 1514
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (yytype57 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval17
		end

	yy_do_action_336 is
			--|#line 1516
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (Void, yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval17
		end

	yy_do_action_337 is
			--|#line 1518
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (yytype57 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval17
		end

	yy_do_action_338 is
			--|#line 1522
		local
			yyval18: CREATION_EXPR_AS
		do

yyval18 := new_creation_expr_as (yytype57 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval18
		end

	yy_do_action_339 is
			--|#line 1524
		local
			yyval18: CREATION_EXPR_AS
		do

yyval18 := new_creation_expr_as (yytype57 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval18
		end

	yy_do_action_341 is
			--|#line 1530
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_342 is
			--|#line 1534
		local
			yyval1: ACCESS_AS
		do

yyval1 := new_access_id_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval1
		end

	yy_do_action_343 is
			--|#line 1536
		local
			yyval1: ACCESS_AS
		do

yyval1 := new_result_as 
			yyval := yyval1
		end

	yy_do_action_345 is
			--|#line 1542
		local
			yyval3: ACCESS_INV_AS
		do

yyval3 := new_access_inv_as (yytype30 (yyvs.item (yyvsp - 1)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_346 is
			--|#line 1550
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype1 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_347 is
			--|#line 1552
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_348 is
			--|#line 1554
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_349 is
			--|#line 1556
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_350 is
			--|#line 1558
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_351 is
			--|#line 1560
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype45 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_352 is
			--|#line 1562
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_353 is
			--|#line 1566
		local
			yyval13: CHECK_AS
		do

				set_position (yytype90 (yyvs.item (yyvsp - 3)))
				yyval13 := new_check_as (yytype81 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval13
		end

	yy_do_action_354 is
			--|#line 1577
		local
			yyval23: EXPR_AS
		do

yyval23 := new_value_as (yytype6 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_355 is
			--|#line 1579
		local
			yyval23: EXPR_AS
		do

yyval23 := new_value_as (yytype4 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_356 is
			--|#line 1581
		local
			yyval23: EXPR_AS
		do

yyval23 := new_value_as (yytype56 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_357 is
			--|#line 1583
		local
			yyval23: EXPR_AS
		do

yyval23 := new_expr_call_as (yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_358 is
			--|#line 1585
		local
			yyval23: EXPR_AS
		do

yyval23 := yytype53 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_359 is
			--|#line 1587
		local
			yyval23: EXPR_AS
		do

yyval23 := new_paran_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_360 is
			--|#line 1589
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_plus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_361 is
			--|#line 1591
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_minus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_362 is
			--|#line 1593
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_star_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_363 is
			--|#line 1595
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_slash_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_364 is
			--|#line 1597
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_mod_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_365 is
			--|#line 1599
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_div_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_366 is
			--|#line 1601
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_power_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_367 is
			--|#line 1603
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_and_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_368 is
			--|#line 1605
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_and_then_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_369 is
			--|#line 1607
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_or_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_370 is
			--|#line 1609
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_or_else_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_371 is
			--|#line 1611
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_implies_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_372 is
			--|#line 1613
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_xor_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_373 is
			--|#line 1615
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_ge_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_374 is
			--|#line 1617
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_gt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_375 is
			--|#line 1619
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_le_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_376 is
			--|#line 1621
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_lt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_377 is
			--|#line 1623
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_eq_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_378 is
			--|#line 1625
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_ne_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_379 is
			--|#line 1627
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_free_as (yytype23 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_380 is
			--|#line 1629
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_minus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_381 is
			--|#line 1631
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_plus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_382 is
			--|#line 1633
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_not_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_383 is
			--|#line 1635
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_old_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_384 is
			--|#line 1637
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_free_as (yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_385 is
			--|#line 1639
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_strip_as (yytype73 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_386 is
			--|#line 1641
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_as (yytype86 (yyvs.item (yyvsp)).first) 
			yyval := yyval23
		end

	yy_do_action_387 is
			--|#line 1643
		local
			yyval23: EXPR_AS
		do

yyval23 := new_expr_address_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_388 is
			--|#line 1645
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_current_as 
			yyval := yyval23
		end

	yy_do_action_389 is
			--|#line 1647
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_result_as 
			yyval := yyval23
		end

	yy_do_action_390 is
			--|#line 1651
		local
			yyval30: ID_AS
		do

yyval30 := new_id_as (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_391 is
			--|#line 1659
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_392 is
			--|#line 1661
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_393 is
			--|#line 1663
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_394 is
			--|#line 1665
		local
			yyval10: CALL_AS
		do

yyval10 := new_current_as 
			yyval := yyval10
		end

	yy_do_action_395 is
			--|#line 1667
		local
			yyval10: CALL_AS
		do

yyval10 := new_result_as 
			yyval := yyval10
		end

	yy_do_action_396 is
			--|#line 1669
		local
			yyval10: CALL_AS
		do

yyval10 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_397 is
			--|#line 1671
		local
			yyval10: CALL_AS
		do

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_398 is
			--|#line 1673
		local
			yyval10: CALL_AS
		do

yyval10 := yytype45 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_399 is
			--|#line 1675
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_400 is
			--|#line 1677
		local
			yyval10: CALL_AS
		do

yyval10 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_401 is
			--|#line 1681
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (new_current_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_402 is
			--|#line 1685
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (new_result_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_403 is
			--|#line 1689
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype1 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_404 is
			--|#line 1693
		local
			yyval42: NESTED_EXPR_AS
		do

yyval42 := new_nested_expr_as (yytype23 (yyvs.item (yyvsp - 3)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_405 is
			--|#line 1697
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype45 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_406 is
			--|#line 1701
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor_as (Void, yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_407 is
			--|#line 1703
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype85 (yyvs.item (yyvsp - 4)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_408 is
			--|#line 1705
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype85 (yyvs.item (yyvsp - 2)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_409 is
			--|#line 1707
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype85 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_410 is
			--|#line 1709
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype85 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_411 is
			--|#line 1711
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype85 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_412 is
			--|#line 1713
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype85 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_413 is
			--|#line 1715
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype85 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_414 is
			--|#line 1717
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype85 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_415 is
			--|#line 1719
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype85 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_416 is
			--|#line 1721
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype85 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_417 is
			--|#line 1723
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype85 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_418 is
			--|#line 1725
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype85 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_419 is
			--|#line 1727
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype85 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_420 is
			--|#line 1731
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_421 is
			--|#line 1733
		local
			yyval10: CALL_AS
		do

yyval10 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_422 is
			--|#line 1737
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_423 is
			--|#line 1739
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype41 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_424 is
			--|#line 1743
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

	yy_do_action_425 is
			--|#line 1756
		local
			yyval2: ACCESS_FEAT_AS
		do

yyval2 := new_access_feat_as (yytype30 (yyvs.item (yyvsp - 1)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval2
		end

	yy_do_action_428 is
			--|#line 1764
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

yyval65 := yytype65 (yyvs.item (yyvsp - 1)) 
			yyval := yyval65
		end

	yy_do_action_429 is
			--|#line 1768
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_430 is
			--|#line 1773
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := yytype65 (yyvs.item (yyvsp - 2))
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_431 is
			--|#line 1780
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

yyval65 := new_eiffel_list_expr_as (0) 
			yyval := yyval65
		end

	yy_do_action_432 is
			--|#line 1782
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_433 is
			--|#line 1786
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_434 is
			--|#line 1791
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := yytype65 (yyvs.item (yyvsp - 2))
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_435 is
			--|#line 1802
		local
			yyval30: ID_AS
		do

yyval30 := new_id_as (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_436 is
			--|#line 1804
		local
			yyval30: ID_AS
		do

yyval30 := new_boolean_id_as 
			yyval := yyval30
		end

	yy_do_action_437 is
			--|#line 1806
		local
			yyval30: ID_AS
		do

yyval30 := new_character_id_as (False) 
			yyval := yyval30
		end

	yy_do_action_438 is
			--|#line 1808
		local
			yyval30: ID_AS
		do

yyval30 := new_character_id_as (True) 
			yyval := yyval30
		end

	yy_do_action_439 is
			--|#line 1810
		local
			yyval30: ID_AS
		do

yyval30 := new_double_id_as 
			yyval := yyval30
		end

	yy_do_action_440 is
			--|#line 1812
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (8) 
			yyval := yyval30
		end

	yy_do_action_441 is
			--|#line 1814
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (16) 
			yyval := yyval30
		end

	yy_do_action_442 is
			--|#line 1816
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (32) 
			yyval := yyval30
		end

	yy_do_action_443 is
			--|#line 1818
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (64) 
			yyval := yyval30
		end

	yy_do_action_444 is
			--|#line 1820
		local
			yyval30: ID_AS
		do

yyval30 := new_none_id_as 
			yyval := yyval30
		end

	yy_do_action_445 is
			--|#line 1822
		local
			yyval30: ID_AS
		do

yyval30 := new_pointer_id_as 
			yyval := yyval30
		end

	yy_do_action_446 is
			--|#line 1824
		local
			yyval30: ID_AS
		do

yyval30 := new_real_id_as 
			yyval := yyval30
		end

	yy_do_action_447 is
			--|#line 1828
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_448 is
			--|#line 1830
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_449 is
			--|#line 1832
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_450 is
			--|#line 1834
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype46 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_451 is
			--|#line 1836
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_452 is
			--|#line 1838
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_453 is
			--|#line 1842
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_454 is
			--|#line 1844
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_455 is
			--|#line 1846
		local
			yyval6: ATOMIC_AS
		do

				if token_buffer.is_integer then
					yyval6 := new_integer_as (token_buffer.to_integer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval6 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval6 := new_integer_as (0)
				end
			
			yyval := yyval6
		end

	yy_do_action_456 is
			--|#line 1861
		local
			yyval6: ATOMIC_AS
		do

yyval6 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval6
		end

	yy_do_action_457 is
			--|#line 1863
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_458 is
			--|#line 1865
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_459 is
			--|#line 1869
		local
			yyval9: BOOL_AS
		do

yyval9 := new_boolean_as (False) 
			yyval := yyval9
		end

	yy_do_action_460 is
			--|#line 1871
		local
			yyval9: BOOL_AS
		do

yyval9 := new_boolean_as (True) 
			yyval := yyval9
		end

	yy_do_action_461 is
			--|#line 1875
		local
			yyval12: CHAR_AS
		do

				check is_character: not token_buffer.is_empty end
				yyval12 := new_character_as (token_buffer.item (1))
			
			yyval := yyval12
		end

	yy_do_action_462 is
			--|#line 1882
		local
			yyval36: INTEGER_AS
		do

				if token_buffer.is_integer then
					yyval36 := new_integer_as (token_buffer.to_integer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval36 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval36 := new_integer_as (0)
				end
			
			yyval := yyval36
		end

	yy_do_action_463 is
			--|#line 1897
		local
			yyval36: INTEGER_AS
		do

				if token_buffer.is_integer then
					yyval36 := new_integer_as (token_buffer.to_integer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval36 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval36 := new_integer_as (0)
				end
			
			yyval := yyval36
		end

	yy_do_action_464 is
			--|#line 1912
		local
			yyval36: INTEGER_AS
		do

				if token_buffer.is_integer then
					yyval36 := new_integer_as (- token_buffer.to_integer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval36 := new_integer_as_from_hexa (token_buffer)	
				else
					token_buffer.precede ('-')
					report_integer_too_small_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval36 := new_integer_as (0)
				end
			
			yyval := yyval36
		end

	yy_do_action_465 is
			--|#line 1930
		local
			yyval46: REAL_AS
		do

yyval46 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval46
		end

	yy_do_action_466 is
			--|#line 1932
		local
			yyval46: REAL_AS
		do

yyval46 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval46
		end

	yy_do_action_467 is
			--|#line 1934
		local
			yyval46: REAL_AS
		do

				token_buffer.precede ('-')
				yyval46 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval46
		end

	yy_do_action_468 is
			--|#line 1941
		local
			yyval7: BIT_CONST_AS
		do

yyval7 := new_bit_const_as (new_id_as (token_buffer)) 
			yyval := yyval7
		end

	yy_do_action_469 is
			--|#line 1945
		local
			yyval54: STRING_AS
		do

yyval54 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval54
		end

	yy_do_action_470 is
			--|#line 1947
		local
			yyval54: STRING_AS
		do

yyval54 := new_empty_string_as 
			yyval := yyval54
		end

	yy_do_action_471 is
			--|#line 1949
		local
			yyval54: STRING_AS
		do

yyval54 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval54
		end

	yy_do_action_472 is
			--|#line 1953
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_473 is
			--|#line 1955
		local
			yyval54: STRING_AS
		do

yyval54 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval54
		end

	yy_do_action_474 is
			--|#line 1957
		local
			yyval54: STRING_AS
		do

yyval54 := new_lt_string_as 
			yyval := yyval54
		end

	yy_do_action_475 is
			--|#line 1959
		local
			yyval54: STRING_AS
		do

yyval54 := new_le_string_as 
			yyval := yyval54
		end

	yy_do_action_476 is
			--|#line 1961
		local
			yyval54: STRING_AS
		do

yyval54 := new_gt_string_as 
			yyval := yyval54
		end

	yy_do_action_477 is
			--|#line 1963
		local
			yyval54: STRING_AS
		do

yyval54 := new_ge_string_as 
			yyval := yyval54
		end

	yy_do_action_478 is
			--|#line 1965
		local
			yyval54: STRING_AS
		do

yyval54 := new_minus_string_as 
			yyval := yyval54
		end

	yy_do_action_479 is
			--|#line 1967
		local
			yyval54: STRING_AS
		do

yyval54 := new_plus_string_as 
			yyval := yyval54
		end

	yy_do_action_480 is
			--|#line 1969
		local
			yyval54: STRING_AS
		do

yyval54 := new_star_string_as 
			yyval := yyval54
		end

	yy_do_action_481 is
			--|#line 1971
		local
			yyval54: STRING_AS
		do

yyval54 := new_slash_string_as 
			yyval := yyval54
		end

	yy_do_action_482 is
			--|#line 1973
		local
			yyval54: STRING_AS
		do

yyval54 := new_mod_string_as 
			yyval := yyval54
		end

	yy_do_action_483 is
			--|#line 1975
		local
			yyval54: STRING_AS
		do

yyval54 := new_div_string_as 
			yyval := yyval54
		end

	yy_do_action_484 is
			--|#line 1977
		local
			yyval54: STRING_AS
		do

yyval54 := new_power_string_as 
			yyval := yyval54
		end

	yy_do_action_485 is
			--|#line 1979
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_486 is
			--|#line 1981
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_487 is
			--|#line 1983
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_488 is
			--|#line 1985
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_489 is
			--|#line 1987
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_490 is
			--|#line 1989
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_491 is
			--|#line 1991
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_492 is
			--|#line 1993
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_493 is
			--|#line 1997
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_minus_string_as) 
			yyval := yyval87
		end

	yy_do_action_494 is
			--|#line 1999
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_plus_string_as) 
			yyval := yyval87
		end

	yy_do_action_495 is
			--|#line 2001
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_not_string_as) 
			yyval := yyval87
		end

	yy_do_action_496 is
			--|#line 2003
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval87
		end

	yy_do_action_497 is
			--|#line 2007
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_lt_string_as) 
			yyval := yyval87
		end

	yy_do_action_498 is
			--|#line 2009
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_le_string_as) 
			yyval := yyval87
		end

	yy_do_action_499 is
			--|#line 2011
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_gt_string_as) 
			yyval := yyval87
		end

	yy_do_action_500 is
			--|#line 2013
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_ge_string_as) 
			yyval := yyval87
		end

	yy_do_action_501 is
			--|#line 2015
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_minus_string_as) 
			yyval := yyval87
		end

	yy_do_action_502 is
			--|#line 2017
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_plus_string_as) 
			yyval := yyval87
		end

	yy_do_action_503 is
			--|#line 2019
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_star_string_as) 
			yyval := yyval87
		end

	yy_do_action_504 is
			--|#line 2021
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_slash_string_as) 
			yyval := yyval87
		end

	yy_do_action_505 is
			--|#line 2023
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_mod_string_as) 
			yyval := yyval87
		end

	yy_do_action_506 is
			--|#line 2025
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_div_string_as) 
			yyval := yyval87
		end

	yy_do_action_507 is
			--|#line 2027
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_power_string_as) 
			yyval := yyval87
		end

	yy_do_action_508 is
			--|#line 2029
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_and_string_as) 
			yyval := yyval87
		end

	yy_do_action_509 is
			--|#line 2031
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval87
		end

	yy_do_action_510 is
			--|#line 2033
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_implies_string_as) 
			yyval := yyval87
		end

	yy_do_action_511 is
			--|#line 2035
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_or_string_as) 
			yyval := yyval87
		end

	yy_do_action_512 is
			--|#line 2037
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval87
		end

	yy_do_action_513 is
			--|#line 2039
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_xor_string_as) 
			yyval := yyval87
		end

	yy_do_action_514 is
			--|#line 2041
		local
			yyval87: PAIR [STRING_AS, CLICK_AST]
		do

yyval87 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval87
		end

	yy_do_action_515 is
			--|#line 2045
		local
			yyval4: ARRAY_AS
		do

yyval4 := new_array_as (yytype65 (yyvs.item (yyvsp - 1))) 
			yyval := yyval4
		end

	yy_do_action_516 is
			--|#line 2049
		local
			yyval56: TUPLE_AS
		do

yyval56 := new_tuple_as (yytype65 (yyvs.item (yyvsp - 1))) 
			yyval := yyval56
		end

	yy_do_action_517 is
			--|#line 2053
		local

		do
			yyval := yyval_default;
set_position (current_position) 

		end

	yy_do_action_518 is
			--|#line 2057
		local
			yyval90: TOKEN_LOCATION
		do

yyval90 := clone (current_position) 
			yyval := yyval90
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
			    0,  302,  304,  280,  280,  280,  280,  280,  280,  280,
			  280,  280,  280,  280,  280,  281,  282,  283,  289,  284,
			  286,  287,  285,  288,  290,  291,  292,  251,  251,  251,
			  253,  253,  253,  254,  254,  254,  252,  252,  176,  173,
			  173,  219,  219,  219,  143,  143,  143,  303,  303,  303,
			  303,  306,  306,  307,  307,  204,  204,  234,  234,  235,
			  235,  169,  169,  155,  308,  154,  154,  247,  247,  248,
			  248,  233,  233,  305,  305,  309,  309,  168,  299,  299,
			  296,  310,  310,  295,  295,  295,  293,  294,  147,  156,
			  156,  157,  157,  157,  263,  263,  263,  264,  264,  193,

			  193,  194,  194,  194,  194,  194,  194,  194,  265,  265,
			  266,  266,  197,  227,  227,  226,  226,  228,  228,  164,
			  170,  170,  236,  236,  238,  238,  237,  237,  240,  240,
			  239,  239,  242,  242,  241,  241,  274,  274,  275,  275,
			  276,  276,  216,  311,  311,  278,  278,  279,  279,  217,
			  249,  249,  250,  250,  212,  212,  202,  312,  201,  201,
			  201,  166,  167,  313,  206,  206,  182,  182,  277,  277,
			  256,  256,  257,  257,  179,  314,  314,  180,  180,  180,
			  180,  180,  180,  180,  180,  180,  180,  198,  198,  316,
			  198,  317,  163,  163,  318,  163,  319,  269,  269,  270,

			  270,  208,  209,  209,  209,  211,  211,  215,  215,  215,
			  215,  215,  215,  213,  213,  213,  213,  213,  213,  213,
			  213,  213,  213,  213,  213,  272,  272,  272,  273,  273,
			  244,  244,  245,  245,  246,  246,  171,  320,  300,  300,
			  243,  243,  175,  224,  224,  225,  225,  162,  258,  258,
			  177,  220,  220,  221,  221,  151,  260,  260,  183,  183,
			  183,  183,  183,  183,  183,  183,  183,  183,  259,  259,
			  185,  271,  271,  184,  184,  321,  218,  218,  218,  161,
			  267,  267,  267,  268,  268,  199,  255,  255,  142,  142,
			  200,  200,  222,  222,  223,  223,  158,  158,  158,  158,

			  158,  158,  203,  203,  203,  203,  203,  203,  203,  203,
			  203,  203,  203,  203,  203,  203,  261,  261,  262,  262,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  159,  159,  159,  160,  160,
			  214,  214,  137,  137,  140,  140,  178,  178,  178,  178,
			  178,  178,  178,  153,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  174,  150,  150,  150,  150,  150,  150,  150,  150,  150,

			  150,  190,  189,  188,  191,  187,  195,  195,  195,  195,
			  195,  195,  195,  195,  195,  195,  195,  195,  195,  195,
			  149,  149,  186,  186,  138,  139,  229,  229,  229,  230,
			  230,  231,  231,  232,  232,  172,  172,  172,  172,  172,
			  172,  172,  172,  172,  172,  172,  172,  144,  144,  144,
			  144,  144,  144,  145,  145,  145,  145,  145,  145,  148,
			  148,  152,  181,  181,  181,  196,  196,  196,  146,  205,
			  205,  205,  207,  207,  207,  207,  207,  207,  207,  207,
			  207,  207,  207,  207,  207,  207,  207,  207,  207,  207,
			  207,  207,  207,  298,  298,  298,  298,  297,  297,  297,

			  297,  297,  297,  297,  297,  297,  297,  297,  297,  297,
			  297,  297,  297,  297,  297,  141,  210,  315,  301>>)
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
			    3,    1,    2,    0,    1,    0,    2,    3,    1,    3,
			    2,    0,    1,    1,    1,    1,    2,    2,    3,    1,
			    2,    2,    2,    2,    0,    2,    2,    1,    2,    2,

			    3,    2,    8,    7,    6,    5,    4,    3,    1,    2,
			    1,    3,    3,    0,    1,    2,    2,    1,    2,    3,
			    1,    1,    1,    3,    0,    1,    1,    2,    0,    1,
			    1,    2,    0,    1,    1,    2,    0,    3,    0,    1,
			    1,    2,    5,    0,    3,    0,    1,    1,    2,    4,
			    1,    3,    0,    1,    0,    2,    8,    0,    1,    1,
			    1,    3,    2,    0,    0,    2,    2,    2,    0,    2,
			    1,    2,    1,    2,    3,    0,    2,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    0,    3,    0,
			    4,    0,    0,    3,    0,    4,    0,    0,    1,    1,

			    2,    3,    1,    3,    2,    1,    1,    3,    3,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    0,    2,    3,    1,    3,
			    0,    4,    0,    1,    1,    3,    3,    0,    0,    3,
			    0,    3,    8,    0,    1,    1,    2,    4,    0,    2,
			    6,    0,    1,    1,    2,    4,    1,    3,    1,    1,
			    1,    3,    3,    3,    3,    3,    3,    3,    0,    2,
			   10,    0,    2,    0,    3,    0,    0,    4,    2,    5,
			    0,    2,    3,    1,    3,    1,    0,    2,    3,    3,
			    3,    3,    0,    1,    1,    2,    1,    3,    2,    1,

			    3,    2,    5,    5,    5,    7,    7,    5,    3,    4,
			    4,    4,    6,    5,    4,    3,    0,    3,    1,    3,
			    1,    1,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    3,    5,    3,    6,    5,    4,
			    0,    1,    1,    1,    0,    3,    1,    1,    1,    1,
			    1,    1,    1,    4,    1,    1,    1,    1,    1,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    4,    3,
			    4,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    2,    2,    2,    2,    2,    4,    2,    4,    2,    2,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    3,    3,    3,    5,    3,    2,    7,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    1,    1,    3,    3,    2,    2,    0,    2,    3,    1,
			    3,    0,    1,    1,    3,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    2,    2,    1,    2,    2,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    3,    3,    0,    0>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   27,   40,   51,  446,  445,  444,  438,  443,  441,  440,
			  442,  439,  437,  436,  435,    0,    0,   36,   40,   52,
			   53,    0,   53,   39,  492,  491,  490,  489,  488,  487,
			  486,  485,  484,  483,  482,  481,  480,  479,  478,  477,
			  476,  475,  474,  471,  473,  470,  460,  459,    0,   43,
			    0,  468,  472,  465,  461,  462,    0,    0,   41,   45,
			  451,  447,  448,    0,   44,  449,  450,  452,  469,   73,
			   37,   54,   48,    0,   53,   53,   47,    0,   26,   25,
			   24,   18,   23,   21,   20,   22,   19,   17,   16,    0,
			    0,    0,    0,   15,    0,  205,  206,  225,  225,  225,

			  225,  225,  225,  225,  225,  225,  225,  225,  225,  467,
			  464,  466,  463,   46,    0,   74,   38,  518,    3,    4,
			    6,    7,   10,    8,    9,   11,    5,   12,   13,   14,
			   50,   49,    0,  225,  212,  211,  225,    0,    0,  210,
			  209,  344,    0,  213,  214,  215,  217,  220,  218,  219,
			  221,  216,  222,  223,  224,   42,  164,    0,  344,  208,
			  207,    0,  339,  226,  228,    0,    0,   55,  232,  338,
			  426,  227,    0,  165,    0,   94,  237,  234,    0,  233,
			    0,  345,  229,   56,  518,  518,  238,  231,    0,    0,
			  395,    0,  426,  394,    0,  431,    0,  427,  431,    0,

			  456,  455,    0,    0,    0,    0,  390,    0,    0,  396,
			  355,  354,  457,  453,  357,  454,  400,  429,  426,    0,
			  399,  393,  392,  391,  397,  398,  358,  458,  356,    0,
			   97,  518,    0,   96,  292,    0,  236,  235,    0,    0,
			    0,    0,    0,    0,    0,    0,  316,    0,  406,    0,
			    0,  389,    0,    0,  388,    0,   83,   84,   85,  386,
			  433,    0,  432,    0,    0,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,    0,  316,    0,  383,
			  152,  382,  380,  381,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,  424,  384,    0,  428,    0,   98,
			   99,  225,  299,  296,  294,   57,  293,  240,  316,  316,
			  421,  402,  426,  420,    0,    0,    0,    0,    0,    0,
			    0,  308,    0,  316,  401,  496,  495,  494,  493,   87,
			  514,  513,  512,  511,  510,  509,  508,  507,  506,  505,
			  504,  503,  502,  501,  500,  499,  498,  497,   86,    0,
			  516,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  515,  315,  359,  150,  153,
			    0,  403,  366,  365,  364,  363,  362,  361,  360,  373,
			  375,  374,  376,  377,  378,    0,  367,  372,    0,  369,

			  371,  379,  316,  405,  430,  100,  101,    0,    0,  301,
			    0,  298,   64,   81,   59,  518,   58,  295,    0,  239,
			  314,  309,    0,  425,  316,  316,  316,    0,    0,  320,
			    0,  321,  318,    0,  316,  426,  310,  387,  434,    0,
			  316,  426,  426,  426,  426,  426,  426,  426,  426,  426,
			  426,  426,    0,    0,    0,  385,  368,  370,  311,  126,
			  134,  108,  130,   73,  107,  124,  128,  132,    0,  113,
			   67,    0,   69,  300,  122,  297,   65,   82,   71,   81,
			   78,  136,    0,  273,   60,    0,  422,  423,  307,  302,
			  303,    0,    0,  206,  225,  225,  225,  225,  225,  225,

			  225,  225,  225,  225,  225,  225,  317,    0,  304,  408,
			    0,  313,  409,  410,  411,  412,  415,  413,  414,  416,
			  417,  418,  419,  316,  404,  151,  127,  135,  110,  109,
			    0,  131,  117,  115,    0,  116,  125,  128,  129,  132,
			  133,    0,  106,  114,  124,   68,    0,    0,   63,   66,
			   72,   81,  138,   75,  154,   80,  275,  518,  241,  316,
			  316,  334,  213,  214,  215,  217,  220,  218,  219,  221,
			  216,  222,  223,  224,  319,  426,  312,    0,    0,  118,
			  120,   73,  121,  132,    0,  105,  128,   70,  123,   79,
			  140,    0,    0,  139,   77,    0,   33,  517,   27,  306,

			  305,  322,  323,  324,  326,  329,  327,  328,  330,  325,
			  331,  332,  333,  407,  111,  112,  119,    0,  104,  132,
			  143,  137,  141,   76,  155,   30,   40,   88,   89,  199,
			  274,  517,    0,    0,  103,    0,    0,    0,   33,   40,
			   33,   90,   55,   35,   40,  200,  202,  426,   73,    2,
			    1,  102,    0,   73,   92,   40,   91,   93,  157,   34,
			  204,  201,  144,  142,  187,  203,  189,  168,  191,  517,
			  145,    0,  517,  188,  147,    0,  169,  146,  175,  163,
			  175,  160,  159,  158,  192,  190,    0,  148,  167,  517,
			  164,    0,  166,  194,  286,   73,  176,  172,  517,  518,

			  161,  162,  196,  517,  175,    0,  149,  173,  285,    0,
			    0,    0,    0,  340,    0,  346,  179,  185,  177,  184,
			  426,  181,  182,  178,  175,  183,  352,  348,  347,  349,
			  350,  351,  186,  180,    0,  517,  193,  287,  156,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  343,    0,  344,  342,  341,    0,    0,    0,
			    0,  174,    0,    0,  175,  280,  517,  195,  289,  291,
			    0,  336,    0,    0,  288,  290,  251,    0,  271,    0,
			  175,    0,    0,  344,    0,  253,  268,  252,  175,  517,
			  276,  281,  283,    0,    0,  353,  344,  335,  259,  260,

			  258,  256,    0,  175,    0,  254,  243,  272,    0,    0,
			  282,    0,  279,  337,    0,    0,    0,  175,    0,  269,
			  250,    0,  245,  248,  244,  278,  426,    0,  284,  265,
			  267,  266,  264,  263,  262,  261,  255,  257,    0,  175,
			    0,  246,    0,    0,  175,  249,  242,  277,  175,  247,
			    0,  270,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  754,  209,  320,  162,  210,  716,   58,   59,  211,  212,
			  553,  213,  321,  214,  785,  215,  717,  408,  413,  627,
			  641,  314,  718,  216,  719,  822,  694,  532,  260,  682,
			  690,  478,  414,  581,  177,  218,   16,  219,  721,   17,
			  722,  723,  697,  724,   65,  683,  801,  557,  725,  323,
			  220,  221,  222,  223,  224,  432,  230,  310,  225,   66,
			  528,  667,  732,  733,  684,  657,  226,  175,  227,  167,
			   68,  629,  648,  228,  264,  596,   95,  757,   96,  590,
			  674,  809,   69,  786,  787,  315,  316,  823,  824,  465,
			  544,  533,  304,  229,  261,  262,  479,  415,  416,  473,

			  536,  537,  538,  539,  540,  541,  419,  156,  178,  179,
			  534,  471,  591,  380,    2,   18,  642,  628,  705,  688,
			  698,  840,  804,  802,  331,  433,  185,  231,  469,  529,
			  780,  793,  630,  631,  790,  143,  165,  554,  592,  593,
			  671,  676,  677,  256,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  257,  258,  474,  480,
			  358,  339,  481,  236,  232,  852,   21,  650,  116,   22,
			   72,  476,  594,  482,  637,  664,  691,  689,  632,  669,
			  672,  703,  735,  186,  597>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  380, 2228,  110, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  590, 1735, -32768, 2197, -32768,
			  557,  570,  -25, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  581, -32768,
			 2334, -32768, -32768, -32768, -32768, -32768,  112,   49, -32768, -32768,
			 -32768, -32768, -32768,  569, -32768, -32768, -32768, -32768, -32768,  162,
			 -32768, -32768, -32768, 2479,  557,  557, -32768, 2334, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2479,
			 2460, 2479,  901, -32768,  589, -32768, -32768,  480,  480,  480,

			  480,  480,  480,  480,  480,  480,  480,  480,  480, -32768,
			 -32768, -32768, -32768, -32768, 1858, -32768, -32768,  406, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  576,  480, -32768, -32768,  480,  585,  583, -32768,
			 -32768,  196, 2314, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  391,  561,  196, -32768,
			 -32768, 2444, -32768, -32768, -32768,  207, 1132,  360,  567, -32768,
			  446, -32768, 2334, -32768, 1111,  528, -32768, -32768,  553,  565,
			 1447, -32768, -32768, -32768,  462, -32768,  551, -32768,  567,  503,
			  143, 2136,   29,  114, 1976, 1570, 2279, -32768, 1570, 2444,

			 -32768, -32768, 1570, 1570,  562, 1570, -32768, 1570, 1570,  370,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, 1203,   77, 1570,
			 -32768, -32768, -32768, -32768, -32768,  366, -32768, -32768, -32768,  233,
			 -32768,   16, 2479, -32768,  368, 2479, -32768, -32768, 2444, 2444,
			 2444,  573,  566,  564, 2334, 1570,  388, 2479, -32768, 2444,
			 2444, -32768,  107, 2597, -32768, 1570, -32768, -32768, -32768, -32768,
			 1203,  537,  543, 2479,  496,  354,  346,  339,  322,  319,
			  313,  301,  283,  270,  262,  253,  538,  451, 2687, -32768,
			 2444, -32768, -32768, -32768, 2444, 1570, 1570, 1570, 1570, 1570,
			 1570, 1570, 1570, 1570, 1570, 1570, 1570, 1570, 1324, 1570,

			 1066, 1570, 1570, 2444, -32768, -32768, 2444, -32768, 1570, -32768,
			  544,  480, 2362, 2362, -32768,  476,  368,  515,  451,  451,
			  509, -32768,  446, -32768, 2444, 2444, 2444,  533, 2669, 1693,
			 2444, -32768,  532,  451, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2626,
			 -32768, 1570,  531, 2444,  491,  490,  488,  485,  483,  482,
			  481,  479,  478,  477,  468, -32768, -32768,   72, -32768,  510,
			  502, -32768,  387,  387,  387,  387,  387,  418,  418,  906,
			  906,  906,  906,  906,  906, 1570, 2757, 2743, 1570, 2728,

			 2649, -32768,  451, -32768, 1203, -32768,  147,  740,  158, 2377,
			  158, 2377, -32768,  267, -32768, -32768,  476, -32768,  158, -32768,
			 -32768, -32768, 2444, -32768,  451,  451,  451,  519,  518,  503,
			 2279, 1203, -32768,  213,  451,  446, -32768, -32768, 1203,  495,
			  451,  446,  446,  446,  446,  446,  446,  446,  446,  446,
			  446,  446, 2444, 2444, 2444, -32768, 2757, 2728, -32768,  158,
			  158,  158,  158,  179, -32768,  401,  379,  356,  474,  469,
			 -32768,   97, -32768,  430, -32768,  430,  455, -32768, -32768,  216,
			 -32768,   20,  158,  457, -32768,   14,  509, -32768, -32768, -32768,
			 -32768, 2444, 2444,  486,  354,  346,  339,  322,  319,  313,

			  301,  283,  480,  270,  262,  253, -32768, 1693, -32768, -32768,
			  417, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,  451, -32768, -32768,  430,  430, -32768,  466,
			  471,  430, -32768,  455, 1028, -32768, -32768,  379, -32768,  356,
			 -32768,  435, -32768, -32768,  401, -32768, 2479,  158, -32768, -32768,
			 -32768,  425, 2444, -32768,  454, -32768, -32768, -32768, -32768,  451,
			  451, -32768,  449,  448,  447,  445,  440,  439,  438,  434,
			  432,  428,  427,  426, -32768,  446, -32768,  158,  158, -32768,
			 -32768,  362,  430,  356,  404, -32768,  379, -32768, -32768, -32768,
			 -32768,  257,  410, 2444,  412, 2334,  180,  148,  380, -32768,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  381, -32768,  356,
			  396, -32768, -32768, -32768, -32768, 1981, 2427, -32768, -32768, -32768,
			 -32768,  698, 1570,  375, -32768,  367, 2444, 2334,  355, 2170,
			  355, -32768,  360, -32768, 2397, -32768, 1203,  269,  362, -32768,
			 -32768, -32768,  378,  362, -32768, 1842, -32768, -32768, -32768, -32768,
			 1570, -32768, -32768, -32768,  334, 1203,  357,  338, -32768,   45,
			 2444,   66,   45, -32768, -32768,  235, -32768, 2444, -32768, -32768,
			 -32768, -32768, -32768, -32768,  349, -32768, 2334, -32768, -32768,  256,
			  391, 1132, -32768,  321,  320,  362, -32768, -32768,  494, 2113,

			 -32768, -32768, -32768,  -20, -32768,  273, -32768, -32768, -32768,   10,
			  372,  634, 1912, 2334, 1570,  370, -32768, -32768, -32768, -32768,
			   12, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  366, -32768, -32768,   63,  -20, -32768, -32768, -32768, 1570,
			 1570,  341,  337,  317,  311,  306,  304,  299,  295,  289,
			  286,  281, -32768, 2334,  196, -32768, -32768,  291, 2608, 1570,
			 1570,  279, 1570, 1570, -32768,  288,  247, -32768, 1203, 1203,
			  245, -32768, 1282,  260, 1203, 1203, 1265, 1633,  211, 2002,
			 -32768,  217, 1282,  196,  862, -32768,  214,  150, -32768,  -51,
			  140, -32768, -32768,  187,  169, -32768,  196, -32768,  203,  172,

			  170, -32768,  -22, -32768,  124, -32768,   69, -32768, 1570,   60,
			 -32768, 1132, -32768, -32768,  352,  862,  901, -32768,  862, -32768,
			 -32768, 1570, -32768,  100,   69, 1203,  141, 1570, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 1510, -32768,
			   52, -32768, 1570, 2590, -32768, -32768, -32768, 1203, -32768, -32768,
			    7, -32768,   96,   31, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -695,   32,  296, -146, -32768, -32768,  603,   91, -32768,   -3,
			 -32768,   -5, -222, -32768,  -72,  -15, -32768, -299, -32768, -32768,
			 -32768,  393, -32768,    5, -32768, -119, -32768,  174,  223, -32768,
			 -32768,  225,  292, -32768,  514,   -1, -32768,  560, -32768,  -11,
			 -32768, -32768,  -14, -32768,  -90, -32768, -140, -32768, -32768,  274,
			    2,    1,    0,   -8,  -13,  167,  459, -32768,  -17, -32768,
			   98, -32768, -32768, -32768, -32768, -32768, -32768,   21,  -10,  -29,
			 -162,   22, -32768, -32768,  -21, -32768,  453, -32768,  229,   64,
			  -19, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  182,
			 -32768, -32768,  -70, -32768,  443, -32768, -32768, -32768, -32768, -377,

			  249,  103,  236, -510,  234, -514, -32768, -32768, -32768, -32768,
			 -290, -32768, -272, -32768,   38, -452, -32768, -493, -32768, -504,
			 -32768, -32768, -32768, -32768,  563, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -605, -32768, -32768,  800, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,  -39,  119,  115,  108,   11,  -18,  -26,
			  -30,  -34,  -24,  -40,  -41,  -47, -32768, -32768, -155,   81,
			 -32768, -32768, -32768, -32768, -112, -32768, -32768, -32768, -165, -32768,
			   18, -32768, -32768, -32768, -32768, -32768, -32768,  -94, -470, -32768,
			 -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   15,   62,  140,  108,  173,  157,   67,   70,  379,  107,
			  106,   61,  169,   60,  410,   64,  104,   15,  818,  233,
			  103,   63,  409,  411,  102,  584,  105,  583,  334,   94,
			  108,  854,  101,  475,  117,  240,  107,  106,  180,  259,
			   76,  485,   75,  104,   71, -197,  552,  103, -197, -197,
			  133,  102,  136,  105,  547,  180,  132,  -95,  -95,  101,
			  551,  100,  381,  740,  673,  760,  739,  685,  759,  617,
			   74, -197,  851,  234,  817,  247,  619,  783,  112,  558,
			  111,  -95,  526,  527,  403,  531,  -95,  796,  100,  135,
			  -95,  139,  130,  131,  -95,  108,  853,  453,  736,   62,

			  181,  107,  106,  180,   67,  635, -197, -197,  104,   61,
			  452,   60,  103,   64, -197,  303,  102,  846,  105,   63,
			  766,  164,  248,  765,  101,  108, -197,  681,  680, -197,
			  767,  107,  106,  821,  764,  679,  763,  546,  104,  250,
			  762,  110,  103,  109,  545,  654,  102,  656,  105,  275,
			  678,  182,  249,  100,  101,  274,  273,  582,   99,  827,
			  170,  781,  272,  839,  183,   98,  271,  180,  240,   97,
			  270,   20,  105,  816,  644,  815,  692,  548,  269,  303,
			  842,  239,   19,  100,  807,   99,  549,  655,  108,  820,
			  246,   93,   98,  311,  107,  106,   97,  108,  277,  115,

			  737,  104,  114,  107,  106,  103,  814,  268,  332,  102,
			  104,  105,  464, -197,  103,  463,  115,  101,  102,  699,
			  105,  161, -197,  327,  362,  407,  101,  811,  699,  338,
			  337,  524,  810,  253,  812,  462,  461,  318,  319,  322,
			  808,  460,  336,  335,  459,  252,  100,  172,  333,  322,
			   99,  784,  423,  507,  626,  100,  171,   98,  506,  625,
			  778,   97,   88,   87,   86,   85,   84,   83,   82,   81,
			   80,   79,   78,  308,  686,  454,  794,  803,  307,  378,
			   99,  -62,  795,  322,  806,  453,  -62,   98,  477,  789,
			  -62,   97,  782,  696,  -62,  180,  620,  454,  535,  819,

			  374,  142,  402,  483,  267,  322,  530,  303,  660,  373,
			  142,  266, -197,  836,  779,  265,  696,  372,  142, -170,
			 -170, -170, -170,  424,  425,  426,  772,  555,  374,  434,
			  371,  142,  -61,  373, -170,  845,  372,  -61,  738,  477,
			  849,  -61,  371,   99,  850,  -61,  370, -170,  370,  142,
			   98,  369,   99,  368,   97, -170, -170, -170,  367,   98,
			  369,  142,  440,   97,  366,  509,  368,  142,  472,  367,
			  142,  512,  513,  514,  515,  516,  517,  518,  519,  520,
			  521,  522,   54,  505,  365,   14,  366,  142,  364,  504,
			  503,  306,  588,  365,  142,  284,  501,  250,  675,  115,

			  500,  364,  142,  217,  499,  675,  502,  285,  206,  313,
			  312,  704,  498,  330,  329,  693,  616,  702,  166,  670,
			  668,  322,  530,  615,  666,  278,  279,  662,  281,  626,
			  282,  283,  651, -230,  289,  288,  287,  286,  285,  206,
			  649,  497,  305,  174,  636,  598,  634, -230, -230,  623,
			  460,  523,  322,  525,    1,  621,   13,   12,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,  462,  328,  618,
			  547, -230,  180,  612,  611,  610, -230,  329,  359,  609,
			 -230,  608, -230,  661, -230,  607,  606,  605,  663, -230,
			  559,  560,  604,  595,  603,  602,  601,  477,  459,  115,

			  585,  407,  575,  -73,  -73,  613,  577,  587,  382,  383,
			  384,  385,  386,  387,  388,  389,  390,  391,  392,  393,
			  394,  396,  397,  399,  400,  401,  578,  -73,  142,  701,
			  706,  404,  -73,  561,  422,  556,  -73,  463,  496,  542,
			  -73,  238,  510,  492,  491,  495,  412,  455,  108,  494,
			  454,  378,  431,  451,  107,  106,  418, -171, -171, -171,
			 -171,  104,  450,  449,  448,  103,  447,  446,  445,  102,
			  444,  105, -171,  443,  624,  442,  441,  101,  439,  435,
			  427,  405,  375,  361,  438, -171,  360,  734,  280,  326,
			  108,  325,  378, -171, -171, -171,  107,  106,  324,  363,

			  176,  235,  187,  104,  184,  188,  100,  103,  771,  168,
			   62,  102,  112,  105,  110,   67,  653,  792,  456,  101,
			   61,  457,   60,  158,  141,   15,   71,   77,   73,   23,
			  761,  647,  589,   70,  113,  652,  633,  797,   15,  108,
			  468,  276,  467,   15,   70,  107,  106,  586,  100,  828,
			  813,  543,  104,  645,   15,  466,  103,  622,  687,  493,
			  102,  700,  105,  658,  751,  695,  108,   93,  101,  378,
			  750,  749,  107,  106,  574,  614,  378,  748,  837,  104,
			  263,  747,  731,  103,  707,  746,  730,  102,  317,  105,
			  309,  729,  756,  745,  800,  101,  487,  100,  720,  728,

			  727,  726,  237,   99,  550,  841,  108,  579,  484,  417,
			   98,  755,  107,  106,   97,  805,  640,  155,  486,  104,
			    0,    0,  744,  103,  100,  833,  835,  102,  800,  105,
			  431,  715,  770,    0,    0,  101,    0,    0,   88,   87,
			   86,   85,   84,   83,   82,   99,   80,   79,   78,    0,
			    0,    0,   98,    0,    0,    0,   97,    0,    0, -198,
			 -198,    0,    0, -198,  100,    0,    0, -198,    0,  798,
			    0,  755, -198,   93,    0,    0,    0,  302,    0, -198,
			    0,  755, -198,  799,    0,    0,    0,  470,    0, -198,
			    0,    0,    0,    0,   99,    0,    0, -198, -198,  829,

			  831,   98,    0,  798,    0,   97,    0,  826,    0,    0,
			    0,    0,    0,  830,  832,  834,    0,  799,    0,  743,
			  302,   99,    0,    0,    0,    0,  742,    0,   98,    0,
			  741,    0,   97,    0,    0,    0,    0,    0,  302,  302,
			  376,  302,  302,  302,   88,   87,   86,   85,   84,   83,
			   82,   81,   80,   79,   78,  646,    0,    0,    0,    0,
			    0,   99,    0,    0,    0,  302,    0,    0,   98,    0,
			    0,    0,   97,    0,    0,    0,  138,  137,    0,    0,
			    0,  420,  421,  665,    0,    0,    0,    0,  302,    0,
			    0,   55,   54,    0,    0,   14,  436,    0,  144,  145,

			  146,  147,  148,  149,  150,  151,  152,  153,  154,    0,
			    0,    0,    0,    0,    0,  138,  137,    0,    0,  302,
			  291,  290,  289,  288,  287,  286,  285,  206,    0,    0,
			   55,    0,    0,  159,   14,    0,  160,  758,    0,    0,
			    0,    0,  302,  302,  302,  302,  302,  302,  302,  302,
			  302,  302,  302,  302,  302,    0,  302,  302,    0,  302,
			  302,  302,  768,  769,  302,  458,   13,   12,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,    0,    0,    0,
			    0,    0,  774,  775,    0,  776,  777,  488,  489,  490,
			    0,  302,    0,    0,    0,    0,    0,  508,  302,    0,

			    0,    0,    0,  511,    0,   13,   12,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,  302,  302,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  825,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  838,    0,    0,    0,    0,    0,
			  843,    0,    0,    0,    0,    0,  580,    0,    0,    0,
			    0,   93,    0,    0,    0,  847,  144,  145,  146,  147,
			  148,  149,  150,  152,  153,  154,    0,    0,    0,    0,
			  208,  207,    0,    0,    0,    0,  576,  206,  205,  204,
			  203,    0,  202,    0,    0,  201,   54,  200,   52,   14,

			   51,   50,    0,  253,  199,    0,    0,   48,    0,  198,
			    0,  406,  196,    0,  195,  252,    0,   47,   46,    0,
			  194,    0,  599,  600,    0,  193,    0,    0,    0,  398,
			    0,    0,   88,   87,   86,   85,   84,   83,   82,   81,
			   80,   79,   78,   52,    0,    0,    0,    0,    0,    0,
			    0,  192,  191,    0,    0,    0,    0,    0,  190,    0,
			    0,    0,    0,    0,   52,    0,    0,    0,  189,    0,
			   13,   12,   11,   10,    9,    8,    7,    6,    5,    4,
			    3,   45,   44,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,

			   26,   25,   24,    0,    0,    0,  302,  301,  300,  299,
			  298,  297,  296,  295,  294,  293,  292,  291,  290,  289,
			  288,  287,  286,  285,  206,  302,   45,   44,   43,   42,
			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   44,    0,
			   42,   41,   40,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,  301,
			  300,  299,  298,  297,  296,  295,  294,  293,  292,  291,
			  290,  289,  288,  287,  286,  285,  206,    0,    0,    0,
			    0,    0,    0,    0,  562,  563,  564,  565,  566,  567,

			  568,  569,  570,  571,  572,  573,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   14,    0,    0,  302,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  302,  302,
			    0,    0,    0,    0,  302,  302,  302,  302,  208,  207,
			    0,    0,    0,    0,    0,  206,  205,  204,  203,    0,
			  202,    0,    0,  201,   54,  200,   52,   14,   51,   50,
			    0,    0,  199,    0,    0,   48,  784,  198,    0,    0,
			  196,    0,  195,    0,  752,   47,   46,    0,  194,    0,
			    0,    0,    0,  193,    0,  302,   13,   12,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,    0,  302,    0,

			    0,    0,    0,  302,    0,    0,    0,  302,    0,  192,
			  191,    0,    0,    0,    0,    0,  190,    0,    0,    0,
			  395,    0,    0,    0,    0,    0,  189,    0,   13,   12,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,  208,  207,    0,    0,    0,    0,    0,  206,  205,
			  204,  203,    0,  202,    0,    0,  201,   54,  200,   52,
			   14,   51,   50,    0,    0,  199,    0,    0,   48,    0,
			  198,    0,  197,  196,    0,  195,    0,    0,   47,   46,

			    0,  194,    0,    0,    0,    0,  193,    0,    0,    0,
			    0,    0,    0,    0,  301,  300,  299,  298,  297,  296,
			  295,  294,  293,  292,  291,  290,  289,  288,  287,  286,
			  285,  206,  192,  191,    0,    0,    0,    0,    0,  190,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  189,
			    0,   13,   12,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,   45,   44,   43,   42,   41,   40,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,  208,  207,    0,    0,    0,    0,
			    0,  206,  205,  204,  203,    0,  202,    0,    0,  201,

			   54,  200,   52,   14,   51,   50,  844,    0,  199,    0,
			    0,   48,    0,  198,    0,    0,  196,    0,  195,    0,
			    0,   47,   46,    0,  194,    0,    0,    0,    0,  193,
			    0,    0,    0,    0,    0,    0,    0,  301,  300,  299,
			  298,  297,  296,  295,  294,  293,  292,  291,  290,  289,
			  288,  287,  286,  285,  206,  192,  191,    0,    0,    0,
			    0,    0,  190,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  189,    0,   13,   12,   11,   10,    9,    8,
			    7,    6,    5,    4,    3,   45,   44,   43,   42,   41,
			   40,   39,   38,   37,   36,   35,   34,   33,   32,   31,

			   30,   29,   28,   27,   26,   25,   24,  208,  207,    0,
			    0,    0,    0,    0,  206,  205,  204,  203,    0,  202,
			    0,    0,  201,   54,  200,   52,   14,   51,   50,  788,
			    0,  199,    0,    0,   48,    0,  198,    0,    0,  430,
			    0,  195,    0,    0,   47,   46,    0,  194,    0,   57,
			   56,    0,  193,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   55,   54,   53,   52,   14,   51,
			   50,    0,   49,    0,    0,    0,   48,    0,  192,  191,
			    0,    0,    0,    0,    0,  190,   47,   46,    0,    0,
			    0,    0,    0,    0,    0,  429,    0,   13,   12,   11,

			   10,    9,    8,    7,    6,    5,    4,    3,   45,   44,
			   43,   42,   41,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   13,
			   12,   11,   10,    9,    8,    7,    6,    5,    4,    3,
			   45,   44,   43,   42,   41,   40,   39,   38,   37,   36,
			   35,   34,   33,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,   57,   56,    0,   14,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   55,   54,   53,
			   52,   14,   51,   50,    0,    0,    0,    0,    0,   48,

			    0,    0,    0,  -31,  -31,    0,    0,    0,    0,   47,
			   46,  -31,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  -31,    0,  -31,  -31,    0,    0,    0,
			    0,    0,  -31,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   14,   13,   12,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,    0,  753,    0,
			    0,    0,   13,   12,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   57,   56,    0,    0,    0,

			    0,    0,  255,    0,  752,    0,    0,    0,    0,   93,
			   55,   54,   53,   52,    0,   51,   13,   12,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,    0,    0,    0,
			    0,    0,   47,   46,   52,  254,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  791,    0,    0,
			    0,  253,    0,    0,    0,  639,    0,    0,    0,    0,
			    0,    0,    0,  252,    0,    0,    0,    0,  251,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  638,
			   88,   87,   86,   85,   84,   83,   82,   81,   80,   79,
			   78,    0,    0,    0,    0,    0,   45,   44,   43,   42,

			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   44,    0,
			   42,   41,   40,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,  714,
			    0,    0,    0,    0,    0,    0,   14,    0,  713,    0,
			    0,    0,    0,    0,  712,    0,    0,    0,    0,  711,
			    0,    0,  245,    0,    0,    0,    0,    0,    0,   14,
			    0,    0,  710,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  244,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  243,    0,    0,  192,    0,

			    0,    0,    0,   14,    0,  709,  708,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   13,   12,   11,
			   10,    9,    8,    7,    6,    5,    4,    3,  242,    0,
			   14,  -32,  -32,    0,    0,    0,    0,    0,  241,  -32,
			   13,   12,   11,   10,    9,    8,    7,    6,    5,    4,
			    3,  -32,    0,  -32,  -32,  -28,    0,    0,  -28,    0,
			  -32,   14,  -28,    0,  -28,    0,  -28,    0,    0,  -28,
			    0,    0,    0,    0,   13,   12,   11,   10,    9,    8,
			    7,    6,    5,    4,    3,    0,  -29,    0,    0,  -29,
			    0,    0,  -28,  -29,    0,  -29,    0,  -29,    0,    0,

			  -29,   13,   12,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,   93,    0,    0,   92,    0,    0,    0,    0,
			    0,    0,    0,  -29,    0,  263,    0,    0,    0,    0,
			    0,    0,   13,   12,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,    0,    0,    0,   91,   93,    0,    0,
			   92,    0,    0,    0,    0,    0,    0,    0,    0,   90,
			    0,    0,    0,  163,    0,    0,    0,   93,    0,    0,
			   92,    0,    0,    0,   89,    0,    0,    0,    0,    0,
			    0,   91,    0,   88,   87,   86,   85,   84,   83,   82,
			   81,   80,   79,   78,   90,  -65,    0,    0,    0,    0,

			    0,   91,    0,    0,    0,    0,    0,    0,  407,   89,
			  -66,    0,    0,    0,   90,    0,    0,    0,   88,   87,
			   86,   85,   84,   83,   82,   81,   80,   79,   78,   89,
			   14,    0,    0,    0,    0,    0,    0,  -65,   88,   87,
			   86,   85,   84,   83,   82,   81,   80,   79,   78,  -65,
			    0,    0,  -66,    0,    0,    0,    0,    0,    0,    0,
			   14,    0,  659,    0,  -66,    0,  -65,  -65,  -65,  -65,
			  -65,  -65,  -65,  -65,  -65,  -65,  -65,   14,    0,    0,
			    0,  -66,  -66,  -66,  -66,  -66,  -66,  -66,  -66,  -66,
			  -66,  -66,  643,   14,    0,    0,    0,    0,    0,    0,

			    0,   13,   12,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,   93,    0,    0,    0,    0,    0,    0,  134,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   13,   12,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,    0,    0,    0,    0,    0,    0,   13,   12,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,    0,
			    0,    0,    0,    0,   13,   12,   11,   10,    9,    8,
			    7,    6,    5,    4,    3,    0,    0,    0,    0,    0,
			    0,    0,    0,   88,   87,   86,   85,   84,   83,   82,
			   81,   80,   79,   78,  301,  300,  299,  298,  297,  296,

			  295,  294,  293,  292,  291,  290,  289,  288,  287,  286,
			  285,  206,  301,  300,  299,  298,  297,  296,  295,  294,
			  293,  292,  291,  290,  289,  288,  287,  286,  285,  206,
			  301,  300,  299,  298,  297,  296,  295,  294,  293,  292,
			  291,  290,  289,  288,  287,  286,  285,  206,    0,    0,
			    0,    0,    0,  773,  300,  299,  298,  297,  296,  295,
			  294,  293,  292,  291,  290,  289,  288,  287,  286,  285,
			  206,  437,  848,  301,  300,  299,  298,  297,  296,  295,
			  294,  293,  292,  291,  290,  289,  288,  287,  286,  285,
			  206,  301,  300,  299,  298,  297,  296,  295,  294,  293,

			  292,  291,  290,  289,  288,  287,  286,  285,  206,    0,
			    0,    0,    0,    0,  428,  357,  356,  355,  354,  353,
			  352,  351,  350,  349,  348,  347,  346,  345,  344,  343,
			  342,  341,  377,  340,  299,  298,  297,  296,  295,  294,
			  293,  292,  291,  290,  289,  288,  287,  286,  285,  206,
			  298,  297,  296,  295,  294,  293,  292,  291,  290,  289,
			  288,  287,  286,  285,  206,  297,  296,  295,  294,  293,
			  292,  291,  290,  289,  288,  287,  286,  285,  206>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,   16,   92,   50,  166,  117,   16,   18,  280,   50,
			   50,   16,  158,   16,  313,   16,   50,   18,   40,  184,
			   50,   16,  312,  313,   50,  539,   50,  537,  250,   50,
			   77,    0,   50,  410,   73,   25,   77,   77,   26,  194,
			   22,  418,   67,   77,   69,   65,   26,   77,   99,  100,
			   89,   77,   91,   77,   40,   26,   77,   41,   42,   77,
			   40,   50,  284,   53,  669,   53,   56,  672,   56,  583,
			   95,   91,   65,  185,   96,   46,  586,  772,   29,   65,
			   31,   65,  459,  460,  306,  462,   70,  782,   77,   90,
			   74,   92,   74,   75,   78,  142,    0,   25,  703,  114,

			  170,  142,  142,   26,  114,  619,   61,   62,  142,  114,
			   38,  114,  142,  114,   69,   38,  142,   65,  142,  114,
			   57,  142,  192,   60,  142,  172,   81,   61,   62,   84,
			  735,  172,  172,   64,   71,   69,   73,   40,  172,   25,
			   77,   29,  172,   31,   47,  638,  172,  640,  172,  196,
			   84,  172,   38,  142,  172,  196,  196,  534,   50,   99,
			  161,  766,  196,   63,  174,   50,  196,   26,   25,   50,
			  196,   61,  196,    3,  626,    3,  680,  476,  196,   38,
			   39,   38,   72,  172,  789,   77,  476,  639,  235,   65,
			  191,   33,   77,  232,  235,  235,   77,  244,  199,   37,

			  704,  235,   40,  244,  244,  235,    3,  196,  247,  235,
			  244,  235,   65,   65,  244,   68,   37,  235,  244,  689,
			  244,   25,   74,  244,  263,   46,  244,   40,  698,  122,
			  123,  453,   45,   75,   65,   88,   89,  238,  239,  240,
			  100,   94,  135,  136,   97,   87,  235,   40,  249,  250,
			  142,  101,  322,   40,   74,  244,   49,  142,   45,   79,
			  764,  142,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   40,   39,   40,  780,   63,   45,  280,
			  172,   65,   65,  284,  788,   25,   70,  172,   72,   78,
			   74,  172,   47,   37,   78,   26,   39,   40,  463,  803,

			   47,   48,  303,  415,  196,  306,  461,   38,   39,   47,
			   48,  196,   65,  817,   26,  196,   37,   47,   48,   63,
			   64,   65,   66,  324,  325,  326,   35,  482,   47,  330,
			   47,   48,   65,   47,   78,  839,   47,   70,   65,   72,
			  844,   74,   47,  235,  848,   78,   47,   91,   47,   48,
			  235,   47,  244,   47,  235,   99,  100,  101,   47,  244,
			   47,   48,  363,  244,   47,  435,   47,   48,  407,   47,
			   48,  441,  442,  443,  444,  445,  446,  447,  448,  449,
			  450,  451,   30,  430,   47,   33,   47,   48,   47,  430,
			  430,   25,  547,   47,   48,   25,  430,   25,  670,   37,

			  430,   47,   48,  180,  430,  677,  430,   20,   21,   41,
			   42,   91,  430,   25,   26,   66,  581,   96,   27,   81,
			   63,  422,  577,  578,   90,  202,  203,   49,  205,   74,
			  207,  208,   65,   27,   16,   17,   18,   19,   20,   21,
			   65,  430,  219,   83,   48,  557,   65,   41,   42,   37,
			   94,  452,  453,  454,   74,   45,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   88,  245,   65,
			   40,   65,   26,   47,   47,   47,   70,   26,  255,   47,
			   74,   47,   76,  648,   78,   47,   47,   47,  653,   83,
			  491,  492,   47,   39,   47,   47,   47,   72,   97,   37,

			   65,   46,   85,   41,   42,  575,   40,  546,  285,  286,
			  287,  288,  289,  290,  291,  292,  293,  294,  295,  296,
			  297,  298,  299,  300,  301,  302,   55,   65,   48,  691,
			  695,  308,   70,   47,   25,   78,   74,   68,  430,   65,
			   78,   38,   47,   25,   25,  430,   70,   45,  595,  430,
			   40,  552,  329,   85,  595,  595,   41,   63,   64,   65,
			   66,  595,   85,   85,   85,  595,   85,   85,   85,  595,
			   85,  595,   78,   85,  595,   85,   85,  595,   47,   47,
			   47,   37,   44,   40,  361,   91,   49,  699,   26,   25,
			  637,   25,  593,   99,  100,  101,  637,  637,   25,  103,

			   33,   50,   49,  637,   76,   40,  595,  637,  754,   48,
			  625,  637,   29,  637,   29,  625,  637,  779,  395,  637,
			  625,  398,  625,   47,   35,  626,   69,   46,   58,   39,
			  724,  632,  551,  644,   65,  636,  598,  783,  639,  686,
			  406,  198,  406,  644,  655,  686,  686,  544,  637,  811,
			  796,  469,  686,  631,  655,  406,  686,  593,  677,  430,
			  686,  690,  686,  642,  711,  686,  713,   33,  686,  670,
			  711,  711,  713,  713,  507,  577,  677,  711,  818,  713,
			   46,  711,  699,  713,  698,  711,  699,  713,  235,  713,
			  231,  699,  713,  711,  784,  713,  422,  686,  699,  699,

			  699,  699,  188,  595,  479,  824,  753,  533,  416,  316,
			  595,  712,  753,  753,  595,  787,  625,  114,  422,  753,
			   -1,   -1,  711,  753,  713,  815,  816,  753,  818,  753,
			  507,  699,  753,   -1,   -1,  753,   -1,   -1,  104,  105,
			  106,  107,  108,  109,  110,  637,  112,  113,  114,   -1,
			   -1,   -1,  637,   -1,   -1,   -1,  637,   -1,   -1,   61,
			   62,   -1,   -1,   65,  753,   -1,   -1,   69,   -1,  784,
			   -1,  772,   74,   33,   -1,   -1,   -1,  217,   -1,   81,
			   -1,  782,   84,  784,   -1,   -1,   -1,   47,   -1,   91,
			   -1,   -1,   -1,   -1,  686,   -1,   -1,   99,  100,  814,

			  815,  686,   -1,  818,   -1,  686,   -1,  808,   -1,   -1,
			   -1,   -1,   -1,  814,  815,  816,   -1,  818,   -1,  711,
			  260,  713,   -1,   -1,   -1,   -1,  711,   -1,  713,   -1,
			  711,   -1,  713,   -1,   -1,   -1,   -1,   -1,  278,  279,
			  277,  281,  282,  283,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  632,   -1,   -1,   -1,   -1,
			   -1,  753,   -1,   -1,   -1,  305,   -1,   -1,  753,   -1,
			   -1,   -1,  753,   -1,   -1,   -1,   14,   15,   -1,   -1,
			   -1,  318,  319,  660,   -1,   -1,   -1,   -1,  328,   -1,
			   -1,   29,   30,   -1,   -1,   33,  333,   -1,   98,   99,

			  100,  101,  102,  103,  104,  105,  106,  107,  108,   -1,
			   -1,   -1,   -1,   -1,   -1,   14,   15,   -1,   -1,  359,
			   14,   15,   16,   17,   18,   19,   20,   21,   -1,   -1,
			   29,   -1,   -1,  133,   33,   -1,  136,  714,   -1,   -1,
			   -1,   -1,  382,  383,  384,  385,  386,  387,  388,  389,
			  390,  391,  392,  393,  394,   -1,  396,  397,   -1,  399,
			  400,  401,  739,  740,  404,  402,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   -1,   -1,   -1,
			   -1,   -1,  759,  760,   -1,  762,  763,  424,  425,  426,
			   -1,  431,   -1,   -1,   -1,   -1,   -1,  434,  438,   -1,

			   -1,   -1,   -1,  440,   -1,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,  456,  457,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  808,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  821,   -1,   -1,   -1,   -1,   -1,
			  827,   -1,   -1,   -1,   -1,   -1,   28,   -1,   -1,   -1,
			   -1,   33,   -1,   -1,   -1,  842,  266,  267,  268,  269,
			  270,  271,  272,  273,  274,  275,   -1,   -1,   -1,   -1,
			   14,   15,   -1,   -1,   -1,   -1,  523,   21,   22,   23,
			   24,   -1,   26,   -1,   -1,   29,   30,   31,   32,   33,

			   34,   35,   -1,   75,   38,   -1,   -1,   41,   -1,   43,
			   -1,  311,   46,   -1,   48,   87,   -1,   51,   52,   -1,
			   54,   -1,  559,  560,   -1,   59,   -1,   -1,   -1,   63,
			   -1,   -1,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   32,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   85,   86,   -1,   -1,   -1,   -1,   -1,   92,   -1,
			   -1,   -1,   -1,   -1,   32,   -1,   -1,   -1,  102,   -1,
			  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,

			  134,  135,  136,   -1,   -1,   -1,  646,    4,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,  665,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,  116,   -1,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,  131,  132,  133,  134,  135,  136,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  494,  495,  496,  497,  498,  499,

			  500,  501,  502,  503,  504,  505,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   33,   -1,   -1,  758,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  768,  769,
			   -1,   -1,   -1,   -1,  774,  775,  776,  777,   14,   15,
			   -1,   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,
			   26,   -1,   -1,   29,   30,   31,   32,   33,   34,   35,
			   -1,   -1,   38,   -1,   -1,   41,  101,   43,   -1,   -1,
			   46,   -1,   48,   -1,   92,   51,   52,   -1,   54,   -1,
			   -1,   -1,   -1,   59,   -1,  825,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   -1,  838,   -1,

			   -1,   -1,   -1,  843,   -1,   -1,   -1,  847,   -1,   85,
			   86,   -1,   -1,   -1,   -1,   -1,   92,   -1,   -1,   -1,
			   96,   -1,   -1,   -1,   -1,   -1,  102,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,   14,   15,   -1,   -1,   -1,   -1,   -1,   21,   22,
			   23,   24,   -1,   26,   -1,   -1,   29,   30,   31,   32,
			   33,   34,   35,   -1,   -1,   38,   -1,   -1,   41,   -1,
			   43,   -1,   45,   46,   -1,   48,   -1,   -1,   51,   52,

			   -1,   54,   -1,   -1,   -1,   -1,   59,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   85,   86,   -1,   -1,   -1,   -1,   -1,   92,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  102,
			   -1,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,   14,   15,   -1,   -1,   -1,   -1,
			   -1,   21,   22,   23,   24,   -1,   26,   -1,   -1,   29,

			   30,   31,   32,   33,   34,   35,   96,   -1,   38,   -1,
			   -1,   41,   -1,   43,   -1,   -1,   46,   -1,   48,   -1,
			   -1,   51,   52,   -1,   54,   -1,   -1,   -1,   -1,   59,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,    4,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   85,   86,   -1,   -1,   -1,
			   -1,   -1,   92,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  102,   -1,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,

			  130,  131,  132,  133,  134,  135,  136,   14,   15,   -1,
			   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,   26,
			   -1,   -1,   29,   30,   31,   32,   33,   34,   35,   96,
			   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   -1,   46,
			   -1,   48,   -1,   -1,   51,   52,   -1,   54,   -1,   14,
			   15,   -1,   59,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   29,   30,   31,   32,   33,   34,
			   35,   -1,   37,   -1,   -1,   -1,   41,   -1,   85,   86,
			   -1,   -1,   -1,   -1,   -1,   92,   51,   52,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  102,   -1,  104,  105,  106,

			  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,   14,   15,   -1,   33,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   29,   30,   31,
			   32,   33,   34,   35,   -1,   -1,   -1,   -1,   -1,   41,

			   -1,   -1,   -1,   61,   62,   -1,   -1,   -1,   -1,   51,
			   52,   69,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   81,   -1,   83,   84,   -1,   -1,   -1,
			   -1,   -1,   90,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   33,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   -1,   46,   -1,
			   -1,   -1,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,
			  132,  133,  134,  135,  136,   14,   15,   -1,   -1,   -1,

			   -1,   -1,   26,   -1,   92,   -1,   -1,   -1,   -1,   33,
			   29,   30,   31,   32,   -1,   34,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   -1,   -1,   -1,
			   -1,   -1,   51,   52,   32,   59,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   45,   -1,   -1,
			   -1,   75,   -1,   -1,   -1,   74,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   87,   -1,   -1,   -1,   -1,   92,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   98,
			  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,   -1,   -1,   -1,   -1,   -1,  115,  116,  117,  118,

			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,  116,   -1,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,  131,  132,  133,  134,  135,  136,   26,
			   -1,   -1,   -1,   -1,   -1,   -1,   33,   -1,   35,   -1,
			   -1,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   46,
			   -1,   -1,   26,   -1,   -1,   -1,   -1,   -1,   -1,   33,
			   -1,   -1,   59,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   46,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   59,   -1,   -1,   85,   -1,

			   -1,   -1,   -1,   33,   -1,   92,   93,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,   92,   -1,
			   33,   61,   62,   -1,   -1,   -1,   -1,   -1,  102,   69,
			  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,   81,   -1,   83,   84,   58,   -1,   -1,   61,   -1,
			   90,   33,   65,   -1,   67,   -1,   69,   -1,   -1,   72,
			   -1,   -1,   -1,   -1,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,   -1,   58,   -1,   -1,   61,
			   -1,   -1,   95,   65,   -1,   67,   -1,   69,   -1,   -1,

			   72,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   33,   -1,   -1,   36,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   95,   -1,   46,   -1,   -1,   -1,   -1,
			   -1,   -1,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   -1,   -1,   -1,   67,   33,   -1,   -1,
			   36,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   80,
			   -1,   -1,   -1,   49,   -1,   -1,   -1,   33,   -1,   -1,
			   36,   -1,   -1,   -1,   95,   -1,   -1,   -1,   -1,   -1,
			   -1,   67,   -1,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,   80,   33,   -1,   -1,   -1,   -1,

			   -1,   67,   -1,   -1,   -1,   -1,   -1,   -1,   46,   95,
			   33,   -1,   -1,   -1,   80,   -1,   -1,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   95,
			   33,   -1,   -1,   -1,   -1,   -1,   -1,   75,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   87,
			   -1,   -1,   75,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   33,   -1,   65,   -1,   87,   -1,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   33,   -1,   -1,
			   -1,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   65,   33,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   33,   -1,   -1,   -1,   -1,   -1,   -1,   59,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   -1,   -1,   -1,   -1,   -1,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   -1,
			   -1,   -1,   -1,   -1,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,    4,    5,    6,    7,    8,    9,

			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   -1,   -1,
			   -1,   -1,   -1,   45,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   45,   82,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,    4,    5,    6,    7,    8,    9,   10,   11,   12,

			   13,   14,   15,   16,   17,   18,   19,   20,   21,   -1,
			   -1,   -1,   -1,   -1,   45,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,   45,  136,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21>>)
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

	yytype72 (v: ANY): INTEGER is
		require
			valid_type: yyis_type72 (v)
		local
			ref: INTEGER_REF
		do
			ref ?= v
			Result := ref.item
		end

	yyis_type72 (v: ANY): BOOLEAN is
		local
			u: INTEGER_REF
		do
			u ?= v
			Result := (u = v)
		end

	yytype73 (v: ANY): ARRAYED_LIST [INTEGER] is
		require
			valid_type: yyis_type73 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type73 (v: ANY): BOOLEAN is
		local
			u: ARRAYED_LIST [INTEGER]
		do
			u ?= v
			Result := (u = v)
		end

	yytype74 (v: ANY): INDEXING_CLAUSE_AS is
		require
			valid_type: yyis_type74 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type74 (v: ANY): BOOLEAN is
		local
			u: INDEXING_CLAUSE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype75 (v: ANY): EIFFEL_LIST [INSTRUCTION_AS] is
		require
			valid_type: yyis_type75 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type75 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INSTRUCTION_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype76 (v: ANY): EIFFEL_LIST [INTERVAL_AS] is
		require
			valid_type: yyis_type76 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type76 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [INTERVAL_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype77 (v: ANY): EIFFEL_LIST [OPERAND_AS] is
		require
			valid_type: yyis_type77 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type77 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [OPERAND_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype78 (v: ANY): EIFFEL_LIST [PARENT_AS] is
		require
			valid_type: yyis_type78 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type78 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [PARENT_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype79 (v: ANY): EIFFEL_LIST [RENAME_AS] is
		require
			valid_type: yyis_type79 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type79 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [RENAME_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype80 (v: ANY): EIFFEL_LIST [STRING_AS] is
		require
			valid_type: yyis_type80 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type80 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [STRING_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype81 (v: ANY): EIFFEL_LIST [TAGGED_AS] is
		require
			valid_type: yyis_type81 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type81 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TAGGED_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype82 (v: ANY): EIFFEL_LIST [TYPE] is
		require
			valid_type: yyis_type82 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type82 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE]
		do
			u ?= v
			Result := (u = v)
		end

	yytype83 (v: ANY): EIFFEL_LIST [TYPE_DEC_AS] is
		require
			valid_type: yyis_type83 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type83 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [TYPE_DEC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype84 (v: ANY): CLICK_AST is
		require
			valid_type: yyis_type84 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type84 (v: ANY): BOOLEAN is
		local
			u: CLICK_AST
		do
			u ?= v
			Result := (u = v)
		end

	yytype85 (v: ANY): PAIR [ID_AS, CLICK_AST] is
		require
			valid_type: yyis_type85 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type85 (v: ANY): BOOLEAN is
		local
			u: PAIR [ID_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype86 (v: ANY): PAIR [FEATURE_NAME, CLICK_AST] is
		require
			valid_type: yyis_type86 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type86 (v: ANY): BOOLEAN is
		local
			u: PAIR [FEATURE_NAME, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype87 (v: ANY): PAIR [STRING_AS, CLICK_AST] is
		require
			valid_type: yyis_type87 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type87 (v: ANY): BOOLEAN is
		local
			u: PAIR [STRING_AS, CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype88 (v: ANY): PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST] is
		require
			valid_type: yyis_type88 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type88 (v: ANY): BOOLEAN is
		local
			u: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do
			u ?= v
			Result := (u = v)
		end

	yytype89 (v: ANY): PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]] is
		require
			valid_type: yyis_type89 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type89 (v: ANY): BOOLEAN is
		local
			u: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do
			u ?= v
			Result := (u = v)
		end

	yytype90 (v: ANY): TOKEN_LOCATION is
		require
			valid_type: yyis_type90 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type90 (v: ANY): BOOLEAN is
		local
			u: TOKEN_LOCATION
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 854
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 137
			-- Number of tokens

	yyLast: INTEGER is 2778
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 391
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 322
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
