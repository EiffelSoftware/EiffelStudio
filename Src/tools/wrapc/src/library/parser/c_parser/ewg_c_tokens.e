note

	description: "Parser token codes"
	generator: "geyacc"

deferred class EWG_C_TOKENS

inherit

	YY_PARSER_TOKENS

feature -- Last values

	last_detachable_any_value: detachable ANY
	last_string_value: STRING

feature -- Access

	token_name (a_token: INTEGER): STRING
			-- Name of token `a_token'
		do
			inspect a_token
			when 0 then
				Result := "EOF token"
			when -1 then
				Result := "Error token"
			when TOK_IDENTIFIER then
				Result := "TOK_IDENTIFIER"
			when TOK_CONSTANT then
				Result := "TOK_CONSTANT"
			when TOK_STRING_LITERAL then
				Result := "TOK_STRING_LITERAL"
			when TOK_SIZEOF then
				Result := "TOK_SIZEOF"
			when TOK_PTR_OP then
				Result := "TOK_PTR_OP"
			when TOK_INC_OP then
				Result := "TOK_INC_OP"
			when TOK_DEC_OP then
				Result := "TOK_DEC_OP"
			when TOK_LEFT_OP then
				Result := "TOK_LEFT_OP"
			when TOK_RIGHT_OP then
				Result := "TOK_RIGHT_OP"
			when TOK_LE_OP then
				Result := "TOK_LE_OP"
			when TOK_GE_OP then
				Result := "TOK_GE_OP"
			when TOK_EQ_OP then
				Result := "TOK_EQ_OP"
			when TOK_NE_OP then
				Result := "TOK_NE_OP"
			when TOK_AND_OP then
				Result := "TOK_AND_OP"
			when TOK_OR_OP then
				Result := "TOK_OR_OP"
			when TOK_MUL_ASSIGN then
				Result := "TOK_MUL_ASSIGN"
			when TOK_DIV_ASSIGN then
				Result := "TOK_DIV_ASSIGN"
			when TOK_MOD_ASSIGN then
				Result := "TOK_MOD_ASSIGN"
			when TOK_ADD_ASSIGN then
				Result := "TOK_ADD_ASSIGN"
			when TOK_SUB_ASSIGN then
				Result := "TOK_SUB_ASSIGN"
			when TOK_LEFT_ASSIGN then
				Result := "TOK_LEFT_ASSIGN"
			when TOK_RIGHT_ASSIGN then
				Result := "TOK_RIGHT_ASSIGN"
			when TOK_AND_ASSIGN then
				Result := "TOK_AND_ASSIGN"
			when TOK_XOR_ASSIGN then
				Result := "TOK_XOR_ASSIGN"
			when TOK_OR_ASSIGN then
				Result := "TOK_OR_ASSIGN"
			when TOK_TYPE_NAME then
				Result := "TOK_TYPE_NAME"
			when TOK_TYPEDEF then
				Result := "TOK_TYPEDEF"
			when TOK_EXTERN then
				Result := "TOK_EXTERN"
			when TOK_STATIC then
				Result := "TOK_STATIC"
			when TOK_AUTO then
				Result := "TOK_AUTO"
			when TOK_REGISTER then
				Result := "TOK_REGISTER"
			when TOK_CHAR then
				Result := "TOK_CHAR"
			when TOK_SHORT then
				Result := "TOK_SHORT"
			when TOK_INT then
				Result := "TOK_INT"
			when TOK_LONG then
				Result := "TOK_LONG"
			when TOK_SIGNED then
				Result := "TOK_SIGNED"
			when TOK_UNSIGNED then
				Result := "TOK_UNSIGNED"
			when TOK_FLOAT then
				Result := "TOK_FLOAT"
			when TOK_DOUBLE then
				Result := "TOK_DOUBLE"
			when TOK_CONST then
				Result := "TOK_CONST"
			when TOK_VOLATILE then
				Result := "TOK_VOLATILE"
			when TOK_VOID then
				Result := "TOK_VOID"
			when TOK_STRUCT then
				Result := "TOK_STRUCT"
			when TOK_UNION then
				Result := "TOK_UNION"
			when TOK_ENUM then
				Result := "TOK_ENUM"
			when TOK_ELLIPSIS then
				Result := "TOK_ELLIPSIS"
			when TOK_CASE then
				Result := "TOK_CASE"
			when TOK_DEFAULT then
				Result := "TOK_DEFAULT"
			when TOK_IF then
				Result := "TOK_IF"
			when TOK_ELSE then
				Result := "TOK_ELSE"
			when TOK_SWITCH then
				Result := "TOK_SWITCH"
			when TOK_WHILE then
				Result := "TOK_WHILE"
			when TOK_DO then
				Result := "TOK_DO"
			when TOK_FOR then
				Result := "TOK_FOR"
			when TOK_GOTO then
				Result := "TOK_GOTO"
			when TOK_CONTINUE then
				Result := "TOK_CONTINUE"
			when TOK_BREAK then
				Result := "TOK_BREAK"
			when TOK_RETURN then
				Result := "TOK_RETURN"
			when TOK_INLINE then
				Result := "TOK_INLINE"
			when TOK_CL_INT_8 then
				Result := "TOK_CL_INT_8"
			when TOK_CL_INT_16 then
				Result := "TOK_CL_INT_16"
			when TOK_CL_INT_32 then
				Result := "TOK_CL_INT_32"
			when TOK_CL_INT_64 then
				Result := "TOK_CL_INT_64"
			when TOK_CL_FASTCALL then
				Result := "TOK_CL_FASTCALL"
			when TOK_CL_BASED then
				Result := "TOK_CL_BASED"
			when TOK_CL_CDECL then
				Result := "TOK_CL_CDECL"
			when TOK_CL_STDCALL then
				Result := "TOK_CL_STDCALL"
			when TOK_CL_INLINE then
				Result := "TOK_CL_INLINE"
			when TOK_CL_ASM then
				Result := "TOK_CL_ASM"
			else
				Result := yy_character_token_name (a_token)
			end
		end

feature -- Token codes

	TOK_IDENTIFIER: INTEGER = 258
	TOK_CONSTANT: INTEGER = 259
	TOK_STRING_LITERAL: INTEGER = 260
	TOK_SIZEOF: INTEGER = 261
	TOK_PTR_OP: INTEGER = 262
	TOK_INC_OP: INTEGER = 263
	TOK_DEC_OP: INTEGER = 264
	TOK_LEFT_OP: INTEGER = 265
	TOK_RIGHT_OP: INTEGER = 266
	TOK_LE_OP: INTEGER = 267
	TOK_GE_OP: INTEGER = 268
	TOK_EQ_OP: INTEGER = 269
	TOK_NE_OP: INTEGER = 270
	TOK_AND_OP: INTEGER = 271
	TOK_OR_OP: INTEGER = 272
	TOK_MUL_ASSIGN: INTEGER = 273
	TOK_DIV_ASSIGN: INTEGER = 274
	TOK_MOD_ASSIGN: INTEGER = 275
	TOK_ADD_ASSIGN: INTEGER = 276
	TOK_SUB_ASSIGN: INTEGER = 277
	TOK_LEFT_ASSIGN: INTEGER = 278
	TOK_RIGHT_ASSIGN: INTEGER = 279
	TOK_AND_ASSIGN: INTEGER = 280
	TOK_XOR_ASSIGN: INTEGER = 281
	TOK_OR_ASSIGN: INTEGER = 282
	TOK_TYPE_NAME: INTEGER = 283
	TOK_TYPEDEF: INTEGER = 284
	TOK_EXTERN: INTEGER = 285
	TOK_STATIC: INTEGER = 286
	TOK_AUTO: INTEGER = 287
	TOK_REGISTER: INTEGER = 288
	TOK_CHAR: INTEGER = 289
	TOK_SHORT: INTEGER = 290
	TOK_INT: INTEGER = 291
	TOK_LONG: INTEGER = 292
	TOK_SIGNED: INTEGER = 293
	TOK_UNSIGNED: INTEGER = 294
	TOK_FLOAT: INTEGER = 295
	TOK_DOUBLE: INTEGER = 296
	TOK_CONST: INTEGER = 297
	TOK_VOLATILE: INTEGER = 298
	TOK_VOID: INTEGER = 299
	TOK_STRUCT: INTEGER = 300
	TOK_UNION: INTEGER = 301
	TOK_ENUM: INTEGER = 302
	TOK_ELLIPSIS: INTEGER = 303
	TOK_CASE: INTEGER = 304
	TOK_DEFAULT: INTEGER = 305
	TOK_IF: INTEGER = 306
	TOK_ELSE: INTEGER = 307
	TOK_SWITCH: INTEGER = 308
	TOK_WHILE: INTEGER = 309
	TOK_DO: INTEGER = 310
	TOK_FOR: INTEGER = 311
	TOK_GOTO: INTEGER = 312
	TOK_CONTINUE: INTEGER = 313
	TOK_BREAK: INTEGER = 314
	TOK_RETURN: INTEGER = 315
	TOK_INLINE: INTEGER = 316
	TOK_CL_INT_8: INTEGER = 317
	TOK_CL_INT_16: INTEGER = 318
	TOK_CL_INT_32: INTEGER = 319
	TOK_CL_INT_64: INTEGER = 320
	TOK_CL_FASTCALL: INTEGER = 321
	TOK_CL_BASED: INTEGER = 322
	TOK_CL_CDECL: INTEGER = 323
	TOK_CL_STDCALL: INTEGER = 324
	TOK_CL_INLINE: INTEGER = 325
	TOK_CL_ASM: INTEGER = 326

end
