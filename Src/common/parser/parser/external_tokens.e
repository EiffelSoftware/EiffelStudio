indexing

	description: "Parser token codes"
	generator: "geyacc version 3.1"

class EXTERNAL_TOKENS

inherit

	YY_PARSER_TOKENS

feature -- Access

	token_name (a_token: INTEGER): STRING is
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
			when TE_ADDRESS then
				Result := "TE_ADDRESS"
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
			when TE_SIGNED then
				Result := "TE_SIGNED"
			when TE_UNSIGNED then
				Result := "TE_UNSIGNED"
			when TE_USE then
				Result := "TE_USE"
			when TE_ID then
				Result := "TE_ID"
			when TE_INCLUDE_ID then
				Result := "TE_INCLUDE_ID"
			else
				Result := yy_character_token_name (a_token)
			end
		end

feature -- Token codes

	TE_COLON: INTEGER is 258
	TE_LPARAN: INTEGER is 259
	TE_RPARAN: INTEGER is 260
	TE_COMMA: INTEGER is 261
	TE_ADDRESS: INTEGER is 262
	TE_STAR: INTEGER is 263
	TE_LT: INTEGER is 264
	TE_GT: INTEGER is 265
	TE_DQUOTE: INTEGER is 266
	TE_ACCESS: INTEGER is 267
	TE_C_LANGUAGE: INTEGER is 268
	TE_CPP_LANGUAGE: INTEGER is 269
	TE_INLINE: INTEGER is 270
	TE_DELETE: INTEGER is 271
	TE_DLL_LANGUAGE: INTEGER is 272
	TE_DLLWIN_LANGUAGE: INTEGER is 273
	TE_ENUM: INTEGER is 274
	TE_GET_PROPERTY: INTEGER is 275
	TE_IL_LANGUAGE: INTEGER is 276
	TE_MACRO: INTEGER is 277
	TE_FIELD: INTEGER is 278
	TE_JAVA_LANGUAGE: INTEGER is 279
	TE_DEFERRED: INTEGER is 280
	TE_OPERATOR: INTEGER is 281
	TE_INTEGER: INTEGER is 282
	TE_SET_FIELD: INTEGER is 283
	TE_SET_PROPERTY: INTEGER is 284
	TE_SIGNATURE: INTEGER is 285
	TE_STATIC: INTEGER is 286
	TE_CREATOR: INTEGER is 287
	TE_STATIC_FIELD: INTEGER is 288
	TE_SET_STATIC_FIELD: INTEGER is 289
	TE_STRUCT: INTEGER is 290
	TE_TYPE: INTEGER is 291
	TE_SIGNED: INTEGER is 292
	TE_UNSIGNED: INTEGER is 293
	TE_USE: INTEGER is 294
	TE_ID: INTEGER is 295
	TE_INCLUDE_ID: INTEGER is 296

end -- class EXTERNAL_TOKENS
