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
--|#line 206
	yy_do_action_11
when 12 then
--|#line 210
	yy_do_action_12
when 13 then
--|#line 214
	yy_do_action_13
when 14 then
--|#line 218
	yy_do_action_14
when 15 then
--|#line 222
	yy_do_action_15
when 16 then
--|#line 226
	yy_do_action_16
when 17 then
--|#line 230
	yy_do_action_17
when 19 then
--|#line 240
	yy_do_action_19
when 21 then
--|#line 246
	yy_do_action_21
when 22 then
--|#line 251
	yy_do_action_22
when 23 then
--|#line 258
	yy_do_action_23
when 24 then
--|#line 262
	yy_do_action_24
when 26 then
--|#line 268
	yy_do_action_26
when 27 then
--|#line 273
	yy_do_action_27
when 28 then
--|#line 278
	yy_do_action_28
when 29 then
--|#line 285
	yy_do_action_29
when 30 then
--|#line 287
	yy_do_action_30
when 31 then
--|#line 295
	yy_do_action_31
when 32 then
--|#line 301
	yy_do_action_32
when 33 then
--|#line 307
	yy_do_action_33
when 34 then
--|#line 313
	yy_do_action_34
when 36 then
--|#line 327
	yy_do_action_36
when 38 then
--|#line 337
	yy_do_action_38
when 39 then
--|#line 346
	yy_do_action_39
when 40 then
--|#line 351
	yy_do_action_40
when 42 then
--|#line 360
	yy_do_action_42
when 43 then
--|#line 364
	yy_do_action_43
when 44 then
--|#line 364
	yy_do_action_44
when 46 then
--|#line 375
	yy_do_action_46
when 47 then
--|#line 379
	yy_do_action_47
when 48 then
--|#line 384
	yy_do_action_48
when 49 then
--|#line 388
	yy_do_action_49
when 50 then
--|#line 393
	yy_do_action_50
when 51 then
--|#line 400
	yy_do_action_51
when 52 then
--|#line 405
	yy_do_action_52
when 55 then
--|#line 416
	yy_do_action_55
when 56 then
--|#line 420
	yy_do_action_56
when 57 then
--|#line 422
	yy_do_action_57
when 58 then
--|#line 429
	yy_do_action_58
when 59 then
--|#line 433
	yy_do_action_59
when 60 then
--|#line 435
	yy_do_action_60
when 61 then
--|#line 439
	yy_do_action_61
when 62 then
--|#line 441
	yy_do_action_62
when 63 then
--|#line 443
	yy_do_action_63
when 64 then
--|#line 447
	yy_do_action_64
when 65 then
--|#line 452
	yy_do_action_65
when 66 then
--|#line 456
	yy_do_action_66
when 68 then
--|#line 462
	yy_do_action_68
when 69 then
--|#line 466
	yy_do_action_69
when 70 then
--|#line 468
	yy_do_action_70
when 71 then
--|#line 470
	yy_do_action_71
when 73 then
--|#line 480
	yy_do_action_73
when 75 then
--|#line 486
	yy_do_action_75
when 76 then
--|#line 491
	yy_do_action_76
when 77 then
--|#line 498
	yy_do_action_77
when 78 then
--|#line 500
	yy_do_action_78
when 79 then
--|#line 507
	yy_do_action_79
when 80 then
--|#line 512
	yy_do_action_80
when 81 then
--|#line 517
	yy_do_action_81
when 82 then
--|#line 522
	yy_do_action_82
when 83 then
--|#line 527
	yy_do_action_83
when 84 then
--|#line 532
	yy_do_action_84
when 85 then
--|#line 537
	yy_do_action_85
when 86 then
--|#line 544
	yy_do_action_86
when 87 then
--|#line 548
	yy_do_action_87
when 88 then
--|#line 553
	yy_do_action_88
when 89 then
--|#line 560
	yy_do_action_89
when 91 then
--|#line 566
	yy_do_action_91
when 92 then
--|#line 570
	yy_do_action_92
when 94 then
--|#line 576
	yy_do_action_94
when 95 then
--|#line 581
	yy_do_action_95
when 96 then
--|#line 588
	yy_do_action_96
when 97 then
--|#line 592
	yy_do_action_97
when 98 then
--|#line 594
	yy_do_action_98
when 99 then
--|#line 598
	yy_do_action_99
when 100 then
--|#line 603
	yy_do_action_100
when 102 then
--|#line 612
	yy_do_action_102
when 104 then
--|#line 618
	yy_do_action_104
when 106 then
--|#line 624
	yy_do_action_106
when 108 then
--|#line 630
	yy_do_action_108
when 110 then
--|#line 636
	yy_do_action_110
when 112 then
--|#line 642
	yy_do_action_112
when 114 then
--|#line 652
	yy_do_action_114
when 116 then
--|#line 658
	yy_do_action_116
when 117 then
--|#line 662
	yy_do_action_117
when 118 then
--|#line 667
	yy_do_action_118
when 119 then
--|#line 674
	yy_do_action_119
when 120 then
--|#line 678
	yy_do_action_120
when 121 then
--|#line 683
	yy_do_action_121
when 122 then
--|#line 690
	yy_do_action_122
when 123 then
--|#line 692
	yy_do_action_123
when 125 then
--|#line 698
	yy_do_action_125
when 126 then
--|#line 702
	yy_do_action_126
when 127 then
--|#line 702
	yy_do_action_127
when 128 then
--|#line 709
	yy_do_action_128
when 129 then
--|#line 711
	yy_do_action_129
when 130 then
--|#line 713
	yy_do_action_130
when 131 then
--|#line 717
	yy_do_action_131
when 132 then
--|#line 721
	yy_do_action_132
when 133 then
--|#line 721
	yy_do_action_133
when 135 then
--|#line 729
	yy_do_action_135
when 136 then
--|#line 733
	yy_do_action_136
when 137 then
--|#line 735
	yy_do_action_137
when 139 then
--|#line 741
	yy_do_action_139
when 141 then
--|#line 747
	yy_do_action_141
when 142 then
--|#line 751
	yy_do_action_142
when 143 then
--|#line 756
	yy_do_action_143
when 144 then
--|#line 763
	yy_do_action_144
when 147 then
--|#line 771
	yy_do_action_147
when 148 then
--|#line 773
	yy_do_action_148
when 149 then
--|#line 775
	yy_do_action_149
when 150 then
--|#line 777
	yy_do_action_150
when 151 then
--|#line 779
	yy_do_action_151
when 152 then
--|#line 781
	yy_do_action_152
when 153 then
--|#line 783
	yy_do_action_153
when 154 then
--|#line 785
	yy_do_action_154
when 155 then
--|#line 787
	yy_do_action_155
when 156 then
--|#line 789
	yy_do_action_156
when 158 then
--|#line 795
	yy_do_action_158
when 159 then
--|#line 795
	yy_do_action_159
when 160 then
--|#line 802
	yy_do_action_160
when 161 then
--|#line 802
	yy_do_action_161
when 163 then
--|#line 813
	yy_do_action_163
when 164 then
--|#line 813
	yy_do_action_164
when 165 then
--|#line 820
	yy_do_action_165
when 166 then
--|#line 820
	yy_do_action_166
when 168 then
--|#line 831
	yy_do_action_168
when 169 then
--|#line 840
	yy_do_action_169
when 170 then
--|#line 845
	yy_do_action_170
when 171 then
--|#line 852
	yy_do_action_171
when 172 then
--|#line 856
	yy_do_action_172
when 173 then
--|#line 858
	yy_do_action_173
when 175 then
--|#line 868
	yy_do_action_175
when 176 then
--|#line 870
	yy_do_action_176
when 177 then
--|#line 874
	yy_do_action_177
when 178 then
--|#line 876
	yy_do_action_178
when 179 then
--|#line 878
	yy_do_action_179
when 180 then
--|#line 880
	yy_do_action_180
when 181 then
--|#line 882
	yy_do_action_181
when 182 then
--|#line 884
	yy_do_action_182
when 183 then
--|#line 888
	yy_do_action_183
when 184 then
--|#line 890
	yy_do_action_184
when 185 then
--|#line 892
	yy_do_action_185
when 186 then
--|#line 894
	yy_do_action_186
when 187 then
--|#line 896
	yy_do_action_187
when 188 then
--|#line 898
	yy_do_action_188
when 189 then
--|#line 900
	yy_do_action_189
when 190 then
--|#line 902
	yy_do_action_190
when 193 then
--|#line 910
	yy_do_action_193
when 194 then
--|#line 914
	yy_do_action_194
when 195 then
--|#line 919
	yy_do_action_195
when 197 then
--|#line 932
	yy_do_action_197
when 199 then
--|#line 938
	yy_do_action_199
when 200 then
--|#line 942
	yy_do_action_200
when 201 then
--|#line 947
	yy_do_action_201
when 202 then
--|#line 954
	yy_do_action_202
when 203 then
--|#line 954
	yy_do_action_203
when 205 then
--|#line 966
	yy_do_action_205
when 207 then
--|#line 972
	yy_do_action_207
when 208 then
--|#line 980
	yy_do_action_208
when 210 then
--|#line 989
	yy_do_action_210
when 211 then
--|#line 993
	yy_do_action_211
when 212 then
--|#line 998
	yy_do_action_212
when 213 then
--|#line 1005
	yy_do_action_213
when 215 then
--|#line 1011
	yy_do_action_215
when 216 then
--|#line 1015
	yy_do_action_216
when 218 then
--|#line 1024
	yy_do_action_218
when 219 then
--|#line 1028
	yy_do_action_219
when 220 then
--|#line 1033
	yy_do_action_220
when 221 then
--|#line 1040
	yy_do_action_221
when 222 then
--|#line 1044
	yy_do_action_222
when 223 then
--|#line 1049
	yy_do_action_223
when 224 then
--|#line 1056
	yy_do_action_224
when 225 then
--|#line 1058
	yy_do_action_225
when 226 then
--|#line 1060
	yy_do_action_226
when 227 then
--|#line 1062
	yy_do_action_227
when 228 then
--|#line 1064
	yy_do_action_228
when 229 then
--|#line 1066
	yy_do_action_229
when 230 then
--|#line 1068
	yy_do_action_230
when 231 then
--|#line 1070
	yy_do_action_231
when 232 then
--|#line 1072
	yy_do_action_232
when 233 then
--|#line 1074
	yy_do_action_233
when 235 then
--|#line 1080
	yy_do_action_235
when 236 then
--|#line 1089
	yy_do_action_236
when 238 then
--|#line 1098
	yy_do_action_238
when 240 then
--|#line 1104
	yy_do_action_240
when 241 then
--|#line 1104
	yy_do_action_241
when 243 then
--|#line 1116
	yy_do_action_243
when 244 then
--|#line 1118
	yy_do_action_244
when 245 then
--|#line 1122
	yy_do_action_245
when 248 then
--|#line 1133
	yy_do_action_248
when 249 then
--|#line 1137
	yy_do_action_249
when 250 then
--|#line 1142
	yy_do_action_250
when 251 then
--|#line 1149
	yy_do_action_251
when 253 then
--|#line 1155
	yy_do_action_253
when 254 then
--|#line 1164
	yy_do_action_254
when 255 then
--|#line 1166
	yy_do_action_255
when 256 then
--|#line 1170
	yy_do_action_256
when 257 then
--|#line 1172
	yy_do_action_257
when 259 then
--|#line 1178
	yy_do_action_259
when 260 then
--|#line 1182
	yy_do_action_260
when 261 then
--|#line 1187
	yy_do_action_261
when 262 then
--|#line 1194
	yy_do_action_262
when 263 then
--|#line 1199
	yy_do_action_263
when 264 then
--|#line 1204
	yy_do_action_264
when 265 then
--|#line 1211
	yy_do_action_265
when 266 then
--|#line 1215
	yy_do_action_266
when 267 then
--|#line 1217
	yy_do_action_267
when 268 then
--|#line 1219
	yy_do_action_268
when 270 then
--|#line 1223
	yy_do_action_270
when 272 then
--|#line 1229
	yy_do_action_272
when 273 then
--|#line 1233
	yy_do_action_273
when 274 then
--|#line 1238
	yy_do_action_274
when 275 then
--|#line 1245
	yy_do_action_275
when 276 then
--|#line 1247
	yy_do_action_276
when 277 then
--|#line 1249
	yy_do_action_277
when 278 then
--|#line 1251
	yy_do_action_278
when 279 then
--|#line 1253
	yy_do_action_279
when 280 then
--|#line 1255
	yy_do_action_280
when 281 then
--|#line 1257
	yy_do_action_281
when 282 then
--|#line 1259
	yy_do_action_282
when 283 then
--|#line 1261
	yy_do_action_283
when 284 then
--|#line 1263
	yy_do_action_284
when 285 then
--|#line 1265
	yy_do_action_285
when 286 then
--|#line 1269
	yy_do_action_286
when 287 then
--|#line 1271
	yy_do_action_287
when 288 then
--|#line 1273
	yy_do_action_288
when 289 then
--|#line 1277
	yy_do_action_289
when 290 then
--|#line 1279
	yy_do_action_290
when 292 then
--|#line 1285
	yy_do_action_292
when 293 then
--|#line 1289
	yy_do_action_293
when 294 then
--|#line 1291
	yy_do_action_294
when 296 then
--|#line 1297
	yy_do_action_296
when 297 then
--|#line 1305
	yy_do_action_297
when 298 then
--|#line 1307
	yy_do_action_298
when 299 then
--|#line 1309
	yy_do_action_299
when 300 then
--|#line 1311
	yy_do_action_300
when 301 then
--|#line 1313
	yy_do_action_301
when 302 then
--|#line 1315
	yy_do_action_302
when 303 then
--|#line 1317
	yy_do_action_303
when 304 then
--|#line 1321
	yy_do_action_304
when 305 then
--|#line 1332
	yy_do_action_305
when 306 then
--|#line 1334
	yy_do_action_306
when 307 then
--|#line 1336
	yy_do_action_307
when 308 then
--|#line 1338
	yy_do_action_308
when 309 then
--|#line 1340
	yy_do_action_309
when 310 then
--|#line 1342
	yy_do_action_310
when 311 then
--|#line 1344
	yy_do_action_311
when 312 then
--|#line 1346
	yy_do_action_312
when 313 then
--|#line 1348
	yy_do_action_313
when 314 then
--|#line 1350
	yy_do_action_314
when 315 then
--|#line 1352
	yy_do_action_315
when 316 then
--|#line 1354
	yy_do_action_316
when 317 then
--|#line 1356
	yy_do_action_317
when 318 then
--|#line 1358
	yy_do_action_318
when 319 then
--|#line 1360
	yy_do_action_319
when 320 then
--|#line 1362
	yy_do_action_320
when 321 then
--|#line 1364
	yy_do_action_321
when 322 then
--|#line 1366
	yy_do_action_322
when 323 then
--|#line 1368
	yy_do_action_323
when 324 then
--|#line 1370
	yy_do_action_324
when 325 then
--|#line 1372
	yy_do_action_325
when 326 then
--|#line 1374
	yy_do_action_326
when 327 then
--|#line 1376
	yy_do_action_327
when 328 then
--|#line 1378
	yy_do_action_328
when 329 then
--|#line 1380
	yy_do_action_329
when 330 then
--|#line 1382
	yy_do_action_330
when 331 then
--|#line 1384
	yy_do_action_331
when 332 then
--|#line 1386
	yy_do_action_332
when 333 then
--|#line 1388
	yy_do_action_333
when 334 then
--|#line 1390
	yy_do_action_334
when 335 then
--|#line 1392
	yy_do_action_335
when 336 then
--|#line 1394
	yy_do_action_336
when 337 then
--|#line 1398
	yy_do_action_337
when 338 then
--|#line 1400
	yy_do_action_338
when 339 then
--|#line 1402
	yy_do_action_339
when 340 then
--|#line 1404
	yy_do_action_340
when 341 then
--|#line 1406
	yy_do_action_341
when 342 then
--|#line 1410
	yy_do_action_342
when 343 then
--|#line 1418
	yy_do_action_343
when 344 then
--|#line 1420
	yy_do_action_344
when 345 then
--|#line 1422
	yy_do_action_345
when 346 then
--|#line 1424
	yy_do_action_346
when 347 then
--|#line 1426
	yy_do_action_347
when 348 then
--|#line 1428
	yy_do_action_348
when 349 then
--|#line 1430
	yy_do_action_349
when 350 then
--|#line 1432
	yy_do_action_350
when 351 then
--|#line 1434
	yy_do_action_351
when 352 then
--|#line 1436
	yy_do_action_352
when 353 then
--|#line 1440
	yy_do_action_353
when 354 then
--|#line 1444
	yy_do_action_354
when 355 then
--|#line 1448
	yy_do_action_355
when 356 then
--|#line 1452
	yy_do_action_356
when 357 then
--|#line 1456
	yy_do_action_357
when 358 then
--|#line 1460
	yy_do_action_358
when 359 then
--|#line 1462
	yy_do_action_359
when 360 then
--|#line 1464
	yy_do_action_360
when 361 then
--|#line 1466
	yy_do_action_361
when 362 then
--|#line 1468
	yy_do_action_362
when 363 then
--|#line 1470
	yy_do_action_363
when 364 then
--|#line 1472
	yy_do_action_364
when 365 then
--|#line 1474
	yy_do_action_365
when 366 then
--|#line 1476
	yy_do_action_366
when 367 then
--|#line 1478
	yy_do_action_367
when 368 then
--|#line 1480
	yy_do_action_368
when 369 then
--|#line 1484
	yy_do_action_369
when 370 then
--|#line 1486
	yy_do_action_370
when 371 then
--|#line 1490
	yy_do_action_371
when 372 then
--|#line 1492
	yy_do_action_372
when 373 then
--|#line 1496
	yy_do_action_373
when 374 then
--|#line 1509
	yy_do_action_374
when 377 then
--|#line 1517
	yy_do_action_377
when 378 then
--|#line 1521
	yy_do_action_378
when 379 then
--|#line 1526
	yy_do_action_379
when 380 then
--|#line 1533
	yy_do_action_380
when 381 then
--|#line 1535
	yy_do_action_381
when 382 then
--|#line 1539
	yy_do_action_382
when 383 then
--|#line 1544
	yy_do_action_383
when 384 then
--|#line 1555
	yy_do_action_384
when 385 then
--|#line 1557
	yy_do_action_385
when 386 then
--|#line 1559
	yy_do_action_386
when 387 then
--|#line 1561
	yy_do_action_387
when 388 then
--|#line 1563
	yy_do_action_388
when 389 then
--|#line 1565
	yy_do_action_389
when 390 then
--|#line 1567
	yy_do_action_390
when 391 then
--|#line 1569
	yy_do_action_391
when 392 then
--|#line 1573
	yy_do_action_392
when 393 then
--|#line 1575
	yy_do_action_393
when 394 then
--|#line 1577
	yy_do_action_394
when 395 then
--|#line 1579
	yy_do_action_395
when 396 then
--|#line 1581
	yy_do_action_396
when 397 then
--|#line 1583
	yy_do_action_397
when 398 then
--|#line 1587
	yy_do_action_398
when 399 then
--|#line 1589
	yy_do_action_399
when 400 then
--|#line 1591
	yy_do_action_400
when 401 then
--|#line 1601
	yy_do_action_401
when 402 then
--|#line 1603
	yy_do_action_402
when 403 then
--|#line 1605
	yy_do_action_403
when 404 then
--|#line 1609
	yy_do_action_404
when 405 then
--|#line 1611
	yy_do_action_405
when 406 then
--|#line 1615
	yy_do_action_406
when 407 then
--|#line 1622
	yy_do_action_407
when 408 then
--|#line 1632
	yy_do_action_408
when 409 then
--|#line 1642
	yy_do_action_409
when 410 then
--|#line 1655
	yy_do_action_410
when 411 then
--|#line 1657
	yy_do_action_411
when 412 then
--|#line 1659
	yy_do_action_412
when 413 then
--|#line 1666
	yy_do_action_413
when 414 then
--|#line 1670
	yy_do_action_414
when 415 then
--|#line 1672
	yy_do_action_415
when 416 then
--|#line 1676
	yy_do_action_416
when 417 then
--|#line 1678
	yy_do_action_417
when 418 then
--|#line 1680
	yy_do_action_418
when 419 then
--|#line 1682
	yy_do_action_419
when 420 then
--|#line 1684
	yy_do_action_420
when 421 then
--|#line 1686
	yy_do_action_421
when 422 then
--|#line 1688
	yy_do_action_422
when 423 then
--|#line 1690
	yy_do_action_423
when 424 then
--|#line 1692
	yy_do_action_424
when 425 then
--|#line 1694
	yy_do_action_425
when 426 then
--|#line 1696
	yy_do_action_426
when 427 then
--|#line 1698
	yy_do_action_427
when 428 then
--|#line 1700
	yy_do_action_428
when 429 then
--|#line 1702
	yy_do_action_429
when 430 then
--|#line 1704
	yy_do_action_430
when 431 then
--|#line 1706
	yy_do_action_431
when 432 then
--|#line 1708
	yy_do_action_432
when 433 then
--|#line 1710
	yy_do_action_433
when 434 then
--|#line 1712
	yy_do_action_434
when 435 then
--|#line 1714
	yy_do_action_435
when 436 then
--|#line 1718
	yy_do_action_436
when 437 then
--|#line 1720
	yy_do_action_437
when 438 then
--|#line 1722
	yy_do_action_438
when 439 then
--|#line 1724
	yy_do_action_439
when 440 then
--|#line 1728
	yy_do_action_440
when 441 then
--|#line 1730
	yy_do_action_441
when 442 then
--|#line 1732
	yy_do_action_442
when 443 then
--|#line 1734
	yy_do_action_443
when 444 then
--|#line 1736
	yy_do_action_444
when 445 then
--|#line 1738
	yy_do_action_445
when 446 then
--|#line 1740
	yy_do_action_446
when 447 then
--|#line 1742
	yy_do_action_447
when 448 then
--|#line 1744
	yy_do_action_448
when 449 then
--|#line 1746
	yy_do_action_449
when 450 then
--|#line 1748
	yy_do_action_450
when 451 then
--|#line 1750
	yy_do_action_451
when 452 then
--|#line 1752
	yy_do_action_452
when 453 then
--|#line 1754
	yy_do_action_453
when 454 then
--|#line 1756
	yy_do_action_454
when 455 then
--|#line 1758
	yy_do_action_455
when 456 then
--|#line 1760
	yy_do_action_456
when 457 then
--|#line 1762
	yy_do_action_457
when 458 then
--|#line 1766
	yy_do_action_458
when 459 then
--|#line 1770
	yy_do_action_459
when 460 then
--|#line 1774
	yy_do_action_460
when 461 then
--|#line 1778
	yy_do_action_461
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
			--|#line 206
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_boolean_id_as) 
			yyval := yyval83
		end

	yy_do_action_12 is
			--|#line 210
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_character_id_as) 
			yyval := yyval83
		end

	yy_do_action_13 is
			--|#line 214
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_double_id_as) 
			yyval := yyval83
		end

	yy_do_action_14 is
			--|#line 218
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_integer_id_as) 
			yyval := yyval83
		end

	yy_do_action_15 is
			--|#line 222
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_none_id_as) 
			yyval := yyval83
		end

	yy_do_action_16 is
			--|#line 226
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_pointer_id_as) 
			yyval := yyval83
		end

	yy_do_action_17 is
			--|#line 230
		local
			yyval83: PAIR [ID_AS, CLICK_AST]
		do

yyval83 := new_clickable_id (new_real_id_as) 
			yyval := yyval83
		end

	yy_do_action_19 is
			--|#line 240
		local
			yyval72: EIFFEL_LIST [INDEX_AS]
		do

yyval72 := yytype72 (yyvs.item (yyvsp)) 
			yyval := yyval72
		end

	yy_do_action_21 is
			--|#line 246
		local
			yyval72: EIFFEL_LIST [INDEX_AS]
		do

				yyval72 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval72.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval72
		end

	yy_do_action_22 is
			--|#line 251
		local
			yyval72: EIFFEL_LIST [INDEX_AS]
		do

				yyval72 := yytype72 (yyvs.item (yyvsp - 1))
				yyval72.extend (yytype32 (yyvs.item (yyvsp)))
			
			yyval := yyval72
		end

	yy_do_action_23 is
			--|#line 258
		local
			yyval32: INDEX_AS
		do

yyval32 := new_index_as (yytype30 (yyvs.item (yyvsp - 2)), yytype60 (yyvs.item (yyvsp - 1))) 
			yyval := yyval32
		end

	yy_do_action_24 is
			--|#line 262
		local
			yyval30: ID_AS
		do

yyval30 := yytype30 (yyvs.item (yyvsp - 1)) 
			yyval := yyval30
		end

	yy_do_action_26 is
			--|#line 268
		local
			yyval60: EIFFEL_LIST [ATOMIC_AS]
		do

				yyval60 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval60.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval60
		end

	yy_do_action_27 is
			--|#line 273
		local
			yyval60: EIFFEL_LIST [ATOMIC_AS]
		do

				yyval60 := yytype60 (yyvs.item (yyvsp - 2))
				yyval60.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval60
		end

	yy_do_action_28 is
			--|#line 278
		local
			yyval60: EIFFEL_LIST [ATOMIC_AS]
		do

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval60 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval60
		end

	yy_do_action_29 is
			--|#line 285
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype30 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_30 is
			--|#line 287
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_31 is
			--|#line 295
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_32 is
			--|#line 301
		local

		do
			yyval := yyval_default;
				is_deferred := True
				is_expanded := False
				is_separate := False
			

		end

	yy_do_action_33 is
			--|#line 307
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := True
				is_separate := False
			

		end

	yy_do_action_34 is
			--|#line 313
		local

		do
			yyval := yyval_default;
				is_deferred := False
				is_expanded := False
				is_separate := True
			

		end

	yy_do_action_36 is
			--|#line 327
		local
			yyval54: STRING_AS
		do

yyval54 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval54
		end

	yy_do_action_38 is
			--|#line 337
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
			--|#line 346
		local
			yyval67: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval67 := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list (yyval67, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_40 is
			--|#line 351
		local
			yyval67: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

				yyval67 := yytype67 (yyvs.item (yyvsp - 1))
				add_to_feature_clause_list (yyval67, yytype27 (yyvs.item (yyvsp)))
			
			yyval := yyval67
		end

	yy_do_action_42 is
			--|#line 360
		local
			yyval27: FEATURE_CLAUSE_AS
		do

yyval27 := new_feature_clause_as (yytype14 (yyvs.item (yyvsp - 1)), yytype66 (yyvs.item (yyvsp)), fclause_pos) 
			yyval := yyval27
		end

	yy_do_action_43 is
			--|#line 364
		local
			yyval14: CLIENT_AS
		do

yyval14 := yytype14 (yyvs.item (yyvsp)) 
			yyval := yyval14
		end

	yy_do_action_44 is
			--|#line 364
		local

		do
			yyval := yyval_default;
				inherit_context := False
				fclause_pos := current_position.end_position
			

		end

	yy_do_action_46 is
			--|#line 375
		local
			yyval14: CLIENT_AS
		do

yyval14 := new_client_as (yytype71 (yyvs.item (yyvsp))) 
			yyval := yyval14
		end

	yy_do_action_47 is
			--|#line 379
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := new_eiffel_list_id_as (1)
				yyval71.extend (new_none_id_as)
			
			yyval := yyval71
		end

	yy_do_action_48 is
			--|#line 384
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

yyval71 := yytype71 (yyvs.item (yyvsp - 1)) 
			yyval := yyval71
		end

	yy_do_action_49 is
			--|#line 388
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := new_eiffel_list_id_as (Initial_class_list_size)
				yyval71.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_50 is
			--|#line 393
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_51 is
			--|#line 400
		local
			yyval66: EIFFEL_LIST [FEATURE_AS]
		do

				yyval66 := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				yyval66.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_52 is
			--|#line 405
		local
			yyval66: EIFFEL_LIST [FEATURE_AS]
		do

				yyval66 := yytype66 (yyvs.item (yyvsp - 1))
				yyval66.extend (yytype26 (yyvs.item (yyvsp)))
			
			yyval := yyval66
		end

	yy_do_action_55 is
			--|#line 416
		local
			yyval26: FEATURE_AS
		do

yyval26 := new_feature_declaration (yytype86 (yyvs.item (yyvsp - 2)), yytype8 (yyvs.item (yyvsp - 1))) 
			yyval := yyval26
		end

	yy_do_action_56 is
			--|#line 420
		local
			yyval86: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

yyval86 := new_clickable_feature_name_list (yytype84 (yyvs.item (yyvsp)), Initial_new_feature_list_size) 
			yyval := yyval86
		end

	yy_do_action_57 is
			--|#line 422
		local
			yyval86: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]
		do

				yyval86 := yytype86 (yyvs.item (yyvsp - 2))
				yyval86.first.extend (yytype84 (yyvs.item (yyvsp)).first)
			
			yyval := yyval86
		end

	yy_do_action_58 is
			--|#line 429
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_59 is
			--|#line 433
		local

		do
			yyval := yyval_default;
is_frozen := False 

		end

	yy_do_action_60 is
			--|#line 435
		local

		do
			yyval := yyval_default;
is_frozen := True 

		end

	yy_do_action_61 is
			--|#line 439
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval84 := new_clickable_feature_name (yytype83 (yyvs.item (yyvsp))) 
			yyval := yyval84
		end

	yy_do_action_62 is
			--|#line 441
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_63 is
			--|#line 443
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval84 := yytype84 (yyvs.item (yyvsp)) 
			yyval := yyval84
		end

	yy_do_action_64 is
			--|#line 447
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval84 := new_clickable_infix (yytype85 (yyvs.item (yyvsp))) 
			yyval := yyval84
		end

	yy_do_action_65 is
			--|#line 452
		local
			yyval84: PAIR [FEATURE_NAME, CLICK_AST]
		do

yyval84 := new_clickable_prefix (yytype85 (yyvs.item (yyvsp))) 
			yyval := yyval84
		end

	yy_do_action_66 is
			--|#line 456
		local
			yyval8: BODY_AS
		do

yyval8 := new_declaration_body (yytype81 (yyvs.item (yyvsp - 2)), yytype57 (yyvs.item (yyvsp - 1)), yytype15 (yyvs.item (yyvsp))) 
			yyval := yyval8
		end

	yy_do_action_68 is
			--|#line 462
		local
			yyval15: CONTENT_AS
		do

yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_69 is
			--|#line 466
		local
			yyval15: CONTENT_AS
		do

yyval15 := new_constant_as (new_value_as (yytype6 (yyvs.item (yyvsp)))) 
			yyval := yyval15
		end

	yy_do_action_70 is
			--|#line 468
		local
			yyval15: CONTENT_AS
		do

yyval15 := new_constant_as (new_value_as (new_unique_as)) 
			yyval := yyval15
		end

	yy_do_action_71 is
			--|#line 470
		local
			yyval15: CONTENT_AS
		do

yyval15 := yytype52 (yyvs.item (yyvsp)) 
			yyval := yyval15
		end

	yy_do_action_73 is
			--|#line 480
		local
			yyval76: EIFFEL_LIST [PARENT_AS]
		do

yyval76 := yytype76 (yyvs.item (yyvsp)) 
			yyval := yyval76
		end

	yy_do_action_75 is
			--|#line 486
		local
			yyval76: EIFFEL_LIST [PARENT_AS]
		do

				yyval76 := new_eiffel_list_parent_as (Initial_parent_list_size)
				yyval76.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_76 is
			--|#line 491
		local
			yyval76: EIFFEL_LIST [PARENT_AS]
		do

				yyval76 := yytype76 (yyvs.item (yyvsp - 1))
				yyval76.extend (yytype44 (yyvs.item (yyvsp)))
			
			yyval := yyval76
		end

	yy_do_action_77 is
			--|#line 498
		local
			yyval44: PARENT_AS
		do

yyval44 := yytype44 (yyvs.item (yyvsp)) 
			yyval := yyval44
		end

	yy_do_action_78 is
			--|#line 500
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := yytype44 (yyvs.item (yyvsp - 1))
			
			yyval := yyval44
		end

	yy_do_action_79 is
			--|#line 507
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_80 is
			--|#line 512
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 7)), yytype80 (yyvs.item (yyvsp - 6)), yytype77 (yyvs.item (yyvsp - 5)), yytype64 (yyvs.item (yyvsp - 4)), yytype69 (yyvs.item (yyvsp - 3)), yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_81 is
			--|#line 517
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 6)), yytype80 (yyvs.item (yyvsp - 5)), Void, yytype64 (yyvs.item (yyvsp - 4)), yytype69 (yyvs.item (yyvsp - 3)), yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_82 is
			--|#line 522
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 5)), yytype80 (yyvs.item (yyvsp - 4)), Void, Void, yytype69 (yyvs.item (yyvsp - 3)), yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_83 is
			--|#line 527
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 4)), yytype80 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype69 (yyvs.item (yyvsp - 2)), yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_84 is
			--|#line 532
		local
			yyval44: PARENT_AS
		do

				inherit_context := False
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 3)), yytype80 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype69 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval44
		end

	yy_do_action_85 is
			--|#line 537
		local
			yyval44: PARENT_AS
		do

				inherit_context := True
				yyval44 := new_parent_clause (yytype83 (yyvs.item (yyvsp - 2)), yytype80 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval44
		end

	yy_do_action_86 is
			--|#line 544
		local
			yyval77: EIFFEL_LIST [RENAME_AS]
		do

yyval77 := yytype77 (yyvs.item (yyvsp)) 
			yyval := yyval77
		end

	yy_do_action_87 is
			--|#line 548
		local
			yyval77: EIFFEL_LIST [RENAME_AS]
		do

				yyval77 := new_eiffel_list_rename_as (Initial_rename_list_size)
				yyval77.extend (yytype47 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_88 is
			--|#line 553
		local
			yyval77: EIFFEL_LIST [RENAME_AS]
		do

				yyval77 := yytype77 (yyvs.item (yyvsp - 2))
				yyval77.extend (yytype47 (yyvs.item (yyvsp)))
			
			yyval := yyval77
		end

	yy_do_action_89 is
			--|#line 560
		local
			yyval47: RENAME_AS
		do

yyval47 := new_rename_pair (yytype84 (yyvs.item (yyvsp - 2)), yytype84 (yyvs.item (yyvsp))) 
			yyval := yyval47
		end

	yy_do_action_91 is
			--|#line 566
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_92 is
			--|#line 570
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

yyval64 := yytype64 (yyvs.item (yyvsp)) 
			yyval := yyval64
		end

	yy_do_action_94 is
			--|#line 576
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval64 := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				yyval64.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_95 is
			--|#line 581
		local
			yyval64: EIFFEL_LIST [EXPORT_ITEM_AS]
		do

				yyval64 := yytype64 (yyvs.item (yyvsp - 1))
				yyval64.extend (yytype22 (yyvs.item (yyvsp)))
			
			yyval := yyval64
		end

	yy_do_action_96 is
			--|#line 588
		local
			yyval22: EXPORT_ITEM_AS
		do

yyval22 := new_export_item_as (new_client_as (yytype71 (yyvs.item (yyvsp - 2))), yytype28 (yyvs.item (yyvsp - 1))) 
			yyval := yyval22
		end

	yy_do_action_97 is
			--|#line 592
		local
			yyval28: FEATURE_SET_AS
		do

yyval28 := new_all_as 
			yyval := yyval28
		end

	yy_do_action_98 is
			--|#line 594
		local
			yyval28: FEATURE_SET_AS
		do

yyval28 := new_feature_list_as (yytype69 (yyvs.item (yyvsp))) 
			yyval := yyval28
		end

	yy_do_action_99 is
			--|#line 598
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval69 := new_eiffel_list_feature_name (Initial_feature_list_size)
				yyval69.extend (yytype84 (yyvs.item (yyvsp)).first)
			
			yyval := yyval69
		end

	yy_do_action_100 is
			--|#line 603
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

				yyval69 := yytype69 (yyvs.item (yyvsp - 2))
				yyval69.extend (yytype84 (yyvs.item (yyvsp)).first)
			
			yyval := yyval69
		end

	yy_do_action_102 is
			--|#line 612
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_104 is
			--|#line 618
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_106 is
			--|#line 624
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_108 is
			--|#line 630
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_110 is
			--|#line 636
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_112 is
			--|#line 642
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp)) 
			yyval := yyval69
		end

	yy_do_action_114 is
			--|#line 652
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval81 := yytype81 (yyvs.item (yyvsp - 1)) 
			yyval := yyval81
		end

	yy_do_action_116 is
			--|#line 658
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_117 is
			--|#line 662
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval81 := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				yyval81.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_118 is
			--|#line 667
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

				yyval81 := yytype81 (yyvs.item (yyvsp - 1))
				yyval81.extend (yytype58 (yyvs.item (yyvsp)))
			
			yyval := yyval81
		end

	yy_do_action_119 is
			--|#line 674
		local
			yyval58: TYPE_DEC_AS
		do

yyval58 := new_type_dec_as (yytype71 (yyvs.item (yyvsp - 3)), yytype57 (yyvs.item (yyvsp - 1))) 
			yyval := yyval58
		end

	yy_do_action_120 is
			--|#line 678
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := new_eiffel_list_id_as (Initial_identifier_list_size)
				yyval71.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_121 is
			--|#line 683
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

				yyval71 := yytype71 (yyvs.item (yyvsp - 2))
				yyval71.extend (yytype30 (yyvs.item (yyvsp)))
			
			yyval := yyval71
		end

	yy_do_action_122 is
			--|#line 690
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

yyval71 := new_eiffel_list_id_as (0) 
			yyval := yyval71
		end

	yy_do_action_123 is
			--|#line 692
		local
			yyval71: EIFFEL_LIST [ID_AS]
		do

yyval71 := yytype71 (yyvs.item (yyvsp)) 
			yyval := yyval71
		end

	yy_do_action_125 is
			--|#line 698
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_126 is
			--|#line 702
		local
			yyval52: ROUTINE_AS
		do

yyval52 := new_routine_as (yytype54 (yyvs.item (yyvsp - 7)), yytype48 (yyvs.item (yyvsp - 5)), yytype81 (yyvs.item (yyvsp - 4)), yytype51 (yyvs.item (yyvsp - 3)), yytype21 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)), fbody_pos) 
			yyval := yyval52
		end

	yy_do_action_127 is
			--|#line 702
		local

		do
			yyval := yyval_default;
fbody_pos := current_position.start_position 

		end

	yy_do_action_128 is
			--|#line 709
		local
			yyval51: ROUT_BODY_AS
		do

yyval51 := yytype37 (yyvs.item (yyvsp)) 
			yyval := yyval51
		end

	yy_do_action_129 is
			--|#line 711
		local
			yyval51: ROUT_BODY_AS
		do

yyval51 := yytype24 (yyvs.item (yyvsp)) 
			yyval := yyval51
		end

	yy_do_action_130 is
			--|#line 713
		local
			yyval51: ROUT_BODY_AS
		do

yyval51 := new_deferred_as 
			yyval := yyval51
		end

	yy_do_action_131 is
			--|#line 717
		local
			yyval24: EXTERNAL_AS
		do

yyval24 := new_external_as (yytype25 (yyvs.item (yyvsp - 1)), yytype54 (yyvs.item (yyvsp))) 
			yyval := yyval24
		end

	yy_do_action_132 is
			--|#line 721
		local
			yyval25: EXTERNAL_LANG_AS
		do

yyval25 := new_external_lang_as (yytype54 (yyvs.item (yyvsp)), yacc_position) 
			yyval := yyval25
		end

	yy_do_action_133 is
			--|#line 721
		local

		do
			yyval := yyval_default;
set_position (current_position) 

		end

	yy_do_action_135 is
			--|#line 729
		local
			yyval54: STRING_AS
		do

yyval54 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval54
		end

	yy_do_action_136 is
			--|#line 733
		local
			yyval37: INTERNAL_AS
		do

yyval37 := new_do_as (yytype73 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_137 is
			--|#line 735
		local
			yyval37: INTERNAL_AS
		do

yyval37 := new_once_as (yytype73 (yyvs.item (yyvsp))) 
			yyval := yyval37
		end

	yy_do_action_139 is
			--|#line 741
		local
			yyval81: EIFFEL_LIST [TYPE_DEC_AS]
		do

yyval81 := yytype81 (yyvs.item (yyvsp)) 
			yyval := yyval81
		end

	yy_do_action_141 is
			--|#line 747
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
		end

	yy_do_action_142 is
			--|#line 751
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval73 := new_eiffel_list_instruction_as (Initial_compound_size)
				yyval73.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval73
		end

	yy_do_action_143 is
			--|#line 756
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval73 := yytype73 (yyvs.item (yyvsp - 1))
				yyval73.extend (yytype35 (yyvs.item (yyvsp)))
			
			yyval := yyval73
		end

	yy_do_action_144 is
			--|#line 763
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype35 (yyvs.item (yyvsp - 1)) 
			yyval := yyval35
		end

	yy_do_action_147 is
			--|#line 771
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype17 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_148 is
			--|#line 773
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype34 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_149 is
			--|#line 775
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_150 is
			--|#line 777
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype50 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_151 is
			--|#line 779
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype31 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_152 is
			--|#line 781
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype33 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_153 is
			--|#line 783
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype40 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_154 is
			--|#line 785
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype19 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_155 is
			--|#line 787
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_156 is
			--|#line 789
		local
			yyval35: INSTRUCTION_AS
		do

yyval35 := yytype49 (yyvs.item (yyvsp)) 
			yyval := yyval35
		end

	yy_do_action_158 is
			--|#line 795
		local
			yyval48: REQUIRE_AS
		do

				id_level := Normal_level
				yyval48 := new_require_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval48
		end

	yy_do_action_159 is
			--|#line 795
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_160 is
			--|#line 802
		local
			yyval48: REQUIRE_AS
		do

				id_level := Normal_level
				yyval48 := new_require_else_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval48
		end

	yy_do_action_161 is
			--|#line 802
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_163 is
			--|#line 813
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_164 is
			--|#line 813
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_165 is
			--|#line 820
		local
			yyval21: ENSURE_AS
		do

				id_level := Normal_level
				yyval21 := new_ensure_then_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval21
		end

	yy_do_action_166 is
			--|#line 820
		local

		do
			yyval := yyval_default;
id_level := Assert_level 

		end

	yy_do_action_168 is
			--|#line 831
		local
			yyval79: EIFFEL_LIST [TAGGED_AS]
		do

				yyval79 := yytype79 (yyvs.item (yyvsp))
				if yyval79.empty then
					yyval79 := Void
				end
			
			yyval := yyval79
		end

	yy_do_action_169 is
			--|#line 840
		local
			yyval79: EIFFEL_LIST [TAGGED_AS]
		do

				yyval79 := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list (yyval79, yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_170 is
			--|#line 845
		local
			yyval79: EIFFEL_LIST [TAGGED_AS]
		do

				yyval79 := yytype79 (yyvs.item (yyvsp - 1))
				add_to_assertion_list (yyval79, yytype55 (yyvs.item (yyvsp)))
			
			yyval := yyval79
		end

	yy_do_action_171 is
			--|#line 852
		local
			yyval55: TAGGED_AS
		do

yyval55 := yytype55 (yyvs.item (yyvsp - 1)) 
			yyval := yyval55
		end

	yy_do_action_172 is
			--|#line 856
		local
			yyval55: TAGGED_AS
		do

yyval55 := new_tagged_as (Void, yytype23 (yyvs.item (yyvsp)), yacc_position) 
			yyval := yyval55
		end

	yy_do_action_173 is
			--|#line 858
		local
			yyval55: TAGGED_AS
		do

yyval55 := new_tagged_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), yacc_position) 
			yyval := yyval55
		end

	yy_do_action_175 is
			--|#line 868
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_176 is
			--|#line 870
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_177 is
			--|#line 874
		local
			yyval57: TYPE
		do

yyval57 := new_expanded_type (yytype83 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_178 is
			--|#line 876
		local
			yyval57: TYPE
		do

yyval57 := new_separate_type (yytype83 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_179 is
			--|#line 878
		local
			yyval57: TYPE
		do

yyval57 := new_bits_as (yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_180 is
			--|#line 880
		local
			yyval57: TYPE
		do

yyval57 := new_bits_symbol_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_181 is
			--|#line 882
		local
			yyval57: TYPE
		do

yyval57 := new_like_id_as (yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_182 is
			--|#line 884
		local
			yyval57: TYPE
		do

yyval57 := new_like_current_as 
			yyval := yyval57
		end

	yy_do_action_183 is
			--|#line 888
		local
			yyval57: TYPE
		do

yyval57 := new_class_type (yytype83 (yyvs.item (yyvsp - 1)), yytype80 (yyvs.item (yyvsp))) 
			yyval := yyval57
		end

	yy_do_action_184 is
			--|#line 890
		local
			yyval57: TYPE
		do

yyval57 := new_boolean_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_185 is
			--|#line 892
		local
			yyval57: TYPE
		do

yyval57 := new_character_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_186 is
			--|#line 894
		local
			yyval57: TYPE
		do

yyval57 := new_double_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_187 is
			--|#line 896
		local
			yyval57: TYPE
		do

yyval57 := new_integer_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_188 is
			--|#line 898
		local
			yyval57: TYPE
		do

yyval57 := new_none_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_189 is
			--|#line 900
		local
			yyval57: TYPE
		do

yyval57 := new_pointer_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_190 is
			--|#line 902
		local
			yyval57: TYPE
		do

yyval57 := new_real_type (yytype83 (yyvs.item (yyvsp - 1)).second, yytype80 (yyvs.item (yyvsp)) /= Void) 
			yyval := yyval57
		end

	yy_do_action_193 is
			--|#line 910
		local
			yyval80: EIFFEL_LIST [TYPE]
		do

yyval80 := yytype80 (yyvs.item (yyvsp - 1)) 
			yyval := yyval80
		end

	yy_do_action_194 is
			--|#line 914
		local
			yyval80: EIFFEL_LIST [TYPE]
		do

				yyval80 := new_eiffel_list_type (Initial_type_list_size)
				yyval80.extend (yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_195 is
			--|#line 919
		local
			yyval80: EIFFEL_LIST [TYPE]
		do

				yyval80 := yytype80 (yyvs.item (yyvsp - 2))
				yyval80.extend (yytype57 (yyvs.item (yyvsp)))
			
			yyval := yyval80
		end

	yy_do_action_197 is
			--|#line 932
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

yyval70 := yytype70 (yyvs.item (yyvsp - 1)) 
			yyval := yyval70
		end

	yy_do_action_199 is
			--|#line 938
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

yyval70 := yytype70 (yyvs.item (yyvsp)) 
			yyval := yyval70
		end

	yy_do_action_200 is
			--|#line 942
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval70 := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				yyval70.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_201 is
			--|#line 947
		local
			yyval70: EIFFEL_LIST [FORMAL_DEC_AS]
		do

				yyval70 := yytype70 (yyvs.item (yyvsp - 2))
				yyval70.extend (yytype29 (yyvs.item (yyvsp)))
			
			yyval := yyval70
		end

	yy_do_action_202 is
			--|#line 954
		local
			yyval29: FORMAL_DEC_AS
		do

				check formal_exists: not formal_parameters.empty end
				yyval29 := new_formal_dec_as (formal_parameters.last, yytype57 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)), formal_parameters.count)
			
			yyval := yyval29
		end

	yy_do_action_203 is
			--|#line 954
		local

		do
			yyval := yyval_default;
formal_parameters.extend (new_id_as (token_buffer)) 

		end

	yy_do_action_205 is
			--|#line 966
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_207 is
			--|#line 972
		local
			yyval69: EIFFEL_LIST [FEATURE_NAME]
		do

yyval69 := yytype69 (yyvs.item (yyvsp - 1)) 
			yyval := yyval69
		end

	yy_do_action_208 is
			--|#line 980
		local
			yyval31: IF_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 7)))
				yyval31 := new_if_as (yytype23 (yyvs.item (yyvsp - 5)), yytype73 (yyvs.item (yyvsp - 3)), yytype63 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval31
		end

	yy_do_action_210 is
			--|#line 989
		local
			yyval63: EIFFEL_LIST [ELSIF_AS]
		do

yyval63 := yytype63 (yyvs.item (yyvsp)) 
			yyval := yyval63
		end

	yy_do_action_211 is
			--|#line 993
		local
			yyval63: EIFFEL_LIST [ELSIF_AS]
		do

				yyval63 := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				yyval63.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_212 is
			--|#line 998
		local
			yyval63: EIFFEL_LIST [ELSIF_AS]
		do

				yyval63 := yytype63 (yyvs.item (yyvsp - 1))
				yyval63.extend (yytype20 (yyvs.item (yyvsp)))
			
			yyval := yyval63
		end

	yy_do_action_213 is
			--|#line 1005
		local
			yyval20: ELSIF_AS
		do

yyval20 := new_elseif_as (yytype23 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp)), yacc_line_number) 
			yyval := yyval20
		end

	yy_do_action_215 is
			--|#line 1011
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

yyval73 := yytype73 (yyvs.item (yyvsp)) 
			yyval := yyval73
		end

	yy_do_action_216 is
			--|#line 1015
		local
			yyval33: INSPECT_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 5)))
				yyval33 := new_inspect_as (yytype23 (yyvs.item (yyvsp - 3)), yytype61 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval33
		end

	yy_do_action_218 is
			--|#line 1024
		local
			yyval61: EIFFEL_LIST [CASE_AS]
		do

yyval61 := yytype61 (yyvs.item (yyvsp)) 
			yyval := yyval61
		end

	yy_do_action_219 is
			--|#line 1028
		local
			yyval61: EIFFEL_LIST [CASE_AS]
		do

				yyval61 := new_eiffel_list_case_as (Initial_when_part_list_size)
				yyval61.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_220 is
			--|#line 1033
		local
			yyval61: EIFFEL_LIST [CASE_AS]
		do

				yyval61 := yytype61 (yyvs.item (yyvsp - 1))
				yyval61.extend (yytype11 (yyvs.item (yyvsp)))
			
			yyval := yyval61
		end

	yy_do_action_221 is
			--|#line 1040
		local
			yyval11: CASE_AS
		do

yyval11 := new_case_as (yytype74 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp)), yacc_line_number) 
			yyval := yyval11
		end

	yy_do_action_222 is
			--|#line 1044
		local
			yyval74: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval74 := new_eiffel_list_interval_as (Initial_choices_size)
				yyval74.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval74
		end

	yy_do_action_223 is
			--|#line 1049
		local
			yyval74: EIFFEL_LIST [INTERVAL_AS]
		do

				yyval74 := yytype74 (yyvs.item (yyvsp - 2))
				yyval74.extend (yytype38 (yyvs.item (yyvsp)))
			
			yyval := yyval74
		end

	yy_do_action_224 is
			--|#line 1056
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_225 is
			--|#line 1058
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_226 is
			--|#line 1060
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval38
		end

	yy_do_action_227 is
			--|#line 1062
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_228 is
			--|#line 1064
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype36 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_229 is
			--|#line 1066
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype36 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_230 is
			--|#line 1068
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_231 is
			--|#line 1070
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_232 is
			--|#line 1072
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype30 (yyvs.item (yyvsp - 2)), yytype12 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_233 is
			--|#line 1074
		local
			yyval38: INTERVAL_AS
		do

yyval38 := new_interval_as (yytype12 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp))) 
			yyval := yyval38
		end

	yy_do_action_235 is
			--|#line 1080
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval73 := yytype73 (yyvs.item (yyvsp))
				if yyval73 = Void then
					yyval73 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval73
		end

	yy_do_action_236 is
			--|#line 1089
		local
			yyval40: LOOP_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 9)))
				yyval40 := new_loop_as (yytype73 (yyvs.item (yyvsp - 7)), yytype79 (yyvs.item (yyvsp - 6)), yytype59 (yyvs.item (yyvsp - 5)), yytype23 (yyvs.item (yyvsp - 3)), yytype73 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval40
		end

	yy_do_action_238 is
			--|#line 1098
		local
			yyval79: EIFFEL_LIST [TAGGED_AS]
		do

yyval79 := yytype79 (yyvs.item (yyvsp)) 
			yyval := yyval79
		end

	yy_do_action_240 is
			--|#line 1104
		local
			yyval39: INVARIANT_AS
		do

				id_level := Normal_level
				inherit_context := False
				yyval39 := new_invariant_as (yytype79 (yyvs.item (yyvsp)))
			
			yyval := yyval39
		end

	yy_do_action_241 is
			--|#line 1104
		local

		do
			yyval := yyval_default;
id_level := Invariant_level 

		end

	yy_do_action_243 is
			--|#line 1116
		local
			yyval59: VARIANT_AS
		do

yyval59 := new_variant_as (yytype30 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp)), yacc_position) 
			yyval := yyval59
		end

	yy_do_action_244 is
			--|#line 1118
		local
			yyval59: VARIANT_AS
		do

yyval59 := new_variant_as (Void, yytype23 (yyvs.item (yyvsp)), yacc_position) 
			yyval := yyval59
		end

	yy_do_action_245 is
			--|#line 1122
		local
			yyval19: DEBUG_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 4)))
				yyval19 := new_debug_as (yytype78 (yyvs.item (yyvsp - 2)), yytype73 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval19
		end

	yy_do_action_248 is
			--|#line 1133
		local
			yyval78: EIFFEL_LIST [STRING_AS]
		do

yyval78 := yytype78 (yyvs.item (yyvsp - 1)) 
			yyval := yyval78
		end

	yy_do_action_249 is
			--|#line 1137
		local
			yyval78: EIFFEL_LIST [STRING_AS]
		do

				yyval78 := new_eiffel_list_string_as (Initial_debug_key_list_size)
				yyval78.extend (yytype54 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_250 is
			--|#line 1142
		local
			yyval78: EIFFEL_LIST [STRING_AS]
		do

				yyval78 := yytype78 (yyvs.item (yyvsp - 2))
				yyval78.extend (yytype54 (yyvs.item (yyvsp)))
			
			yyval := yyval78
		end

	yy_do_action_251 is
			--|#line 1149
		local
			yyval49: RETRY_AS
		do

yyval49 := new_retry_as (yacc_line_number) 
			yyval := yyval49
		end

	yy_do_action_253 is
			--|#line 1155
		local
			yyval73: EIFFEL_LIST [INSTRUCTION_AS]
		do

				yyval73 := yytype73 (yyvs.item (yyvsp))
				if yyval73 = Void then
					yyval73 := new_eiffel_list_instruction_as (0)
				end
			
			yyval := yyval73
		end

	yy_do_action_254 is
			--|#line 1164
		local
			yyval5: ASSIGN_AS
		do

yyval5 := new_assign_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval5
		end

	yy_do_action_255 is
			--|#line 1166
		local
			yyval5: ASSIGN_AS
		do

yyval5 := new_assign_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval5
		end

	yy_do_action_256 is
			--|#line 1170
		local
			yyval50: REVERSE_AS
		do

yyval50 := new_reverse_as (new_access_id_as (yytype30 (yyvs.item (yyvsp - 2)), Void), yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval50
		end

	yy_do_action_257 is
			--|#line 1172
		local
			yyval50: REVERSE_AS
		do

yyval50 := new_reverse_as (new_result_as, yytype23 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval50
		end

	yy_do_action_259 is
			--|#line 1178
		local
			yyval62: EIFFEL_LIST [CREATE_AS]
		do

yyval62 := yytype62 (yyvs.item (yyvsp)) 
			yyval := yyval62
		end

	yy_do_action_260 is
			--|#line 1182
		local
			yyval62: EIFFEL_LIST [CREATE_AS]
		do

				yyval62 := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				yyval62.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_261 is
			--|#line 1187
		local
			yyval62: EIFFEL_LIST [CREATE_AS]
		do

				yyval62 := yytype62 (yyvs.item (yyvsp - 1))
				yyval62.extend (yytype16 (yyvs.item (yyvsp)))
			
			yyval := yyval62
		end

	yy_do_action_262 is
			--|#line 1194
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (Void, Void)
			
			yyval := yyval16
		end

	yy_do_action_263 is
			--|#line 1199
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (yytype14 (yyvs.item (yyvsp - 1)), yytype69 (yyvs.item (yyvsp)))
			
			yyval := yyval16
		end

	yy_do_action_264 is
			--|#line 1204
		local
			yyval16: CREATE_AS
		do

				inherit_context := False
				yyval16 := new_create_as (new_client_as (yytype71 (yyvs.item (yyvsp))), Void)
			
			yyval := yyval16
		end

	yy_do_action_265 is
			--|#line 1211
		local
			yyval53: ROUTINE_CREATION_AS
		do

yyval53 := new_routine_creation_as (yytype43 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp - 1)), yytype75 (yyvs.item (yyvsp))) 
			yyval := yyval53
		end

	yy_do_action_266 is
			--|#line 1215
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, yytype30 (yyvs.item (yyvsp - 1)), Void) 
			yyval := yyval43
		end

	yy_do_action_267 is
			--|#line 1217
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp - 2))) 
			yyval := yyval43
		end

	yy_do_action_268 is
			--|#line 1219
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (yytype57 (yyvs.item (yyvsp - 1)), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_270 is
			--|#line 1223
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, Void) 
			yyval := yyval43
		end

	yy_do_action_272 is
			--|#line 1229
		local
			yyval75: EIFFEL_LIST [OPERAND_AS]
		do

yyval75 := yytype75 (yyvs.item (yyvsp - 1)) 
			yyval := yyval75
		end

	yy_do_action_273 is
			--|#line 1233
		local
			yyval75: EIFFEL_LIST [OPERAND_AS]
		do

				yyval75 := new_eiffel_list_operand_as (Initial_operand_list_size)
				yyval75.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_274 is
			--|#line 1238
		local
			yyval75: EIFFEL_LIST [OPERAND_AS]
		do

				yyval75 := yytype75 (yyvs.item (yyvsp - 2))
				yyval75.extend (yytype43 (yyvs.item (yyvsp)))
			
			yyval := yyval75
		end

	yy_do_action_275 is
			--|#line 1245
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, Void) 
			yyval := yyval43
		end

	yy_do_action_276 is
			--|#line 1247
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (Void, Void, yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval43
		end

	yy_do_action_277 is
			--|#line 1249
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_class_type (yytype83 (yyvs.item (yyvsp - 2)), yytype80 (yyvs.item (yyvsp - 1))), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_278 is
			--|#line 1251
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_boolean_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_279 is
			--|#line 1253
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_character_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_280 is
			--|#line 1255
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_double_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_281 is
			--|#line 1257
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_integer_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_282 is
			--|#line 1259
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_none_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_283 is
			--|#line 1261
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_pointer_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_284 is
			--|#line 1263
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (new_real_type (yytype83 (yyvs.item (yyvsp - 2)).second, yytype80 (yyvs.item (yyvsp - 1)) /= Void), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_285 is
			--|#line 1265
		local
			yyval43: OPERAND_AS
		do

yyval43 := new_operand_as (yytype57 (yyvs.item (yyvsp - 1)), Void, Void) 
			yyval := yyval43
		end

	yy_do_action_286 is
			--|#line 1269
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (yytype57 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval17
		end

	yy_do_action_287 is
			--|#line 1271
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (Void, yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval17
		end

	yy_do_action_288 is
			--|#line 1273
		local
			yyval17: CREATION_AS
		do

yyval17 := new_creation_as (yytype57 (yyvs.item (yyvsp - 3)), yytype1 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval17
		end

	yy_do_action_289 is
			--|#line 1277
		local
			yyval18: CREATION_EXPR_AS
		do

yyval18 := new_creation_expr_as (yytype57 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp))) 
			yyval := yyval18
		end

	yy_do_action_290 is
			--|#line 1279
		local
			yyval18: CREATION_EXPR_AS
		do

yyval18 := new_creation_expr_as (yytype57 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp))) 
			yyval := yyval18
		end

	yy_do_action_292 is
			--|#line 1285
		local
			yyval57: TYPE
		do

yyval57 := yytype57 (yyvs.item (yyvsp)) 
			yyval := yyval57
		end

	yy_do_action_293 is
			--|#line 1289
		local
			yyval1: ACCESS_AS
		do

yyval1 := new_access_id_as (yytype30 (yyvs.item (yyvsp)), Void) 
			yyval := yyval1
		end

	yy_do_action_294 is
			--|#line 1291
		local
			yyval1: ACCESS_AS
		do

yyval1 := new_result_as 
			yyval := yyval1
		end

	yy_do_action_296 is
			--|#line 1297
		local
			yyval3: ACCESS_INV_AS
		do

yyval3 := new_access_inv_as (yytype30 (yyvs.item (yyvsp - 1)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval3
		end

	yy_do_action_297 is
			--|#line 1305
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype1 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_298 is
			--|#line 1307
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_299 is
			--|#line 1309
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_300 is
			--|#line 1311
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_301 is
			--|#line 1313
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype42 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_302 is
			--|#line 1315
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype45 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_303 is
			--|#line 1317
		local
			yyval34: INSTR_CALL_AS
		do

yyval34 := new_instr_call_as (yytype41 (yyvs.item (yyvsp)), yacc_position, yacc_line_number) 
			yyval := yyval34
		end

	yy_do_action_304 is
			--|#line 1321
		local
			yyval13: CHECK_AS
		do

				set_position (yytype87 (yyvs.item (yyvsp - 3)))
				yyval13 := new_check_as (yytype79 (yyvs.item (yyvsp - 1)), yacc_position, yacc_line_number)
			
			yyval := yyval13
		end

	yy_do_action_305 is
			--|#line 1332
		local
			yyval23: EXPR_AS
		do

yyval23 := new_value_as (yytype6 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_306 is
			--|#line 1334
		local
			yyval23: EXPR_AS
		do

yyval23 := new_value_as (yytype4 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_307 is
			--|#line 1336
		local
			yyval23: EXPR_AS
		do

yyval23 := new_value_as (yytype56 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_308 is
			--|#line 1338
		local
			yyval23: EXPR_AS
		do

yyval23 := new_expr_call_as (yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_309 is
			--|#line 1340
		local
			yyval23: EXPR_AS
		do

yyval23 := yytype53 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_310 is
			--|#line 1342
		local
			yyval23: EXPR_AS
		do

yyval23 := new_paran_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_311 is
			--|#line 1344
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_plus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_312 is
			--|#line 1346
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_minus_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_313 is
			--|#line 1348
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_star_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_314 is
			--|#line 1350
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_slash_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_315 is
			--|#line 1352
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_mod_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_316 is
			--|#line 1354
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_div_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_317 is
			--|#line 1356
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_power_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_318 is
			--|#line 1358
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_and_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_319 is
			--|#line 1360
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_and_then_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_320 is
			--|#line 1362
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_or_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_321 is
			--|#line 1364
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_or_else_as (yytype23 (yyvs.item (yyvsp - 3)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_322 is
			--|#line 1366
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_implies_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_323 is
			--|#line 1368
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_xor_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_324 is
			--|#line 1370
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_ge_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_325 is
			--|#line 1372
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_gt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_326 is
			--|#line 1374
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_le_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_327 is
			--|#line 1376
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_lt_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_328 is
			--|#line 1378
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_eq_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_329 is
			--|#line 1380
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_ne_as (yytype23 (yyvs.item (yyvsp - 2)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_330 is
			--|#line 1382
		local
			yyval23: EXPR_AS
		do

yyval23 := new_bin_free_as (yytype23 (yyvs.item (yyvsp - 2)), yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_331 is
			--|#line 1384
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_minus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_332 is
			--|#line 1386
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_plus_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_333 is
			--|#line 1388
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_not_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_334 is
			--|#line 1390
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_old_as (yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_335 is
			--|#line 1392
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_free_as (yytype30 (yyvs.item (yyvsp - 1)), yytype23 (yyvs.item (yyvsp))) 
			yyval := yyval23
		end

	yy_do_action_336 is
			--|#line 1394
		local
			yyval23: EXPR_AS
		do

yyval23 := new_un_strip_as (yytype71 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_337 is
			--|#line 1398
		local
			yyval23: EXPR_AS
		do

yyval23 := yytype23 (yyvs.item (yyvsp)) 
			yyval := yyval23
		end

	yy_do_action_338 is
			--|#line 1400
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_as (yytype84 (yyvs.item (yyvsp)).first) 
			yyval := yyval23
		end

	yy_do_action_339 is
			--|#line 1402
		local
			yyval23: EXPR_AS
		do

yyval23 := new_expr_address_as (yytype23 (yyvs.item (yyvsp - 1))) 
			yyval := yyval23
		end

	yy_do_action_340 is
			--|#line 1404
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_current_as 
			yyval := yyval23
		end

	yy_do_action_341 is
			--|#line 1406
		local
			yyval23: EXPR_AS
		do

yyval23 := new_address_result_as 
			yyval := yyval23
		end

	yy_do_action_342 is
			--|#line 1410
		local
			yyval30: ID_AS
		do

yyval30 := new_id_as (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_343 is
			--|#line 1418
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_344 is
			--|#line 1420
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_345 is
			--|#line 1422
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_346 is
			--|#line 1424
		local
			yyval10: CALL_AS
		do

yyval10 := new_current_as 
			yyval := yyval10
		end

	yy_do_action_347 is
			--|#line 1426
		local
			yyval10: CALL_AS
		do

yyval10 := new_result_as 
			yyval := yyval10
		end

	yy_do_action_348 is
			--|#line 1428
		local
			yyval10: CALL_AS
		do

yyval10 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_349 is
			--|#line 1430
		local
			yyval10: CALL_AS
		do

yyval10 := yytype42 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_350 is
			--|#line 1432
		local
			yyval10: CALL_AS
		do

yyval10 := yytype45 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_351 is
			--|#line 1434
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_352 is
			--|#line 1436
		local
			yyval10: CALL_AS
		do

yyval10 := yytype18 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_353 is
			--|#line 1440
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (new_current_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_354 is
			--|#line 1444
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (new_result_as, yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_355 is
			--|#line 1448
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype1 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_356 is
			--|#line 1452
		local
			yyval42: NESTED_EXPR_AS
		do

yyval42 := new_nested_expr_as (yytype23 (yyvs.item (yyvsp - 3)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval42
		end

	yy_do_action_357 is
			--|#line 1456
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype45 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_358 is
			--|#line 1460
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor_as (Void, yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_359 is
			--|#line 1462
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 4)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_360 is
			--|#line 1464
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 2)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_361 is
			--|#line 1466
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_362 is
			--|#line 1468
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_363 is
			--|#line 1470
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_364 is
			--|#line 1472
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_365 is
			--|#line 1474
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_366 is
			--|#line 1476
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_367 is
			--|#line 1478
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_368 is
			--|#line 1480
		local
			yyval45: PRECURSOR_AS
		do

yyval45 := new_precursor (yytype83 (yyvs.item (yyvsp - 3)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval45
		end

	yy_do_action_369 is
			--|#line 1484
		local
			yyval10: CALL_AS
		do

yyval10 := yytype41 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_370 is
			--|#line 1486
		local
			yyval10: CALL_AS
		do

yyval10 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval10
		end

	yy_do_action_371 is
			--|#line 1490
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_372 is
			--|#line 1492
		local
			yyval41: NESTED_AS
		do

yyval41 := new_nested_as (yytype2 (yyvs.item (yyvsp - 2)), yytype41 (yyvs.item (yyvsp))) 
			yyval := yyval41
		end

	yy_do_action_373 is
			--|#line 1496
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

	yy_do_action_374 is
			--|#line 1509
		local
			yyval2: ACCESS_FEAT_AS
		do

yyval2 := new_access_feat_as (yytype30 (yyvs.item (yyvsp - 1)), yytype65 (yyvs.item (yyvsp))) 
			yyval := yyval2
		end

	yy_do_action_377 is
			--|#line 1517
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

yyval65 := yytype65 (yyvs.item (yyvsp - 1)) 
			yyval := yyval65
		end

	yy_do_action_378 is
			--|#line 1521
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := new_eiffel_list_expr_as (Initial_parameter_list_size)
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_379 is
			--|#line 1526
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := yytype65 (yyvs.item (yyvsp - 2))
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_380 is
			--|#line 1533
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

yyval65 := new_eiffel_list_expr_as (0) 
			yyval := yyval65
		end

	yy_do_action_381 is
			--|#line 1535
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

yyval65 := yytype65 (yyvs.item (yyvsp)) 
			yyval := yyval65
		end

	yy_do_action_382 is
			--|#line 1539
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := new_eiffel_list_expr_as (Initial_expression_list_size)
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_383 is
			--|#line 1544
		local
			yyval65: EIFFEL_LIST [EXPR_AS]
		do

				yyval65 := yytype65 (yyvs.item (yyvsp - 2))
				yyval65.extend (yytype23 (yyvs.item (yyvsp)))
			
			yyval := yyval65
		end

	yy_do_action_384 is
			--|#line 1555
		local
			yyval30: ID_AS
		do

yyval30 := new_id_as (token_buffer) 
			yyval := yyval30
		end

	yy_do_action_385 is
			--|#line 1557
		local
			yyval30: ID_AS
		do

yyval30 := new_boolean_id_as 
			yyval := yyval30
		end

	yy_do_action_386 is
			--|#line 1559
		local
			yyval30: ID_AS
		do

yyval30 := new_character_id_as 
			yyval := yyval30
		end

	yy_do_action_387 is
			--|#line 1561
		local
			yyval30: ID_AS
		do

yyval30 := new_double_id_as 
			yyval := yyval30
		end

	yy_do_action_388 is
			--|#line 1563
		local
			yyval30: ID_AS
		do

yyval30 := new_integer_id_as 
			yyval := yyval30
		end

	yy_do_action_389 is
			--|#line 1565
		local
			yyval30: ID_AS
		do

yyval30 := new_none_id_as 
			yyval := yyval30
		end

	yy_do_action_390 is
			--|#line 1567
		local
			yyval30: ID_AS
		do

yyval30 := new_pointer_id_as 
			yyval := yyval30
		end

	yy_do_action_391 is
			--|#line 1569
		local
			yyval30: ID_AS
		do

yyval30 := new_real_id_as 
			yyval := yyval30
		end

	yy_do_action_392 is
			--|#line 1573
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_393 is
			--|#line 1575
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_394 is
			--|#line 1577
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype36 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_395 is
			--|#line 1579
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype46 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_396 is
			--|#line 1581
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_397 is
			--|#line 1583
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_398 is
			--|#line 1587
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_399 is
			--|#line 1589
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_400 is
			--|#line 1591
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

	yy_do_action_401 is
			--|#line 1601
		local
			yyval6: ATOMIC_AS
		do

yyval6 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval6
		end

	yy_do_action_402 is
			--|#line 1603
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_403 is
			--|#line 1605
		local
			yyval6: ATOMIC_AS
		do

yyval6 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval6
		end

	yy_do_action_404 is
			--|#line 1609
		local
			yyval9: BOOL_AS
		do

yyval9 := new_boolean_as (False) 
			yyval := yyval9
		end

	yy_do_action_405 is
			--|#line 1611
		local
			yyval9: BOOL_AS
		do

yyval9 := new_boolean_as (True) 
			yyval := yyval9
		end

	yy_do_action_406 is
			--|#line 1615
		local
			yyval12: CHAR_AS
		do

				check is_character: not token_buffer.empty end
				yyval12 := new_character_as (token_buffer.item (1))
			
			yyval := yyval12
		end

	yy_do_action_407 is
			--|#line 1622
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

	yy_do_action_408 is
			--|#line 1632
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
			--|#line 1642
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

	yy_do_action_410 is
			--|#line 1655
		local
			yyval46: REAL_AS
		do

yyval46 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval46
		end

	yy_do_action_411 is
			--|#line 1657
		local
			yyval46: REAL_AS
		do

yyval46 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval46
		end

	yy_do_action_412 is
			--|#line 1659
		local
			yyval46: REAL_AS
		do

				token_buffer.precede ('-')
				yyval46 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval46
		end

	yy_do_action_413 is
			--|#line 1666
		local
			yyval7: BIT_CONST_AS
		do

yyval7 := new_bit_const_as (new_id_as (token_buffer)) 
			yyval := yyval7
		end

	yy_do_action_414 is
			--|#line 1670
		local
			yyval54: STRING_AS
		do

yyval54 := yytype54 (yyvs.item (yyvsp)) 
			yyval := yyval54
		end

	yy_do_action_415 is
			--|#line 1672
		local
			yyval54: STRING_AS
		do

yyval54 := new_empty_string_as 
			yyval := yyval54
		end

	yy_do_action_416 is
			--|#line 1676
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_417 is
			--|#line 1678
		local
			yyval54: STRING_AS
		do

yyval54 := new_lt_string_as 
			yyval := yyval54
		end

	yy_do_action_418 is
			--|#line 1680
		local
			yyval54: STRING_AS
		do

yyval54 := new_le_string_as 
			yyval := yyval54
		end

	yy_do_action_419 is
			--|#line 1682
		local
			yyval54: STRING_AS
		do

yyval54 := new_gt_string_as 
			yyval := yyval54
		end

	yy_do_action_420 is
			--|#line 1684
		local
			yyval54: STRING_AS
		do

yyval54 := new_ge_string_as 
			yyval := yyval54
		end

	yy_do_action_421 is
			--|#line 1686
		local
			yyval54: STRING_AS
		do

yyval54 := new_minus_string_as 
			yyval := yyval54
		end

	yy_do_action_422 is
			--|#line 1688
		local
			yyval54: STRING_AS
		do

yyval54 := new_plus_string_as 
			yyval := yyval54
		end

	yy_do_action_423 is
			--|#line 1690
		local
			yyval54: STRING_AS
		do

yyval54 := new_star_string_as 
			yyval := yyval54
		end

	yy_do_action_424 is
			--|#line 1692
		local
			yyval54: STRING_AS
		do

yyval54 := new_slash_string_as 
			yyval := yyval54
		end

	yy_do_action_425 is
			--|#line 1694
		local
			yyval54: STRING_AS
		do

yyval54 := new_mod_string_as 
			yyval := yyval54
		end

	yy_do_action_426 is
			--|#line 1696
		local
			yyval54: STRING_AS
		do

yyval54 := new_div_string_as 
			yyval := yyval54
		end

	yy_do_action_427 is
			--|#line 1698
		local
			yyval54: STRING_AS
		do

yyval54 := new_power_string_as 
			yyval := yyval54
		end

	yy_do_action_428 is
			--|#line 1700
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_429 is
			--|#line 1702
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_430 is
			--|#line 1704
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_431 is
			--|#line 1706
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_432 is
			--|#line 1708
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_433 is
			--|#line 1710
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_434 is
			--|#line 1712
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_435 is
			--|#line 1714
		local
			yyval54: STRING_AS
		do

yyval54 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval54
		end

	yy_do_action_436 is
			--|#line 1718
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_minus_string_as) 
			yyval := yyval85
		end

	yy_do_action_437 is
			--|#line 1720
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_plus_string_as) 
			yyval := yyval85
		end

	yy_do_action_438 is
			--|#line 1722
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_not_string_as) 
			yyval := yyval85
		end

	yy_do_action_439 is
			--|#line 1724
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval85
		end

	yy_do_action_440 is
			--|#line 1728
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_lt_string_as) 
			yyval := yyval85
		end

	yy_do_action_441 is
			--|#line 1730
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_le_string_as) 
			yyval := yyval85
		end

	yy_do_action_442 is
			--|#line 1732
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_gt_string_as) 
			yyval := yyval85
		end

	yy_do_action_443 is
			--|#line 1734
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_ge_string_as) 
			yyval := yyval85
		end

	yy_do_action_444 is
			--|#line 1736
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_minus_string_as) 
			yyval := yyval85
		end

	yy_do_action_445 is
			--|#line 1738
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_plus_string_as) 
			yyval := yyval85
		end

	yy_do_action_446 is
			--|#line 1740
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_star_string_as) 
			yyval := yyval85
		end

	yy_do_action_447 is
			--|#line 1742
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_slash_string_as) 
			yyval := yyval85
		end

	yy_do_action_448 is
			--|#line 1744
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_mod_string_as) 
			yyval := yyval85
		end

	yy_do_action_449 is
			--|#line 1746
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_div_string_as) 
			yyval := yyval85
		end

	yy_do_action_450 is
			--|#line 1748
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_power_string_as) 
			yyval := yyval85
		end

	yy_do_action_451 is
			--|#line 1750
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_and_string_as) 
			yyval := yyval85
		end

	yy_do_action_452 is
			--|#line 1752
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_and_then_string_as) 
			yyval := yyval85
		end

	yy_do_action_453 is
			--|#line 1754
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_implies_string_as) 
			yyval := yyval85
		end

	yy_do_action_454 is
			--|#line 1756
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_or_string_as) 
			yyval := yyval85
		end

	yy_do_action_455 is
			--|#line 1758
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_or_else_string_as) 
			yyval := yyval85
		end

	yy_do_action_456 is
			--|#line 1760
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_xor_string_as) 
			yyval := yyval85
		end

	yy_do_action_457 is
			--|#line 1762
		local
			yyval85: PAIR [STRING_AS, CLICK_AST]
		do

yyval85 := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) 
			yyval := yyval85
		end

	yy_do_action_458 is
			--|#line 1766
		local
			yyval4: ARRAY_AS
		do

yyval4 := new_array_as (yytype65 (yyvs.item (yyvsp - 1))) 
			yyval := yyval4
		end

	yy_do_action_459 is
			--|#line 1770
		local
			yyval56: TUPLE_AS
		do

yyval56 := new_tuple_as (yytype65 (yyvs.item (yyvsp - 1))) 
			yyval := yyval56
		end

	yy_do_action_460 is
			--|#line 1774
		local

		do
			yyval := yyval_default;
set_position (current_position) 

		end

	yy_do_action_461 is
			--|#line 1778
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
			  188,  188,  188,  188,  188,  188,  257,  258,  258,  191,
			  221,  221,  220,  220,  222,  222,  156,  163,  163,  230,

			  230,  232,  232,  231,  231,  234,  234,  233,  233,  236,
			  236,  235,  235,  266,  266,  267,  267,  268,  268,  211,
			  243,  243,  244,  244,  206,  206,  196,  292,  195,  195,
			  195,  159,  160,  293,  200,  200,  175,  175,  269,  269,
			  248,  248,  249,  249,  172,  294,  294,  173,  173,  173,
			  173,  173,  173,  173,  173,  173,  173,  192,  192,  296,
			  192,  297,  155,  155,  298,  155,  299,  261,  261,  262,
			  262,  202,  203,  203,  203,  205,  205,  210,  210,  210,
			  210,  210,  210,  207,  207,  207,  207,  207,  207,  207,
			  207,  264,  264,  264,  265,  265,  238,  238,  239,  239,

			  240,  240,  164,  300,  208,  208,  237,  237,  168,  218,
			  218,  219,  219,  154,  250,  250,  170,  214,  214,  215,
			  215,  143,  252,  252,  176,  176,  176,  176,  176,  176,
			  176,  176,  176,  176,  251,  251,  178,  263,  263,  177,
			  177,  301,  212,  212,  212,  153,  259,  259,  259,  260,
			  260,  193,  247,  247,  134,  134,  194,  194,  216,  216,
			  217,  217,  150,  150,  150,  197,  185,  185,  185,  185,
			  185,  253,  253,  254,  254,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  151,  151,  151,  152,
			  152,  209,  209,  129,  129,  132,  132,  171,  171,  171,

			  171,  171,  171,  171,  145,  157,  157,  157,  157,  157,
			  157,  157,  157,  157,  157,  157,  157,  157,  157,  157,
			  157,  157,  157,  157,  157,  157,  157,  157,  157,  157,
			  157,  157,  157,  157,  157,  157,  157,  158,  158,  158,
			  158,  158,  167,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  183,  182,  181,  184,  180,  189,  189,
			  189,  189,  189,  189,  189,  189,  189,  189,  189,  141,
			  141,  179,  179,  130,  131,  223,  223,  223,  224,  224,
			  225,  225,  226,  226,  165,  165,  165,  165,  165,  165,
			  165,  165,  136,  136,  136,  136,  136,  136,  137,  137,

			  137,  137,  137,  137,  140,  140,  144,  174,  174,  174,
			  190,  190,  190,  138,  199,  199,  201,  201,  201,  201,
			  201,  201,  201,  201,  201,  201,  201,  201,  201,  201,
			  201,  201,  201,  201,  201,  201,  284,  284,  284,  284,
			  283,  283,  283,  283,  283,  283,  283,  283,  283,  283,
			  283,  283,  283,  283,  283,  283,  283,  283,  133,  204,
			  295,  286>>)
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
			    8,    7,    6,    5,    4,    3,    2,    1,    3,    3,
			    0,    1,    2,    2,    1,    2,    3,    1,    1,    1,

			    3,    0,    1,    1,    2,    0,    1,    1,    2,    0,
			    1,    1,    2,    0,    3,    0,    1,    1,    2,    4,
			    1,    3,    0,    1,    0,    2,    8,    0,    1,    1,
			    1,    3,    2,    0,    0,    2,    2,    2,    0,    2,
			    1,    2,    1,    2,    3,    0,    2,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    0,    3,    0,
			    4,    0,    0,    3,    0,    4,    0,    0,    1,    1,
			    2,    3,    1,    3,    2,    1,    1,    3,    3,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    0,    2,    3,    1,    3,    0,    3,    0,    1,

			    1,    3,    4,    0,    0,    2,    0,    3,    8,    0,
			    1,    1,    2,    4,    0,    2,    6,    0,    1,    1,
			    2,    4,    1,    3,    1,    1,    1,    3,    3,    3,
			    3,    3,    3,    3,    0,    2,   10,    0,    2,    0,
			    3,    0,    0,    4,    2,    5,    0,    2,    3,    1,
			    3,    1,    0,    2,    3,    3,    3,    3,    0,    1,
			    1,    2,    1,    3,    2,    3,    2,    4,    3,    2,
			    1,    0,    3,    1,    3,    1,    1,    4,    4,    4,
			    4,    4,    4,    4,    4,    3,    5,    3,    6,    5,
			    4,    0,    1,    1,    1,    0,    3,    1,    1,    1,

			    1,    1,    1,    1,    4,    1,    1,    1,    1,    1,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    4,
			    3,    4,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    2,    2,    2,    2,    2,    4,    1,    2,    4,
			    2,    2,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    3,    3,    3,    5,    3,    2,    7,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    1,
			    1,    3,    3,    2,    2,    0,    2,    3,    1,    3,
			    0,    1,    1,    3,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    2,    2,
			    1,    2,    2,    1,    1,    1,    1,    1,    1,    1,
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
			   18,   25,   31,  391,  390,  389,  388,  387,  386,  385,
			  384,    0,    0,   21,   25,   34,   33,   32,    0,   24,
			  435,  434,  433,  432,  431,  430,  429,  428,  427,  426,
			  425,  424,  423,  422,  421,  420,  419,  418,  417,  415,
			  405,  404,   28,  413,  416,  410,  406,  407,    0,    0,
			   26,   30,  396,  392,  393,   29,  394,  395,  397,  414,
			   53,   22,    0,  412,  409,  411,  408,    0,   54,   23,
			   17,   16,   15,   14,   13,   12,   11,   10,  196,    2,
			    3,    4,    5,    6,    7,    8,    9,   27,  198,   35,
			  203,  200,    0,  199,    0,   72,  204,  197,    0,   36,

			   53,  258,    0,  206,  201,   75,   77,   73,  191,   74,
			  262,  260,   37,  259,  205,  191,  191,  191,  191,  191,
			  191,  191,  191,    0,  202,   78,   76,    0,   79,    0,
			    0,  264,   44,   59,   39,  239,   38,  261,  183,  184,
			  185,  186,  187,  188,  189,  190,    0,    0,    0,   61,
			   62,   63,   99,    0,    0,    0,  192,    0,  194,  175,
			  176,    0,  103,  111,    0,  107,   53,   85,  101,  105,
			  109,    0,   90,   47,   49,    0,  263,   45,   60,   51,
			   59,   56,  113,    0,  241,    0,   40,  439,  438,  437,
			  436,   65,  457,  456,  455,  454,  453,  452,  451,  450,

			  449,  448,  447,  446,  445,  444,  443,  442,  441,  440,
			   64,  207,    0,  191,  182,  181,  191,    0,    0,  180,
			  179,  193,    0,  104,  112,   87,   86,    0,  108,   94,
			   92,    0,   93,  102,  105,  106,  109,  110,    0,   84,
			   91,  101,   48,    0,   43,   46,   52,   59,  115,   53,
			  124,   58,  460,    1,  100,  178,  177,  195,    0,    0,
			   95,   97,   53,   98,  109,    0,   83,  105,   50,   57,
			  120,  117,    0,    0,  116,   55,    0,   67,  169,  240,
			  460,    0,   88,   89,   96,    0,   82,  109,    0,    0,
			  114,  118,  125,   35,   66,  170,    0,  347,  375,  346,

			  380,    0,  380,    0,  270,    0,  401,  400,    0,    0,
			    0,    0,  342,    0,    0,  348,  306,  305,  402,  398,
			  308,  399,  352,  172,  375,    0,  351,  345,  344,  343,
			  349,    0,  350,  309,  403,   53,  307,   81,    0,  121,
			   53,   70,   69,   68,   71,  127,  269,    0,    0,    0,
			  358,    0,  382,  375,    0,  381,    0,    0,  191,  191,
			  191,  191,  191,  191,  191,  191,    0,    0,    0,    0,
			  334,  122,  333,  331,  332,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  174,  266,  373,  335,  271,    0,

			  171,   80,  119,  157,  370,  354,  375,  369,    0,    0,
			  376,  337,  378,    0,  353,  459,    0,    0,  268,    0,
			    0,    0,    0,    0,    0,    0,    0,  458,    0,  295,
			  310,  123,    0,  355,  317,  316,  315,  314,  313,  312,
			  311,  324,  326,  325,  327,  328,  329,    0,  318,  323,
			    0,  320,  322,  330,  173,    0,  265,  357,  159,  138,
			    0,  374,  375,  341,  340,    0,  338,  377,    0,  383,
			    0,  375,  375,  375,  375,  375,  375,  375,  375,  295,
			    0,  290,  267,    0,  336,  319,  321,  275,    0,  276,
			  273,    0,  161,  460,  115,    0,  371,  372,  360,    0,

			  379,    0,  361,  362,  363,  364,  365,  366,  367,  368,
			  289,  375,  356,  176,  191,  191,  191,  191,  191,  191,
			  191,  191,  272,    0,  460,  158,  139,  145,  133,  145,
			  130,  129,  128,  162,  339,  375,  296,  285,  183,  184,
			  185,  186,  187,  188,  189,  190,  274,  160,  137,  460,
			  134,    0,  136,  164,  252,  359,  277,  278,  279,  280,
			  281,  282,  283,  284,  146,  142,  460,  461,    0,  131,
			  132,  166,  460,  145,    0,  143,  251,    0,    0,    0,
			    0,  291,    0,  297,  149,  155,  147,  154,  375,  151,
			  152,  148,  145,  153,  303,  299,  298,  300,  301,  302,

			  156,  150,    0,  135,  460,  163,  253,  126,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  294,    0,
			  295,  293,  292,    0,    0,    0,    0,  144,    0,    0,
			  145,  246,  460,  165,  255,  257,    0,  287,    0,    0,
			  254,  256,  217,    0,  237,    0,  145,    0,    0,  295,
			    0,  219,  234,  218,  145,  460,  242,  247,  249,    0,
			    0,  304,  295,  286,  225,  226,  224,  222,    0,  145,
			    0,  220,  209,  238,    0,    0,  248,    0,  245,  288,
			    0,    0,    0,  145,    0,  235,  216,    0,  211,  214,
			  210,  244,  375,    0,  250,  231,  233,  232,  230,  229,

			  228,  227,  221,  223,    0,  145,    0,  212,    0,    0,
			  145,  215,  208,  243,  145,  213,    0,  236,    0,    0,
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
			  561, 1605,   -7, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  594, 1507, -32768,  747, -32768, -32768, -32768,  575, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  131,   13,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  103, -32768,  908, -32768, -32768, -32768, -32768, 1622, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  565, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  537,  529,
			 -32768, -32768,  542,  549,  711,  513,  538, -32768,  537, -32768,

			  766,  524,  908,  528, -32768, -32768,  531,  908,  495, -32768,
			  281, -32768,  484,  524, -32768,  495,  495,  495,  495,  495,
			  495,  495,  495,  469, -32768, -32768, -32768, 1726,   47,  358,
			  469, 1735, -32768,  304, -32768,  490,  484, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  -33, 1884,   38, -32768,
			 -32768, -32768, -32768,  908,  890,  908, -32768,  217, -32768, -32768,
			 -32768,  121,  469,  469,  469,  469,  109, -32768,  435,  422,
			  400,  488,  496, -32768, -32768,  125,  480,  486, -32768, -32768,
			  288, -32768,   89,  469, -32768,  485, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  469,  495, -32768, -32768,  495,  511,  507, -32768,
			 -32768, -32768, 1770,  480,  480, -32768,  494,  481,  480, -32768,
			  486,  323, -32768, -32768,  422, -32768,  400, -32768,  465, -32768,
			 -32768,  435, -32768,  898, -32768, -32768, -32768,  452,  898,  440,
			  483, -32768,  204, -32768, -32768, -32768, -32768, -32768,  469,  469,
			 -32768, -32768,  440,  480,  400,  455, -32768,  422, -32768, -32768,
			 -32768, -32768,  276,  461,  898, -32768, 1770,  421, -32768, -32768,
			 1465, 1469, -32768, -32768, -32768,  431, -32768,  400,  898, 1770,
			 -32768, -32768, -32768,  482, -32768, -32768,  357,  460,   48,  309,

			 1469, 1719, 1469,  445, -32768, 1770, -32768, -32768, 1469, 1469,
			  454, 1469, -32768, 1469, 1469,  302, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, 2013,  218, 1469, -32768, -32768, -32768, -32768,
			 -32768,  898,  263, -32768, -32768,  440, -32768, -32768,  414, -32768,
			  440, -32768, -32768, -32768, -32768, -32768, -32768,  898,  908,  862,
			 -32768,  898, 2013,   46,  427,  434,  908,  372,  251,  235,
			  230,  224,  213,  206,  192,  172,  428, 1770,  380, 1972,
			 -32768,  898, -32768, -32768, -32768,  898, 1469, 1469, 1469, 1469,
			 1469, 1469, 1469, 1469, 1469, 1469, 1469, 1469, 1469, 1354,
			 1469, 1239, 1469, 1469, 1469, -32768, -32768, -32768,  388,  898,

			 -32768, -32768, -32768,  324,  369, -32768,  335, -32768,  365,  831,
			 -32768, 2013, -32768,  143, -32768, -32768, 1469,  363, -32768,  386,
			  383,  374,  373,  352,  351,  349,  348, -32768,  360,  175,
			  126,  362,  359, -32768,  280,  280,  280,  280,  280,  540,
			  540,  677,  677,  677,  677,  677,  677, 1469, 2058, 2044,
			 1469, 2029, 1953, -32768, 2013, 1009, -32768, -32768,  339,  320,
			  898, -32768,  335, -32768, -32768, 1469, -32768, -32768, 1124, 2013,
			  353,  335,  335,  335,  335,  335,  335,  335,  335,  175,
			  898, -32768, -32768,  898, -32768, 2058, 2029,  357, 1719, -32768,
			 -32768,  135, -32768,  408,  898,   29,  369, -32768, -32768, 1931,

			 -32768,  298, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  335, -32768,  334,  251,  235,  230,  224,  213,  206,
			  192,  172, -32768, 1009,  408, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,  327, -32768,  335, -32768, -32768,  333,  332,
			  331,  330,  325,  321,  318,  317, -32768, -32768, -32768, 1817,
			  322,  959, -32768,  260,  255, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  719,  617,  959, -32768,
			 -32768, -32768,  -49, -32768,  283, -32768, -32768,   36,  309,   15,
			  684, 1770, 1469,  302, -32768, -32768, -32768, -32768,   21, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  263,

			 -32768, -32768,   96, -32768,  -49, -32768, -32768, -32768, 1469, 1469,
			  290,  289,  287,  286,  282,  272,  267,  258, -32768, 1770,
			  175, -32768, -32768,  250, 1913, 1469, 1469,  242, 1469, 1469,
			 -32768,  248,  204, -32768, 2013, 2013,  209, -32768,  315,  223,
			 2013, 2013, 1179, 1411,  168,  328, -32768,  141,  315,  175,
			  159, -32768,  181,  137, -32768,  118,  130, -32768, -32768,   43,
			  138, -32768,  175, -32768,  190,  187,  107, -32768,  -17, -32768,
			  106, -32768,   73, -32768, 1469,   88, -32768,  959, -32768, -32768,
			    1,  159,  217, -32768,  159, -32768, -32768, 1469, -32768,   83,
			   73, 2013,  196, 1469, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, 1299, -32768,   62, -32768, 1469, 1670,
			 -32768, -32768, -32768, 2013, -32768, -32768,   28, -32768,   33,   26,
			 -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -513,  148,  254, -463, -32768, -32768,  645,  418, -32768,    0,
			 -32768,   -3, -334, -32768,   57,  -10, -32768,  532, -32768, -32768,
			 -32768,  592, -32768, -32768, -32768,   16, -32768,  474,  237, -330,
			 -32768, -32768,  523,  564, -32768,  601,   -1, -32768,  316, -32768,
			  668, -32768, -32768,  111, -32768, -156, -32768,   -6, -32768, -32768,
			  216,  105,  102,  100,   99,   97, -32768,  142,  556, -32768,
			   94, -32768,  402, -32768, -32768, -32768, -32768, -32768, -32768,  366,
			   -9, -32768, -529,  377, -32768, -32768, -109, -32768,  554, -32768,
			 -32768,  166,  381, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  479, -32768, -32768, -166, -32768,  346, -32768, -32768, -32768,

			 -32768,  -94,  518,  404,  516, -197,  514, -208, -32768, -32768,
			 -32768, -32768, -102, -32768,  264, -32768, -32768, -32768, -32768, -352,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -473, -32768, -32768,  221, -32768, -32768,  147, -32768,
			 -32768,  -57,  -64,  -72,  -75,  -78,  -81,  -92,  -95,  -98,
			 -32768, -32768, -158,  391, -32768, -32768, -32768, -32768, -32768, -32768,
			  -86, -32768, -32768, -32768, -32768,   44, -504, -32768, -32768, -32768,
			 -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   11,  220,   54,   58,  122,   78,  227,  121,  131,   53,
			  120,   55,   52,   11,  109, -167,  510,  414,  158,  412,
			  525,  119,  570,  684,  118,  251,  720,  117,  265,  122,
			  116,   46,  121,  719,   10,  120,  176,  264,  115,  603,
			 -167,  433,   66,  108,   65,  567,  119,  349,   77,  118,
			  108,  547,  117,   17,  254,  116,  285,   54,   58,   16,
			  356,  347,  567,  115,   53,  457,   55,   52,  223,  224,
			  287,  228,  349,  626,  349,  245,  625,  683,  212,  338,
			  232,  190,  189,  677,  395,   99,   15,  676,  609,  530,
			  529,  608,  717,  348,  188,  187,  213,  528,  216,  605,

			  227,  283,  211,    9,    8,    7,    6,    5,    4,    3,
			  682,  167,  527,  257,  166,  248,  658,   76,   75,   74,
			   73,   72,   71,   70,  122,  649,  712,  121,  174,  247,
			  120,  633,  350,  165,  164,  662,  687,  263,  500,  163,
			   68,  119,  162,   67,  118,  705,   68,  117,  694,  512,
			  116,  483,  632,  215,  129,  631,  219,  637,  115,  647,
			   64,  222,   63,  275,  482,  243,  630,  292,  629,  221,
			  686,  242,  628,  218,  217,  523,  284,  552,  122,  522,
			  340,  121,  673,  468,  120,  693,  663,  467,   47,   46,
			  681,  122,   10,  680,  121,  119,  368,  120,  118,  679,

			  480,  117,  678,  365,  116,  661,  364,  122,  119,  363,
			  121,  118,  115,  120,  117, -167, -167,  116,  426,  127,
			  362,  606,  349,  361,  119,  115,  360,  118,  674,  359,
			  117,  218,  217,  116,  395,  708,  650,  358,  425,  127,
			  461,  115,  268,  669,  349,  655,   47,  270,  483,  400,
			   10,  466,  424,  127,  402,  648,  395,  394,  428,  423,
			  127,    9,    8,    7,    6,    5,    4,    3, -167,  122,
			  422,  127,  121,  270,  645,  120,  421,  127,  644,  564,
			  324,  420,  127,   54,   58,  638,  119,  339,  399,  118,
			   53,  408,  117,   52,  660,  116,  498,  419,  127,  417,

			  376,  312,  672,  115,  426,  502,  503,  504,  505,  506,
			  507,  508,  509,  425,  -45,  289,  288,  685,  424,    9,
			    8,    7,    6,    5,    4,    3,  129,  375,  423,  128,
			  398,  702,  422,  421,  351,  420,  419,  139,  140,  141,
			  142,  143,  144,  145,  573,  536,  406,  607,   10,  568,
			  406,  261,  -42,  711,  571,  -45,   77,  -42,  715,  178,
			   44,  349,  716,  563,  562,  -42,  -45,  561,  -41,  555,
			  270,  560,  657,  -41,  406,  178,  559,  558,  557,  556,
			  537,  -41,  535,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  521,   10,  553,  520,  460,  346,  519,  147,  406,  501,

			  494,  492,  288,  484,  173,  618,  479,  518,  146,  470,
			  517,  462,  458,  516,  455,  429,  515,    9,    8,    7,
			    6,    5,    4,    3,  514,   76,   75,   74,   73,   72,
			   71,   70,  478,  477,  255,  476,  475,  256,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   22,   21,   20,  474,  473,  406,
			    9,    8,    7,    6,    5,    4,    3,  472, -167, -167,
			  471,  427,  622,  418,  416,  415, -167,   68,  401,  511,
			  371,  617,  406,  122,  616,  347,  121,  615, -167,  120,
			  367, -167,  163,  270,  666,  337,   49,   48,  614,  293,

			  119,  613,   77,  118,  612,  290,  117,  611,  165,  116,
			  636,   47,   46,   45,   44,  610,   43,  115,  323,  286,
			  212,  122,  276,  178,  121,  699,  701,  120,  666,  266,
			  162,  129,   41,   40,  258,  259,   66,  352,  119,  352,
			   64,  118,  127,  147,  117,  369,  370,  116,  372,  253,
			  373,  374,  239,  132,  146,  115,  380,  379,  378,  377,
			  376,  312,  397,  166,   94,  110,  588,  184,  125,  123,
			   90,   76,   75,   74,   73,   72,   71,   70,  341,  621,
			  139,  140,  141,  142,  143,  144,  145,  102,  100,   98,
			   97,   39,   38,   37,   36,   35,   34,   33,   32,   31,

			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,
			   20,   94,   88,  434,  435,  436,  437,  438,  439,  440,
			  441,  442,  443,  444,  445,  446,  448,  449,  451,  452,
			  453,  454,   62,   19,    1,  431,  627,  621,  269,  393,
			  664,  526,  171,  582,  170,  267,  169,  621,  366,  665,
			   10,  240,  581,  469,  513,  291,  114,  295,  580,  345,
			  282,  599,  579,  126,  598,  546,  597,  596,  393,  595,
			  695,  697,  594,  692,  664,  578,  497,  575,  703,  696,
			  698,  700,   61,  665,  485,  393,  393,  486,  393,  393,
			  393,  382,  381,  380,  379,  378,  377,  376,  312,  104,

			  186,  298,  499,  246,  260,  137,  707,  577,  576,  244,
			  671,  342,   87,  393,  496,  583,    0,   10,    0,    9,
			    8,    7,    6,    5,    4,    3,    0,  393,    0,  619,
			    0,    0,    0,    0,    0,  538,  539,  540,  541,  542,
			  543,  544,  545,   44,    0,    0,    0,    0,    0,    0,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,    0,  393,  393,    0,  393,  393,  393,
			  393,    0,    0,    0,  618,    0,    0,    0,    0,    0,
			   10, -141, -141, -141, -141,  393,    9,    8,    7,    6,
			    5,    4,    3,    0,    0,    0, -141,    0,    0,   77,

			    0,  393,  393,   68,  -19,    0,    0,  -19, -141,    0,
			    0,    0,    0,  -19,    0,  393, -141, -141, -141,  624,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   22,   21,   20,
			  -19,    0,    0,    0,    0,  634,  635,    0,    0,    9,
			    8,    7,    6,    5,    4,    3,    0,  465,    0,    0,
			    0,    0,  640,  641,   77,  642,  643,    0,   76,   75,
			   74,   73,   72,   71,   70,    0,  314,  313,    0,    0,
			    0,    0,    0,  312,  311,  310,  309,    0,  308,  464,
			    0,  307,   46,  306,   44,   10,   43,  305,    0,    0,

			  304,    0,    0,  303,  302,  147,  410,  301,    0,  300,
			    0,  691,   41,   40,    0,  409,  146,    0,    0,    0,
			  299,  463,    0,   10,  704,    0,    0,    0,    0,    0,
			  709,   10,    0,   76,   75,   74,   73,   72,   71,   70,
			  393,   77,    0,    0,    0,  713,  298,    0,  214,    0,
			  393,  393,  297,    0,    0,    0,  393,  393,  393,  393,
			    0,    0,  296,    0,    9,    8,    7,    6,    5,    4,
			    3,   39,   38,   37,   36,   35,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,
			   20,   44,    9,    8,    7,    6,    5,    4,    3,    0,

			    9,    8,    7,    6,    5,    4,    3,  393,    0,    0,
			   76,   75,   74,   73,   72,   71,   70,    0,    0,    0,
			  393,    0,    0,  314,  313,  393,    0,    0,    0,  393,
			  312,  311,  310,  309,    0,  308,    0,    0,  307,   46,
			  306,   44,   10,   43,  305,    0,    0,  304,    0,    0,
			  303,  302,    0,    0,  488,    0,  300,    0,    0,   41,
			   40,    0,  409,    0,    0,    0,    0,  299,    0,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,   20,    0,    0,
			    0,    0,    0,  298,    0,    0,    0,    0,    0,  297,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,  487,
			    0,    9,    8,    7,    6,    5,    4,    3,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,   20,  314,  313,
			    0,    0,    0,    0,    0,  312,  311,  310,  309,    0,
			  308,    0,    0,  307,   46,  306,   44,   10,   43,  305,
			    0,    0,  304,    0,    0,  303,  302,    0,    0,  301,
			    0,  300,    0,    0,   41,   40,    0,  409,    0,    0,
			    0,    0,  299,  392,  391,  390,  389,  388,  387,  386,
			  385,  384,  383,  382,  381,  380,  379,  378,  377,  376,

			  312,    0,    0,    0,    0,    0,    0,    0,  298,    0,
			    0,    0,    0,    0,  297,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  296,    0,    9,    8,    7,    6,
			    5,    4,    3,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   22,   21,   20,  314,  313,    0,    0,    0,    0,    0,
			  312,  311,  310,  309,    0,  308,    0,    0,  307,   46,
			  306,   44,   10,   43,  305,    0,    0,  304,  650,    0,
			  303,  302,    0,    0,  301,    0,  300,    0,    0,   41,
			   40,    0,    0,    0,    0,    0,    0,  299,    0,    0,

			    0,  450,    0,  392,  391,  390,  389,  388,  387,  386,
			  385,  384,  383,  382,  381,  380,  379,  378,  377,  376,
			  312,    0,    0,  298,    0,    0,    0,    0,    0,  297,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  296,
			    0,    9,    8,    7,    6,    5,    4,    3,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,   20,  314,  313,
			    0,    0,    0,    0,    0,  312,  311,  310,  309,    0,
			  308,    0,    0,  307,   46,  306,   44,   10,   43,  305,
			    0,    0,  304,  710,    0,  303,  302,    0,    0,  301,

			    0,  300,    0,    0,   41,   40,    0,    0,    0,    0,
			    0,    0,  299,    0,    0,  392,  391,  390,  389,  388,
			  387,  386,  385,  384,  383,  382,  381,  380,  379,  378,
			  377,  376,  312,    0,    0,    0,    0,    0,  298,    0,
			    0,    0,    0,    0,  297,    0,    0,    0,  447,    0,
			    0,    0,    0,    0,  296,    0,    9,    8,    7,    6,
			    5,    4,    3,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   22,   21,   20,  314,  313,    0,    0,    0,    0,    0,
			  312,  311,  310,  309,    0,  308,    0,    0,  307,   46,

			  306,   44,   10,   43,  305,  654,    0,  304,    0,    0,
			  303,  302,    0,    0,  301,    0,  300,    0,    0,   41,
			   40,   49,   48,    0,    0, -168, -168,  299,    0, -168,
			    0,    0,    0, -168,    0,    0,   47,   46,   45,   44,
			   10,   43,    0,    0,   42, -168,    0,    0, -168,    0,
			    0,    0,    0,  298, -168,    0,    0,   41,   40,  297,
			    0,    0, -168, -168,    0,    0,    0,    0,    0,  296,
			    0,    9,    8,    7,    6,    5,    4,    3,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,   20,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    9,
			    8,    7,    6,    5,    4,    3,   39,   38,   37,   36,
			   35,   34,   33,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,   22,   21,   20,   49,   48,   10,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   47,   46,   45,   44,   10,   43,    0,    0,    0,
			    0,    0,  -20,    0,    0,  -20,    0,    0,    0,    0,
			    0,  -20,   41,   40,  392,  391,  390,  389,  388,  387,
			  386,  385,  384,  383,  382,  381,  380,  379,  378,  377,
			  376,  312,    0,    0,    0,    0,    0,    0,  -20,    0,

			    0,    0,    0,    0,    0,    0,    0,    9,    8,    7,
			    6,    5,    4,    3,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    9,    8,    7,    6,    5,    4,
			    3,   39,   38,   37,   36,   35,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,
			   20,  714,   77,    0,    0,  157,    0,    0,    0,   77,
			    0,    0,  157,    0,  356,    0,    0,    0,  -46,    0,
			    0,    0,    0,    0,  156,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  155,    0,    0,    0,    0,
			    0,    0,  155,    0,    0,    0,    0,    0,  154,    0,

			    0,    0,    0,   77,    0,  154,  157,    0,    0,  -46,
			    0,    0,  153,    0,    0,    0,    0,    0,    0,  153,
			  -46,   76,   75,   74,   73,   72,   71,   70,   76,   75,
			   74,   73,   72,   71,   70,    0,  155,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,    0,    0,    0,    0,    0,  154,
			    0,    0,    0,    0,  564,    0,    0,    0,    0,    0,
			    0,    0,    0,  153,    0,    0,    0,    0,    0,    0,
			    0,    0,   76,   75,   74,   73,   72,   71,   70, -140,
			 -140, -140, -140,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0, -140,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0, -140,    0,    0,    0,
			    0,    0,    0,    0, -140, -140, -140,  392,  391,  390,
			  389,  388,  387,  386,  385,  384,  383,  382,  381,  380,
			  379,  378,  377,  376,  312,  392,  391,  390,  389,  388,
			  387,  386,  385,  384,  383,  382,  381,  380,  379,  378,
			  377,  376,  312,    0,    0,    0,    0,  639,  391,  390,
			  389,  388,  387,  386,  385,  384,  383,  382,  381,  380,
			  379,  378,  377,  376,  312,  534,  392,  391,  390,  389,
			  388,  387,  386,  385,  384,  383,  382,  381,  380,  379,
			  378,  377,  376,  312,  209,  208,  207,  206,  205,  204,

			  203,  202,  201,  200,  199,  198,  197,  196,  195,  194,
			  193,    0,  192,    0,    0,    0,  430,  392,  391,  390,
			  389,  388,  387,  386,  385,  384,  383,  382,  381,  380,
			  379,  378,  377,  376,  312,  390,  389,  388,  387,  386,
			  385,  384,  383,  382,  381,  380,  379,  378,  377,  376,
			  312,  389,  388,  387,  386,  385,  384,  383,  382,  381,
			  380,  379,  378,  377,  376,  312,  388,  387,  386,  385,
			  384,  383,  382,  381,  380,  379,  378,  377,  376,  312>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,  157,   12,   12,  102,   62,  164,  102,  110,   12,
			  102,   12,   12,   14,  100,   64,  479,  351,  127,  349,
			  493,  102,  551,   40,  102,  183,    0,  102,  236,  127,
			  102,   30,  127,    0,   33,  127,  130,  234,  102,  568,
			   89,  375,   29,  100,   31,  549,  127,   26,   33,  127,
			  107,  524,  127,   60,  212,  127,  264,   67,   67,   66,
			   45,   25,  566,  127,   67,  399,   67,   67,  162,  163,
			  267,  165,   26,   52,   26,  177,   55,   94,   40,  287,
			  166,  114,  115,   40,   38,   94,   93,   44,   52,   60,
			   61,   55,   64,   45,  127,  128,  153,   68,  155,  572,

			  258,  259,   64,  102,  103,  104,  105,  106,  107,  108,
			    3,   64,   83,  222,   67,   26,  645,  102,  103,  104,
			  105,  106,  107,  108,  222,  638,   64,  222,  129,   40,
			  222,  604,  298,   86,   87,  648,   63,  231,  468,   92,
			   37,  222,   95,   40,  222,   62,   37,  222,  677,  483,
			  222,   25,   56,  154,   45,   59,  157,  620,  222,  632,
			   29,   40,   31,  249,   38,   40,   70,  276,   72,   48,
			   64,   46,   76,   14,   15,   40,  262,  529,  276,   44,
			  289,  276,  655,   40,  276,   97,  649,   44,   29,   30,
			    3,  289,   33,    3,  289,  276,  305,  289,  276,  662,

			   25,  276,   64,  301,  276,   64,  301,  305,  289,  301,
			  305,  289,  276,  305,  289,   97,   98,  289,   46,   47,
			  301,  573,   26,  301,  305,  289,  301,  305,   98,  301,
			  305,   14,   15,  305,   38,   39,   99,  301,   46,   47,
			  406,  305,  243,   62,   26,   77,   29,  248,   25,  335,
			   33,  409,   46,   47,  340,   46,   38,   39,  367,   46,
			   47,  102,  103,  104,  105,  106,  107,  108,   64,  367,
			   46,   47,  367,  274,   26,  367,   46,   47,  630,   37,
			  281,   46,   47,  293,  293,   35,  367,  288,   25,  367,
			  293,  348,  367,  293,  646,  367,  462,   46,   47,  356,

			   20,   21,  654,  367,   46,  471,  472,  473,  474,  475,
			  476,  477,  478,   46,   33,   39,   40,  669,   46,  102,
			  103,  104,  105,  106,  107,  108,   45,   25,   46,  108,
			  331,  683,   46,   46,   25,   46,   46,  116,  117,  118,
			  119,  120,  121,  122,   89,  511,  347,   64,   33,   27,
			  351,   28,   64,  705,   94,   74,   33,   69,  710,   71,
			   32,   26,  714,   46,   46,   77,   85,   46,   64,  535,
			  371,   46,   44,   69,  375,   71,   46,   46,   46,   46,
			   46,   77,   84,  102,  103,  104,  105,  106,  107,  108,
			  488,   33,   65,  488,   25,   38,  488,   74,  399,   46,

			   80,   62,   40,   44,   46,   90,   46,  488,   85,   46,
			  488,   46,   88,  488,   26,   35,  488,  102,  103,  104,
			  105,  106,  107,  108,  488,  102,  103,  104,  105,  106,
			  107,  108,   84,   84,  213,   84,   84,  216,  110,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,   84,   84,  460,
			  102,  103,  104,  105,  106,  107,  108,   84,   60,   61,
			   84,   43,  581,  101,   40,   48,   68,   37,   64,  480,
			   26,  579,  483,  581,  579,   25,  581,  579,   80,  581,
			   45,   83,   92,  494,  650,   64,   14,   15,  579,   78,

			  581,  579,   33,  581,  579,   44,  581,  579,   86,  581,
			  619,   29,   30,   31,   32,  579,   34,  581,  281,   64,
			   40,  619,   39,   71,  619,  681,  682,  619,  684,   64,
			   95,   45,   50,   51,   40,   54,   29,  300,  619,  302,
			   29,  619,   47,   74,  619,  308,  309,  619,  311,   64,
			  313,  314,   64,   69,   85,  619,   16,   17,   18,   19,
			   20,   21,  325,   67,   82,   41,  567,   77,   37,   41,
			   33,  102,  103,  104,  105,  106,  107,  108,   96,  580,
			  359,  360,  361,  362,  363,  364,  365,   49,   75,   40,
			   48,  109,  110,  111,  112,  113,  114,  115,  116,  117,

			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,   82,   47,  376,  377,  378,  379,  380,  381,  382,
			  383,  384,  385,  386,  387,  388,  389,  390,  391,  392,
			  393,  394,   57,   39,   73,  371,  592,  638,  247,  323,
			  650,  494,  128,   26,  128,  241,  128,  648,  302,  650,
			   33,  172,   35,  416,  488,  274,  102,  280,   41,  293,
			  258,  567,   45,  107,  567,  523,  567,  567,  352,  567,
			  680,  681,  567,  674,  684,   58,  460,  566,  684,  680,
			  681,  682,   14,  684,  447,  369,  370,  450,  372,  373,
			  374,   14,   15,   16,   17,   18,   19,   20,   21,   98,

			  136,   84,  465,  180,  230,  113,  690,   90,   91,  177,
			  653,  293,   67,  397,  460,  567,    0,   33,    0,  102,
			  103,  104,  105,  106,  107,  108,    0,  411,    0,   45,
			    0,    0,    0,    0,    0,  514,  515,  516,  517,  518,
			  519,  520,  521,   32,    0,    0,    0,    0,    0,    0,
			  434,  435,  436,  437,  438,  439,  440,  441,  442,  443,
			  444,  445,  446,    0,  448,  449,    0,  451,  452,  453,
			  454,    0,    0,    0,   90,    0,    0,    0,    0,    0,
			   33,   62,   63,   64,   65,  469,  102,  103,  104,  105,
			  106,  107,  108,    0,    0,    0,   77,    0,    0,   33,

			    0,  485,  486,   37,   57,    0,    0,   60,   89,    0,
			    0,    0,    0,   66,    0,  499,   97,   98,   99,  582,
			  109,  110,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			   93,    0,    0,    0,    0,  608,  609,    0,    0,  102,
			  103,  104,  105,  106,  107,  108,    0,   26,    0,    0,
			    0,    0,  625,  626,   33,  628,  629,    0,  102,  103,
			  104,  105,  106,  107,  108,    0,   14,   15,    0,    0,
			    0,    0,    0,   21,   22,   23,   24,    0,   26,   58,
			    0,   29,   30,   31,   32,   33,   34,   35,    0,    0,

			   38,    0,    0,   41,   42,   74,   44,   45,    0,   47,
			    0,  674,   50,   51,    0,   53,   85,    0,    0,    0,
			   58,   90,    0,   33,  687,    0,    0,    0,    0,    0,
			  693,   33,    0,  102,  103,  104,  105,  106,  107,  108,
			  624,   33,    0,    0,    0,  708,   84,    0,   58,    0,
			  634,  635,   90,    0,    0,    0,  640,  641,  642,  643,
			    0,    0,  100,    0,  102,  103,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,   32,  102,  103,  104,  105,  106,  107,  108,    0,

			  102,  103,  104,  105,  106,  107,  108,  691,    0,    0,
			  102,  103,  104,  105,  106,  107,  108,    0,    0,    0,
			  704,    0,    0,   14,   15,  709,    0,    0,    0,  713,
			   21,   22,   23,   24,    0,   26,    0,    0,   29,   30,
			   31,   32,   33,   34,   35,    0,    0,   38,    0,    0,
			   41,   42,    0,    0,   45,    0,   47,    0,    0,   50,
			   51,    0,   53,    0,    0,    0,    0,   58,    0,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,    0,    0,
			    0,    0,    0,   84,    0,    0,    0,    0,    0,   90,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,  100,
			    0,  102,  103,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,   14,   15,
			    0,    0,    0,    0,    0,   21,   22,   23,   24,    0,
			   26,    0,    0,   29,   30,   31,   32,   33,   34,   35,
			    0,    0,   38,    0,    0,   41,   42,    0,    0,   45,
			    0,   47,    0,    0,   50,   51,    0,   53,    0,    0,
			    0,    0,   58,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,

			   21,    0,    0,    0,    0,    0,    0,    0,   84,    0,
			    0,    0,    0,    0,   90,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  100,    0,  102,  103,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,   14,   15,    0,    0,    0,    0,    0,
			   21,   22,   23,   24,    0,   26,    0,    0,   29,   30,
			   31,   32,   33,   34,   35,    0,    0,   38,   99,    0,
			   41,   42,    0,    0,   45,    0,   47,    0,    0,   50,
			   51,    0,    0,    0,    0,    0,    0,   58,    0,    0,

			    0,   62,    0,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,    0,    0,   84,    0,    0,    0,    0,    0,   90,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  100,
			    0,  102,  103,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,   14,   15,
			    0,    0,    0,    0,    0,   21,   22,   23,   24,    0,
			   26,    0,    0,   29,   30,   31,   32,   33,   34,   35,
			    0,    0,   38,   94,    0,   41,   42,    0,    0,   45,

			    0,   47,    0,    0,   50,   51,    0,    0,    0,    0,
			    0,    0,   58,    0,    0,    4,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,    0,    0,    0,    0,    0,   84,    0,
			    0,    0,    0,    0,   90,    0,    0,    0,   94,    0,
			    0,    0,    0,    0,  100,    0,  102,  103,  104,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,   14,   15,    0,    0,    0,    0,    0,
			   21,   22,   23,   24,    0,   26,    0,    0,   29,   30,

			   31,   32,   33,   34,   35,   94,    0,   38,    0,    0,
			   41,   42,    0,    0,   45,    0,   47,    0,    0,   50,
			   51,   14,   15,    0,    0,   60,   61,   58,    0,   64,
			    0,    0,    0,   68,    0,    0,   29,   30,   31,   32,
			   33,   34,    0,    0,   37,   80,    0,    0,   83,    0,
			    0,    0,    0,   84,   89,    0,    0,   50,   51,   90,
			    0,    0,   97,   98,    0,    0,    0,    0,    0,  100,
			    0,  102,  103,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,  102,
			  103,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,   14,   15,   33,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   29,   30,   31,   32,   33,   34,    0,    0,    0,
			    0,    0,   57,    0,    0,   60,    0,    0,    0,    0,
			    0,   66,   50,   51,    4,    5,    6,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,    0,    0,    0,    0,    0,    0,   93,    0,

			    0,    0,    0,    0,    0,    0,    0,  102,  103,  104,
			  105,  106,  107,  108,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  102,  103,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,   81,   33,    0,    0,   36,    0,    0,    0,   33,
			    0,    0,   36,    0,   45,    0,    0,    0,   33,    0,
			    0,    0,    0,    0,   48,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   66,    0,    0,    0,    0,
			    0,    0,   66,    0,    0,    0,    0,    0,   79,    0,

			    0,    0,    0,   33,    0,   79,   36,    0,    0,   74,
			    0,    0,   93,    0,    0,    0,    0,    0,    0,   93,
			   85,  102,  103,  104,  105,  106,  107,  108,  102,  103,
			  104,  105,  106,  107,  108,    0,   66,  102,  103,  104,
			  105,  106,  107,  108,    0,    0,    0,    0,    0,   79,
			    0,    0,    0,    0,   37,    0,    0,    0,    0,    0,
			    0,    0,    0,   93,    0,    0,    0,    0,    0,    0,
			    0,    0,  102,  103,  104,  105,  106,  107,  108,   62,
			   63,   64,   65,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   77,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,   89,    0,    0,    0,
			    0,    0,    0,    0,   97,   98,   99,    4,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,    4,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,    0,    0,    0,    0,   44,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   44,    4,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,  110,  111,  112,  113,  114,  115,

			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,    0,  128,    0,    0,    0,   44,    4,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,    8,    9,   10,   11,
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

	yyNtbase: INTEGER is 129
			-- Number of tokens

	yyLast: INTEGER is 2079
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
