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
--|#line 391
	yy_do_action_49
when 50 then
--|#line 401
	yy_do_action_50
when 51 then
--|#line 407
	yy_do_action_51
when 52 then
--|#line 414
	yy_do_action_52
when 53 then
--|#line 420
	yy_do_action_53
when 54 then
--|#line 428
	yy_do_action_54
when 55 then
--|#line 432
	yy_do_action_55
when 56 then
--|#line 443
	yy_do_action_56
when 57 then
--|#line 447
	yy_do_action_57
when 59 then
--|#line 464
	yy_do_action_59
when 61 then
--|#line 473
	yy_do_action_61
when 62 then
--|#line 482
	yy_do_action_62
when 63 then
--|#line 487
	yy_do_action_63
when 64 then
--|#line 494
	yy_do_action_64
when 65 then
--|#line 496
	yy_do_action_65
when 66 then
--|#line 500
	yy_do_action_66
when 67 then
--|#line 500
	yy_do_action_67
when 69 then
--|#line 511
	yy_do_action_69
when 70 then
--|#line 515
	yy_do_action_70
when 71 then
--|#line 520
	yy_do_action_71
when 72 then
--|#line 524
	yy_do_action_72
when 73 then
--|#line 530
	yy_do_action_73
when 74 then
--|#line 538
	yy_do_action_74
when 75 then
--|#line 543
	yy_do_action_75
when 78 then
--|#line 554
	yy_do_action_78
when 79 then
--|#line 567
	yy_do_action_79
when 80 then
--|#line 569
	yy_do_action_80
when 81 then
--|#line 576
	yy_do_action_81
when 82 then
--|#line 580
	yy_do_action_82
when 83 then
--|#line 582
	yy_do_action_83
when 84 then
--|#line 586
	yy_do_action_84
when 85 then
--|#line 588
	yy_do_action_85
when 86 then
--|#line 590
	yy_do_action_86
when 87 then
--|#line 594
	yy_do_action_87
when 88 then
--|#line 599
	yy_do_action_88
when 89 then
--|#line 603
	yy_do_action_89
when 90 then
--|#line 607
	yy_do_action_90
when 91 then
--|#line 609
	yy_do_action_91
when 92 then
--|#line 613
	yy_do_action_92
when 93 then
--|#line 618
	yy_do_action_93
when 94 then
--|#line 623
	yy_do_action_94
when 96 then
--|#line 636
	yy_do_action_96
when 97 then
--|#line 638
	yy_do_action_97
when 98 then
--|#line 642
	yy_do_action_98
when 99 then
--|#line 647
	yy_do_action_99
when 100 then
--|#line 654
	yy_do_action_100
when 101 then
--|#line 659
	yy_do_action_101
when 102 then
--|#line 667
	yy_do_action_102
when 103 then
--|#line 672
	yy_do_action_103
when 104 then
--|#line 677
	yy_do_action_104
when 105 then
--|#line 682
	yy_do_action_105
when 106 then
--|#line 687
	yy_do_action_106
when 107 then
--|#line 692
	yy_do_action_107
when 108 then
--|#line 697
	yy_do_action_108
when 110 then
--|#line 707
	yy_do_action_110
when 111 then
--|#line 711
	yy_do_action_111
when 112 then
--|#line 716
	yy_do_action_112
when 113 then
--|#line 723
	yy_do_action_113
when 115 then
--|#line 729
	yy_do_action_115
when 116 then
--|#line 733
	yy_do_action_116
when 118 then
--|#line 739
	yy_do_action_118
when 119 then
--|#line 744
	yy_do_action_119
when 120 then
--|#line 751
	yy_do_action_120
when 121 then
--|#line 755
	yy_do_action_121
when 122 then
--|#line 757
	yy_do_action_122
when 123 then
--|#line 761
	yy_do_action_123
when 124 then
--|#line 766
	yy_do_action_124
when 126 then
--|#line 775
	yy_do_action_126
when 128 then
--|#line 781
	yy_do_action_128
when 130 then
--|#line 787
	yy_do_action_130
when 132 then
--|#line 793
	yy_do_action_132
when 134 then
--|#line 799
	yy_do_action_134
when 136 then
--|#line 805
	yy_do_action_136
when 138 then
--|#line 815
	yy_do_action_138
when 140 then
--|#line 821
	yy_do_action_140
when 141 then
--|#line 825
	yy_do_action_141
when 142 then
--|#line 830
	yy_do_action_142
when 143 then
--|#line 837
	yy_do_action_143
when 145 then
--|#line 842
	yy_do_action_145
when 147 then
--|#line 853
	yy_do_action_147
when 148 then
--|#line 857
	yy_do_action_148
when 149 then
--|#line 862
	yy_do_action_149
when 150 then
--|#line 869
	yy_do_action_150
when 151 then
--|#line 873
	yy_do_action_151
when 152 then
--|#line 879
	yy_do_action_152
when 153 then
--|#line 887
	yy_do_action_153
when 154 then
--|#line 889
	yy_do_action_154
when 156 then
--|#line 895
	yy_do_action_156
when 157 then
--|#line 899
	yy_do_action_157
when 158 then
--|#line 899
	yy_do_action_158
when 159 then
--|#line 911
	yy_do_action_159
when 160 then
--|#line 913
	yy_do_action_160
when 161 then
--|#line 915
	yy_do_action_161
when 162 then
--|#line 919
	yy_do_action_162
when 163 then
--|#line 923
	yy_do_action_163
when 165 then
--|#line 930
	yy_do_action_165
when 166 then
--|#line 934
	yy_do_action_166
when 167 then
--|#line 936
	yy_do_action_167
when 169 then
--|#line 942
	yy_do_action_169
when 171 then
--|#line 948
	yy_do_action_171
when 172 then
--|#line 952
	yy_do_action_172
when 173 then
--|#line 957
	yy_do_action_173
when 174 then
--|#line 964
	yy_do_action_174
when 177 then
--|#line 972
	yy_do_action_177
when 178 then
--|#line 974
	yy_do_action_178
when 179 then
--|#line 976
	yy_do_action_179
when 180 then
--|#line 978
	yy_do_action_180
when 181 then
--|#line 980
	yy_do_action_181
when 182 then
--|#line 982
	yy_do_action_182
when 183 then
--|#line 984
	yy_do_action_183
when 184 then
--|#line 986
	yy_do_action_184
when 185 then
--|#line 988
	yy_do_action_185
when 186 then
--|#line 990
	yy_do_action_186
when 188 then
--|#line 996
	yy_do_action_188
when 189 then
--|#line 996
	yy_do_action_189
when 190 then
--|#line 1003
	yy_do_action_190
when 191 then
--|#line 1003
	yy_do_action_191
when 193 then
--|#line 1014
	yy_do_action_193
when 194 then
--|#line 1014
	yy_do_action_194
when 195 then
--|#line 1021
	yy_do_action_195
when 196 then
--|#line 1021
	yy_do_action_196
when 198 then
--|#line 1032
	yy_do_action_198
when 199 then
--|#line 1041
	yy_do_action_199
when 200 then
--|#line 1046
	yy_do_action_200
when 201 then
--|#line 1053
	yy_do_action_201
when 202 then
--|#line 1057
	yy_do_action_202
when 203 then
--|#line 1059
	yy_do_action_203
when 205 then
--|#line 1069
	yy_do_action_205
when 206 then
--|#line 1071
	yy_do_action_206
when 207 then
--|#line 1075
	yy_do_action_207
when 208 then
--|#line 1077
	yy_do_action_208
when 209 then
--|#line 1079
	yy_do_action_209
when 210 then
--|#line 1081
	yy_do_action_210
when 211 then
--|#line 1083
	yy_do_action_211
when 212 then
--|#line 1085
	yy_do_action_212
when 213 then
--|#line 1089
	yy_do_action_213
when 214 then
--|#line 1091
	yy_do_action_214
when 215 then
--|#line 1093
	yy_do_action_215
when 216 then
--|#line 1095
	yy_do_action_216
when 217 then
--|#line 1097
	yy_do_action_217
when 218 then
--|#line 1099
	yy_do_action_218
when 219 then
--|#line 1101
	yy_do_action_219
when 220 then
--|#line 1103
	yy_do_action_220
when 221 then
--|#line 1105
	yy_do_action_221
when 222 then
--|#line 1107
	yy_do_action_222
when 223 then
--|#line 1109
	yy_do_action_223
when 224 then
--|#line 1111
	yy_do_action_224
when 227 then
--|#line 1119
	yy_do_action_227
when 228 then
--|#line 1123
	yy_do_action_228
when 229 then
--|#line 1128
	yy_do_action_229
when 230 then
--|#line 1139
	yy_do_action_230
when 231 then
--|#line 1145
	yy_do_action_231
when 233 then
--|#line 1155
	yy_do_action_233
when 234 then
--|#line 1159
	yy_do_action_234
when 235 then
--|#line 1164
	yy_do_action_235
when 236 then
--|#line 1171
	yy_do_action_236
when 237 then
--|#line 1171
	yy_do_action_237
when 238 then
--|#line 1181
	yy_do_action_238
when 239 then
--|#line 1183
	yy_do_action_239
when 241 then
--|#line 1193
	yy_do_action_241
when 242 then
--|#line 1201
	yy_do_action_242
when 244 then
--|#line 1209
	yy_do_action_244
when 245 then
--|#line 1213
	yy_do_action_245
when 246 then
--|#line 1218
	yy_do_action_246
when 247 then
--|#line 1225
	yy_do_action_247
when 249 then
--|#line 1231
	yy_do_action_249
when 250 then
--|#line 1235
	yy_do_action_250
when 252 then
--|#line 1243
	yy_do_action_252
when 253 then
--|#line 1247
	yy_do_action_253
when 254 then
--|#line 1252
	yy_do_action_254
when 255 then
--|#line 1259
	yy_do_action_255
when 256 then
--|#line 1263
	yy_do_action_256
when 257 then
--|#line 1268
	yy_do_action_257
when 258 then
--|#line 1275
	yy_do_action_258
when 259 then
--|#line 1277
	yy_do_action_259
when 260 then
--|#line 1279
	yy_do_action_260
when 261 then
--|#line 1281
	yy_do_action_261
when 262 then
--|#line 1283
	yy_do_action_262
when 263 then
--|#line 1285
	yy_do_action_263
when 264 then
--|#line 1287
	yy_do_action_264
when 265 then
--|#line 1289
	yy_do_action_265
when 266 then
--|#line 1291
	yy_do_action_266
when 267 then
--|#line 1293
	yy_do_action_267
when 268 then
--|#line 1295
	yy_do_action_268
when 269 then
--|#line 1297
	yy_do_action_269
when 270 then
--|#line 1299
	yy_do_action_270
when 271 then
--|#line 1301
	yy_do_action_271
when 272 then
--|#line 1303
	yy_do_action_272
when 273 then
--|#line 1305
	yy_do_action_273
when 274 then
--|#line 1307
	yy_do_action_274
when 275 then
--|#line 1309
	yy_do_action_275
when 277 then
--|#line 1316
	yy_do_action_277
when 278 then
--|#line 1325
	yy_do_action_278
when 280 then
--|#line 1333
	yy_do_action_280
when 282 then
--|#line 1339
	yy_do_action_282
when 283 then
--|#line 1339
	yy_do_action_283
when 285 then
--|#line 1351
	yy_do_action_285
when 286 then
--|#line 1353
	yy_do_action_286
when 287 then
--|#line 1357
	yy_do_action_287
when 290 then
--|#line 1367
	yy_do_action_290
when 291 then
--|#line 1371
	yy_do_action_291
when 292 then
--|#line 1376
	yy_do_action_292
when 293 then
--|#line 1383
	yy_do_action_293
when 295 then
--|#line 1389
	yy_do_action_295
when 296 then
--|#line 1398
	yy_do_action_296
when 297 then
--|#line 1400
	yy_do_action_297
when 298 then
--|#line 1404
	yy_do_action_298
when 299 then
--|#line 1406
	yy_do_action_299
when 301 then
--|#line 1412
	yy_do_action_301
when 302 then
--|#line 1416
	yy_do_action_302
when 303 then
--|#line 1421
	yy_do_action_303
when 304 then
--|#line 1428
	yy_do_action_304
when 305 then
--|#line 1434
	yy_do_action_305
when 306 then
--|#line 1439
	yy_do_action_306
when 307 then
--|#line 1444
	yy_do_action_307
when 308 then
--|#line 1449
	yy_do_action_308
when 309 then
--|#line 1454
	yy_do_action_309
when 310 then
--|#line 1461
	yy_do_action_310
when 311 then
--|#line 1464
	yy_do_action_311
when 312 then
--|#line 1466
	yy_do_action_312
when 313 then
--|#line 1468
	yy_do_action_313
when 314 then
--|#line 1470
	yy_do_action_314
when 315 then
--|#line 1472
	yy_do_action_315
when 316 then
--|#line 1474
	yy_do_action_316
when 317 then
--|#line 1476
	yy_do_action_317
when 318 then
--|#line 1478
	yy_do_action_318
when 319 then
--|#line 1480
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
when 325 then
--|#line 1494
	yy_do_action_325
when 326 then
--|#line 1498
	yy_do_action_326
when 327 then
--|#line 1503
	yy_do_action_327
when 328 then
--|#line 1510
	yy_do_action_328
when 329 then
--|#line 1512
	yy_do_action_329
when 330 then
--|#line 1514
	yy_do_action_330
when 331 then
--|#line 1516
	yy_do_action_331
when 332 then
--|#line 1518
	yy_do_action_332
when 333 then
--|#line 1520
	yy_do_action_333
when 334 then
--|#line 1522
	yy_do_action_334
when 335 then
--|#line 1524
	yy_do_action_335
when 336 then
--|#line 1526
	yy_do_action_336
when 337 then
--|#line 1528
	yy_do_action_337
when 338 then
--|#line 1530
	yy_do_action_338
when 339 then
--|#line 1532
	yy_do_action_339
when 340 then
--|#line 1534
	yy_do_action_340
when 341 then
--|#line 1536
	yy_do_action_341
when 342 then
--|#line 1538
	yy_do_action_342
when 343 then
--|#line 1542
	yy_do_action_343
when 344 then
--|#line 1544
	yy_do_action_344
when 345 then
--|#line 1546
	yy_do_action_345
when 346 then
--|#line 1550
	yy_do_action_346
when 347 then
--|#line 1552
	yy_do_action_347
when 349 then
--|#line 1558
	yy_do_action_349
when 350 then
--|#line 1562
	yy_do_action_350
when 351 then
--|#line 1564
	yy_do_action_351
when 353 then
--|#line 1570
	yy_do_action_353
when 354 then
--|#line 1578
	yy_do_action_354
when 355 then
--|#line 1580
	yy_do_action_355
when 356 then
--|#line 1582
	yy_do_action_356
when 357 then
--|#line 1584
	yy_do_action_357
when 358 then
--|#line 1586
	yy_do_action_358
when 359 then
--|#line 1588
	yy_do_action_359
when 360 then
--|#line 1590
	yy_do_action_360
when 361 then
--|#line 1592
	yy_do_action_361
when 362 then
--|#line 1594
	yy_do_action_362
when 363 then
--|#line 1598
	yy_do_action_363
when 364 then
--|#line 1606
	yy_do_action_364
when 365 then
--|#line 1608
	yy_do_action_365
when 366 then
--|#line 1610
	yy_do_action_366
when 367 then
--|#line 1612
	yy_do_action_367
when 368 then
--|#line 1614
	yy_do_action_368
when 369 then
--|#line 1616
	yy_do_action_369
when 370 then
--|#line 1618
	yy_do_action_370
when 371 then
--|#line 1620
	yy_do_action_371
when 372 then
--|#line 1622
	yy_do_action_372
when 373 then
--|#line 1624
	yy_do_action_373
when 374 then
--|#line 1626
	yy_do_action_374
when 375 then
--|#line 1628
	yy_do_action_375
when 376 then
--|#line 1630
	yy_do_action_376
when 377 then
--|#line 1632
	yy_do_action_377
when 378 then
--|#line 1634
	yy_do_action_378
when 379 then
--|#line 1636
	yy_do_action_379
when 380 then
--|#line 1638
	yy_do_action_380
when 381 then
--|#line 1640
	yy_do_action_381
when 382 then
--|#line 1642
	yy_do_action_382
when 383 then
--|#line 1644
	yy_do_action_383
when 384 then
--|#line 1646
	yy_do_action_384
when 385 then
--|#line 1648
	yy_do_action_385
when 386 then
--|#line 1650
	yy_do_action_386
when 387 then
--|#line 1652
	yy_do_action_387
when 388 then
--|#line 1654
	yy_do_action_388
when 389 then
--|#line 1656
	yy_do_action_389
when 390 then
--|#line 1658
	yy_do_action_390
when 391 then
--|#line 1660
	yy_do_action_391
when 392 then
--|#line 1662
	yy_do_action_392
when 393 then
--|#line 1664
	yy_do_action_393
when 394 then
--|#line 1666
	yy_do_action_394
when 395 then
--|#line 1668
	yy_do_action_395
when 396 then
--|#line 1670
	yy_do_action_396
when 397 then
--|#line 1672
	yy_do_action_397
when 398 then
--|#line 1674
	yy_do_action_398
when 399 then
--|#line 1676
	yy_do_action_399
when 400 then
--|#line 1680
	yy_do_action_400
when 401 then
--|#line 1688
	yy_do_action_401
when 402 then
--|#line 1690
	yy_do_action_402
when 403 then
--|#line 1692
	yy_do_action_403
when 404 then
--|#line 1694
	yy_do_action_404
when 405 then
--|#line 1696
	yy_do_action_405
when 406 then
--|#line 1698
	yy_do_action_406
when 407 then
--|#line 1700
	yy_do_action_407
when 408 then
--|#line 1702
	yy_do_action_408
when 409 then
--|#line 1704
	yy_do_action_409
when 410 then
--|#line 1706
	yy_do_action_410
when 411 then
--|#line 1708
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
--|#line 1734
	yy_do_action_418
when 419 then
--|#line 1736
	yy_do_action_419
when 420 then
--|#line 1738
	yy_do_action_420
when 421 then
--|#line 1740
	yy_do_action_421
when 422 then
--|#line 1742
	yy_do_action_422
when 423 then
--|#line 1744
	yy_do_action_423
when 424 then
--|#line 1746
	yy_do_action_424
when 425 then
--|#line 1748
	yy_do_action_425
when 426 then
--|#line 1750
	yy_do_action_426
when 427 then
--|#line 1752
	yy_do_action_427
when 428 then
--|#line 1754
	yy_do_action_428
when 429 then
--|#line 1756
	yy_do_action_429
when 430 then
--|#line 1758
	yy_do_action_430
when 431 then
--|#line 1760
	yy_do_action_431
when 432 then
--|#line 1764
	yy_do_action_432
when 433 then
--|#line 1768
	yy_do_action_433
when 434 then
--|#line 1775
	yy_do_action_434
when 435 then
--|#line 1783
	yy_do_action_435
when 436 then
--|#line 1785
	yy_do_action_436
when 437 then
--|#line 1789
	yy_do_action_437
when 438 then
--|#line 1791
	yy_do_action_438
when 439 then
--|#line 1795
	yy_do_action_439
when 440 then
--|#line 1808
	yy_do_action_440
when 443 then
--|#line 1816
	yy_do_action_443
when 444 then
--|#line 1820
	yy_do_action_444
when 445 then
--|#line 1825
	yy_do_action_445
when 446 then
--|#line 1832
	yy_do_action_446
when 447 then
--|#line 1834
	yy_do_action_447
when 448 then
--|#line 1838
	yy_do_action_448
when 449 then
--|#line 1843
	yy_do_action_449
when 450 then
--|#line 1854
	yy_do_action_450
when 451 then
--|#line 1856
	yy_do_action_451
when 452 then
--|#line 1858
	yy_do_action_452
when 453 then
--|#line 1860
	yy_do_action_453
when 454 then
--|#line 1862
	yy_do_action_454
when 455 then
--|#line 1864
	yy_do_action_455
when 456 then
--|#line 1866
	yy_do_action_456
when 457 then
--|#line 1868
	yy_do_action_457
when 458 then
--|#line 1870
	yy_do_action_458
when 459 then
--|#line 1872
	yy_do_action_459
when 460 then
--|#line 1874
	yy_do_action_460
when 461 then
--|#line 1876
	yy_do_action_461
when 462 then
--|#line 1880
	yy_do_action_462
when 463 then
--|#line 1882
	yy_do_action_463
when 464 then
--|#line 1884
	yy_do_action_464
when 465 then
--|#line 1886
	yy_do_action_465
when 466 then
--|#line 1888
	yy_do_action_466
when 467 then
--|#line 1890
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
--|#line 1913
	yy_do_action_471
when 472 then
--|#line 1915
	yy_do_action_472
when 473 then
--|#line 1917
	yy_do_action_473
when 474 then
--|#line 1921
	yy_do_action_474
when 475 then
--|#line 1923
	yy_do_action_475
when 476 then
--|#line 1927
	yy_do_action_476
when 477 then
--|#line 1934
	yy_do_action_477
when 478 then
--|#line 1949
	yy_do_action_478
when 479 then
--|#line 1964
	yy_do_action_479
when 480 then
--|#line 1982
	yy_do_action_480
when 481 then
--|#line 1984
	yy_do_action_481
when 482 then
--|#line 1986
	yy_do_action_482
when 483 then
--|#line 1993
	yy_do_action_483
when 484 then
--|#line 1997
	yy_do_action_484
when 485 then
--|#line 1999
	yy_do_action_485
when 486 then
--|#line 2001
	yy_do_action_486
when 487 then
--|#line 2005
	yy_do_action_487
when 488 then
--|#line 2007
	yy_do_action_488
when 489 then
--|#line 2009
	yy_do_action_489
when 490 then
--|#line 2011
	yy_do_action_490
when 491 then
--|#line 2013
	yy_do_action_491
when 492 then
--|#line 2015
	yy_do_action_492
when 493 then
--|#line 2017
	yy_do_action_493
when 494 then
--|#line 2019
	yy_do_action_494
when 495 then
--|#line 2021
	yy_do_action_495
when 496 then
--|#line 2023
	yy_do_action_496
when 497 then
--|#line 2025
	yy_do_action_497
when 498 then
--|#line 2027
	yy_do_action_498
when 499 then
--|#line 2029
	yy_do_action_499
when 500 then
--|#line 2031
	yy_do_action_500
when 501 then
--|#line 2033
	yy_do_action_501
when 502 then
--|#line 2035
	yy_do_action_502
when 503 then
--|#line 2037
	yy_do_action_503
when 504 then
--|#line 2039
	yy_do_action_504
when 505 then
--|#line 2041
	yy_do_action_505
when 506 then
--|#line 2043
	yy_do_action_506
when 507 then
--|#line 2045
	yy_do_action_507
when 508 then
--|#line 2049
	yy_do_action_508
when 509 then
--|#line 2051
	yy_do_action_509
when 510 then
--|#line 2053
	yy_do_action_510
when 511 then
--|#line 2055
	yy_do_action_511
when 512 then
--|#line 2059
	yy_do_action_512
when 513 then
--|#line 2061
	yy_do_action_513
when 514 then
--|#line 2063
	yy_do_action_514
when 515 then
--|#line 2065
	yy_do_action_515
when 516 then
--|#line 2067
	yy_do_action_516
when 517 then
--|#line 2069
	yy_do_action_517
when 518 then
--|#line 2071
	yy_do_action_518
when 519 then
--|#line 2073
	yy_do_action_519
when 520 then
--|#line 2075
	yy_do_action_520
when 521 then
--|#line 2077
	yy_do_action_521
when 522 then
--|#line 2079
	yy_do_action_522
when 523 then
--|#line 2081
	yy_do_action_523
when 524 then
--|#line 2083
	yy_do_action_524
when 525 then
--|#line 2085
	yy_do_action_525
when 526 then
--|#line 2087
	yy_do_action_526
when 527 then
--|#line 2089
	yy_do_action_527
when 528 then
--|#line 2091
	yy_do_action_528
when 529 then
--|#line 2093
	yy_do_action_529
when 530 then
--|#line 2097
	yy_do_action_530
when 531 then
--|#line 2101
	yy_do_action_531
when 533 then
--|#line 2109
	yy_do_action_533
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

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype18 (yyvs.item (yyvsp - 1)), Void)
			
			yyval := yyval6
		end

	yy_do_action_49 is
			--|#line 391
		local
			yyval6: ATOMIC_AS
		do

				create {CUSTOM_ATTRIBUTE_AS} yyval6.initialize (yytype18 (yyvs.item (yyvsp - 2)), yytype57 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval6
		end

	yy_do_action_50 is
			--|#line 401
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_51 is
			--|#line 407
		local

		do
			yyval := yyval_default;
				is_frozen_class := False
				is_deferred := True
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_52 is
			--|#line 414
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := True
				is_separate := False
			

		end

	yy_do_action_53 is
			--|#line 420
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := True
			

		end

	yy_do_action_54 is
			--|#line 428
		local

		do
			yyval := yyval_default;
				is_frozen_class := False
			

		end

	yy_do_action_55 is
			--|#line 432
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

	yy_do_action_56 is
			--|#line 443
		local

		do
			yyval := yyval_default;
				is_external_class := False
			

		end

	yy_do_action_57 is
			--|#line 447
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

	yy_do_action_59 is
			--|#line 464
		local
			yyval55: STRING_AS
		do

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_61 is
			--|#line 473
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval68 := yytype68 (yyvs.item (yyvsp))
				if yyval68.is_empty then
					yyval68 := Void
				end
			
			yyval := yyval68
		end

	yy_do_action_62 is
			--|#line 482
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval68 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval68, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_63 is
			--|#line 487
		local
			yyval68: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval68 := yytype68 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval68, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval68
		end

	yy_do_action_64 is
			--|#line 494
		local
			yyval27: FEATURE_CLAUSE_AS
		do

yyval27 := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) 
			yyval := yyval27
		end

	yy_do_action_65 is
			--|#line 496
		local
			yyval27: FEATURE_CLAUSE_AS
		do

yyval27 := new_feature_clause_as (yytype14 (yyvs.item (yyvsp - 1)), yytype67 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval27
		end

	yy_do_action_66 is
			--|#line 500
		local
			yyval14: CLIENT_AS
		do

yyval14 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval14
		end

	yy_do_action_67 is
			--|#line 500
		local

		do
			yyval := yyval_default;
				inherit_context := False
				fclause_pos := clone (current_position)
			

		end

	yy_do_action_69 is
			--|#line 511
		local
			yyval14: CLIENT_AS
		do

yyval14 := new_client_as (yytype72 (yyvs.item (yyvsp))) 
			yyval := yyval14
		end

	yy_do_action_70 is
			--|#line 515
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do

				yyval72 := new_eiffel_list_id_as (1)
				yyval72.extend (new_none_id_as)
			
			yyval := yyval72
		end

	yy_do_action_71 is
			--|#line 520
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do

yyval72 := yytype72 (yyvs.item (yyvsp - 1)) 
			yyval := yyval72
		end

	yy_do_action_72 is
			--|#line 524
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do

				yyval72 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval72.extend (yytype86 (yyvs.item (yyvsp)).first)
				yytype86 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype86 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval72
		end

	yy_do_action_73 is
			--|#line 530
		local
			yyval72: EIFFEL_LIST [ID_AS]
		do

				yyval72 := yytype72 (yyvs.item (yyvsp - 2))
				yyval72.extend (yytype86 (yyvs.item (yyvsp)).first)
				yytype86 (yyvs.item (yyvsp)).second.set_node (new_class_type_as (yytype86 (yyvs.item (yyvsp)).first, Void))
			
			yyval := yyval72
		end

	yy_do_action_74 is
			--|#line 538
		local
			yyval67: EIFFEL_LIST [FEATURE_AS]
		do

				yyval67 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval67.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_75 is
			--|#line 543
		local
			yyval67: EIFFEL_LIST [FEATURE_AS]
		do

				yyval67 := yytype67 (yyvs.item (yyvsp - 1))
				yyval67.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_78 is
			--|#line 554
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

	yy_do_action_79 is
			--|#line 567
		local
			yyval89: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

yyval89 := new_clickable_feature_name_list (yytype87 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval89
		end

	yy_do_action_80 is
			--|#line 569
		local
			yyval89: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

				yyval89 := yytype89 (yyvs.item (yyvsp - 2))
				yyval89.first.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval89
		end

	yy_do_action_81 is
			--|#line 576
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
		end

	yy_do_action_82 is
			--|#line 580
		local

		do
			yyval := yyval_default;
is_frozen := False 

		end

	yy_do_action_83 is
			--|#line 582
		local

		do
			yyval := yyval_default;
is_frozen := True 

		end

	yy_do_action_84 is
			--|#line 586
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := new_clickable_feature_name (yytype86 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_85 is
			--|#line 588
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

yyval87 := yytype87 (yyvs.item (yyvsp)) 
			yyval := yyval87
		end

	yy_do_action_87 is
			--|#line 594
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := new_clickable_infix (yytype88 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_88 is
			--|#line 599
		local
			yyval87: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval87 := new_clickable_prefix (yytype88 (yyvs.item (yyvsp))) 
			yyval := yyval87
		end

	yy_do_action_89 is
			--|#line 603
		local
			yyval8: BODY_AS
		do

yyval8 := new_declaration_body (yytype84 (yyvs.item (yyvsp - 2)), yytype58 (yyvs.item (yyvsp - 1)), yytype15 (yyvs.item (yyvsp))) 
			yyval := yyval8
		end

	yy_do_action_90 is
			--|#line 607
		local
			yyval15: CONTENT_AS
		do

feature_indexes := yytype75 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_91 is
			--|#line 609
		local
			yyval15: CONTENT_AS
		do

yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_92 is
			--|#line 613
		local
			yyval15: CONTENT_AS
		do

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (yytype6 (yyvs.item (yyvsp - 1))))
				feature_indexes := yytype75 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_93 is
			--|#line 618
		local
			yyval15: CONTENT_AS
		do

				yyval15 := new_constant_as (create {VALUE_AS}.initialize (new_unique_as))
				feature_indexes := yytype75 (yyvs.item (yyvsp))
			
			yyval := yyval15
		end

	yy_do_action_94 is
			--|#line 623
		local
			yyval15: CONTENT_AS
		do

				yyval15 := yytype53 (yyvs.item (yyvsp))
				feature_indexes := yytype75 (yyvs.item (yyvsp - 1))
			
			yyval := yyval15
		end

	yy_do_action_96 is
			--|#line 636
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do

yyval79 := yytype79 (yyvs.item (yyvsp)) 
			yyval := yyval79
		end

	yy_do_action_97 is
			--|#line 638
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do

yyval79 := new_eiffel_list_parent_as (0) 
			yyval := yyval79
		end

	yy_do_action_98 is
			--|#line 642
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do

				yyval79 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval79.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_99 is
			--|#line 647
		local
			yyval79: EIFFEL_LIST [PARENT_AS]
		do

				yyval79 := yytype79 (yyvs.item (yyvsp - 1))
				yyval79.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_100 is
			--|#line 654
		local
			yyval44: PARENT_AS
		do

				yyval44 := yytype44 (yyvs.item (yyvsp))
				yytype44 (yyvs.item (yyvsp)).set_location (yytype91 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_101 is
			--|#line 659
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := yytype44 (yyvs.item (yyvsp - 1))
				yytype44 (yyvs.item (yyvsp - 1)).set_location (yytype91 (yyvs.item (yyvsp - 2)))
			
			yyval := yyval44
		end

	yy_do_action_102 is
			--|#line 667
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_103 is
			--|#line 672
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 7)), yytype83 (yyvs.item (yyvsp - 6)), yytype80 (yyvs.item (yyvsp - 5)), yytype65 (yyvs.item (yyvsp - 4)), yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_104 is
			--|#line 677
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 6)), yytype83 (yyvs.item (yyvsp - 5)), Void, yytype65 (yyvs.item (yyvsp - 4)), yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_105 is
			--|#line 682
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 5)), yytype83 (yyvs.item (yyvsp - 4)), Void, Void, yytype70 (yyvs.item (yyvsp - 3)), yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_106 is
			--|#line 687
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 4)), yytype83 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype70 (yyvs.item (yyvsp - 2)), yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_107 is
			--|#line 692
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 3)), yytype83 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype70 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_108 is
			--|#line 697
		local
			yyval44: PARENT_AS
		do

				inherit_context := True
				real_class_end_position := current_position.end_position - 3
				yyval44 := new_parent_clause (yytype86 (yyvs.item (yyvsp - 2)), yytype83 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_110 is
			--|#line 707
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do

yyval80 := yytype80 (yyvs.item (yyvsp)) 
			yyval := yyval80
		end

	yy_do_action_111 is
			--|#line 711
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do

				yyval80 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval80.extend (yytype48 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_112 is
			--|#line 716
		local
			yyval80: EIFFEL_LIST [RENAME_AS]
		do

				yyval80 := yytype80 (yyvs.item (yyvsp - 2))
				yyval80.extend (yytype48 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_113 is
			--|#line 723
		local
			yyval48: RENAME_AS
		do

yyval48 := new_rename_pair (yytype87 (yyvs.item (yyvsp - 2)), yytype87 (yyvs.item (yyvsp))) 
			yyval := yyval48
		end

	yy_do_action_115 is
			--|#line 729
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_116 is
			--|#line 733
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_118 is
			--|#line 739
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval65 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				yyval65.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_119 is
			--|#line 744
		local
			yyval65: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval65 := yytype65 (yyvs.item (yyvsp - 1))
				yyval65.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_120 is
			--|#line 751
		local
			yyval22: EXPORT_ITEM_AS
		do

yyval22 := new_export_item_as (new_client_as (yytype72 (yyvs.item (yyvsp - 2))), yytype28 (yyvs.item (yyvsp - 1))) 
			yyval := yyval22
		end

	yy_do_action_121 is
			--|#line 755
		local
			yyval28: FEATURE_SET_AS
		do

yyval28 := new_all_as 
			yyval := yyval28
		end

	yy_do_action_122 is
			--|#line 757
		local
			yyval28: FEATURE_SET_AS
		do

yyval28 := new_feature_list_as (yytype70 (yyvs.item (yyvsp))) 
			yyval := yyval28
		end

	yy_do_action_123 is
			--|#line 761
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval70 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval70.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval70
		end

	yy_do_action_124 is
			--|#line 766
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval70 := yytype70 (yyvs.item (yyvsp - 2))
				yyval70.extend (yytype87 (yyvs.item (yyvsp)).first)
			
			yyval := yyval70
		end

	yy_do_action_126 is
			--|#line 775
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_128 is
			--|#line 781
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_130 is
			--|#line 787
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_132 is
			--|#line 793
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_134 is
			--|#line 799
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_136 is
			--|#line 805
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_138 is
			--|#line 815
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval84 := yytype84 (yyvs.item (yyvsp - 1)) 
			yyval := yyval84
		end

	yy_do_action_140 is
			--|#line 821
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_141 is
			--|#line 825
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval84 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_142 is
			--|#line 830
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval84 := yytype84 (yyvs.item (yyvsp - 1))
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_143 is
			--|#line 837
		local
			yyval59: TYPE_DEC_AS
		do

yyval59 := new_type_dec_as (yytype74 (yyvs.item (yyvsp - 4)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval59
		end

	yy_do_action_145 is
			--|#line 842
		local

		do
			yyval := yyval_default;
				if il_parser then
						-- Trigger a syntax error.
					raise_error
				end
			

		end

	yy_do_action_147 is
			--|#line 853
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_148 is
			--|#line 857
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval84 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_149 is
			--|#line 862
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval84 := yytype84 (yyvs.item (yyvsp - 1))
				yyval84.extend (yytype59 (yyvs.item (yyvsp)))
			
			yyval := yyval84
		end

	yy_do_action_150 is
			--|#line 869
		local
			yyval59: TYPE_DEC_AS
		do

yyval59 := new_type_dec_as (yytype74 (yyvs.item (yyvsp - 3)), yytype58 (yyvs.item (yyvsp - 1))) 
			yyval := yyval59
		end

	yy_do_action_151 is
			--|#line 873
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do

				create yyval74.make (Initial_identifier_list_size)
				Names_heap.put (yytype30 (yyvs.item (yyvsp)))
				yyval74.extend (Names_heap.found_item)
			
			yyval := yyval74
		end

	yy_do_action_152 is
			--|#line 879
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do

				yyval74 := yytype74 (yyvs.item (yyvsp - 2))
				Names_heap.put (yytype30 (yyvs.item (yyvsp)))
				yyval74.extend (Names_heap.found_item)
			
			yyval := yyval74
		end

	yy_do_action_153 is
			--|#line 887
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do

create yyval74.make (0) 
			yyval := yyval74
		end

	yy_do_action_154 is
			--|#line 889
		local
			yyval74: ARRAYED_LIST [INTEGER]
		do

yyval74 := yytype74 (yyvs.item (yyvsp)) 
			yyval := yyval74
		end

	yy_do_action_156 is
			--|#line 895
		local
			yyval58: TYPE
		do

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_157 is
			--|#line 899
		local
			yyval53: ROUTINE_AS
		do

yyval53 := new_routine_as (yytype55 (yyvs.item (yyvsp - 7)), yytype49 (yyvs.item (yyvsp - 5)), yytype84 (yyvs.item (yyvsp - 4)), yytype52 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), fbody_pos, current_position) 
			yyval := yyval53
		end

	yy_do_action_158 is
			--|#line 899
		local

		do
			yyval := yyval_default;
fbody_pos := current_position.start_position 

		end

	yy_do_action_159 is
			--|#line 911
		local
			yyval52: ROUT_BODY_AS
		do

yyval52 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval52
		end

	yy_do_action_160 is
			--|#line 913
		local
			yyval52: ROUT_BODY_AS
		do

yyval52 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval52
		end

	yy_do_action_161 is
			--|#line 915
		local
			yyval52: ROUT_BODY_AS
		do

yyval52 := new_deferred_as 
			yyval := yyval52
		end

	yy_do_action_162 is
			--|#line 919
		local
			yyval24: EXTERNAL_AS
		do

yyval24 := new_external_as (yytype25 (yyvs.item (yyvsp - 1)), yytype55 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_163 is
			--|#line 923
		local
			yyval25: EXTERNAL_LANG_AS
		do

yyval25 := new_external_lang_as (yytype55 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval25
		end

	yy_do_action_165 is
			--|#line 930
		local
			yyval55: STRING_AS
		do

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_166 is
			--|#line 934
		local
			yyval37: INTERNAL_AS
		do

yyval37 := new_do_as (yytype76 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_167 is
			--|#line 936
		local
			yyval37: INTERNAL_AS
		do

yyval37 := new_once_as (yytype76 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_169 is
			--|#line 942
		local
			yyval84: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_171 is
			--|#line 948
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_172 is
			--|#line 952
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval76.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_173 is
			--|#line 957
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp - 1))
				yyval76.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_174 is
			--|#line 964
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype35 (yyvs.item (yyvsp - 1)) 
			yyval := yyval35
		end

	yy_do_action_177 is
			--|#line 972
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_178 is
			--|#line 974
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_179 is
			--|#line 976
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_180 is
			--|#line 978
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype51 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_181 is
			--|#line 980
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype31 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_182 is
			--|#line 982
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_183 is
			--|#line 984
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype40 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_184 is
			--|#line 986
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_185 is
			--|#line 988
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_186 is
			--|#line 990
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype50 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_188 is
			--|#line 996
		local
			yyval49: REQUIRE_AS
		do

				id_level := Normal_level
				yyval49 := new_require_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval49
		end

	yy_do_action_189 is
			--|#line 996
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_190 is
			--|#line 1003
		local
			yyval49: REQUIRE_AS
		do

				id_level := Normal_level
				yyval49 := new_require_else_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval49
		end

	yy_do_action_191 is
			--|#line 1003
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_193 is
			--|#line 1014
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_194 is
			--|#line 1014
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_195 is
			--|#line 1021
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_then_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_196 is
			--|#line 1021
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_198 is
			--|#line 1032
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

				yyval82 := yytype82 (yyvs.item (yyvsp))
				if yyval82.is_empty then
					yyval82 := Void
				end
			
			yyval := yyval82
		end

	yy_do_action_199 is
			--|#line 1041
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

				yyval82 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval82, yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_200 is
			--|#line 1046
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

				yyval82 := yytype82 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval82, yytype56 (yyvs.item (yyvsp)))
			
			yyval := yyval82
		end

	yy_do_action_201 is
			--|#line 1053
		local
			yyval56: TAGGED_AS
		do

yyval56 := yytype56 (yyvs.item (yyvsp - 1)) 
			yyval := yyval56
		end

	yy_do_action_202 is
			--|#line 1057
		local
			yyval56: TAGGED_AS
		do

yyval56 := new_tagged_as (Void, yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval56
		end

	yy_do_action_203 is
			--|#line 1059
		local
			yyval56: TAGGED_AS
		do

yyval56 := new_tagged_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval56
		end

	yy_do_action_205 is
			--|#line 1069
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

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_207 is
			--|#line 1075
		local
			yyval58: TYPE
		do

yyval58 := new_expanded_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_208 is
			--|#line 1077
		local
			yyval58: TYPE
		do

yyval58 := new_separate_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_209 is
			--|#line 1079
		local
			yyval58: TYPE
		do

yyval58 := new_bits_as (yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_210 is
			--|#line 1081
		local
			yyval58: TYPE
		do

yyval58 := new_bits_symbol_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_211 is
			--|#line 1083
		local
			yyval58: TYPE
		do

yyval58 := new_like_id_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_212 is
			--|#line 1085
		local
			yyval58: TYPE
		do

yyval58 := new_like_current_as 
			yyval := yyval58
		end

	yy_do_action_213 is
			--|#line 1089
		local
			yyval58: TYPE
		do

yyval58 := new_class_type (yytype86 (yyvs.item (yyvsp - 1)), yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval58
		end

	yy_do_action_214 is
			--|#line 1091
		local
			yyval58: TYPE
		do

yyval58 := new_boolean_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_215 is
			--|#line 1093
		local
			yyval58: TYPE
		do

yyval58 := new_character_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, False) 
			yyval := yyval58
		end

	yy_do_action_216 is
			--|#line 1095
		local
			yyval58: TYPE
		do

yyval58 := new_character_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, True) 
			yyval := yyval58
		end

	yy_do_action_217 is
			--|#line 1097
		local
			yyval58: TYPE
		do

yyval58 := new_double_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_218 is
			--|#line 1099
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 8) 
			yyval := yyval58
		end

	yy_do_action_219 is
			--|#line 1101
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 16) 
			yyval := yyval58
		end

	yy_do_action_220 is
			--|#line 1103
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 32) 
			yyval := yyval58
		end

	yy_do_action_221 is
			--|#line 1105
		local
			yyval58: TYPE
		do

yyval58 := new_integer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void, 64) 
			yyval := yyval58
		end

	yy_do_action_222 is
			--|#line 1107
		local
			yyval58: TYPE
		do

yyval58 := new_none_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_223 is
			--|#line 1109
		local
			yyval58: TYPE
		do

yyval58 := new_pointer_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_224 is
			--|#line 1111
		local
			yyval58: TYPE
		do

yyval58 := new_real_type (yytype86 (yyvs.item (yyvsp - 1)).second, yytype83 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval58
		end

	yy_do_action_227 is
			--|#line 1119
		local
			yyval83: EIFFEL_LIST [TYPE]
		do

yyval83 := yytype83 (yyvs.item (yyvsp - 1)) 
			yyval := yyval83
		end

	yy_do_action_228 is
			--|#line 1123
		local
			yyval83: EIFFEL_LIST [TYPE]
		do

				yyval83 := new_eiffel_list_type (Initial_type_list_size)
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_229 is
			--|#line 1128
		local
			yyval83: EIFFEL_LIST [TYPE]
		do

				yyval83 := yytype83 (yyvs.item (yyvsp - 2))
				yyval83.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval83
		end

	yy_do_action_230 is
			--|#line 1139
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				-- $$ := Void
				formal_generics_start_position := current_position.start_position
				formal_generics_end_position := 0
			
			yyval := yyval71
		end

	yy_do_action_231 is
			--|#line 1145
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 1))
				formal_generics_start_position := yytype91 (yyvs.item (yyvsp - 3)).start_position
				formal_generics_end_position := current_position.start_position
			
			yyval := yyval71
		end

	yy_do_action_233 is
			--|#line 1155
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

yyval71 := yytype71 (yyvs.item (yyvsp)) 
			yyval := yyval71
		end

	yy_do_action_234 is
			--|#line 1159
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval71 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval71.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_235 is
			--|#line 1164
		local
			yyval71: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_236 is
			--|#line 1171
		local
			yyval29: FORMAL_DEC_AS
		do

				check formal_exists: not formal_parameters.is_empty end
				yyval29 := new_formal_dec_as (formal_parameters.last, yytype90 (yyvs.item (yyvsp)).first, yytype90 (yyvs.item (yyvsp)).second, formal_parameters.count)
			
			yyval := yyval29
		end

	yy_do_action_237 is
			--|#line 1171
		local

		do
			yyval := yyval_default;
formal_parameters.extend (create {ID_AS}.initialize (token_buffer)) 

		end

	yy_do_action_238 is
			--|#line 1181
		local
			yyval90: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do

create yyval90 
			yyval := yyval90
		end

	yy_do_action_239 is
			--|#line 1183
		local
			yyval90: PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]
		do

				create yyval90
				yyval90.set_first (yytype58 (yyvs.item (yyvsp - 1)))
				yyval90.set_second (yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval90
		end

	yy_do_action_241 is
			--|#line 1193
		local
			yyval70: EIFFEL_LIST [FEATURE_NAME]
		do

yyval70 := yytype70 (yyvs.item (yyvsp - 1)) 
			yyval := yyval70
		end

	yy_do_action_242 is
			--|#line 1201
		local
			yyval31: IF_AS
		do

				yyval31 := new_if_as (yytype23 (yyvs.item (yyvsp - 5)), yytype76 (yyvs.item (yyvsp - 3)), yytype64 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 7)))
			
			yyval := yyval31
		end

	yy_do_action_244 is
			--|#line 1209
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_245 is
			--|#line 1213
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do

				yyval64 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval64.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_246 is
			--|#line 1218
		local
			yyval64: EIFFEL_LIST [ELSIF_AS]
		do

				yyval64 := yytype64 (yyvs.item (yyvsp - 1))
				yyval64.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_247 is
			--|#line 1225
		local
			yyval20: ELSIF_AS
		do

yyval20 := new_elseif_as (yytype23 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 4))) 
			yyval := yyval20
		end

	yy_do_action_249 is
			--|#line 1231
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_250 is
			--|#line 1235
		local
			yyval33: INSPECT_AS
		do

				yyval33 := new_inspect_as (yytype23 (yyvs.item (yyvsp - 3)), yytype62 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)))
			
			yyval := yyval33
		end

	yy_do_action_252 is
			--|#line 1243
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do

yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
		end

	yy_do_action_253 is
			--|#line 1247
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do

				yyval62 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval62.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_254 is
			--|#line 1252
		local
			yyval62: EIFFEL_LIST [CASE_AS]
		do

				yyval62 := yytype62 (yyvs.item (yyvsp - 1))
				yyval62.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_255 is
			--|#line 1259
		local
			yyval11: CASE_AS
		do

yyval11 := new_case_as (yytype77 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval11
		end

	yy_do_action_256 is
			--|#line 1263
		local
			yyval77: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval77 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval77.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_257 is
			--|#line 1268
		local
			yyval77: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval77 := yytype77 (yyvs.item (yyvsp - 2))
				yyval77.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_258 is
			--|#line 1275
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_259 is
			--|#line 1277
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_260 is
			--|#line 1279
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_261 is
			--|#line 1281
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_262 is
			--|#line 1283
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_263 is
			--|#line 1285
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_264 is
			--|#line 1287
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_265 is
			--|#line 1289
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_266 is
			--|#line 1291
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_267 is
			--|#line 1293
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_268 is
			--|#line 1295
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_269 is
			--|#line 1297
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_270 is
			--|#line 1299
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_271 is
			--|#line 1301
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_272 is
			--|#line 1303
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_273 is
			--|#line 1305
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_274 is
			--|#line 1307
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype46 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_275 is
			--|#line 1309
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype46 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_277 is
			--|#line 1316
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp))
				if yyval76 = Void then
					yyval76 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval76
		end

	yy_do_action_278 is
			--|#line 1325
		local
			yyval40: LOOP_AS
		do

				yyval40 := new_loop_as (yytype76 (yyvs.item (yyvsp - 8)), yytype82 (yyvs.item (yyvsp - 7)), yytype60 (yyvs.item (yyvsp - 6)), yytype23 (yyvs.item (yyvsp - 3)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)))
			
			yyval := yyval40
		end

	yy_do_action_280 is
			--|#line 1333
		local
			yyval82: EIFFEL_LIST [TAGGED_AS]
		do

yyval82 := yytype82 (yyvs.item (yyvsp)) 
			yyval := yyval82
		end

	yy_do_action_282 is
			--|#line 1339
		local
			yyval39: INVARIANT_AS
		do

				id_level := Normal_level
				inherit_context := False
				yyval39 := new_invariant_as (yytype82 (yyvs.item (yyvsp)))
			
			yyval := yyval39
		end

	yy_do_action_283 is
			--|#line 1339
		local

		do
			yyval := yyval_default;
id_level := Invariant_level 

		end

	yy_do_action_285 is
			--|#line 1351
		local
			yyval60: VARIANT_AS
		do

yyval60 := new_variant_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval60
		end

	yy_do_action_286 is
			--|#line 1353
		local
			yyval60: VARIANT_AS
		do

yyval60 := new_variant_as (Void, yytype23 (yyvs.item (yyvsp)), current_position) 
			yyval := yyval60
		end

	yy_do_action_287 is
			--|#line 1357
		local
			yyval19: DEBUG_AS
		do

				yyval19 := new_debug_as (yytype81 (yyvs.item (yyvsp - 2)), yytype76 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 4)))
			
			yyval := yyval19
		end

	yy_do_action_290 is
			--|#line 1367
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do

yyval81 := yytype81 (yyvs.item (yyvsp - 1)) 
			yyval := yyval81
		end

	yy_do_action_291 is
			--|#line 1371
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do

				yyval81 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval81.extend (yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_292 is
			--|#line 1376
		local
			yyval81: EIFFEL_LIST [STRING_AS]
		do

				yyval81 := yytype81 (yyvs.item (yyvsp - 2))
				yyval81.extend (yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_293 is
			--|#line 1383
		local
			yyval50: RETRY_AS
		do

yyval50 := new_retry_as (current_position) 
			yyval := yyval50
		end

	yy_do_action_295 is
			--|#line 1389
		local
			yyval76: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp))
				if yyval76 = Void then
					yyval76 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval76
		end

	yy_do_action_296 is
			--|#line 1398
		local
			yyval5: ASSIGN_AS
		do

yyval5 := new_assign_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_297 is
			--|#line 1400
		local
			yyval5: ASSIGN_AS
		do

yyval5 := new_assign_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval5
		end

	yy_do_action_298 is
			--|#line 1404
		local
			yyval51: REVERSE_AS
		do

yyval51 := new_reverse_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval51
		end

	yy_do_action_299 is
			--|#line 1406
		local
			yyval51: REVERSE_AS
		do

yyval51 := new_reverse_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval51
		end

	yy_do_action_301 is
			--|#line 1412
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_302 is
			--|#line 1416
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do

				yyval63 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval63.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_303 is
			--|#line 1421
		local
			yyval63: EIFFEL_LIST [CREATE_AS]
		do

				yyval63 := yytype63 (yyvs.item (yyvsp - 1))
				yyval63.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_304 is
			--|#line 1428
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_305 is
			--|#line 1434
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_306 is
			--|#line 1439
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype72 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_307 is
			--|#line 1444
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_308 is
			--|#line 1449
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype70 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_309 is
			--|#line 1454
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype72 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_310 is
			--|#line 1461
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_result_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_311 is
			--|#line 1464
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_312 is
			--|#line 1466
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 3)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_313 is
			--|#line 1468
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 4))), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_314 is
			--|#line 1470
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (yytype58 (yyvs.item (yyvsp - 4)), Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_315 is
			--|#line 1472
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (Void, yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_316 is
			--|#line 1474
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_317 is
			--|#line 1476
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_result_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_318 is
			--|#line 1478
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_319 is
			--|#line 1480
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 3)), Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_320 is
			--|#line 1482
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_As (new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 4))), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_321 is
			--|#line 1484
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (yytype58 (yyvs.item (yyvsp - 3)), Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_322 is
			--|#line 1486
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (Void, yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_323 is
			--|#line 1488
		local
			yyval54: ROUTINE_CREATION_AS
		do

yyval54 := new_routine_creation_as (new_operand_as (Void, Void, Void), yytype30 (yyvs.item (yyvsp - 1)), yytype78 (yyvs.item (yyvsp))) 
			yyval := yyval54
		end

	yy_do_action_325 is
			--|#line 1494
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do

yyval78 := yytype78 (yyvs.item (yyvsp - 1)) 
			yyval := yyval78
		end

	yy_do_action_326 is
			--|#line 1498
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do

				yyval78 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval78.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_327 is
			--|#line 1503
		local
			yyval78: EIFFEL_LIST [OPERAND_AS]
		do

				yyval78 := yytype78 (yyvs.item (yyvsp - 2))
				yyval78.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_328 is
			--|#line 1510
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, Void) 
			yyval := yyval43
		end

	yy_do_action_329 is
			--|#line 1512
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval43
		end

	yy_do_action_330 is
			--|#line 1514
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_class_type (yytype86 (yyvs.item (yyvsp - 2)), yytype83 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_331 is
			--|#line 1516
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_boolean_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_332 is
			--|#line 1518
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_character_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, False), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_333 is
			--|#line 1520
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_character_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, True), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_334 is
			--|#line 1522
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_double_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_335 is
			--|#line 1524
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 8), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_336 is
			--|#line 1526
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 16), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_337 is
			--|#line 1528
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 32), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_338 is
			--|#line 1530
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void, 64), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_339 is
			--|#line 1532
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_none_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_340 is
			--|#line 1534
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_pointer_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_341 is
			--|#line 1536
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_real_type (yytype86 (yyvs.item (yyvsp - 2)).second, yytype83 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_342 is
			--|#line 1538
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (yytype58 (yyvs.item (yyvsp - 1)), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_343 is
			--|#line 1542
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (yytype58 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 5))) 
			yyval := yyval17
		end

	yy_do_action_344 is
			--|#line 1544
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (Void, yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval17
		end

	yy_do_action_345 is
			--|#line 1546
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (yytype58 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 6))) 
			yyval := yyval17
		end

	yy_do_action_346 is
			--|#line 1550
		local
			yyval18: CREATION_EXPR_AS
		do

yyval18 := new_creation_expr_as (yytype58 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval18
		end

	yy_do_action_347 is
			--|#line 1552
		local
			yyval18: CREATION_EXPR_AS
		do

yyval18 := new_creation_expr_as (yytype58 (yyvs.item (yyvsp - 3)), yytype3 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval18
		end

	yy_do_action_349 is
			--|#line 1558
		local
			yyval58: TYPE
		do

yyval58 := yytype58 (yyvs.item (yyvsp)) 
			yyval := yyval58
		end

	yy_do_action_350 is
			--|#line 1562
		local
			yyval1: ACCESS_AS
		do

yyval1 := new_access_id_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval1
		end

	yy_do_action_351 is
			--|#line 1564
		local
			yyval1: ACCESS_AS
		do

yyval1 := new_result_as 
			yyval := yyval1
		end

	yy_do_action_353 is
			--|#line 1570
		local
			yyval3: ACCESS_INV_AS
		do

yyval3 := new_access_inv_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_354 is
			--|#line 1578
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype1 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_355 is
			--|#line 1580
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_356 is
			--|#line 1582
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_357 is
			--|#line 1584
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_358 is
			--|#line 1586
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_359 is
			--|#line 1588
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype45 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_360 is
			--|#line 1590
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_361 is
			--|#line 1592
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype46 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_362 is
			--|#line 1594
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yytype91 (yyvs.item (yyvsp - 1))) 
			yyval := yyval34
		end

	yy_do_action_363 is
			--|#line 1598
		local
			yyval13: CHECK_AS
		do

yyval13 := new_check_as (yytype82 (yyvs.item (yyvsp - 1)), yytype91 (yyvs.item (yyvsp - 3))) 
			yyval := yyval13
		end

	yy_do_action_364 is
			--|#line 1606
		local
			yyval23: EXPR_AS
		do

create {VALUE_AS} yyval23.initialize (yytype6 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_365 is
			--|#line 1608
		local
			yyval23: EXPR_AS
		do

create {VALUE_AS} yyval23.initialize (yytype4 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_366 is
			--|#line 1610
		local
			yyval23: EXPR_AS
		do

create {VALUE_AS} yyval23.initialize (yytype57 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_367 is
			--|#line 1612
		local
			yyval23: EXPR_AS
		do

yyval23 := new_expr_call_as (yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_368 is
			--|#line 1614
		local
			yyval23: EXPR_AS
		do

yyval23 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_369 is
			--|#line 1616
		local
			yyval23: EXPR_AS
		do

yyval23 := new_paran_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_370 is
			--|#line 1618
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_plus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_371 is
			--|#line 1620
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_minus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_372 is
			--|#line 1622
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_star_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_373 is
			--|#line 1624
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_slash_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_374 is
			--|#line 1626
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_mod_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_375 is
			--|#line 1628
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_div_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_376 is
			--|#line 1630
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_power_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_377 is
			--|#line 1632
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_and_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_378 is
			--|#line 1634
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_and_then_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_379 is
			--|#line 1636
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_or_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_380 is
			--|#line 1638
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_or_else_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_381 is
			--|#line 1640
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_implies_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_382 is
			--|#line 1642
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_xor_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_383 is
			--|#line 1644
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_ge_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_384 is
			--|#line 1646
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_gt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_385 is
			--|#line 1648
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_le_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_386 is
			--|#line 1650
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_lt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_387 is
			--|#line 1652
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_eq_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_388 is
			--|#line 1654
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_ne_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_389 is
			--|#line 1656
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_free_as (yytype23 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_390 is
			--|#line 1658
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_minus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_391 is
			--|#line 1660
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_plus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_392 is
			--|#line 1662
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_not_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_393 is
			--|#line 1664
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_old_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_394 is
			--|#line 1666
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_free_as (yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_395 is
			--|#line 1668
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_strip_as (yytype74 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_396 is
			--|#line 1670
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_as (yytype87 (yyvs.item (yyvsp)).first) 
			yyval := yyval23
		end

	yy_do_action_397 is
			--|#line 1672
		local
			yyval23: EXPR_AS
		do

yyval23 := new_expr_address_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_398 is
			--|#line 1674
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_current_as 
			yyval := yyval23
		end

	yy_do_action_399 is
			--|#line 1676
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_result_as 
			yyval := yyval23
		end

	yy_do_action_400 is
			--|#line 1680
		local
			yyval30: ID_AS
		do

create yyval30.initialize (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_401 is
			--|#line 1688
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_402 is
			--|#line 1690
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_403 is
			--|#line 1692
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_404 is
			--|#line 1694
		local
			yyval10: CALL_AS
		do

yyval10 := new_current_as 
			yyval := yyval10
		end

	yy_do_action_405 is
			--|#line 1696
		local
			yyval10: CALL_AS
		do

yyval10 := new_result_as 
			yyval := yyval10
		end

	yy_do_action_406 is
			--|#line 1698
		local
			yyval10: CALL_AS
		do

yyval10 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_407 is
			--|#line 1700
		local
			yyval10: CALL_AS
		do

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_408 is
			--|#line 1702
		local
			yyval10: CALL_AS
		do

yyval10 := yytype45 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_409 is
			--|#line 1704
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_410 is
			--|#line 1706
		local
			yyval10: CALL_AS
		do

yyval10 := yytype46 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_411 is
			--|#line 1708
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_412 is
			--|#line 1710
		local
			yyval10: CALL_AS
		do

yyval10 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_413 is
			--|#line 1714
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (new_current_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_414 is
			--|#line 1718
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (new_result_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_415 is
			--|#line 1722
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype1 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_416 is
			--|#line 1726
		local
			yyval42: NESTED_EXPR_AS
		do

yyval42 := new_nested_expr_as (yytype23 (yyvs.item (yyvsp - 3)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_417 is
			--|#line 1730
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype45 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_418 is
			--|#line 1734
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor_as (Void, yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_419 is
			--|#line 1736
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 4)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_420 is
			--|#line 1738
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 2)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_421 is
			--|#line 1740
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_422 is
			--|#line 1742
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_423 is
			--|#line 1744
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_424 is
			--|#line 1746
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_425 is
			--|#line 1748
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_426 is
			--|#line 1750
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_427 is
			--|#line 1752
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_428 is
			--|#line 1754
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_429 is
			--|#line 1756
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_430 is
			--|#line 1758
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_431 is
			--|#line 1760
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype86 (yyvs.item (yyvsp - 3)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_432 is
			--|#line 1764
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype46 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_433 is
			--|#line 1768
		local
			yyval46: STATIC_ACCESS_AS
		do

				yyval46 := new_static_access_as (yytype58 (yyvs.item (yyvsp - 4)), yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp)));
			
			yyval := yyval46
		end

	yy_do_action_434 is
			--|#line 1775
		local
			yyval46: STATIC_ACCESS_AS
		do

				yyval46 := new_static_access_as (yytype58 (yyvs.item (yyvsp - 3)), yytype30 (yyvs.item (yyvsp)), Void);
			
			yyval := yyval46
		end

	yy_do_action_435 is
			--|#line 1783
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_436 is
			--|#line 1785
		local
			yyval10: CALL_AS
		do

yyval10 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_437 is
			--|#line 1789
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_438 is
			--|#line 1791
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype41 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_439 is
			--|#line 1795
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

	yy_do_action_440 is
			--|#line 1808
		local
			yyval2: ACCESS_FEAT_AS
		do

yyval2 := new_access_feat_as (yytype30 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp))) 
			yyval := yyval2
		end

	yy_do_action_443 is
			--|#line 1816
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

yyval66 := yytype66 (yyvs.item (yyvsp - 1)) 
			yyval := yyval66
		end

	yy_do_action_444 is
			--|#line 1820
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_445 is
			--|#line 1825
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := yytype66 (yyvs.item (yyvsp - 2))
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_446 is
			--|#line 1832
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

yyval66 := new_eiffel_list_expr_as (0) 
			yyval := yyval66
		end

	yy_do_action_447 is
			--|#line 1834
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

yyval66 := yytype66 (yyvs.item (yyvsp)) 
			yyval := yyval66
		end

	yy_do_action_448 is
			--|#line 1838
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_449 is
			--|#line 1843
		local
			yyval66: EIFFEL_LIST [EXPR_AS]
		do

				yyval66 := yytype66 (yyvs.item (yyvsp - 2))
				yyval66.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_450 is
			--|#line 1854
		local
			yyval30: ID_AS
		do

create yyval30.initialize (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_451 is
			--|#line 1856
		local
			yyval30: ID_AS
		do

yyval30 := new_boolean_id_as 
			yyval := yyval30
		end

	yy_do_action_452 is
			--|#line 1858
		local
			yyval30: ID_AS
		do

yyval30 := new_character_id_as (False) 
			yyval := yyval30
		end

	yy_do_action_453 is
			--|#line 1860
		local
			yyval30: ID_AS
		do

yyval30 := new_character_id_as (True) 
			yyval := yyval30
		end

	yy_do_action_454 is
			--|#line 1862
		local
			yyval30: ID_AS
		do

yyval30 := new_double_id_as 
			yyval := yyval30
		end

	yy_do_action_455 is
			--|#line 1864
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (8) 
			yyval := yyval30
		end

	yy_do_action_456 is
			--|#line 1866
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (16) 
			yyval := yyval30
		end

	yy_do_action_457 is
			--|#line 1868
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (32) 
			yyval := yyval30
		end

	yy_do_action_458 is
			--|#line 1870
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as (64) 
			yyval := yyval30
		end

	yy_do_action_459 is
			--|#line 1872
		local
			yyval30: ID_AS
		do

yyval30 := new_none_id_as 
			yyval := yyval30
		end

	yy_do_action_460 is
			--|#line 1874
		local
			yyval30: ID_AS
		do

yyval30 := new_pointer_id_as 
			yyval := yyval30
		end

	yy_do_action_461 is
			--|#line 1876
		local
			yyval30: ID_AS
		do

yyval30 := new_real_id_as 
			yyval := yyval30
		end

	yy_do_action_462 is
			--|#line 1880
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_463 is
			--|#line 1882
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_464 is
			--|#line 1884
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_465 is
			--|#line 1886
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype47 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_466 is
			--|#line 1888
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_467 is
			--|#line 1890
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_468 is
			--|#line 1894
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_469 is
			--|#line 1896
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_470 is
			--|#line 1898
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

	yy_do_action_471 is
			--|#line 1913
		local
			yyval6: ATOMIC_AS
		do

yyval6 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval6
		end

	yy_do_action_472 is
			--|#line 1915
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_473 is
			--|#line 1917
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_474 is
			--|#line 1921
		local
			yyval9: BOOL_AS
		do

yyval9 := new_boolean_as (False) 
			yyval := yyval9
		end

	yy_do_action_475 is
			--|#line 1923
		local
			yyval9: BOOL_AS
		do

yyval9 := new_boolean_as (True) 
			yyval := yyval9
		end

	yy_do_action_476 is
			--|#line 1927
		local
			yyval12: CHAR_AS
		do

				check is_character: not token_buffer.is_empty end
				yyval12 := new_character_as (token_buffer.item (1))
			
			yyval := yyval12
		end

	yy_do_action_477 is
			--|#line 1934
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
			--|#line 1949
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

	yy_do_action_479 is
			--|#line 1964
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

	yy_do_action_480 is
			--|#line 1982
		local
			yyval47: REAL_AS
		do

yyval47 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval47
		end

	yy_do_action_481 is
			--|#line 1984
		local
			yyval47: REAL_AS
		do

yyval47 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval47
		end

	yy_do_action_482 is
			--|#line 1986
		local
			yyval47: REAL_AS
		do

				token_buffer.precede ('-')
				yyval47 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval47
		end

	yy_do_action_483 is
			--|#line 1993
		local
			yyval7: BIT_CONST_AS
		do

yyval7 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval7
		end

	yy_do_action_484 is
			--|#line 1997
		local
			yyval55: STRING_AS
		do

yyval55 := yytype55 (yyvs.item (yyvsp)) 
			yyval := yyval55
		end

	yy_do_action_485 is
			--|#line 1999
		local
			yyval55: STRING_AS
		do

yyval55 := new_empty_string_as 
			yyval := yyval55
		end

	yy_do_action_486 is
			--|#line 2001
		local
			yyval55: STRING_AS
		do

yyval55 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval55
		end

	yy_do_action_487 is
			--|#line 2005
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_488 is
			--|#line 2007
		local
			yyval55: STRING_AS
		do

yyval55 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval55
		end

	yy_do_action_489 is
			--|#line 2009
		local
			yyval55: STRING_AS
		do

yyval55 := new_lt_string_as 
			yyval := yyval55
		end

	yy_do_action_490 is
			--|#line 2011
		local
			yyval55: STRING_AS
		do

yyval55 := new_le_string_as 
			yyval := yyval55
		end

	yy_do_action_491 is
			--|#line 2013
		local
			yyval55: STRING_AS
		do

yyval55 := new_gt_string_as 
			yyval := yyval55
		end

	yy_do_action_492 is
			--|#line 2015
		local
			yyval55: STRING_AS
		do

yyval55 := new_ge_string_as 
			yyval := yyval55
		end

	yy_do_action_493 is
			--|#line 2017
		local
			yyval55: STRING_AS
		do

yyval55 := new_minus_string_as 
			yyval := yyval55
		end

	yy_do_action_494 is
			--|#line 2019
		local
			yyval55: STRING_AS
		do

yyval55 := new_plus_string_as 
			yyval := yyval55
		end

	yy_do_action_495 is
			--|#line 2021
		local
			yyval55: STRING_AS
		do

yyval55 := new_star_string_as 
			yyval := yyval55
		end

	yy_do_action_496 is
			--|#line 2023
		local
			yyval55: STRING_AS
		do

yyval55 := new_slash_string_as 
			yyval := yyval55
		end

	yy_do_action_497 is
			--|#line 2025
		local
			yyval55: STRING_AS
		do

yyval55 := new_mod_string_as 
			yyval := yyval55
		end

	yy_do_action_498 is
			--|#line 2027
		local
			yyval55: STRING_AS
		do

yyval55 := new_div_string_as 
			yyval := yyval55
		end

	yy_do_action_499 is
			--|#line 2029
		local
			yyval55: STRING_AS
		do

yyval55 := new_power_string_as 
			yyval := yyval55
		end

	yy_do_action_500 is
			--|#line 2031
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_501 is
			--|#line 2033
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_502 is
			--|#line 2035
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_503 is
			--|#line 2037
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_504 is
			--|#line 2039
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_505 is
			--|#line 2041
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_506 is
			--|#line 2043
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_507 is
			--|#line 2045
		local
			yyval55: STRING_AS
		do

yyval55 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval55
		end

	yy_do_action_508 is
			--|#line 2049
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_minus_string_as) 
			yyval := yyval88
		end

	yy_do_action_509 is
			--|#line 2051
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_plus_string_as) 
			yyval := yyval88
		end

	yy_do_action_510 is
			--|#line 2053
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_not_string_as) 
			yyval := yyval88
		end

	yy_do_action_511 is
			--|#line 2055
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval88
		end

	yy_do_action_512 is
			--|#line 2059
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_lt_string_as) 
			yyval := yyval88
		end

	yy_do_action_513 is
			--|#line 2061
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_le_string_as) 
			yyval := yyval88
		end

	yy_do_action_514 is
			--|#line 2063
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_gt_string_as) 
			yyval := yyval88
		end

	yy_do_action_515 is
			--|#line 2065
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_ge_string_as) 
			yyval := yyval88
		end

	yy_do_action_516 is
			--|#line 2067
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_minus_string_as) 
			yyval := yyval88
		end

	yy_do_action_517 is
			--|#line 2069
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_plus_string_as) 
			yyval := yyval88
		end

	yy_do_action_518 is
			--|#line 2071
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_star_string_as) 
			yyval := yyval88
		end

	yy_do_action_519 is
			--|#line 2073
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_slash_string_as) 
			yyval := yyval88
		end

	yy_do_action_520 is
			--|#line 2075
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_mod_string_as) 
			yyval := yyval88
		end

	yy_do_action_521 is
			--|#line 2077
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_div_string_as) 
			yyval := yyval88
		end

	yy_do_action_522 is
			--|#line 2079
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_power_string_as) 
			yyval := yyval88
		end

	yy_do_action_523 is
			--|#line 2081
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_and_string_as) 
			yyval := yyval88
		end

	yy_do_action_524 is
			--|#line 2083
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval88
		end

	yy_do_action_525 is
			--|#line 2085
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_implies_string_as) 
			yyval := yyval88
		end

	yy_do_action_526 is
			--|#line 2087
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_or_string_as) 
			yyval := yyval88
		end

	yy_do_action_527 is
			--|#line 2089
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval88
		end

	yy_do_action_528 is
			--|#line 2091
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_xor_string_as) 
			yyval := yyval88
		end

	yy_do_action_529 is
			--|#line 2093
		local
			yyval88: PAIR [STRING_AS, CLICK_AST]
		do

yyval88 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval88
		end

	yy_do_action_530 is
			--|#line 2097
		local
			yyval4: ARRAY_AS
		do

yyval4 := new_array_as (yytype66 (yyvs.item (yyvsp - 1))) 
			yyval := yyval4
		end

	yy_do_action_531 is
			--|#line 2101
		local
			yyval57: TUPLE_AS
		do

yyval57 := new_tuple_as (yytype66 (yyvs.item (yyvsp - 1))) 
			yyval := yyval57
		end

	yy_do_action_533 is
			--|#line 2109
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
			  176,  173,  173,  222,  222,  222,  143,  143,  143,  143,
			  307,  307,  307,  307,  310,  310,  311,  311,  207,  207,
			  237,  237,  238,  238,  169,  169,  155,  312,  154,  154,
			  250,  250,  251,  251,  236,  236,  309,  309,  168,  302,
			  302,  299,  314,  314,  298,  298,  298,  296,  297,  147,
			  156,  156,  157,  157,  157,  266,  266,  266,  267,  267,

			  194,  194,  195,  195,  195,  195,  195,  195,  195,  268,
			  268,  269,  269,  200,  230,  230,  229,  229,  231,  231,
			  164,  170,  170,  239,  239,  241,  241,  240,  240,  243,
			  243,  242,  242,  245,  245,  244,  244,  277,  277,  278,
			  278,  279,  279,  219,  315,  315,  281,  281,  282,  282,
			  220,  252,  252,  253,  253,  215,  215,  205,  316,  204,
			  204,  204,  166,  167,  209,  209,  182,  182,  280,  280,
			  259,  259,  260,  260,  179,  313,  313,  180,  180,  180,
			  180,  180,  180,  180,  180,  180,  180,  201,  201,  318,
			  201,  319,  163,  163,  320,  163,  321,  272,  272,  273,

			  273,  211,  212,  212,  212,  214,  214,  218,  218,  218,
			  218,  218,  218,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,  275,  275,  275,  276,  276,
			  247,  247,  248,  248,  249,  249,  171,  322,  303,  303,
			  246,  246,  175,  227,  227,  228,  228,  162,  261,  261,
			  177,  223,  223,  224,  224,  151,  263,  263,  183,  183,
			  183,  183,  183,  183,  183,  183,  183,  183,  183,  183,
			  183,  183,  183,  183,  183,  183,  262,  262,  185,  274,
			  274,  184,  184,  323,  221,  221,  221,  161,  270,  270,
			  270,  271,  271,  202,  258,  258,  142,  142,  203,  203,

			  225,  225,  226,  226,  158,  158,  158,  158,  158,  158,
			  206,  206,  206,  206,  206,  206,  206,  206,  206,  206,
			  206,  206,  206,  206,  264,  264,  265,  265,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  159,  159,  159,  160,  160,  217,  217,
			  137,  137,  140,  140,  178,  178,  178,  178,  178,  178,
			  178,  178,  178,  153,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,

			  174,  150,  150,  150,  150,  150,  150,  150,  150,  150,
			  150,  150,  150,  190,  189,  188,  192,  187,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  196,  196,  191,  197,  198,  149,  149,  186,  186,  138,
			  139,  232,  232,  232,  233,  233,  234,  234,  235,  235,
			  172,  172,  172,  172,  172,  172,  172,  172,  172,  172,
			  172,  172,  144,  144,  144,  144,  144,  144,  145,  145,
			  145,  145,  145,  145,  148,  148,  152,  181,  181,  181,
			  199,  199,  199,  146,  208,  208,  208,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,

			  210,  210,  210,  210,  210,  210,  210,  210,  301,  301,
			  301,  301,  300,  300,  300,  300,  300,  300,  300,  300,
			  300,  300,  300,  300,  300,  300,  300,  300,  300,  300,
			  141,  213,  317,  304>>)
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
			    3,    2,    0,    1,    3,    1,    1,    1,    2,    3,
			    2,    2,    3,    3,    0,    1,    0,    1,    0,    2,
			    0,    1,    1,    2,    1,    2,    3,    0,    0,    1,
			    2,    3,    1,    3,    1,    2,    0,    1,    3,    1,
			    3,    2,    0,    1,    1,    1,    1,    2,    2,    3,
			    1,    2,    2,    2,    2,    0,    2,    2,    1,    2,

			    2,    3,    2,    8,    7,    6,    5,    4,    3,    1,
			    2,    1,    3,    3,    0,    1,    2,    2,    1,    2,
			    3,    1,    1,    1,    3,    0,    1,    1,    2,    0,
			    1,    1,    2,    0,    1,    1,    2,    0,    3,    0,
			    1,    1,    2,    5,    0,    3,    0,    1,    1,    2,
			    4,    1,    3,    0,    1,    0,    2,    8,    0,    1,
			    1,    1,    3,    2,    0,    2,    2,    2,    0,    2,
			    1,    2,    1,    2,    3,    0,    2,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    0,    3,    0,
			    4,    0,    0,    3,    0,    4,    0,    0,    1,    1,

			    2,    3,    1,    3,    2,    1,    1,    3,    3,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    0,    2,    3,    1,    3,
			    0,    4,    0,    1,    1,    3,    3,    0,    0,    3,
			    0,    3,    8,    0,    1,    1,    2,    5,    0,    2,
			    6,    0,    1,    1,    2,    5,    1,    3,    1,    3,
			    1,    3,    1,    3,    3,    3,    3,    3,    1,    3,
			    3,    3,    3,    3,    3,    3,    0,    2,   10,    0,
			    2,    0,    3,    0,    0,    4,    2,    5,    0,    2,
			    3,    1,    3,    1,    0,    2,    4,    4,    4,    4,

			    0,    1,    1,    2,    1,    3,    2,    1,    3,    2,
			    5,    5,    5,    7,    7,    5,    3,    4,    4,    4,
			    6,    5,    4,    3,    0,    3,    1,    3,    1,    1,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    3,    6,    4,    7,    6,    5,    0,    1,
			    1,    1,    0,    3,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    4,    1,    1,    1,    1,    1,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    4,    3,
			    4,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    2,    2,    2,    2,    2,    4,    2,    4,    2,    2,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    3,    3,    3,    5,    3,    2,    7,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    3,    7,    6,    1,    1,    3,    3,    2,
			    2,    0,    2,    3,    1,    3,    0,    1,    1,    3,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    2,    2,
			    1,    2,    2,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    3,    3,    0,    0>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   29,  461,  460,  459,  453,  458,  456,  455,  457,  454,
			  452,  451,   42,  450,    0,   54,    1,    0,    0,   38,
			   42,   28,   27,   26,   20,   25,   23,   22,   24,   21,
			   19,   18,    0,    0,    0,    0,   17,    2,  205,  206,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,   55,   56,    0,   56,   41,  507,  506,  505,
			  504,  503,  502,  501,  500,  499,  498,  497,  496,  495,
			  494,  493,  492,  491,  490,  489,  486,  488,  485,  475,
			  474,    0,   45,    0,  483,  487,  480,  476,  477,    0,
			    0,   43,   47,  466,  462,  463,    0,   46,  464,  465,

			  467,  484,   76,   39,  225,    5,    6,    8,    9,   12,
			   10,   11,   13,    7,   14,   15,   16,  212,  211,  225,
			    0,    0,  210,  209,    0,  213,  214,  215,  217,  220,
			  218,  219,  221,  216,  222,  223,  224,   57,   51,    0,
			   56,   56,   50,    0,    0,  482,  479,  481,  478,   48,
			  446,    0,    0,   77,   40,  208,  207,  226,  228,    0,
			  533,   53,   52,    0,  533,    0,  405,    0,  441,    0,
			  404,    0,    0,  446,    0,  471,  470,    0,    0,    0,
			    0,  400,    0,    0,  406,  365,  364,  472,  468,  367,
			  469,  412,  448,  441,    0,  409,  403,  402,  401,  411,

			  407,  408,  410,  368,  473,  366,    0,  447,   49,   44,
			  227,    0,  164,    0,  533,  352,    0,    0,    0,    0,
			    0,    0,    0,    0,  324,    0,    0,  418,    0,    0,
			    0,  399,    0,    0,  398,    0,   84,   85,   86,  396,
			    0,    0,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,    0,  324,    0,  393,  153,  392,  390,
			  391,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  439,  394,    0,    0,  531,    0,  229,    0,   58,
			  232,  352,    0,  347,  324,  324,  436,  414,  441,  435,

			    0,    0,    0,    0,    0,    0,    0,  316,    0,  442,
			  444,    0,    0,  324,  413,  511,  510,  509,  508,   88,
			  529,  528,  527,  526,  525,  524,  523,  522,  521,  520,
			  519,  518,  517,  516,  515,  514,  513,  512,   87,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  530,  323,  369,  151,  154,    0,  415,
			  376,  375,  374,  373,  372,  371,  370,  383,  385,  384,
			  386,  387,  388,    0,  377,  382,    0,  379,  381,  389,
			  324,  417,  432,  449,  165,    0,   95,  237,  234,    0,
			  233,  346,  441,  322,  317,    0,  440,  324,  324,  324,

			    0,    0,  328,    0,  329,  326,    0,  324,  441,  443,
			    0,    0,  318,  397,    0,  324,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,    0,    0,    0,
			  395,  378,  380,  319,   59,  533,  533,  238,  231,    0,
			  353,  437,  438,  315,  310,  311,    0,    0,  206,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  325,    0,  312,  420,  445,    0,    0,  321,  421,
			  422,  423,  424,  427,  425,  426,  428,  429,  430,  431,
			  324,  416,  152,   98,  533,    0,   97,  300,    0,  236,
			  235,  324,  324,  342,  213,  214,  215,  217,  220,  218,

			  219,  221,  216,  222,  223,  224,  327,  441,  441,  320,
			   99,  100,  225,  307,  304,  302,   60,  301,  240,  314,
			  313,  330,  331,  332,  334,  337,  335,  336,  338,  333,
			  339,  340,  341,  433,  419,  101,  102,    0,    0,  309,
			    0,  306,   67,   82,   62,  533,   61,  303,    0,  239,
			  127,  135,  109,  131,   76,  108,  125,  129,  133,    0,
			  114,   70,    0,   72,  308,  123,  305,   68,   83,   74,
			   82,   79,  137,    0,  281,   63,    0,  128,  136,  111,
			  110,    0,  132,  118,  116,    0,  117,  126,  129,  130,
			  133,  134,    0,  107,  115,  125,   71,    0,    0,   66,

			   69,   75,   82,  139,  175,  155,   81,  283,  533,  241,
			    0,    0,  119,  121,   76,  122,  133,    0,  106,  129,
			   73,  124,   80,  141,    0,    0,  140,   78,    0,   35,
			  532,   29,  112,  113,  120,    0,  105,  133,  144,  138,
			  142,  176,  156,   32,   42,   89,   90,  199,  282,  532,
			    0,    0,  104,    0,    0,    0,   35,   42,   35,   91,
			   58,   37,   42,  200,  202,  441,   76,    4,    3,  103,
			    0,   76,   93,   42,   92,   94,  158,   36,  204,  201,
			  145,  143,  187,  203,  189,  168,  191,  532,  146,    0,
			  532,  188,  148,    0,  169,  147,  175,  533,  175,  161,

			  160,  159,  192,  190,    0,  149,  167,  532,  164,    0,
			  166,  194,  294,   76,  172,  532,  533,  162,  163,  196,
			  532,  175,    0,  150,  173,  293,  533,  175,  179,  185,
			  177,  184,  181,  182,  178,  175,  183,  186,  180,    0,
			  532,  193,  295,  157,    0,  279,  174,    0,    0,  288,
			    0,  532,    0,    0,  348,    0,  354,  441,  360,  356,
			  355,  357,  362,  358,  359,  361,  195,  251,  532,  284,
			    0,    0,    0,    0,  175,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  351,    0,  352,
			  350,  349,    0,    0,    0,    0,  533,  253,  276,  252,

			  280,    0,    0,  297,  299,  175,  289,  291,    0,    0,
			  363,    0,  344,    0,    0,  296,  298,    0,  175,    0,
			  254,  286,  441,  533,  533,  290,    0,  287,    0,  352,
			    0,  260,  262,  258,  256,  268,    0,  277,  250,    0,
			    0,  245,  248,  533,    0,  292,  352,  343,    0,    0,
			    0,    0,    0,  175,    0,  285,    0,  175,    0,  246,
			    0,  345,    0,  261,  267,  275,  266,  263,  264,  270,
			  265,  259,  273,  274,  269,  272,  271,  255,  257,  175,
			  249,  242,    0,    0,    0,  175,    0,  278,  247,  434,
			    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  789,  184,  296,  293,  185,  728,   91,   92,  186,  187,
			  604,  188,  297,  189,  797,  190,  729,  538,  543,  645,
			  659,  515,  730,  191,  731,  841,  712,  583,  192,  700,
			  708,  569,  544,  614,  388,  193,   18,  194,  732,   19,
			  733,  734,  714,  735,   98,  701,  834,  608,  736,  299,
			  195,  196,  197,  198,  199,  200,  405,  483,  511,  201,
			  202,  835,   99,  579,  685,  737,  738,  702,  675,  203,
			  386,  204,  289,  101,  647,  666,  205,  241,  629,   38,
			  792,   39,  623,  692,  802,  102,  798,  799,  516,  517,
			  842,  843,  556,  595,  584,  281,  311,  206,  207,  570,

			  545,  546,  564,  587,  588,  589,  590,  591,  592,  549,
			  212,  389,  390,  585,  562,  624,  358,   15,   20,  660,
			  646,  722,  706,  715,  858,  819,  836,  307,  406,  436,
			  484,  560,  580,  774,  808,  648,  649,  769,  125,  159,
			  605,  625,  626,  689,  694,  695,  236,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,  237,
			  238,  565,  571,  338,  319,  572,  489,  485,  890,   16,
			   54,  668,  154,   55,  138,  567,  707,  573,  655,  682,
			  650,  687,  690,  720,  740,  437,  630>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 2685, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 2460, -32768, 2578,   87, -32768,  651, 1072, -32768,
			 2440, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 2711, 1112, 2711,  459, -32768, -32768, -32768, -32768,
			  514,  514,  514,  514,  514,  514,  514,  514,  514,  514,
			  514,  514, -32768,  614,  631,  101, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  641, -32768, 2578, -32768, -32768, -32768, -32768, -32768,  346,
			  326, -32768, -32768, -32768, -32768, -32768,  -20, -32768, -32768, -32768,

			 -32768, -32768,   59, -32768,  514, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  514,
			  657,  655, -32768, -32768, 2543, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2711,
			  614,  614, -32768, 2578,  645, -32768, -32768, -32768, -32768, -32768,
			 1887,  617, 1468, -32768, -32768, -32768, -32768, -32768, -32768,  183,
			  278, -32768, -32768,  630, -32768,  573,  172, 1445,   62,  629,
			  156, 2128, 2495, 1887, 2697, -32768, -32768, 1887, 1887,  648,
			 1887, -32768, 1887, 1887,  452, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 2956,   69, 1887, -32768, -32768, -32768, -32768, -32768,

			 -32768,  435,  431, -32768, -32768, -32768,  623,  628, -32768, -32768,
			 -32768, 2578,  479,  615, -32768,  199, 2697, 2697, 2697,  636,
			  634,  622, 2578, 1887,  464, 2711, 1764, -32768, 2711, 2697,
			 2697, -32768,  133, 2823, -32768, 1887, -32768, -32768, -32768, -32768,
			 2711,  568,  432,  428,  422,  420,  411,  394,  388,  376,
			  364,  358,  280,  596,  569, 2913, -32768, 2697, -32768, -32768,
			 -32768, 2697, 1887, 1887, 1887, 1887, 1887, 1887, 1887, 1887,
			 1887, 1887, 1887, 1887, 1887, 1641, 1887, 1280, 1887, 1887,
			 2697, -32768, -32768, 2697, 2697, -32768, 1887, -32768, 1131,  429,
			  574,  199, 2697, -32768,  569,  569,  581, -32768,  548, -32768,

			 2697, 2697, 2697,  591, 2895, 2010, 2697, -32768,  584, -32768,
			 2956,  232,  583,  569, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2853,
			  580, 2697,  582,  575,  571,  570,  564,  561,  560,  557,
			  556,  552,  547, -32768, -32768,   66, -32768,  579,  578, -32768,
			  462,  462,  462,  462,  462,  433,  433,  563,  563,  563,
			  563,  563,  563, 1887, 1950, 2987, 1887, 2972, 2876, -32768,
			  569, -32768, -32768, 2956, -32768,  945,  544, -32768, -32768,  565,
			  576, -32768,  548, -32768, -32768, 2697, -32768,  569,  569,  569,

			  588,  587,  573, 2495, 2956, -32768,  230,  569,  548, -32768,
			 1887,  585, -32768, -32768,  562,  569,  548,  548,  548,  548,
			  548,  548,  548,  548,  548,  548,  548, 2697, 2697, 2697,
			 -32768, 1950, 2972, -32768, -32768,  244, -32768,  558, -32768,  574,
			 -32768,  581, -32768, -32768, -32768, -32768, 2697, 2697,  555,  432,
			  428,  422,  420,  411,  394,  388,  376,  514,  364,  358,
			  280, -32768, 2010, -32768, -32768, 2956, 2697,  519, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  569, -32768, -32768, -32768,  288, 2711, -32768,  328, 2711, -32768,
			 -32768,  569,  569, -32768,  554,  553,  551,  550,  546,  545,

			  543,  542,  541,  540,  538,  528, -32768,  548,  548, -32768,
			 -32768,  523,  514, 2589, 2589, -32768,  487,  328,  517, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  279, 2064, 2629, 2642,
			 2629, 2642, -32768,  217, -32768, -32768,  487, -32768, 2629, -32768,
			 2629, 2629, 2629, 2629,  152, -32768,  453,  449,  425,  490,
			  486, -32768,  109, -32768,  498, -32768,  498,  503, -32768, -32768,
			  112, -32768,    4, 2629,  475, -32768,   45,  498,  498, -32768,
			  512,  492,  498, -32768,  503, 2276, -32768, -32768,  449, -32768,
			  425, -32768,  481, -32768, -32768,  453, -32768, 2711, 2629, -32768,

			 -32768, -32768,  473, 2697, -32768,  501, -32768, -32768, -32768, -32768,
			 2629, 2629, -32768, -32768,  463,  498,  425,  458, -32768,  449,
			 -32768, -32768, -32768, -32768,  284,  477, 2697,  457, 2578,  170,
			   99,  447, -32768, -32768, -32768,  455, -32768,  425,  469, -32768,
			 -32768, -32768, -32768, 2133, 2601, -32768, -32768, -32768, -32768,  637,
			 1887,  450, -32768,  445, 2697, 2578,  442, 2371,  442, -32768,
			  429, -32768, 2301, -32768, 2956,  300,  463, -32768, -32768, -32768,
			  465,  463, -32768, 2358, -32768, -32768, -32768, -32768, 1887, -32768,
			 -32768, -32768,  423, 2956,  446,  427, -32768,  -38, 2697,   28,
			  -38, -32768, -32768,  264, -32768, 2697, -32768, -32768, -32768, -32768,

			 -32768, -32768,  441, -32768, 2578, -32768, -32768, 1763,  479, 1131,
			 -32768,  409,  407,  463, -32768,  803,   16, -32768, -32768, -32768,
			  -43, -32768,  436, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2265,
			  -43, -32768, -32768, -32768, 1887,  418,  457,  132, 1887,  467,
			  461,  419,  275,  814, 2578, 1887,  452,   30, -32768, -32768,
			 -32768, -32768, -32768, -32768,  435,  431, -32768,   54,  -59,  343,
			 1887, 1887, 1633, 2154, -32768,  372,  386,  383,  378,  373,
			  370,  362,  356,  354,  350,  347,  344, -32768, 2578,  199,
			 -32768, -32768,  329, 2835, 1887, 1887, -32768, -32768,  282,  258,

			 -32768, 1887,  238, 2956, 2956, -32768, -32768, -32768,  161,  267,
			 -32768,  266, -32768,   19,  272, 2956, 2956,  860, -32768,  242,
			 -32768, 2956,  215, -32768,  286, -32768, 1131, -32768,   19,  199,
			  189,  291,  270,  263, -32768,  249,  -19, -32768, -32768, 1887,
			 1887, -32768,  165,  277,  149, -32768,  199, -32768, 2711, 2288,
			  860, 1417,  860, -32768,  860, 2956, 2756, -32768,  138, -32768,
			 1887, -32768,  153, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, 1272,  150,  113, -32768, 2697, -32768, -32768, -32768,
			  163,  122, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -786,   27,  369, -285, -32768, -32768,  609,  116, -32768,   -9,
			 -32768,  -10, -229, -32768,  -37,  -15, -32768, -488, -32768, -32768,
			 -32768,  243, -32768,    1, -32768,  -85, -32768,  173,  865, -32768,
			 -32768,  186,  209, -32768,  313,    0, -32768,  652, -32768,   -4,
			 -32768, -32768,   39, -32768,  -21, -32768, -104, -32768, -32768,  340,
			    9,    7,    5,    3,   -5,   -6,  268,  245, -32768,   -8,
			  -13, -387, -32768,  115, -32768, -32768, -32768, -32768, -32768, -32768,
			   64,  -14,   14, -278,   71, -32768,  621,   36, -32768, -226,
			 -32768,  311,   84,   13, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  147, -32768, -32768,  110, -32768,  532, -32768, -32768,

			 -32768, -32768, -435,  168,  114,  167, -541,  164, -444, -32768,
			 -32768, -32768, -32768, -475, -32768, -240, -32768,   63, -394, -32768,
			 -266, -32768, -507, -32768, -32768, -32768, -32768,  144, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -606, -32768, -32768, 1111, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,    2,  250,  191,  188,
			   88,   68,   37,   23,   15,  193,   11,   -3,   -7, -32768,
			 -32768, -166,   91, -32768, -32768, -32768, -32768, -111, -32768, -32768,
			 -32768, -32768, -378, -32768,  -40, -32768, -591, -32768, -32768, -32768,
			 -469, -32768, -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   14,  314,  312,   95,  100,  239,  391,   51,   94,   93,
			  384,   50,   17,  627,  123,  142,  103,  357,   97,   96,
			   17,  854, -197, -197, -197,   49,  540,  829,  150,   47,
			  603, -197,  359,  118,  104,  122,  119,   46,  539,  541,
			 -197, -197,  846, -197,  602,  149, -197,  616, -197,  213,
			   37,   45,   13,  215,  381,  382,  226,  486,  278,  277,
			  276,  275,  274,  273,  272,  271,  270,  269,  268,  267,
			  266,  265,  264,  263,  262,  181,   51,  853,  637,  599,
			   50,  691,   44,  795,  703,  598,  794,  727,  226,  699,
			  698,  428,  600,  726,   49,  226,  153,  697,   47,  152,

			  161,  162,   43,  291,  427,  566,   46,  280,  225,  725,
			  609,  787,  696,  576,  741,  577,  578,   51,  582,  144,
			   45,   50,  892,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,    2,    1,  766,   49,   51,   95,  100,   47,
			   50,  160,   94,   93,  746,  775,  617,   46,   53,  597,
			  615,   44,   97,   96,   49,  796,  596,  218,   47,   52,
			  158,   45,  800,  891, -197,  252,   46,  224,  141,  251,
			  137,   43,  635, -197,  254,  886,  586,  -65,  887,  163,
			   45,  230,  -65,  250,  568,  771,  -65,  249,  770,  153,
			  -65,  710,   44,  653,  229,  248,  140,  218,  537,  481,

			  883,  826,   42,  881,   51,   41,  825,   48,   50,  247,
			  217,   44,   43,  860,  742,   51,  294,  295,  298,   50,
			  745,   51,   49,  211,  292,   50,   47,  308,  857,  313,
			  298,   43,  210,   49,   46,  848,  634,   47,  716,   49,
			  246,  226,  340,   47,  644,   46,  716,  287,   45,  643,
			  662,   46,  852,  280,  839,  318,  317,  356,  303,   45,
			  245,  298,  518,  673,   40,   45,  851,  809,  316,  315,
			  462,   42,  410,  850,   41,  461,   48,  409,  227,   44,
			  380,  153,  -64,  298,  298,  -76,  -76,  -64,  679,  568,
			   44,  -64,  392,  681,  849,  -64,   44,  428,  824,   43,

			  397,  398,  399,  704,  429, -230,  407,  838,   36,  -76,
			   43,  837,   42,  828,  -76,   41,   43,   48,  -76, -230,
			 -230,  240,  -76,  638,  429,  487,  226,  352,  124,  -96,
			  -96,   42,  827,   40,   41,  723,   48,  823,  280,  678,
			 -244,  415, -244, -230,  555,  818,  877,  554, -230, -243,
			  880, -243, -230,  -96, -230,  148, -230,  147,  -96,  796,
			  244, -230,  -96,  243,  813,   48,  -96,  553,  552,  514,
			  513,  434,  884,  551,   40,  146,  550,  145,  888,   31,
			   30,   29,   28,   27,   26,   25,  581,   23,   22,   21,
			  672,  352,  674,   40,  351,  298,  460,  350,  354,   42,

			  459,  349,   41,  348,   48,  351,  124,  606,  396,  347,
			   42,  350,  124,   41,  458,   48,   42,  346,  456,   41,
			  345,   48,  242,  349,  124,  344,  455,  480,  298,  482,
			  343,  718,  621,  342,  574,  348,  124,  810,  393,  394,
			  454,  347,  124,  801,  581,  633,  491,  492,  693,  266,
			  265,  264,  263,  262,  181,  693,  284,  412,  346,  124,
			  283,   40,  865,  869,  872,  876,  507,  345,  124,  344,
			  124,  453,   40,  121,  120,  343,  124,  261,   40,  342,
			  124,   51,  262,  181, -197,   50,  230,  512,   88,  306,
			  305,  452,   13,  773,  641,  807,  768,  631,  721,   49,

			  153,  743,  440,   47,  812,  719,  288,  711,  688,  686,
			  669,   46,  385,  684,  680,  667,  644,  654,  464,  551,
			  652,   12,  639,  636,  433,   45,  469,  470,  471,  472,
			  473,  474,  475,  476,  477,  478,  479,  553,  598,  563,
			  628,  443,  444,  445,  847,  568,  618,  611,  845,  537,
			  550,  463,  610,  607,  554,  593,   44,  542,  548,  468,
			  535,  861,  124,   11,   10,    9,    8,    7,    6,    5,
			    4,    3,    2,    1,  226,  532,   43,  268,  267,  266,
			  265,  264,  263,  262,  181,  531,  709,  530,  529,  528,
			  527,  451,  526,  525,  450,  305,  457,  524,  523,  620,

			  522,  521,  493,  356,  508,  739,  395,  387,  488,  467,
			  466,  216,  447,  446,  438,  744,  439,  533,  534,  429,
			  435,   51,  862,  430,  509,   50,  356,  414,   95,  100,
			  411,  408,  426,   94,   93,  519,  520,  425,  400,   49,
			  353,  424,  423,   47,   17,  422,  421,  302,   51,  420,
			  665,   46,   50,  449,  670,  419,  418,   17,  103,  301,
			  417,  300,   17,  290,  642,   45,   49,  416,  286,  103,
			   47,  341,  285,   17,  257,  228,   42,  214,   46,   41,
			  164,   48,  208,  137,  148,  817,  146,  143,  356,  139,
			   56,  671,   45,  622,  651,  356,   44,   51, -198, -198,

			  559,   50, -198,  558,  557,  253, -198,  594,  705,  619,
			  640, -198,  840,  844,  448,   49,   43,  151, -198,   47,
			  663, -198,  717,   44,  676,  632,  765,   46, -198,  510,
			  506,  764,  844,  763,  762,  442, -198, -198,   40,  757,
			  713,   45,  761,   43,  760,  786,  759,   51,  758,  785,
			  878,   50,  490,  790,  724,  575,  601,  612,  859,  658,
			  547,  209,  820,  784,  441,   49,  756,  783,    0,   47,
			    0,    0,   44,    0,    0,  782,    0,   46,    0,    0,
			    0,   51,    0,    0,    0,   50,    0,    0,    0,  781,
			  791,   45,   43,    0,    0,    0,  833,    0,    0,   49,

			    0,  822,  831,   47,    0,    0,    0,    0,    0,    0,
			    0,   46,    0,  790,    0,    0,   42,  832,    0,   41,
			  780,   48,   44,    0,  811,   45,    0,    0,  790,  868,
			  871,  875,    0,  833,  863,  866,    0,  873,    0,  831,
			  779,   51,   43,   42,  279,   50,   41,   13,   48,  864,
			  867,  870,  874,    0,  832,    0,   44,    0,    0,   49,
			  788,    0,    0,   47,    0,    0, -171, -171, -171, -171,
			    0,   46,    0,    0,  121,  120,   43,    0,   40,    0,
			    0, -171,    0,    0,    0,   45,  889,    0,    0,   88,
			   87,    0,   42,   13, -171,   41,    0,   48,    0,    0,

			    0,    0, -171, -171, -171,   40,  787,  279,  279,    0,
			  279,  279,  279,    0,    0,    0,   44,    0,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,    2,    1,    0,
			  830,    0,    0,    0,  279,    0,   43,    0,    0,    0,
			  778,    0,   42,  777,    0,   41,    0,   48,    0,    0,
			    0,    0,    0,    0,   40,    0,  279,    0,    0,    0,
			    0,    0,  279,    0,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,    2,    1,    0,   42,   85,    0,   41,
			    0,   48,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  279,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,  776,    0,   40,    0,    0,    0,    0,    0,
			    0,    0,  279,  279,  279,  279,  279,  279,  279,  279,
			  279,  279,  279,  279,  279,    0,  279,  279,    0,  279,
			  279,  279,    0,    0,    0,  279,   42,    0,   40,   41,
			    0,   48,  255,  256,    0,  258,    0,  259,  260,    0,
			    0,    0,    0,    0,    0,    0,  279,    0,    0,  282,
			   78,   77,   76,   75,   74,   73,   72,   71,   70,   69,
			   68,   67,   66,   65,   64,   63,   62,   61,   60,   59,
			   58,   57,    0,  279,  279,    0,   90,   89,  304,    0,
			    0,  310,    0,    0,    0,    0,    0,    0,   40,    0,

			  339,   88,   87,   86,   85,   13,   84,   83,    0,   82,
			    0,    0,    0,   81,    0,    0,    0,  279,    0,    0,
			    0,    0,    0,   80,   79,    0,    0,  360,  361,  362,
			  363,  364,  365,  366,  367,  368,  369,  370,  371,  372,
			  374,  375,  377,  378,  379,   13,    0,    0,    0,    0,
			    0,  383,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,   85,    0,    0,    0,    0,    0,    0,
			  404,  117,    0,    0,    0,    0,   11,   10,    9,    8,
			    7,    6,    5,    4,    3,    2,    1,   78,   77,   76,
			   75,   74,   73,   72,   71,   70,   69,   68,   67,   66,

			   65,   64,   63,   62,   61,   60,   59,   58,   57,    0,
			    0,    0,    0,    0,    0,  155,   11,   10,    9,    8,
			    7,    6,    5,    4,    3,    2,    1,    0,    0,    0,
			  156,    0,    0,    0,    0,    0,    0,    0,  431,    0,
			    0,  432,    0,    0,    0,    0,    0,   77,    0,   75,
			   74,   73,   72,   71,   70,   69,   68,   67,   66,   65,
			   64,   63,   62,   61,   60,   59,   58,   57,    0,    0,
			    0,    0,    0,    0,    0,  465,  278,  277,  276,  275,
			  274,  273,  272,  271,  270,  269,  268,  267,  266,  265,
			  264,  263,  262,  181,  183,  182,    0,    0,    0,    0,

			    0,  181,  180,  179,  178,    0,  177,    0,    0,  176,
			   87,  175,   85,   13,   84,   83,  279,    0,  174,    0,
			    0,   81,    0,  173,    0,    0,  172,  404,  150,    0,
			    0,   80,   79,    0,  171,  279,    0,    0,    0,  170,
			    0,    0,    0,  376,    0,    0,    0,    0,    0,    0,
			  169,    0,    0,    0,  126,  127,  128,  129,  130,  131,
			  132,  134,  135,  136,    0,  168,  167,    0,  885,    0,
			    0,    0,  166,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  165,    0,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,    2,    1,   78,   77,   76,   75,   74,

			   73,   72,   71,   70,   69,   68,   67,   66,   65,   64,
			   63,   62,   61,   60,   59,   58,   57,    0,    0,  279,
			    0,    0,    0,    0,  279,    0,    0,    0,    0,    0,
			    0,  121,  120,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  279,   88,    0,    0,    0,
			   13,    0,    0,    0,    0,  279,  279,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  279,  279,    0,
			    0,  223,    0,  279,    0,    0,    0,    0,   13,    0,
			    0,    0,   90,   89,    0,    0,    0,  830,    0,    0,
			    0,  222,    0,    0,    0,    0,    0,   88,   87,   86,

			   85,   13,   84,   83,  221,    0,    0,  279,  279,   81,
			    0,    0,    0,    0,    0,  664,    0,    0,    0,   80,
			   79,   11,   10,    9,    8,    7,    6,    5,    4,    3,
			    2,    1,    0,    0,  279,    0,    0,  220,    0,    0,
			    0,    0,    0,  683,    0,    0,    0,  219,    0,   11,
			   10,    9,    8,    7,    6,    5,    4,    3,    2,    1,
			  494,  495,  496,  497,  498,  499,  500,  501,  502,  503,
			  504,  505,   11,   10,    9,    8,    7,    6,    5,    4,
			    3,    2,    1,   78,   77,   76,   75,   74,   73,   72,
			   71,   70,   69,   68,   67,   66,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,    0,    0,    0,    0,  767,
			    0,    0,    0,  772,    0,    0,    0,    0,    0,    0,
			  793,    0,    0,  536,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  803,  804,  278,  277,  276,
			  275,  274,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,  264,  263,  262,  181,  183,  182,    0,    0,  815,
			  816,    0,  181,  180,  179,  178,  821,  177,    0,    0,
			  176,   87,  175,   85,   13,   84,   83,    0,    0,  174,
			    0,    0,   81,    0,  173,    0,    0,  172,    0,  150,
			    0,    0,   80,   79,    0,  171,    0,    0,    0,    0,

			  170,    0,    0,    0,  855,  856,    0,    0,    0,    0,
			    0,  169,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  882,  168,  167,    0,  805,
			    0,    0,    0,  166,    0,    0,    0,  373,    0,    0,
			    0,    0,    0,  165,    0,   11,   10,    9,    8,    7,
			    6,    5,    4,    3,    2,    1,   78,   77,   76,   75,
			   74,   73,   72,   71,   70,   69,   68,   67,   66,   65,
			   64,   63,   62,   61,   60,   59,   58,   57,  183,  182,
			    0,    0,    0,    0,    0,  181,  180,  179,  178,    0,
			  177,    0,    0,  176,   87,  175,   85,   13,   84,   83,

			  641,    0,  174,    0,    0,   81,    0,  173,    0,  309,
			  172,    0,  150,    0,    0,   80,   79,    0,  171,    0,
			    0,    0,    0,  170,    0,    0, -170, -170, -170, -170,
			    0,    0,    0,    0,  169,    0,    0,    0,    0,    0,
			    0, -170,    0,    0,    0,    0,    0,    0,    0,  168,
			  167,    0,    0,    0, -170,    0,  166,    0,    0,    0,
			    0,    0, -170, -170, -170,    0,  165,    0,   11,   10,
			    9,    8,    7,    6,    5,    4,    3,    2,    1,   78,
			   77,   76,   75,   74,   73,   72,   71,   70,   69,   68,
			   67,   66,   65,   64,   63,   62,   61,   60,   59,   58,

			   57,  183,  182,    0,    0,    0,    0,    0,  181,  180,
			  179,  178,    0,  177,    0,    0,  176,   87,  175,   85,
			   13,   84,   83,    0,    0,  174,    0,    0,   81,    0,
			  173,    0,    0,  172,    0,  150,    0,    0,   80,   79,
			    0,  171,    0,    0,    0,    0,  170,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  169,  274,  273,
			  272,  271,  270,  269,  268,  267,  266,  265,  264,  263,
			  262,  181,  168,  167,    0,    0,    0,    0,    0,  166,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  165,
			    0,   11,   10,    9,    8,    7,    6,    5,    4,    3,

			    2,    1,   78,   77,   76,   75,   74,   73,   72,   71,
			   70,   69,   68,   67,   66,   65,   64,   63,   62,   61,
			   60,   59,   58,   57,  183,  182,    0,    0,    0,    0,
			    0,  181,  180,  179,  178,    0,  177,    0,    0,  176,
			   87,  175,   85,   13,   84,   83,    0,    0,  174,    0,
			    0,   81,    0,  173,    0,    0,  403,    0,  150,    0,
			    0,   80,   79,    0,  171,    0,    0,    0,    0,  170,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  169,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  168,  167,   36,    0,    0,

			    0,    0,  166,    0,    0,    0,    0,    0,    0,    0,
			    0,  561,  402,    0,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,    2,    1,   78,   77,   76,   75,   74,
			   73,   72,   71,   70,   69,   68,   67,   66,   65,   64,
			   63,   62,   61,   60,   59,   58,   57,   90,   89,    0,
			    0,    0,    0,    0,  235,    0,    0,    0,    0,    0,
			    0,   36,   88,   87,   86,   85,    0,   84,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   22,   21,    0,
			    0,    0,    0,    0,   80,   79,   85,  234,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  806,

			    0,    0,    0,  233,    0,    0,    0,  657,    0,    0,
			    0,    0,    0,    0,    0,  232,    0,    0,    0,    0,
			  231,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  656,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,    0,    0,    0,    0,    0,   78,   77,
			   76,   75,   74,   73,   72,   71,   70,   69,   68,   67,
			   66,   65,   64,   63,   62,   61,   60,   59,   58,   57,
			   77,    0,   75,   74,   73,   72,   71,   70,   69,   68,
			   67,   66,   65,   64,   63,   62,   61,   60,   59,   58,
			   57,  755,    0,    0,    0,    0,    0,    0,   13,    0,

			  754,    0,    0,    0,  613,    0,  753,    0,    0,   36,
			    0,  752,    0,    0,    0,    0,    0,    0,   87,    0,
			    0,   13,  751,    0,  750,  749,    0,    0,    0,    0,
			    0,    0,    0,    0,   13,  169,    0,    0,  748,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  168,  233,    0,    0,    0,    0,    0,  747,  830,    0,
			    0,    0,    0,  232,    0,    0,  677,    0,    0,   11,
			   10,    9,    8,    7,    6,    5,    4,    3,    2,    1,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   22,
			   21,   13,   11,   10,    9,    8,    7,    6,    5,    4,

			    3,    2,    1,    0,   13,   11,   10,    9,    8,    7,
			    6,    5,    4,    3,    2,    1,    0,    0,    0,  -33,
			  -33,    0,    0,    0,    0,    0,    0,  -33,    0,    0,
			    0,    0,  -34,  -34,    0,    0,    0,    0,    0,  -33,
			  -34,  -33,  -33,    0,    0,    0,    0,    0,  -33,    0,
			    0,    0,  -34,    0,  -34,  -34,    0,    0,    0,    0,
			    0,  -34,   11,   10,    9,    8,    7,    6,    5,    4,
			    3,    2,    1,   13,    0,   11,   10,    9,    8,    7,
			    6,    5,    4,    3,    2,    1,    0,    0,    0,    0,
			    0,    0,    0,   13,    0,    0,    0,    0,  -30,    0,

			    0,  -30,    0,    0,    0,  -30,    0,  -30,    0,  -30,
			    0,    0,  -30,    0,    0,    0,    0,    0,  -31,    0,
			    0,  -31,    0,    0,    0,  -31,    0,  -31,   36,  -31,
			    0,   35,  -31,    0,    0,  -30,    0,    0,    0,    0,
			    0,  240,    0,    0,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,    2,    1,  -31,    0,    0,    0,    0,
			    0,    0,   34,    0,   11,   10,    9,    8,    7,    6,
			    5,    4,    3,    2,    1,   33,   36,    0,    0,   35,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			   32,    0,  157,    0,    0,    0,    0,    0,    0,   31,

			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,
			   34,   36,    0,    0,   35,    0,    0,    0,    0,    0,
			    0,    0,  -68,   33,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   13,  537,    0,    0,   32,    0,
			    0,    0,    0,    0,    0,   34,    0,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,   22,   21,   33,    0,
			    0,    0,   36,    0,  -68,    0,  661,    0,    0,    0,
			    0,    0,    0,   32,    0,  -69,  -68,    0,    0,    0,
			    0,    0,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,  -68,  -68,  -68,  -68,  -68,  -68,  -68,

			  -68,  -68,  -68,  -68,  233,   11,   10,    9,    8,    7,
			    6,    5,    4,    3,    2,    1,  232,  -69,   13,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  -69,
			   13,    0,    0,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   22,   21,   36,    0,  -69,  -69,  -69,  -69,
			  -69,  -69,  -69,  -69,  -69,  -69,  -69,    0,    0,   12,
			  278,  277,  276,  275,  274,  273,  272,  271,  270,  269,
			  268,  267,  266,  265,  264,  263,  262,  181,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   11,
			   10,    9,    8,    7,    6,    5,    4,    3,    2,    1,

			    0,   11,   10,    9,    8,    7,    6,    5,    4,    3,
			    2,    1,    0,    0,    0,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   22,   21,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  879,  278,
			  277,  276,  275,  274,  273,  272,  271,  270,  269,  268,
			  267,  266,  265,  264,  263,  262,  181,  278,  277,  276,
			  275,  274,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,  264,  263,  262,  181,    0,    0,    0,    0,    0,
			  814,  277,  276,  275,  274,  273,  272,  271,  270,  269,
			  268,  267,  266,  265,  264,  263,  262,  181,  413,  278,

			  277,  276,  275,  274,  273,  272,  271,  270,  269,  268,
			  267,  266,  265,  264,  263,  262,  181,  278,  277,  276,
			  275,  274,  273,  272,  271,  270,  269,  268,  267,  266,
			  265,  264,  263,  262,  181,    0,    0,    0,    0,    0,
			  401,  337,  336,  335,  334,  333,  332,  331,  330,  329,
			  328,  327,  326,  325,  324,  323,  322,  321,  355,  320,
			  278,  277,  276,  275,  274,  273,  272,  271,  270,  269,
			  268,  267,  266,  265,  264,  263,  262,  181,  276,  275,
			  274,  273,  272,  271,  270,  269,  268,  267,  266,  265,
			  264,  263,  262,  181,  275,  274,  273,  272,  271,  270,

			  269,  268,  267,  266,  265,  264,  263,  262,  181>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  230,  228,   18,   18,  171,  291,   14,   18,   18,
			  288,   14,   12,  604,   35,   55,   20,  257,   18,   18,
			   20,   40,   65,   61,   62,   14,  514,  813,   48,   14,
			   26,   69,  261,   33,   32,   35,   34,   14,  513,  514,
			   99,  100,  828,   81,   40,   65,   84,  588,   91,  160,
			   14,   14,   33,  164,  283,  284,   26,  435,    4,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   83,   96,  619,  567,
			   83,  687,   14,   53,  690,   40,   56,   71,   26,   61,
			   62,   25,  567,   77,   83,   26,   37,   69,   83,   40,

			  140,  141,   14,  214,   38,  540,   83,   38,   46,   93,
			   65,   92,   84,  548,  720,  550,  551,  124,  553,   83,
			   83,  124,    0,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  740,  124,  143,  152,  152,  124,
			  143,  139,  152,  152,  735,  751,  590,  124,   61,   40,
			  585,   83,  152,  152,  143,  101,   47,   25,  143,   72,
			  124,  124,  768,    0,   65,  172,  143,  167,   67,  172,
			   69,   83,  616,   74,  174,   25,  554,   65,   65,  143,
			  143,   25,   70,  172,   72,   53,   74,  172,   56,   37,
			   78,  698,  124,  637,   38,  172,   95,   25,   46,  428,

			   47,   40,   14,   65,  211,   14,   45,   14,  211,  172,
			   38,  143,  124,   64,  721,  222,  216,  217,  218,  222,
			  727,  228,  211,   40,   25,  228,  211,  225,   63,  229,
			  230,  143,   49,  222,  211,   46,  614,  222,  707,  228,
			  172,   26,  240,  228,   74,  222,  715,  211,  211,   79,
			  644,  228,    3,   38,   39,  122,  123,  257,  222,  222,
			  172,  261,  488,  657,   14,  228,    3,  774,  135,  136,
			   40,   83,   40,    3,   83,   45,   83,   45,  168,  211,
			  280,   37,   65,  283,  284,   41,   42,   70,  666,   72,
			  222,   74,  292,  671,    3,   78,  228,   25,  805,  211,

			  300,  301,  302,   39,   40,   27,  306,   65,   33,   65,
			  222,  818,  124,   47,   70,  124,  228,  124,   74,   41,
			   42,   46,   78,   39,   40,  436,   26,   47,   48,   41,
			   42,  143,   65,   83,  143,  713,  143,   99,   38,   39,
			   63,  341,   65,   65,   65,   63,  853,   68,   70,   63,
			  857,   65,   74,   65,   76,   29,   78,   31,   70,  101,
			  172,   83,   74,  172,   35,  172,   78,   88,   89,   41,
			   42,  385,  879,   94,  124,   29,   97,   31,  885,  104,
			  105,  106,  107,  108,  109,  110,  552,  112,  113,  114,
			  656,   47,  658,  143,   47,  395,  403,   47,  254,  211,

			  403,   47,  211,   47,  211,   47,   48,  573,  298,   47,
			  222,   47,   48,  222,  403,  222,  228,   47,  403,  228,
			   47,  228,  172,   47,   48,   47,  403,  427,  428,  429,
			   47,  709,  598,   47,  545,   47,   48,   65,  294,  295,
			  403,   47,   48,  100,  610,  611,  446,  447,  688,   16,
			   17,   18,   19,   20,   21,  695,   25,  313,   47,   48,
			   25,  211,  849,  850,  851,  852,  466,   47,   48,   47,
			   48,  403,  222,   14,   15,   47,   48,   25,  228,   47,
			   48,  488,   20,   21,   65,  488,   25,  485,   29,   25,
			   26,  403,   33,   26,   37,  773,   78,  608,   91,  488,

			   37,   65,  392,  488,  789,   96,   27,   66,   81,   63,
			   65,  488,   83,   90,   49,   65,   74,   48,  408,   94,
			   65,   74,   45,   65,  380,  488,  416,  417,  418,  419,
			  420,  421,  422,  423,  424,  425,  426,   88,   40,  537,
			   39,  397,  398,  399,  829,   72,   65,   55,  826,   46,
			   97,  407,   40,   78,   68,   65,  488,   70,   41,  415,
			   37,  846,   48,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,   26,   47,  488,   14,   15,   16,
			   17,   18,   19,   20,   21,   47,  697,   47,   47,   47,
			   47,  403,   47,   47,  403,   26,  403,   47,   47,  597,

			   47,   47,   47,  603,   85,  716,   25,   33,   50,   47,
			   25,   38,   25,   25,   49,  726,   40,  507,  508,   40,
			   76,  628,  848,   45,  480,  628,  626,   47,  643,  643,
			   47,   47,   85,  643,  643,  491,  492,   85,   47,  628,
			   44,   85,   85,  628,  644,   85,   85,   25,  655,   85,
			  650,  628,  655,  403,  654,   85,   85,  657,  662,   25,
			   85,   25,  662,   48,  628,  628,  655,   85,   40,  673,
			  655,  103,   49,  673,   26,   46,  488,   47,  655,  488,
			   35,  488,   65,   69,   29,  796,   29,   46,  688,   58,
			   39,  655,  655,  602,  631,  695,  628,  704,   61,   62,

			  536,  704,   65,  536,  536,  173,   69,  560,  695,  595,
			  626,   74,  823,  824,  403,  704,  628,   96,   81,  704,
			  649,   84,  708,  655,  660,  610,  739,  704,   91,  484,
			  462,  739,  843,  739,  739,  395,   99,  100,  488,  739,
			  704,  704,  739,  655,  739,  752,  739,  754,  739,  752,
			  854,  754,  439,  753,  715,  546,  570,  584,  843,  643,
			  517,  152,  799,  752,  395,  754,  739,  752,   -1,  754,
			   -1,   -1,  704,   -1,   -1,  752,   -1,  754,   -1,   -1,
			   -1,  788,   -1,   -1,   -1,  788,   -1,   -1,   -1,  752,
			  754,  754,  704,   -1,   -1,   -1,  817,   -1,   -1,  788,

			   -1,  801,  817,  788,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  788,   -1,  813,   -1,   -1,  628,  817,   -1,  628,
			  752,  628,  754,   -1,  788,  788,   -1,   -1,  828,  850,
			  851,  852,   -1,  854,  849,  850,   -1,  852,   -1,  854,
			  752,  848,  754,  655,  192,  848,  655,   33,  655,  849,
			  850,  851,  852,   -1,  854,   -1,  788,   -1,   -1,  848,
			   46,   -1,   -1,  848,   -1,   -1,   63,   64,   65,   66,
			   -1,  848,   -1,   -1,   14,   15,  788,   -1,  628,   -1,
			   -1,   78,   -1,   -1,   -1,  848,  886,   -1,   -1,   29,
			   30,   -1,  704,   33,   91,  704,   -1,  704,   -1,   -1,

			   -1,   -1,   99,  100,  101,  655,   92,  255,  256,   -1,
			  258,  259,  260,   -1,   -1,   -1,  848,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   -1,
			   70,   -1,   -1,   -1,  282,   -1,  848,   -1,   -1,   -1,
			  752,   -1,  754,  752,   -1,  754,   -1,  754,   -1,   -1,
			   -1,   -1,   -1,   -1,  704,   -1,  304,   -1,   -1,   -1,
			   -1,   -1,  310,   -1,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,   -1,  788,   32,   -1,  788,
			   -1,  788,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  339,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,  752,   -1,  754,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  360,  361,  362,  363,  364,  365,  366,  367,
			  368,  369,  370,  371,  372,   -1,  374,  375,   -1,  377,
			  378,  379,   -1,   -1,   -1,  383,  848,   -1,  788,  848,
			   -1,  848,  177,  178,   -1,  180,   -1,  182,  183,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  404,   -1,   -1,  194,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,   -1,  431,  432,   -1,   14,   15,  223,   -1,
			   -1,  226,   -1,   -1,   -1,   -1,   -1,   -1,  848,   -1,

			  235,   29,   30,   31,   32,   33,   34,   35,   -1,   37,
			   -1,   -1,   -1,   41,   -1,   -1,   -1,  465,   -1,   -1,
			   -1,   -1,   -1,   51,   52,   -1,   -1,  262,  263,  264,
			  265,  266,  267,  268,  269,  270,  271,  272,  273,  274,
			  275,  276,  277,  278,  279,   33,   -1,   -1,   -1,   -1,
			   -1,  286,   41,   42,   43,   44,   45,   46,   47,   48,
			   49,   50,   51,   32,   -1,   -1,   -1,   -1,   -1,   -1,
			  305,   59,   -1,   -1,   -1,   -1,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,

			  128,  129,  130,  131,  132,  133,  134,  135,  136,   -1,
			   -1,   -1,   -1,   -1,   -1,  104,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   -1,   -1,   -1,
			  119,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  373,   -1,
			   -1,  376,   -1,   -1,   -1,   -1,   -1,  116,   -1,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  410,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   14,   15,   -1,   -1,   -1,   -1,

			   -1,   21,   22,   23,   24,   -1,   26,   -1,   -1,   29,
			   30,   31,   32,   33,   34,   35,  664,   -1,   38,   -1,
			   -1,   41,   -1,   43,   -1,   -1,   46,  462,   48,   -1,
			   -1,   51,   52,   -1,   54,  683,   -1,   -1,   -1,   59,
			   -1,   -1,   -1,   63,   -1,   -1,   -1,   -1,   -1,   -1,
			   70,   -1,   -1,   -1,  243,  244,  245,  246,  247,  248,
			  249,  250,  251,  252,   -1,   85,   86,   -1,   96,   -1,
			   -1,   -1,   92,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  102,   -1,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,

			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,  132,  133,  134,  135,  136,   -1,   -1,  767,
			   -1,   -1,   -1,   -1,  772,   -1,   -1,   -1,   -1,   -1,
			   -1,   14,   15,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  793,   29,   -1,   -1,   -1,
			   33,   -1,   -1,   -1,   -1,  803,  804,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  815,  816,   -1,
			   -1,   26,   -1,  821,   -1,   -1,   -1,   -1,   33,   -1,
			   -1,   -1,   14,   15,   -1,   -1,   -1,   70,   -1,   -1,
			   -1,   46,   -1,   -1,   -1,   -1,   -1,   29,   30,   31,

			   32,   33,   34,   35,   59,   -1,   -1,  855,  856,   41,
			   -1,   -1,   -1,   -1,   -1,  650,   -1,   -1,   -1,   51,
			   52,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   -1,   -1,  882,   -1,   -1,   92,   -1,   -1,
			   -1,   -1,   -1,  678,   -1,   -1,   -1,  102,   -1,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  449,  450,  451,  452,  453,  454,  455,  456,  457,  458,
			  459,  460,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,

			  132,  133,  134,  135,  136,   -1,   -1,   -1,   -1,  744,
			   -1,   -1,   -1,  748,   -1,   -1,   -1,   -1,   -1,   -1,
			  755,   -1,   -1,  512,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  770,  771,    4,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   14,   15,   -1,   -1,  794,
			  795,   -1,   21,   22,   23,   24,  801,   26,   -1,   -1,
			   29,   30,   31,   32,   33,   34,   35,   -1,   -1,   38,
			   -1,   -1,   41,   -1,   43,   -1,   -1,   46,   -1,   48,
			   -1,   -1,   51,   52,   -1,   54,   -1,   -1,   -1,   -1,

			   59,   -1,   -1,   -1,  839,  840,   -1,   -1,   -1,   -1,
			   -1,   70,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  860,   85,   86,   -1,   96,
			   -1,   -1,   -1,   92,   -1,   -1,   -1,   96,   -1,   -1,
			   -1,   -1,   -1,  102,   -1,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,   14,   15,
			   -1,   -1,   -1,   -1,   -1,   21,   22,   23,   24,   -1,
			   26,   -1,   -1,   29,   30,   31,   32,   33,   34,   35,

			   37,   -1,   38,   -1,   -1,   41,   -1,   43,   -1,   45,
			   46,   -1,   48,   -1,   -1,   51,   52,   -1,   54,   -1,
			   -1,   -1,   -1,   59,   -1,   -1,   63,   64,   65,   66,
			   -1,   -1,   -1,   -1,   70,   -1,   -1,   -1,   -1,   -1,
			   -1,   78,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   85,
			   86,   -1,   -1,   -1,   91,   -1,   92,   -1,   -1,   -1,
			   -1,   -1,   99,  100,  101,   -1,  102,   -1,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,

			  136,   14,   15,   -1,   -1,   -1,   -1,   -1,   21,   22,
			   23,   24,   -1,   26,   -1,   -1,   29,   30,   31,   32,
			   33,   34,   35,   -1,   -1,   38,   -1,   -1,   41,   -1,
			   43,   -1,   -1,   46,   -1,   48,   -1,   -1,   51,   52,
			   -1,   54,   -1,   -1,   -1,   -1,   59,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   70,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   85,   86,   -1,   -1,   -1,   -1,   -1,   92,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  102,
			   -1,  104,  105,  106,  107,  108,  109,  110,  111,  112,

			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,   14,   15,   -1,   -1,   -1,   -1,
			   -1,   21,   22,   23,   24,   -1,   26,   -1,   -1,   29,
			   30,   31,   32,   33,   34,   35,   -1,   -1,   38,   -1,
			   -1,   41,   -1,   43,   -1,   -1,   46,   -1,   48,   -1,
			   -1,   51,   52,   -1,   54,   -1,   -1,   -1,   -1,   59,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   70,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   85,   86,   33,   -1,   -1,

			   -1,   -1,   92,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   47,  102,   -1,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,  132,  133,  134,  135,  136,   14,   15,   -1,
			   -1,   -1,   -1,   -1,   26,   -1,   -1,   -1,   -1,   -1,
			   -1,   33,   29,   30,   31,   32,   -1,   34,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,   -1,
			   -1,   -1,   -1,   -1,   51,   52,   32,   59,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   45,

			   -1,   -1,   -1,   75,   -1,   -1,   -1,   74,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   87,   -1,   -1,   -1,   -1,
			   92,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   98,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			  116,   -1,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,   26,   -1,   -1,   -1,   -1,   -1,   -1,   33,   -1,

			   35,   -1,   -1,   -1,   28,   -1,   41,   -1,   -1,   33,
			   -1,   46,   -1,   -1,   -1,   -1,   -1,   -1,   30,   -1,
			   -1,   33,   57,   -1,   59,   60,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   33,   70,   -1,   -1,   73,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   85,   75,   -1,   -1,   -1,   -1,   -1,   92,   70,   -1,
			   -1,   -1,   -1,   87,   -1,   -1,   65,   -1,   -1,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,   33,  104,  105,  106,  107,  108,  109,  110,  111,

			  112,  113,  114,   -1,   33,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,   -1,   -1,   -1,   61,
			   62,   -1,   -1,   -1,   -1,   -1,   -1,   69,   -1,   -1,
			   -1,   -1,   61,   62,   -1,   -1,   -1,   -1,   -1,   81,
			   69,   83,   84,   -1,   -1,   -1,   -1,   -1,   90,   -1,
			   -1,   -1,   81,   -1,   83,   84,   -1,   -1,   -1,   -1,
			   -1,   90,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   33,   -1,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   33,   -1,   -1,   -1,   -1,   58,   -1,

			   -1,   61,   -1,   -1,   -1,   65,   -1,   67,   -1,   69,
			   -1,   -1,   72,   -1,   -1,   -1,   -1,   -1,   58,   -1,
			   -1,   61,   -1,   -1,   -1,   65,   -1,   67,   33,   69,
			   -1,   36,   72,   -1,   -1,   95,   -1,   -1,   -1,   -1,
			   -1,   46,   -1,   -1,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,   95,   -1,   -1,   -1,   -1,
			   -1,   -1,   67,   -1,  104,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,   80,   33,   -1,   -1,   36,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   95,   -1,   49,   -1,   -1,   -1,   -1,   -1,   -1,  104,

			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			   67,   33,   -1,   -1,   36,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   33,   80,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   33,   46,   -1,   -1,   95,   -1,
			   -1,   -1,   -1,   -1,   -1,   67,   -1,  104,  105,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,   80,   -1,
			   -1,   -1,   33,   -1,   75,   -1,   65,   -1,   -1,   -1,
			   -1,   -1,   -1,   95,   -1,   33,   87,   -1,   -1,   -1,
			   -1,   -1,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  104,  105,  106,  107,  108,  109,  110,

			  111,  112,  113,  114,   75,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,   87,   75,   33,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   87,
			   33,   -1,   -1,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,   33,   -1,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,   -1,   -1,   74,
			    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,

			   -1,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   -1,   -1,   -1,  104,  105,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   82,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,    4,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   -1,   -1,   -1,   -1,   -1,
			   45,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   45,    4,

			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,    4,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   -1,   -1,   -1,   -1,   -1,
			   45,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,   45,  136,
			    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,    7,    8,    9,   10,   11,   12,

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

	yyFinal: INTEGER is 892
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 137
			-- Number of tokens

	yyLast: INTEGER is 3008
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
