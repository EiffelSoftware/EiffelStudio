note

	description: "Parser token codes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "geyacc version 3.4"

class CODE_INHERITANCE_CLAUSE_TOKENS

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

	TE_ALL: INTEGER = 258
	TE_SEMICOLON: INTEGER = 259
	TE_COMMA: INTEGER = 260
	TE_ID: INTEGER = 261
	TE_END: INTEGER = 262
	TE_AS: INTEGER = 263
	TE_EXPANDED: INTEGER = 264
	TE_EXPORT: INTEGER = 265
	TE_INHERIT: INTEGER = 266
	TE_REDEFINE: INTEGER = 267
	TE_RENAME: INTEGER = 268
	TE_LSQURE: INTEGER = 269
	TE_RSQURE: INTEGER = 270
	TE_SELECT: INTEGER = 271
	TE_UNDEFINE: INTEGER = 272
	TE_INFIX: INTEGER = 273
	TE_PREFIX: INTEGER = 274
	TE_LCURLY: INTEGER = 275
	TE_RCURLY: INTEGER = 276
	TE_SEPARATE: INTEGER = 277
	TE_BIT: INTEGER = 278
	TE_LIKE: INTEGER = 279
	TE_CURRENT: INTEGER = 280
	TE_INTEGER: INTEGER = 281
	TE_PLUS: INTEGER = 282
	TE_MINUS: INTEGER = 283
	TE_STR_LT: INTEGER = 284
	TE_STR_LE: INTEGER = 285
	TE_STR_GT: INTEGER = 286
	TE_STR_GE: INTEGER = 287
	TE_STR_MINUS: INTEGER = 288
	TE_STR_PLUS: INTEGER = 289
	TE_STR_STAR: INTEGER = 290
	TE_STR_SLASH: INTEGER = 291
	TE_STR_MOD: INTEGER = 292
	TE_STR_DIV: INTEGER = 293
	TE_STR_POWER: INTEGER = 294
	TE_STR_AND: INTEGER = 295
	TE_STR_AND_THEN: INTEGER = 296
	TE_STR_IMPLIES: INTEGER = 297
	TE_STR_OR: INTEGER = 298
	TE_STR_OR_ELSE: INTEGER = 299
	TE_STR_XOR: INTEGER = 300
	TE_STR_NOT: INTEGER = 301
	TE_STR_FREE: INTEGER = 302;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
