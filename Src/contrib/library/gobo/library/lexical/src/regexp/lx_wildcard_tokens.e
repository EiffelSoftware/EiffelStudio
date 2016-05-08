note

	description: "Parser token codes"
	generator: "geyacc version 3.9"

deferred class LX_WILDCARD_TOKENS

inherit

	YY_PARSER_TOKENS

feature -- Last values

	last_detachable_any_value: detachable ANY
	last_integer_value: INTEGER
	last_lx_symbol_class_value: LX_SYMBOL_CLASS
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
			when STAR_STAR_SLASH then
				Result := "STAR_STAR_SLASH"
			when STAR_PAREN then
				Result := "STAR_PAREN"
			when CHAR then
				Result := "CHAR"
			when CCL_OP then
				Result := "CCL_OP"
			else
				Result := yy_character_token_name (a_token)
			end
		end

feature -- Token codes

	STAR_STAR_SLASH: INTEGER = 258
	STAR_PAREN: INTEGER = 259
	CHAR: INTEGER = 260
	CCL_OP: INTEGER = 261

end
