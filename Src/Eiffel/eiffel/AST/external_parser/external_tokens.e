note

	description: "Parser token codes"
	generator: "geyacc version 3.8"

class EXTERNAL_TOKENS

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
			when TE_COLON then
				Result := "TE_COLON"
			when TE_LPARAN then
				Result := "TE_LPARAN"
			when TE_RPARAN then
				Result := "TE_RPARAN"
			when TE_COMMA then
				Result := "TE_COMMA"
			when TE_BUILT_IN then
				Result := "TE_BUILT_IN"
			when TE_ADDRESS then
				Result := "TE_ADDRESS"
			when TE_BLOCKING then
				Result := "TE_BLOCKING"
			when TE_STAR then
				Result := "TE_STAR"
			when TE_LT then
				Result := "TE_LT"
			when TE_GT then
				Result := "TE_GT"
			when TE_DQUOTE then
				Result := "TE_DQUOTE"
			when TE_ACCESS then
				Result := "TE_ACCESS"
			when TE_C_LANGUAGE then
				Result := "TE_C_LANGUAGE"
			when TE_CPP_LANGUAGE then
				Result := "TE_CPP_LANGUAGE"
			when TE_INLINE then
				Result := "TE_INLINE"
			when TE_DELETE then
				Result := "TE_DELETE"
			when TE_DLL_LANGUAGE then
				Result := "TE_DLL_LANGUAGE"
			when TE_DLLWIN_LANGUAGE then
				Result := "TE_DLLWIN_LANGUAGE"
			when TE_ENUM then
				Result := "TE_ENUM"
			when TE_GET_PROPERTY then
				Result := "TE_GET_PROPERTY"
			when TE_IL_LANGUAGE then
				Result := "TE_IL_LANGUAGE"
			when TE_MACRO then
				Result := "TE_MACRO"
			when TE_FIELD then
				Result := "TE_FIELD"
			when TE_JAVA_LANGUAGE then
				Result := "TE_JAVA_LANGUAGE"
			when TE_DEFERRED then
				Result := "TE_DEFERRED"
			when TE_OPERATOR then
				Result := "TE_OPERATOR"
			when TE_INTEGER then
				Result := "TE_INTEGER"
			when TE_SET_FIELD then
				Result := "TE_SET_FIELD"
			when TE_SET_PROPERTY then
				Result := "TE_SET_PROPERTY"
			when TE_SIGNATURE then
				Result := "TE_SIGNATURE"
			when TE_STATIC then
				Result := "TE_STATIC"
			when TE_CREATOR then
				Result := "TE_CREATOR"
			when TE_STATIC_FIELD then
				Result := "TE_STATIC_FIELD"
			when TE_SET_STATIC_FIELD then
				Result := "TE_SET_STATIC_FIELD"
			when TE_STRUCT then
				Result := "TE_STRUCT"
			when TE_TYPE then
				Result := "TE_TYPE"
			when TE_CONST then
				Result := "TE_CONST"
			when TE_SIGNED then
				Result := "TE_SIGNED"
			when TE_UNSIGNED then
				Result := "TE_UNSIGNED"
			when TE_USE then
				Result := "TE_USE"
			when TE_ID then
				Result := "TE_ID"
			when TE_FILE_ID then
				Result := "TE_FILE_ID"
			else
				Result := yy_character_token_name (a_token)
			end
		end

feature -- Token codes

	TE_COLON: INTEGER = 258
	TE_LPARAN: INTEGER = 259
	TE_RPARAN: INTEGER = 260
	TE_COMMA: INTEGER = 261
	TE_BUILT_IN: INTEGER = 262
	TE_ADDRESS: INTEGER = 263
	TE_BLOCKING: INTEGER = 264
	TE_STAR: INTEGER = 265
	TE_LT: INTEGER = 266
	TE_GT: INTEGER = 267
	TE_DQUOTE: INTEGER = 268
	TE_ACCESS: INTEGER = 269
	TE_C_LANGUAGE: INTEGER = 270
	TE_CPP_LANGUAGE: INTEGER = 271
	TE_INLINE: INTEGER = 272
	TE_DELETE: INTEGER = 273
	TE_DLL_LANGUAGE: INTEGER = 274
	TE_DLLWIN_LANGUAGE: INTEGER = 275
	TE_ENUM: INTEGER = 276
	TE_GET_PROPERTY: INTEGER = 277
	TE_IL_LANGUAGE: INTEGER = 278
	TE_MACRO: INTEGER = 279
	TE_FIELD: INTEGER = 280
	TE_JAVA_LANGUAGE: INTEGER = 281
	TE_DEFERRED: INTEGER = 282
	TE_OPERATOR: INTEGER = 283
	TE_INTEGER: INTEGER = 284
	TE_SET_FIELD: INTEGER = 285
	TE_SET_PROPERTY: INTEGER = 286
	TE_SIGNATURE: INTEGER = 287
	TE_STATIC: INTEGER = 288
	TE_CREATOR: INTEGER = 289
	TE_STATIC_FIELD: INTEGER = 290
	TE_SET_STATIC_FIELD: INTEGER = 291
	TE_STRUCT: INTEGER = 292
	TE_TYPE: INTEGER = 293
	TE_CONST: INTEGER = 294
	TE_SIGNED: INTEGER = 295
	TE_UNSIGNED: INTEGER = 296
	TE_USE: INTEGER = 297
	TE_ID: INTEGER = 298
	TE_FILE_ID: INTEGER = 299

end
