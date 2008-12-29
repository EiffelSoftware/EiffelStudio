note

	description: "Parser token codes"
	generator: "geyacc version 3.4"

class LACE_TOKENS

inherit

	YY_PARSER_TOKENS

feature -- Last values

	last_any_value: ANY

feature -- Access

	token_name (a_token: INTEGER): STRING
			-- Name of token `a_token'
		do
			inspect a_token
			when 0 then
				Result := "EOF token"
			when -1 then
				Result := "Error token"
			when LAC_ADAPT then
				Result := "LAC_ADAPT"
			when LAC_ALL then
				Result := "LAC_ALL"
			when LAC_AS then
				Result := "LAC_AS"
			when LAC_ASSEMBLY then
				Result := "LAC_ASSEMBLY"
			when LAC_ASSERTION then
				Result := "LAC_ASSERTION"
			when LAC_CHECK then
				Result := "LAC_CHECK"
			when LAC_CLUSTER then
				Result := "LAC_CLUSTER"
			when LAC_COLON then
				Result := "LAC_COLON"
			when LAC_COMMA then
				Result := "LAC_COMMA"
			when LAC_CREATION then
				Result := "LAC_CREATION"
			when LAC_DEBUG then
				Result := "LAC_DEBUG"
			when LAC_DEFAULT then
				Result := "LAC_DEFAULT"
			when LAC_DISABLED_DEBUG then
				Result := "LAC_DISABLED_DEBUG"
			when LAC_END then
				Result := "LAC_END"
			when LAC_ENSURE then
				Result := "LAC_ENSURE"
			when LAC_EXCLUDE then
				Result := "LAC_EXCLUDE"
			when LAC_DEPEND then
				Result := "LAC_DEPEND"
			when LAC_EXPORT then
				Result := "LAC_EXPORT"
			when LAC_EXTERNAL then
				Result := "LAC_EXTERNAL"
			when LAC_GENERATE then
				Result := "LAC_GENERATE"
			when LAC_IDENTIFIER then
				Result := "LAC_IDENTIFIER"
			when LAC_IGNORE then
				Result := "LAC_IGNORE"
			when LAC_INCLUDE then
				Result := "LAC_INCLUDE"
			when LAC_INVARIANT then
				Result := "LAC_INVARIANT"
			when LAC_LEFT_PARAM then
				Result := "LAC_LEFT_PARAM"
			when LAC_LOOP then
				Result := "LAC_LOOP"
			when LAC_NO then
				Result := "LAC_NO"
			when LAC_OPTIMIZE then
				Result := "LAC_OPTIMIZE"
			when LAC_OPTION then
				Result := "LAC_OPTION"
			when LAC_PRECOMPILED then
				Result := "LAC_PRECOMPILED"
			when LAC_PREFIX then
				Result := "LAC_PREFIX"
			when LAC_RENAME then
				Result := "LAC_RENAME"
			when LAC_REQUIRE then
				Result := "LAC_REQUIRE"
			when LAC_RIGHT_PARAM then
				Result := "LAC_RIGHT_PARAM"
			when LAC_ROOT then
				Result := "LAC_ROOT"
			when LAC_SEMICOLON then
				Result := "LAC_SEMICOLON"
			when LAC_STRING then
				Result := "LAC_STRING"
			when LAC_SYSTEM then
				Result := "LAC_SYSTEM"
			when LAC_TRACE then
				Result := "LAC_TRACE"
			when LAC_USE then
				Result := "LAC_USE"
			when LAC_VISIBLE then
				Result := "LAC_VISIBLE"
			when LAC_YES then
				Result := "LAC_YES"
			when LAC_LIBRARY then
				Result := "LAC_LIBRARY"
			else
				Result := yy_character_token_name (a_token)
			end
		end

feature -- Token codes

	LAC_ADAPT: INTEGER = 258
	LAC_ALL: INTEGER = 259
	LAC_AS: INTEGER = 260
	LAC_ASSEMBLY: INTEGER = 261
	LAC_ASSERTION: INTEGER = 262
	LAC_CHECK: INTEGER = 263
	LAC_CLUSTER: INTEGER = 264
	LAC_COLON: INTEGER = 265
	LAC_COMMA: INTEGER = 266
	LAC_CREATION: INTEGER = 267
	LAC_DEBUG: INTEGER = 268
	LAC_DEFAULT: INTEGER = 269
	LAC_DISABLED_DEBUG: INTEGER = 270
	LAC_END: INTEGER = 271
	LAC_ENSURE: INTEGER = 272
	LAC_EXCLUDE: INTEGER = 273
	LAC_DEPEND: INTEGER = 274
	LAC_EXPORT: INTEGER = 275
	LAC_EXTERNAL: INTEGER = 276
	LAC_GENERATE: INTEGER = 277
	LAC_IDENTIFIER: INTEGER = 278
	LAC_IGNORE: INTEGER = 279
	LAC_INCLUDE: INTEGER = 280
	LAC_INVARIANT: INTEGER = 281
	LAC_LEFT_PARAM: INTEGER = 282
	LAC_LOOP: INTEGER = 283
	LAC_NO: INTEGER = 284
	LAC_OPTIMIZE: INTEGER = 285
	LAC_OPTION: INTEGER = 286
	LAC_PRECOMPILED: INTEGER = 287
	LAC_PREFIX: INTEGER = 288
	LAC_RENAME: INTEGER = 289
	LAC_REQUIRE: INTEGER = 290
	LAC_RIGHT_PARAM: INTEGER = 291
	LAC_ROOT: INTEGER = 292
	LAC_SEMICOLON: INTEGER = 293
	LAC_STRING: INTEGER = 294
	LAC_SYSTEM: INTEGER = 295
	LAC_TRACE: INTEGER = 296
	LAC_USE: INTEGER = 297
	LAC_VISIBLE: INTEGER = 298
	LAC_YES: INTEGER = 299
	LAC_LIBRARY: INTEGER = 300

end
