note

	description: "Parser token codes"
	generator: "geyacc version 3.9"

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
	last_keyword_id_value: TUPLE [KEYWORD_AS, ID_AS, INTEGER, INTEGER, STRING]
	last_string_as_value: STRING_AS

feature -- Access

	token_name (a_token: INTEGER): STRING
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
			when TE_ASSIGN then
				Result := "TE_ASSIGN"
			when TE_ATTRIBUTE then
				Result := "TE_ATTRIBUTE"
			when TE_ATTACHED then
				Result := "TE_ATTACHED"
			when TE_DETACHABLE then
				Result := "TE_DETACHABLE"
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

	TE_ASSIGNMENT: INTEGER = 258
	TE_DOTDOT: INTEGER = 259
	TE_IMPLIES: INTEGER = 260
	TE_OR: INTEGER = 261
	TE_XOR: INTEGER = 262
	TE_AND: INTEGER = 263
	TE_TILDE: INTEGER = 264
	TE_NOT_TILDE: INTEGER = 265
	TE_NE: INTEGER = 266
	TE_EQ: INTEGER = 267
	TE_LT: INTEGER = 268
	TE_GT: INTEGER = 269
	TE_LE: INTEGER = 270
	TE_GE: INTEGER = 271
	TE_PLUS: INTEGER = 272
	TE_MINUS: INTEGER = 273
	TE_STAR: INTEGER = 274
	TE_SLASH: INTEGER = 275
	TE_MOD: INTEGER = 276
	TE_DIV: INTEGER = 277
	TE_POWER: INTEGER = 278
	TE_FREE: INTEGER = 279
	TE_NOT: INTEGER = 280
	TE_STRIP: INTEGER = 281
	TE_OLD: INTEGER = 282
	TE_DOT: INTEGER = 283
	TE_LPARAN: INTEGER = 284
	TE_ID: INTEGER = 285
	TE_TUPLE: INTEGER = 286
	TE_A_BIT: INTEGER = 287
	TE_INTEGER: INTEGER = 288
	TE_REAL: INTEGER = 289
	TE_CHAR: INTEGER = 290
	TE_LSQURE: INTEGER = 291
	TE_RSQURE: INTEGER = 292
	TE_ACCEPT: INTEGER = 293
	TE_ADDRESS: INTEGER = 294
	TE_LARRAY: INTEGER = 295
	TE_RARRAY: INTEGER = 296
	TE_RPARAN: INTEGER = 297
	TE_LCURLY: INTEGER = 298
	TE_RCURLY: INTEGER = 299
	TE_BANG: INTEGER = 300
	TE_SEMICOLON: INTEGER = 301
	TE_COLON: INTEGER = 302
	TE_COMMA: INTEGER = 303
	TE_CONSTRAIN: INTEGER = 304
	TE_QUESTION: INTEGER = 305
	TE_FALSE: INTEGER = 306
	TE_TRUE: INTEGER = 307
	TE_RESULT: INTEGER = 308
	TE_RETRY: INTEGER = 309
	TE_UNIQUE: INTEGER = 310
	TE_CURRENT: INTEGER = 311
	TE_DEFERRED: INTEGER = 312
	TE_VOID: INTEGER = 313
	TE_END: INTEGER = 314
	TE_FROZEN: INTEGER = 315
	TE_PARTIAL_CLASS: INTEGER = 316
	TE_INFIX: INTEGER = 317
	TE_CREATION: INTEGER = 318
	TE_PRECURSOR: INTEGER = 319
	TE_PREFIX: INTEGER = 320
	TE_IS: INTEGER = 321
	TE_AGENT: INTEGER = 322
	TE_ALIAS: INTEGER = 323
	TE_ALL: INTEGER = 324
	TE_AS: INTEGER = 325
	TE_BIT: INTEGER = 326
	TE_CHECK: INTEGER = 327
	TE_CLASS: INTEGER = 328
	TE_CONVERT: INTEGER = 329
	TE_CREATE: INTEGER = 330
	TE_DEBUG: INTEGER = 331
	TE_DO: INTEGER = 332
	TE_ELSE: INTEGER = 333
	TE_ELSEIF: INTEGER = 334
	TE_ENSURE: INTEGER = 335
	TE_EXPANDED: INTEGER = 336
	TE_EXPORT: INTEGER = 337
	TE_EXTERNAL: INTEGER = 338
	TE_FEATURE: INTEGER = 339
	TE_FROM: INTEGER = 340
	TE_IF: INTEGER = 341
	TE_INDEXING: INTEGER = 342
	TE_INHERIT: INTEGER = 343
	TE_INSPECT: INTEGER = 344
	TE_INVARIANT: INTEGER = 345
	TE_LIKE: INTEGER = 346
	TE_LOCAL: INTEGER = 347
	TE_LOOP: INTEGER = 348
	TE_NOTE: INTEGER = 349
	TE_OBSOLETE: INTEGER = 350
	TE_ONCE: INTEGER = 351
	TE_ONCE_STRING: INTEGER = 352
	TE_REDEFINE: INTEGER = 353
	TE_REFERENCE: INTEGER = 354
	TE_RENAME: INTEGER = 355
	TE_REQUIRE: INTEGER = 356
	TE_RESCUE: INTEGER = 357
	TE_SELECT: INTEGER = 358
	TE_SEPARATE: INTEGER = 359
	TE_THEN: INTEGER = 360
	TE_UNDEFINE: INTEGER = 361
	TE_UNTIL: INTEGER = 362
	TE_VARIANT: INTEGER = 363
	TE_WHEN: INTEGER = 364
	TE_ASSIGN: INTEGER = 365
	TE_ATTRIBUTE: INTEGER = 366
	TE_ATTACHED: INTEGER = 367
	TE_DETACHABLE: INTEGER = 368
	TE_STRING: INTEGER = 369
	TE_EMPTY_STRING: INTEGER = 370
	TE_VERBATIM_STRING: INTEGER = 371
	TE_EMPTY_VERBATIM_STRING: INTEGER = 372
	TE_STR_LT: INTEGER = 373
	TE_STR_LE: INTEGER = 374
	TE_STR_GT: INTEGER = 375
	TE_STR_GE: INTEGER = 376
	TE_STR_MINUS: INTEGER = 377
	TE_STR_PLUS: INTEGER = 378
	TE_STR_STAR: INTEGER = 379
	TE_STR_SLASH: INTEGER = 380
	TE_STR_MOD: INTEGER = 381
	TE_STR_DIV: INTEGER = 382
	TE_STR_POWER: INTEGER = 383
	TE_STR_AND: INTEGER = 384
	TE_STR_AND_THEN: INTEGER = 385
	TE_STR_IMPLIES: INTEGER = 386
	TE_STR_OR: INTEGER = 387
	TE_STR_OR_ELSE: INTEGER = 388
	TE_STR_XOR: INTEGER = 389
	TE_STR_NOT: INTEGER = 390
	TE_STR_FREE: INTEGER = 391
	TE_STR_BRACKET: INTEGER = 392

end
