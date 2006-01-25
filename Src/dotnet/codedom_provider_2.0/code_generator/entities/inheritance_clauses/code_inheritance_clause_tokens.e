indexing

	description: "Parser token codes"
	generator: "geyacc version 3.3"

class CODE_INHERITANCE_CLAUSE_TOKENS

inherit

	YY_PARSER_TOKENS

feature -- Last values

	last_any_value: ANY

feature -- Access

	token_name (a_token: INTEGER): STRING is
			-- Name of token `a_token'
		do
			inspect a_token
			when 0 then
				Result := "EOF token"
			when -1 then
				Result := "Error token"
			when TE_ALL then
				Result := "TE_ALL"
			when TE_SEMICOLON then
				Result := "TE_SEMICOLON"
			when TE_COMMA then
				Result := "TE_COMMA"
			when TE_ID then
				Result := "TE_ID"
			when TE_END then
				Result := "TE_END"
			when TE_AS then
				Result := "TE_AS"
			when TE_EXPANDED then
				Result := "TE_EXPANDED"
			when TE_EXPORT then
				Result := "TE_EXPORT"
			when TE_INHERIT then
				Result := "TE_INHERIT"
			when TE_REDEFINE then
				Result := "TE_REDEFINE"
			when TE_RENAME then
				Result := "TE_RENAME"
			when TE_LSQURE then
				Result := "TE_LSQURE"
			when TE_RSQURE then
				Result := "TE_RSQURE"
			when TE_SELECT then
				Result := "TE_SELECT"
			when TE_UNDEFINE then
				Result := "TE_UNDEFINE"
			when TE_INFIX then
				Result := "TE_INFIX"
			when TE_PREFIX then
				Result := "TE_PREFIX"
			when TE_LCURLY then
				Result := "TE_LCURLY"
			when TE_RCURLY then
				Result := "TE_RCURLY"
			when TE_SEPARATE then
				Result := "TE_SEPARATE"
			when TE_BIT then
				Result := "TE_BIT"
			when TE_LIKE then
				Result := "TE_LIKE"
			when TE_CURRENT then
				Result := "TE_CURRENT"
			when TE_INTEGER then
				Result := "TE_INTEGER"
			when TE_PLUS then
				Result := "TE_PLUS"
			when TE_MINUS then
				Result := "TE_MINUS"
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
			else
				Result := yy_character_token_name (a_token)
			end
		end

feature -- Token codes

	TE_ALL: INTEGER is 258
	TE_SEMICOLON: INTEGER is 259
	TE_COMMA: INTEGER is 260
	TE_ID: INTEGER is 261
	TE_END: INTEGER is 262
	TE_AS: INTEGER is 263
	TE_EXPANDED: INTEGER is 264
	TE_EXPORT: INTEGER is 265
	TE_INHERIT: INTEGER is 266
	TE_REDEFINE: INTEGER is 267
	TE_RENAME: INTEGER is 268
	TE_LSQURE: INTEGER is 269
	TE_RSQURE: INTEGER is 270
	TE_SELECT: INTEGER is 271
	TE_UNDEFINE: INTEGER is 272
	TE_INFIX: INTEGER is 273
	TE_PREFIX: INTEGER is 274
	TE_LCURLY: INTEGER is 275
	TE_RCURLY: INTEGER is 276
	TE_SEPARATE: INTEGER is 277
	TE_BIT: INTEGER is 278
	TE_LIKE: INTEGER is 279
	TE_CURRENT: INTEGER is 280
	TE_INTEGER: INTEGER is 281
	TE_PLUS: INTEGER is 282
	TE_MINUS: INTEGER is 283
	TE_STR_LT: INTEGER is 284
	TE_STR_LE: INTEGER is 285
	TE_STR_GT: INTEGER is 286
	TE_STR_GE: INTEGER is 287
	TE_STR_MINUS: INTEGER is 288
	TE_STR_PLUS: INTEGER is 289
	TE_STR_STAR: INTEGER is 290
	TE_STR_SLASH: INTEGER is 291
	TE_STR_MOD: INTEGER is 292
	TE_STR_DIV: INTEGER is 293
	TE_STR_POWER: INTEGER is 294
	TE_STR_AND: INTEGER is 295
	TE_STR_AND_THEN: INTEGER is 296
	TE_STR_IMPLIES: INTEGER is 297
	TE_STR_OR: INTEGER is 298
	TE_STR_OR_ELSE: INTEGER is 299
	TE_STR_XOR: INTEGER is 300
	TE_STR_NOT: INTEGER is 301
	TE_STR_FREE: INTEGER is 302

end
