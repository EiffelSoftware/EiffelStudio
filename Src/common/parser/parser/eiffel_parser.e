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
--|#line 182
	yy_do_action_2
when 3 then
--|#line 191
	yy_do_action_3
when 4 then
--|#line 233
	yy_do_action_4
when 5 then
--|#line 242
	yy_do_action_5
when 6 then
--|#line 244
	yy_do_action_6
when 7 then
--|#line 246
	yy_do_action_7
when 8 then
--|#line 248
	yy_do_action_8
when 9 then
--|#line 250
	yy_do_action_9
when 10 then
--|#line 252
	yy_do_action_10
when 11 then
--|#line 254
	yy_do_action_11
when 12 then
--|#line 256
	yy_do_action_12
when 13 then
--|#line 258
	yy_do_action_13
when 14 then
--|#line 260
	yy_do_action_14
when 15 then
--|#line 262
	yy_do_action_15
when 16 then
--|#line 264
	yy_do_action_16
when 17 then
--|#line 268
	yy_do_action_17
when 18 then
--|#line 272
	yy_do_action_18
when 19 then
--|#line 276
	yy_do_action_19
when 20 then
--|#line 280
	yy_do_action_20
when 21 then
--|#line 284
	yy_do_action_21
when 22 then
--|#line 288
	yy_do_action_22
when 23 then
--|#line 292
	yy_do_action_23
when 24 then
--|#line 296
	yy_do_action_24
when 25 then
--|#line 300
	yy_do_action_25
when 26 then
--|#line 304
	yy_do_action_26
when 27 then
--|#line 308
	yy_do_action_27
when 28 then
--|#line 312
	yy_do_action_28
when 30 then
--|#line 322
	yy_do_action_30
when 33 then
--|#line 330
	yy_do_action_33
when 34 then
--|#line 332
	yy_do_action_34
when 36 then
--|#line 338
	yy_do_action_36
when 37 then
--|#line 340
	yy_do_action_37
when 38 then
--|#line 344
	yy_do_action_38
when 39 then
--|#line 349
	yy_do_action_39
when 40 then
--|#line 356
	yy_do_action_40
when 41 then
--|#line 360
	yy_do_action_41
when 43 then
--|#line 366
	yy_do_action_43
when 44 then
--|#line 371
	yy_do_action_44
when 45 then
--|#line 376
	yy_do_action_45
when 46 then
--|#line 383
	yy_do_action_46
when 47 then
--|#line 385
	yy_do_action_47
when 48 then
--|#line 387
	yy_do_action_48
when 49 then
--|#line 397
	yy_do_action_49
when 50 then
--|#line 403
	yy_do_action_50
when 51 then
--|#line 410
	yy_do_action_51
when 52 then
--|#line 416
	yy_do_action_52
when 53 then
--|#line 424
	yy_do_action_53
when 54 then
--|#line 428
	yy_do_action_54
when 55 then
--|#line 439
	yy_do_action_55
when 56 then
--|#line 443
	yy_do_action_56
when 58 then
--|#line 460
	yy_do_action_58
when 60 then
--|#line 469
	yy_do_action_60
when 61 then
--|#line 478
	yy_do_action_61
when 62 then
--|#line 483
	yy_do_action_62
when 63 then
--|#line 490
	yy_do_action_63
when 64 then
--|#line 492
	yy_do_action_64
when 65 then
--|#line 496
	yy_do_action_65
when 66 then
--|#line 496
	yy_do_action_66
when 68 then
--|#line 507
	yy_do_action_68
when 69 then
--|#line 511
	yy_do_action_69
when 70 then
--|#line 516
	yy_do_action_70
when 71 then
--|#line 520
	yy_do_action_71
when 72 then
--|#line 526
	yy_do_action_72
when 73 then
--|#line 534
	yy_do_action_73
when 74 then
--|#line 539
	yy_do_action_74
when 77 then
--|#line 550
	yy_do_action_77
when 78 then
--|#line 563
	yy_do_action_78
when 79 then
--|#line 565
	yy_do_action_79
when 80 then
--|#line 572
	yy_do_action_80
when 81 then
--|#line 576
	yy_do_action_81
when 82 then
--|#line 578
	yy_do_action_82
when 83 then
--|#line 582
	yy_do_action_83
when 84 then
--|#line 584
	yy_do_action_84
when 85 then
--|#line 586
	yy_do_action_85
when 86 then
--|#line 590
	yy_do_action_86
when 87 then
--|#line 595
	yy_do_action_87
when 88 then
--|#line 599
	yy_do_action_88
when 89 then
--|#line 603
	yy_do_action_89
when 90 then
--|#line 605
	yy_do_action_90
when 91 then
--|#line 609
	yy_do_action_91
when 92 then
--|#line 614
	yy_do_action_92
when 93 then
--|#line 619
	yy_do_action_93
when 95 then
--|#line 632
	yy_do_action_95
when 96 then
--|#line 634
	yy_do_action_96
when 97 then
--|#line 638
	yy_do_action_97
when 98 then
--|#line 643
	yy_do_action_98
when 99 then
--|#line 650
	yy_do_action_99
when 100 then
--|#line 655
	yy_do_action_100
when 101 then
--|#line 663
	yy_do_action_101
when 102 then
--|#line 668
	yy_do_action_102
when 103 then
--|#line 673
	yy_do_action_103
when 104 then
--|#line 678
	yy_do_action_104
when 105 then
--|#line 683
	yy_do_action_105
when 106 then
--|#line 688
	yy_do_action_106
when 107 then
--|#line 693
	yy_do_action_107
when 109 then
--|#line 703
	yy_do_action_109
when 110 then
--|#line 707
	yy_do_action_110
when 111 then
--|#line 712
	yy_do_action_111
when 112 then
--|#line 719
	yy_do_action_112
when 114 then
--|#line 725
	yy_do_action_114
when 115 then
--|#line 729
	yy_do_action_115
when 117 then
--|#line 735
	yy_do_action_117
when 118 then
--|#line 740
	yy_do_action_118
when 119 then
--|#line 747
	yy_do_action_119
when 120 then
--|#line 751
	yy_do_action_120
when 121 then
--|#line 753
	yy_do_action_121
when 122 then
--|#line 757
	yy_do_action_122
when 123 then
--|#line 762
	yy_do_action_123
when 125 then
--|#line 771
	yy_do_action_125
when 127 then
--|#line 777
	yy_do_action_127
when 129 then
--|#line 783
	yy_do_action_129
when 131 then
--|#line 789
	yy_do_action_131
when 133 then
--|#line 795
	yy_do_action_133
when 135 then
--|#line 801
	yy_do_action_135
when 137 then
--|#line 811
	yy_do_action_137
when 139 then
--|#line 817
	yy_do_action_139
when 140 then
--|#line 821
	yy_do_action_140
when 141 then
--|#line 826
	yy_do_action_141
when 142 then
--|#line 833
	yy_do_action_142
when 144 then
--|#line 838
	yy_do_action_144
when 146 then
--|#line 849
	yy_do_action_146
when 147 then
--|#line 853
	yy_do_action_147
when 148 then
--|#line 858
	yy_do_action_148
when 149 then
--|#line 865
	yy_do_action_149
when 150 then
--|#line 869
	yy_do_action_150
when 151 then
--|#line 875
	yy_do_action_151
when 152 then
--|#line 883
	yy_do_action_152
when 153 then
--|#line 885
	yy_do_action_153
when 155 then
--|#line 891
	yy_do_action_155
when 156 then
--|#line 895
	yy_do_action_156
when 157 then
--|#line 895
	yy_do_action_157
when 158 then
--|#line 907
	yy_do_action_158
when 159 then
--|#line 909
	yy_do_action_159
when 160 then
--|#line 911
	yy_do_action_160
when 161 then
--|#line 915
	yy_do_action_161
when 162 then
--|#line 919
	yy_do_action_162
when 164 then
--|#line 926
	yy_do_action_164
when 165 then
--|#line 930
	yy_do_action_165
when 166 then
--|#line 932
	yy_do_action_166
when 168 then
--|#line 938
	yy_do_action_168
when 170 then
--|#line 944
	yy_do_action_170
when 171 then
--|#line 948
	yy_do_action_171
when 172 then
--|#line 953
	yy_do_action_172
when 173 then
--|#line 960
	yy_do_action_173
when 176 then
--|#line 968
	yy_do_action_176
when 177 then
--|#line 970
	yy_do_action_177
when 178 then
--|#line 972
	yy_do_action_178
when 179 then
--|#line 974
	yy_do_action_179
when 180 then
--|#line 976
	yy_do_action_180
when 181 then
--|#line 978
	yy_do_action_181
when 182 then
--|#line 980
	yy_do_action_182
when 183 then
--|#line 982
	yy_do_action_183
when 184 then
--|#line 984
	yy_do_action_184
when 185 then
--|#line 986
	yy_do_action_185
when 187 then
--|#line 992
	yy_do_action_187
when 188 then
--|#line 992
	yy_do_action_188
when 189 then
--|#line 999
	yy_do_action_189
when 190 then
--|#line 999
	yy_do_action_190
when 192 then
--|#line 1010
	yy_do_action_192
when 193 then
--|#line 1010
	yy_do_action_193
when 194 then
--|#line 1017
	yy_do_action_194
when 195 then
--|#line 1017
	yy_do_action_195
when 197 then
--|#line 1028
	yy_do_action_197
when 198 then
--|#line 1037
	yy_do_action_198
when 199 then
--|#line 1042
	yy_do_action_199
when 200 then
--|#line 1049
	yy_do_action_200
when 201 then
--|#line 1053
	yy_do_action_201
when 202 then
--|#line 1055
	yy_do_action_202
when 204 then
--|#line 1065
	yy_do_action_204
when 205 then
--|#line 1067
	yy_do_action_205
when 206 then
--|#line 1071
	yy_do_action_206
when 207 then
--|#line 1073
	yy_do_action_207
when 208 then
--|#line 1075
	yy_do_action_208
when 209 then
--|#line 1077
	yy_do_action_209
when 210 then
--|#line 1079
	yy_do_action_210
when 211 then
--|#line 1081
	yy_do_action_211
when 212 then
--|#line 1085
	yy_do_action_212
when 213 then
--|#line 1087
	yy_do_action_213
when 214 then
--|#line 1089
	yy_do_action_214
when 215 then
--|#line 1091
	yy_do_action_215
when 216 then
--|#line 1093
	yy_do_action_216
when 217 then
--|#line 1095
	yy_do_action_217
when 218 then
--|#line 1097
	yy_do_action_218
when 219 then
--|#line 1099
	yy_do_action_219
when 220 then
--|#line 1101
	yy_do_action_220
when 221 then
--|#line 1103
	yy_do_action_221
when 222 then
--|#line 1105
	yy_do_action_222
when 223 then
--|#line 1107
	yy_do_action_223
when 226 then
--|#line 1115
	yy_do_action_226
when 227 then
--|#line 1119
	yy_do_action_227
when 228 then
--|#line 1124
	yy_do_action_228
when 229 then
--|#line 1135
	yy_do_action_229
when 230 then
--|#line 1141
	yy_do_action_230
when 232 then
--|#line 1151
	yy_do_action_232
when 233 then
--|#line 1155
	yy_do_action_233
when 234 then
--|#line 1160
	yy_do_action_234
when 235 then
--|#line 1167
	yy_do_action_235
when 236 then
--|#line 1167
	yy_do_action_236
when 237 then
--|#line 1177
	yy_do_action_237
when 238 then
--|#line 1179
	yy_do_action_238
when 240 then
--|#line 1189
	yy_do_action_240
when 241 then
--|#line 1197
	yy_do_action_241
when 243 then
--|#line 1205
	yy_do_action_243
when 244 then
--|#line 1209
	yy_do_action_244
when 245 then
--|#line 1214
	yy_do_action_245
when 246 then
--|#line 1221
	yy_do_action_246
when 248 then
--|#line 1227
	yy_do_action_248
when 249 then
--|#line 1231
	yy_do_action_249
when 251 then
--|#line 1239
	yy_do_action_251
when 252 then
--|#line 1243
	yy_do_action_252
when 253 then
--|#line 1248
	yy_do_action_253
when 254 then
--|#line 1255
	yy_do_action_254
when 255 then
--|#line 1259
	yy_do_action_255
when 256 then
--|#line 1264
	yy_do_action_256
when 257 then
--|#line 1271
	yy_do_action_257
when 258 then
--|#line 1273
	yy_do_action_258
when 259 then
--|#line 1275
	yy_do_action_259
when 260 then
--|#line 1277
	yy_do_action_260
when 261 then
--|#line 1279
	yy_do_action_261
when 262 then
--|#line 1281
	yy_do_action_262
when 263 then
--|#line 1283
	yy_do_action_263
when 264 then
--|#line 1285
	yy_do_action_264
when 265 then
--|#line 1287
	yy_do_action_265
when 266 then
--|#line 1289
	yy_do_action_266
when 267 then
--|#line 1291
	yy_do_action_267
when 268 then
--|#line 1293
	yy_do_action_268
when 269 then
--|#line 1295
	yy_do_action_269
when 270 then
--|#line 1297
	yy_do_action_270
when 271 then
--|#line 1299
	yy_do_action_271
when 272 then
--|#line 1301
	yy_do_action_272
when 273 then
--|#line 1303
	yy_do_action_273
when 274 then
--|#line 1305
	yy_do_action_274
when 276 then
--|#line 1312
	yy_do_action_276
when 277 then
--|#line 1321
	yy_do_action_277
when 279 then
--|#line 1329
	yy_do_action_279
when 281 then
--|#line 1335
	yy_do_action_281
when 282 then
--|#line 1335
	yy_do_action_282
when 284 then
--|#line 1347
	yy_do_action_284
when 285 then
--|#line 1349
	yy_do_action_285
when 286 then
--|#line 1353
	yy_do_action_286
when 289 then
--|#line 1363
	yy_do_action_289
when 290 then
--|#line 1367
	yy_do_action_290
when 291 then
--|#line 1372
	yy_do_action_291
when 292 then
--|#line 1379
	yy_do_action_292
when 294 then
--|#line 1385
	yy_do_action_294
when 295 then
--|#line 1394
	yy_do_action_295
when 296 then
--|#line 1396
	yy_do_action_296
when 297 then
--|#line 1400
	yy_do_action_297
when 298 then
--|#line 1402
	yy_do_action_298
when 300 then
--|#line 1408
	yy_do_action_300
when 301 then
--|#line 1412
	yy_do_action_301
when 302 then
--|#line 1417
	yy_do_action_302
when 303 then
--|#line 1424
	yy_do_action_303
when 304 then
--|#line 1430
	yy_do_action_304
when 305 then
--|#line 1435
	yy_do_action_305
when 306 then
--|#line 1440
	yy_do_action_306
when 307 then
--|#line 1445
	yy_do_action_307
when 308 then
--|#line 1450
	yy_do_action_308
when 309 then
--|#line 1457
	yy_do_action_309
when 310 then
--|#line 1460
	yy_do_action_310
when 311 then
--|#line 1462
	yy_do_action_311
when 312 then
--|#line 1464
	yy_do_action_312
when 313 then
--|#line 1466
	yy_do_action_313
when 314 then
--|#line 1468
	yy_do_action_314
when 315 then
--|#line 1470
	yy_do_action_315
when 316 then
--|#line 1472
	yy_do_action_316
when 317 then
--|#line 1474
	yy_do_action_317
when 318 then
--|#line 1476
	yy_do_action_318
when 319 then
--|#line 1478
	yy_do_action_319
when 320 then
--|#line 1480
	yy_do_action_320
when 321 then
--|#line 1482
	yy_do_action_321
when 322 then
--|#line 1484
	yy_do_action_322
when 324 then
--|#line 1490
	yy_do_action_324
when 325 then
--|#line 1494
	yy_do_action_325
when 326 then
--|#line 1499
	yy_do_action_326
when 327 then
--|#line 1506
	yy_do_action_327
when 328 then
--|#line 1508
	yy_do_action_328
when 329 then
--|#line 1510
	yy_do_action_329
when 330 then
--|#line 1512
	yy_do_action_330
when 331 then
--|#line 1514
	yy_do_action_331
when 332 then
--|#line 1516
	yy_do_action_332
when 333 then
--|#line 1518
	yy_do_action_333
when 334 then
--|#line 1520
	yy_do_action_334
when 335 then
--|#line 1522
	yy_do_action_335
when 336 then
--|#line 1524
	yy_do_action_336
when 337 then
--|#line 1526
	yy_do_action_337
when 338 then
--|#line 1528
	yy_do_action_338
when 339 then
--|#line 1530
	yy_do_action_339
when 340 then
--|#line 1532
	yy_do_action_340
when 341 then
--|#line 1534
	yy_do_action_341
when 342 then
--|#line 1538
	yy_do_action_342
when 343 then
--|#line 1540
	yy_do_action_343
when 344 then
--|#line 1542
	yy_do_action_344
when 345 then
--|#line 1546
	yy_do_action_345
when 346 then
--|#line 1548
	yy_do_action_346
when 348 then
--|#line 1554
	yy_do_action_348
when 349 then
--|#line 1558
	yy_do_action_349
when 350 then
--|#line 1560
	yy_do_action_350
when 352 then
--|#line 1566
	yy_do_action_352
when 353 then
--|#line 1574
	yy_do_action_353
when 354 then
--|#line 1576
	yy_do_action_354
when 355 then
--|#line 1578
	yy_do_action_355
when 356 then
--|#line 1580
	yy_do_action_356
when 357 then
--|#line 1582
	yy_do_action_357
when 358 then
--|#line 1584
	yy_do_action_358
when 359 then
--|#line 1586
	yy_do_action_359
when 360 then
--|#line 1588
	yy_do_action_360
when 361 then
--|#line 1590
	yy_do_action_361
when 362 then
--|#line 1594
	yy_do_action_362
when 363 then
--|#line 1602
	yy_do_action_363
when 364 then
--|#line 1604
	yy_do_action_364
when 365 then
--|#line 1606
	yy_do_action_365
when 366 then
--|#line 1608
	yy_do_action_366
when 367 then
--|#line 1610
	yy_do_action_367
when 368 then
--|#line 1612
	yy_do_action_368
when 369 then
--|#line 1614
	yy_do_action_369
when 370 then
--|#line 1616
	yy_do_action_370
when 371 then
--|#line 1618
	yy_do_action_371
when 372 then
--|#line 1620
	yy_do_action_372
when 373 then
--|#line 1622
	yy_do_action_373
when 374 then
--|#line 1624
	yy_do_action_374
when 375 then
--|#line 1626
	yy_do_action_375
when 376 then
--|#line 1628
	yy_do_action_376
when 377 then
--|#line 1630
	yy_do_action_377
when 378 then
--|#line 1632
	yy_do_action_378
when 379 then
--|#line 1634
	yy_do_action_379
when 380 then
--|#line 1636
	yy_do_action_380
when 381 then
--|#line 1638
	yy_do_action_381
when 382 then
--|#line 1640
	yy_do_action_382
when 383 then
--|#line 1642
	yy_do_action_383
when 384 then
--|#line 1644
	yy_do_action_384
when 385 then
--|#line 1646
	yy_do_action_385
when 386 then
--|#line 1648
	yy_do_action_386
when 387 then
--|#line 1650
	yy_do_action_387
when 388 then
--|#line 1652
	yy_do_action_388
when 389 then
--|#line 1654
	yy_do_action_389
when 390 then
--|#line 1656
	yy_do_action_390
when 391 then
--|#line 1658
	yy_do_action_391
when 392 then
--|#line 1660
	yy_do_action_392
when 393 then
--|#line 1662
	yy_do_action_393
when 394 then
--|#line 1664
	yy_do_action_394
when 395 then
--|#line 1666
	yy_do_action_395
when 396 then
--|#line 1668
	yy_do_action_396
when 397 then
--|#line 1670
	yy_do_action_397
when 398 then
--|#line 1672
	yy_do_action_398
when 399 then
--|#line 1676
	yy_do_action_399
when 400 then
--|#line 1684
	yy_do_action_400
when 401 then
--|#line 1686
	yy_do_action_401
when 402 then
--|#line 1688
	yy_do_action_402
when 403 then
--|#line 1690
	yy_do_action_403
when 404 then
--|#line 1692
	yy_do_action_404
when 405 then
--|#line 1694
	yy_do_action_405
when 406 then
--|#line 1696
	yy_do_action_406
when 407 then
--|#line 1698
	yy_do_action_407
when 408 then
--|#line 1700
	yy_do_action_408
when 409 then
--|#line 1702
	yy_do_action_409
when 410 then
--|#line 1704
	yy_do_action_410
when 411 then
--|#line 1706
	yy_do_action_411
when 412 then
--|#line 1710
	yy_do_action_412
when 413 then
--|#line 1714
	yy_do_action_413
when 414 then
--|#line 1718
	yy_do_action_414
when 415 then
--|#line 1722
	yy_do_action_415
when 416 then
--|#line 1726
	yy_do_action_416
when 417 then
--|#line 1730
	yy_do_action_417
when 418 then
--|#line 1732
	yy_do_action_418
when 419 then
--|#line 1734
	yy_do_action_419
when 420 then
--|#line 1736
	yy_do_action_420
when 421 then
--|#line 1738
	yy_do_action_421
when 422 then
--|#line 1740
	yy_do_action_422
when 423 then
--|#line 1742
	yy_do_action_423
when 424 then
--|#line 1744
	yy_do_action_424
when 425 then
--|#line 1746
	yy_do_action_425
when 426 then
--|#line 1748
	yy_do_action_426
when 427 then
--|#line 1750
	yy_do_action_427
when 428 then
--|#line 1752
	yy_do_action_428
when 429 then
--|#line 1754
	yy_do_action_429
when 430 then
--|#line 1756
	yy_do_action_430
when 431 then
--|#line 1760
	yy_do_action_431
when 432 then
--|#line 1764
	yy_do_action_432
when 433 then
--|#line 1771
	yy_do_action_433
when 434 then
--|#line 1779
	yy_do_action_434
when 435 then
--|#line 1781
	yy_do_action_435
when 436 then
--|#line 1785
	yy_do_action_436
when 437 then
--|#line 1787
	yy_do_action_437
when 438 then
--|#line 1791
	yy_do_action_438
when 439 then
--|#line 1804
	yy_do_action_439
when 442 then
--|#line 1812
	yy_do_action_442
when 443 then
--|#line 1816
	yy_do_action_443
when 444 then
--|#line 1821
	yy_do_action_444
when 445 then
--|#line 1828
	yy_do_action_445
when 446 then
--|#line 1830
	yy_do_action_446
when 447 then
--|#line 1834
	yy_do_action_447
when 448 then
--|#line 1839
	yy_do_action_448
when 449 then
--|#line 1850
	yy_do_action_449
when 450 then
--|#line 1852
	yy_do_action_450
when 451 then
--|#line 1854
	yy_do_action_451
when 452 then
--|#line 1856
	yy_do_action_452
when 453 then
--|#line 1858
	yy_do_action_453
when 454 then
--|#line 1860
	yy_do_action_454
when 455 then
--|#line 1862
	yy_do_action_455
when 456 then
--|#line 1864
	yy_do_action_456
when 457 then
--|#line 1866
	yy_do_action_457
when 458 then
--|#line 1868
	yy_do_action_458
when 459 then
--|#line 1870
	yy_do_action_459
when 460 then
--|#line 1872
	yy_do_action_460
when 461 then
--|#line 1876
	yy_do_action_461
when 462 then
--|#line 1878
	yy_do_action_462
when 463 then
--|#line 1880
	yy_do_action_463
when 464 then
--|#line 1882
	yy_do_action_464
when 465 then
--|#line 1884
	yy_do_action_465
when 466 then
--|#line 1886
	yy_do_action_466
when 467 then
--|#line 1890
	yy_do_action_467
when 468 then
--|#line 1892
	yy_do_action_468
when 469 then
--|#line 1894
	yy_do_action_469
when 470 then
--|#line 1909
	yy_do_action_470
when 471 then
--|#line 1911
	yy_do_action_471
when 472 then
--|#line 1913
	yy_do_action_472
when 473 then
--|#line 1917
	yy_do_action_473
when 474 then
--|#line 1919
	yy_do_action_474
when 475 then
--|#line 1923
	yy_do_action_475
when 476 then
--|#line 1930
	yy_do_action_476
when 477 then
--|#line 1945
	yy_do_action_477
when 478 then
--|#line 1960
	yy_do_action_478
when 479 then
--|#line 1978
	yy_do_action_479
when 480 then
--|#line 1980
	yy_do_action_480
when 481 then
--|#line 1982
	yy_do_action_481
when 482 then
--|#line 1989
	yy_do_action_482
when 483 then
--|#line 1993
	yy_do_action_483
when 484 then
--|#line 1995
	yy_do_action_484
when 485 then
--|#line 1997
	yy_do_action_485
when 486 then
--|#line 2001
	yy_do_action_486
when 487 then
--|#line 2003
	yy_do_action_487
when 488 then
--|#line 2005
	yy_do_action_488
when 489 then
--|#line 2007
	yy_do_action_489
when 490 then
--|#line 2009
	yy_do_action_490
when 491 then
--|#line 2011
	yy_do_action_491
when 492 then
--|#line 2013
	yy_do_action_492
when 493 then
--|#line 2015
	yy_do_action_493
when 494 then
--|#line 2017
	yy_do_action_494
when 495 then
--|#line 2019
	yy_do_action_495
when 496 then
--|#line 2021
	yy_do_action_496
when 497 then
--|#line 2023
	yy_do_action_497
when 498 then
--|#line 2025
	yy_do_action_498
when 499 then
--|#line 2027
	yy_do_action_499
when 500 then
--|#line 2029
	yy_do_action_500
when 501 then
--|#line 2031
	yy_do_action_501
when 502 then
--|#line 2033
	yy_do_action_502
when 503 then
--|#line 2035
	yy_do_action_503
when 504 then
--|#line 2037
	yy_do_action_504
when 505 then
--|#line 2039
	yy_do_action_505
when 506 then
--|#line 2041
	yy_do_action_506
when 507 then
--|#line 2045
	yy_do_action_507
when 508 then
--|#line 2047
	yy_do_action_508
when 509 then
--|#line 2049
	yy_do_action_509
when 510 then
--|#line 2051
	yy_do_action_510
when 511 then
--|#line 2055
	yy_do_action_511
when 512 then
--|#line 2057
	yy_do_action_512
when 513 then
--|#line 2059
	yy_do_action_513
when 514 then
--|#line 2061
	yy_do_action_514
when 515 then
--|#line 2063
	yy_do_action_515
when 516 then
--|#line 2065
	yy_do_action_516
when 517 then
--|#line 2067
	yy_do_action_517
when 518 then
--|#line 2069
	yy_do_action_518
when 519 then
--|#line 2071
	yy_do_action_519
when 520 then
--|#line 2073
	yy_do_action_520
when 521 then
--|#line 2075
	yy_do_action_521
when 522 then
--|#line 2077
	yy_do_action_522
when 523 then
--|#line 2079
	yy_do_action_523
when 524 then
--|#line 2081
	yy_do_action_524
when 525 then
--|#line 2083
	yy_do_action_525
when 526 then
--|#line 2085
	yy_do_action_526
when 527 then
--|#line 2087
	yy_do_action_527
when 528 then
--|#line 2089
	yy_do_action_528
when 529 then
--|#line 2093
	yy_do_action_529
when 530 then
--|#line 2097
	yy_do_action_530
when 532 then
--|#line 2105
	yy_do_action_532
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
				if type_parser then
					raise_error
				end
			

		end

	yy_do_action_2 is
			--|#line 182
		local

		do
			yyval := yyval_default;
				if not type_parser then
					raise_error
				end
				type_node := yytype58 (yyvs.item (yyvsp))
			

		end

	yy_do_action_3 is
			--|#line 191
		local

		do
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
			--|#line 233
		local

		do
			yyval := yyval_default;
				if inherit_context then
					inherit_context := False
					real_class_end_position := 0
				end
			

		end

	yy_do_action_5 is
			--|#line 242
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_6 is
			--|#line 244
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_7 is
			--|#line 246
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_8 is
			--|#line 248
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_9 is
			--|#line 250
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_10 is
			--|#line 252
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_11 is
			--|#line 254
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_12 is
			--|#line 256
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_13 is
			--|#line 258
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_14 is
			--|#line 260
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_15 is
			--|#line 262
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_16 is
			--|#line 264
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := yytype86 (yyvs.item (yyvsp)) 
			yyval := yyval86
		end

	yy_do_action_17 is
			--|#line 268
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval86
		end

	yy_do_action_18 is
			--|#line 272
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_boolean_id_as) 
			yyval := yyval86
		end

	yy_do_action_19 is
			--|#line 276
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_character_id_as (False)) 
			yyval := yyval86
		end

	yy_do_action_20 is
			--|#line 280
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_character_id_as (True)) 
			yyval := yyval86
		end

	yy_do_action_21 is
			--|#line 284
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_double_id_as) 
			yyval := yyval86
		end

	yy_do_action_22 is
			--|#line 288
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_integer_id_as (8)) 
			yyval := yyval86
		end

	yy_do_action_23 is
			--|#line 292
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_integer_id_as (16)) 
			yyval := yyval86
		end

	yy_do_action_24 is
			--|#line 296
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_integer_id_as (32)) 
			yyval := yyval86
		end

	yy_do_action_25 is
			--|#line 300
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_integer_id_as (64)) 
			yyval := yyval86
		end

	yy_do_action_26 is
			--|#line 304
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_none_id_as) 
			yyval := yyval86
		end

	yy_do_action_27 is
			--|#line 308
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_pointer_id_as) 
			yyval := yyval86
		end

	yy_do_action_28 is
			--|#line 312
		local
			yyval86: PAIR [ID_AS, CLICK_AST]
		do

yyval86 := new_clickable_id (new_real_id_as) 
			yyval := yyval86
		end

	yy_do_action_30 is
			--|#line 322
		local
			yyval75: INDEXING_CLAUSE_AS
		do

yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
		end

	yy_do_action_33 is
			--|#line 330
		local
			yyval75: INDEXING_CLAUSE_AS
		do

yyval75 := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval75
		end

	yy_do_action_34 is
			--|#line 332
		local
			yyval75: INDEXING_CLAUSE_AS
		do

yyval75 := Void 
			yyval := yyval75
		end

	yy_do_action_36 is
			--|#line 338
		local
			yyval75: INDEXING_CLAUSE_AS
		do

yyval75 := yytype75 (yyvs.item (yyvsp - 1)) 
			yyval := yyval75
		end

	yy_do_action_37 is
			--|#line 340
		local
			yyval75: INDEXING_CLAUSE_AS
		do

yyval75 := Void 
			yyval := yyval75
		end

	yy_do_action_38 is
			--|#line 344
		local
			yyval75: INDEXING_CLAUSE_AS
		do

				yyval75 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval75.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_39 is
			--|#line 349
		local
			yyval75: INDEXING_CLAUSE_AS
		do

				yyval75 := yytype75 (yyvs.item (yyvsp - 1))
				yyval75.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_40 is
			--|#line 356
		local
			yyval32: INDEX_AS
		do

yyval32 := new_index_as (yytype30 (yyvs.item (yyvsp - 2)), yytype61 (yyvs.item (yyvsp - 1))) 
			yyval := yyval32
		end

	yy_do_action_41 is
			--|#line 360
		local
			yyval30: ID_AS
		do

yyval30 := yytype30 (yyvs.item (yyvsp - 1)) 
			yyval := yyval30
		end

	yy_do_action_43 is
			--|#line 366
		local
			yyval61: EIFFEL_LIST [ATOMIC_AS]
		do

				yyval61 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval61.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_44 is
			--|#line 371
		local
			yyval61: EIFFEL_LIST [ATOMIC_AS]
		do

				yyval61 := yytype61 (yyvs.item (yyvsp - 2))
				yyval61.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_45 is
			--|#line 376
		local
			yyval61: EIFFEL_LIST [ATOMIC_AS]
		do

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval61 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval61
		end

	yy_do_action_46 is
			--|#line 383
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype30 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_47 is
			--|#line 385
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_48 is
			--|#line 387
		local
			yyval6: ATOMIC_AS
		do

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype18 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval6
		end

	yy_do_action_49 is
			--|#line 397
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_50 is
			--|#line 403
		local

		do
			yyval := yyval_default;
				is_frozen_class := False
				is_deferred := True
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_51 is
			--|#line 410
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := True
				is_separate := False
			

		end

	yy_do_action_52 is
			--|#line 416
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := True
			

		end

	yy_do_action_53 is
			--|#line 424
		local

		do
			yyval := yyval_default;
				is_frozen_class := False
			

		end

	yy_do_action_54 is
			--|#line 428
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

	yy_do_action_55 is
			--|#line 439
		local

		do
			yyval := yyval_default;
				is_external_class := False
			

		end

	yy_do_action_56 is
			--|#line 443
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

	yy_do_action_58 is
			--|#line 460
		local
			yyval55: STRING_AS
		do

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_60 is
			--|#line 469
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval68 := yytype68 (yyvs.item (yyvsp))
				if yyval68.is_empty then
					yyval68 := Void
				end
			
			yyval := yyval68
		end

	yy_do_action_61 is
			--|#line 478
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval68 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval68, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_62 is
			--|#line 483
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval68 := yytype68 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval68, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_63 is
			--|#line 490
		local
			yyval27: FEATURE_CLAUSE_AS
		do

yyval27 := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) 
			yyval := yyval27
		end

	yy_do_action_64 is
			--|#line 492
		local
			yyval27: FEATURE_CLAUSE_AS
		do

yyval27 := new_feature_clause_as (yytype14 (yyvs.item (yyvsp - 1)), yytype67 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval27
		end

	yy_do_action_65 is
			--|#line 496
		local
			yyval14: CLIENT_AS
		do

yyval14 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval14
		end

	yy_do_action_66 is
			--|#line 496
		local

		do
			yyval := yyval_default;
				inherit_context := False
				fclause_pos := clone (current_position)
			

		end

	yy_do_action_68 is
			--|#line 507
		local
			yyval14: CLIENT_AS
		do

yyval14 := new_client_as (yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval14
		end

	yy_do_action_69 is
			--|#line 511
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do

				yyval72 := new_eiffel_list_id_as (1)
				yyval72.extend (new_none_id_as)
			
			yyval := yyval72
		end

	yy_do_action_70 is
			--|#line 516
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do

yyval72 := yytype72 (yyvs.item (yyvsp - 1)) 
			yyval := yyval72
		end

	yy_do_action_71 is
			--|#line 520
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do

				yyval72 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval72.extend (yytype86 (yyvs.item (yyvsp)).first)
				yytype86 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype86 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval72
		end

	yy_do_action_72 is
			--|#line 526
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do

				yyval72 := yytype72 (yyvs.item (yyvsp - 2))
				yyval72.extend (yytype86 (yyvs.item (yyvsp)).first)
				yytype86 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype86 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval72
		end

	yy_do_action_73 is
			--|#line 534
		local
			yyval67: EIFFEL_LIST [FEATURE_AS]
		do

				yyval67 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval67.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_74 is
			--|#line 539
		local
			yyval67: EIFFEL_LIST [FEATURE_AS]
		do

				yyval67 := yytype67 (yyvs.item (yyvsp - 1))
				yyval67.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_77 is
			--|#line 550
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

	yy_do_action_78 is
			--|#line 563
		local
			yyval89: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

yyval89 := new_clickable_feature_name_list (yytype87 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval89
		end

	yy_do_action_79 is
			--|#line 565
		local
			yyval89: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

				yyval89 := yytype89 (yyvs.item (yyvsp - 2))
				yyval89.first.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval89
		end

	yy_do_action_80 is
			--|#line 572
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
		end

	yy_do_action_81 is
			--|#line 576
		local

		do
			yyval := yyval_default;
is_frozen := False 

		end

	yy_do_action_82 is
			--|#line 578
		local

		do
			yyval := yyval_default;
is_frozen := True 

		end

	yy_do_action_83 is
			--|#line 582
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := new_clickable_feature_name (yytype86 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_84 is
			--|#line 584
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
		end

	yy_do_action_85 is
			--|#line 586
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
		end

	yy_do_action_86 is
			--|#line 590
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := new_clickable_infix (yytype88 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_87 is
			--|#line 595
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := new_clickable_prefix (yytype88 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_88 is
			--|#line 599
		local
			yyval8: BODY_AS
		do

yyval8 := new_declaration_body (yytype84 (yyvs.item (yyvsp - 2)), yytype58 (yyvs.item (yyvsp - 1)), yytype15 (yyvs.item (yyvsp))) 
			yyval := yyval8
		end

	yy_do_action_89 is
			--|#line 603
		local
			yyval15: CONTENT_AS
		do

feature_indexes := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_90 is
			--|#line 605
		local
			yyval15: CONTENT_AS
		do

yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_91 is
			--|#line 609
		local
			yyval15: CONTENT_AS
		do

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (yytype6 (yyvs.item (yyvsp - 1))))
				feature_indexes := yytype75 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_92 is
			--|#line 614
		local
			yyval15: CONTENT_AS
		do

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (new_unique_as))
				feature_indexes := yytype75 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_93 is
			--|#line 619
		local
			yyval15: CONTENT_AS
		do

				yyval15 := yytype53 (yyvs.item (yyvsp))
				feature_indexes := yytype75 (yyvs.item (yyvsp - 1))
			
			yyval := yyval15
		end

	yy_do_action_95 is
			--|#line 632
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do

yyval79 := yytype79 (yyvs.item (yyvsp)) 
			yyval := yyval79
		end

	yy_do_action_96 is
			--|#line 634
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do

yyval79 := new_eiffel_list_parent_as (0) 
			yyval := yyval79
		end

	yy_do_action_97 is
			--|#line 638
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do

				yyval79 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval79.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_98 is
			--|#line 643
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do

				yyval79 := yytype79 (yyvs.item (yyvsp - 1))
				yyval79.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_99 is
			--|#line 650
		local
			yyval44: PARENT_AS
		do

				yyval44 := yytype44 (yyvs.item (yyvsp))
				yytype44 (yyvs.item (yyvsp)).set_location (yytype91 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_100 is
			--|#line 655
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := yytype44 (yyvs.item (yyvsp - 1))
				yytype44 (yyvs.item (yyvsp - 1)).set_location (yytype91 (yyvs.item (yyvsp - 2)))
			
			yyval := yyval44
		end

	yy_do_action_101 is
			--|#line 663
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_102 is
			--|#line 668
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 7)), yytype83 (yyvs.item (yyvsp - 6)), yytype80 (yyvs.item (yyvsp - 5)), yytype65 (yyvs.item (yyvsp - 4)), yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_103 is
			--|#line 673
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 6)), yytype83 (yyvs.item (yyvsp - 5)), Void, yytype65 (yyvs.item (yyvsp - 4)), yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_104 is
			--|#line 678
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 5)), yytype83 (yyvs.item (yyvsp - 4)), Void, Void, yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_105 is
			--|#line 683
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 4)), yytype83 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_106 is
			--|#line 688
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 3)), yytype83 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_107 is
			--|#line 693
		local
			yyval44: PARENT_AS
		do

				inherit_context := True
				real_class_end_position := current_position.end_position - 3
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 2)), yytype83 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_109 is
			--|#line 703
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do

yyval80 := yytype80 (yyvs.item (yyvsp)) 
			yyval := yyval80
		end

	yy_do_action_110 is
			--|#line 707
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do

				yyval80 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval80.extend (yytype48 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_111 is
			--|#line 712
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do

				yyval80 := yytype80 (yyvs.item (yyvsp - 2))
				yyval80.extend (yytype48 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_112 is
			--|#line 719
		local
			yyval48: RENAME_AS
		do

yyval48 := new_rename_pair (yytype87 (yyvs.item (yyvsp - 2)), yytype87 (yyvs.item (yyvsp))) 
			yyval := yyval48
		end

	yy_do_action_114 is
			--|#line 725
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_115 is
			--|#line 729
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_117 is
			--|#line 735
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval65 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				yyval65.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_118 is
			--|#line 740
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval65 := yytype65 (yyvs.item (yyvsp - 1))
				yyval65.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_119 is
			--|#line 747
		local
			yyval22: EXPORT_ITEM_AS
		do

yyval22 := new_export_item_as (new_client_as (yytype72 (yyvs.item (yyvsp - 2))), yytype28 (yyvs.item (yyvsp - 1))) 
			yyval := yyval22
		end

	yy_do_action_120 is
			--|#line 751
		local
			yyval28: FEATURE_SET_AS
		do

yyval28 := new_all_as 
			yyval := yyval28
		end

	yy_do_action_121 is
			--|#line 753
		local
			yyval28: FEATURE_SET_AS
		do

yyval28 := new_feature_list_as (yytype70 (yyvs.item (yyvsp))) 
			yyval := yyval28
		end

	yy_do_action_122 is
			--|#line 757
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval70 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval70.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval70
		end

	yy_do_action_123 is
			--|#line 762
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval70 := yytype70 (yyvs.item (yyvsp - 2))
				yyval70.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval70
		end

	yy_do_action_125 is
			--|#line 771
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_127 is
			--|#line 777
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_129 is
			--|#line 783
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_131 is
			--|#line 789
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_133 is
			--|#line 795
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_135 is
			--|#line 801
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_137 is
			--|#line 811
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval84 := yytype84 (yyvs.item (yyvsp - 1)) 
			yyval := yyval84
		end

	yy_do_action_139 is
			--|#line 817
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_140 is
			--|#line 821
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval84 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_141 is
			--|#line 826
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval84 := yytype84 (yyvs.item (yyvsp - 1))
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_142 is
			--|#line 833
		local
			yyval59: TYPE_DEC_AS
		do

yyval59 := new_type_dec_as (yytype74 (yyvs.item (yyvsp - 4)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval59
		end

	yy_do_action_144 is
			--|#line 838
		local

		do
			yyval := yyval_default;
				if il_parser then
						-- Trigger a syntax error.
					raise_error
				end
			

		end

	yy_do_action_146 is
			--|#line 849
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_147 is
			--|#line 853
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval84 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_148 is
			--|#line 858
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval84 := yytype84 (yyvs.item (yyvsp - 1))
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_149 is
			--|#line 865
		local
			yyval59: TYPE_DEC_AS
		do

yyval59 := new_type_dec_as (yytype74 (yyvs.item (yyvsp - 3)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval59
		end

	yy_do_action_150 is
			--|#line 869
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do

				create yyval74.make (Initial_identifier_list_size)
				Names_heap.put (yytype30 (yyvs.item (yyvsp)))
				yyval74.extend (Names_heap.found_item)
			
			yyval := yyval74
		end

	yy_do_action_151 is
			--|#line 875
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do

				yyval74 := yytype74 (yyvs.item (yyvsp - 2))
				Names_heap.put (yytype30 (yyvs.item (yyvsp)))
				yyval74.extend (Names_heap.found_item)
			
			yyval := yyval74
		end

	yy_do_action_152 is
			--|#line 883
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do

create yyval74.make (0) 
			yyval := yyval74
		end

	yy_do_action_153 is
			--|#line 885
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do

yyval74 := yytype74 (yyvs.item (yyvsp)) 
			yyval := yyval74
		end

	yy_do_action_155 is
			--|#line 891
		local
			yyval58: TYPE
		do

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_156 is
			--|#line 895
		local
			yyval53: ROUTINE_AS
		do

yyval53 := new_routine_as (yytype55 (yyvs.item (yyvsp - 7)), yytype49 (yyvs.item (yyvsp - 5)), yytype84 (yyvs.item (yyvsp - 4)), yytype52 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), fbody_pos, current_position) 
			yyval := yyval53
		end

	yy_do_action_157 is
			--|#line 895
		local

		do
			yyval := yyval_default;
fbody_pos := current_position.start_position 

		end

	yy_do_action_158 is
			--|#line 907
		local
			yyval52: ROUT_BODY_AS
		do

yyval52 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval52
		end

	yy_do_action_159 is
			--|#line 909
		local
			yyval52: ROUT_BODY_AS
		do

yyval52 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval52
		end

	yy_do_action_160 is
			--|#line 911
		local
			yyval52: ROUT_BODY_AS
		do

yyval52 := new_deferred_as 
			yyval := yyval52
		end

	yy_do_action_161 is
			--|#line 915
		local
			yyval24: EXTERNAL_AS
		do

yyval24 := new_external_as (yytype25 (yyvs.item (yyvsp - 1)), yytype55 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_162 is
			--|#line 919
		local
			yyval25: EXTERNAL_LANG_AS
		do

yyval25 := new_external_lang_as (yytype55 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
		end

	yy_do_action_164 is
			--|#line 926
		local
			yyval55: STRING_AS
		do

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_165 is
			--|#line 930
		local
			yyval37: INTERNAL_AS
		do

yyval37 := new_do_as (yytype76 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_166 is
			--|#line 932
		local
			yyval37: INTERNAL_AS
		do

yyval37 := new_once_as (yytype76 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_168 is
			--|#line 938
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_170 is
			--|#line 944
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_171 is
			--|#line 948
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval76.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_172 is
			--|#line 953
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp - 1))
				yyval76.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_173 is
			--|#line 960
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype35 (yyvs.item (yyvsp - 1)) 
			yyval := yyval35
		end

	yy_do_action_176 is
			--|#line 968
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_177 is
			--|#line 970
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_178 is
			--|#line 972
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_179 is
			--|#line 974
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype51 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_180 is
			--|#line 976
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype31 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_181 is
			--|#line 978
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_182 is
			--|#line 980
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype40 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_183 is
			--|#line 982
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_184 is
			--|#line 984
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_185 is
			--|#line 986
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype50 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_187 is
			--|#line 992
		local
			yyval49: REQUIRE_AS
		do

				id_level := Normal_level
				yyval49 := new_require_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval49
		end

	yy_do_action_188 is
			--|#line 992
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_189 is
			--|#line 999
		local
			yyval49: REQUIRE_AS
		do

				id_level := Normal_level
				yyval49 := new_require_else_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval49
		end

	yy_do_action_190 is
			--|#line 999
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_192 is
			--|#line 1010
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_193 is
			--|#line 1010
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_194 is
			--|#line 1017
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_then_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_195 is
			--|#line 1017
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_197 is
			--|#line 1028
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

				yyval82 := yytype82 (yyvs.item (yyvsp))
				if yyval82.is_empty then
					yyval82 := Void
				end
			
			yyval := yyval82
		end

	yy_do_action_198 is
			--|#line 1037
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

				yyval82 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval82, yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_199 is
			--|#line 1042
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

				yyval82 := yytype82 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval82, yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_200 is
			--|#line 1049
		local
			yyval56: TAGGED_AS
		do

yyval56 := yytype56 (yyvs.item (yyvsp - 1)) 
			yyval := yyval56
		end

	yy_do_action_201 is
			--|#line 1053
		local
			yyval56: TAGGED_AS
		do

yyval56 := new_tagged_as (Void, yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval56
		end

	yy_do_action_202 is
			--|#line 1055
		local
			yyval56: TAGGED_AS
		do

yyval56 := new_tagged_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval56
		end

	yy_do_action_204 is
			--|#line 1065
		local
			yyval58: TYPE
		do

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_205 is
			--|#line 1067
		local
			yyval58: TYPE
		do

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_206 is
			--|#line 1071
		local
			yyval58: TYPE
		do

yyval58 := new_expanded_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_207 is
			--|#line 1073
		local
			yyval58: TYPE
		do

yyval58 := new_separate_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_208 is
			--|#line 1075
		local
			yyval58: TYPE
		do

yyval58 := new_bits_as (yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_209 is
			--|#line 1077
		local
			yyval58: TYPE
		do

yyval58 := new_bits_symbol_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_210 is
			--|#line 1079
		local
			yyval58: TYPE
		do

yyval58 := new_like_id_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_211 is
			--|#line 1081
		local
			yyval58: TYPE
		do

yyval58 := new_like_current_as 
			yyval := yyval58
		end

	yy_do_action_212 is
			--|#line 1085
		local
			yyval58: TYPE
		do

yyval58 := new_class_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_213 is
			--|#line 1087
		local
			yyval58: TYPE
		do

yyval58 := new_boolean_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_214 is
			--|#line 1089
		local
			yyval58: TYPE
		do

yyval58 := new_character_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, False) 
			yyval := yyval58
		end

	yy_do_action_215 is
			--|#line 1091
		local
			yyval58: TYPE
		do

yyval58 := new_character_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, True) 
			yyval := yyval58
		end

	yy_do_action_216 is
			--|#line 1093
		local
			yyval58: TYPE
		do

yyval58 := new_double_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_217 is
			--|#line 1095
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 8) 
			yyval := yyval58
		end

	yy_do_action_218 is
			--|#line 1097
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 16) 
			yyval := yyval58
		end

	yy_do_action_219 is
			--|#line 1099
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 32) 
			yyval := yyval58
		end

	yy_do_action_220 is
			--|#line 1101
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 64) 
			yyval := yyval58
		end

	yy_do_action_221 is
			--|#line 1103
		local
			yyval58: TYPE
		do

yyval58 := new_none_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_222 is
			--|#line 1105
		local
			yyval58: TYPE
		do

yyval58 := new_pointer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_223 is
			--|#line 1107
		local
			yyval58: TYPE
		do

yyval58 := new_real_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_226 is
			--|#line 1115
		local
			yyval83: EIFFEL_LIST [TYPE]
		do

yyval83 := yytype83 (yyvs.item (yyvsp - 1)) 
			yyval := yyval83
		end

	yy_do_action_227 is
			--|#line 1119
		local
			yyval83: EIFFEL_LIST [TYPE]
		do

				yyval83 := new_eiffel_list_type (Initial_type_list_size)
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_228 is
			--|#line 1124
		local
			yyval83: EIFFEL_LIST [TYPE]
		do

				yyval83 := yytype83 (yyvs.item (yyvsp - 2))
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_229 is
			--|#line 1135
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				-- $$ := Void
				formal_generics_start_position := current_position.start_position
				formal_generics_end_position := 0
			
			yyval := yyval71
		end

	yy_do_action_230 is
			--|#line 1141
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 1))
				formal_generics_start_position := yytype91 (yyvs.item (yyvsp - 3)).start_position
				formal_generics_end_position := current_position.start_position
			
			yyval := yyval71
		end

	yy_do_action_232 is
			--|#line 1151
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

yyval71 := yytype71 (yyvs.item (yyvsp)) 
			yyval := yyval71
		end

	yy_do_action_233 is
			--|#line 1155
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval71 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval71.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_234 is
			--|#line 1160
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_235 is
			--|#line 1167
		local
			yyval29: FORMAL_DEC_AS
		do

				check formal_exists: not formal_parameters.is_empty end
				yyval29 := new_formal_dec_as (formal_parameters.last, yytype90 (yyvs.item (yyvsp)).first, yytype90 (yyvs.item (yyvsp)).second, formal_parameters.count)
			
			yyval := yyval29
		end

	yy_do_action_236 is
			--|#line 1167
		local

		do
			yyval := yyval_default;
formal_parameters.extend (create {ID_AS}.initialize (token_buffer)) 

		end

	yy_do_action_237 is
			--|#line 1177
		local
			yyval90: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do

create yyval90 
			yyval := yyval90
		end

	yy_do_action_238 is
			--|#line 1179
		local
			yyval90: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do

				create yyval90
				yyval90.set_first (yytype58 (yyvs.item (yyvsp - 1)))
				yyval90.set_second (yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval90
		end

	yy_do_action_240 is
			--|#line 1189
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp - 1)) 
			yyval := yyval70
		end

	yy_do_action_241 is
			--|#line 1197
		local
			yyval31: IF_AS
		do

				yyval31 := new_if_as (yytype23 (yyvs.item (yyvsp - 5)), yytype76 (yyvs.item (yyvsp - 3)), yytype64 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 7)))
			
			yyval := yyval31
		end

	yy_do_action_243 is
			--|#line 1205
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_244 is
			--|#line 1209
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do

				yyval64 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval64.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_245 is
			--|#line 1214
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do

				yyval64 := yytype64 (yyvs.item (yyvsp - 1))
				yyval64.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_246 is
			--|#line 1221
		local
			yyval20: ELSIF_AS
		do

yyval20 := new_elseif_as (yytype23 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 4))) 
			yyval := yyval20
		end

	yy_do_action_248 is
			--|#line 1227
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_249 is
			--|#line 1231
		local
			yyval33: INSPECT_AS
		do

				yyval33 := new_inspect_as (yytype23 (yyvs.item (yyvsp - 3)), yytype62 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)))
			
			yyval := yyval33
		end

	yy_do_action_251 is
			--|#line 1239
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do

yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
		end

	yy_do_action_252 is
			--|#line 1243
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do

				yyval62 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval62.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_253 is
			--|#line 1248
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do

				yyval62 := yytype62 (yyvs.item (yyvsp - 1))
				yyval62.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_254 is
			--|#line 1255
		local
			yyval11: CASE_AS
		do

yyval11 := new_case_as (yytype77 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval11
		end

	yy_do_action_255 is
			--|#line 1259
		local
			yyval77: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval77 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval77.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_256 is
			--|#line 1264
		local
			yyval77: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval77 := yytype77 (yyvs.item (yyvsp - 2))
				yyval77.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_257 is
			--|#line 1271
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_258 is
			--|#line 1273
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_259 is
			--|#line 1275
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_260 is
			--|#line 1277
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_261 is
			--|#line 1279
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_262 is
			--|#line 1281
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_263 is
			--|#line 1283
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_264 is
			--|#line 1285
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_265 is
			--|#line 1287
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_266 is
			--|#line 1289
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_267 is
			--|#line 1291
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_268 is
			--|#line 1293
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_269 is
			--|#line 1295
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_270 is
			--|#line 1297
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_271 is
			--|#line 1299
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_272 is
			--|#line 1301
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_273 is
			--|#line 1303
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_274 is
			--|#line 1305
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_276 is
			--|#line 1312
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp))
				if yyval76 = Void then
					yyval76 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval76
		end

	yy_do_action_277 is
			--|#line 1321
		local
			yyval40: LOOP_AS
		do

				yyval40 := new_loop_as (yytype76 (yyvs.item (yyvsp - 8)), yytype82 (yyvs.item (yyvsp - 7)), yytype60 (yyvs.item (yyvsp - 6)), yytype23 (yyvs.item (yyvsp - 3)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)))
			
			yyval := yyval40
		end

	yy_do_action_279 is
			--|#line 1329
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
		end

	yy_do_action_281 is
			--|#line 1335
		local
			yyval39: INVARIANT_AS
		do

				id_level := Normal_level
				inherit_context := False
				yyval39 := new_invariant_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval39
		end

	yy_do_action_282 is
			--|#line 1335
		local

		do
			yyval := yyval_default;
id_level := Invariant_level 

		end

	yy_do_action_284 is
			--|#line 1347
		local
			yyval60: VARIANT_AS
		do

yyval60 := new_variant_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval60
		end

	yy_do_action_285 is
			--|#line 1349
		local
			yyval60: VARIANT_AS
		do

yyval60 := new_variant_as (Void, yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval60
		end

	yy_do_action_286 is
			--|#line 1353
		local
			yyval19: DEBUG_AS
		do

				yyval19 := new_debug_as (yytype81 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)))
			
			yyval := yyval19
		end

	yy_do_action_289 is
			--|#line 1363
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do

yyval81 := yytype81 (yyvs.item (yyvsp - 1)) 
			yyval := yyval81
		end

	yy_do_action_290 is
			--|#line 1367
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do

				yyval81 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval81.extend (yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_291 is
			--|#line 1372
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do

				yyval81 := yytype81 (yyvs.item (yyvsp - 2))
				yyval81.extend (yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_292 is
			--|#line 1379
		local
			yyval50: RETRY_AS
		do

yyval50 := new_retry_as (current_position) 
			yyval := yyval50
		end

	yy_do_action_294 is
			--|#line 1385
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp))
				if yyval76 = Void then
					yyval76 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval76
		end

	yy_do_action_295 is
			--|#line 1394
		local
			yyval5: ASSIGN_AS
		do

yyval5 := new_assign_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_296 is
			--|#line 1396
		local
			yyval5: ASSIGN_AS
		do

yyval5 := new_assign_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_297 is
			--|#line 1400
		local
			yyval51: REVERSE_AS
		do

yyval51 := new_reverse_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval51
		end

	yy_do_action_298 is
			--|#line 1402
		local
			yyval51: REVERSE_AS
		do

yyval51 := new_reverse_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval51
		end

	yy_do_action_300 is
			--|#line 1408
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_301 is
			--|#line 1412
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do

				yyval63 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval63.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_302 is
			--|#line 1417
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do

				yyval63 := yytype63 (yyvs.item (yyvsp - 1))
				yyval63.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_303 is
			--|#line 1424
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_304 is
			--|#line 1430
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_305 is
			--|#line 1435
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype72 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_306 is
			--|#line 1440
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_307 is
			--|#line 1445
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_308 is
			--|#line 1450
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype72 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_309 is
			--|#line 1457
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_result_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_310 is
			--|#line 1460
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_311 is
			--|#line 1462
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 3)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_312 is
			--|#line 1464
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 4))), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_313 is
			--|#line 1466
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (yytype58 (yyvs.item (yyvsp - 4)), Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_314 is
			--|#line 1468
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (Void, yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_315 is
			--|#line 1470
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_316 is
			--|#line 1472
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_result_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_317 is
			--|#line 1474
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_318 is
			--|#line 1476
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 3)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_319 is
			--|#line 1478
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_As (new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 4))), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_320 is
			--|#line 1480
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (yytype58 (yyvs.item (yyvsp - 3)), Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_321 is
			--|#line 1482
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (Void, yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_322 is
			--|#line 1484
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_324 is
			--|#line 1490
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do

yyval78 := yytype78 (yyvs.item (yyvsp - 1)) 
			yyval := yyval78
		end

	yy_do_action_325 is
			--|#line 1494
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do

				yyval78 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval78.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_326 is
			--|#line 1499
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do

				yyval78 := yytype78 (yyvs.item (yyvsp - 2))
				yyval78.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_327 is
			--|#line 1506
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, Void) 
			yyval := yyval43
		end

	yy_do_action_328 is
			--|#line 1508
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval43
		end

	yy_do_action_329 is
			--|#line 1510
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_class_type (yytype86 (yyvs.item (yyvsp - 2)), yytype83 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_330 is
			--|#line 1512
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_boolean_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_331 is
			--|#line 1514
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_character_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, False), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_332 is
			--|#line 1516
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_character_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, True), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_333 is
			--|#line 1518
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_double_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_334 is
			--|#line 1520
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 8), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_335 is
			--|#line 1522
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 16), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_336 is
			--|#line 1524
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 32), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_337 is
			--|#line 1526
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 64), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_338 is
			--|#line 1528
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_none_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_339 is
			--|#line 1530
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_pointer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_340 is
			--|#line 1532
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_real_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_341 is
			--|#line 1534
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (yytype58 (yyvs.item (yyvsp - 1)), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_342 is
			--|#line 1538
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (yytype58 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 5))) 
			yyval := yyval17
		end

	yy_do_action_343 is
			--|#line 1540
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (Void, yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval17
		end

	yy_do_action_344 is
			--|#line 1542
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (yytype58 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 6))) 
			yyval := yyval17
		end

	yy_do_action_345 is
			--|#line 1546
		local
			yyval18: CREATION_EXPR_AS
		do

yyval18 := new_creation_expr_as (yytype58 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval18
		end

	yy_do_action_346 is
			--|#line 1548
		local
			yyval18: CREATION_EXPR_AS
		do

yyval18 := new_creation_expr_as (yytype58 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval18
		end

	yy_do_action_348 is
			--|#line 1554
		local
			yyval58: TYPE
		do

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_349 is
			--|#line 1558
		local
			yyval1: ACCESS_AS
		do

yyval1 := new_access_id_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval1
		end

	yy_do_action_350 is
			--|#line 1560
		local
			yyval1: ACCESS_AS
		do

yyval1 := new_result_as 
			yyval := yyval1
		end

	yy_do_action_352 is
			--|#line 1566
		local
			yyval3: ACCESS_INV_AS
		do

yyval3 := new_access_inv_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_353 is
			--|#line 1574
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype1 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_354 is
			--|#line 1576
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_355 is
			--|#line 1578
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_356 is
			--|#line 1580
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_357 is
			--|#line 1582
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_358 is
			--|#line 1584
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype45 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_359 is
			--|#line 1586
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_360 is
			--|#line 1588
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype46 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_361 is
			--|#line 1590
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_362 is
			--|#line 1594
		local
			yyval13: CHECK_AS
		do

yyval13 := new_check_as (yytype82 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval13
		end

	yy_do_action_363 is
			--|#line 1602
		local
			yyval23: EXPR_AS
		do

create {VALUE_AS} yyval23.initialize (yytype6 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_364 is
			--|#line 1604
		local
			yyval23: EXPR_AS
		do

create {VALUE_AS} yyval23.initialize (yytype4 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_365 is
			--|#line 1606
		local
			yyval23: EXPR_AS
		do

create {VALUE_AS} yyval23.initialize (yytype57 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_366 is
			--|#line 1608
		local
			yyval23: EXPR_AS
		do

yyval23 := new_expr_call_as (yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_367 is
			--|#line 1610
		local
			yyval23: EXPR_AS
		do

yyval23 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_368 is
			--|#line 1612
		local
			yyval23: EXPR_AS
		do

yyval23 := new_paran_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_369 is
			--|#line 1614
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_plus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_370 is
			--|#line 1616
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_minus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_371 is
			--|#line 1618
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_star_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_372 is
			--|#line 1620
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_slash_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_373 is
			--|#line 1622
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_mod_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_374 is
			--|#line 1624
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_div_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_375 is
			--|#line 1626
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_power_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_376 is
			--|#line 1628
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_and_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_377 is
			--|#line 1630
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_and_then_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_378 is
			--|#line 1632
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_or_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_379 is
			--|#line 1634
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_or_else_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_380 is
			--|#line 1636
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_implies_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_381 is
			--|#line 1638
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_xor_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_382 is
			--|#line 1640
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_ge_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_383 is
			--|#line 1642
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_gt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_384 is
			--|#line 1644
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_le_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_385 is
			--|#line 1646
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_lt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_386 is
			--|#line 1648
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_eq_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_387 is
			--|#line 1650
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_ne_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_388 is
			--|#line 1652
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_free_as (yytype23 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_389 is
			--|#line 1654
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_minus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_390 is
			--|#line 1656
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_plus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_391 is
			--|#line 1658
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_not_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_392 is
			--|#line 1660
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_old_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_393 is
			--|#line 1662
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_free_as (yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_394 is
			--|#line 1664
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_strip_as (yytype74 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_395 is
			--|#line 1666
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_as (yytype87 (yyvs.item (yyvsp)).first) 
			yyval := yyval23
		end

	yy_do_action_396 is
			--|#line 1668
		local
			yyval23: EXPR_AS
		do

yyval23 := new_expr_address_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_397 is
			--|#line 1670
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_current_as 
			yyval := yyval23
		end

	yy_do_action_398 is
			--|#line 1672
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_result_as 
			yyval := yyval23
		end

	yy_do_action_399 is
			--|#line 1676
		local
			yyval30: ID_AS
		do

create yyval30.initialize (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_400 is
			--|#line 1684
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_401 is
			--|#line 1686
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_402 is
			--|#line 1688
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_403 is
			--|#line 1690
		local
			yyval10: CALL_AS
		do

yyval10 := new_current_as 
			yyval := yyval10
		end

	yy_do_action_404 is
			--|#line 1692
		local
			yyval10: CALL_AS
		do

yyval10 := new_result_as 
			yyval := yyval10
		end

	yy_do_action_405 is
			--|#line 1694
		local
			yyval10: CALL_AS
		do

yyval10 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_406 is
			--|#line 1696
		local
			yyval10: CALL_AS
		do

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_407 is
			--|#line 1698
		local
			yyval10: CALL_AS
		do

yyval10 := yytype45 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_408 is
			--|#line 1700
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_409 is
			--|#line 1702
		local
			yyval10: CALL_AS
		do

yyval10 := yytype46 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_410 is
			--|#line 1704
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_411 is
			--|#line 1706
		local
			yyval10: CALL_AS
		do

yyval10 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_412 is
			--|#line 1710
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (new_current_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_413 is
			--|#line 1714
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (new_result_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_414 is
			--|#line 1718
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype1 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_415 is
			--|#line 1722
		local
			yyval42: NESTED_EXPR_AS
		do

yyval42 := new_nested_expr_as (yytype23 (yyvs.item (yyvsp - 3)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_416 is
			--|#line 1726
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype45 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_417 is
			--|#line 1730
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor_as (Void, yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_418 is
			--|#line 1732
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_419 is
			--|#line 1734
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 2)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_420 is
			--|#line 1736
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_421 is
			--|#line 1738
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_422 is
			--|#line 1740
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_423 is
			--|#line 1742
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_424 is
			--|#line 1744
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_425 is
			--|#line 1746
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_426 is
			--|#line 1748
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_427 is
			--|#line 1750
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_428 is
			--|#line 1752
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_429 is
			--|#line 1754
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_430 is
			--|#line 1756
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_431 is
			--|#line 1760
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype46 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_432 is
			--|#line 1764
		local
			yyval46: STATIC_ACCESS_AS
		do

				yyval46 := new_static_access_as (yytype58 (yyvs.item (yyvsp - 4)), yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp)));
			
			yyval := yyval46
		end

	yy_do_action_433 is
			--|#line 1771
		local
			yyval46: STATIC_ACCESS_AS
		do

				yyval46 := new_static_access_as (yytype58 (yyvs.item (yyvsp - 3)), yytype30 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval46
		end

	yy_do_action_434 is
			--|#line 1779
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_435 is
			--|#line 1781
		local
			yyval10: CALL_AS
		do

yyval10 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_436 is
			--|#line 1785
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_437 is
			--|#line 1787
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype41 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_438 is
			--|#line 1791
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

	yy_do_action_439 is
			--|#line 1804
		local
			yyval2: ACCESS_FEAT_AS
		do

yyval2 := new_access_feat_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval2
		end

	yy_do_action_442 is
			--|#line 1812
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

yyval66 := yytype66 (yyvs.item (yyvsp - 1)) 
			yyval := yyval66
		end

	yy_do_action_443 is
			--|#line 1816
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_444 is
			--|#line 1821
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := yytype66 (yyvs.item (yyvsp - 2))
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_445 is
			--|#line 1828
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

yyval66 := new_eiffel_list_expr_as (0) 
			yyval := yyval66
		end

	yy_do_action_446 is
			--|#line 1830
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

yyval66 := yytype66 (yyvs.item (yyvsp)) 
			yyval := yyval66
		end

	yy_do_action_447 is
			--|#line 1834
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_448 is
			--|#line 1839
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := yytype66 (yyvs.item (yyvsp - 2))
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_449 is
			--|#line 1850
		local
			yyval30: ID_AS
		do

create yyval30.initialize (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_450 is
			--|#line 1852
		local
			yyval30: ID_AS
		do

yyval30 := new_boolean_id_as 
			yyval := yyval30
		end

	yy_do_action_451 is
			--|#line 1854
		local
			yyval30: ID_AS
		do

yyval30 := new_character_id_as (False) 
			yyval := yyval30
		end

	yy_do_action_452 is
			--|#line 1856
		local
			yyval30: ID_AS
		do

yyval30 := new_character_id_as (True) 
			yyval := yyval30
		end

	yy_do_action_453 is
			--|#line 1858
		local
			yyval30: ID_AS
		do

yyval30 := new_double_id_as 
			yyval := yyval30
		end

	yy_do_action_454 is
			--|#line 1860
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (8) 
			yyval := yyval30
		end

	yy_do_action_455 is
			--|#line 1862
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (16) 
			yyval := yyval30
		end

	yy_do_action_456 is
			--|#line 1864
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (32) 
			yyval := yyval30
		end

	yy_do_action_457 is
			--|#line 1866
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (64) 
			yyval := yyval30
		end

	yy_do_action_458 is
			--|#line 1868
		local
			yyval30: ID_AS
		do

yyval30 := new_none_id_as 
			yyval := yyval30
		end

	yy_do_action_459 is
			--|#line 1870
		local
			yyval30: ID_AS
		do

yyval30 := new_pointer_id_as 
			yyval := yyval30
		end

	yy_do_action_460 is
			--|#line 1872
		local
			yyval30: ID_AS
		do

yyval30 := new_real_id_as 
			yyval := yyval30
		end

	yy_do_action_461 is
			--|#line 1876
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_462 is
			--|#line 1878
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_463 is
			--|#line 1880
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_464 is
			--|#line 1882
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype47 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_465 is
			--|#line 1884
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_466 is
			--|#line 1886
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_467 is
			--|#line 1890
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_468 is
			--|#line 1892
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_469 is
			--|#line 1894
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

	yy_do_action_470 is
			--|#line 1909
		local
			yyval6: ATOMIC_AS
		do

yyval6 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval6
		end

	yy_do_action_471 is
			--|#line 1911
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_472 is
			--|#line 1913
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_473 is
			--|#line 1917
		local
			yyval9: BOOL_AS
		do

yyval9 := new_boolean_as (False) 
			yyval := yyval9
		end

	yy_do_action_474 is
			--|#line 1919
		local
			yyval9: BOOL_AS
		do

yyval9 := new_boolean_as (True) 
			yyval := yyval9
		end

	yy_do_action_475 is
			--|#line 1923
		local
			yyval12: CHAR_AS
		do

				check is_character: not token_buffer.is_empty end
				yyval12 := new_character_as (token_buffer.item (1))
			
			yyval := yyval12
		end

	yy_do_action_476 is
			--|#line 1930
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
			--|#line 1945
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

	yy_do_action_478 is
			--|#line 1960
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

	yy_do_action_479 is
			--|#line 1978
		local
			yyval47: REAL_AS
		do

yyval47 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval47
		end

	yy_do_action_480 is
			--|#line 1980
		local
			yyval47: REAL_AS
		do

yyval47 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval47
		end

	yy_do_action_481 is
			--|#line 1982
		local
			yyval47: REAL_AS
		do

				token_buffer.precede ('-')
				yyval47 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval47
		end

	yy_do_action_482 is
			--|#line 1989
		local
			yyval7: BIT_CONST_AS
		do

yyval7 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval7
		end

	yy_do_action_483 is
			--|#line 1993
		local
			yyval55: STRING_AS
		do

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_484 is
			--|#line 1995
		local
			yyval55: STRING_AS
		do

yyval55 := new_empty_string_as 
			yyval := yyval55
		end

	yy_do_action_485 is
			--|#line 1997
		local
			yyval55: STRING_AS
		do

yyval55 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval55
		end

	yy_do_action_486 is
			--|#line 2001
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_487 is
			--|#line 2003
		local
			yyval55: STRING_AS
		do

yyval55 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval55
		end

	yy_do_action_488 is
			--|#line 2005
		local
			yyval55: STRING_AS
		do

yyval55 := new_lt_string_as 
			yyval := yyval55
		end

	yy_do_action_489 is
			--|#line 2007
		local
			yyval55: STRING_AS
		do

yyval55 := new_le_string_as 
			yyval := yyval55
		end

	yy_do_action_490 is
			--|#line 2009
		local
			yyval55: STRING_AS
		do

yyval55 := new_gt_string_as 
			yyval := yyval55
		end

	yy_do_action_491 is
			--|#line 2011
		local
			yyval55: STRING_AS
		do

yyval55 := new_ge_string_as 
			yyval := yyval55
		end

	yy_do_action_492 is
			--|#line 2013
		local
			yyval55: STRING_AS
		do

yyval55 := new_minus_string_as 
			yyval := yyval55
		end

	yy_do_action_493 is
			--|#line 2015
		local
			yyval55: STRING_AS
		do

yyval55 := new_plus_string_as 
			yyval := yyval55
		end

	yy_do_action_494 is
			--|#line 2017
		local
			yyval55: STRING_AS
		do

yyval55 := new_star_string_as 
			yyval := yyval55
		end

	yy_do_action_495 is
			--|#line 2019
		local
			yyval55: STRING_AS
		do

yyval55 := new_slash_string_as 
			yyval := yyval55
		end

	yy_do_action_496 is
			--|#line 2021
		local
			yyval55: STRING_AS
		do

yyval55 := new_mod_string_as 
			yyval := yyval55
		end

	yy_do_action_497 is
			--|#line 2023
		local
			yyval55: STRING_AS
		do

yyval55 := new_div_string_as 
			yyval := yyval55
		end

	yy_do_action_498 is
			--|#line 2025
		local
			yyval55: STRING_AS
		do

yyval55 := new_power_string_as 
			yyval := yyval55
		end

	yy_do_action_499 is
			--|#line 2027
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_500 is
			--|#line 2029
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_501 is
			--|#line 2031
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_502 is
			--|#line 2033
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_503 is
			--|#line 2035
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_504 is
			--|#line 2037
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_505 is
			--|#line 2039
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_506 is
			--|#line 2041
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_507 is
			--|#line 2045
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_minus_string_as) 
			yyval := yyval88
		end

	yy_do_action_508 is
			--|#line 2047
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_plus_string_as) 
			yyval := yyval88
		end

	yy_do_action_509 is
			--|#line 2049
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_not_string_as) 
			yyval := yyval88
		end

	yy_do_action_510 is
			--|#line 2051
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval88
		end

	yy_do_action_511 is
			--|#line 2055
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_lt_string_as) 
			yyval := yyval88
		end

	yy_do_action_512 is
			--|#line 2057
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_le_string_as) 
			yyval := yyval88
		end

	yy_do_action_513 is
			--|#line 2059
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_gt_string_as) 
			yyval := yyval88
		end

	yy_do_action_514 is
			--|#line 2061
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_ge_string_as) 
			yyval := yyval88
		end

	yy_do_action_515 is
			--|#line 2063
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_minus_string_as) 
			yyval := yyval88
		end

	yy_do_action_516 is
			--|#line 2065
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_plus_string_as) 
			yyval := yyval88
		end

	yy_do_action_517 is
			--|#line 2067
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_star_string_as) 
			yyval := yyval88
		end

	yy_do_action_518 is
			--|#line 2069
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_slash_string_as) 
			yyval := yyval88
		end

	yy_do_action_519 is
			--|#line 2071
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_mod_string_as) 
			yyval := yyval88
		end

	yy_do_action_520 is
			--|#line 2073
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_div_string_as) 
			yyval := yyval88
		end

	yy_do_action_521 is
			--|#line 2075
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_power_string_as) 
			yyval := yyval88
		end

	yy_do_action_522 is
			--|#line 2077
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_and_string_as) 
			yyval := yyval88
		end

	yy_do_action_523 is
			--|#line 2079
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval88
		end

	yy_do_action_524 is
			--|#line 2081
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_implies_string_as) 
			yyval := yyval88
		end

	yy_do_action_525 is
			--|#line 2083
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_or_string_as) 
			yyval := yyval88
		end

	yy_do_action_526 is
			--|#line 2085
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval88
		end

	yy_do_action_527 is
			--|#line 2087
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_xor_string_as) 
			yyval := yyval88
		end

	yy_do_action_528 is
			--|#line 2089
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval88
		end

	yy_do_action_529 is
			--|#line 2093
		local
			yyval4: ARRAY_AS
		do

yyval4 := new_array_as (yytype66 (yyvs.item (yyvsp - 1))) 
			yyval := yyval4
		end

	yy_do_action_530 is
			--|#line 2097
		local
			yyval57: TUPLE_AS
		do

yyval57 := new_tuple_as (yytype66 (yyvs.item (yyvsp - 1))) 
			yyval := yyval57
		end

	yy_do_action_532 is
			--|#line 2105
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
			    0,  305,  305,  306,  308,  283,  283,  283,  283,  283,
			  283,  283,  283,  283,  283,  283,  283,  284,  285,  286,
			  292,  287,  289,  290,  288,  291,  293,  294,  295,  254,
			  254,  254,  256,  256,  256,  257,  257,  257,  255,  255,
			  176,  173,  173,  222,  222,  222,  143,  143,  143,  307,
			  307,  307,  307,  310,  310,  311,  311,  207,  207,  237,
			  237,  238,  238,  169,  169,  155,  312,  154,  154,  250,
			  250,  251,  251,  236,  236,  309,  309,  168,  302,  302,
			  299,  314,  314,  298,  298,  298,  296,  297,  147,  156,
			  156,  157,  157,  157,  266,  266,  266,  267,  267,  194,

			  194,  195,  195,  195,  195,  195,  195,  195,  268,  268,
			  269,  269,  200,  230,  230,  229,  229,  231,  231,  164,
			  170,  170,  239,  239,  241,  241,  240,  240,  243,  243,
			  242,  242,  245,  245,  244,  244,  277,  277,  278,  278,
			  279,  279,  219,  315,  315,  281,  281,  282,  282,  220,
			  252,  252,  253,  253,  215,  215,  205,  316,  204,  204,
			  204,  166,  167,  209,  209,  182,  182,  280,  280,  259,
			  259,  260,  260,  179,  313,  313,  180,  180,  180,  180,
			  180,  180,  180,  180,  180,  180,  201,  201,  318,  201,
			  319,  163,  163,  320,  163,  321,  272,  272,  273,  273,

			  211,  212,  212,  212,  214,  214,  218,  218,  218,  218,
			  218,  218,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  275,  275,  275,  276,  276,  247,
			  247,  248,  248,  249,  249,  171,  322,  303,  303,  246,
			  246,  175,  227,  227,  228,  228,  162,  261,  261,  177,
			  223,  223,  224,  224,  151,  263,  263,  183,  183,  183,
			  183,  183,  183,  183,  183,  183,  183,  183,  183,  183,
			  183,  183,  183,  183,  183,  262,  262,  185,  274,  274,
			  184,  184,  323,  221,  221,  221,  161,  270,  270,  270,
			  271,  271,  202,  258,  258,  142,  142,  203,  203,  225,

			  225,  226,  226,  158,  158,  158,  158,  158,  158,  206,
			  206,  206,  206,  206,  206,  206,  206,  206,  206,  206,
			  206,  206,  206,  264,  264,  265,  265,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  159,  159,  159,  160,  160,  217,  217,  137,
			  137,  140,  140,  178,  178,  178,  178,  178,  178,  178,
			  178,  178,  153,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  174,

			  150,  150,  150,  150,  150,  150,  150,  150,  150,  150,
			  150,  150,  190,  189,  188,  192,  187,  196,  196,  196,
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
			    3,    2,    0,    1,    3,    1,    1,    1,    2,    2,
			    2,    3,    3,    0,    1,    0,    1,    0,    2,    0,
			    1,    1,    2,    1,    2,    3,    0,    0,    1,    2,
			    3,    1,    3,    1,    2,    0,    1,    3,    1,    3,
			    2,    0,    1,    1,    1,    1,    2,    2,    3,    1,
			    2,    2,    2,    2,    0,    2,    2,    1,    2,    2,

			    3,    2,    8,    7,    6,    5,    4,    3,    1,    2,
			    1,    3,    3,    0,    1,    2,    2,    1,    2,    3,
			    1,    1,    1,    3,    0,    1,    1,    2,    0,    1,
			    1,    2,    0,    1,    1,    2,    0,    3,    0,    1,
			    1,    2,    5,    0,    3,    0,    1,    1,    2,    4,
			    1,    3,    0,    1,    0,    2,    8,    0,    1,    1,
			    1,    3,    2,    0,    2,    2,    2,    0,    2,    1,
			    2,    1,    2,    3,    0,    2,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    0,    3,    0,    4,
			    0,    0,    3,    0,    4,    0,    0,    1,    1,    2,

			    3,    1,    3,    2,    1,    1,    3,    3,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    0,    2,    3,    1,    3,    0,
			    4,    0,    1,    1,    3,    3,    0,    0,    3,    0,
			    3,    8,    0,    1,    1,    2,    5,    0,    2,    6,
			    0,    1,    1,    2,    5,    1,    3,    1,    3,    1,
			    3,    1,    3,    3,    3,    3,    3,    1,    3,    3,
			    3,    3,    3,    3,    3,    0,    2,   10,    0,    2,
			    0,    3,    0,    0,    4,    2,    5,    0,    2,    3,
			    1,    3,    1,    0,    2,    4,    4,    4,    4,    0,

			    1,    1,    2,    1,    3,    2,    1,    3,    2,    5,
			    5,    5,    7,    7,    5,    3,    4,    4,    4,    6,
			    5,    4,    3,    0,    3,    1,    3,    1,    1,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    3,    6,    4,    7,    6,    5,    0,    1,    1,
			    1,    0,    3,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    4,    1,    1,    1,    1,    1,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    4,    3,    4,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    2,
			    2,    2,    2,    2,    4,    2,    4,    2,    2,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    3,    3,    3,    5,    3,    2,    7,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    3,    7,    6,    1,    1,    3,    3,    2,    2,
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
			   29,  460,  459,  458,  452,  457,  455,  454,  456,  453,
			  451,  450,   42,  449,    0,   53,    1,    0,    0,   38,
			   42,   28,   27,   26,   20,   25,   23,   22,   24,   21,
			   19,   18,    0,    0,    0,    0,   17,    2,  204,  205,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,   54,   55,    0,   55,   41,  506,  505,  504,
			  503,  502,  501,  500,  499,  498,  497,  496,  495,  494,
			  493,  492,  491,  490,  489,  488,  485,  487,  484,  474,
			  473,    0,   45,    0,  482,  486,  479,  475,  476,    0,
			    0,   43,   47,  465,  461,  462,    0,   46,  463,  464,

			  466,  483,   75,   39,  224,    5,    6,    8,    9,   12,
			   10,   11,   13,    7,   14,   15,   16,  211,  210,  224,
			    0,    0,  209,  208,    0,  212,  213,  214,  216,  219,
			  217,  218,  220,  215,  221,  222,  223,   56,   50,    0,
			   55,   55,   49,    0,    0,  481,  478,  480,  477,   48,
			    0,   76,   40,  207,  206,  225,  227,    0,  532,   52,
			   51,    0,  532,   44,  226,    0,  163,    0,  532,  351,
			  228,    0,   57,  231,  351,    0,  346,  164,    0,   94,
			  236,  233,    0,  232,  345,  440,   58,  532,  532,  237,
			  230,    0,    0,  352,   97,  532,    0,   96,  299,    0,

			  235,  234,    0,  404,    0,  440,    0,  403,    0,  445,
			    0,  441,  445,    0,  470,  469,    0,    0,    0,    0,
			  399,    0,    0,  405,  364,  363,  471,  467,  366,  468,
			  411,  443,  440,    0,  408,  402,  401,  400,  410,  406,
			  407,  409,  367,  472,  365,    0,   98,   99,  224,  306,
			  303,  301,   59,  300,  239,    0,    0,    0,    0,    0,
			    0,    0,    0,  323,    0,  417,    0,    0,    0,  398,
			    0,    0,  397,    0,   83,   84,   85,  395,  447,    0,
			  446,    0,    0,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,    0,  323,    0,  392,  152,  391,

			  389,  390,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  438,  393,    0,    0,  442,    0,  100,  101,
			    0,    0,  308,    0,  305,   66,   81,   61,  532,   60,
			  302,    0,  238,  323,  323,  435,  413,  440,  434,    0,
			    0,    0,    0,    0,    0,    0,  315,    0,    0,  323,
			  412,  510,  509,  508,  507,   87,  528,  527,  526,  525,
			  524,  523,  522,  521,  520,  519,  518,  517,  516,  515,
			  514,  513,  512,  511,   86,    0,  530,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,  529,  322,  368,  150,  153,    0,  414,  375,  374,
			  373,  372,  371,  370,  369,  382,  384,  383,  385,  386,
			  387,    0,  376,  381,    0,  378,  380,  388,  323,  416,
			  431,  444,  126,  134,  108,  130,   75,  107,  124,  128,
			  132,    0,  113,   69,    0,   71,  307,  122,  304,   67,
			   82,   73,   81,   78,  136,    0,  280,   62,    0,  321,
			  316,    0,  439,  323,  323,  323,    0,    0,  327,    0,
			  328,  325,    0,  323,  440,    0,  317,  396,  448,    0,
			  323,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,    0,    0,    0,  394,  377,  379,  318,  127,

			  135,  110,  109,    0,  131,  117,  115,    0,  116,  125,
			  128,  129,  132,  133,    0,  106,  114,  124,   70,    0,
			    0,   65,   68,   74,   81,  138,  174,  154,   80,  282,
			  532,  240,  436,  437,  314,  309,  310,    0,    0,  205,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  324,    0,  311,  419,    0,    0,  320,  420,
			  421,  422,  423,  426,  424,  425,  427,  428,  429,  430,
			  323,  415,  151,    0,    0,  118,  120,   75,  121,  132,
			    0,  105,  128,   72,  123,   79,  140,    0,    0,  139,
			   77,    0,   35,  531,   29,  323,  323,  341,  212,  213,

			  214,  216,  219,  217,  218,  220,  215,  221,  222,  223,
			  326,  440,  440,  319,  111,  112,  119,    0,  104,  132,
			  143,  137,  141,  175,  155,   32,   42,   88,   89,  198,
			  281,  531,    0,    0,  313,  312,  329,  330,  331,  333,
			  336,  334,  335,  337,  332,  338,  339,  340,  432,  418,
			  103,    0,    0,    0,   35,   42,   35,   90,   57,   37,
			   42,  199,  201,  440,   75,    4,    3,  102,    0,   75,
			   92,   42,   91,   93,  157,   36,  203,  200,  144,  142,
			  186,  202,  188,  167,  190,  531,  145,    0,  531,  187,
			  147,    0,  168,  146,  174,  532,  174,  160,  159,  158,

			  191,  189,    0,  148,  166,  531,  163,    0,  165,  193,
			  293,   75,  171,  531,  532,  161,  162,  195,  531,  174,
			    0,  149,  172,  292,  532,  174,  178,  184,  176,  183,
			  180,  181,  177,  174,  182,  185,  179,    0,  531,  192,
			  294,  156,    0,  278,  173,    0,    0,  287,    0,  531,
			    0,    0,  347,    0,  353,  440,  359,  355,  354,  356,
			  361,  357,  358,  360,  194,  250,  531,  283,    0,    0,
			    0,    0,  174,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  350,    0,  351,  349,  348,
			    0,    0,    0,    0,  532,  252,  275,  251,  279,    0,

			    0,  296,  298,  174,  288,  290,    0,    0,  362,    0,
			  343,    0,    0,  295,  297,    0,  174,    0,  253,  285,
			  440,  532,  532,  289,    0,  286,    0,  351,    0,  259,
			  261,  257,  255,  267,    0,  276,  249,    0,    0,  244,
			  247,  532,    0,  291,  351,  342,    0,    0,    0,    0,
			    0,  174,    0,  284,    0,  174,    0,  245,    0,  344,
			    0,  260,  266,  274,  265,  262,  263,  269,  264,  258,
			  272,  273,  268,  271,  270,  254,  256,  174,  248,  241,
			    0,    0,    0,  174,    0,  277,  246,  433,    0,    0,
			    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  787,  223,  345,  176,  224,  726,   91,   92,  225,  226,
			  526,  227,  346,  228,  795,  229,  727,  331,  336,  627,
			  657,  251,  728,  230,  729,  839,  710,  505,  278,  698,
			  706,  451,  337,  577,  181,  232,   18,  233,  730,   19,
			  731,  732,  712,  733,   98,  699,  832,  530,  734,  348,
			  234,  235,  236,  237,  238,  239,  471,  194,  247,  240,
			  241,  833,   99,  501,  683,  735,  736,  700,  673,  242,
			  179,  243,  172,  101,  629,  664,  244,  282,  592,   38,
			  790,   39,  586,  690,  800,  102,  796,  797,  252,  253,
			  840,  841,  438,  517,  506,  322,  245,  279,  280,  452,

			  338,  339,  446,  509,  510,  511,  512,  513,  514,  342,
			  166,  182,  183,  507,  444,  587,  406,   15,   20,  658,
			  628,  720,  704,  713,  856,  817,  834,  356,  472,  188,
			  195,  442,  502,  772,  806,  630,  631,  767,  125,  157,
			  527,  588,  589,  687,  692,  693,  274,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,  275,
			  276,  447,  453,  384,  365,  454,  200,  196,  888,   16,
			   54,  666,  152,   55,  138,  449,  705,  455,  653,  680,
			  632,  685,  688,  718,  738,  189,  593>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 2648, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 2473, -32768, 2579,  -16, -32768,  591, 2001, -32768,
			 2442, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 2706, 1558, 2706,  963, -32768, -32768, -32768, -32768,
			  457,  457,  457,  457,  457,  457,  457,  457,  457,  457,
			  457,  457, -32768,  548,  566,  -35, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  581, -32768, 2579, -32768, -32768, -32768, -32768, -32768,  172,
			  166, -32768, -32768, -32768, -32768, -32768,  563, -32768, -32768, -32768,

			 -32768, -32768,   12, -32768,  457, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  457,
			  594,  593, -32768, -32768, 2559, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2706,
			  548,  548, -32768, 2579,  578, -32768, -32768, -32768, -32768, -32768,
			 2124, -32768, -32768, -32768, -32768, -32768, -32768,  120,  517, -32768,
			 -32768,  564, -32768, -32768, -32768, 2579,  383,  562, -32768,  149,
			 -32768, 1251,  342,  565,  149, 2690, -32768, -32768, 1230,  525,
			 -32768, -32768,  550,  567, -32768,  426, -32768,   50, -32768,  553,
			 -32768,  565, 1713, -32768, -32768,  170, 2706, -32768,  332, 2706,

			 -32768, -32768,  503,   89, 2381,   22,  551,   81, 2242, 1836,
			 2524, -32768, 1836, 2690, -32768, -32768, 1836, 1836,  568, 1836,
			 -32768, 1836, 1836,  356, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, 2957,  106, 1836, -32768, -32768, -32768, -32768, -32768, -32768,
			  355,  350, -32768, -32768, -32768,  179, -32768,  555,  457, 2607,
			 2607, -32768,  491,  332,  549, 2690, 2690, 2690,  561,  559,
			  558, 2579, 1836,  339, 2706, -32768, 2579, 2690, 2690, -32768,
			   -6, 2824, -32768, 1836, -32768, -32768, -32768, -32768, 2957,  531,
			  538, 2706,  482,  293,  288,  275,  265,  260,  258,  248,
			  237,  235,  218,  213,  521,  432, 2914, -32768, 2690, -32768,

			 -32768, -32768, 2690, 1836, 1836, 1836, 1836, 1836, 1836, 1836,
			 1836, 1836, 1836, 1836, 1836, 1836, 1590, 1836, 1183, 1836,
			 1836, 2690, -32768, -32768, 2690, 2690, -32768, 1836, -32768,  385,
			 2178, 2622, 2662, 2622, 2662, -32768,  411, -32768, -32768,  491,
			 -32768, 2622, -32768,  432,  432,  486, -32768,  426, -32768, 2690,
			 2690, 2690,  530, 2896, 1959, 2690, -32768,  529,  524,  432,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, 2853, -32768, 1836,  523, 2690,
			  489,  488,  487,  484,  481,  479,  478,  477,  475,  472,

			  470, -32768, -32768,   58, -32768,  514,  506, -32768,  322,  322,
			  322,  322,  322,  340,  340,  895,  895,  895,  895,  895,
			  895, 1836, 1135, 2295, 1836, 2973, 2876, -32768,  432, -32768,
			 -32768, 2957, 2622, 2622, 2622, 2622,   39, -32768,  418,  414,
			  341,  485,  480, -32768,    7, -32768,  463, -32768,  463,  476,
			 -32768, -32768,  344, -32768,   55, 2622,  464, -32768,   -1, -32768,
			 -32768, 2690, -32768,  432,  432,  432,  522,  518,  503, 2524,
			 2957, -32768,  138,  432,  426,  515, -32768, -32768, 2957,  492,
			  432,  426,  426,  426,  426,  426,  426,  426,  426,  426,
			  426,  426, 2690, 2690, 2690, -32768, 1135, 2973, -32768,  463,

			  463, -32768,  483,  465,  463, -32768,  476, 1362, -32768, -32768,
			  414, -32768,  341, -32768,  454, -32768, -32768,  418, -32768, 2706,
			 2622, -32768, -32768, -32768,  446, 2690, -32768,  474, -32768, -32768,
			 -32768, -32768,  486, -32768, -32768, -32768, -32768, 2690, 2690,  459,
			  293,  288,  275,  265,  260,  258,  248,  237,  457,  235,
			  218,  213, -32768, 1959, -32768, -32768, 2690,  425, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  432, -32768, -32768, 2622, 2622, -32768, -32768,  363,  463,  341,
			  435, -32768,  414, -32768, -32768, -32768, -32768,  206,  453, 2690,
			  354, 2579,   94,   10,  421,  432,  432, -32768,  444,  443,

			  441,  439,  431,  430,  428,  420,  416,  415,  413,  412,
			 -32768,  426,  426, -32768, -32768, -32768, -32768,  386, -32768,  341,
			  388, -32768, -32768, -32768, -32768, 2247, 2673, -32768, -32768, -32768,
			 -32768, 1701, 1836,  367, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  362, 2690, 2579,  352, 2415,  352, -32768,  342, -32768,
			  422, -32768, 2957,  151,  363, -32768, -32768, -32768,  375,  363,
			 -32768, 2108, -32768, -32768, -32768, -32768, 1836, -32768, -32768, -32768,
			  329, 2957,  358,  334, -32768,  387, 2690,  -18,  387, -32768,
			 -32768,  145, -32768, 2690, -32768, -32768, -32768, -32768, -32768, -32768,

			  345, -32768, 2579, -32768, -32768,  253,  383, 1251, -32768,  312,
			  313,  363, -32768,  306,   32, -32768, -32768, -32768,  -29, -32768,
			  330, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2358,  -29, -32768,
			 -32768, -32768, 1836,  315,  354,   21, 1836,  364,  361,  320,
			  834,  596, 2579, 1836,  356,    5, -32768, -32768, -32768, -32768,
			 -32768, -32768,  355,  350, -32768, 1107,  -21,  276, 1836, 1836,
			 1522, 1366, -32768,  297,  301,  300,  290,  283,  281,  279,
			  273,  268,  254,  252,  240, -32768, 2579,  149, -32768, -32768,
			  244, 2835, 1836, 1836, -32768, -32768,  207,  161, -32768, 1836,

			  174, 2957, 2957, -32768, -32768, -32768,  102,  187, -32768,  169,
			 -32768, 1228,  222, 2957, 2957,  789, -32768,  171, -32768, 2957,
			  117, -32768,  101, -32768, 1251, -32768, 1228,  149,  163,  231,
			  225,  202, -32768,  191,  -10, -32768, -32768, 1836, 1836, -32768,
			  128,   71,  124, -32768,  149, -32768, 2579, 1488,  789,  857,
			  789, -32768,  789, 2957, 2817, -32768,   83, -32768, 1836, -32768,
			  116, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 1414,   98,   37, -32768, 2690, -32768, -32768, -32768,  113,   88,
			 -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -773,  -23,  250, -171, -32768, -32768,  547,   69, -32768,   -4,
			 -32768,   -5, -252, -32768, -105,  -17, -32768, -243, -32768, -32768,
			 -32768,  445, -32768,    9, -32768, -152, -32768,  181,  712, -32768,
			 -32768,  239,  346, -32768,  493,    0, -32768,  755, -32768,  -14,
			 -32768, -32768,  -30, -32768,  -25, -32768, -173, -32768, -32768,  221,
			  -59,  -60,  -61,  -62,  -67,  -68,  121,  471, -32768,  -72,
			  -74, -617, -32768,   85, -32768, -32768, -32768, -32768, -32768, -32768,
			    1,  -13,  -53, -162,   30, -32768, -32768,   14, -32768,  455,
			 -32768,  182,   60,  -49, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  205, -32768, -32768,  -44, -32768,  436, -32768, -32768,

			 -32768, -32768, -233,  316,  126,  309, -489,  304, -497, -32768,
			 -32768, -32768, -32768, -226, -32768, -294, -32768,   41, -600, -32768,
			 -434, -32768, -302, -32768, -32768, -32768, -32768,   44, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -648, -32768, -32768, 1038, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,   33,  255,  168,  167,
			  135,   43,   28,   27,   15,  203,   11,   -3,  -12, -32768,
			 -32768, -191,  107, -32768, -32768, -32768, -32768,  -99, -32768, -32768,
			 -32768, -32768, -165, -32768,  -36, -32768, -518, -32768, -32768, -32768,
			 -606, -32768, -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   14,   95,   51,  184,  405,  100,  103,  333,  590,  177,
			  123,   50,   17,   94,   93,  580,  360,  277,   97,  142,
			   17,  579,  197,  332,  334,   49,  660,   96,   37,   47,
			  852,  192,  141,  118,  137,  122, -196,  689,  827,  520,
			  701,   46,   45,  697,  696,   53,  257,  519,  192,  151,
			  407,  695,  150,  844,  518,  671,   52,   44,  793,  167,
			  140,  792, -196,  169,  531,  104,  694,  119,  264,  174,
			  739,   51,  429,  430,  769, -196,  151,  768, -196, -196,
			   50,  525,  617,  493, -196,  330,  851,  151,  890,  198,
			  764,  -75,  -75,  619,   49,  524,  492,  144,   47,  714,

			  448,  773,  885,  725,  159,  160,  268,  714,  458,  724,
			   46,   45,   51,  889,  257,  -75,  364,  363,  798,  267,
			  -75,   50,  651,  884,  -75,  723,   44,  256,  -75,  362,
			  361,   51,  192,   95, -243,   49, -243,  100,  156,   47,
			   50,  193,  824,  192,  321,   94,   93,  823,  879,   43,
			   97,   46,   45,   51,   49,  321,  837,  161,   47,   96,
			  165,  265,   50,  881, -242,  186, -242,   44,  626,  164,
			   46,   45,  158,  625,  175,  185,   49,  192,  553,  170,
			   47,   42,   41,  552,  702,  494,   44,   51,  858,  321,
			  676,  855,   46,   45,  850,  148,   50,  147,  293,  499,

			  500,  146,  504,  145,  263,  849,  521,  292,   44,  846,
			   49,  -95,  -95,  295,   47,  744,  826,   48,   43,  327,
			  670,  291,  672,  522,  326,  290,   46,   45,  848,  248,
			  863,  867,  870,  874,  847,  -95,  836,  289,  288,  456,
			  -95,  571,   44,  503,  -95,  620,  494,  493,  -95,   51,
			   42,   41,  825,  287,   51,  343,  344,  347,   50,   43,
			  400,  124,  794,   50,  528,  399,  124,  359,  347,   40,
			  816,  508,   49,  821,  578,  352,   47,   49,   43,  811,
			  358,   47,  398,  124,  397,  124,   48,  400,   46,   45,
			  623,   42,   41,   46,   45,  396,  124,  357,  404,  399,

			   43,  398,  347,  462,   44,  395,  124,  394,  124,   44,
			   42,   41,  393,  124,  388,  397, -169, -169, -169, -169,
			  396,  428,  392,  124,  347,  347,  395,   48,  394,  584,
			  393, -169,   42,   41,   43,  391,  124,  392,   40,  402,
			  390,  124,  303,  220, -169,  286,   48,  391,  390,  463,
			  464,  465, -169, -169, -169,  473,  307,  306,  305,  304,
			  303,  220,  808,  445,  355,  354,   42,   41,   48, -170,
			 -170, -170, -170,  250,  249,  325,  799,  285,  284,   40,
			  324,  302,  503,  615, -170, -196,  268,  459,  460,  480,
			  771,  623,  691,  766,  708,  741,   43, -170,   40,  691,

			  151,   43,   48,  476,  719, -170, -170, -170,  717,  -64,
			  171,  709,  616,   48,  -64,  686,  450,  740,  -64,  682,
			   40,  684,  -64,  743,  678,  178,  626,  667,   42,   41,
			  555,  594,  665,   42,   41,  433,  652,  559,  560,  561,
			  562,  563,  564,  565,  566,  567,  568,  569, -196, -196,
			  437,  650,  192,  436,   40,   13, -196,  551,  354,  647,
			  646,  347,  645,  644,   48,  283,  550,  643, -196,   48,
			  807, -196,  498,  435,  434,  642,  -63,  641,  640,  433,
			  549,  -63,  432,  450,  547,  -63,  639,  675,  638,  -63,
			  637,  636,  570,  347,  572,   12,  546,  545,  621,  677,

			  618,  822,  435,  520,  679,  124,  597,  534,  535,  536,
			  612,  461,  544,  591,  835,  432,   40,  554,  450,  581,
			  574,   40,  330,  573,  558,  404,   11,   10,    9,    8,
			    7,    6,    5,    4,    3,    2,    1,  595,  596,  557,
			  556,  255,  529,  538, -229,  716,  721,  537,  436,  875,
			  515,  495,  583,  878,  494,  491,  611,  490, -229, -229,
			  489,  335,  488,  487,  486,  401,  485,  648,  649,  484,
			  479,  475,  483,  482,  481,  882,  474,  466,  387,   51,
			  386,  886, -229,  351,  350,  389,  349, -229,   50,  404,
			  341, -229,  328, -229,  298, -229,  707,  266,  180,  190,

			 -229,  187,   49,  199,  543,  624,   47,  191,   95,  805,
			  173,  168,  100,  162,  613,  737,  810,  137,   46,   45,
			   94,   93,  148,  146,  139,  742,   17,  143,  149,   13,
			   56,  585,  663,  441,   44,  633,  542,  541,  440,  634,
			  635,   51,  786,  582,  703,  439,  103,  516,  294,  622,
			   50,  539,  668,  715,  254,   17,  845,  103,  614,  674,
			   17,  661,  843,  763,   49,  762,  246,  669,   47,  761,
			  760,   17,  548,  859,  610,  759,  758,  757,  756,  876,
			   46,   45,  533,  722,  201,  457,  404,  575,  785,  857,
			   51,  523,  818,  404,  656,  815,   44,  163,  340,   50,

			   11,   10,    9,    8,    7,    6,    5,    4,    3,    2,
			    1,  532,    0,   49,  754,    0,  711,   47,    0,    0,
			    0,    0,  838,  842,  540,    0,   43,    0,    0,   46,
			   45,    0,    0,    0,    0,    0,    0,  755,  784,    0,
			   51,    0,  842,    0,    0,   44,    0,  783,    0,   50,
			    0,  788,    0,    0,    0,    0,    0,    0,   42,   41,
			    0,  782,    0,   49,    0,  781,  789,   47,    0,    0,
			    0,    0,    0,    0,   51,    0,    0,  780,  779,   46,
			   45,    0,    0,   50,    0,    0,    0,    0,   43,    0,
			  831,    0,    0,  778,   48,   44,    0,   49,  829,  820,

			  809,   47,    0,  121,  120,    0,    0,    0,    0,    0,
			    0,  788,    0,   46,   45,  830,    0,    0,   88,   87,
			   42,   41,   13,  866,  869,  873,  788,  831,    0,   44,
			  861,  864,    0,  871,   51,  829,    0,   43,    0,    0,
			    0,    0,    0,   50,    0,    0,   40,  862,  865,  868,
			  872,    0,  830,    0,    0,    0,   48,   49,    0,  828,
			  860,   47,    0,    0,    0,    0,    0,   36,    0,   42,
			   41,  121,  120,   46,   45,    0,    0,    0,    0,    0,
			  281,    0,    0,    0,  887,  777,   88,   43,    0,   44,
			   13,    0,    0,   11,   10,    9,    8,    7,    6,    5,

			    4,    3,    2,    1,  231,   48,    0,    0,   40,  309,
			  308,  307,  306,  305,  304,  303,  220,  776,  775,   42,
			   41,   43,    0,    0,    0,    0,    0,  828,  296,  297,
			    0,  299,    0,  300,  301,    0,    0,    0,   31,   30,
			   29,   28,   27,   26,   25,  323,   23,   22,   21,    0,
			    0,    0,    0,   42,   41,   48,    0,   40,    0,    0,
			    0,   11,   10,    9,    8,    7,    6,    5,    4,    3,
			    2,    1,    0,    0,  353,    0,    0,  121,  120,    0,
			    0,   43,    0,    0,    0,  385,  320,    0,    0,   48,
			    0,    0,   88,    0,    0,    0,   13,    0,    0,    0,

			    0,    0,    0,    0,    0,  774,    0,   40,    0,    0,
			    0,    0,    0,   42,   41,  408,  409,  410,  411,  412,
			  413,  414,  415,  416,  417,  418,  419,  420,  422,  423,
			  425,  426,  427,  320,    0,    0,    0,    0,    0,  431,
			    0,   40,    0,    0,    0,    0,    0,    0,    0,   48,
			    0,  320,  320,    0,  320,  320,  320,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  470,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    2,    1,  320,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  478,

			    0,   40,    0,    0,    0,    0,    0,    0,  320,    0,
			    0,  319,  318,  317,  316,  315,  314,  313,  312,  311,
			  310,  309,  308,  307,  306,  305,  304,  303,  220,    0,
			    0,    0,    0,  496,    0,    0,  497,    0,    0,    0,
			  320,    0,  153,  315,  314,  313,  312,  311,  310,  309,
			  308,  307,  306,  305,  304,  303,  220,  154,    0,    0,
			    0,    0,    0,  320,  320,  320,  320,  320,  320,  320,
			  320,  320,  320,  320,  320,  320,    0,  320,  320,    0,
			  320,  320,  320,    0,    0,    0,  320,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  222,  221,    0,

			    0,    0,    0,    0,  220,  219,  218,  217,  794,  216,
			    0,    0,  215,   87,  214,   85,   13,   84,   83,    0,
			    0,  213,    0,    0,   81,  320,  212,    0,    0,  210,
			    0,  209,    0,  320,   80,   79,    0,  208,    0,    0,
			    0,    0,  207,    0,    0,    0,  424,    0,    0,    0,
			    0,  320,  320,  206,    0,    0,    0,    0,    0,    0,
			    0,   13,   85,    0,    0,  470,    0,    0,  205,  204,
			    0,    0,    0,    0,    0,  203,    0,    0,    0,    0,
			    0,    0,    0,   85,    0,  202,  329,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    2,    1,   78,   77,

			   76,   75,   74,   73,   72,   71,   70,   69,   68,   67,
			   66,   65,   64,   63,   62,   61,   60,   59,   58,   57,
			  785,    0,  126,  127,  128,  129,  130,  131,  132,  134,
			  135,  136,   11,   10,    9,    8,    7,    6,    5,    4,
			    3,    2,    1,    0,  662,   78,   77,   76,   75,   74,
			   73,   72,   71,   70,   69,   68,   67,   66,   65,   64,
			   63,   62,   61,   60,   59,   58,   57,   77,    0,   75,
			   74,   73,   72,   71,   70,   69,   68,   67,   66,   65,
			   64,   63,   62,   61,   60,   59,   58,   57,  681,    0,
			  576,    0,    0,    0,    0,   36,    0,    0,   85,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  804,    0,    0,    0,    0,    0,  320,  319,  318,
			  317,  316,  315,  314,  313,  312,  311,  310,  309,  308,
			  307,  306,  305,  304,  303,  220,  320,  271,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  270,
			    0,    0,    0,    0,  765,    0,    0,    0,  770,    0,
			    0,    0,    0,    0,    0,  791,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,    0,    0,    0,
			  801,  802,   77,    0,   75,   74,   73,   72,   71,   70,
			   69,   68,   67,   66,   65,   64,   63,   62,   61,   60,

			   59,   58,   57,    0,  813,  814,    0,    0,    0,    0,
			  883,  819,    0,    0,    0,    0,    0,    0,   87,    0,
			  320,   13,    0,    0,    0,  320,  319,  318,  317,  316,
			  315,  314,  313,  312,  311,  310,  309,  308,  307,  306,
			  305,  304,  303,  220,    0,    0,  320,    0,    0,  853,
			  854,    0,    0,    0,    0,    0,  320,  320,  828,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  320,  320,
			  880,    0,    0,    0,  320,    0,    0,    0,  598,  599,
			  600,  601,  602,  603,  604,  605,  606,  607,  608,  609,
			    0,   13,   11,   10,    9,    8,    7,    6,    5,    4,

			    3,    2,    1,    0,  222,  221,    0,    0,  320,  320,
			    0,  220,  219,  218,  217,    0,  216,  117,  803,  215,
			   87,  214,   85,   13,   84,   83,    0,    0,  213,    0,
			    0,   81,    0,  212,    0,  320,  210,    0,  209,    0,
			    0,   80,   79,    0,  208,    0,    0,    0,    0,  207,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  206,    0,   11,   10,    9,    8,    7,    6,    5,    4,
			    3,    2,    1,    0,    0,  205,  204,    0,    0,    0,
			    0,    0,  203,    0,    0,    0,  421,    0,    0,    0,
			    0,    0,  202,    0,   11,   10,    9,    8,    7,    6,

			    5,    4,    3,    2,    1,   78,   77,   76,   75,   74,
			   73,   72,   71,   70,   69,   68,   67,   66,   65,   64,
			   63,   62,   61,   60,   59,   58,   57,  222,  221,    0,
			    0,    0,    0,    0,  220,  219,  218,  217,    0,  216,
			    0,    0,  215,   87,  214,   85,   13,   84,   83,    0,
			    0,  213,    0,    0,   81,    0,  212,    0,  211,  210,
			    0,  209, -197, -197,   80,   79, -197,  208,    0,    0,
			 -197,    0,  207,    0,    0, -197,    0,    0,    0,    0,
			    0,    0, -197,  206,    0, -197,    0,    0,    0,    0,
			    0,    0, -197,    0,    0,    0,    0,    0,  205,  204,

			 -197, -197,    0,    0,    0,  203,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  202,    0,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    2,    1,   78,   77,
			   76,   75,   74,   73,   72,   71,   70,   69,   68,   67,
			   66,   65,   64,   63,   62,   61,   60,   59,   58,   57,
			  222,  221,    0,    0,    0,    0,    0,  220,  219,  218,
			  217,    0,  216,    0,    0,  215,   87,  214,   85,   13,
			   84,   83,    0,    0,  213,    0,    0,   81,    0,  212,
			    0,    0,  210,    0,  209,    0,    0,   80,   79,    0,
			  208,    0,    0,    0,    0,  207,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,  206,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  205,  204,    0,    0,    0,    0,    0,  203,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  202,    0,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,    2,
			    1,   78,   77,   76,   75,   74,   73,   72,   71,   70,
			   69,   68,   67,   66,   65,   64,   63,   62,   61,   60,
			   59,   58,   57,  222,  221,    0,    0,    0,    0,    0,
			  220,  219,  218,  217,    0,  216,    0,    0,  215,   87,
			  214,   85,   13,   84,   83,    0,    0,  213,    0,    0,

			   81,    0,  212,    0,    0,  469,    0,  209,    0,    0,
			   80,   79,    0,  208,    0,   90,   89,    0,  207,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  206,
			   88,   87,   86,   85,   13,   84,   83,    0,   82,    0,
			    0,    0,   81,    0,  205,  204,    0,    0,    0,    0,
			    0,  203,   80,   79,    0,    0,    0,    0,    0,    0,
			    0,  468,    0,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,    2,    1,   78,   77,   76,   75,   74,   73,
			   72,   71,   70,   69,   68,   67,   66,   65,   64,   63,
			   62,   61,   60,   59,   58,   57,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,   11,   10,    9,    8,    7,
			    6,    5,    4,    3,    2,    1,   78,   77,   76,   75,
			   74,   73,   72,   71,   70,   69,   68,   67,   66,   65,
			   64,   63,   62,   61,   60,   59,   58,   57,   90,   89,
			    0,   13,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   88,   87,   86,   85,   13,   84,   83,
			    0,    0,    0,    0,    0,   81,    0,    0,    0,  -33,
			  -33,    0,    0,    0,    0,   80,   79,  -33,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  -33,
			    0,  -33,  -33,    0,    0,    0,    0,    0,  -33,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   36,   11,   10,    9,    8,    7,    6,    5,    4,
			    3,    2,    1,    0,    0,  443,    0,    0,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,    2,    1,   78,
			   77,   76,   75,   74,   73,   72,   71,   70,   69,   68,
			   67,   66,   65,   64,   63,   62,   61,   60,   59,   58,
			   57,   90,   89,    0,    0,    0,    0,    0,  273,    0,
			    0,    0,    0,    0,    0,   36,   88,   87,   86,   85,
			    0,   84,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,    0,    0,    0,    0,    0,   80,   79,

			    0,  272,  316,  315,  314,  313,  312,  311,  310,  309,
			  308,  307,  306,  305,  304,  303,  220,  271,    0,    0,
			    0,  655,    0,    0,    0,    0,    0,    0,    0,  270,
			    0,    0,    0,    0,  269,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  654,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,    0,    0,    0,
			    0,    0,   78,   77,   76,   75,   74,   73,   72,   71,
			   70,   69,   68,   67,   66,   65,   64,   63,   62,   61,
			   60,   59,   58,   57,  753,    0,    0,    0,    0,    0,
			    0,   13,    0,  752,    0,    0,    0,    0,    0,  751,

			    0,    0,    0,    0,  750,    0,    0,  262,    0,    0,
			    0,    0,    0,    0,   13,  749,    0,  748,  747,    0,
			    0,    0,    0,    0,    0,    0,    0,  261,  206,    0,
			    0,  746,    0,    0,    0,    0,    0,    0,    0,    0,
			  260,    0,    0,  205,    0,    0,    0,    0,   13,    0,
			  745,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   11,   10,    9,    8,    7,    6,    5,    4,
			    3,    2,    1,  259,    0,   13,  -34,  -34,    0,    0,
			    0,    0,    0,  258,  -34,   11,   10,    9,    8,    7,
			    6,    5,    4,    3,    2,    1,  -34,    0,  -34,  -34,

			  -30,    0,    0,  -30,    0,  -34,   13,  -30,    0,  -30,
			    0,  -30,    0,    0,  -30,    0,    0,    0,    0,   11,
			   10,    9,    8,    7,    6,    5,    4,    3,    2,    1,
			    0,  -31,    0,    0,  -31,    0,    0,  -30,  -31,    0,
			  -31,    0,  -31,    0,    0,  -31,   11,   10,    9,    8,
			    7,    6,    5,    4,    3,    2,    1,   36,    0,    0,
			   35,    0,    0,    0,    0,    0,    0,    0,  -31,    0,
			  281,    0,    0,    0,    0,    0,    0,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    2,    1,    0,    0,
			    0,   34,   36,    0,    0,   35,    0,    0,    0,    0,

			    0,    0,    0,    0,   33,    0,    0,    0,  155,    0,
			    0,    0,   36,    0,    0,   35,    0,    0,    0,   32,
			    0,    0,    0,    0,    0,    0,   34,    0,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   22,   21,   33,
			  -67,    0,    0,    0,    0,    0,   34,    0,    0,    0,
			    0,    0,    0,  330,   32,   36,    0,    0,    0,   33,
			    0,    0,    0,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   22,   21,   32,    0,    0,    0,    0,    0,
			    0,   13,  -67,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   22,   21,  -67,  -68,    0,  271,    0,    0,

			    0,    0,    0,    0,    0,    0,   13,    0,    0,  270,
			    0,  -67,  -67,  -67,  -67,  -67,  -67,  -67,  -67,  -67,
			  -67,  -67,   12,   13,    0,    0,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,  -68,  659,   36,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  -68,
			    0,    0,   11,   10,    9,    8,    7,    6,    5,    4,
			    3,    2,    1,    0,    0,    0,  -68,  -68,  -68,  -68,
			  -68,  -68,  -68,  -68,  -68,  -68,  -68,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    2,    1,    0,    0,
			    0,    0,    0,    0,   11,   10,    9,    8,    7,    6,

			    5,    4,    3,    2,    1,    0,    0,    0,    0,    0,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   22,
			   21,  319,  318,  317,  316,  315,  314,  313,  312,  311,
			  310,  309,  308,  307,  306,  305,  304,  303,  220,  319,
			  318,  317,  316,  315,  314,  313,  312,  311,  310,  309,
			  308,  307,  306,  305,  304,  303,  220,  319,  318,  317,
			  316,  315,  314,  313,  312,  311,  310,  309,  308,  307,
			  306,  305,  304,  303,  220,    0,    0,    0,    0,    0,
			  812,  318,  317,  316,  315,  314,  313,  312,  311,  310,
			  309,  308,  307,  306,  305,  304,  303,  220,  477,  877,

			  319,  318,  317,  316,  315,  314,  313,  312,  311,  310,
			  309,  308,  307,  306,  305,  304,  303,  220,  319,  318,
			  317,  316,  315,  314,  313,  312,  311,  310,  309,  308,
			  307,  306,  305,  304,  303,  220,    0,    0,    0,    0,
			    0,  467,  383,  382,  381,  380,  379,  378,  377,  376,
			  375,  374,  373,  372,  371,  370,  369,  368,  367,  403,
			  366,  319,  318,  317,  316,  315,  314,  313,  312,  311,
			  310,  309,  308,  307,  306,  305,  304,  303,  220,  317,
			  316,  315,  314,  313,  312,  311,  310,  309,  308,  307,
			  306,  305,  304,  303,  220>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   18,   14,  174,  298,   18,   20,  250,  526,  171,
			   35,   14,   12,   18,   18,  512,  268,  208,   18,   55,
			   20,  510,  187,  249,  250,   14,  626,   18,   14,   14,
			   40,   26,   67,   33,   69,   35,   65,  685,  811,   40,
			  688,   14,   14,   61,   62,   61,   25,   40,   26,   37,
			  302,   69,   40,  826,   47,  655,   72,   14,   53,  158,
			   95,   56,   91,  162,   65,   32,   84,   34,   46,  168,
			  718,   83,  324,  325,   53,   65,   37,   56,   99,  100,
			   83,   26,  579,   25,   74,   46,   96,   37,    0,  188,
			  738,   41,   42,  582,   83,   40,   38,   83,   83,  705,

			  333,  749,   65,   71,  140,  141,   25,  713,  341,   77,
			   83,   83,  124,    0,   25,   65,  122,  123,  766,   38,
			   70,  124,  619,   25,   74,   93,   83,   38,   78,  135,
			  136,  143,   26,  150,   63,  124,   65,  150,  124,  124,
			  143,  185,   40,   26,   38,  150,  150,   45,   65,   14,
			  150,  124,  124,  165,  143,   38,   39,  143,  143,  150,
			   40,  205,  165,   47,   63,  178,   65,  124,   74,   49,
			  143,  143,  139,   79,   25,  175,  165,   26,   40,  165,
			  165,   14,   14,   45,   39,   40,  143,  199,   64,   38,
			   39,   63,  165,  165,    3,   29,  199,   31,  210,  432,

			  433,   29,  435,   31,  204,    3,  449,  210,  165,   46,
			  199,   41,   42,  213,  199,  733,   47,   14,   83,   40,
			  654,  210,  656,  449,   45,  210,  199,  199,    3,  196,
			  847,  848,  849,  850,    3,   65,   65,  210,  210,  338,
			   70,  493,  199,  434,   74,   39,   40,   25,   78,  261,
			   83,   83,   65,  210,  266,  255,  256,  257,  261,  124,
			   47,   48,  101,  266,  455,   47,   48,  267,  268,   14,
			   63,  436,  261,   99,  507,  261,  261,  266,  143,   35,
			  266,  266,   47,   48,   47,   48,   83,   47,  261,  261,
			   37,  124,  124,  266,  266,   47,   48,  264,  298,   47,

			  165,   47,  302,  347,  261,   47,   48,   47,   48,  266,
			  143,  143,   47,   48,  281,   47,   63,   64,   65,   66,
			   47,  321,   47,   48,  324,  325,   47,  124,   47,  520,
			   47,   78,  165,  165,  199,   47,   48,   47,   83,  295,
			   47,   48,   20,   21,   91,  210,  143,   47,   47,  349,
			  350,  351,   99,  100,  101,  355,   16,   17,   18,   19,
			   20,   21,   65,  330,   25,   26,  199,  199,  165,   63,
			   64,   65,   66,   41,   42,   25,  100,  210,  210,  124,
			   25,   25,  573,  574,   78,   65,   25,  343,  344,  389,
			   26,   37,  686,   78,  696,   65,  261,   91,  143,  693,

			   37,  266,  199,  359,   91,   99,  100,  101,   96,   65,
			   27,   66,  577,  210,   70,   81,   72,  719,   74,   90,
			  165,   63,   78,  725,   49,   83,   74,   65,  261,  261,
			  474,  530,   65,  266,  266,   94,   48,  481,  482,  483,
			  484,  485,  486,  487,  488,  489,  490,  491,   61,   62,
			   65,   65,   26,   68,  199,   33,   69,  469,   26,   47,
			   47,  461,   47,   47,  261,  210,  469,   47,   81,  266,
			  772,   84,  428,   88,   89,   47,   65,   47,   47,   94,
			  469,   70,   97,   72,  469,   74,   47,   65,   47,   78,
			   47,   47,  492,  493,  494,   74,  469,  469,   45,  664,

			   65,  803,   88,   40,  669,   48,   47,  463,  464,  465,
			   85,   25,  469,   39,  816,   97,  261,  473,   72,   65,
			   55,  266,   46,   40,  480,  525,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  537,  538,   47,
			   25,   38,   78,   25,   27,  707,  711,   25,   68,  851,
			   65,   45,  519,  855,   40,   85,  556,   85,   41,   42,
			   85,   70,   85,   85,   85,   44,   85,  611,  612,   85,
			   47,   47,   85,   85,   85,  877,   47,   47,   40,  591,
			   49,  883,   65,   25,   25,  103,   25,   70,  591,  589,
			   41,   74,   37,   76,   26,   78,  695,   46,   33,   49,

			   83,   76,  591,   50,  469,  591,  591,   40,  625,  771,
			   48,   47,  625,   35,  570,  714,  787,   69,  591,  591,
			  625,  625,   29,   29,   58,  724,  626,   46,   65,   33,
			   39,  524,  632,  329,  591,  594,  469,  469,  329,  595,
			  596,  653,   46,  517,  693,  329,  660,  442,  212,  589,
			  653,  469,  652,  706,  199,  655,  827,  671,  573,  658,
			  660,  631,  824,  737,  653,  737,  195,  653,  653,  737,
			  737,  671,  469,  844,  553,  737,  737,  737,  737,  852,
			  653,  653,  461,  713,  191,  339,  686,  506,   92,  841,
			  702,  452,  797,  693,  625,  794,  653,  150,  253,  702,

			  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  461,   -1,  702,  737,   -1,  702,  702,   -1,   -1,
			   -1,   -1,  821,  822,  469,   -1,  591,   -1,   -1,  702,
			  702,   -1,   -1,   -1,   -1,   -1,   -1,  737,  750,   -1,
			  752,   -1,  841,   -1,   -1,  702,   -1,  750,   -1,  752,
			   -1,  751,   -1,   -1,   -1,   -1,   -1,   -1,  591,  591,
			   -1,  750,   -1,  752,   -1,  750,  752,  752,   -1,   -1,
			   -1,   -1,   -1,   -1,  786,   -1,   -1,  750,  750,  752,
			  752,   -1,   -1,  786,   -1,   -1,   -1,   -1,  653,   -1,
			  815,   -1,   -1,  750,  591,  752,   -1,  786,  815,  799,

			  786,  786,   -1,   14,   15,   -1,   -1,   -1,   -1,   -1,
			   -1,  811,   -1,  786,  786,  815,   -1,   -1,   29,   30,
			  653,  653,   33,  848,  849,  850,  826,  852,   -1,  786,
			  847,  848,   -1,  850,  846,  852,   -1,  702,   -1,   -1,
			   -1,   -1,   -1,  846,   -1,   -1,  591,  847,  848,  849,
			  850,   -1,  852,   -1,   -1,   -1,  653,  846,   -1,   70,
			  846,  846,   -1,   -1,   -1,   -1,   -1,   33,   -1,  702,
			  702,   14,   15,  846,  846,   -1,   -1,   -1,   -1,   -1,
			   46,   -1,   -1,   -1,  884,  750,   29,  752,   -1,  846,
			   33,   -1,   -1,  104,  105,  106,  107,  108,  109,  110,

			  111,  112,  113,  114,  192,  702,   -1,   -1,  653,   14,
			   15,   16,   17,   18,   19,   20,   21,  750,  750,  752,
			  752,  786,   -1,   -1,   -1,   -1,   -1,   70,  216,  217,
			   -1,  219,   -1,  221,  222,   -1,   -1,   -1,  104,  105,
			  106,  107,  108,  109,  110,  233,  112,  113,  114,   -1,
			   -1,   -1,   -1,  786,  786,  752,   -1,  702,   -1,   -1,
			   -1,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   -1,   -1,  262,   -1,   -1,   14,   15,   -1,
			   -1,  846,   -1,   -1,   -1,  273,  231,   -1,   -1,  786,
			   -1,   -1,   29,   -1,   -1,   -1,   33,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,  750,   -1,  752,   -1,   -1,
			   -1,   -1,   -1,  846,  846,  303,  304,  305,  306,  307,
			  308,  309,  310,  311,  312,  313,  314,  315,  316,  317,
			  318,  319,  320,  278,   -1,   -1,   -1,   -1,   -1,  327,
			   -1,  786,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  846,
			   -1,  296,  297,   -1,  299,  300,  301,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  354,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  323,   41,
			   42,   43,   44,   45,   46,   47,   48,   49,   50,   51,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  387,

			   -1,  846,   -1,   -1,   -1,   -1,   -1,   -1,  353,   -1,
			   -1,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   -1,
			   -1,   -1,   -1,  421,   -1,   -1,  424,   -1,   -1,   -1,
			  385,   -1,  104,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,  119,   -1,   -1,
			   -1,   -1,   -1,  408,  409,  410,  411,  412,  413,  414,
			  415,  416,  417,  418,  419,  420,   -1,  422,  423,   -1,
			  425,  426,  427,   -1,   -1,   -1,  431,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   14,   15,   -1,

			   -1,   -1,   -1,   -1,   21,   22,   23,   24,  101,   26,
			   -1,   -1,   29,   30,   31,   32,   33,   34,   35,   -1,
			   -1,   38,   -1,   -1,   41,  470,   43,   -1,   -1,   46,
			   -1,   48,   -1,  478,   51,   52,   -1,   54,   -1,   -1,
			   -1,   -1,   59,   -1,   -1,   -1,   63,   -1,   -1,   -1,
			   -1,  496,  497,   70,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   33,   32,   -1,   -1,  553,   -1,   -1,   85,   86,
			   -1,   -1,   -1,   -1,   -1,   92,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   32,   -1,  102,  248,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,

			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			   92,   -1,  284,  285,  286,  287,  288,  289,  290,  291,
			  292,  293,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   -1,  632,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,  132,  133,  134,  135,  136,  116,   -1,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,  676,   -1,
			   28,   -1,   -1,   -1,   -1,   33,   -1,   -1,   32,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   45,   -1,   -1,   -1,   -1,   -1,  662,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,  681,   75,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   87,
			   -1,   -1,   -1,   -1,  742,   -1,   -1,   -1,  746,   -1,
			   -1,   -1,   -1,   -1,   -1,  753,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   -1,   -1,   -1,
			  768,  769,  116,   -1,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,

			  134,  135,  136,   -1,  792,  793,   -1,   -1,   -1,   -1,
			   96,  799,   -1,   -1,   -1,   -1,   -1,   -1,   30,   -1,
			  765,   33,   -1,   -1,   -1,  770,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   -1,   -1,  791,   -1,   -1,  837,
			  838,   -1,   -1,   -1,   -1,   -1,  801,  802,   70,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  813,  814,
			  858,   -1,   -1,   -1,  819,   -1,   -1,   -1,  540,  541,
			  542,  543,  544,  545,  546,  547,  548,  549,  550,  551,
			   -1,   33,  104,  105,  106,  107,  108,  109,  110,  111,

			  112,  113,  114,   -1,   14,   15,   -1,   -1,  853,  854,
			   -1,   21,   22,   23,   24,   -1,   26,   59,   96,   29,
			   30,   31,   32,   33,   34,   35,   -1,   -1,   38,   -1,
			   -1,   41,   -1,   43,   -1,  880,   46,   -1,   48,   -1,
			   -1,   51,   52,   -1,   54,   -1,   -1,   -1,   -1,   59,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   70,   -1,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   -1,   -1,   85,   86,   -1,   -1,   -1,
			   -1,   -1,   92,   -1,   -1,   -1,   96,   -1,   -1,   -1,
			   -1,   -1,  102,   -1,  104,  105,  106,  107,  108,  109,

			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,  132,  133,  134,  135,  136,   14,   15,   -1,
			   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,   26,
			   -1,   -1,   29,   30,   31,   32,   33,   34,   35,   -1,
			   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   45,   46,
			   -1,   48,   61,   62,   51,   52,   65,   54,   -1,   -1,
			   69,   -1,   59,   -1,   -1,   74,   -1,   -1,   -1,   -1,
			   -1,   -1,   81,   70,   -1,   84,   -1,   -1,   -1,   -1,
			   -1,   -1,   91,   -1,   -1,   -1,   -1,   -1,   85,   86,

			   99,  100,   -1,   -1,   -1,   92,   -1,   -1,   -1,   -1,
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
			   51,   52,   -1,   54,   -1,   14,   15,   -1,   59,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   70,
			   29,   30,   31,   32,   33,   34,   35,   -1,   37,   -1,
			   -1,   -1,   41,   -1,   85,   86,   -1,   -1,   -1,   -1,
			   -1,   92,   51,   52,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  102,   -1,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,   14,   15,
			   -1,   33,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   29,   30,   31,   32,   33,   34,   35,
			   -1,   -1,   -1,   -1,   -1,   41,   -1,   -1,   -1,   61,
			   62,   -1,   -1,   -1,   -1,   51,   52,   69,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   81,
			   -1,   83,   84,   -1,   -1,   -1,   -1,   -1,   90,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   33,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   -1,   -1,   47,   -1,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,   14,   15,   -1,   -1,   -1,   -1,   -1,   26,   -1,
			   -1,   -1,   -1,   -1,   -1,   33,   29,   30,   31,   32,
			   -1,   34,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   -1,   -1,   -1,   -1,   -1,   51,   52,

			   -1,   59,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   75,   -1,   -1,
			   -1,   74,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   87,
			   -1,   -1,   -1,   -1,   92,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   98,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   -1,   -1,   -1,
			   -1,   -1,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,   26,   -1,   -1,   -1,   -1,   -1,
			   -1,   33,   -1,   35,   -1,   -1,   -1,   -1,   -1,   41,

			   -1,   -1,   -1,   -1,   46,   -1,   -1,   26,   -1,   -1,
			   -1,   -1,   -1,   -1,   33,   57,   -1,   59,   60,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   46,   70,   -1,
			   -1,   73,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   59,   -1,   -1,   85,   -1,   -1,   -1,   -1,   33,   -1,
			   92,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   92,   -1,   33,   61,   62,   -1,   -1,
			   -1,   -1,   -1,  102,   69,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,   81,   -1,   83,   84,

			   58,   -1,   -1,   61,   -1,   90,   33,   65,   -1,   67,
			   -1,   69,   -1,   -1,   72,   -1,   -1,   -1,   -1,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			   -1,   58,   -1,   -1,   61,   -1,   -1,   95,   65,   -1,
			   67,   -1,   69,   -1,   -1,   72,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   33,   -1,   -1,
			   36,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   95,   -1,
			   46,   -1,   -1,   -1,   -1,   -1,   -1,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,   -1,   -1,
			   -1,   67,   33,   -1,   -1,   36,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   80,   -1,   -1,   -1,   49,   -1,
			   -1,   -1,   33,   -1,   -1,   36,   -1,   -1,   -1,   95,
			   -1,   -1,   -1,   -1,   -1,   -1,   67,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   80,
			   33,   -1,   -1,   -1,   -1,   -1,   67,   -1,   -1,   -1,
			   -1,   -1,   -1,   46,   95,   33,   -1,   -1,   -1,   80,
			   -1,   -1,   -1,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,   95,   -1,   -1,   -1,   -1,   -1,
			   -1,   33,   75,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,   87,   33,   -1,   75,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   33,   -1,   -1,   87,
			   -1,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   74,   33,   -1,   -1,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   75,   65,   33,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   87,
			   -1,   -1,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   -1,   -1,   -1,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,   -1,   -1,
			   -1,   -1,   -1,   -1,  104,  105,  106,  107,  108,  109,

			  110,  111,  112,  113,  114,   -1,   -1,   -1,   -1,   -1,
			  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,    4,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   -1,   -1,   -1,   -1,   -1,
			   45,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   45,   82,

			    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   -1,   -1,   -1,   -1,
			   -1,   45,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,   45,
			  136,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21>>)
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

	yyFinal: INTEGER is 890
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 137
			-- Number of tokens

	yyLast: INTEGER is 2994
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
