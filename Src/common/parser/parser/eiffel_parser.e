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
when 162 then
--|#line 911
	yy_do_action_162
when 163 then
--|#line 915
	yy_do_action_163
when 164 then
--|#line 917
	yy_do_action_164
when 166 then
--|#line 923
	yy_do_action_166
when 168 then
--|#line 929
	yy_do_action_168
when 169 then
--|#line 933
	yy_do_action_169
when 170 then
--|#line 938
	yy_do_action_170
when 171 then
--|#line 945
	yy_do_action_171
when 174 then
--|#line 953
	yy_do_action_174
when 175 then
--|#line 955
	yy_do_action_175
when 176 then
--|#line 957
	yy_do_action_176
when 177 then
--|#line 959
	yy_do_action_177
when 178 then
--|#line 961
	yy_do_action_178
when 179 then
--|#line 963
	yy_do_action_179
when 180 then
--|#line 965
	yy_do_action_180
when 181 then
--|#line 967
	yy_do_action_181
when 182 then
--|#line 969
	yy_do_action_182
when 183 then
--|#line 971
	yy_do_action_183
when 185 then
--|#line 977
	yy_do_action_185
when 186 then
--|#line 977
	yy_do_action_186
when 187 then
--|#line 984
	yy_do_action_187
when 188 then
--|#line 984
	yy_do_action_188
when 190 then
--|#line 995
	yy_do_action_190
when 191 then
--|#line 995
	yy_do_action_191
when 192 then
--|#line 1002
	yy_do_action_192
when 193 then
--|#line 1002
	yy_do_action_193
when 195 then
--|#line 1013
	yy_do_action_195
when 196 then
--|#line 1022
	yy_do_action_196
when 197 then
--|#line 1027
	yy_do_action_197
when 198 then
--|#line 1034
	yy_do_action_198
when 199 then
--|#line 1038
	yy_do_action_199
when 200 then
--|#line 1040
	yy_do_action_200
when 202 then
--|#line 1050
	yy_do_action_202
when 203 then
--|#line 1052
	yy_do_action_203
when 204 then
--|#line 1056
	yy_do_action_204
when 205 then
--|#line 1058
	yy_do_action_205
when 206 then
--|#line 1060
	yy_do_action_206
when 207 then
--|#line 1062
	yy_do_action_207
when 208 then
--|#line 1064
	yy_do_action_208
when 209 then
--|#line 1066
	yy_do_action_209
when 210 then
--|#line 1070
	yy_do_action_210
when 211 then
--|#line 1072
	yy_do_action_211
when 212 then
--|#line 1074
	yy_do_action_212
when 213 then
--|#line 1076
	yy_do_action_213
when 214 then
--|#line 1078
	yy_do_action_214
when 215 then
--|#line 1080
	yy_do_action_215
when 216 then
--|#line 1082
	yy_do_action_216
when 217 then
--|#line 1084
	yy_do_action_217
when 218 then
--|#line 1086
	yy_do_action_218
when 219 then
--|#line 1088
	yy_do_action_219
when 220 then
--|#line 1090
	yy_do_action_220
when 221 then
--|#line 1092
	yy_do_action_221
when 224 then
--|#line 1100
	yy_do_action_224
when 225 then
--|#line 1104
	yy_do_action_225
when 226 then
--|#line 1109
	yy_do_action_226
when 227 then
--|#line 1120
	yy_do_action_227
when 228 then
--|#line 1126
	yy_do_action_228
when 230 then
--|#line 1136
	yy_do_action_230
when 231 then
--|#line 1140
	yy_do_action_231
when 232 then
--|#line 1145
	yy_do_action_232
when 233 then
--|#line 1152
	yy_do_action_233
when 234 then
--|#line 1152
	yy_do_action_234
when 235 then
--|#line 1162
	yy_do_action_235
when 236 then
--|#line 1164
	yy_do_action_236
when 238 then
--|#line 1174
	yy_do_action_238
when 239 then
--|#line 1182
	yy_do_action_239
when 241 then
--|#line 1190
	yy_do_action_241
when 242 then
--|#line 1194
	yy_do_action_242
when 243 then
--|#line 1199
	yy_do_action_243
when 244 then
--|#line 1206
	yy_do_action_244
when 246 then
--|#line 1212
	yy_do_action_246
when 247 then
--|#line 1216
	yy_do_action_247
when 249 then
--|#line 1224
	yy_do_action_249
when 250 then
--|#line 1228
	yy_do_action_250
when 251 then
--|#line 1233
	yy_do_action_251
when 252 then
--|#line 1240
	yy_do_action_252
when 253 then
--|#line 1244
	yy_do_action_253
when 254 then
--|#line 1249
	yy_do_action_254
when 255 then
--|#line 1256
	yy_do_action_255
when 256 then
--|#line 1258
	yy_do_action_256
when 257 then
--|#line 1260
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
when 268 then
--|#line 1282
	yy_do_action_268
when 269 then
--|#line 1284
	yy_do_action_269
when 270 then
--|#line 1286
	yy_do_action_270
when 271 then
--|#line 1288
	yy_do_action_271
when 272 then
--|#line 1290
	yy_do_action_272
when 274 then
--|#line 1297
	yy_do_action_274
when 275 then
--|#line 1306
	yy_do_action_275
when 277 then
--|#line 1314
	yy_do_action_277
when 279 then
--|#line 1320
	yy_do_action_279
when 280 then
--|#line 1320
	yy_do_action_280
when 282 then
--|#line 1332
	yy_do_action_282
when 283 then
--|#line 1334
	yy_do_action_283
when 284 then
--|#line 1338
	yy_do_action_284
when 287 then
--|#line 1348
	yy_do_action_287
when 288 then
--|#line 1352
	yy_do_action_288
when 289 then
--|#line 1357
	yy_do_action_289
when 290 then
--|#line 1364
	yy_do_action_290
when 292 then
--|#line 1370
	yy_do_action_292
when 293 then
--|#line 1379
	yy_do_action_293
when 294 then
--|#line 1381
	yy_do_action_294
when 295 then
--|#line 1385
	yy_do_action_295
when 296 then
--|#line 1387
	yy_do_action_296
when 298 then
--|#line 1393
	yy_do_action_298
when 299 then
--|#line 1397
	yy_do_action_299
when 300 then
--|#line 1402
	yy_do_action_300
when 301 then
--|#line 1409
	yy_do_action_301
when 302 then
--|#line 1415
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
--|#line 1442
	yy_do_action_307
when 308 then
--|#line 1445
	yy_do_action_308
when 309 then
--|#line 1447
	yy_do_action_309
when 310 then
--|#line 1449
	yy_do_action_310
when 311 then
--|#line 1451
	yy_do_action_311
when 312 then
--|#line 1453
	yy_do_action_312
when 313 then
--|#line 1455
	yy_do_action_313
when 314 then
--|#line 1457
	yy_do_action_314
when 315 then
--|#line 1459
	yy_do_action_315
when 316 then
--|#line 1461
	yy_do_action_316
when 317 then
--|#line 1463
	yy_do_action_317
when 318 then
--|#line 1465
	yy_do_action_318
when 319 then
--|#line 1467
	yy_do_action_319
when 320 then
--|#line 1469
	yy_do_action_320
when 322 then
--|#line 1475
	yy_do_action_322
when 323 then
--|#line 1479
	yy_do_action_323
when 324 then
--|#line 1484
	yy_do_action_324
when 325 then
--|#line 1491
	yy_do_action_325
when 326 then
--|#line 1493
	yy_do_action_326
when 327 then
--|#line 1495
	yy_do_action_327
when 328 then
--|#line 1497
	yy_do_action_328
when 329 then
--|#line 1499
	yy_do_action_329
when 330 then
--|#line 1501
	yy_do_action_330
when 331 then
--|#line 1503
	yy_do_action_331
when 332 then
--|#line 1505
	yy_do_action_332
when 333 then
--|#line 1507
	yy_do_action_333
when 334 then
--|#line 1509
	yy_do_action_334
when 335 then
--|#line 1511
	yy_do_action_335
when 336 then
--|#line 1513
	yy_do_action_336
when 337 then
--|#line 1515
	yy_do_action_337
when 338 then
--|#line 1517
	yy_do_action_338
when 339 then
--|#line 1519
	yy_do_action_339
when 340 then
--|#line 1523
	yy_do_action_340
when 341 then
--|#line 1525
	yy_do_action_341
when 342 then
--|#line 1527
	yy_do_action_342
when 343 then
--|#line 1531
	yy_do_action_343
when 344 then
--|#line 1533
	yy_do_action_344
when 346 then
--|#line 1539
	yy_do_action_346
when 347 then
--|#line 1543
	yy_do_action_347
when 348 then
--|#line 1545
	yy_do_action_348
when 350 then
--|#line 1551
	yy_do_action_350
when 351 then
--|#line 1559
	yy_do_action_351
when 352 then
--|#line 1561
	yy_do_action_352
when 353 then
--|#line 1563
	yy_do_action_353
when 354 then
--|#line 1565
	yy_do_action_354
when 355 then
--|#line 1567
	yy_do_action_355
when 356 then
--|#line 1569
	yy_do_action_356
when 357 then
--|#line 1571
	yy_do_action_357
when 358 then
--|#line 1573
	yy_do_action_358
when 359 then
--|#line 1575
	yy_do_action_359
when 360 then
--|#line 1579
	yy_do_action_360
when 361 then
--|#line 1587
	yy_do_action_361
when 362 then
--|#line 1589
	yy_do_action_362
when 363 then
--|#line 1591
	yy_do_action_363
when 364 then
--|#line 1593
	yy_do_action_364
when 365 then
--|#line 1595
	yy_do_action_365
when 366 then
--|#line 1597
	yy_do_action_366
when 367 then
--|#line 1599
	yy_do_action_367
when 368 then
--|#line 1601
	yy_do_action_368
when 369 then
--|#line 1603
	yy_do_action_369
when 370 then
--|#line 1605
	yy_do_action_370
when 371 then
--|#line 1607
	yy_do_action_371
when 372 then
--|#line 1609
	yy_do_action_372
when 373 then
--|#line 1611
	yy_do_action_373
when 374 then
--|#line 1613
	yy_do_action_374
when 375 then
--|#line 1615
	yy_do_action_375
when 376 then
--|#line 1617
	yy_do_action_376
when 377 then
--|#line 1619
	yy_do_action_377
when 378 then
--|#line 1621
	yy_do_action_378
when 379 then
--|#line 1623
	yy_do_action_379
when 380 then
--|#line 1625
	yy_do_action_380
when 381 then
--|#line 1627
	yy_do_action_381
when 382 then
--|#line 1629
	yy_do_action_382
when 383 then
--|#line 1631
	yy_do_action_383
when 384 then
--|#line 1633
	yy_do_action_384
when 385 then
--|#line 1635
	yy_do_action_385
when 386 then
--|#line 1637
	yy_do_action_386
when 387 then
--|#line 1639
	yy_do_action_387
when 388 then
--|#line 1641
	yy_do_action_388
when 389 then
--|#line 1643
	yy_do_action_389
when 390 then
--|#line 1645
	yy_do_action_390
when 391 then
--|#line 1647
	yy_do_action_391
when 392 then
--|#line 1649
	yy_do_action_392
when 393 then
--|#line 1651
	yy_do_action_393
when 394 then
--|#line 1653
	yy_do_action_394
when 395 then
--|#line 1655
	yy_do_action_395
when 396 then
--|#line 1657
	yy_do_action_396
when 397 then
--|#line 1661
	yy_do_action_397
when 398 then
--|#line 1669
	yy_do_action_398
when 399 then
--|#line 1671
	yy_do_action_399
when 400 then
--|#line 1673
	yy_do_action_400
when 401 then
--|#line 1675
	yy_do_action_401
when 402 then
--|#line 1677
	yy_do_action_402
when 403 then
--|#line 1679
	yy_do_action_403
when 404 then
--|#line 1681
	yy_do_action_404
when 405 then
--|#line 1683
	yy_do_action_405
when 406 then
--|#line 1685
	yy_do_action_406
when 407 then
--|#line 1687
	yy_do_action_407
when 408 then
--|#line 1689
	yy_do_action_408
when 409 then
--|#line 1691
	yy_do_action_409
when 410 then
--|#line 1695
	yy_do_action_410
when 411 then
--|#line 1699
	yy_do_action_411
when 412 then
--|#line 1703
	yy_do_action_412
when 413 then
--|#line 1707
	yy_do_action_413
when 414 then
--|#line 1711
	yy_do_action_414
when 415 then
--|#line 1715
	yy_do_action_415
when 416 then
--|#line 1717
	yy_do_action_416
when 417 then
--|#line 1719
	yy_do_action_417
when 418 then
--|#line 1721
	yy_do_action_418
when 419 then
--|#line 1723
	yy_do_action_419
when 420 then
--|#line 1725
	yy_do_action_420
when 421 then
--|#line 1727
	yy_do_action_421
when 422 then
--|#line 1729
	yy_do_action_422
when 423 then
--|#line 1731
	yy_do_action_423
when 424 then
--|#line 1733
	yy_do_action_424
when 425 then
--|#line 1735
	yy_do_action_425
when 426 then
--|#line 1737
	yy_do_action_426
when 427 then
--|#line 1739
	yy_do_action_427
when 428 then
--|#line 1741
	yy_do_action_428
when 429 then
--|#line 1745
	yy_do_action_429
when 430 then
--|#line 1749
	yy_do_action_430
when 431 then
--|#line 1756
	yy_do_action_431
when 432 then
--|#line 1764
	yy_do_action_432
when 433 then
--|#line 1766
	yy_do_action_433
when 434 then
--|#line 1770
	yy_do_action_434
when 435 then
--|#line 1772
	yy_do_action_435
when 436 then
--|#line 1776
	yy_do_action_436
when 437 then
--|#line 1789
	yy_do_action_437
when 440 then
--|#line 1797
	yy_do_action_440
when 441 then
--|#line 1801
	yy_do_action_441
when 442 then
--|#line 1806
	yy_do_action_442
when 443 then
--|#line 1813
	yy_do_action_443
when 444 then
--|#line 1815
	yy_do_action_444
when 445 then
--|#line 1819
	yy_do_action_445
when 446 then
--|#line 1824
	yy_do_action_446
when 447 then
--|#line 1835
	yy_do_action_447
when 448 then
--|#line 1837
	yy_do_action_448
when 449 then
--|#line 1839
	yy_do_action_449
when 450 then
--|#line 1841
	yy_do_action_450
when 451 then
--|#line 1843
	yy_do_action_451
when 452 then
--|#line 1845
	yy_do_action_452
when 453 then
--|#line 1847
	yy_do_action_453
when 454 then
--|#line 1849
	yy_do_action_454
when 455 then
--|#line 1851
	yy_do_action_455
when 456 then
--|#line 1853
	yy_do_action_456
when 457 then
--|#line 1855
	yy_do_action_457
when 458 then
--|#line 1857
	yy_do_action_458
when 459 then
--|#line 1861
	yy_do_action_459
when 460 then
--|#line 1863
	yy_do_action_460
when 461 then
--|#line 1865
	yy_do_action_461
when 462 then
--|#line 1867
	yy_do_action_462
when 463 then
--|#line 1869
	yy_do_action_463
when 464 then
--|#line 1871
	yy_do_action_464
when 465 then
--|#line 1875
	yy_do_action_465
when 466 then
--|#line 1877
	yy_do_action_466
when 467 then
--|#line 1879
	yy_do_action_467
when 468 then
--|#line 1894
	yy_do_action_468
when 469 then
--|#line 1896
	yy_do_action_469
when 470 then
--|#line 1898
	yy_do_action_470
when 471 then
--|#line 1902
	yy_do_action_471
when 472 then
--|#line 1904
	yy_do_action_472
when 473 then
--|#line 1908
	yy_do_action_473
when 474 then
--|#line 1915
	yy_do_action_474
when 475 then
--|#line 1930
	yy_do_action_475
when 476 then
--|#line 1945
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
--|#line 1974
	yy_do_action_480
when 481 then
--|#line 1978
	yy_do_action_481
when 482 then
--|#line 1980
	yy_do_action_482
when 483 then
--|#line 1982
	yy_do_action_483
when 484 then
--|#line 1986
	yy_do_action_484
when 485 then
--|#line 1988
	yy_do_action_485
when 486 then
--|#line 1990
	yy_do_action_486
when 487 then
--|#line 1992
	yy_do_action_487
when 488 then
--|#line 1994
	yy_do_action_488
when 489 then
--|#line 1996
	yy_do_action_489
when 490 then
--|#line 1998
	yy_do_action_490
when 491 then
--|#line 2000
	yy_do_action_491
when 492 then
--|#line 2002
	yy_do_action_492
when 493 then
--|#line 2004
	yy_do_action_493
when 494 then
--|#line 2006
	yy_do_action_494
when 495 then
--|#line 2008
	yy_do_action_495
when 496 then
--|#line 2010
	yy_do_action_496
when 497 then
--|#line 2012
	yy_do_action_497
when 498 then
--|#line 2014
	yy_do_action_498
when 499 then
--|#line 2016
	yy_do_action_499
when 500 then
--|#line 2018
	yy_do_action_500
when 501 then
--|#line 2020
	yy_do_action_501
when 502 then
--|#line 2022
	yy_do_action_502
when 503 then
--|#line 2024
	yy_do_action_503
when 504 then
--|#line 2026
	yy_do_action_504
when 505 then
--|#line 2030
	yy_do_action_505
when 506 then
--|#line 2032
	yy_do_action_506
when 507 then
--|#line 2034
	yy_do_action_507
when 508 then
--|#line 2036
	yy_do_action_508
when 509 then
--|#line 2040
	yy_do_action_509
when 510 then
--|#line 2042
	yy_do_action_510
when 511 then
--|#line 2044
	yy_do_action_511
when 512 then
--|#line 2046
	yy_do_action_512
when 513 then
--|#line 2048
	yy_do_action_513
when 514 then
--|#line 2050
	yy_do_action_514
when 515 then
--|#line 2052
	yy_do_action_515
when 516 then
--|#line 2054
	yy_do_action_516
when 517 then
--|#line 2056
	yy_do_action_517
when 518 then
--|#line 2058
	yy_do_action_518
when 519 then
--|#line 2060
	yy_do_action_519
when 520 then
--|#line 2062
	yy_do_action_520
when 521 then
--|#line 2064
	yy_do_action_521
when 522 then
--|#line 2066
	yy_do_action_522
when 523 then
--|#line 2068
	yy_do_action_523
when 524 then
--|#line 2070
	yy_do_action_524
when 525 then
--|#line 2072
	yy_do_action_525
when 526 then
--|#line 2074
	yy_do_action_526
when 527 then
--|#line 2078
	yy_do_action_527
when 528 then
--|#line 2082
	yy_do_action_528
when 530 then
--|#line 2090
	yy_do_action_530
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
				fclause_pos := clone (current_position)
			

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

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (yytype6 (yyvs.item (yyvsp - 1))))
				feature_indexes := yytype75 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_90 is
			--|#line 599
		local
			yyval15: CONTENT_AS
		do

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (new_unique_as))
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
				yytype44 (yyvs.item (yyvsp)).set_location (yytype91 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_98 is
			--|#line 640
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := yytype44 (yyvs.item (yyvsp - 1))
				yytype44 (yyvs.item (yyvsp - 1)).set_location (yytype91 (yyvs.item (yyvsp - 2)))
			
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
				real_class_end_position := current_position.end_position - 3
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

yyval53 := new_routine_as (yytype55 (yyvs.item (yyvsp - 7)), yytype49 (yyvs.item (yyvsp - 5)), yytype84 (yyvs.item (yyvsp - 4)), yytype52 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), fbody_pos, current_position) 
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

yyval25 := new_external_lang_as (yytype55 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
		end

	yy_do_action_162 is
			--|#line 911
		local
			yyval55: STRING_AS
		do

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_163 is
			--|#line 915
		local
			yyval37: INTERNAL_AS
		do

yyval37 := new_do_as (yytype76 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_164 is
			--|#line 917
		local
			yyval37: INTERNAL_AS
		do

yyval37 := new_once_as (yytype76 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_166 is
			--|#line 923
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_168 is
			--|#line 929
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_169 is
			--|#line 933
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval76.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_170 is
			--|#line 938
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp - 1))
				yyval76.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_171 is
			--|#line 945
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype35 (yyvs.item (yyvsp - 1)) 
			yyval := yyval35
		end

	yy_do_action_174 is
			--|#line 953
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_175 is
			--|#line 955
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_176 is
			--|#line 957
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_177 is
			--|#line 959
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype51 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_178 is
			--|#line 961
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype31 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_179 is
			--|#line 963
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_180 is
			--|#line 965
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype40 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_181 is
			--|#line 967
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_182 is
			--|#line 969
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_183 is
			--|#line 971
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype50 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_185 is
			--|#line 977
		local
			yyval49: REQUIRE_AS
		do

				id_level := Normal_level
				yyval49 := new_require_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval49
		end

	yy_do_action_186 is
			--|#line 977
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_187 is
			--|#line 984
		local
			yyval49: REQUIRE_AS
		do

				id_level := Normal_level
				yyval49 := new_require_else_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval49
		end

	yy_do_action_188 is
			--|#line 984
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_190 is
			--|#line 995
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_191 is
			--|#line 995
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_192 is
			--|#line 1002
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_then_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_193 is
			--|#line 1002
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_195 is
			--|#line 1013
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

				yyval82 := yytype82 (yyvs.item (yyvsp))
				if yyval82.is_empty then
					yyval82 := Void
				end
			
			yyval := yyval82
		end

	yy_do_action_196 is
			--|#line 1022
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

				yyval82 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval82, yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_197 is
			--|#line 1027
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

				yyval82 := yytype82 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval82, yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_198 is
			--|#line 1034
		local
			yyval56: TAGGED_AS
		do

yyval56 := yytype56 (yyvs.item (yyvsp - 1)) 
			yyval := yyval56
		end

	yy_do_action_199 is
			--|#line 1038
		local
			yyval56: TAGGED_AS
		do

yyval56 := new_tagged_as (Void, yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval56
		end

	yy_do_action_200 is
			--|#line 1040
		local
			yyval56: TAGGED_AS
		do

yyval56 := new_tagged_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval56
		end

	yy_do_action_202 is
			--|#line 1050
		local
			yyval58: TYPE
		do

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_203 is
			--|#line 1052
		local
			yyval58: TYPE
		do

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_204 is
			--|#line 1056
		local
			yyval58: TYPE
		do

yyval58 := new_expanded_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_205 is
			--|#line 1058
		local
			yyval58: TYPE
		do

yyval58 := new_separate_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_206 is
			--|#line 1060
		local
			yyval58: TYPE
		do

yyval58 := new_bits_as (yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_207 is
			--|#line 1062
		local
			yyval58: TYPE
		do

yyval58 := new_bits_symbol_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_208 is
			--|#line 1064
		local
			yyval58: TYPE
		do

yyval58 := new_like_id_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_209 is
			--|#line 1066
		local
			yyval58: TYPE
		do

yyval58 := new_like_current_as 
			yyval := yyval58
		end

	yy_do_action_210 is
			--|#line 1070
		local
			yyval58: TYPE
		do

yyval58 := new_class_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_211 is
			--|#line 1072
		local
			yyval58: TYPE
		do

yyval58 := new_boolean_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_212 is
			--|#line 1074
		local
			yyval58: TYPE
		do

yyval58 := new_character_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, False) 
			yyval := yyval58
		end

	yy_do_action_213 is
			--|#line 1076
		local
			yyval58: TYPE
		do

yyval58 := new_character_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, True) 
			yyval := yyval58
		end

	yy_do_action_214 is
			--|#line 1078
		local
			yyval58: TYPE
		do

yyval58 := new_double_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_215 is
			--|#line 1080
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 8) 
			yyval := yyval58
		end

	yy_do_action_216 is
			--|#line 1082
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 16) 
			yyval := yyval58
		end

	yy_do_action_217 is
			--|#line 1084
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 32) 
			yyval := yyval58
		end

	yy_do_action_218 is
			--|#line 1086
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 64) 
			yyval := yyval58
		end

	yy_do_action_219 is
			--|#line 1088
		local
			yyval58: TYPE
		do

yyval58 := new_none_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_220 is
			--|#line 1090
		local
			yyval58: TYPE
		do

yyval58 := new_pointer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_221 is
			--|#line 1092
		local
			yyval58: TYPE
		do

yyval58 := new_real_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_224 is
			--|#line 1100
		local
			yyval83: EIFFEL_LIST [TYPE]
		do

yyval83 := yytype83 (yyvs.item (yyvsp - 1)) 
			yyval := yyval83
		end

	yy_do_action_225 is
			--|#line 1104
		local
			yyval83: EIFFEL_LIST [TYPE]
		do

				yyval83 := new_eiffel_list_type (Initial_type_list_size)
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_226 is
			--|#line 1109
		local
			yyval83: EIFFEL_LIST [TYPE]
		do

				yyval83 := yytype83 (yyvs.item (yyvsp - 2))
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_227 is
			--|#line 1120
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				-- $$ := Void
				formal_generics_start_position := current_position.start_position
				formal_generics_end_position := 0
			
			yyval := yyval71
		end

	yy_do_action_228 is
			--|#line 1126
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 1))
				formal_generics_start_position := yytype91 (yyvs.item (yyvsp - 3)).start_position
				formal_generics_end_position := current_position.start_position
			
			yyval := yyval71
		end

	yy_do_action_230 is
			--|#line 1136
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

yyval71 := yytype71 (yyvs.item (yyvsp)) 
			yyval := yyval71
		end

	yy_do_action_231 is
			--|#line 1140
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval71 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval71.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_232 is
			--|#line 1145
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_233 is
			--|#line 1152
		local
			yyval29: FORMAL_DEC_AS
		do

				check formal_exists: not formal_parameters.is_empty end
				yyval29 := new_formal_dec_as (formal_parameters.last, yytype90 (yyvs.item (yyvsp)).first, yytype90 (yyvs.item (yyvsp)).second, formal_parameters.count)
			
			yyval := yyval29
		end

	yy_do_action_234 is
			--|#line 1152
		local

		do
			yyval := yyval_default;
formal_parameters.extend (new_id_as (token_buffer)) 

		end

	yy_do_action_235 is
			--|#line 1162
		local
			yyval90: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do

create yyval90 
			yyval := yyval90
		end

	yy_do_action_236 is
			--|#line 1164
		local
			yyval90: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do

				create yyval90
				yyval90.set_first (yytype58 (yyvs.item (yyvsp - 1)))
				yyval90.set_second (yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval90
		end

	yy_do_action_238 is
			--|#line 1174
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp - 1)) 
			yyval := yyval70
		end

	yy_do_action_239 is
			--|#line 1182
		local
			yyval31: IF_AS
		do

				yyval31 := new_if_as (yytype23 (yyvs.item (yyvsp - 5)), yytype76 (yyvs.item (yyvsp - 3)), yytype64 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 7)))
			
			yyval := yyval31
		end

	yy_do_action_241 is
			--|#line 1190
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_242 is
			--|#line 1194
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do

				yyval64 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval64.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_243 is
			--|#line 1199
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do

				yyval64 := yytype64 (yyvs.item (yyvsp - 1))
				yyval64.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_244 is
			--|#line 1206
		local
			yyval20: ELSIF_AS
		do

yyval20 := new_elseif_as (yytype23 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 4))) 
			yyval := yyval20
		end

	yy_do_action_246 is
			--|#line 1212
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_247 is
			--|#line 1216
		local
			yyval33: INSPECT_AS
		do

				yyval33 := new_inspect_as (yytype23 (yyvs.item (yyvsp - 3)), yytype62 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)))
			
			yyval := yyval33
		end

	yy_do_action_249 is
			--|#line 1224
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do

yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
		end

	yy_do_action_250 is
			--|#line 1228
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do

				yyval62 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval62.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_251 is
			--|#line 1233
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do

				yyval62 := yytype62 (yyvs.item (yyvsp - 1))
				yyval62.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_252 is
			--|#line 1240
		local
			yyval11: CASE_AS
		do

yyval11 := new_case_as (yytype77 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval11
		end

	yy_do_action_253 is
			--|#line 1244
		local
			yyval77: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval77 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval77.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_254 is
			--|#line 1249
		local
			yyval77: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval77 := yytype77 (yyvs.item (yyvsp - 2))
				yyval77.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_255 is
			--|#line 1256
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_256 is
			--|#line 1258
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_257 is
			--|#line 1260
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_258 is
			--|#line 1262
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_259 is
			--|#line 1264
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_260 is
			--|#line 1266
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_261 is
			--|#line 1268
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
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

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_264 is
			--|#line 1274
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_265 is
			--|#line 1276
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_266 is
			--|#line 1278
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_267 is
			--|#line 1280
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_268 is
			--|#line 1282
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_269 is
			--|#line 1284
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_270 is
			--|#line 1286
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_271 is
			--|#line 1288
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_272 is
			--|#line 1290
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_274 is
			--|#line 1297
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp))
				if yyval76 = Void then
					yyval76 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval76
		end

	yy_do_action_275 is
			--|#line 1306
		local
			yyval40: LOOP_AS
		do

				yyval40 := new_loop_as (yytype76 (yyvs.item (yyvsp - 8)), yytype82 (yyvs.item (yyvsp - 7)), yytype60 (yyvs.item (yyvsp - 6)), yytype23 (yyvs.item (yyvsp - 3)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)))
			
			yyval := yyval40
		end

	yy_do_action_277 is
			--|#line 1314
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
		end

	yy_do_action_279 is
			--|#line 1320
		local
			yyval39: INVARIANT_AS
		do

				id_level := Normal_level
				inherit_context := False
				yyval39 := new_invariant_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval39
		end

	yy_do_action_280 is
			--|#line 1320
		local

		do
			yyval := yyval_default;
id_level := Invariant_level 

		end

	yy_do_action_282 is
			--|#line 1332
		local
			yyval60: VARIANT_AS
		do

yyval60 := new_variant_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval60
		end

	yy_do_action_283 is
			--|#line 1334
		local
			yyval60: VARIANT_AS
		do

yyval60 := new_variant_as (Void, yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval60
		end

	yy_do_action_284 is
			--|#line 1338
		local
			yyval19: DEBUG_AS
		do

				yyval19 := new_debug_as (yytype81 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)))
			
			yyval := yyval19
		end

	yy_do_action_287 is
			--|#line 1348
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do

yyval81 := yytype81 (yyvs.item (yyvsp - 1)) 
			yyval := yyval81
		end

	yy_do_action_288 is
			--|#line 1352
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do

				yyval81 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval81.extend (yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_289 is
			--|#line 1357
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do

				yyval81 := yytype81 (yyvs.item (yyvsp - 2))
				yyval81.extend (yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_290 is
			--|#line 1364
		local
			yyval50: RETRY_AS
		do

yyval50 := new_retry_as (current_position) 
			yyval := yyval50
		end

	yy_do_action_292 is
			--|#line 1370
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp))
				if yyval76 = Void then
					yyval76 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval76
		end

	yy_do_action_293 is
			--|#line 1379
		local
			yyval5: ASSIGN_AS
		do

yyval5 := new_assign_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_294 is
			--|#line 1381
		local
			yyval5: ASSIGN_AS
		do

yyval5 := new_assign_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_295 is
			--|#line 1385
		local
			yyval51: REVERSE_AS
		do

yyval51 := new_reverse_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval51
		end

	yy_do_action_296 is
			--|#line 1387
		local
			yyval51: REVERSE_AS
		do

yyval51 := new_reverse_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval51
		end

	yy_do_action_298 is
			--|#line 1393
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_299 is
			--|#line 1397
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do

				yyval63 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval63.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_300 is
			--|#line 1402
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do

				yyval63 := yytype63 (yyvs.item (yyvsp - 1))
				yyval63.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_301 is
			--|#line 1409
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_302 is
			--|#line 1415
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_303 is
			--|#line 1420
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype72 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_304 is
			--|#line 1425
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_305 is
			--|#line 1430
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_306 is
			--|#line 1435
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype72 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_307 is
			--|#line 1442
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_result_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_308 is
			--|#line 1445
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_309 is
			--|#line 1447
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 3)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_310 is
			--|#line 1449
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 4))), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_311 is
			--|#line 1451
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (yytype58 (yyvs.item (yyvsp - 4)), Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_312 is
			--|#line 1453
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (Void, yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_313 is
			--|#line 1455
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_314 is
			--|#line 1457
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_result_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_315 is
			--|#line 1459
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_316 is
			--|#line 1461
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 3)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_317 is
			--|#line 1463
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_As (new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 4))), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_318 is
			--|#line 1465
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (yytype58 (yyvs.item (yyvsp - 3)), Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_319 is
			--|#line 1467
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (Void, yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_320 is
			--|#line 1469
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_322 is
			--|#line 1475
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do

yyval78 := yytype78 (yyvs.item (yyvsp - 1)) 
			yyval := yyval78
		end

	yy_do_action_323 is
			--|#line 1479
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do

				yyval78 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval78.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_324 is
			--|#line 1484
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do

				yyval78 := yytype78 (yyvs.item (yyvsp - 2))
				yyval78.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_325 is
			--|#line 1491
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, Void) 
			yyval := yyval43
		end

	yy_do_action_326 is
			--|#line 1493
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval43
		end

	yy_do_action_327 is
			--|#line 1495
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_class_type (yytype86 (yyvs.item (yyvsp - 2)), yytype83 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_328 is
			--|#line 1497
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_boolean_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_329 is
			--|#line 1499
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_character_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, False), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_330 is
			--|#line 1501
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_character_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, True), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_331 is
			--|#line 1503
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_double_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_332 is
			--|#line 1505
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 8), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_333 is
			--|#line 1507
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 16), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_334 is
			--|#line 1509
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 32), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_335 is
			--|#line 1511
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 64), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_336 is
			--|#line 1513
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_none_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_337 is
			--|#line 1515
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_pointer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_338 is
			--|#line 1517
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_real_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_339 is
			--|#line 1519
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (yytype58 (yyvs.item (yyvsp - 1)), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_340 is
			--|#line 1523
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (yytype58 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 5))) 
			yyval := yyval17
		end

	yy_do_action_341 is
			--|#line 1525
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (Void, yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval17
		end

	yy_do_action_342 is
			--|#line 1527
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (yytype58 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 6))) 
			yyval := yyval17
		end

	yy_do_action_343 is
			--|#line 1531
		local
			yyval18: CREATION_EXPR_AS
		do

yyval18 := new_creation_expr_as (yytype58 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval18
		end

	yy_do_action_344 is
			--|#line 1533
		local
			yyval18: CREATION_EXPR_AS
		do

yyval18 := new_creation_expr_as (yytype58 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval18
		end

	yy_do_action_346 is
			--|#line 1539
		local
			yyval58: TYPE
		do

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_347 is
			--|#line 1543
		local
			yyval1: ACCESS_AS
		do

yyval1 := new_access_id_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval1
		end

	yy_do_action_348 is
			--|#line 1545
		local
			yyval1: ACCESS_AS
		do

yyval1 := new_result_as 
			yyval := yyval1
		end

	yy_do_action_350 is
			--|#line 1551
		local
			yyval3: ACCESS_INV_AS
		do

yyval3 := new_access_inv_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_351 is
			--|#line 1559
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype1 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_352 is
			--|#line 1561
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_353 is
			--|#line 1563
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_354 is
			--|#line 1565
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_355 is
			--|#line 1567
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_356 is
			--|#line 1569
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype45 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_357 is
			--|#line 1571
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_358 is
			--|#line 1573
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype46 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_359 is
			--|#line 1575
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_360 is
			--|#line 1579
		local
			yyval13: CHECK_AS
		do

yyval13 := new_check_as (yytype82 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval13
		end

	yy_do_action_361 is
			--|#line 1587
		local
			yyval23: EXPR_AS
		do

create {VALUE_AS} yyval23.initialize (yytype6 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_362 is
			--|#line 1589
		local
			yyval23: EXPR_AS
		do

create {VALUE_AS} yyval23.initialize (yytype4 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_363 is
			--|#line 1591
		local
			yyval23: EXPR_AS
		do

create {VALUE_AS} yyval23.initialize (yytype57 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_364 is
			--|#line 1593
		local
			yyval23: EXPR_AS
		do

yyval23 := new_expr_call_as (yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_365 is
			--|#line 1595
		local
			yyval23: EXPR_AS
		do

yyval23 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_366 is
			--|#line 1597
		local
			yyval23: EXPR_AS
		do

yyval23 := new_paran_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_367 is
			--|#line 1599
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_plus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_368 is
			--|#line 1601
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_minus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_369 is
			--|#line 1603
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_star_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_370 is
			--|#line 1605
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_slash_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_371 is
			--|#line 1607
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_mod_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_372 is
			--|#line 1609
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_div_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_373 is
			--|#line 1611
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_power_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_374 is
			--|#line 1613
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_and_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_375 is
			--|#line 1615
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_and_then_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_376 is
			--|#line 1617
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_or_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_377 is
			--|#line 1619
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_or_else_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_378 is
			--|#line 1621
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_implies_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_379 is
			--|#line 1623
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_xor_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_380 is
			--|#line 1625
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_ge_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_381 is
			--|#line 1627
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_gt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_382 is
			--|#line 1629
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_le_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_383 is
			--|#line 1631
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_lt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_384 is
			--|#line 1633
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_eq_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_385 is
			--|#line 1635
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_ne_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_386 is
			--|#line 1637
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_free_as (yytype23 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_387 is
			--|#line 1639
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_minus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_388 is
			--|#line 1641
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_plus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_389 is
			--|#line 1643
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_not_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_390 is
			--|#line 1645
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_old_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_391 is
			--|#line 1647
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_free_as (yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_392 is
			--|#line 1649
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_strip_as (yytype74 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_393 is
			--|#line 1651
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_as (yytype87 (yyvs.item (yyvsp)).first) 
			yyval := yyval23
		end

	yy_do_action_394 is
			--|#line 1653
		local
			yyval23: EXPR_AS
		do

yyval23 := new_expr_address_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_395 is
			--|#line 1655
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_current_as 
			yyval := yyval23
		end

	yy_do_action_396 is
			--|#line 1657
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_result_as 
			yyval := yyval23
		end

	yy_do_action_397 is
			--|#line 1661
		local
			yyval30: ID_AS
		do

yyval30 := new_id_as (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_398 is
			--|#line 1669
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_399 is
			--|#line 1671
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_400 is
			--|#line 1673
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_401 is
			--|#line 1675
		local
			yyval10: CALL_AS
		do

yyval10 := new_current_as 
			yyval := yyval10
		end

	yy_do_action_402 is
			--|#line 1677
		local
			yyval10: CALL_AS
		do

yyval10 := new_result_as 
			yyval := yyval10
		end

	yy_do_action_403 is
			--|#line 1679
		local
			yyval10: CALL_AS
		do

yyval10 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_404 is
			--|#line 1681
		local
			yyval10: CALL_AS
		do

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_405 is
			--|#line 1683
		local
			yyval10: CALL_AS
		do

yyval10 := yytype45 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_406 is
			--|#line 1685
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_407 is
			--|#line 1687
		local
			yyval10: CALL_AS
		do

yyval10 := yytype46 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_408 is
			--|#line 1689
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_409 is
			--|#line 1691
		local
			yyval10: CALL_AS
		do

yyval10 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_410 is
			--|#line 1695
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (new_current_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_411 is
			--|#line 1699
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (new_result_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_412 is
			--|#line 1703
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype1 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_413 is
			--|#line 1707
		local
			yyval42: NESTED_EXPR_AS
		do

yyval42 := new_nested_expr_as (yytype23 (yyvs.item (yyvsp - 3)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_414 is
			--|#line 1711
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype45 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_415 is
			--|#line 1715
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor_as (Void, yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_416 is
			--|#line 1717
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_417 is
			--|#line 1719
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 2)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_418 is
			--|#line 1721
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_419 is
			--|#line 1723
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_420 is
			--|#line 1725
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_421 is
			--|#line 1727
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_422 is
			--|#line 1729
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_423 is
			--|#line 1731
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_424 is
			--|#line 1733
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_425 is
			--|#line 1735
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_426 is
			--|#line 1737
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_427 is
			--|#line 1739
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_428 is
			--|#line 1741
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_429 is
			--|#line 1745
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype46 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_430 is
			--|#line 1749
		local
			yyval46: STATIC_ACCESS_AS
		do

				yyval46 := new_static_access_as (new_class_type (yytype86 (yyvs.item (yyvsp - 4)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp)));
			
			yyval := yyval46
		end

	yy_do_action_431 is
			--|#line 1756
		local
			yyval46: STATIC_ACCESS_AS
		do

				yyval46 := new_static_access_as (new_class_type (yytype86 (yyvs.item (yyvsp - 3)), Void), yytype30 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval46
		end

	yy_do_action_432 is
			--|#line 1764
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_433 is
			--|#line 1766
		local
			yyval10: CALL_AS
		do

yyval10 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_434 is
			--|#line 1770
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_435 is
			--|#line 1772
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype41 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_436 is
			--|#line 1776
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

	yy_do_action_437 is
			--|#line 1789
		local
			yyval2: ACCESS_FEAT_AS
		do

yyval2 := new_access_feat_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval2
		end

	yy_do_action_440 is
			--|#line 1797
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

yyval66 := yytype66 (yyvs.item (yyvsp - 1)) 
			yyval := yyval66
		end

	yy_do_action_441 is
			--|#line 1801
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_442 is
			--|#line 1806
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := yytype66 (yyvs.item (yyvsp - 2))
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_443 is
			--|#line 1813
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

yyval66 := new_eiffel_list_expr_as (0) 
			yyval := yyval66
		end

	yy_do_action_444 is
			--|#line 1815
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

yyval66 := yytype66 (yyvs.item (yyvsp)) 
			yyval := yyval66
		end

	yy_do_action_445 is
			--|#line 1819
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_446 is
			--|#line 1824
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := yytype66 (yyvs.item (yyvsp - 2))
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_447 is
			--|#line 1835
		local
			yyval30: ID_AS
		do

yyval30 := new_id_as (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_448 is
			--|#line 1837
		local
			yyval30: ID_AS
		do

yyval30 := new_boolean_id_as 
			yyval := yyval30
		end

	yy_do_action_449 is
			--|#line 1839
		local
			yyval30: ID_AS
		do

yyval30 := new_character_id_as (False) 
			yyval := yyval30
		end

	yy_do_action_450 is
			--|#line 1841
		local
			yyval30: ID_AS
		do

yyval30 := new_character_id_as (True) 
			yyval := yyval30
		end

	yy_do_action_451 is
			--|#line 1843
		local
			yyval30: ID_AS
		do

yyval30 := new_double_id_as 
			yyval := yyval30
		end

	yy_do_action_452 is
			--|#line 1845
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (8) 
			yyval := yyval30
		end

	yy_do_action_453 is
			--|#line 1847
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (16) 
			yyval := yyval30
		end

	yy_do_action_454 is
			--|#line 1849
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (32) 
			yyval := yyval30
		end

	yy_do_action_455 is
			--|#line 1851
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (64) 
			yyval := yyval30
		end

	yy_do_action_456 is
			--|#line 1853
		local
			yyval30: ID_AS
		do

yyval30 := new_none_id_as 
			yyval := yyval30
		end

	yy_do_action_457 is
			--|#line 1855
		local
			yyval30: ID_AS
		do

yyval30 := new_pointer_id_as 
			yyval := yyval30
		end

	yy_do_action_458 is
			--|#line 1857
		local
			yyval30: ID_AS
		do

yyval30 := new_real_id_as 
			yyval := yyval30
		end

	yy_do_action_459 is
			--|#line 1861
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_460 is
			--|#line 1863
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_461 is
			--|#line 1865
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_462 is
			--|#line 1867
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype47 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_463 is
			--|#line 1869
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_464 is
			--|#line 1871
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_465 is
			--|#line 1875
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_466 is
			--|#line 1877
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_467 is
			--|#line 1879
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

	yy_do_action_468 is
			--|#line 1894
		local
			yyval6: ATOMIC_AS
		do

yyval6 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval6
		end

	yy_do_action_469 is
			--|#line 1896
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_470 is
			--|#line 1898
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_471 is
			--|#line 1902
		local
			yyval9: BOOL_AS
		do

yyval9 := new_boolean_as (False) 
			yyval := yyval9
		end

	yy_do_action_472 is
			--|#line 1904
		local
			yyval9: BOOL_AS
		do

yyval9 := new_boolean_as (True) 
			yyval := yyval9
		end

	yy_do_action_473 is
			--|#line 1908
		local
			yyval12: CHAR_AS
		do

				check is_character: not token_buffer.is_empty end
				yyval12 := new_character_as (token_buffer.item (1))
			
			yyval := yyval12
		end

	yy_do_action_474 is
			--|#line 1915
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

	yy_do_action_475 is
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

	yy_do_action_476 is
			--|#line 1945
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

	yy_do_action_477 is
			--|#line 1963
		local
			yyval47: REAL_AS
		do

yyval47 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval47
		end

	yy_do_action_478 is
			--|#line 1965
		local
			yyval47: REAL_AS
		do

yyval47 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval47
		end

	yy_do_action_479 is
			--|#line 1967
		local
			yyval47: REAL_AS
		do

				token_buffer.precede ('-')
				yyval47 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval47
		end

	yy_do_action_480 is
			--|#line 1974
		local
			yyval7: BIT_CONST_AS
		do

yyval7 := new_bit_const_as (new_id_as (token_buffer)) 
			yyval := yyval7
		end

	yy_do_action_481 is
			--|#line 1978
		local
			yyval55: STRING_AS
		do

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_482 is
			--|#line 1980
		local
			yyval55: STRING_AS
		do

yyval55 := new_empty_string_as 
			yyval := yyval55
		end

	yy_do_action_483 is
			--|#line 1982
		local
			yyval55: STRING_AS
		do

yyval55 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval55
		end

	yy_do_action_484 is
			--|#line 1986
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_485 is
			--|#line 1988
		local
			yyval55: STRING_AS
		do

yyval55 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval55
		end

	yy_do_action_486 is
			--|#line 1990
		local
			yyval55: STRING_AS
		do

yyval55 := new_lt_string_as 
			yyval := yyval55
		end

	yy_do_action_487 is
			--|#line 1992
		local
			yyval55: STRING_AS
		do

yyval55 := new_le_string_as 
			yyval := yyval55
		end

	yy_do_action_488 is
			--|#line 1994
		local
			yyval55: STRING_AS
		do

yyval55 := new_gt_string_as 
			yyval := yyval55
		end

	yy_do_action_489 is
			--|#line 1996
		local
			yyval55: STRING_AS
		do

yyval55 := new_ge_string_as 
			yyval := yyval55
		end

	yy_do_action_490 is
			--|#line 1998
		local
			yyval55: STRING_AS
		do

yyval55 := new_minus_string_as 
			yyval := yyval55
		end

	yy_do_action_491 is
			--|#line 2000
		local
			yyval55: STRING_AS
		do

yyval55 := new_plus_string_as 
			yyval := yyval55
		end

	yy_do_action_492 is
			--|#line 2002
		local
			yyval55: STRING_AS
		do

yyval55 := new_star_string_as 
			yyval := yyval55
		end

	yy_do_action_493 is
			--|#line 2004
		local
			yyval55: STRING_AS
		do

yyval55 := new_slash_string_as 
			yyval := yyval55
		end

	yy_do_action_494 is
			--|#line 2006
		local
			yyval55: STRING_AS
		do

yyval55 := new_mod_string_as 
			yyval := yyval55
		end

	yy_do_action_495 is
			--|#line 2008
		local
			yyval55: STRING_AS
		do

yyval55 := new_div_string_as 
			yyval := yyval55
		end

	yy_do_action_496 is
			--|#line 2010
		local
			yyval55: STRING_AS
		do

yyval55 := new_power_string_as 
			yyval := yyval55
		end

	yy_do_action_497 is
			--|#line 2012
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_498 is
			--|#line 2014
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_499 is
			--|#line 2016
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_500 is
			--|#line 2018
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_501 is
			--|#line 2020
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_502 is
			--|#line 2022
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_503 is
			--|#line 2024
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_504 is
			--|#line 2026
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_505 is
			--|#line 2030
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_minus_string_as) 
			yyval := yyval88
		end

	yy_do_action_506 is
			--|#line 2032
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_plus_string_as) 
			yyval := yyval88
		end

	yy_do_action_507 is
			--|#line 2034
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_not_string_as) 
			yyval := yyval88
		end

	yy_do_action_508 is
			--|#line 2036
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval88
		end

	yy_do_action_509 is
			--|#line 2040
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_lt_string_as) 
			yyval := yyval88
		end

	yy_do_action_510 is
			--|#line 2042
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_le_string_as) 
			yyval := yyval88
		end

	yy_do_action_511 is
			--|#line 2044
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_gt_string_as) 
			yyval := yyval88
		end

	yy_do_action_512 is
			--|#line 2046
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_ge_string_as) 
			yyval := yyval88
		end

	yy_do_action_513 is
			--|#line 2048
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_minus_string_as) 
			yyval := yyval88
		end

	yy_do_action_514 is
			--|#line 2050
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_plus_string_as) 
			yyval := yyval88
		end

	yy_do_action_515 is
			--|#line 2052
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_star_string_as) 
			yyval := yyval88
		end

	yy_do_action_516 is
			--|#line 2054
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_slash_string_as) 
			yyval := yyval88
		end

	yy_do_action_517 is
			--|#line 2056
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_mod_string_as) 
			yyval := yyval88
		end

	yy_do_action_518 is
			--|#line 2058
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_div_string_as) 
			yyval := yyval88
		end

	yy_do_action_519 is
			--|#line 2060
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_power_string_as) 
			yyval := yyval88
		end

	yy_do_action_520 is
			--|#line 2062
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_and_string_as) 
			yyval := yyval88
		end

	yy_do_action_521 is
			--|#line 2064
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval88
		end

	yy_do_action_522 is
			--|#line 2066
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_implies_string_as) 
			yyval := yyval88
		end

	yy_do_action_523 is
			--|#line 2068
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_or_string_as) 
			yyval := yyval88
		end

	yy_do_action_524 is
			--|#line 2070
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval88
		end

	yy_do_action_525 is
			--|#line 2072
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_xor_string_as) 
			yyval := yyval88
		end

	yy_do_action_526 is
			--|#line 2074
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval88
		end

	yy_do_action_527 is
			--|#line 2078
		local
			yyval4: ARRAY_AS
		do

yyval4 := new_array_as (yytype66 (yyvs.item (yyvsp - 1))) 
			yyval := yyval4
		end

	yy_do_action_528 is
			--|#line 2082
		local
			yyval57: TUPLE_AS
		do

yyval57 := new_tuple_as (yytype66 (yyvs.item (yyvsp - 1))) 
			yyval := yyval57
		end

	yy_do_action_530 is
			--|#line 2090
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
			  167,  209,  209,  182,  182,  280,  280,  259,  259,  260,
			  260,  179,  312,  312,  180,  180,  180,  180,  180,  180,
			  180,  180,  180,  180,  201,  201,  317,  201,  318,  163,
			  163,  319,  163,  320,  272,  272,  273,  273,  211,  212,

			  212,  212,  214,  214,  218,  218,  218,  218,  218,  218,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  275,  275,  275,  276,  276,  247,  247,  248,
			  248,  249,  249,  171,  321,  303,  303,  246,  246,  175,
			  227,  227,  228,  228,  162,  261,  261,  177,  223,  223,
			  224,  224,  151,  263,  263,  183,  183,  183,  183,  183,
			  183,  183,  183,  183,  183,  183,  183,  183,  183,  183,
			  183,  183,  183,  262,  262,  185,  274,  274,  184,  184,
			  322,  221,  221,  221,  161,  270,  270,  270,  271,  271,
			  202,  258,  258,  142,  142,  203,  203,  225,  225,  226,

			  226,  158,  158,  158,  158,  158,  158,  206,  206,  206,
			  206,  206,  206,  206,  206,  206,  206,  206,  206,  206,
			  206,  264,  264,  265,  265,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  159,  159,  159,  160,  160,  217,  217,  137,  137,  140,
			  140,  178,  178,  178,  178,  178,  178,  178,  178,  178,
			  153,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  174,  150,  150,

			  150,  150,  150,  150,  150,  150,  150,  150,  150,  150,
			  190,  189,  188,  192,  187,  196,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  191,
			  197,  198,  149,  149,  186,  186,  138,  139,  232,  232,
			  232,  233,  233,  234,  234,  235,  235,  172,  172,  172,
			  172,  172,  172,  172,  172,  172,  172,  172,  172,  144,
			  144,  144,  144,  144,  144,  145,  145,  145,  145,  145,
			  145,  148,  148,  152,  181,  181,  181,  199,  199,  199,
			  146,  208,  208,  208,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,

			  210,  210,  210,  210,  210,  301,  301,  301,  301,  300,
			  300,  300,  300,  300,  300,  300,  300,  300,  300,  300,
			  300,  300,  300,  300,  300,  300,  300,  141,  213,  316,
			  304>>)
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
			    2,    0,    2,    2,    2,    0,    2,    1,    2,    1,
			    2,    3,    0,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    0,    3,    0,    4,    0,    0,
			    3,    0,    4,    0,    0,    1,    1,    2,    3,    1,

			    3,    2,    1,    1,    3,    3,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    0,    2,    3,    1,    3,    0,    4,    0,
			    1,    1,    3,    3,    0,    0,    3,    0,    3,    8,
			    0,    1,    1,    2,    5,    0,    2,    6,    0,    1,
			    1,    2,    5,    1,    3,    1,    3,    1,    3,    1,
			    3,    3,    3,    3,    3,    1,    3,    3,    3,    3,
			    3,    3,    3,    0,    2,   10,    0,    2,    0,    3,
			    0,    0,    4,    2,    5,    0,    2,    3,    1,    3,
			    1,    0,    2,    4,    4,    4,    4,    0,    1,    1,

			    2,    1,    3,    2,    1,    3,    2,    5,    5,    5,
			    7,    7,    5,    3,    4,    4,    4,    6,    5,    4,
			    3,    0,    3,    1,    3,    1,    1,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    3,
			    6,    4,    7,    6,    5,    0,    1,    1,    1,    0,
			    3,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    4,    1,    1,    1,    1,    1,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    4,    3,    4,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    2,    2,    2,
			    2,    2,    4,    2,    4,    2,    2,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    3,    3,    3,    5,    3,    2,    7,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    3,
			    7,    6,    1,    1,    3,    3,    2,    2,    0,    2,
			    3,    1,    3,    0,    1,    1,    3,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    2,    2,    1,    2,    2,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    3,    3,    0,
			    0>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   27,   40,   51,  458,  457,  456,  450,  455,  453,  452,
			  454,  451,  449,  448,  447,    0,    0,   36,   40,   52,
			   53,    0,   53,   39,  504,  503,  502,  501,  500,  499,
			  498,  497,  496,  495,  494,  493,  492,  491,  490,  489,
			  488,  487,  486,  483,  485,  482,  472,  471,    0,   43,
			    0,  480,  484,  477,  473,  474,    0,    0,   41,   45,
			  463,  459,  460,    0,   44,  461,  462,  464,  481,   73,
			   37,   54,   48,    0,   53,   53,   47,    0,   26,   25,
			   24,   18,   23,   21,   20,   22,   19,   17,   16,    0,
			    0,    0,    0,   15,    0,  202,  203,  222,  222,  222,

			  222,  222,  222,  222,  222,  222,  222,  222,  222,  479,
			  476,  478,  475,   46,    0,   74,   38,  530,    3,    4,
			    6,    7,   10,    8,    9,   11,    5,   12,   13,   14,
			   50,   49,    0,  222,  209,  208,  222,    0,    0,  207,
			  206,  530,    0,  210,  211,  212,  214,  217,  215,  216,
			  218,  213,  219,  220,  221,   42,  161,    0,  530,  205,
			  204,  349,  223,  225,    0,    0,   55,  229,  349,    0,
			  344,  224,    0,  162,    0,   92,  234,  231,    0,  230,
			  343,  438,  226,   56,  530,  530,  235,  228,    0,    0,
			  350,   95,  530,    0,   94,  297,    0,  233,  232,    0,

			  402,    0,  438,    0,  401,    0,  443,    0,  439,  443,
			    0,  468,  467,    0,    0,    0,    0,  397,    0,    0,
			  403,  362,  361,  469,  465,  364,  466,  409,  441,  438,
			    0,  406,  400,  399,  398,  408,  404,  405,  407,  365,
			  470,  363,    0,   96,   97,  222,  304,  301,  299,   57,
			  298,  237,    0,    0,    0,    0,    0,    0,    0,    0,
			  321,    0,  415,    0,    0,    0,  396,    0,    0,  395,
			    0,   81,   82,   83,  393,  445,    0,  444,    0,    0,
			  222,  222,  222,  222,  222,  222,  222,  222,  222,  222,
			  222,    0,  321,    0,  390,  150,  389,  387,  388,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  436,
			  391,    0,    0,  440,    0,   98,   99,    0,    0,  306,
			    0,  303,   64,   79,   59,  530,   58,  300,    0,  236,
			  321,  321,  433,  411,  438,  432,    0,    0,    0,    0,
			    0,    0,    0,  313,    0,    0,  321,  410,  508,  507,
			  506,  505,   85,  526,  525,  524,  523,  522,  521,  520,
			  519,  518,  517,  516,  515,  514,  513,  512,  511,  510,
			  509,   84,    0,  528,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  527,  320,

			  366,  148,  151,    0,  412,  373,  372,  371,  370,  369,
			  368,  367,  380,  382,  381,  383,  384,  385,    0,  374,
			  379,    0,  376,  378,  386,  321,  414,  429,  442,  124,
			  132,  106,  128,   73,  105,  122,  126,  130,    0,  111,
			   67,    0,   69,  305,  120,  302,   65,   80,   71,   79,
			   76,  134,    0,  278,   60,    0,  319,  314,    0,  437,
			  321,  321,  321,    0,    0,  325,    0,  326,  323,    0,
			  321,  438,    0,  315,  394,  446,    0,  321,  438,  438,
			  438,  438,  438,  438,  438,  438,  438,  438,  438,    0,
			    0,    0,  392,  375,  377,  316,  125,  133,  108,  107,

			    0,  129,  115,  113,    0,  114,  123,  126,  127,  130,
			  131,    0,  104,  112,  122,   68,    0,    0,   63,   66,
			   72,   79,  136,  172,  152,   78,  280,  530,  238,  434,
			  435,  312,  307,  308,    0,    0,  203,  222,  222,  222,
			  222,  222,  222,  222,  222,  222,  222,  222,  222,  322,
			    0,  309,  417,    0,    0,  318,  418,  419,  420,  421,
			  424,  422,  423,  425,  426,  427,  428,  321,  413,  149,
			    0,    0,  116,  118,   73,  119,  130,    0,  103,  126,
			   70,  121,   77,  138,    0,    0,  137,   75,    0,   33,
			  529,   27,  321,  321,  339,  210,  211,  212,  214,  217,

			  215,  216,  218,  213,  219,  220,  221,  324,  438,  438,
			  317,  109,  110,  117,    0,  102,  130,  141,  135,  139,
			  173,  153,   30,   40,   86,   87,  196,  279,  529,    0,
			    0,  311,  310,  327,  328,  329,  331,  334,  332,  333,
			  335,  330,  336,  337,  338,  430,  416,  101,    0,    0,
			    0,   33,   40,   33,   88,   55,   35,   40,  197,  199,
			  438,   73,    2,    1,  100,    0,   73,   90,   40,   89,
			   91,  155,   34,  201,  198,  142,  140,  184,  200,  186,
			  165,  188,  529,  143,    0,  529,  185,  145,    0,  166,
			  144,  172,  530,  172,  158,  157,  156,  189,  187,    0,

			  146,  164,  529,  161,    0,  163,  191,  291,   73,  169,
			  529,  530,  159,  160,  193,  529,  172,    0,  147,  170,
			  290,  530,  172,  176,  182,  174,  181,  178,  179,  175,
			  172,  180,  183,  177,    0,  529,  190,  292,  154,    0,
			  276,  171,    0,    0,  285,    0,  529,    0,    0,  345,
			    0,  351,  438,  357,  353,  352,  354,  359,  355,  356,
			  358,  192,  248,  529,  281,    0,    0,    0,    0,  172,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  348,    0,  349,  347,  346,    0,    0,    0,
			    0,  530,  250,  273,  249,  277,    0,    0,  294,  296,

			  172,  286,  288,    0,    0,  360,    0,  341,    0,    0,
			  293,  295,    0,  172,    0,  251,  283,  438,  530,  530,
			  287,    0,  284,    0,  349,    0,  257,  259,  255,  253,
			  265,    0,  274,  247,    0,    0,  242,  245,  530,    0,
			  289,  349,  340,    0,    0,    0,    0,    0,  172,    0,
			  282,    0,  172,    0,  243,    0,  342,    0,  258,  264,
			  272,  263,  260,  261,  267,  262,  256,  270,  271,  266,
			  269,  268,  252,  254,  172,  246,  239,    0,    0,    0,
			  172,    0,  275,  244,  431,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  784,  220,  342,  170,  221,  723,   58,   59,  222,  223,
			  523,  224,  343,  225,  792,  226,  724,  328,  333,  624,
			  654,  248,  725,  227,  726,  836,  707,  502,  275,  695,
			  703,  448,  334,  574,  177,  229,   16,  230,  727,   17,
			  728,  729,  709,  730,   65,  696,  829,  527,  731,  345,
			  231,  232,  233,  234,  235,  236,  468,  191,  244,  237,
			  238,  830,   66,  498,  680,  732,  733,  697,  670,  239,
			  175,  240,  166,   68,  626,  661,  241,  279,  589,   95,
			  787,   96,  583,  687,  797,   69,  793,  794,  249,  250,
			  837,  838,  435,  514,  503,  319,  242,  276,  277,  449,

			  335,  336,  443,  506,  507,  508,  509,  510,  511,  339,
			  156,  178,  179,  504,  441,  584,  403,    2,   18,  655,
			  625,  717,  701,  710,  853,  814,  831,  353,  469,  185,
			  192,  439,  499,  769,  803,  627,  628,  764,  143,  164,
			  524,  585,  586,  684,  689,  690,  271,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  272,
			  273,  444,  450,  381,  362,  451,  197,  193,  885,   21,
			  663,  116,   22,   72,  446,  702,  452,  650,  677,  629,
			  682,  685,  715,  735,  186,  590>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  391, 2377,   57, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  661,  928, -32768, 2319, -32768,
			  617,  657,  -13, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  642, -32768,
			 1404, -32768, -32768, -32768, -32768, -32768,  240,  230, -32768, -32768,
			 -32768, -32768, -32768,  625, -32768, -32768, -32768, -32768, -32768,  198,
			 -32768, -32768, -32768, 2539,  617,  617, -32768, 1404, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2539,
			 2528, 2539, 1051, -32768,  650, -32768, -32768,  465,  465,  465,

			  465,  465,  465,  465,  465,  465,  465,  465,  465, -32768,
			 -32768, -32768, -32768, -32768, 1084, -32768, -32768, 1067, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  637,  465, -32768, -32768,  465,  652,  640, -32768,
			 -32768, -32768, 2412, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  404,  618, -32768, -32768,
			 -32768,  124, -32768, -32768,  134, 2093,  366,  619,  124, 1147,
			 -32768, -32768, 1404, -32768, 1114,  588, -32768, -32768,  610,  623,
			 -32768,  435, -32768, -32768,  235, -32768,  605, -32768,  619, 1681,
			 -32768, -32768,  301, 2539, -32768,  326, 2539, -32768, -32768,  511,

			   87, 2227,   49,  604,   65, 2045, 1804,  303, -32768, 1804,
			 1147, -32768, -32768, 1804, 1804,  621, 1804, -32768, 1804, 1804,
			  378, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2790,  106,
			 1804, -32768, -32768, -32768, -32768, -32768, -32768,  377,  375, -32768,
			 -32768, -32768,  163, -32768,  609,  465,  807,  807, -32768,  544,
			  326,  592, 1147, 1147, 1147,  602,  601,  600, 1404, 1804,
			  339, 2539, -32768, 2539, 1147, 1147, -32768,  108, 2657, -32768,
			 1804, -32768, -32768, -32768, -32768, 2790,  571,  576, 2539,  512,
			  306,  293,  290,  275,  267,  264,  259,  256,  248,  242,
			  237,  524,  459, 2747, -32768, 1147, -32768, -32768, -32768, 1147,

			 1804, 1804, 1804, 1804, 1804, 1804, 1804, 1804, 1804, 1804,
			 1804, 1804, 1804, 1558, 1804, 1435, 1804, 1804, 1147, -32768,
			 -32768, 1147, 1147, -32768, 1804, -32768,  -20, 2508, 2389, 2440,
			 2389, 2440, -32768,  438, -32768, -32768,  544, -32768, 2389, -32768,
			  459,  459,  490, -32768,  435, -32768, 1147, 1147, 1147,  564,
			 2729, 1927, 1147, -32768,  563,  536,  459, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 2686, -32768, 1804,  519, 1147,  521,  517,  516,
			  515,  514,  502,  501,  499,  486,  485,  482, -32768, -32768,

			   46, -32768,  525,  518, -32768,  342,  342,  342,  342,  342,
			  655,  655,  678,  678,  678,  678,  678,  678, 1804, 1298,
			 2821, 1804, 2806, 2709, -32768,  459, -32768, -32768, 2790, 2389,
			 2389, 2389, 2389,   96, -32768,  443,  414,  364,  497,  491,
			 -32768,   99, -32768,  464, -32768,  464,  495, -32768, -32768,  365,
			 -32768,   26, 2389,  483, -32768,   -2, -32768, -32768, 1147, -32768,
			  459,  459,  459,  533,  530,  511,  303, 2790, -32768,  153,
			  459,  435,  523, -32768, -32768, 2790,  498,  459,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435, 1147,
			 1147, 1147, -32768, 1298, 2806, -32768,  464,  464, -32768,  504,

			  481,  464, -32768,  495,  418, -32768, -32768,  414, -32768,  364,
			 -32768,  472, -32768, -32768,  443, -32768, 2539, 2389, -32768, -32768,
			 -32768,  467, 1147, -32768,  496, -32768, -32768, -32768, -32768,  490,
			 -32768, -32768, -32768, -32768, 1147, 1147,  471,  306,  293,  290,
			  275,  267,  264,  259,  256,  465,  248,  242,  237, -32768,
			 1927, -32768, -32768, 1147,  424, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  459, -32768, -32768,
			 2389, 2389, -32768, -32768,  390,  464,  364,  442, -32768,  414,
			 -32768, -32768, -32768, -32768,  210,  455, 1147,  385, 1404,   73,
			   54,  391,  459,  459, -32768,  451,  445,  444,  440,  439,

			  437,  433,  432,  431,  417,  416,  415, -32768,  435,  435,
			 -32768, -32768, -32768, -32768,  394, -32768,  364,  406, -32768, -32768,
			 -32768, -32768, 2050, 2495, -32768, -32768, -32768, -32768, 1669, 1804,
			  388, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  387, 1147,
			 1404,  376, 2295,  376, -32768,  366, -32768, 2471, -32768, 2790,
			  208,  390, -32768, -32768, -32768,  399,  390, -32768, 2261, -32768,
			 -32768, -32768, -32768, 1804, -32768, -32768, -32768,  351, 2790,  384,
			  359, -32768,  115, 1147,   76,  115, -32768, -32768,  175, -32768,
			 1147, -32768, -32768, -32768, -32768, -32768, -32768,  370, -32768, 1404,

			 -32768, -32768, 1557,  404, 2093, -32768,  348,  341,  390, -32768,
			 1011,  102, -32768, -32768, -32768,  -21, -32768,  361, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, 2204,  -21, -32768, -32768, -32768, 1804,
			  345,  385,    2, 1804,  392,  381,  340,  842, 1981, 1404,
			 1804,  378,   25, -32768, -32768, -32768, -32768, -32768, -32768,  377,
			  375, -32768, 1259,   64,  295, 1804, 1804, 1367, 2071, -32768,
			  285,  344,  343,  337,  335,  334,  333,  329,  327,  322,
			  313,  297, -32768, 1404,  124, -32768, -32768,  258, 2668, 1804,
			 1804, -32768, -32768,  261,  215, -32768, 1804,  202, 2790, 2790,

			 -32768, -32768, -32768,  149,  216, -32768,  227, -32768,  531,  245,
			 2790, 2790,  363, -32768,  201, -32768, 2790,   21, -32768,  192,
			 -32768, 2093, -32768,  531,  124,  132,  255,  236,  225, -32768,
			  194,   13, -32768, -32768, 1804, 1804, -32768,  147,  141,  118,
			 -32768,  124, -32768, 2539,  484,  363,  468,  363, -32768,  363,
			 2790, 2650, -32768,   78, -32768, 1804, -32768,  109, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, 1319,   32,   71,
			 -32768, 1147, -32768, -32768, -32768,  114,   88, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -747,   58,  332, -154, -32768, -32768,  674,  164, -32768,   10,
			 -32768,    9, -249, -32768,  -10,  -15, -32768, -223, -32768, -32768,
			 -32768,  537, -32768,    6, -32768,  -55, -32768,  278,  555, -32768,
			 -32768,  318,  423, -32768,  578,   -1, -32768,  603, -32768,   -8,
			 -32768, -32768,   53, -32768,  -89, -32768,  -94, -32768, -32768,  291,
			   41,   36,   31,   27,   20,   17,  186,  551, -32768,   16,
			   14, -488, -32768,  165, -32768, -32768, -32768, -32768, -32768, -32768,
			   79,    7,   24, -144,  111, -32768, -32768,  -31, -32768,  534,
			 -32768,  260,  139,   34, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  281, -32768, -32768, -153, -32768,  522, -32768, -32768,

			 -32768, -32768, -244,  396,  203,  395, -477,  393, -468, -32768,
			 -32768, -32768, -32768, -204, -32768, -289, -32768,  122, -590, -32768,
			 -371, -32768, -414, -32768, -32768, -32768, -32768,  -73, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -648, -32768, -32768,  888, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  -71,   90,   33,   30,
			   29,   15,  -37,  -38,  -41,  103,  -42,  -45,  -46, -32768,
			 -32768, -198,  195, -32768, -32768, -32768, -32768,  107, -32768, -32768,
			 -32768, -155, -32768,   42, -32768, -512, -32768, -32768, -32768, -617,
			 -32768, -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   15,   62,  117,  140,  108,  107,  402,  274,  106,  104,
			   70,  587,  103,  102,  180,   64,  357,   15,  133,   94,
			  136,  173,   63,   67,  330,   61,   60,  254,  190,  194,
			  576,  108,  107,  657,  686,  106,  104,  698,  517,  103,
			  102,  577,  329,  331, -194,  434,  132,  189,  433,  262,
			  404,  189,  522,  849,   75,  766,   71,  881,  765,  318,
			  834,  824,  668,  528,   76,  101,  521,  736,  432,  431,
			 -194,  490,  426,  427,  430,  189,  841,  429,  790,  100,
			   99,  789,   74,   98,  489,  711,  445,  761,  887,  135,
			  265,  139,  101,  711,  455,  261,  108,  107,  770,   62,

			  106,  104,  616,  264,  103,  102,  100,   99,  614,  848,
			   98,  163,  254,   64,  886,  795,  130,  131,   20, -194,
			   63,   67,  245,   61,   60,  253,  108,  107, -194,   19,
			  106,  104,  189,  115,  103,  102,  882,  694,  693,  516,
			   97,  182,  327,  876,  318,  692,  515,  623,  648,  169,
			  108,  107,  622,  105,  106,  104,  878,  101,  103,  102,
			  691,  290,  289, -194, -194,  288,  287,   97,  181,  286,
			  285,  100,   99,  722,  172,   98, -194, -194,  843,  721,
			  105,  183,  855,  171, -194,  496,  497,  101,  501,  821,
			  354,  459,  355,  550,  820,  720, -194,  847,  549, -194,

			  260,  100,   99,  324, -241,   98, -241,  385,  323,  292,
			  852,  101,  108,  107,  699,  491,  106,  104,  741,  399,
			  103,  102,  284,  518,  157,  100,   99,  349,  846,   98,
			  361,  360,   97,  500,  189,  115,  283,  282,  114,  845,
			  281,  568,  519,  359,  358,  105,  318,  673,  161,  617,
			  491,  340,  341,  344,  525, -240,  442, -240,  844,  112,
			  575,  111,   97,  356,  344,  168,  833,  456,  457,  110,
			  490,  109,  115,  101,  823,  105,  -73,  -73,  505,  705,
			  667,  822,  669,  473,  397,  142,   97,  100,   99,  396,
			  142,   98,  195,  808,  401,  395,  142,  280,  344,  105,

			  -73,  818,  737,  394,  142,  -73,  393,  142,  740,  -73,
			  105,  392,  142,  -73,  391,  142,  791,  425,  552,  581,
			  344,  344,  390,  142,  813,  556,  557,  558,  559,  560,
			  561,  562,  563,  564,  565,  566,   93,  389,  142,   92,
			  388,  142,  -93,  -93,  397,  460,  461,  462,   97,  278,
			  805,  470,  495,  387,  142,  804,  860,  864,  867,  871,
			  396,  105,  300,  217,  352,  351,  -93,  247,  246,  395,
			   91,  -93,  500,  612,  394,  -93,  393,  138,  137,  -93,
			  392,  391,  390,   90,  389,  477,  819,  531,  532,  533,
			  388,  387,   55,   54,  688,  796,   14,  551,   89,  832,

			  322,  688,  321,  299,  555, -194,  265,   88,   87,   86,
			   85,   84,   83,   82,   81,   80,   79,   78,  768,  613,
			  548,  547,  620,  763,  546,  544,  738,  115,  543,  542,
			  -62,  165,  716,  825,  872,  -62,  706,  447,  875,  -62,
			  683,  679,  453,  -62,  714,  580,  573,  681,  675,  174,
			  623,   93,  664,  662,  649,  645,  646,  344,  430,  647,
			  879,  189,  644,  643,  642,    1,  883,   13,   12,   11,
			   10,    9,    8,    7,    6,    5,    4,    3,  641,  640,
			  639,  541,  138,  137,  638,  351,  637,  636,  567,  344,
			  569,  635,  634,  268,  610,  540,  539,   55,  633,  538,

			  618,   14,  432,  -61,  517,  267,  674,  615,  -61,  609,
			  447,  676,  -61,  142,   54,  458,  -61,   14,  594,  631,
			  632,  401,   88,   87,   86,   85,   84,   83,   82,   81,
			   80,   79,   78,  592,  593,  588,  571,  578,  825,  447,
			  429,  327,  108,  107,  570,  554,  106,  104,  553,  252,
			  103,  102,  608,  718,  825,  535,  537,  621,  534,  433,
			  713,  526,  512,  492,   14,  491,  476,  488,  398,  545,
			  487,  486,   13,   12,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,  472,  485,  401,  484,  483,   13,   12,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,  482,

			  481,  480,  479,  101,  108,  107,  478,   62,  106,  104,
			  471,  463,  103,  102,  332,  386,  384,  100,   99,  666,
			  383,   98,   15,  782,  802,  348,  347,  346,  660,   67,
			  807,   61,   60,  338,  591,   13,   12,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,  325,  295,  665,   70,
			  263,   15,  176,  108,  107,  196,   15,  106,  104,  187,
			   70,  103,  102,  188,  184,  101,  167,   15,  708,  112,
			  842,  304,  303,  302,  301,  300,  217,  840,   97,  100,
			   99,  110,  401,   98,  158,  141,   71,  856,   77,  401,
			  113,  105,  306,  305,  304,  303,  302,  301,  300,  217,

			   23,  781,  780,  108,  107,  779,  778,  106,  104,  777,
			  776,  103,  102,  630,  101,   73,  582,  579,  786,  438,
			  513,  437,  436,  828,  700,  619,  536,  712,  100,   99,
			  251,  291,   98,  752,  671,  611,  607,  108,  107,  658,
			   97,  106,  104,  243,  228,  103,  102,  785,  760,  530,
			  759,  758,  806,  105,  757,  873,  863,  866,  870,  454,
			  828,  756,  775,  719,  101,  755,  198,  520,  293,  294,
			  754,  296,  857,  297,  298,  753,  774,  773,  100,   99,
			  772,  572,   98,  854,  815,  320,  653,  337,  155,   97,
			  529,    0,  751,    0,    0,  817,    0,  826,  101,  704,

			    0,    0,  105,    0,    0,    0,    0,  785,    0,    0,
			    0,  827,  100,   99,  350,    0,   98,    0,  734,    0,
			    0,    0,  785,    0,    0,  382,    0,    0,  739,  858,
			  861,  317,  868,    0,  826,    0,    0,  771,    0,   97,
			  -65,    0,    0,  859,  862,  865,  869,    0,  827,    0,
			    0,    0,  105,  327,    0,  405,  406,  407,  408,  409,
			  410,  411,  412,  413,  414,  415,  416,  417,  419,  420,
			  422,  423,  424,   97,    0,   93,    0,    0,  317,  428,
			  884,    0,  -65,    0,    0,    0,  105,    0,  278,    0,
			    0,    0,    0,    0,  -65,    0,  317,  317,  812,  317,

			  317,  317,    0,    0,    0,    0,  467,    0,    0,    0,
			    0,  -65,  -65,  -65,  -65,  -65,  -65,  -65,  -65,  -65,
			  -65,  -65,    0,  317,    0,  835,  839,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  475,
			    0,    0,   57,   56,    0,  839,   88,   87,   86,   85,
			   84,   83,   82,  317,   80,   79,   78,   55,   54,   53,
			   52,   14,   51,   50,    0,   49,    0,    0,    0,   48,
			    0,    0,    0,  493,    0,    0,  494,    0,    0,   47,
			   46,    0,    0,    0,    0,  317,  144,  145,  146,  147,
			  148,  149,  150,  151,  152,  153,  154,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,  317,  317,
			  317,  317,  317,  317,  317,  317,  317,  317,  317,  317,
			  317,  159,  317,  317,  160,  317,  317,  317,    0,    0,
			    0,  317,   13,   12,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,  138,  137,    0,    0,    0,
			  317,    0,    0,    0, -168, -168, -168, -168,  317,    0,
			   55,    0,    0,    0,   14,    0,    0,    0,    0, -168,
			    0,    0,    0,    0, -227,    0,  317,  317,   57,   56,

			    0,    0, -168,    0,    0,  467,    0,    0, -227, -227,
			 -168, -168, -168,   55,   54,   53,   52,   14,   51,   50,
			    0,    0,    0,    0,    0,   48,    0,    0,    0,    0,
			    0,    0, -227,  326,    0,   47,   46, -227,    0,    0,
			    0, -227,    0, -227,    0, -227,   52,    0,    0,    0,
			 -227,    0,    0,    0,    0,   13,   12,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    0,    0,    0,  144,
			  145,  146,  147,  148,  149,  150,  152,  153,  154,    0,
			   14,    0,    0,    0,  659,    0,    0,    0,   13,   12,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,   45,

			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,    0,    0,    0,    0,    0,    0,    0,  678,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   13,   12,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,  317,  316,  315,  314,  313,  312,  311,  310,
			  309,  308,  307,  306,  305,  304,  303,  302,  301,  300,
			  217,  317,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  762,    0,    0,    0,  767,    0,

			    0,    0,    0,    0,    0,  788,  312,  311,  310,  309,
			  308,  307,  306,  305,  304,  303,  302,  301,  300,  217,
			  798,  799,    0,  316,  315,  314,  313,  312,  311,  310,
			  309,  308,  307,  306,  305,  304,  303,  302,  301,  300,
			  217,    0,    0,    0,  810,  811,    0,    0,    0,    0,
			    0,  816,    0,    0,    0,    0,    0,    0,    0,    0,
			  791,    0,    0,    0,    0,  317,    0,    0,    0,    0,
			  317,  316,  315,  314,  313,  312,  311,  310,  309,  308,
			  307,  306,  305,  304,  303,  302,  301,  300,  217,  850,
			  851,  317,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,  317,  317,    0,    0,    0,    0,    0,    0,    0,
			  877,    0,    0,  317,  317,  880,    0,    0,    0,  317,
			    0,    0,    0,    0,    0,  595,  596,  597,  598,  599,
			  600,  601,  602,  603,  604,  605,  606,   93,    0,    0,
			   92,    0,    0,    0,    0,    0,    0,    0,    0,  219,
			  218,    0,    0,  317,  317,    0,  217,  216,  215,  214,
			    0,  213,    0,  800,  212,   54,  211,   52,   14,   51,
			   50,   91,    0,  210,    0,    0,   48,    0,  209,    0,
			  317,  207,    0,  206,   90,    0,   47,   46,    0,  205,
			    0,    0,    0,    0,  204,    0,    0,    0,  421,   89,

			    0,    0,    0,    0,    0,  203,    0,    0,   88,   87,
			   86,   85,   84,   83,   82,   81,   80,   79,   78,    0,
			  202,  201,    0,    0,    0,    0,    0,  200,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  199,    0,   13,
			   12,   11,   10,    9,    8,    7,    6,    5,    4,    3,
			   45,   44,   43,   42,   41,   40,   39,   38,   37,   36,
			   35,   34,   33,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,  219,  218,    0,    0,    0,    0,    0,  217,
			  216,  215,  214,    0,  213,    0,    0,  212,   54,  211,
			   52,   14,   51,   50,  620,    0,  210,    0,    0,   48,

			    0,  209,    0,    0,  207,    0,  206,    0,    0,   47,
			   46,    0,  205,    0,    0,    0,    0,  204,    0,    0,
			 -167, -167, -167, -167,    0,    0,    0,    0,  203,    0,
			    0,    0,    0,    0,    0, -167,    0,    0,    0,    0,
			    0,    0,    0,  202,  201,    0,    0,    0, -167,    0,
			  200,    0,    0,    0,  418,    0, -167, -167, -167,    0,
			  199,    0,   13,   12,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,  219,  218,    0,    0,    0,

			    0,    0,  217,  216,  215,  214,    0,  213,    0,    0,
			  212,   54,  211,   52,   14,   51,   50,    0,    0,  210,
			    0,    0,   48,    0,  209,    0,  208,  207,    0,  206,
			 -195, -195,   47,   46, -195,  205,    0,    0, -195,    0,
			  204,    0,    0, -195,    0,    0,    0,    0,    0,    0,
			 -195,  203,    0, -195,    0,    0,    0,    0,    0,    0,
			 -195,    0,    0,    0,    0,    0,  202,  201, -195, -195,
			    0,    0,    0,  200,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  199,    0,   13,   12,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,   45,   44,   43,   42,

			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,  219,  218,
			    0,    0,    0,    0,    0,  217,  216,  215,  214,    0,
			  213,    0,    0,  212,   54,  211,   52,   14,   51,   50,
			    0,    0,  210,    0,    0,   48,    0,  209,    0,    0,
			  207,    0,  206,    0,    0,   47,   46,    0,  205,    0,
			    0,    0,    0,  204,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  203,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  202,
			  201,    0,    0,    0,    0,    0,  200,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,  199,    0,   13,   12,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,  219,  218,    0,    0,    0,    0,    0,  217,  216,
			  215,  214,    0,  213,    0,    0,  212,   54,  211,   52,
			   14,   51,   50,    0,    0,  210,    0,    0,   48,    0,
			  209,    0,    0,  466,    0,  206,    0,    0,   47,   46,
			    0,  205,    0,    0,    0,    0,  204,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  203,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  202,  201,   14,    0,    0,    0,    0,  200,
			    0,    0,    0,    0,    0,    0,    0,  783,    0,  465,
			    0,   13,   12,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,   45,   44,   43,   42,   41,   40,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   57,   56,    0,    0,    0,    0,
			    0,  270,    0,  782,    0,    0,    0,    0,   93,   55,
			   54,   53,   52,    0,   51,   13,   12,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    0,    0,    0,    0,

			    0,   47,   46,   52,  269,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  801,    0,    0,    0,
			  268,    0,    0,    0,  652,   52,    0,    0,    0,    0,
			    0,    0,  267,    0,    0,    0,    0,  266,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  651,   88,
			   87,   86,   85,   84,   83,   82,   81,   80,   79,   78,
			    0,    0,    0,    0,    0,   45,   44,   43,   42,   41,
			   40,   39,   38,   37,   36,   35,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,   44,    0,   42,
			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,

			   31,   30,   29,   28,   27,   26,   25,   24,    0,   44,
			    0,   42,   41,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			  750,    0,    0,    0,    0,    0,    0,   14,    0,  749,
			    0,    0,    0,    0,    0,  748,    0,    0,    0,    0,
			  747,    0,    0,  259,    0,    0,    0,    0,    0,    0,
			   14,  746,    0,  745,  744,    0,    0,    0,    0,    0,
			    0,    0,    0,  258,  203,    0,    0,  743,    0,    0,
			    0,    0,    0,    0,    0,    0,  257,    0,    0,  202,
			    0,    0,    0,    0,   14,    0,  742,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,   13,   12,
			   11,   10,    9,    8,    7,    6,    5,    4,    3,  256,
			    0,    0,  -31,  -31,    0,    0,    0,    0,   14,  255,
			  -31,   13,   12,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,  -31,    0,  -31,  -31,    0,    0,    0,    0,
			    0,  -31,   14,    0,    0,    0,  -32,  -32,    0,    0,
			    0,    0,    0,    0,  -32,   13,   12,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,  -32,  -28,  -32,  -32,
			  -28,    0,    0,    0,  -28,  -32,  -28,    0,  -28,    0,
			    0,  -28,    0,    0,    0,    0,    0,    0,    0,   13,

			   12,   11,   10,    9,    8,    7,    6,    5,    4,    3,
			   14,    0,    0,    0,  -28,    0,    0,    0,    0,    0,
			    0,    0,   93,   13,   12,   11,   10,    9,    8,    7,
			    6,    5,    4,    3,    0,  -29,    0,    0,  -29,    0,
			    0,    0,  -29,    0,  -29,   93,  -29,    0,   92,  -29,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  162,    0,    0,  268,    0,    0,    0,    0,    0,
			    0,    0,  -29,  -66,    0,    0,  267,    0,    0,   91,
			    0,   13,   12,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,   90,   88,   87,   86,   85,   84,   83,   82,

			   81,   80,   79,   78,   14,    0,    0,   89,    0,    0,
			    0,    0,    0,    0,    0,  -66,   88,   87,   86,   85,
			   84,   83,   82,   81,   80,   79,   78,  -66,   14,    0,
			    0,    0,    0,    0,    0,    0,  672,    0,    0,    0,
			    0,   93,    0,    0,  -66,  -66,  -66,  -66,  -66,  -66,
			  -66,  -66,  -66,  -66,  -66,  440,    0,    0,    0,    0,
			  656,   14,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   93,    0,    0,   13,   12,   11,   10,    9,
			    8,    7,    6,    5,    4,    3,    0,  134,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   13,

			   12,   11,   10,    9,    8,    7,    6,    5,    4,    3,
			    0,    0,   88,   87,   86,   85,   84,   83,   82,   81,
			   80,   79,   78,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   13,   12,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,   88,   87,   86,   85,   84,   83,   82,
			   81,   80,   79,   78,  316,  315,  314,  313,  312,  311,
			  310,  309,  308,  307,  306,  305,  304,  303,  302,  301,
			  300,  217,  316,  315,  314,  313,  312,  311,  310,  309,
			  308,  307,  306,  305,  304,  303,  302,  301,  300,  217,
			  316,  315,  314,  313,  312,  311,  310,  309,  308,  307,

			  306,  305,  304,  303,  302,  301,  300,  217,    0,    0,
			    0,    0,    0,  809,  315,  314,  313,  312,  311,  310,
			  309,  308,  307,  306,  305,  304,  303,  302,  301,  300,
			  217,  474,  874,  316,  315,  314,  313,  312,  311,  310,
			  309,  308,  307,  306,  305,  304,  303,  302,  301,  300,
			  217,  316,  315,  314,  313,  312,  311,  310,  309,  308,
			  307,  306,  305,  304,  303,  302,  301,  300,  217,    0,
			    0,    0,    0,    0,  464,  380,  379,  378,  377,  376,
			  375,  374,  373,  372,  371,  370,  369,  368,  367,  366,
			  365,  364,  400,  363,  316,  315,  314,  313,  312,  311,

			  310,  309,  308,  307,  306,  305,  304,  303,  302,  301,
			  300,  217,  314,  313,  312,  311,  310,  309,  308,  307,
			  306,  305,  304,  303,  302,  301,  300,  217,  313,  312,
			  311,  310,  309,  308,  307,  306,  305,  304,  303,  302,
			  301,  300,  217>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,   16,   73,   92,   50,   50,  295,  205,   50,   50,
			   18,  523,   50,   50,  168,   16,  265,   18,   89,   50,
			   91,  165,   16,   16,  247,   16,   16,   25,  181,  184,
			  507,   77,   77,  623,  682,   77,   77,  685,   40,   77,
			   77,  509,  246,  247,   65,   65,   77,   26,   68,  202,
			  299,   26,   26,   40,   67,   53,   69,   25,   56,   38,
			   39,  808,  652,   65,   22,   50,   40,  715,   88,   89,
			   91,   25,  321,  322,   94,   26,  823,   97,   53,   50,
			   50,   56,   95,   50,   38,  702,  330,  735,    0,   90,
			   25,   92,   77,  710,  338,   46,  142,  142,  746,  114,

			  142,  142,  579,   38,  142,  142,   77,   77,  576,   96,
			   77,  142,   25,  114,    0,  763,   74,   75,   61,   65,
			  114,  114,  193,  114,  114,   38,  172,  172,   74,   72,
			  172,  172,   26,   37,  172,  172,   65,   61,   62,   40,
			   50,  172,   46,   65,   38,   69,   47,   74,  616,   25,
			  196,  196,   79,   50,  196,  196,   47,  142,  196,  196,
			   84,  207,  207,   99,  100,  207,  207,   77,  169,  207,
			  207,  142,  142,   71,   40,  142,   61,   62,   46,   77,
			   77,  174,   64,   49,   69,  429,  430,  172,  432,   40,
			  261,  344,  263,   40,   45,   93,   81,    3,   45,   84,

			  201,  172,  172,   40,   63,  172,   65,  278,   45,  210,
			   63,  196,  258,  258,   39,   40,  258,  258,  730,  292,
			  258,  258,  207,  446,  117,  196,  196,  258,    3,  196,
			  122,  123,  142,  431,   26,   37,  207,  207,   40,    3,
			  207,  490,  446,  135,  136,  142,   38,   39,  141,   39,
			   40,  252,  253,  254,  452,   63,  327,   65,    3,   29,
			  504,   31,  172,  264,  265,  158,   65,  340,  341,   29,
			   25,   31,   37,  258,   47,  172,   41,   42,  433,  693,
			  651,   65,  653,  356,   47,   48,  196,  258,  258,   47,
			   48,  258,  185,   35,  295,   47,   48,  207,  299,  196,

			   65,   99,  716,   47,   48,   70,   47,   48,  722,   74,
			  207,   47,   48,   78,   47,   48,  101,  318,  471,  517,
			  321,  322,   47,   48,   63,  478,  479,  480,  481,  482,
			  483,  484,  485,  486,  487,  488,   33,   47,   48,   36,
			   47,   48,   41,   42,   47,  346,  347,  348,  258,   46,
			   65,  352,  425,   47,   48,  769,  844,  845,  846,  847,
			   47,  258,   20,   21,   25,   26,   65,   41,   42,   47,
			   67,   70,  570,  571,   47,   74,   47,   14,   15,   78,
			   47,   47,   47,   80,   47,  386,  800,  460,  461,  462,
			   47,   47,   29,   30,  683,  100,   33,  470,   95,  813,

			   25,  690,   25,   25,  477,   65,   25,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,   26,  574,
			  466,  466,   37,   78,  466,  466,   65,   37,  466,  466,
			   65,   27,   91,   70,  848,   70,   66,   72,  852,   74,
			   81,   90,  335,   78,   96,  516,   28,   63,   49,   83,
			   74,   33,   65,   65,   48,  608,  609,  458,   94,   65,
			  874,   26,   47,   47,   47,   74,  880,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,   47,   47,
			   47,  466,   14,   15,   47,   26,   47,   47,  489,  490,
			  491,   47,   47,   75,  567,  466,  466,   29,   47,  466,

			   45,   33,   88,   65,   40,   87,  661,   65,   70,   85,
			   72,  666,   74,   48,   30,   25,   78,   33,   47,  592,
			  593,  522,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  534,  535,   39,   55,   65,   70,   72,
			   97,   46,  588,  588,   40,   47,  588,  588,   25,   38,
			  588,  588,  553,  708,   70,   25,  466,  588,   25,   68,
			  704,   78,   65,   45,   33,   40,   47,   85,   44,  466,
			   85,   85,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   47,   85,  586,   85,   85,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   85,

			   85,   85,   85,  588,  650,  650,   85,  622,  650,  650,
			   47,   47,  650,  650,   70,  103,   40,  588,  588,  650,
			   49,  588,  623,   92,  768,   25,   25,   25,  629,  622,
			  784,  622,  622,   41,  527,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,   37,   26,  649,  657,
			   46,  652,   33,  699,  699,   50,  657,  699,  699,   49,
			  668,  699,  699,   40,   76,  650,   48,  668,  699,   29,
			  824,   16,   17,   18,   19,   20,   21,  821,  588,  650,
			  650,   29,  683,  650,   47,   35,   69,  841,   46,  690,
			   65,  588,   14,   15,   16,   17,   18,   19,   20,   21,

			   39,  747,  747,  749,  749,  747,  747,  749,  749,  747,
			  747,  749,  749,  591,  699,   58,  521,  514,  749,  326,
			  439,  326,  326,  812,  690,  586,  466,  703,  699,  699,
			  196,  209,  699,  734,  655,  570,  550,  783,  783,  628,
			  650,  783,  783,  192,  189,  783,  783,  748,  734,  458,
			  734,  734,  783,  650,  734,  849,  845,  846,  847,  336,
			  849,  734,  747,  710,  749,  734,  188,  449,  213,  214,
			  734,  216,  843,  218,  219,  734,  747,  747,  749,  749,
			  747,  503,  749,  838,  794,  230,  622,  250,  114,  699,
			  458,   -1,  734,   -1,   -1,  796,   -1,  812,  783,  692,

			   -1,   -1,  699,   -1,   -1,   -1,   -1,  808,   -1,   -1,
			   -1,  812,  783,  783,  259,   -1,  783,   -1,  711,   -1,
			   -1,   -1,  823,   -1,   -1,  270,   -1,   -1,  721,  844,
			  845,  228,  847,   -1,  849,   -1,   -1,  747,   -1,  749,
			   33,   -1,   -1,  844,  845,  846,  847,   -1,  849,   -1,
			   -1,   -1,  749,   46,   -1,  300,  301,  302,  303,  304,
			  305,  306,  307,  308,  309,  310,  311,  312,  313,  314,
			  315,  316,  317,  783,   -1,   33,   -1,   -1,  275,  324,
			  881,   -1,   75,   -1,   -1,   -1,  783,   -1,   46,   -1,
			   -1,   -1,   -1,   -1,   87,   -1,  293,  294,  791,  296,

			  297,  298,   -1,   -1,   -1,   -1,  351,   -1,   -1,   -1,
			   -1,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   -1,  320,   -1,  818,  819,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  384,
			   -1,   -1,   14,   15,   -1,  838,  104,  105,  106,  107,
			  108,  109,  110,  350,  112,  113,  114,   29,   30,   31,
			   32,   33,   34,   35,   -1,   37,   -1,   -1,   -1,   41,
			   -1,   -1,   -1,  418,   -1,   -1,  421,   -1,   -1,   51,
			   52,   -1,   -1,   -1,   -1,  382,   98,   99,  100,  101,
			  102,  103,  104,  105,  106,  107,  108,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  405,  406,
			  407,  408,  409,  410,  411,  412,  413,  414,  415,  416,
			  417,  133,  419,  420,  136,  422,  423,  424,   -1,   -1,
			   -1,  428,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,
			  132,  133,  134,  135,  136,   14,   15,   -1,   -1,   -1,
			  467,   -1,   -1,   -1,   63,   64,   65,   66,  475,   -1,
			   29,   -1,   -1,   -1,   33,   -1,   -1,   -1,   -1,   78,
			   -1,   -1,   -1,   -1,   27,   -1,  493,  494,   14,   15,

			   -1,   -1,   91,   -1,   -1,  550,   -1,   -1,   41,   42,
			   99,  100,  101,   29,   30,   31,   32,   33,   34,   35,
			   -1,   -1,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,
			   -1,   -1,   65,  245,   -1,   51,   52,   70,   -1,   -1,
			   -1,   74,   -1,   76,   -1,   78,   32,   -1,   -1,   -1,
			   83,   -1,   -1,   -1,   -1,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,   -1,   -1,   -1,  281,
			  282,  283,  284,  285,  286,  287,  288,  289,  290,   -1,
			   33,   -1,   -1,   -1,  629,   -1,   -1,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,

			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  673,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  659,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,  678,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  739,   -1,   -1,   -1,  743,   -1,

			   -1,   -1,   -1,   -1,   -1,  750,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			  765,  766,   -1,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   -1,   -1,   -1,  789,  790,   -1,   -1,   -1,   -1,
			   -1,  796,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  101,   -1,   -1,   -1,   -1,  762,   -1,   -1,   -1,   -1,
			  767,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,  834,
			  835,  788,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,  798,  799,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  855,   -1,   -1,  810,  811,   96,   -1,   -1,   -1,  816,
			   -1,   -1,   -1,   -1,   -1,  537,  538,  539,  540,  541,
			  542,  543,  544,  545,  546,  547,  548,   33,   -1,   -1,
			   36,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   14,
			   15,   -1,   -1,  850,  851,   -1,   21,   22,   23,   24,
			   -1,   26,   -1,   96,   29,   30,   31,   32,   33,   34,
			   35,   67,   -1,   38,   -1,   -1,   41,   -1,   43,   -1,
			  877,   46,   -1,   48,   80,   -1,   51,   52,   -1,   54,
			   -1,   -1,   -1,   -1,   59,   -1,   -1,   -1,   63,   95,

			   -1,   -1,   -1,   -1,   -1,   70,   -1,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   -1,
			   85,   86,   -1,   -1,   -1,   -1,   -1,   92,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  102,   -1,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,   14,   15,   -1,   -1,   -1,   -1,   -1,   21,
			   22,   23,   24,   -1,   26,   -1,   -1,   29,   30,   31,
			   32,   33,   34,   35,   37,   -1,   38,   -1,   -1,   41,

			   -1,   43,   -1,   -1,   46,   -1,   48,   -1,   -1,   51,
			   52,   -1,   54,   -1,   -1,   -1,   -1,   59,   -1,   -1,
			   63,   64,   65,   66,   -1,   -1,   -1,   -1,   70,   -1,
			   -1,   -1,   -1,   -1,   -1,   78,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   85,   86,   -1,   -1,   -1,   91,   -1,
			   92,   -1,   -1,   -1,   96,   -1,   99,  100,  101,   -1,
			  102,   -1,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,
			  132,  133,  134,  135,  136,   14,   15,   -1,   -1,   -1,

			   -1,   -1,   21,   22,   23,   24,   -1,   26,   -1,   -1,
			   29,   30,   31,   32,   33,   34,   35,   -1,   -1,   38,
			   -1,   -1,   41,   -1,   43,   -1,   45,   46,   -1,   48,
			   61,   62,   51,   52,   65,   54,   -1,   -1,   69,   -1,
			   59,   -1,   -1,   74,   -1,   -1,   -1,   -1,   -1,   -1,
			   81,   70,   -1,   84,   -1,   -1,   -1,   -1,   -1,   -1,
			   91,   -1,   -1,   -1,   -1,   -1,   85,   86,   99,  100,
			   -1,   -1,   -1,   92,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  102,   -1,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,  115,  116,  117,  118,

			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,   14,   15,
			   -1,   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,
			   26,   -1,   -1,   29,   30,   31,   32,   33,   34,   35,
			   -1,   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   -1,
			   46,   -1,   48,   -1,   -1,   51,   52,   -1,   54,   -1,
			   -1,   -1,   -1,   59,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   70,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   85,
			   86,   -1,   -1,   -1,   -1,   -1,   92,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,  102,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,   14,   15,   -1,   -1,   -1,   -1,   -1,   21,   22,
			   23,   24,   -1,   26,   -1,   -1,   29,   30,   31,   32,
			   33,   34,   35,   -1,   -1,   38,   -1,   -1,   41,   -1,
			   43,   -1,   -1,   46,   -1,   48,   -1,   -1,   51,   52,
			   -1,   54,   -1,   -1,   -1,   -1,   59,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   70,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   85,   86,   33,   -1,   -1,   -1,   -1,   92,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   46,   -1,  102,
			   -1,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,   14,   15,   -1,   -1,   -1,   -1,
			   -1,   26,   -1,   92,   -1,   -1,   -1,   -1,   33,   29,
			   30,   31,   32,   -1,   34,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,   -1,   -1,   -1,   -1,

			   -1,   51,   52,   32,   59,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   45,   -1,   -1,   -1,
			   75,   -1,   -1,   -1,   74,   32,   -1,   -1,   -1,   -1,
			   -1,   -1,   87,   -1,   -1,   -1,   -1,   92,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   98,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			   -1,   -1,   -1,   -1,   -1,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,  132,  133,  134,  135,  136,  116,   -1,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,

			  129,  130,  131,  132,  133,  134,  135,  136,   -1,  116,
			   -1,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			   26,   -1,   -1,   -1,   -1,   -1,   -1,   33,   -1,   35,
			   -1,   -1,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,
			   46,   -1,   -1,   26,   -1,   -1,   -1,   -1,   -1,   -1,
			   33,   57,   -1,   59,   60,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   46,   70,   -1,   -1,   73,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   59,   -1,   -1,   85,
			   -1,   -1,   -1,   -1,   33,   -1,   92,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   92,
			   -1,   -1,   61,   62,   -1,   -1,   -1,   -1,   33,  102,
			   69,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   81,   -1,   83,   84,   -1,   -1,   -1,   -1,
			   -1,   90,   33,   -1,   -1,   -1,   61,   62,   -1,   -1,
			   -1,   -1,   -1,   -1,   69,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,   81,   58,   83,   84,
			   61,   -1,   -1,   -1,   65,   90,   67,   -1,   69,   -1,
			   -1,   72,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  104,

			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			   33,   -1,   -1,   -1,   95,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   33,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,   -1,   58,   -1,   -1,   61,   -1,
			   -1,   -1,   65,   -1,   67,   33,   69,   -1,   36,   72,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   49,   -1,   -1,   75,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   95,   33,   -1,   -1,   87,   -1,   -1,   67,
			   -1,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   80,  104,  105,  106,  107,  108,  109,  110,

			  111,  112,  113,  114,   33,   -1,   -1,   95,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   75,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   87,   33,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   65,   -1,   -1,   -1,
			   -1,   33,   -1,   -1,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,   47,   -1,   -1,   -1,   -1,
			   65,   33,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   33,   -1,   -1,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,   -1,   59,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  104,

			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			   -1,   -1,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  104,  105,  106,  107,  108,  109,  110,
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
			  133,  134,   45,  136,    4,    5,    6,    7,    8,    9,

			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21>>)
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

	yyFinal: INTEGER is 887
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 137
			-- Number of tokens

	yyLast: INTEGER is 2842
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 391
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 323
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
