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
--|#line 207
	yy_do_action_11
when 12 then
--|#line 211
	yy_do_action_12
when 13 then
--|#line 215
	yy_do_action_13
when 14 then
--|#line 219
	yy_do_action_14
when 15 then
--|#line 223
	yy_do_action_15
when 16 then
--|#line 227
	yy_do_action_16
when 17 then
--|#line 231
	yy_do_action_17
when 19 then
--|#line 241
	yy_do_action_19
when 21 then
--|#line 247
	yy_do_action_21
when 22 then
--|#line 252
	yy_do_action_22
when 23 then
--|#line 259
	yy_do_action_23
when 24 then
--|#line 263
	yy_do_action_24
when 26 then
--|#line 269
	yy_do_action_26
when 27 then
--|#line 274
	yy_do_action_27
when 28 then
--|#line 279
	yy_do_action_28
when 29 then
--|#line 286
	yy_do_action_29
when 30 then
--|#line 288
	yy_do_action_30
when 31 then
--|#line 296
	yy_do_action_31
when 32 then
--|#line 302
	yy_do_action_32
when 33 then
--|#line 308
	yy_do_action_33
when 34 then
--|#line 314
	yy_do_action_34
when 36 then
--|#line 328
	yy_do_action_36
when 38 then
--|#line 338
	yy_do_action_38
when 39 then
--|#line 347
	yy_do_action_39
when 40 then
--|#line 352
	yy_do_action_40
when 42 then
--|#line 361
	yy_do_action_42
when 43 then
--|#line 365
	yy_do_action_43
when 44 then
--|#line 365
	yy_do_action_44
when 46 then
--|#line 376
	yy_do_action_46
when 47 then
--|#line 380
	yy_do_action_47
when 48 then
--|#line 385
	yy_do_action_48
when 49 then
--|#line 389
	yy_do_action_49
when 50 then
--|#line 394
	yy_do_action_50
when 51 then
--|#line 401
	yy_do_action_51
when 52 then
--|#line 406
	yy_do_action_52
when 55 then
--|#line 417
	yy_do_action_55
when 56 then
--|#line 421
	yy_do_action_56
when 57 then
--|#line 423
	yy_do_action_57
when 58 then
--|#line 430
	yy_do_action_58
when 59 then
--|#line 434
	yy_do_action_59
when 60 then
--|#line 436
	yy_do_action_60
when 61 then
--|#line 440
	yy_do_action_61
when 62 then
--|#line 442
	yy_do_action_62
when 63 then
--|#line 444
	yy_do_action_63
when 64 then
--|#line 448
	yy_do_action_64
when 65 then
--|#line 453
	yy_do_action_65
when 66 then
--|#line 457
	yy_do_action_66
when 68 then
--|#line 463
	yy_do_action_68
when 69 then
--|#line 467
	yy_do_action_69
when 70 then
--|#line 469
	yy_do_action_70
when 71 then
--|#line 471
	yy_do_action_71
when 73 then
--|#line 481
	yy_do_action_73
when 75 then
--|#line 487
	yy_do_action_75
when 76 then
--|#line 492
	yy_do_action_76
when 77 then
--|#line 499
	yy_do_action_77
when 78 then
--|#line 501
	yy_do_action_78
when 79 then
--|#line 508
	yy_do_action_79
when 80 then
--|#line 513
	yy_do_action_80
when 81 then
--|#line 518
	yy_do_action_81
when 82 then
--|#line 523
	yy_do_action_82
when 83 then
--|#line 528
	yy_do_action_83
when 84 then
--|#line 533
	yy_do_action_84
when 85 then
--|#line 538
	yy_do_action_85
when 87 then
--|#line 547
	yy_do_action_87
when 88 then
--|#line 551
	yy_do_action_88
when 89 then
--|#line 556
	yy_do_action_89
when 90 then
--|#line 563
	yy_do_action_90
when 92 then
--|#line 569
	yy_do_action_92
when 93 then
--|#line 573
	yy_do_action_93
when 95 then
--|#line 579
	yy_do_action_95
when 96 then
--|#line 584
	yy_do_action_96
when 97 then
--|#line 591
	yy_do_action_97
when 98 then
--|#line 595
	yy_do_action_98
when 99 then
--|#line 597
	yy_do_action_99
when 100 then
--|#line 601
	yy_do_action_100
when 101 then
--|#line 606
	yy_do_action_101
when 103 then
--|#line 615
	yy_do_action_103
when 105 then
--|#line 621
	yy_do_action_105
when 107 then
--|#line 627
	yy_do_action_107
when 109 then
--|#line 633
	yy_do_action_109
when 111 then
--|#line 639
	yy_do_action_111
when 113 then
--|#line 645
	yy_do_action_113
when 115 then
--|#line 655
	yy_do_action_115
when 117 then
--|#line 661
	yy_do_action_117
when 118 then
--|#line 665
	yy_do_action_118
when 119 then
--|#line 670
	yy_do_action_119
when 120 then
--|#line 677
	yy_do_action_120
when 121 then
--|#line 681
	yy_do_action_121
when 122 then
--|#line 686
	yy_do_action_122
when 123 then
--|#line 693
	yy_do_action_123
when 124 then
--|#line 695
	yy_do_action_124
when 126 then
--|#line 701
	yy_do_action_126
when 127 then
--|#line 705
	yy_do_action_127
when 128 then
--|#line 705
	yy_do_action_128
when 129 then
--|#line 712
	yy_do_action_129
when 130 then
--|#line 714
	yy_do_action_130
when 131 then
--|#line 716
	yy_do_action_131
when 132 then
--|#line 720
	yy_do_action_132
when 133 then
--|#line 724
	yy_do_action_133
when 134 then
--|#line 724
	yy_do_action_134
when 136 then
--|#line 732
	yy_do_action_136
when 137 then
--|#line 736
	yy_do_action_137
when 138 then
--|#line 738
	yy_do_action_138
when 140 then
--|#line 744
	yy_do_action_140
when 142 then
--|#line 750
	yy_do_action_142
when 143 then
--|#line 754
	yy_do_action_143
when 144 then
--|#line 759
	yy_do_action_144
when 145 then
--|#line 766
	yy_do_action_145
when 148 then
--|#line 774
	yy_do_action_148
when 149 then
--|#line 776
	yy_do_action_149
when 150 then
--|#line 778
	yy_do_action_150
when 151 then
--|#line 780
	yy_do_action_151
when 152 then
--|#line 782
	yy_do_action_152
when 153 then
--|#line 784
	yy_do_action_153
when 154 then
--|#line 786
	yy_do_action_154
when 155 then
--|#line 788
	yy_do_action_155
when 156 then
--|#line 790
	yy_do_action_156
when 157 then
--|#line 792
	yy_do_action_157
when 159 then
--|#line 798
	yy_do_action_159
when 160 then
--|#line 798
	yy_do_action_160
when 161 then
--|#line 805
	yy_do_action_161
when 162 then
--|#line 805
	yy_do_action_162
when 164 then
--|#line 816
	yy_do_action_164
when 165 then
--|#line 816
	yy_do_action_165
when 166 then
--|#line 823
	yy_do_action_166
when 167 then
--|#line 823
	yy_do_action_167
when 169 then
--|#line 834
	yy_do_action_169
when 170 then
--|#line 843
	yy_do_action_170
when 171 then
--|#line 848
	yy_do_action_171
when 172 then
--|#line 855
	yy_do_action_172
when 173 then
--|#line 859
	yy_do_action_173
when 174 then
--|#line 861
	yy_do_action_174
when 176 then
--|#line 871
	yy_do_action_176
when 177 then
--|#line 873
	yy_do_action_177
when 178 then
--|#line 877
	yy_do_action_178
when 179 then
--|#line 879
	yy_do_action_179
when 180 then
--|#line 881
	yy_do_action_180
when 181 then
--|#line 883
	yy_do_action_181
when 182 then
--|#line 885
	yy_do_action_182
when 183 then
--|#line 887
	yy_do_action_183
when 184 then
--|#line 891
	yy_do_action_184
when 185 then
--|#line 893
	yy_do_action_185
when 186 then
--|#line 895
	yy_do_action_186
when 187 then
--|#line 897
	yy_do_action_187
when 188 then
--|#line 899
	yy_do_action_188
when 189 then
--|#line 901
	yy_do_action_189
when 190 then
--|#line 903
	yy_do_action_190
when 191 then
--|#line 905
	yy_do_action_191
when 194 then
--|#line 913
	yy_do_action_194
when 195 then
--|#line 917
	yy_do_action_195
when 196 then
--|#line 922
	yy_do_action_196
when 198 then
--|#line 935
	yy_do_action_198
when 200 then
--|#line 941
	yy_do_action_200
when 201 then
--|#line 945
	yy_do_action_201
when 202 then
--|#line 950
	yy_do_action_202
when 203 then
--|#line 957
	yy_do_action_203
when 204 then
--|#line 957
	yy_do_action_204
when 206 then
--|#line 969
	yy_do_action_206
when 208 then
--|#line 975
	yy_do_action_208
when 209 then
--|#line 983
	yy_do_action_209
when 211 then
--|#line 992
	yy_do_action_211
when 212 then
--|#line 996
	yy_do_action_212
when 213 then
--|#line 1001
	yy_do_action_213
when 214 then
--|#line 1008
	yy_do_action_214
when 216 then
--|#line 1014
	yy_do_action_216
when 217 then
--|#line 1018
	yy_do_action_217
when 219 then
--|#line 1027
	yy_do_action_219
when 220 then
--|#line 1031
	yy_do_action_220
when 221 then
--|#line 1036
	yy_do_action_221
when 222 then
--|#line 1043
	yy_do_action_222
when 223 then
--|#line 1047
	yy_do_action_223
when 224 then
--|#line 1052
	yy_do_action_224
when 225 then
--|#line 1059
	yy_do_action_225
when 226 then
--|#line 1061
	yy_do_action_226
when 227 then
--|#line 1063
	yy_do_action_227
when 228 then
--|#line 1065
	yy_do_action_228
when 229 then
--|#line 1067
	yy_do_action_229
when 230 then
--|#line 1069
	yy_do_action_230
when 231 then
--|#line 1071
	yy_do_action_231
when 232 then
--|#line 1073
	yy_do_action_232
when 233 then
--|#line 1075
	yy_do_action_233
when 234 then
--|#line 1077
	yy_do_action_234
when 236 then
--|#line 1083
	yy_do_action_236
when 237 then
--|#line 1092
	yy_do_action_237
when 239 then
--|#line 1101
	yy_do_action_239
when 241 then
--|#line 1107
	yy_do_action_241
when 242 then
--|#line 1107
	yy_do_action_242
when 244 then
--|#line 1119
	yy_do_action_244
when 245 then
--|#line 1121
	yy_do_action_245
when 246 then
--|#line 1125
	yy_do_action_246
when 249 then
--|#line 1136
	yy_do_action_249
when 250 then
--|#line 1140
	yy_do_action_250
when 251 then
--|#line 1145
	yy_do_action_251
when 252 then
--|#line 1152
	yy_do_action_252
when 254 then
--|#line 1158
	yy_do_action_254
when 255 then
--|#line 1167
	yy_do_action_255
when 256 then
--|#line 1169
	yy_do_action_256
when 257 then
--|#line 1173
	yy_do_action_257
when 258 then
--|#line 1175
	yy_do_action_258
when 260 then
--|#line 1181
	yy_do_action_260
when 261 then
--|#line 1185
	yy_do_action_261
when 262 then
--|#line 1190
	yy_do_action_262
when 263 then
--|#line 1197
	yy_do_action_263
when 264 then
--|#line 1202
	yy_do_action_264
when 265 then
--|#line 1207
	yy_do_action_265
when 266 then
--|#line 1214
	yy_do_action_266
when 267 then
--|#line 1218
	yy_do_action_267
when 268 then
--|#line 1220
	yy_do_action_268
when 269 then
--|#line 1222
	yy_do_action_269
when 271 then
--|#line 1226
	yy_do_action_271
when 273 then
--|#line 1232
	yy_do_action_273
when 274 then
--|#line 1236
	yy_do_action_274
when 275 then
--|#line 1241
	yy_do_action_275
when 276 then
--|#line 1248
	yy_do_action_276
when 277 then
--|#line 1250
	yy_do_action_277
when 278 then
--|#line 1252
	yy_do_action_278
when 279 then
--|#line 1254
	yy_do_action_279
when 280 then
--|#line 1256
	yy_do_action_280
when 281 then
--|#line 1258
	yy_do_action_281
when 282 then
--|#line 1260
	yy_do_action_282
when 283 then
--|#line 1262
	yy_do_action_283
when 284 then
--|#line 1264
	yy_do_action_284
when 285 then
--|#line 1266
	yy_do_action_285
when 286 then
--|#line 1268
	yy_do_action_286
when 287 then
--|#line 1272
	yy_do_action_287
when 288 then
--|#line 1274
	yy_do_action_288
when 289 then
--|#line 1276
	yy_do_action_289
when 290 then
--|#line 1280
	yy_do_action_290
when 291 then
--|#line 1282
	yy_do_action_291
when 293 then
--|#line 1288
	yy_do_action_293
when 294 then
--|#line 1292
	yy_do_action_294
when 295 then
--|#line 1294
	yy_do_action_295
when 297 then
--|#line 1300
	yy_do_action_297
when 298 then
--|#line 1308
	yy_do_action_298
when 299 then
--|#line 1310
	yy_do_action_299
when 300 then
--|#line 1312
	yy_do_action_300
when 301 then
--|#line 1314
	yy_do_action_301
when 302 then
--|#line 1316
	yy_do_action_302
when 303 then
--|#line 1318
	yy_do_action_303
when 304 then
--|#line 1320
	yy_do_action_304
when 305 then
--|#line 1324
	yy_do_action_305
when 306 then
--|#line 1335
	yy_do_action_306
when 307 then
--|#line 1337
	yy_do_action_307
when 308 then
--|#line 1339
	yy_do_action_308
when 309 then
--|#line 1341
	yy_do_action_309
when 310 then
--|#line 1343
	yy_do_action_310
when 311 then
--|#line 1345
	yy_do_action_311
when 312 then
--|#line 1347
	yy_do_action_312
when 313 then
--|#line 1349
	yy_do_action_313
when 314 then
--|#line 1351
	yy_do_action_314
when 315 then
--|#line 1353
	yy_do_action_315
when 316 then
--|#line 1355
	yy_do_action_316
when 317 then
--|#line 1357
	yy_do_action_317
when 318 then
--|#line 1359
	yy_do_action_318
when 319 then
--|#line 1361
	yy_do_action_319
when 320 then
--|#line 1363
	yy_do_action_320
when 321 then
--|#line 1365
	yy_do_action_321
when 322 then
--|#line 1367
	yy_do_action_322
when 323 then
--|#line 1369
	yy_do_action_323
when 324 then
--|#line 1371
	yy_do_action_324
when 325 then
--|#line 1373
	yy_do_action_325
when 326 then
--|#line 1375
	yy_do_action_326
when 327 then
--|#line 1377
	yy_do_action_327
when 328 then
--|#line 1379
	yy_do_action_328
when 329 then
--|#line 1381
	yy_do_action_329
when 330 then
--|#line 1383
	yy_do_action_330
when 331 then
--|#line 1385
	yy_do_action_331
when 332 then
--|#line 1387
	yy_do_action_332
when 333 then
--|#line 1389
	yy_do_action_333
when 334 then
--|#line 1391
	yy_do_action_334
when 335 then
--|#line 1393
	yy_do_action_335
when 336 then
--|#line 1395
	yy_do_action_336
when 337 then
--|#line 1397
	yy_do_action_337
when 338 then
--|#line 1401
	yy_do_action_338
when 339 then
--|#line 1403
	yy_do_action_339
when 340 then
--|#line 1405
	yy_do_action_340
when 341 then
--|#line 1407
	yy_do_action_341
when 342 then
--|#line 1409
	yy_do_action_342
when 343 then
--|#line 1413
	yy_do_action_343
when 344 then
--|#line 1421
	yy_do_action_344
when 345 then
--|#line 1423
	yy_do_action_345
when 346 then
--|#line 1425
	yy_do_action_346
when 347 then
--|#line 1427
	yy_do_action_347
when 348 then
--|#line 1429
	yy_do_action_348
when 349 then
--|#line 1431
	yy_do_action_349
when 350 then
--|#line 1433
	yy_do_action_350
when 351 then
--|#line 1435
	yy_do_action_351
when 352 then
--|#line 1437
	yy_do_action_352
when 353 then
--|#line 1439
	yy_do_action_353
when 354 then
--|#line 1443
	yy_do_action_354
when 355 then
--|#line 1447
	yy_do_action_355
when 356 then
--|#line 1451
	yy_do_action_356
when 357 then
--|#line 1455
	yy_do_action_357
when 358 then
--|#line 1459
	yy_do_action_358
when 359 then
--|#line 1463
	yy_do_action_359
when 360 then
--|#line 1465
	yy_do_action_360
when 361 then
--|#line 1467
	yy_do_action_361
when 362 then
--|#line 1469
	yy_do_action_362
when 363 then
--|#line 1471
	yy_do_action_363
when 364 then
--|#line 1473
	yy_do_action_364
when 365 then
--|#line 1475
	yy_do_action_365
when 366 then
--|#line 1477
	yy_do_action_366
when 367 then
--|#line 1479
	yy_do_action_367
when 368 then
--|#line 1481
	yy_do_action_368
when 369 then
--|#line 1483
	yy_do_action_369
when 370 then
--|#line 1487
	yy_do_action_370
when 371 then
--|#line 1489
	yy_do_action_371
when 372 then
--|#line 1493
	yy_do_action_372
when 373 then
--|#line 1495
	yy_do_action_373
when 374 then
--|#line 1499
	yy_do_action_374
when 375 then
--|#line 1512
	yy_do_action_375
when 378 then
--|#line 1520
	yy_do_action_378
when 379 then
--|#line 1524
	yy_do_action_379
when 380 then
--|#line 1529
	yy_do_action_380
when 381 then
--|#line 1536
	yy_do_action_381
when 382 then
--|#line 1538
	yy_do_action_382
when 383 then
--|#line 1542
	yy_do_action_383
when 384 then
--|#line 1547
	yy_do_action_384
when 385 then
--|#line 1558
	yy_do_action_385
when 386 then
--|#line 1560
	yy_do_action_386
when 387 then
--|#line 1562
	yy_do_action_387
when 388 then
--|#line 1564
	yy_do_action_388
when 389 then
--|#line 1566
	yy_do_action_389
when 390 then
--|#line 1568
	yy_do_action_390
when 391 then
--|#line 1570
	yy_do_action_391
when 392 then
--|#line 1572
	yy_do_action_392
when 393 then
--|#line 1576
	yy_do_action_393
when 394 then
--|#line 1578
	yy_do_action_394
when 395 then
--|#line 1580
	yy_do_action_395
when 396 then
--|#line 1582
	yy_do_action_396
when 397 then
--|#line 1584
	yy_do_action_397
when 398 then
--|#line 1586
	yy_do_action_398
when 399 then
--|#line 1590
	yy_do_action_399
when 400 then
--|#line 1592
	yy_do_action_400
when 401 then
--|#line 1594
	yy_do_action_401
when 402 then
--|#line 1604
	yy_do_action_402
when 403 then
--|#line 1606
	yy_do_action_403
when 404 then
--|#line 1608
	yy_do_action_404
when 405 then
--|#line 1612
	yy_do_action_405
when 406 then
--|#line 1614
	yy_do_action_406
when 407 then
--|#line 1618
	yy_do_action_407
when 408 then
--|#line 1625
	yy_do_action_408
when 409 then
--|#line 1635
	yy_do_action_409
when 410 then
--|#line 1645
	yy_do_action_410
when 411 then
--|#line 1658
	yy_do_action_411
when 412 then
--|#line 1660
	yy_do_action_412
when 413 then
--|#line 1662
	yy_do_action_413
when 414 then
--|#line 1669
	yy_do_action_414
when 415 then
--|#line 1673
	yy_do_action_415
when 416 then
--|#line 1675
	yy_do_action_416
when 417 then
--|#line 1679
	yy_do_action_417
when 418 then
--|#line 1681
	yy_do_action_418
when 419 then
--|#line 1683
	yy_do_action_419
when 420 then
--|#line 1685
	yy_do_action_420
when 421 then
--|#line 1687
	yy_do_action_421
when 422 then
--|#line 1689
	yy_do_action_422
when 423 then
--|#line 1691
	yy_do_action_423
when 424 then
--|#line 1693
	yy_do_action_424
when 425 then
--|#line 1695
	yy_do_action_425
when 426 then
--|#line 1697
	yy_do_action_426
when 427 then
--|#line 1699
	yy_do_action_427
when 428 then
--|#line 1701
	yy_do_action_428
when 429 then
--|#line 1703
	yy_do_action_429
when 430 then
--|#line 1705
	yy_do_action_430
when 431 then
--|#line 1707
	yy_do_action_431
when 432 then
--|#line 1709
	yy_do_action_432
when 433 then
--|#line 1711
	yy_do_action_433
when 434 then
--|#line 1713
	yy_do_action_434
when 435 then
--|#line 1715
	yy_do_action_435
when 436 then
--|#line 1717
	yy_do_action_436
when 437 then
--|#line 1721
	yy_do_action_437
when 438 then
--|#line 1723
	yy_do_action_438
when 439 then
--|#line 1725
	yy_do_action_439
when 440 then
--|#line 1727
	yy_do_action_440
when 441 then
--|#line 1731
	yy_do_action_441
when 442 then
--|#line 1733
	yy_do_action_442
when 443 then
--|#line 1735
	yy_do_action_443
when 444 then
--|#line 1737
	yy_do_action_444
when 445 then
--|#line 1739
	yy_do_action_445
when 446 then
--|#line 1741
	yy_do_action_446
when 447 then
--|#line 1743
	yy_do_action_447
when 448 then
--|#line 1745
	yy_do_action_448
when 449 then
--|#line 1747
	yy_do_action_449
when 450 then
--|#line 1749
	yy_do_action_450
when 451 then
--|#line 1751
	yy_do_action_451
when 452 then
--|#line 1753
	yy_do_action_452
when 453 then
--|#line 1755
	yy_do_action_453
when 454 then
--|#line 1757
	yy_do_action_454
when 455 then
--|#line 1759
	yy_do_action_455
when 456 then
--|#line 1761
	yy_do_action_456
when 457 then
--|#line 1763
	yy_do_action_457
when 458 then
--|#line 1765
	yy_do_action_458
when 459 then
--|#line 1769
	yy_do_action_459
when 460 then
--|#line 1773
	yy_do_action_460
when 461 then
--|#line 1777
	yy_do_action_461
when 462 then
--|#line 1781
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
				root_node := new_class_description (yytype83 (yyvs.item (yyvsp - 8)),
					is_deferred, is_expanded, is_separate,
					yytype72 (yyvs.item (yyvsp - 11)), yytype72 (yyvs.item (yyvsp - 1)), yytype70 (yyvs.item (yyvsp - 7)), yytype76 (yyvs.item (yyvsp - 5)), yytype62 (yyvs.item (yyvsp - 4)), yytype67 (yyvs.item (yyvsp - 3)), yytype39 (yyvs.item (yyvsp - 2)), suppliers, yytype54 (yyvs.item (yyvsp - 6)), click_list,
					current_position.start_position)
			

		end

	yy_do_action_2 is
			--|#line 185
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_3 is
			--|#line 187
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_4 is
			--|#line 189
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_5 is
			--|#line 191
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_6 is
			--|#line 193
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_7 is
			--|#line 195
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_8 is
			--|#line 197
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_9 is
			--|#line 199
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := yytype83 (yyvs.item (yyvsp)) 
			yyval := yyval83
		end

	yy_do_action_10 is
			--|#line 203
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_id_as (token_buffer)) 
			yyval := yyval83
		end

	yy_do_action_11 is
			--|#line 207
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_boolean_id_as) 
			yyval := yyval83
		end

	yy_do_action_12 is
			--|#line 211
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_character_id_as) 
			yyval := yyval83
		end

	yy_do_action_13 is
			--|#line 215
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_double_id_as) 
			yyval := yyval83
		end

	yy_do_action_14 is
			--|#line 219
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_integer_id_as) 
			yyval := yyval83
		end

	yy_do_action_15 is
			--|#line 223
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_none_id_as) 
			yyval := yyval83
		end

	yy_do_action_16 is
			--|#line 227
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_pointer_id_as) 
			yyval := yyval83
		end

	yy_do_action_17 is
			--|#line 231
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_real_id_as) 
			yyval := yyval83
		end

	yy_do_action_19 is
			--|#line 241
		local
			yyval72: EIFFEL_LIST [INDEX_AS]
		do

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_21 is
			--|#line 247
		local
			yyval72: EIFFEL_LIST [INDEX_AS]
		do

				yyval72 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval72.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval72
		end

	yy_do_action_22 is
			--|#line 252
		local
			yyval72: EIFFEL_LIST [INDEX_AS]
		do

				yyval72 := yytype72 (yyvs.item (yyvsp - 1))
				yyval72.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval72
		end

	yy_do_action_23 is
			--|#line 259
		local
			yyval32: INDEX_AS
		do

yyval32 := new_index_as (yytype30 (yyvs.item (yyvsp - 2)), yytype60 (yyvs.item (yyvsp - 1))) 
			yyval := yyval32
		end

	yy_do_action_24 is
			--|#line 263
		local
			yyval30: ID_AS
		do

yyval30 := yytype30 (yyvs.item (yyvsp - 1)) 
			yyval := yyval30
		end

	yy_do_action_26 is
			--|#line 269
		local
			yyval60: EIFFEL_LIST [ATOMIC_AS]
		do

				yyval60 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval60.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval60
		end

	yy_do_action_27 is
			--|#line 274
		local
			yyval60: EIFFEL_LIST [ATOMIC_AS]
		do

				yyval60 := yytype60 (yyvs.item (yyvsp - 2))
				yyval60.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval60
		end

	yy_do_action_28 is
			--|#line 279
		local
			yyval60: EIFFEL_LIST [ATOMIC_AS]
		do

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval60 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval60
		end

	yy_do_action_29 is
			--|#line 286
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype30 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_30 is
			--|#line 288
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_31 is
			--|#line 296
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_32 is
			--|#line 302
		local

		do
			yyval := yyval_default;
				is_deferred := True
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_33 is
			--|#line 308
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := True
				is_separate := False
			

		end

	yy_do_action_34 is
			--|#line 314
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := True
			

		end

	yy_do_action_36 is
			--|#line 328
		local
			yyval54: STRING_AS
		do

yyval54 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval54
		end

	yy_do_action_38 is
			--|#line 338
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
			--|#line 347
		local
			yyval67: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval67 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval67, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_40 is
			--|#line 352
		local
			yyval67: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval67 := yytype67 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval67, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_42 is
			--|#line 361
		local
			yyval27: FEATURE_CLAUSE_AS
		do

yyval27 := new_feature_clause_as (yytype14 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval27
		end

	yy_do_action_43 is
			--|#line 365
		local
			yyval14: CLIENT_AS
		do

yyval14 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval14
		end

	yy_do_action_44 is
			--|#line 365
		local

		do
			yyval := yyval_default;
				inherit_context := False
				fclause_pos := current_position.end_position
			

		end

	yy_do_action_46 is
			--|#line 376
		local
			yyval14: CLIENT_AS
		do

yyval14 := new_client_as (yytype71 (yyvs.item (yyvsp))) 
			yyval := yyval14
		end

	yy_do_action_47 is
			--|#line 380
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := new_eiffel_list_id_as (1)
				yyval71.extend (new_none_id_as)
			
			yyval := yyval71
		end

	yy_do_action_48 is
			--|#line 385
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

yyval71 := yytype71 (yyvs.item (yyvsp - 1)) 
			yyval := yyval71
		end

	yy_do_action_49 is
			--|#line 389
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval71.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_50 is
			--|#line 394
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_51 is
			--|#line 401
		local
			yyval66: EIFFEL_LIST [FEATURE_AS]
		do

				yyval66 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval66.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_52 is
			--|#line 406
		local
			yyval66: EIFFEL_LIST [FEATURE_AS]
		do

				yyval66 := yytype66 (yyvs.item (yyvsp - 1))
				yyval66.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_55 is
			--|#line 417
		local
			yyval26: FEATURE_AS
		do

yyval26 := new_feature_declaration (yytype86 (yyvs.item (yyvsp - 2)), yytype8 (yyvs.item (yyvsp - 1))) 
			yyval := yyval26
		end

	yy_do_action_56 is
			--|#line 421
		local
			yyval86: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

yyval86 := new_clickable_feature_name_list (yytype84 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval86
		end

	yy_do_action_57 is
			--|#line 423
		local
			yyval86: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

				yyval86 := yytype86 (yyvs.item (yyvsp - 2))
				yyval86.first.extend (yytype84 (yyvs.item (yyvsp)).first)
			
			yyval := yyval86
		end

	yy_do_action_58 is
			--|#line 430
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_59 is
			--|#line 434
		local

		do
			yyval := yyval_default;
is_frozen := False 

		end

	yy_do_action_60 is
			--|#line 436
		local

		do
			yyval := yyval_default;
is_frozen := True 

		end

	yy_do_action_61 is
			--|#line 440
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval84 := new_clickable_feature_name (yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval84
		end

	yy_do_action_62 is
			--|#line 442
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_63 is
			--|#line 444
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_64 is
			--|#line 448
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval84 := new_clickable_infix (yytype85 (yyvs.item (yyvsp))) 
			yyval := yyval84
		end

	yy_do_action_65 is
			--|#line 453
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval84 := new_clickable_prefix (yytype85 (yyvs.item (yyvsp))) 
			yyval := yyval84
		end

	yy_do_action_66 is
			--|#line 457
		local
			yyval8: BODY_AS
		do

yyval8 := new_declaration_body (yytype81 (yyvs.item (yyvsp - 2)), yytype57 (yyvs.item (yyvsp - 1)), yytype15 (yyvs.item (yyvsp))) 
			yyval := yyval8
		end

	yy_do_action_68 is
			--|#line 463
		local
			yyval15: CONTENT_AS
		do

yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_69 is
			--|#line 467
		local
			yyval15: CONTENT_AS
		do

yyval15 := new_constant_as (new_value_as (yytype6 (yyvs.item (yyvsp)))) 
			yyval := yyval15
		end

	yy_do_action_70 is
			--|#line 469
		local
			yyval15: CONTENT_AS
		do

yyval15 := new_constant_as (new_value_as (new_unique_as)) 
			yyval := yyval15
		end

	yy_do_action_71 is
			--|#line 471
		local
			yyval15: CONTENT_AS
		do

yyval15 := yytype52 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_73 is
			--|#line 481
		local
			yyval76: EIFFEL_LIST [PARENT_AS]
		do

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_75 is
			--|#line 487
		local
			yyval76: EIFFEL_LIST [PARENT_AS]
		do

				yyval76 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval76.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_76 is
			--|#line 492
		local
			yyval76: EIFFEL_LIST [PARENT_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp - 1))
				yyval76.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_77 is
			--|#line 499
		local
			yyval44: PARENT_AS
		do

yyval44 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval44
		end

	yy_do_action_78 is
			--|#line 501
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := yytype44 (yyvs.item (yyvsp - 1))
			
			yyval := yyval44
		end

	yy_do_action_79 is
			--|#line 508
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_80 is
			--|#line 513
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 7)), yytype80 (yyvs.item (yyvsp - 6)), yytype77 (yyvs.item (yyvsp - 5)), yytype64 (yyvs.item (yyvsp - 4)), yytype69 (yyvs.item (yyvsp - 3)), yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_81 is
			--|#line 518
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 6)), yytype80 (yyvs.item (yyvsp - 5)), Void, yytype64 (yyvs.item (yyvsp - 4)), yytype69 (yyvs.item (yyvsp - 3)), yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_82 is
			--|#line 523
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 5)), yytype80 (yyvs.item (yyvsp - 4)), Void, Void, yytype69 (yyvs.item (yyvsp - 3)), yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_83 is
			--|#line 528
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 4)), yytype80 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_84 is
			--|#line 533
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 3)), yytype80 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_85 is
			--|#line 538
		local
			yyval44: PARENT_AS
		do

				inherit_context := True
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 2)), yytype80 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_87 is
			--|#line 547
		local
			yyval77: EIFFEL_LIST [RENAME_AS]
		do

yyval77 := yytype77 (yyvs.item (yyvsp)) 
			yyval := yyval77
		end

	yy_do_action_88 is
			--|#line 551
		local
			yyval77: EIFFEL_LIST [RENAME_AS]
		do

				yyval77 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval77.extend (yytype47 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_89 is
			--|#line 556
		local
			yyval77: EIFFEL_LIST [RENAME_AS]
		do

				yyval77 := yytype77 (yyvs.item (yyvsp - 2))
				yyval77.extend (yytype47 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_90 is
			--|#line 563
		local
			yyval47: RENAME_AS
		do

yyval47 := new_rename_pair (yytype84 (yyvs.item (yyvsp - 2)), yytype84 (yyvs.item (yyvsp))) 
			yyval := yyval47
		end

	yy_do_action_92 is
			--|#line 569
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_93 is
			--|#line 573
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_95 is
			--|#line 579
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval64 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				yyval64.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_96 is
			--|#line 584
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval64 := yytype64 (yyvs.item (yyvsp - 1))
				yyval64.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_97 is
			--|#line 591
		local
			yyval22: EXPORT_ITEM_AS
		do

yyval22 := new_export_item_as (new_client_as (yytype71 (yyvs.item (yyvsp - 2))), yytype28 (yyvs.item (yyvsp - 1))) 
			yyval := yyval22
		end

	yy_do_action_98 is
			--|#line 595
		local
			yyval28: FEATURE_SET_AS
		do

yyval28 := new_all_as 
			yyval := yyval28
		end

	yy_do_action_99 is
			--|#line 597
		local
			yyval28: FEATURE_SET_AS
		do

yyval28 := new_feature_list_as (yytype69 (yyvs.item (yyvsp))) 
			yyval := yyval28
		end

	yy_do_action_100 is
			--|#line 601
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval69 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval69.extend (yytype84 (yyvs.item (yyvsp)).first)
			
			yyval := yyval69
		end

	yy_do_action_101 is
			--|#line 606
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval69 := yytype69 (yyvs.item (yyvsp - 2))
				yyval69.extend (yytype84 (yyvs.item (yyvsp)).first)
			
			yyval := yyval69
		end

	yy_do_action_103 is
			--|#line 615
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_105 is
			--|#line 621
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_107 is
			--|#line 627
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_109 is
			--|#line 633
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_111 is
			--|#line 639
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_113 is
			--|#line 645
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_115 is
			--|#line 655
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval81 := yytype81 (yyvs.item (yyvsp - 1)) 
			yyval := yyval81
		end

	yy_do_action_117 is
			--|#line 661
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_118 is
			--|#line 665
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval81 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval81.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_119 is
			--|#line 670
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval81 := yytype81 (yyvs.item (yyvsp - 1))
				yyval81.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_120 is
			--|#line 677
		local
			yyval58: TYPE_DEC_AS
		do

yyval58 := new_type_dec_as (yytype71 (yyvs.item (yyvsp - 3)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval58
		end

	yy_do_action_121 is
			--|#line 681
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := new_eiffel_list_id_as (Initial_identifier_list_size)
				yyval71.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_122 is
			--|#line 686
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_123 is
			--|#line 693
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

yyval71 := new_eiffel_list_id_as (0) 
			yyval := yyval71
		end

	yy_do_action_124 is
			--|#line 695
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

yyval71 := yytype71 (yyvs.item (yyvsp)) 
			yyval := yyval71
		end

	yy_do_action_126 is
			--|#line 701
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_127 is
			--|#line 705
		local
			yyval52: ROUTINE_AS
		do

yyval52 := new_routine_as (yytype54 (yyvs.item (yyvsp - 7)), yytype48 (yyvs.item (yyvsp - 5)), yytype81 (yyvs.item (yyvsp - 4)), yytype51 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)), fbody_pos) 
			yyval := yyval52
		end

	yy_do_action_128 is
			--|#line 705
		local

		do
			yyval := yyval_default;
fbody_pos := current_position.start_position 

		end

	yy_do_action_129 is
			--|#line 712
		local
			yyval51: ROUT_BODY_AS
		do

yyval51 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval51
		end

	yy_do_action_130 is
			--|#line 714
		local
			yyval51: ROUT_BODY_AS
		do

yyval51 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval51
		end

	yy_do_action_131 is
			--|#line 716
		local
			yyval51: ROUT_BODY_AS
		do

yyval51 := new_deferred_as 
			yyval := yyval51
		end

	yy_do_action_132 is
			--|#line 720
		local
			yyval24: EXTERNAL_AS
		do

yyval24 := new_external_as (yytype25 (yyvs.item (yyvsp - 1)), yytype54 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_133 is
			--|#line 724
		local
			yyval25: EXTERNAL_LANG_AS
		do

yyval25 := new_external_lang_as (yytype54 (yyvs.item (yyvsp)), yacc_position) 
			yyval := yyval25
		end

	yy_do_action_134 is
			--|#line 724
		local

		do
			yyval := yyval_default;
set_position (current_position) 

		end

	yy_do_action_136 is
			--|#line 732
		local
			yyval54: STRING_AS
		do

yyval54 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval54
		end

	yy_do_action_137 is
			--|#line 736
		local
			yyval37: INTERNAL_AS
		do

yyval37 := new_do_as (yytype73 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_138 is
			--|#line 738
		local
			yyval37: INTERNAL_AS
		do

yyval37 := new_once_as (yytype73 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_140 is
			--|#line 744
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_142 is
			--|#line 750
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
		end

	yy_do_action_143 is
			--|#line 754
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval73 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval73.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval73
		end

	yy_do_action_144 is
			--|#line 759
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval73 := yytype73 (yyvs.item (yyvsp - 1))
				yyval73.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval73
		end

	yy_do_action_145 is
			--|#line 766
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype35 (yyvs.item (yyvsp - 1)) 
			yyval := yyval35
		end

	yy_do_action_148 is
			--|#line 774
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_149 is
			--|#line 776
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_150 is
			--|#line 778
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_151 is
			--|#line 780
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype50 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_152 is
			--|#line 782
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype31 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_153 is
			--|#line 784
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_154 is
			--|#line 786
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype40 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_155 is
			--|#line 788
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_156 is
			--|#line 790
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_157 is
			--|#line 792
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype49 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_159 is
			--|#line 798
		local
			yyval48: REQUIRE_AS
		do

				id_level := Normal_level
				yyval48 := new_require_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval48
		end

	yy_do_action_160 is
			--|#line 798
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_161 is
			--|#line 805
		local
			yyval48: REQUIRE_AS
		do

				id_level := Normal_level
				yyval48 := new_require_else_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval48
		end

	yy_do_action_162 is
			--|#line 805
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_164 is
			--|#line 816
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_165 is
			--|#line 816
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_166 is
			--|#line 823
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_then_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_167 is
			--|#line 823
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_169 is
			--|#line 834
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
			--|#line 843
		local
			yyval79: EIFFEL_LIST [TAGGED_AS]
		do

				yyval79 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval79, yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_171 is
			--|#line 848
		local
			yyval79: EIFFEL_LIST [TAGGED_AS]
		do

				yyval79 := yytype79 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval79, yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_172 is
			--|#line 855
		local
			yyval55: TAGGED_AS
		do

yyval55 := yytype55 (yyvs.item (yyvsp - 1)) 
			yyval := yyval55
		end

	yy_do_action_173 is
			--|#line 859
		local
			yyval55: TAGGED_AS
		do

yyval55 := new_tagged_as (Void, yytype23 (yyvs.item (yyvsp)), yacc_position) 
			yyval := yyval55
		end

	yy_do_action_174 is
			--|#line 861
		local
			yyval55: TAGGED_AS
		do

yyval55 := new_tagged_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), yacc_position) 
			yyval := yyval55
		end

	yy_do_action_176 is
			--|#line 871
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_177 is
			--|#line 873
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_178 is
			--|#line 877
		local
			yyval57: TYPE
		do

yyval57 := new_expanded_type (yytype83 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_179 is
			--|#line 879
		local
			yyval57: TYPE
		do

yyval57 := new_separate_type (yytype83 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_180 is
			--|#line 881
		local
			yyval57: TYPE
		do

yyval57 := new_bits_as (yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_181 is
			--|#line 883
		local
			yyval57: TYPE
		do

yyval57 := new_bits_symbol_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_182 is
			--|#line 885
		local
			yyval57: TYPE
		do

yyval57 := new_like_id_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_183 is
			--|#line 887
		local
			yyval57: TYPE
		do

yyval57 := new_like_current_as 
			yyval := yyval57
		end

	yy_do_action_184 is
			--|#line 891
		local
			yyval57: TYPE
		do

yyval57 := new_class_type (yytype83 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_185 is
			--|#line 893
		local
			yyval57: TYPE
		do

yyval57 := new_boolean_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_186 is
			--|#line 895
		local
			yyval57: TYPE
		do

yyval57 := new_character_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_187 is
			--|#line 897
		local
			yyval57: TYPE
		do

yyval57 := new_double_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_188 is
			--|#line 899
		local
			yyval57: TYPE
		do

yyval57 := new_integer_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_189 is
			--|#line 901
		local
			yyval57: TYPE
		do

yyval57 := new_none_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_190 is
			--|#line 903
		local
			yyval57: TYPE
		do

yyval57 := new_pointer_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_191 is
			--|#line 905
		local
			yyval57: TYPE
		do

yyval57 := new_real_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_194 is
			--|#line 913
		local
			yyval80: EIFFEL_LIST [TYPE]
		do

yyval80 := yytype80 (yyvs.item (yyvsp - 1)) 
			yyval := yyval80
		end

	yy_do_action_195 is
			--|#line 917
		local
			yyval80: EIFFEL_LIST [TYPE]
		do

				yyval80 := new_eiffel_list_type (Initial_type_list_size)
				yyval80.extend (yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_196 is
			--|#line 922
		local
			yyval80: EIFFEL_LIST [TYPE]
		do

				yyval80 := yytype80 (yyvs.item (yyvsp - 2))
				yyval80.extend (yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_198 is
			--|#line 935
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

yyval70 := yytype70 (yyvs.item (yyvsp - 1)) 
			yyval := yyval70
		end

	yy_do_action_200 is
			--|#line 941
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_201 is
			--|#line 945
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval70 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval70.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_202 is
			--|#line 950
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval70 := yytype70 (yyvs.item (yyvsp - 2))
				yyval70.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_203 is
			--|#line 957
		local
			yyval29: FORMAL_DEC_AS
		do

				check formal_exists: not formal_parameters.empty end
				yyval29 := new_formal_dec_as (formal_parameters.last, yytype57 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)), formal_parameters.count)
			
			yyval := yyval29
		end

	yy_do_action_204 is
			--|#line 957
		local

		do
			yyval := yyval_default;
formal_parameters.extend (new_id_as (token_buffer)) 

		end

	yy_do_action_206 is
			--|#line 969
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_208 is
			--|#line 975
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp - 1)) 
			yyval := yyval69
		end

	yy_do_action_209 is
			--|#line 983
		local
			yyval31: IF_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 7)))
				yyval31 := new_if_as (yytype23 (yyvs.item (yyvsp - 5)), yytype73 (yyvs.item (yyvsp - 3)), yytype63 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval31
		end

	yy_do_action_211 is
			--|#line 992
		local
			yyval63: EIFFEL_LIST [ELSIF_AS]
		do

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_212 is
			--|#line 996
		local
			yyval63: EIFFEL_LIST [ELSIF_AS]
		do

				yyval63 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval63.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_213 is
			--|#line 1001
		local
			yyval63: EIFFEL_LIST [ELSIF_AS]
		do

				yyval63 := yytype63 (yyvs.item (yyvsp - 1))
				yyval63.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_214 is
			--|#line 1008
		local
			yyval20: ELSIF_AS
		do

yyval20 := new_elseif_as (yytype23 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp)), yacc_line_number) 
			yyval := yyval20
		end

	yy_do_action_216 is
			--|#line 1014
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
		end

	yy_do_action_217 is
			--|#line 1018
		local
			yyval33: INSPECT_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 5)))
				yyval33 := new_inspect_as (yytype23 (yyvs.item (yyvsp - 3)), yytype61 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval33
		end

	yy_do_action_219 is
			--|#line 1027
		local
			yyval61: EIFFEL_LIST [CASE_AS]
		do

yyval61 := yytype61 (yyvs.item (yyvsp)) 
			yyval := yyval61
		end

	yy_do_action_220 is
			--|#line 1031
		local
			yyval61: EIFFEL_LIST [CASE_AS]
		do

				yyval61 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval61.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_221 is
			--|#line 1036
		local
			yyval61: EIFFEL_LIST [CASE_AS]
		do

				yyval61 := yytype61 (yyvs.item (yyvsp - 1))
				yyval61.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_222 is
			--|#line 1043
		local
			yyval11: CASE_AS
		do

yyval11 := new_case_as (yytype74 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp)), yacc_line_number) 
			yyval := yyval11
		end

	yy_do_action_223 is
			--|#line 1047
		local
			yyval74: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval74 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval74.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval74
		end

	yy_do_action_224 is
			--|#line 1052
		local
			yyval74: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval74 := yytype74 (yyvs.item (yyvsp - 2))
				yyval74.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval74
		end

	yy_do_action_225 is
			--|#line 1059
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_226 is
			--|#line 1061
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_227 is
			--|#line 1063
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_228 is
			--|#line 1065
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_229 is
			--|#line 1067
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_230 is
			--|#line 1069
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_231 is
			--|#line 1071
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_232 is
			--|#line 1073
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_233 is
			--|#line 1075
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_234 is
			--|#line 1077
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_236 is
			--|#line 1083
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
			--|#line 1092
		local
			yyval40: LOOP_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 9)))
				yyval40 := new_loop_as (yytype73 (yyvs.item (yyvsp - 7)), yytype79 (yyvs.item (yyvsp - 6)), yytype59 (yyvs.item (yyvsp - 5)), yytype23 (yyvs.item (yyvsp - 3)), yytype73 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval40
		end

	yy_do_action_239 is
			--|#line 1101
		local
			yyval79: EIFFEL_LIST [TAGGED_AS]
		do

yyval79 := yytype79 (yyvs.item (yyvsp)) 
			yyval := yyval79
		end

	yy_do_action_241 is
			--|#line 1107
		local
			yyval39: INVARIANT_AS
		do

				id_level := Normal_level
				inherit_context := False
				yyval39 := new_invariant_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval39
		end

	yy_do_action_242 is
			--|#line 1107
		local

		do
			yyval := yyval_default;
id_level := Invariant_level 

		end

	yy_do_action_244 is
			--|#line 1119
		local
			yyval59: VARIANT_AS
		do

yyval59 := new_variant_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), yacc_position) 
			yyval := yyval59
		end

	yy_do_action_245 is
			--|#line 1121
		local
			yyval59: VARIANT_AS
		do

yyval59 := new_variant_as (Void, yytype23 (yyvs.item (yyvsp)), yacc_position) 
			yyval := yyval59
		end

	yy_do_action_246 is
			--|#line 1125
		local
			yyval19: DEBUG_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 4)))
				yyval19 := new_debug_as (yytype78 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval19
		end

	yy_do_action_249 is
			--|#line 1136
		local
			yyval78: EIFFEL_LIST [STRING_AS]
		do

yyval78 := yytype78 (yyvs.item (yyvsp - 1)) 
			yyval := yyval78
		end

	yy_do_action_250 is
			--|#line 1140
		local
			yyval78: EIFFEL_LIST [STRING_AS]
		do

				yyval78 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval78.extend (yytype54 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_251 is
			--|#line 1145
		local
			yyval78: EIFFEL_LIST [STRING_AS]
		do

				yyval78 := yytype78 (yyvs.item (yyvsp - 2))
				yyval78.extend (yytype54 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_252 is
			--|#line 1152
		local
			yyval49: RETRY_AS
		do

yyval49 := new_retry_as (yacc_line_number) 
			yyval := yyval49
		end

	yy_do_action_254 is
			--|#line 1158
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
			--|#line 1167
		local
			yyval5: ASSIGN_AS
		do

yyval5 := new_assign_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval5
		end

	yy_do_action_256 is
			--|#line 1169
		local
			yyval5: ASSIGN_AS
		do

yyval5 := new_assign_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval5
		end

	yy_do_action_257 is
			--|#line 1173
		local
			yyval50: REVERSE_AS
		do

yyval50 := new_reverse_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval50
		end

	yy_do_action_258 is
			--|#line 1175
		local
			yyval50: REVERSE_AS
		do

yyval50 := new_reverse_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval50
		end

	yy_do_action_260 is
			--|#line 1181
		local
			yyval62: EIFFEL_LIST [CREATE_AS]
		do

yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
		end

	yy_do_action_261 is
			--|#line 1185
		local
			yyval62: EIFFEL_LIST [CREATE_AS]
		do

				yyval62 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval62.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_262 is
			--|#line 1190
		local
			yyval62: EIFFEL_LIST [CREATE_AS]
		do

				yyval62 := yytype62 (yyvs.item (yyvsp - 1))
				yyval62.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_263 is
			--|#line 1197
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_264 is
			--|#line 1202
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_265 is
			--|#line 1207
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype71 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_266 is
			--|#line 1214
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (yytype43 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp - 1)), yytype75 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_267 is
			--|#line 1218
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 1)), Void) 
			yyval := yyval43
		end

	yy_do_action_268 is
			--|#line 1220
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 2))) 
			yyval := yyval43
		end

	yy_do_action_269 is
			--|#line 1222
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (yytype57 (yyvs.item (yyvsp - 1)), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_271 is
			--|#line 1226
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, Void) 
			yyval := yyval43
		end

	yy_do_action_273 is
			--|#line 1232
		local
			yyval75: EIFFEL_LIST [OPERAND_AS]
		do

yyval75 := yytype75 (yyvs.item (yyvsp - 1)) 
			yyval := yyval75
		end

	yy_do_action_274 is
			--|#line 1236
		local
			yyval75: EIFFEL_LIST [OPERAND_AS]
		do

				yyval75 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval75.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_275 is
			--|#line 1241
		local
			yyval75: EIFFEL_LIST [OPERAND_AS]
		do

				yyval75 := yytype75 (yyvs.item (yyvsp - 2))
				yyval75.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_276 is
			--|#line 1248
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, Void) 
			yyval := yyval43
		end

	yy_do_action_277 is
			--|#line 1250
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval43
		end

	yy_do_action_278 is
			--|#line 1252
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_class_type (yytype83 (yyvs.item (yyvsp - 2)), yytype80 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_279 is
			--|#line 1254
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_boolean_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_280 is
			--|#line 1256
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_character_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_281 is
			--|#line 1258
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_double_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_282 is
			--|#line 1260
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_283 is
			--|#line 1262
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_none_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_284 is
			--|#line 1264
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_pointer_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_285 is
			--|#line 1266
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_real_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_286 is
			--|#line 1268
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (yytype57 (yyvs.item (yyvsp - 1)), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_287 is
			--|#line 1272
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (yytype57 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval17
		end

	yy_do_action_288 is
			--|#line 1274
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (Void, yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval17
		end

	yy_do_action_289 is
			--|#line 1276
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (yytype57 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval17
		end

	yy_do_action_290 is
			--|#line 1280
		local
			yyval18: CREATION_EXPR_AS
		do

yyval18 := new_creation_expr_as (yytype57 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp))) 
			yyval := yyval18
		end

	yy_do_action_291 is
			--|#line 1282
		local
			yyval18: CREATION_EXPR_AS
		do

yyval18 := new_creation_expr_as (yytype57 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp))) 
			yyval := yyval18
		end

	yy_do_action_293 is
			--|#line 1288
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_294 is
			--|#line 1292
		local
			yyval1: ACCESS_AS
		do

yyval1 := new_access_id_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval1
		end

	yy_do_action_295 is
			--|#line 1294
		local
			yyval1: ACCESS_AS
		do

yyval1 := new_result_as 
			yyval := yyval1
		end

	yy_do_action_297 is
			--|#line 1300
		local
			yyval3: ACCESS_INV_AS
		do

yyval3 := new_access_inv_as (yytype30 (yyvs.item (yyvsp - 1)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_298 is
			--|#line 1308
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype1 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_299 is
			--|#line 1310
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_300 is
			--|#line 1312
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_301 is
			--|#line 1314
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_302 is
			--|#line 1316
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_303 is
			--|#line 1318
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype45 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_304 is
			--|#line 1320
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_305 is
			--|#line 1324
		local
			yyval13: CHECK_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 3)))
				yyval13 := new_check_as (yytype79 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval13
		end

	yy_do_action_306 is
			--|#line 1335
		local
			yyval23: EXPR_AS
		do

yyval23 := new_value_as (yytype6 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_307 is
			--|#line 1337
		local
			yyval23: EXPR_AS
		do

yyval23 := new_value_as (yytype4 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_308 is
			--|#line 1339
		local
			yyval23: EXPR_AS
		do

yyval23 := new_value_as (yytype56 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_309 is
			--|#line 1341
		local
			yyval23: EXPR_AS
		do

yyval23 := new_expr_call_as (yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_310 is
			--|#line 1343
		local
			yyval23: EXPR_AS
		do

yyval23 := yytype53 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_311 is
			--|#line 1345
		local
			yyval23: EXPR_AS
		do

yyval23 := new_paran_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_312 is
			--|#line 1347
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_plus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_313 is
			--|#line 1349
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_minus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_314 is
			--|#line 1351
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_star_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_315 is
			--|#line 1353
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_slash_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_316 is
			--|#line 1355
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_mod_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_317 is
			--|#line 1357
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_div_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_318 is
			--|#line 1359
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_power_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_319 is
			--|#line 1361
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_and_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_320 is
			--|#line 1363
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_and_then_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_321 is
			--|#line 1365
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_or_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_322 is
			--|#line 1367
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_or_else_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_323 is
			--|#line 1369
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_implies_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_324 is
			--|#line 1371
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_xor_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_325 is
			--|#line 1373
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_ge_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_326 is
			--|#line 1375
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_gt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_327 is
			--|#line 1377
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_le_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_328 is
			--|#line 1379
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_lt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_329 is
			--|#line 1381
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_eq_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_330 is
			--|#line 1383
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_ne_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_331 is
			--|#line 1385
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_free_as (yytype23 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_332 is
			--|#line 1387
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_minus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_333 is
			--|#line 1389
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_plus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_334 is
			--|#line 1391
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_not_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_335 is
			--|#line 1393
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_old_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_336 is
			--|#line 1395
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_free_as (yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_337 is
			--|#line 1397
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_strip_as (yytype71 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_338 is
			--|#line 1401
		local
			yyval23: EXPR_AS
		do

yyval23 := yytype23 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_339 is
			--|#line 1403
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_as (yytype84 (yyvs.item (yyvsp)).first) 
			yyval := yyval23
		end

	yy_do_action_340 is
			--|#line 1405
		local
			yyval23: EXPR_AS
		do

yyval23 := new_expr_address_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_341 is
			--|#line 1407
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_current_as 
			yyval := yyval23
		end

	yy_do_action_342 is
			--|#line 1409
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_result_as 
			yyval := yyval23
		end

	yy_do_action_343 is
			--|#line 1413
		local
			yyval30: ID_AS
		do

yyval30 := new_id_as (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_344 is
			--|#line 1421
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_345 is
			--|#line 1423
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_346 is
			--|#line 1425
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_347 is
			--|#line 1427
		local
			yyval10: CALL_AS
		do

yyval10 := new_current_as 
			yyval := yyval10
		end

	yy_do_action_348 is
			--|#line 1429
		local
			yyval10: CALL_AS
		do

yyval10 := new_result_as 
			yyval := yyval10
		end

	yy_do_action_349 is
			--|#line 1431
		local
			yyval10: CALL_AS
		do

yyval10 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_350 is
			--|#line 1433
		local
			yyval10: CALL_AS
		do

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_351 is
			--|#line 1435
		local
			yyval10: CALL_AS
		do

yyval10 := yytype45 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_352 is
			--|#line 1437
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_353 is
			--|#line 1439
		local
			yyval10: CALL_AS
		do

yyval10 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_354 is
			--|#line 1443
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (new_current_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_355 is
			--|#line 1447
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (new_result_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_356 is
			--|#line 1451
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype1 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_357 is
			--|#line 1455
		local
			yyval42: NESTED_EXPR_AS
		do

yyval42 := new_nested_expr_as (yytype23 (yyvs.item (yyvsp - 3)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_358 is
			--|#line 1459
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype45 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_359 is
			--|#line 1463
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor_as (Void, yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_360 is
			--|#line 1465
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 4)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_361 is
			--|#line 1467
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 2)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_362 is
			--|#line 1469
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_363 is
			--|#line 1471
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_364 is
			--|#line 1473
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_365 is
			--|#line 1475
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_366 is
			--|#line 1477
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_367 is
			--|#line 1479
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_368 is
			--|#line 1481
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_369 is
			--|#line 1483
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_370 is
			--|#line 1487
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_371 is
			--|#line 1489
		local
			yyval10: CALL_AS
		do

yyval10 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_372 is
			--|#line 1493
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_373 is
			--|#line 1495
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype41 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_374 is
			--|#line 1499
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
			--|#line 1512
		local
			yyval2: ACCESS_FEAT_AS
		do

yyval2 := new_access_feat_as (yytype30 (yyvs.item (yyvsp - 1)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval2
		end

	yy_do_action_378 is
			--|#line 1520
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

yyval65 := yytype65 (yyvs.item (yyvsp - 1)) 
			yyval := yyval65
		end

	yy_do_action_379 is
			--|#line 1524
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_380 is
			--|#line 1529
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := yytype65 (yyvs.item (yyvsp - 2))
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_381 is
			--|#line 1536
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

yyval65 := new_eiffel_list_expr_as (0) 
			yyval := yyval65
		end

	yy_do_action_382 is
			--|#line 1538
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_383 is
			--|#line 1542
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_384 is
			--|#line 1547
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := yytype65 (yyvs.item (yyvsp - 2))
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_385 is
			--|#line 1558
		local
			yyval30: ID_AS
		do

yyval30 := new_id_as (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_386 is
			--|#line 1560
		local
			yyval30: ID_AS
		do

yyval30 := new_boolean_id_as 
			yyval := yyval30
		end

	yy_do_action_387 is
			--|#line 1562
		local
			yyval30: ID_AS
		do

yyval30 := new_character_id_as 
			yyval := yyval30
		end

	yy_do_action_388 is
			--|#line 1564
		local
			yyval30: ID_AS
		do

yyval30 := new_double_id_as 
			yyval := yyval30
		end

	yy_do_action_389 is
			--|#line 1566
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as 
			yyval := yyval30
		end

	yy_do_action_390 is
			--|#line 1568
		local
			yyval30: ID_AS
		do

yyval30 := new_none_id_as 
			yyval := yyval30
		end

	yy_do_action_391 is
			--|#line 1570
		local
			yyval30: ID_AS
		do

yyval30 := new_pointer_id_as 
			yyval := yyval30
		end

	yy_do_action_392 is
			--|#line 1572
		local
			yyval30: ID_AS
		do

yyval30 := new_real_id_as 
			yyval := yyval30
		end

	yy_do_action_393 is
			--|#line 1576
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_394 is
			--|#line 1578
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_395 is
			--|#line 1580
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_396 is
			--|#line 1582
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype46 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_397 is
			--|#line 1584
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_398 is
			--|#line 1586
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_399 is
			--|#line 1590
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_400 is
			--|#line 1592
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_401 is
			--|#line 1594
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
			--|#line 1604
		local
			yyval6: ATOMIC_AS
		do

yyval6 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval6
		end

	yy_do_action_403 is
			--|#line 1606
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_404 is
			--|#line 1608
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_405 is
			--|#line 1612
		local
			yyval9: BOOL_AS
		do

yyval9 := new_boolean_as (False) 
			yyval := yyval9
		end

	yy_do_action_406 is
			--|#line 1614
		local
			yyval9: BOOL_AS
		do

yyval9 := new_boolean_as (True) 
			yyval := yyval9
		end

	yy_do_action_407 is
			--|#line 1618
		local
			yyval12: CHAR_AS
		do

				check is_character: not token_buffer.empty end
				yyval12 := new_character_as (token_buffer.item (1))
			
			yyval := yyval12
		end

	yy_do_action_408 is
			--|#line 1625
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
			--|#line 1635
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
			--|#line 1645
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
			--|#line 1658
		local
			yyval46: REAL_AS
		do

yyval46 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval46
		end

	yy_do_action_412 is
			--|#line 1660
		local
			yyval46: REAL_AS
		do

yyval46 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval46
		end

	yy_do_action_413 is
			--|#line 1662
		local
			yyval46: REAL_AS
		do

				token_buffer.precede ('-')
				yyval46 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval46
		end

	yy_do_action_414 is
			--|#line 1669
		local
			yyval7: BIT_CONST_AS
		do

yyval7 := new_bit_const_as (new_id_as (token_buffer)) 
			yyval := yyval7
		end

	yy_do_action_415 is
			--|#line 1673
		local
			yyval54: STRING_AS
		do

yyval54 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval54
		end

	yy_do_action_416 is
			--|#line 1675
		local
			yyval54: STRING_AS
		do

yyval54 := new_empty_string_as 
			yyval := yyval54
		end

	yy_do_action_417 is
			--|#line 1679
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_418 is
			--|#line 1681
		local
			yyval54: STRING_AS
		do

yyval54 := new_lt_string_as 
			yyval := yyval54
		end

	yy_do_action_419 is
			--|#line 1683
		local
			yyval54: STRING_AS
		do

yyval54 := new_le_string_as 
			yyval := yyval54
		end

	yy_do_action_420 is
			--|#line 1685
		local
			yyval54: STRING_AS
		do

yyval54 := new_gt_string_as 
			yyval := yyval54
		end

	yy_do_action_421 is
			--|#line 1687
		local
			yyval54: STRING_AS
		do

yyval54 := new_ge_string_as 
			yyval := yyval54
		end

	yy_do_action_422 is
			--|#line 1689
		local
			yyval54: STRING_AS
		do

yyval54 := new_minus_string_as 
			yyval := yyval54
		end

	yy_do_action_423 is
			--|#line 1691
		local
			yyval54: STRING_AS
		do

yyval54 := new_plus_string_as 
			yyval := yyval54
		end

	yy_do_action_424 is
			--|#line 1693
		local
			yyval54: STRING_AS
		do

yyval54 := new_star_string_as 
			yyval := yyval54
		end

	yy_do_action_425 is
			--|#line 1695
		local
			yyval54: STRING_AS
		do

yyval54 := new_slash_string_as 
			yyval := yyval54
		end

	yy_do_action_426 is
			--|#line 1697
		local
			yyval54: STRING_AS
		do

yyval54 := new_mod_string_as 
			yyval := yyval54
		end

	yy_do_action_427 is
			--|#line 1699
		local
			yyval54: STRING_AS
		do

yyval54 := new_div_string_as 
			yyval := yyval54
		end

	yy_do_action_428 is
			--|#line 1701
		local
			yyval54: STRING_AS
		do

yyval54 := new_power_string_as 
			yyval := yyval54
		end

	yy_do_action_429 is
			--|#line 1703
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_430 is
			--|#line 1705
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_431 is
			--|#line 1707
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_432 is
			--|#line 1709
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_433 is
			--|#line 1711
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_434 is
			--|#line 1713
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_435 is
			--|#line 1715
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_436 is
			--|#line 1717
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_437 is
			--|#line 1721
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_minus_string_as) 
			yyval := yyval85
		end

	yy_do_action_438 is
			--|#line 1723
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_plus_string_as) 
			yyval := yyval85
		end

	yy_do_action_439 is
			--|#line 1725
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_not_string_as) 
			yyval := yyval85
		end

	yy_do_action_440 is
			--|#line 1727
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval85
		end

	yy_do_action_441 is
			--|#line 1731
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_lt_string_as) 
			yyval := yyval85
		end

	yy_do_action_442 is
			--|#line 1733
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_le_string_as) 
			yyval := yyval85
		end

	yy_do_action_443 is
			--|#line 1735
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_gt_string_as) 
			yyval := yyval85
		end

	yy_do_action_444 is
			--|#line 1737
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_ge_string_as) 
			yyval := yyval85
		end

	yy_do_action_445 is
			--|#line 1739
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_minus_string_as) 
			yyval := yyval85
		end

	yy_do_action_446 is
			--|#line 1741
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_plus_string_as) 
			yyval := yyval85
		end

	yy_do_action_447 is
			--|#line 1743
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_star_string_as) 
			yyval := yyval85
		end

	yy_do_action_448 is
			--|#line 1745
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_slash_string_as) 
			yyval := yyval85
		end

	yy_do_action_449 is
			--|#line 1747
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_mod_string_as) 
			yyval := yyval85
		end

	yy_do_action_450 is
			--|#line 1749
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_div_string_as) 
			yyval := yyval85
		end

	yy_do_action_451 is
			--|#line 1751
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_power_string_as) 
			yyval := yyval85
		end

	yy_do_action_452 is
			--|#line 1753
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_and_string_as) 
			yyval := yyval85
		end

	yy_do_action_453 is
			--|#line 1755
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval85
		end

	yy_do_action_454 is
			--|#line 1757
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_implies_string_as) 
			yyval := yyval85
		end

	yy_do_action_455 is
			--|#line 1759
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_or_string_as) 
			yyval := yyval85
		end

	yy_do_action_456 is
			--|#line 1761
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval85
		end

	yy_do_action_457 is
			--|#line 1763
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_xor_string_as) 
			yyval := yyval85
		end

	yy_do_action_458 is
			--|#line 1765
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval85
		end

	yy_do_action_459 is
			--|#line 1769
		local
			yyval4: ARRAY_AS
		do

yyval4 := new_array_as (yytype65 (yyvs.item (yyvsp - 1))) 
			yyval := yyval4
		end

	yy_do_action_460 is
			--|#line 1773
		local
			yyval56: TUPLE_AS
		do

yyval56 := new_tuple_as (yytype65 (yyvs.item (yyvsp - 1))) 
			yyval := yyval56
		end

	yy_do_action_461 is
			--|#line 1777
		local

		do
			yyval := yyval_default;
set_position (current_position) 

		end

	yy_do_action_462 is
			--|#line 1781
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
			  125,  126,  127,  128>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  287,  270,  270,  270,  270,  270,  270,  270,  270,
			  271,  272,  273,  274,  275,  276,  277,  278,  245,  245,
			  245,  246,  246,  169,  166,  166,  213,  213,  213,  135,
			  135,  288,  288,  288,  288,  198,  198,  228,  228,  229,
			  229,  162,  162,  147,  290,  146,  146,  241,  241,  242,
			  242,  227,  227,  289,  289,  161,  285,  285,  282,  291,
			  291,  281,  281,  281,  279,  280,  139,  148,  148,  149,
			  149,  149,  255,  255,  255,  256,  256,  187,  187,  188,
			  188,  188,  188,  188,  188,  188,  257,  257,  258,  258,
			  191,  221,  221,  220,  220,  222,  222,  156,  163,  163,

			  230,  230,  232,  232,  231,  231,  234,  234,  233,  233,
			  236,  236,  235,  235,  266,  266,  267,  267,  268,  268,
			  211,  243,  243,  244,  244,  206,  206,  196,  292,  195,
			  195,  195,  159,  160,  293,  200,  200,  175,  175,  269,
			  269,  248,  248,  249,  249,  172,  294,  294,  173,  173,
			  173,  173,  173,  173,  173,  173,  173,  173,  192,  192,
			  296,  192,  297,  155,  155,  298,  155,  299,  261,  261,
			  262,  262,  202,  203,  203,  203,  205,  205,  210,  210,
			  210,  210,  210,  210,  207,  207,  207,  207,  207,  207,
			  207,  207,  264,  264,  264,  265,  265,  238,  238,  239,

			  239,  240,  240,  164,  300,  208,  208,  237,  237,  168,
			  218,  218,  219,  219,  154,  250,  250,  170,  214,  214,
			  215,  215,  143,  252,  252,  176,  176,  176,  176,  176,
			  176,  176,  176,  176,  176,  251,  251,  178,  263,  263,
			  177,  177,  301,  212,  212,  212,  153,  259,  259,  259,
			  260,  260,  193,  247,  247,  134,  134,  194,  194,  216,
			  216,  217,  217,  150,  150,  150,  197,  185,  185,  185,
			  185,  185,  253,  253,  254,  254,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  151,  151,  151,
			  152,  152,  209,  209,  129,  129,  132,  132,  171,  171,

			  171,  171,  171,  171,  171,  145,  157,  157,  157,  157,
			  157,  157,  157,  157,  157,  157,  157,  157,  157,  157,
			  157,  157,  157,  157,  157,  157,  157,  157,  157,  157,
			  157,  157,  157,  157,  157,  157,  157,  157,  158,  158,
			  158,  158,  158,  167,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  183,  182,  181,  184,  180,  189,
			  189,  189,  189,  189,  189,  189,  189,  189,  189,  189,
			  141,  141,  179,  179,  130,  131,  223,  223,  223,  224,
			  224,  225,  225,  226,  226,  165,  165,  165,  165,  165,
			  165,  165,  165,  136,  136,  136,  136,  136,  136,  137,

			  137,  137,  137,  137,  137,  140,  140,  144,  174,  174,
			  174,  190,  190,  190,  138,  199,  199,  201,  201,  201,
			  201,  201,  201,  201,  201,  201,  201,  201,  201,  201,
			  201,  201,  201,  201,  201,  201,  201,  284,  284,  284,
			  284,  283,  283,  283,  283,  283,  283,  283,  283,  283,
			  283,  283,  283,  283,  283,  283,  283,  283,  283,  133,
			  204,  295,  286>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   12,    1,    1,    1,    1,    1,    1,    1,    1,
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
			   59,   56,  114,    0,  242,   18,   40,  440,  439,  438,
			  437,   65,  458,  457,  456,  455,  454,  453,  452,  451,

			  450,  449,  448,  447,  446,  445,  444,  443,  442,  441,
			   64,  208,    0,  192,  183,  182,  192,    0,    0,  181,
			  180,  194,    0,  105,  113,   88,   87,    0,  109,   95,
			   93,    0,   94,  103,  106,  107,  110,  111,    0,   84,
			   92,  102,   48,    0,   43,   46,   52,   59,  116,   53,
			  125,   58,  461,    0,  101,  179,  178,  196,    0,    0,
			   96,   98,   53,   99,  110,    0,   83,  106,   50,   57,
			  121,  118,    0,    0,  117,   55,    0,   67,  170,  241,
			  461,    0,    1,   89,   90,   97,    0,   82,  110,    0,
			    0,  115,  119,  126,   35,   66,  171,    0,  348,  376,

			  347,  381,    0,  381,    0,  271,    0,  402,  401,    0,
			    0,    0,    0,  343,    0,    0,  349,  307,  306,  403,
			  399,  309,  400,  353,  173,  376,    0,  352,  346,  345,
			  344,  350,    0,  351,  310,  404,   53,  308,   81,    0,
			  122,   53,   70,   69,   68,   71,  128,  270,    0,    0,
			    0,  359,    0,  383,  376,    0,  382,    0,    0,  192,
			  192,  192,  192,  192,  192,  192,  192,    0,    0,    0,
			    0,  335,  123,  334,  332,  333,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  175,  267,  374,  336,  272,

			    0,  172,   80,  120,  158,  371,  355,  376,  370,    0,
			    0,  377,  338,  379,    0,  354,  460,    0,    0,  269,
			    0,    0,    0,    0,    0,    0,    0,    0,  459,    0,
			  296,  311,  124,    0,  356,  318,  317,  316,  315,  314,
			  313,  312,  325,  327,  326,  328,  329,  330,    0,  319,
			  324,    0,  321,  323,  331,  174,    0,  266,  358,  160,
			  139,    0,  375,  376,  342,  341,    0,  339,  378,    0,
			  384,    0,  376,  376,  376,  376,  376,  376,  376,  376,
			  296,    0,  291,  268,    0,  337,  320,  322,  276,    0,
			  277,  274,    0,  162,  461,  116,    0,  372,  373,  361,

			    0,  380,    0,  362,  363,  364,  365,  366,  367,  368,
			  369,  290,  376,  357,  177,  192,  192,  192,  192,  192,
			  192,  192,  192,  273,    0,  461,  159,  140,  146,  134,
			  146,  131,  130,  129,  163,  340,  376,  297,  286,  184,
			  185,  186,  187,  188,  189,  190,  191,  275,  161,  138,
			  461,  135,    0,  137,  165,  253,  360,  278,  279,  280,
			  281,  282,  283,  284,  285,  147,  143,  461,  462,    0,
			  132,  133,  167,  461,  146,    0,  144,  252,    0,    0,
			    0,    0,  292,    0,  298,  150,  156,  148,  155,  376,
			  152,  153,  149,  146,  154,  304,  300,  299,  301,  302,

			  303,  157,  151,    0,  136,  461,  164,  254,  127,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  295,
			    0,  296,  294,  293,    0,    0,    0,    0,  145,    0,
			    0,  146,  247,  461,  166,  256,  258,    0,  288,    0,
			    0,  255,  257,  218,    0,  238,    0,  146,    0,    0,
			  296,    0,  220,  235,  219,  146,  461,  243,  248,  250,
			    0,    0,  305,  296,  287,  226,  227,  225,  223,    0,
			  146,    0,  221,  210,  239,    0,    0,  249,    0,  246,
			  289,    0,    0,    0,  146,    0,  236,  217,    0,  212,
			  215,  211,  245,  376,    0,  251,  232,  234,  233,  231,

			  230,  229,  228,  222,  224,    0,  146,    0,  213,    0,
			    0,  146,  216,  209,  244,  146,  214,    0,  237,    0,
			    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  621,  316,  405,  482,  317,  585,   50,   51,  318,  319,
			  249,  320,  406,  321,  652,  322,  586,  130,  133,  295,
			  344,  111,  587,  323,  588,  689,  555,  229,  412,  490,
			  532,  551,  179,  134,  262,   91,  354,   12,  326,  590,
			   13,  591,  592,  566,  593,   56,  533,  668,  185,  594,
			  408,  327,  328,  329,  330,  331,  332,  491,  105,  106,
			  333,   57,  225,  460,  601,  602,  534,  345,  334,   95,
			  335,  570,   59,  278,  336,  337,  358,  277,  159,  103,
			  624,  160,  271,  676,   60,  653,  654,  112,  113,  690,
			  691,  168,  241,  230,  397,  414,  355,  356,  180,  135,

			  136,  148,  233,  234,  235,  236,  237,  238,  124,   89,
			   92,   93,  231,  175,  272,  433,    2,   14,  575,  549,
			  567,  707,  671,  669,  457,  492,  101,  107,  172,  226,
			  647,  660,  279,  280,  657,  138,  161,  250,  273,  274,
			  496,  149,   79,   80,   81,   82,   83,   84,   85,   86,
			  150,  151,  152,  181,  210,  191,  182,  603,  719,   18,
			   69,  177,  183,  404,  552,  550,  281,  494,  525,  573,
			  605,   96,  252>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  434, 1747,  -29, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  508, 1453, -32768, 1739, -32768, -32768, -32768,  493, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  172,  165,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  146, -32768, 1815, -32768, -32768, -32768, -32768, 1568, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  498, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  480,  462,
			 -32768, -32768,  494,  496,  492,  458,  482, -32768,  480, -32768,

			 1598,  470, 1815,  473, -32768, -32768,  475, 1815,  455, -32768,
			  644, -32768,  435,  470, -32768,  455,  455,  455,  455,  455,
			  455,  455,  455,  710, -32768, -32768, -32768, 1555,  151, 1731,
			  710,  918, -32768,  228, -32768,  448,  435, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,   22, 1891,  -22, -32768,
			 -32768, -32768, -32768, 1815,  490, 1815, -32768,  520, -32768, -32768,
			 -32768,   -2,  710,  710,  710,  710,   97, -32768,  384,  388,
			  370,  446,  442, -32768, -32768,  122,  437,  440, -32768, -32768,
			  210, -32768,   52,  710, -32768,  434, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  710,  455, -32768, -32768,  455,  472,  471, -32768,
			 -32768, -32768, 1792,  437,  437, -32768,  453,  438,  437, -32768,
			  440,  413, -32768, -32768,  388, -32768,  370, -32768,  427, -32768,
			 -32768,  384, -32768, 1773, -32768, -32768, -32768,  410, 1773,  408,
			  439, -32768,   26,  412, -32768, -32768, -32768, -32768,  710,  710,
			 -32768, -32768,  408,  437,  370,  411, -32768,  388, -32768, -32768,
			 -32768, -32768,  267,  421, 1773, -32768, 1792,  386, -32768, -32768,
			   46, 1415, -32768, -32768, -32768, -32768,  399, -32768,  370, 1773,
			 1792, -32768, -32768, -32768, 1615, -32768, -32768,  336,  436,    0,

			  278, 1415, 1716, 1415,  414, -32768, 1792, -32768, -32768, 1415,
			 1415,  431, 1415, -32768, 1415, 1415,  268, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, 2020,   55, 1415, -32768, -32768, -32768,
			 -32768, -32768, 1773,  261, -32768, -32768,  408, -32768, -32768,  392,
			 -32768,  408, -32768, -32768, -32768, -32768, -32768, -32768, 1773, 1815,
			  805, -32768, 1773, 2020,   89,  396,  403, 1815,  341,  225,
			  211,  207,  184,  174,  159,  123,   74,  397, 1792,  358,
			 1979, -32768, 1773, -32768, -32768, -32768, 1773, 1415, 1415, 1415,
			 1415, 1415, 1415, 1415, 1415, 1415, 1415, 1415, 1415, 1415,
			 1300, 1415, 1185, 1415, 1415, 1415, -32768, -32768, -32768,  391,

			 1773, -32768, -32768, -32768,  350,  348, -32768,  317, -32768,  361,
			 1686, -32768, 2020, -32768,  121, -32768, -32768, 1415,  355, -32768,
			  353,  332,  330,  329,  327,  326,  324,  314, -32768,  349,
			  202,   59,  352,  337, -32768,  257,  257,  257,  257,  257,
			  367,  367,  339,  339,  339,  339,  339,  339, 1415,  926,
			 2035, 1415, 1895, 1960, -32768, 2020,  955, -32768, -32768,  328,
			  309, 1773, -32768,  317, -32768, -32768, 1415, -32768, -32768, 1070,
			 2020,  333,  317,  317,  317,  317,  317,  317,  317,  317,
			  202, 1773, -32768, -32768, 1773, -32768,  926, 1895,  336, 1716,
			 -32768, -32768,  114, -32768,  129, 1773,   72,  348, -32768, -32768,

			 1938, -32768,  279, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  317, -32768,  319,  225,  211,  207,  184,  174,
			  159,  123,   74, -32768,  955,  129, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  301, -32768,  317, -32768, -32768,  304,
			  302,  300,  299,  298,  284,  283,  282, -32768, -32768, -32768,
			  305,  297,  589, -32768,  227,  233, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  954,  697,  589,
			 -32768, -32768, -32768,   19, -32768,  256, -32768, -32768,   49,  278,
			 1443, 1784, 1792, 1415,  268, -32768, -32768, -32768, -32768,   61,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			  261, -32768, -32768,  101, -32768,   19, -32768, -32768, -32768, 1415,
			 1415,  273,  264,  263,  262,  254,  252,  249,  229, -32768,
			 1792,  202, -32768, -32768,  247, 1920, 1415, 1415,  232, 1415,
			 1415, -32768,  240,  198, -32768, 2020, 2020,  213, -32768, 1520,
			  226, 2020, 2020,  861, 1245,  164,  308, -32768,  181, 1520,
			  202,  347, -32768,  177,  137, -32768,  -64,  135, -32768, -32768,
			   78,  158, -32768,  202, -32768,  214,  208,  197, -32768,  -18,
			 -32768,  127, -32768,   75, -32768, 1415,   88, -32768,  589, -32768,
			 -32768,  456,  347,  520, -32768,  347, -32768, -32768, 1415, -32768,
			  133,   75, 2020,    1, 1415, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, 1127, -32768,  115, -32768, 1415,
			 1359, -32768, -32768, -32768, 2020, -32768, -32768,   83, -32768,  131,
			   96, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -544,  110,  212, -475, -32768, -32768,  582,  376, -32768,    8,
			 -32768,   -4, -297, -32768,   -8,  -10, -32768,  467, -32768, -32768,
			 -32768,  529, -32768, -32768, -32768,  -48, -32768,  415,  274, -344,
			 -32768, -32768,  460,  503, -32768,  539,   -1, -32768,  323, -32768,
			  622, -32768, -32768,   68, -32768, -156, -32768,  -54, -32768, -32768,
			  168,   66,   65,   64,   31,   23, -32768,   63,  483, -32768,
			   17, -32768,  372, -32768, -32768, -32768, -32768, -32768, -32768,  288,
			   -5, -32768, -537,  294, -32768, -32768, -124, -32768,  474, -32768,
			 -32768,   84,  307, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  393, -32768, -32768, -140, -32768,  265, -32768, -32768, -32768,

			 -32768, -114,  444,  325,  443, -211,  441, -206, -32768, -32768,
			 -32768, -32768,  -89, -32768,  180, -32768,  371, -32768, -32768, -306,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -482, -32768, -32768,  -49, -32768, -32768,   56, -32768,
			 -32768,  -53,  -41,  -42,  -50,  -74,  -77,  -83,  -92,  -98,
			 -32768, -32768, -147,  310, -32768, -32768, -32768, -32768, -32768, -32768,
			  -86, -32768, -32768, -32768, -32768,  -39, -526, -32768, -32768, -32768,
			 -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   11,  220,   54,  158,  122,  511,  413,   58,   53,   78,
			  121,   55,  526,   11,  109,  571,  176,  227,  212,  120,
			   52,  131,  685,  264,  568,  119,  350,  350,  118,  122,
			  265,   17,  604, -168, -168,  121,  251,   16,  222,  396,
			  709,  568,  211,  548,  120,  349,  221,  108,  223,  224,
			  119,  228,  117,  118,  108,  415,  288,   54,  286,  128,
			  116,  115,   58,   53,   15,  254,   55,  139,  140,  141,
			  142,  143,  144,  145,  348,   52,  684,  117,  248,  434,
			  232,  350,  339, -168,  484,  116,  115,  350,  245,   99,
			 -168,  606,  247,  396,  395,  650,  721,  483,  257, -168,

			  213,  610,  216,  458,  609,  663, -169, -169, -168,  659,
			 -169,  227,  284,  627, -169,  350,  626,  263,  678, -169,
			  427,  127,  677,  634,  122,  501, -169,  396,  174, -169,
			  121,  720,  531,  530,   68, -169,  190,  189,  688,  120,
			  529,  695,  129, -169, -169,  119,  638,  718,  118,  188,
			  187,  648,  293,  215,  524,  528,  219,  633,  523,  351,
			  632,  469,  243,  275,  255,  468,  341,  256,  242,  426,
			  127,  631,  117,  630,  674,  664,  285,  629,  122,  713,
			  116,  115,  369,   68,  121,  694,   67,  513,  680, -168,
			 -168,  687,  122,  120,   66,  706,   65, -168,  121,  119,

			  683,   64,  118,   63,  366,  425,  127,  120,  122, -168,
			  365,  682, -168,  119,  121,  167,  118,  681,  166,  364,
			  424,  127,  679,  120,  553,  363,  117,  481,  362,  119,
			  423,  127,  118,  675,  116,  115,  651,  165,  164,  670,
			  117,  656,  268,  163,  429,  662,  162,  270,  116,  115,
			  401,  484,  361,  422,  127,  403,  117,  421,  127,  649,
			  360,  359, -168,  467,  116,  115,  646,  462,  607,  565,
			  122,  420,  127,  270,  -42,  427,  121,  377,  313,  -42,
			  325,  178,  639,  -42,   54,  120,  400,  -42,  340,   58,
			   53,  119,  -41,  376,  118,  426,  409,  -41,  425,  178,

			  424,  -41,   52,  352,  418,  -41,  290,  289,  423,  422,
			  421,  139,  140,  141,  142,  143,  144,  145,  117,  420,
			  608,  572,  574,  499,  569,  645,  116,  115,  564,  563,
			  562,  399,  503,  504,  505,  506,  507,  508,  509,  510,
			   44,  661,  565,  350,  561,  560,  559,  407,  558,  673,
			  557,  407,  658,  383,  382,  381,  380,  379,  378,  377,
			  313,  218,  217,  536,  686,  538,  554, -141, -141, -141,
			 -141,  270,  537,  461,  347,  407,   47,   46,  703,  502,
			   10,  485, -141,  381,  380,  379,  378,  377,  313,  495,
			  493,  522,  289,  430, -141,  480,  556,  521,  479,  407,

			  712,  471, -141, -141, -141,  716,  520,  463,  478,  717,
			  477,  476,  519,  475,  474,  518,  473,  456,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   22,   21,   20,  472,  459,  517,
			  428,  261,  419,  417,  416,   68,   77,  516,  515,    9,
			    8,    7,    6,    5,    4,    3,  402,  372,  623,  368,
			  407,  348,  163,  338,  294,  291,  539,  540,  541,  542,
			  543,  544,  545,  546,  165,  287,  282,  212,  276,  162,
			  512,  178,  618,  407,  122,  129,   46,  147,  617,   10,
			  121,  266,  259,  258,  270,  667,  637,  616,  146,  120,

			   66,   64,  127,  615,  132,  119,  614,    1,  118,  166,
			  239,  110,  125,   90,  123,   76,   75,   74,   73,   72,
			   71,   70,  122,   10,   44,  184,  700,  702,  121,  667,
			  613,  102,  117,  100,  218,  217,   98,  120,  612,  611,
			  116,  115,   97,  119,   94,   88,  118,   19,  214,   47,
			   62,  527,  432,   10,  628,  324,  253,  269,    9,    8,
			    7,    6,    5,    4,    3,  240,  267,  589,  367,  171,
			  117,  170,  169,  514,  296,  353,  114,  353,  116,  115,
			  622,  292,  346,  370,  371,  600,  373,  547,  374,  375,
			  126,  599,    9,    8,    7,    6,    5,    4,    3,  598,

			  398,   39,   38,   37,   36,   35,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,
			   20,   44,    9,    8,    7,    6,    5,    4,    3,  498,
			  283,  704,  597,  596,  595,  576,   61,  104,  622,  186,
			  246,  665,  137,  708,  244,  260,  672,  394,  622,   87,
			  666,  435,  436,  437,  438,  439,  440,  441,  442,  443,
			  444,  445,  446,  447,  449,  450,  452,  453,  454,  455,
			  343,  696,  698,  497,  693,  665,  394,  -45,  584,    0,
			  697,  699,  701,    0,  666,    0,    0,    0,    0,  129,
			    0,  470,    0,  394,  394,    0,  394,  394,  394,   38,

			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,   20,  -45,    0,
			    0,  394,  486,  583,    0,  487,    0,    0,    0,  -45,
			   10,    0,  582,    0,    0,  394,    0,    0,  581,    0,
			  500,    0,  580,   77,    0,    0,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,    0,    0,  579,    0,    0,  394,  394,
			  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,
			  394,    0,  394,  394,    0,  394,  394,  394,  394,    0,
			    0,  299,    0,    0,  147,    0,    0,  578,  577,    0,
			    0,    0,    0,  394,    0,  146,    0,    0,    0,    9,

			    8,    7,    6,    5,    4,    3,    0,    0,    0,  394,
			  394,    0,   76,   75,   74,   73,   72,   71,   70,  315,
			  314,    0,    0,  394,    0,    0,  313,  312,  311,  310,
			    0,  309,    0,    0,  308,   46,  307,   44,   10,   43,
			  306,    0,    0,  305,    0,    0,  304,  303,    0,  411,
			  302,    0,  301,    0,    0,   41,   40,  625,  410,    0,
			    0,    0,    0,  300,    0,  393,  392,  391,  390,  389,
			  388,  387,  386,  385,  384,  383,  382,  381,  380,  379,
			  378,  377,  313,  635,  636,    0,    0,    0,    0,  299,
			    0,    0,    0,    0,    0,  298,    0,    0,    0,    0,

			  641,  642,    0,  643,  644,  297,    0,    9,    8,    7,
			    6,    5,    4,    3,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,   20,  389,  388,  387,  386,  385,  384,
			  383,  382,  381,  380,  379,  378,  377,  313,  394,  692,
			    0,  -46,    0,    0,    0,    0,    0,    0,  394,  394,
			  651,    0,  705,    0,  394,  394,  394,  394,  710,  315,
			  314,    0,    0,    0,    0,    0,  313,  312,  311,  310,
			    0,  309,    0,  714,  308,   46,  307,   44,   10,   43,
			  306,    0,  -46,  305,    0,    0,  304,  303,    0,    0,

			  489,    0,  301,  -46,    0,   41,   40,    0,  410,    0,
			    0,    0,    0,  300,    0,  394, -142, -142, -142, -142,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,    0,  394,    0,
			    0, -142,    0,  394,    0,    0,    0,  394,    0,  299,
			    0,    0,    0, -142,    0,  298,    0,    0,    0,    0,
			    0, -142, -142, -142,    0,  488,    0,    9,    8,    7,
			    6,    5,    4,    3,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,   20,  315,  314,    0,    0,    0,    0,
			    0,  313,  312,  311,  310,    0,  309,    0,    0,  308,

			   46,  307,   44,   10,   43,  306,    0,    0,  305,    0,
			    0,  304,  303,    0,    0,  302,    0,  301,    0,    0,
			   41,   40,    0,  410,    0,    0,    0,    0,  300,    0,
			    0,  393,  392,  391,  390,  389,  388,  387,  386,  385,
			  384,  383,  382,  381,  380,  379,  378,  377,  313,    0,
			    0,    0,    0,    0,  299,    0,    0,    0,    0,    0,
			  298,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  297,    0,    9,    8,    7,    6,    5,    4,    3,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,   22,   21,   20,  315,

			  314,    0,    0,    0,    0,    0,  313,  312,  311,  310,
			    0,  309,    0,    0,  308,   46,  307,   44,   10,   43,
			  306,  711,    0,  305,    0,    0,  304,  303,    0,    0,
			  302,    0,  301,    0,    0,   41,   40,    0,    0,    0,
			    0,    0,    0,  300,    0,    0,    0,  451,    0,  393,
			  392,  391,  390,  389,  388,  387,  386,  385,  384,  383,
			  382,  381,  380,  379,  378,  377,  313,    0,    0,  299,
			    0,    0,    0,    0,    0,  298,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  297,    0,    9,    8,    7,
			    6,    5,    4,    3,   39,   38,   37,   36,   35,   34,

			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,   20,  315,  314,    0,    0,    0,    0,
			    0,  313,  312,  311,  310,    0,  309,    0,    0,  308,
			   46,  307,   44,   10,   43,  306,    0,    0,  305,  655,
			    0,  304,  303,    0,    0,  302,    0,  301,    0,    0,
			   41,   40,    0,    0,    0,    0,    0,    0,  300,    0,
			    0,    0,    0,  393,  392,  391,  390,  389,  388,  387,
			  386,  385,  384,  383,  382,  381,  380,  379,  378,  377,
			  313,    0,    0,    0,  299,    0,    0,    0,    0,    0,
			  298,    0,    0,    0,  448,    0,    0,    0,    0,    0,

			  297,    0,    9,    8,    7,    6,    5,    4,    3,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,   22,   21,   20,  315,
			  314,    0,    0,    0,    0,    0,  313,  312,  311,  310,
			  715,  309,    0,    0,  308,   46,  307,   44,   10,   43,
			  306,    0,    0,  305,    0,    0,  304,  303,    0,    0,
			  302,    0,  301,    0,    0,   41,   40,   49,   48,    0,
			    0,    0,    0,  300,    0,    0,   77,    0,    0,    0,
			    0,    0,   47,   46,   45,   44,   10,   43,  357,    0,
			   42,    0,    0,    0,    0,    0,    0,    0,    0,  299,

			    0,    0,    0,   41,   40,  298,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  297,    0,    9,    8,    7,
			    6,    5,    4,    3,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,   20,    0,   76,   75,   74,   73,   72,
			   71,   70,    0,   10,    0,    9,    8,    7,    6,    5,
			    4,    3,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   22,
			   21,   20,   49,   48,    0,    0,    0,    0,   77,    0,
			    0,  157,    0,    0,    0,    0,    0,   47,   46,   45,

			   44,   10,   43,  156,    0,    0,    0,    0,    0,    0,
			  619,    0,    0,    0,    0,    0,    0,    0,   41,   40,
			    0,  155,    9,    8,    7,    6,    5,    4,    3,   49,
			   48,   77,    0,    0,  154,   68,    0,    0,    0,    0,
			    0,    0,    0,    0,   47,   46,   45,   44,  153,   43,
			    0,    0,    0,    0,    0,    0,    0,   76,   75,   74,
			   73,   72,   71,   70,    0,   41,   40,    0,    0,    0,
			    9,    8,    7,    6,    5,    4,    3,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   22,   21,   20,   94,    0,    0,

			   76,   75,   74,   73,   72,   71,   70,    0,    0,    0,
			    0,  342,  466,    0,    0,    0,    0,    0,    0,   77,
			    0,    0,    0,    0,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,   20,  465,    0,    0,    0,    0,   77,
			    0,    0,  157,    0,    0,    0,    0,    0,    0,    0,
			  147,  357,    0,    0,   10,    0,    0,    0,    0,    0,
			    0,  146,   10,    0,    0,    0,  464,  173,    0,    0,
			   10,    0,  155,    0,    0,    0,    0,    0,   76,   75,
			   74,   73,   72,   71,   70,  154,  -19,    0,    0,  -19,

			    0,    0,    0,  -19,  -20,  -19,   10,  -20,    0,  153,
			    0,  -20,    0,  -20,    0,    0,    0,   10,   76,   75,
			   74,   73,   72,   71,   70,   77,    0,    0,  157,  620,
			    0,    0,  -19,    9,    8,    7,    6,    5,    4,    3,
			  -20,    9,    8,    7,    6,    5,    4,    3,   77,    9,
			    8,    7,    6,    5,    4,    3,    0,    0,  155,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  154,    0,    0,  619,    9,    8,    7,    6,    5,
			    4,    3,    0,    0,    0,  153,    9,    8,    7,    6,
			    5,    4,    3,    0,   76,   75,   74,   73,   72,   71,

			   70,  391,  390,  389,  388,  387,  386,  385,  384,  383,
			  382,  381,  380,  379,  378,  377,  313,   76,   75,   74,
			   73,   72,   71,   70,  393,  392,  391,  390,  389,  388,
			  387,  386,  385,  384,  383,  382,  381,  380,  379,  378,
			  377,  313,  393,  392,  391,  390,  389,  388,  387,  386,
			  385,  384,  383,  382,  381,  380,  379,  378,  377,  313,
			    0,    0,    0,    0,  640,  392,  391,  390,  389,  388,
			  387,  386,  385,  384,  383,  382,  381,  380,  379,  378,
			  377,  313,  535,  393,  392,  391,  390,  389,  388,  387,
			  386,  385,  384,  383,  382,  381,  380,  379,  378,  377,

			  313,  209,  208,  207,  206,  205,  204,  203,  202,  201,
			  200,  199,  198,  197,  196,  195,  194,  193,    0,  192,
			    0,    0,    0,  431,  393,  392,  391,  390,  389,  388,
			  387,  386,  385,  384,  383,  382,  381,  380,  379,  378,
			  377,  313,  390,  389,  388,  387,  386,  385,  384,  383,
			  382,  381,  380,  379,  378,  377,  313>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,  157,   12,  127,  102,  480,  350,   12,   12,   62,
			  102,   12,  494,   14,  100,  552,  130,  164,   40,  102,
			   12,  110,   40,  234,  550,  102,   26,   26,  102,  127,
			  236,   60,  569,   97,   98,  127,  183,   66,   40,   38,
			   39,  567,   64,  525,  127,   45,   48,  100,  162,  163,
			  127,  165,  102,  127,  107,  352,  267,   67,  264,  108,
			  102,  102,   67,   67,   93,  212,   67,  116,  117,  118,
			  119,  120,  121,  122,   25,   67,   94,  127,   26,  376,
			  166,   26,  288,   64,   25,  127,  127,   26,  177,   94,
			   64,  573,   40,   38,   39,  639,    0,   38,  222,   73,

			  153,   52,  155,  400,   55,  649,   60,   61,   89,  646,
			   64,  258,  259,   52,   68,   26,   55,  231,   40,   73,
			   46,   47,   44,  605,  222,  469,   80,   38,  129,   83,
			  222,    0,   60,   61,   37,   89,  114,  115,   63,  222,
			   68,  678,   45,   97,   98,  222,  621,   64,  222,  127,
			  128,  633,  276,  154,   40,   83,  157,   56,   44,  299,
			   59,   40,   40,  249,  213,   44,  290,  216,   46,   46,
			   47,   70,  222,   72,  656,  650,  262,   76,  276,   64,
			  222,  222,  306,   37,  276,   97,   40,  484,  663,   60,
			   61,   64,  290,  276,   29,   62,   31,   68,  290,  276,

			    3,   29,  276,   31,  302,   46,   47,  290,  306,   80,
			  302,    3,   83,  290,  306,   64,  290,    3,   67,  302,
			   46,   47,   64,  306,  530,  302,  276,   25,  302,  306,
			   46,   47,  306,   98,  276,  276,   99,   86,   87,   62,
			  290,   77,  243,   92,  368,   64,   95,  248,  290,  290,
			  336,   25,  302,   46,   47,  341,  306,   46,   47,   46,
			  302,  302,   64,  410,  306,  306,   26,  407,  574,   37,
			  368,   46,   47,  274,   64,   46,  368,   20,   21,   69,
			  281,   71,   35,   73,  294,  368,   25,   77,  289,  294,
			  294,  368,   64,   25,  368,   46,  349,   69,   46,   71,

			   46,   73,  294,   25,  357,   77,   39,   40,   46,   46,
			   46,  360,  361,  362,  363,  364,  365,  366,  368,   46,
			   64,   94,   89,  463,   27,  631,  368,  368,   46,   46,
			   46,  332,  472,  473,  474,  475,  476,  477,  478,  479,
			   32,  647,   37,   26,   46,   46,   46,  348,   46,  655,
			   46,  352,   44,   14,   15,   16,   17,   18,   19,   20,
			   21,   14,   15,   84,  670,   46,   65,   62,   63,   64,
			   65,  372,  512,   25,   38,  376,   29,   30,  684,   46,
			   33,   44,   77,   16,   17,   18,   19,   20,   21,   80,
			   62,  489,   40,   35,   89,   46,  536,  489,   84,  400,

			  706,   46,   97,   98,   99,  711,  489,   46,   84,  715,
			   84,   84,  489,   84,   84,  489,   84,   26,  110,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,   84,   88,  489,
			   43,   28,  101,   40,   48,   37,   33,  489,  489,  102,
			  103,  104,  105,  106,  107,  108,   64,   26,  582,   45,
			  461,   25,   92,   64,   78,   44,  515,  516,  517,  518,
			  519,  520,  521,  522,   86,   64,   64,   40,   39,   95,
			  481,   71,  580,  484,  582,   45,   30,   74,  580,   33,
			  582,   64,   54,   40,  495,  651,  620,  580,   85,  582,

			   29,   29,   47,  580,   69,  582,  580,   73,  582,   67,
			   64,   41,   37,   33,   41,  102,  103,  104,  105,  106,
			  107,  108,  620,   33,   32,   77,  682,  683,  620,  685,
			  580,   49,  582,   75,   14,   15,   40,  620,  580,  580,
			  582,  582,   48,  620,   82,   47,  620,   39,   58,   29,
			   57,  495,  372,   33,  593,  281,  185,  247,  102,  103,
			  104,  105,  106,  107,  108,  172,  241,  568,  303,  128,
			  620,  128,  128,  489,  280,  301,  102,  303,  620,  620,
			  581,  274,  294,  309,  310,  568,  312,  524,  314,  315,
			  107,  568,  102,  103,  104,  105,  106,  107,  108,  568,

			  326,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,   32,  102,  103,  104,  105,  106,  107,  108,  461,
			  258,  685,  568,  568,  568,  567,   14,   98,  639,  136,
			  180,  651,  113,  691,  177,  230,  654,  324,  649,   67,
			  651,  377,  378,  379,  380,  381,  382,  383,  384,  385,
			  386,  387,  388,  389,  390,  391,  392,  393,  394,  395,
			  294,  681,  682,  461,  675,  685,  353,   33,  568,    0,
			  681,  682,  683,    0,  685,    0,    0,    0,    0,   45,
			    0,  417,    0,  370,  371,    0,  373,  374,  375,  110,

			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,   74,    0,
			    0,  398,  448,   26,    0,  451,    0,    0,    0,   85,
			   33,    0,   35,    0,    0,  412,    0,    0,   41,    0,
			  466,    0,   45,   33,    0,    0,  102,  103,  104,  105,
			  106,  107,  108,    0,    0,   58,    0,    0,  435,  436,
			  437,  438,  439,  440,  441,  442,  443,  444,  445,  446,
			  447,    0,  449,  450,    0,  452,  453,  454,  455,    0,
			    0,   84,    0,    0,   74,    0,    0,   90,   91,    0,
			    0,    0,    0,  470,    0,   85,    0,    0,    0,  102,

			  103,  104,  105,  106,  107,  108,    0,    0,    0,  486,
			  487,    0,  102,  103,  104,  105,  106,  107,  108,   14,
			   15,    0,    0,  500,    0,    0,   21,   22,   23,   24,
			    0,   26,    0,    0,   29,   30,   31,   32,   33,   34,
			   35,    0,    0,   38,    0,    0,   41,   42,    0,   44,
			   45,    0,   47,    0,    0,   50,   51,  583,   53,    0,
			    0,    0,    0,   58,    0,    4,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,  609,  610,    0,    0,    0,    0,   84,
			    0,    0,    0,    0,    0,   90,    0,    0,    0,    0,

			  626,  627,    0,  629,  630,  100,    0,  102,  103,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,  625,  675,
			    0,   33,    0,    0,    0,    0,    0,    0,  635,  636,
			   99,    0,  688,    0,  641,  642,  643,  644,  694,   14,
			   15,    0,    0,    0,    0,    0,   21,   22,   23,   24,
			    0,   26,    0,  709,   29,   30,   31,   32,   33,   34,
			   35,    0,   74,   38,    0,    0,   41,   42,    0,    0,

			   45,    0,   47,   85,    0,   50,   51,    0,   53,    0,
			    0,    0,    0,   58,    0,  692,   62,   63,   64,   65,
			  102,  103,  104,  105,  106,  107,  108,    0,  705,    0,
			    0,   77,    0,  710,    0,    0,    0,  714,    0,   84,
			    0,    0,    0,   89,    0,   90,    0,    0,    0,    0,
			    0,   97,   98,   99,    0,  100,    0,  102,  103,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,   14,   15,    0,    0,    0,    0,
			    0,   21,   22,   23,   24,    0,   26,    0,    0,   29,

			   30,   31,   32,   33,   34,   35,    0,    0,   38,    0,
			    0,   41,   42,    0,    0,   45,    0,   47,    0,    0,
			   50,   51,    0,   53,    0,    0,    0,    0,   58,    0,
			    0,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,    0,
			    0,    0,    0,    0,   84,    0,    0,    0,    0,    0,
			   90,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  100,    0,  102,  103,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,   14,

			   15,    0,    0,    0,    0,    0,   21,   22,   23,   24,
			    0,   26,    0,    0,   29,   30,   31,   32,   33,   34,
			   35,   94,    0,   38,    0,    0,   41,   42,    0,    0,
			   45,    0,   47,    0,    0,   50,   51,    0,    0,    0,
			    0,    0,    0,   58,    0,    0,    0,   62,    0,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,    0,    0,   84,
			    0,    0,    0,    0,    0,   90,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  100,    0,  102,  103,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,

			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,   14,   15,    0,    0,    0,    0,
			    0,   21,   22,   23,   24,    0,   26,    0,    0,   29,
			   30,   31,   32,   33,   34,   35,    0,    0,   38,   94,
			    0,   41,   42,    0,    0,   45,    0,   47,    0,    0,
			   50,   51,    0,    0,    0,    0,    0,    0,   58,    0,
			    0,    0,    0,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,    0,    0,    0,   84,    0,    0,    0,    0,    0,
			   90,    0,    0,    0,   94,    0,    0,    0,    0,    0,

			  100,    0,  102,  103,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,   14,
			   15,    0,    0,    0,    0,    0,   21,   22,   23,   24,
			   81,   26,    0,    0,   29,   30,   31,   32,   33,   34,
			   35,    0,    0,   38,    0,    0,   41,   42,    0,    0,
			   45,    0,   47,    0,    0,   50,   51,   14,   15,    0,
			    0,    0,    0,   58,    0,    0,   33,    0,    0,    0,
			    0,    0,   29,   30,   31,   32,   33,   34,   45,    0,
			   37,    0,    0,    0,    0,    0,    0,    0,    0,   84,

			    0,    0,    0,   50,   51,   90,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  100,    0,  102,  103,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,    0,  102,  103,  104,  105,  106,
			  107,  108,    0,   33,    0,  102,  103,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,   14,   15,    0,    0,    0,    0,   33,    0,
			    0,   36,    0,    0,    0,    0,    0,   29,   30,   31,

			   32,   33,   34,   48,    0,    0,    0,    0,    0,    0,
			   90,    0,    0,    0,    0,    0,    0,    0,   50,   51,
			    0,   66,  102,  103,  104,  105,  106,  107,  108,   14,
			   15,   33,    0,    0,   79,   37,    0,    0,    0,    0,
			    0,    0,    0,    0,   29,   30,   31,   32,   93,   34,
			    0,    0,    0,    0,    0,    0,    0,  102,  103,  104,
			  105,  106,  107,  108,    0,   50,   51,    0,    0,    0,
			  102,  103,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,   82,    0,    0,

			  102,  103,  104,  105,  106,  107,  108,    0,    0,    0,
			    0,   96,   26,    0,    0,    0,    0,    0,    0,   33,
			    0,    0,    0,    0,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,   58,    0,    0,    0,    0,   33,
			    0,    0,   36,    0,    0,    0,    0,    0,    0,    0,
			   74,   45,    0,    0,   33,    0,    0,    0,    0,    0,
			    0,   85,   33,    0,    0,    0,   90,   46,    0,    0,
			   33,    0,   66,    0,    0,    0,    0,    0,  102,  103,
			  104,  105,  106,  107,  108,   79,   57,    0,    0,   60,

			    0,    0,    0,   64,   57,   66,   33,   60,    0,   93,
			    0,   64,    0,   66,    0,    0,    0,   33,  102,  103,
			  104,  105,  106,  107,  108,   33,    0,    0,   36,   45,
			    0,    0,   93,  102,  103,  104,  105,  106,  107,  108,
			   93,  102,  103,  104,  105,  106,  107,  108,   33,  102,
			  103,  104,  105,  106,  107,  108,    0,    0,   66,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   79,    0,    0,   90,  102,  103,  104,  105,  106,
			  107,  108,    0,    0,    0,   93,  102,  103,  104,  105,
			  106,  107,  108,    0,  102,  103,  104,  105,  106,  107,

			  108,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,  102,  103,  104,
			  105,  106,  107,  108,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			    0,    0,    0,    0,   44,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   44,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,

			   21,  110,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,    0,  128,
			    0,    0,    0,   44,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,    7,    8,    9,   10,   11,   12,   13,   14,
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

	yyFinal: INTEGER is 721
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 129
			-- Number of tokens

	yyLast: INTEGER is 2056
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 383
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 302
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
