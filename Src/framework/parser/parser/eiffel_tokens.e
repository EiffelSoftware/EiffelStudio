indexing

	description: "Parser token codes"
	generator: "geyacc version 3.6"

class EIFFEL_TOKENS

inherit

	YY_PARSER_TOKENS

feature -- Last values

	last_any_value: ANY
	last_symbol_as_value: SYMBOL_AS
	last_keyword_as_value: KEYWORD_AS
	last_id_as_value: ID_AS
	last_char_as_value: CHAR_AS
	last_bool_as_value: BOOL_AS
	last_result_as_value: RESULT_AS
	last_retry_as_value: RETRY_AS
	last_unique_as_value: UNIQUE_AS
	last_current_as_value: CURRENT_AS
	last_deferred_as_value: DEFERRED_AS
	last_void_as_value: VOID_AS

feature -- Access

	token_name (a_token: INTEGER): STRING is
			-- Name of token `a_token'
		do
			inspect a_token
			when 0 then
				Result := "EOF token"
			when -1 then
				Result := "Error token"
			when TE_ASSIGNMENT then
				Result := "TE_ASSIGNMENT"
			when TE_DOTDOT then
				Result := "TE_DOTDOT"
			when TE_IMPLIES then
				Result := "TE_IMPLIES"
			when TE_OR then
				Result := "TE_OR"
			when TE_XOR then
				Result := "TE_XOR"
			when TE_AND then
				Result := "TE_AND"
			when TE_TILDE then
				Result := "TE_TILDE"
			when TE_NOT_TILDE then
				Result := "TE_NOT_TILDE"
			when TE_NE then
				Result := "TE_NE"
			when TE_EQ then
				Result := "TE_EQ"
			when TE_LT then
				Result := "TE_LT"
			when TE_GT then
				Result := "TE_GT"
			when TE_LE then
				Result := "TE_LE"
			when TE_GE then
				Result := "TE_GE"
			when TE_PLUS then
				Result := "TE_PLUS"
			when TE_MINUS then
				Result := "TE_MINUS"
			when TE_STAR then
				Result := "TE_STAR"
			when TE_SLASH then
				Result := "TE_SLASH"
			when TE_MOD then
				Result := "TE_MOD"
			when TE_DIV then
				Result := "TE_DIV"
			when TE_POWER then
				Result := "TE_POWER"
			when TE_FREE then
				Result := "TE_FREE"
			when TE_NOT then
				Result := "TE_NOT"
			when TE_STRIP then
				Result := "TE_STRIP"
			when TE_OLD then
				Result := "TE_OLD"
			when TE_DOT then
				Result := "TE_DOT"
			when TE_LPARAN then
				Result := "TE_LPARAN"
			when TE_ID then
				Result := "TE_ID"
			when TE_TUPLE then
				Result := "TE_TUPLE"
			when TE_A_BIT then
				Result := "TE_A_BIT"
			when TE_INTEGER then
				Result := "TE_INTEGER"
			when TE_REAL then
				Result := "TE_REAL"
			when TE_CHAR then
				Result := "TE_CHAR"
			when TE_LSQURE then
				Result := "TE_LSQURE"
			when TE_RSQURE then
				Result := "TE_RSQURE"
			when TE_ACCEPT then
				Result := "TE_ACCEPT"
			when TE_ADDRESS then
				Result := "TE_ADDRESS"
			when TE_CURLYTILDE then
				Result := "TE_CURLYTILDE"
			when TE_LARRAY then
				Result := "TE_LARRAY"
			when TE_RARRAY then
				Result := "TE_RARRAY"
			when TE_RPARAN then
				Result := "TE_RPARAN"
			when TE_LCURLY then
				Result := "TE_LCURLY"
			when TE_RCURLY then
				Result := "TE_RCURLY"
			when TE_BANG then
				Result := "TE_BANG"
			when TE_SEMICOLON then
				Result := "TE_SEMICOLON"
			when TE_COLON then
				Result := "TE_COLON"
			when TE_COMMA then
				Result := "TE_COMMA"
			when TE_CONSTRAIN then
				Result := "TE_CONSTRAIN"
			when TE_QUESTION then
				Result := "TE_QUESTION"
			when TE_FALSE then
				Result := "TE_FALSE"
			when TE_TRUE then
				Result := "TE_TRUE"
			when TE_RESULT then
				Result := "TE_RESULT"
			when TE_RETRY then
				Result := "TE_RETRY"
			when TE_UNIQUE then
				Result := "TE_UNIQUE"
			when TE_CURRENT then
				Result := "TE_CURRENT"
			when TE_DEFERRED then
				Result := "TE_DEFERRED"
			when TE_VOID then
				Result := "TE_VOID"
			when TE_END then
				Result := "TE_END"
			when TE_FROZEN then
				Result := "TE_FROZEN"
			when TE_PARTIAL_CLASS then
				Result := "TE_PARTIAL_CLASS"
			when TE_INFIX then
				Result := "TE_INFIX"
			when TE_CREATION then
				Result := "TE_CREATION"
			when TE_PRECURSOR then
				Result := "TE_PRECURSOR"
			when TE_PREFIX then
				Result := "TE_PREFIX"
			when TE_IS then
				Result := "TE_IS"
			when TE_AGENT then
				Result := "TE_AGENT"
			when TE_ALIAS then
				Result := "TE_ALIAS"
			when TE_ALL then
				Result := "TE_ALL"
			when TE_AS then
				Result := "TE_AS"
			when TE_ASSIGN then
				Result := "TE_ASSIGN"
			when TE_BIT then
				Result := "TE_BIT"
			when TE_CHECK then
				Result := "TE_CHECK"
			when TE_CLASS then
				Result := "TE_CLASS"
			when TE_CONVERT then
				Result := "TE_CONVERT"
			when TE_CREATE then
				Result := "TE_CREATE"
			when TE_DEBUG then
				Result := "TE_DEBUG"
			when TE_DO then
				Result := "TE_DO"
			when TE_ELSE then
				Result := "TE_ELSE"
			when TE_ELSEIF then
				Result := "TE_ELSEIF"
			when TE_ENSURE then
				Result := "TE_ENSURE"
			when TE_EXPANDED then
				Result := "TE_EXPANDED"
			when TE_EXPORT then
				Result := "TE_EXPORT"
			when TE_EXTERNAL then
				Result := "TE_EXTERNAL"
			when TE_FEATURE then
				Result := "TE_FEATURE"
			when TE_FROM then
				Result := "TE_FROM"
			when TE_IF then
				Result := "TE_IF"
			when TE_INDEXING then
				Result := "TE_INDEXING"
			when TE_INHERIT then
				Result := "TE_INHERIT"
			when TE_INSPECT then
				Result := "TE_INSPECT"
			when TE_INVARIANT then
				Result := "TE_INVARIANT"
			when TE_LIKE then
				Result := "TE_LIKE"
			when TE_LOCAL then
				Result := "TE_LOCAL"
			when TE_LOOP then
				Result := "TE_LOOP"
			when TE_NOTE then
				Result := "TE_NOTE"
			when TE_OBSOLETE then
				Result := "TE_OBSOLETE"
			when TE_ONCE then
				Result := "TE_ONCE"
			when TE_ONCE_STRING then
				Result := "TE_ONCE_STRING"
			when TE_REDEFINE then
				Result := "TE_REDEFINE"
			when TE_REFERENCE then
				Result := "TE_REFERENCE"
			when TE_RENAME then
				Result := "TE_RENAME"
			when TE_REQUIRE then
				Result := "TE_REQUIRE"
			when TE_RESCUE then
				Result := "TE_RESCUE"
			when TE_SELECT then
				Result := "TE_SELECT"
			when TE_SEPARATE then
				Result := "TE_SEPARATE"
			when TE_THEN then
				Result := "TE_THEN"
			when TE_UNDEFINE then
				Result := "TE_UNDEFINE"
			when TE_UNTIL then
				Result := "TE_UNTIL"
			when TE_VARIANT then
				Result := "TE_VARIANT"
			when TE_WHEN then
				Result := "TE_WHEN"
			when TE_STRING then
				Result := "TE_STRING"
			when TE_EMPTY_STRING then
				Result := "TE_EMPTY_STRING"
			when TE_VERBATIM_STRING then
				Result := "TE_VERBATIM_STRING"
			when TE_EMPTY_VERBATIM_STRING then
				Result := "TE_EMPTY_VERBATIM_STRING"
			when TE_STR_LT then
				Result := "TE_STR_LT"
			when TE_STR_LE then
				Result := "TE_STR_LE"
			when TE_STR_GT then
				Result := "TE_STR_GT"
			when TE_STR_GE then
				Result := "TE_STR_GE"
			when TE_STR_MINUS then
				Result := "TE_STR_MINUS"
			when TE_STR_PLUS then
				Result := "TE_STR_PLUS"
			when TE_STR_STAR then
				Result := "TE_STR_STAR"
			when TE_STR_SLASH then
				Result := "TE_STR_SLASH"
			when TE_STR_MOD then
				Result := "TE_STR_MOD"
			when TE_STR_DIV then
				Result := "TE_STR_DIV"
			when TE_STR_POWER then
				Result := "TE_STR_POWER"
			when TE_STR_AND then
				Result := "TE_STR_AND"
			when TE_STR_AND_THEN then
				Result := "TE_STR_AND_THEN"
			when TE_STR_IMPLIES then
				Result := "TE_STR_IMPLIES"
			when TE_STR_OR then
				Result := "TE_STR_OR"
			when TE_STR_OR_ELSE then
				Result := "TE_STR_OR_ELSE"
			when TE_STR_XOR then
				Result := "TE_STR_XOR"
			when TE_STR_NOT then
				Result := "TE_STR_NOT"
			when TE_STR_FREE then
				Result := "TE_STR_FREE"
			when TE_STR_BRACKET then
				Result := "TE_STR_BRACKET"
			else
				Result := yy_character_token_name (a_token)
			end
		end

feature -- Token codes

	TE_ASSIGNMENT: INTEGER is 258
	TE_DOTDOT: INTEGER is 259
	TE_IMPLIES: INTEGER is 260
	TE_OR: INTEGER is 261
	TE_XOR: INTEGER is 262
	TE_AND: INTEGER is 263
	TE_TILDE: INTEGER is 264
	TE_NOT_TILDE: INTEGER is 265
	TE_NE: INTEGER is 266
	TE_EQ: INTEGER is 267
	TE_LT: INTEGER is 268
	TE_GT: INTEGER is 269
	TE_LE: INTEGER is 270
	TE_GE: INTEGER is 271
	TE_PLUS: INTEGER is 272
	TE_MINUS: INTEGER is 273
	TE_STAR: INTEGER is 274
	TE_SLASH: INTEGER is 275
	TE_MOD: INTEGER is 276
	TE_DIV: INTEGER is 277
	TE_POWER: INTEGER is 278
	TE_FREE: INTEGER is 279
	TE_NOT: INTEGER is 280
	TE_STRIP: INTEGER is 281
	TE_OLD: INTEGER is 282
	TE_DOT: INTEGER is 283
	TE_LPARAN: INTEGER is 284
	TE_ID: INTEGER is 285
	TE_TUPLE: INTEGER is 286
	TE_A_BIT: INTEGER is 287
	TE_INTEGER: INTEGER is 288
	TE_REAL: INTEGER is 289
	TE_CHAR: INTEGER is 290
	TE_LSQURE: INTEGER is 291
	TE_RSQURE: INTEGER is 292
	TE_ACCEPT: INTEGER is 293
	TE_ADDRESS: INTEGER is 294
	TE_CURLYTILDE: INTEGER is 295
	TE_LARRAY: INTEGER is 296
	TE_RARRAY: INTEGER is 297
	TE_RPARAN: INTEGER is 298
	TE_LCURLY: INTEGER is 299
	TE_RCURLY: INTEGER is 300
	TE_BANG: INTEGER is 301
	TE_SEMICOLON: INTEGER is 302
	TE_COLON: INTEGER is 303
	TE_COMMA: INTEGER is 304
	TE_CONSTRAIN: INTEGER is 305
	TE_QUESTION: INTEGER is 306
	TE_FALSE: INTEGER is 307
	TE_TRUE: INTEGER is 308
	TE_RESULT: INTEGER is 309
	TE_RETRY: INTEGER is 310
	TE_UNIQUE: INTEGER is 311
	TE_CURRENT: INTEGER is 312
	TE_DEFERRED: INTEGER is 313
	TE_VOID: INTEGER is 314
	TE_END: INTEGER is 315
	TE_FROZEN: INTEGER is 316
	TE_PARTIAL_CLASS: INTEGER is 317
	TE_INFIX: INTEGER is 318
	TE_CREATION: INTEGER is 319
	TE_PRECURSOR: INTEGER is 320
	TE_PREFIX: INTEGER is 321
	TE_IS: INTEGER is 322
	TE_AGENT: INTEGER is 323
	TE_ALIAS: INTEGER is 324
	TE_ALL: INTEGER is 325
	TE_AS: INTEGER is 326
	TE_ASSIGN: INTEGER is 327
	TE_BIT: INTEGER is 328
	TE_CHECK: INTEGER is 329
	TE_CLASS: INTEGER is 330
	TE_CONVERT: INTEGER is 331
	TE_CREATE: INTEGER is 332
	TE_DEBUG: INTEGER is 333
	TE_DO: INTEGER is 334
	TE_ELSE: INTEGER is 335
	TE_ELSEIF: INTEGER is 336
	TE_ENSURE: INTEGER is 337
	TE_EXPANDED: INTEGER is 338
	TE_EXPORT: INTEGER is 339
	TE_EXTERNAL: INTEGER is 340
	TE_FEATURE: INTEGER is 341
	TE_FROM: INTEGER is 342
	TE_IF: INTEGER is 343
	TE_INDEXING: INTEGER is 344
	TE_INHERIT: INTEGER is 345
	TE_INSPECT: INTEGER is 346
	TE_INVARIANT: INTEGER is 347
	TE_LIKE: INTEGER is 348
	TE_LOCAL: INTEGER is 349
	TE_LOOP: INTEGER is 350
	TE_NOTE: INTEGER is 351
	TE_OBSOLETE: INTEGER is 352
	TE_ONCE: INTEGER is 353
	TE_ONCE_STRING: INTEGER is 354
	TE_REDEFINE: INTEGER is 355
	TE_REFERENCE: INTEGER is 356
	TE_RENAME: INTEGER is 357
	TE_REQUIRE: INTEGER is 358
	TE_RESCUE: INTEGER is 359
	TE_SELECT: INTEGER is 360
	TE_SEPARATE: INTEGER is 361
	TE_THEN: INTEGER is 362
	TE_UNDEFINE: INTEGER is 363
	TE_UNTIL: INTEGER is 364
	TE_VARIANT: INTEGER is 365
	TE_WHEN: INTEGER is 366
	TE_STRING: INTEGER is 367
	TE_EMPTY_STRING: INTEGER is 368
	TE_VERBATIM_STRING: INTEGER is 369
	TE_EMPTY_VERBATIM_STRING: INTEGER is 370
	TE_STR_LT: INTEGER is 371
	TE_STR_LE: INTEGER is 372
	TE_STR_GT: INTEGER is 373
	TE_STR_GE: INTEGER is 374
	TE_STR_MINUS: INTEGER is 375
	TE_STR_PLUS: INTEGER is 376
	TE_STR_STAR: INTEGER is 377
	TE_STR_SLASH: INTEGER is 378
	TE_STR_MOD: INTEGER is 379
	TE_STR_DIV: INTEGER is 380
	TE_STR_POWER: INTEGER is 381
	TE_STR_AND: INTEGER is 382
	TE_STR_AND_THEN: INTEGER is 383
	TE_STR_IMPLIES: INTEGER is 384
	TE_STR_OR: INTEGER is 385
	TE_STR_OR_ELSE: INTEGER is 386
	TE_STR_XOR: INTEGER is 387
	TE_STR_NOT: INTEGER is 388
	TE_STR_FREE: INTEGER is 389
	TE_STR_BRACKET: INTEGER is 390

end
