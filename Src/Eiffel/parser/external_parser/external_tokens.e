indexing

	description: "Parser token codes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "geyacc version 3.4"

class EXTERNAL_TOKENS

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
	TE_BUILT_IN: INTEGER is 262
	TE_ADDRESS: INTEGER is 263
	TE_BLOCKING: INTEGER is 264
	TE_STAR: INTEGER is 265
	TE_LT: INTEGER is 266
	TE_GT: INTEGER is 267
	TE_DQUOTE: INTEGER is 268
	TE_ACCESS: INTEGER is 269
	TE_C_LANGUAGE: INTEGER is 270
	TE_CPP_LANGUAGE: INTEGER is 271
	TE_INLINE: INTEGER is 272
	TE_DELETE: INTEGER is 273
	TE_DLL_LANGUAGE: INTEGER is 274
	TE_DLLWIN_LANGUAGE: INTEGER is 275
	TE_ENUM: INTEGER is 276
	TE_GET_PROPERTY: INTEGER is 277
	TE_IL_LANGUAGE: INTEGER is 278
	TE_MACRO: INTEGER is 279
	TE_FIELD: INTEGER is 280
	TE_JAVA_LANGUAGE: INTEGER is 281
	TE_DEFERRED: INTEGER is 282
	TE_OPERATOR: INTEGER is 283
	TE_INTEGER: INTEGER is 284
	TE_SET_FIELD: INTEGER is 285
	TE_SET_PROPERTY: INTEGER is 286
	TE_SIGNATURE: INTEGER is 287
	TE_STATIC: INTEGER is 288
	TE_CREATOR: INTEGER is 289
	TE_STATIC_FIELD: INTEGER is 290
	TE_SET_STATIC_FIELD: INTEGER is 291
	TE_STRUCT: INTEGER is 292
	TE_TYPE: INTEGER is 293
	TE_SIGNED: INTEGER is 294
	TE_UNSIGNED: INTEGER is 295
	TE_USE: INTEGER is 296
	TE_ID: INTEGER is 297
	TE_INCLUDE_ID: INTEGER is 298;

indexing
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
