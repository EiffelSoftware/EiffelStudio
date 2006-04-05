indexing

	description: "Parser token codes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "geyacc version 3.4"

class LACE_TOKENS

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

	LAC_ADAPT: INTEGER is 258
	LAC_ALL: INTEGER is 259
	LAC_AS: INTEGER is 260
	LAC_ASSEMBLY: INTEGER is 261
	LAC_ASSERTION: INTEGER is 262
	LAC_CHECK: INTEGER is 263
	LAC_CLUSTER: INTEGER is 264
	LAC_COLON: INTEGER is 265
	LAC_COMMA: INTEGER is 266
	LAC_CREATION: INTEGER is 267
	LAC_DEBUG: INTEGER is 268
	LAC_DEFAULT: INTEGER is 269
	LAC_DISABLED_DEBUG: INTEGER is 270
	LAC_END: INTEGER is 271
	LAC_ENSURE: INTEGER is 272
	LAC_EXCLUDE: INTEGER is 273
	LAC_DEPEND: INTEGER is 274
	LAC_EXPORT: INTEGER is 275
	LAC_EXTERNAL: INTEGER is 276
	LAC_GENERATE: INTEGER is 277
	LAC_IDENTIFIER: INTEGER is 278
	LAC_IGNORE: INTEGER is 279
	LAC_INCLUDE: INTEGER is 280
	LAC_INVARIANT: INTEGER is 281
	LAC_LEFT_PARAM: INTEGER is 282
	LAC_LOOP: INTEGER is 283
	LAC_NO: INTEGER is 284
	LAC_OPTIMIZE: INTEGER is 285
	LAC_OPTION: INTEGER is 286
	LAC_PRECOMPILED: INTEGER is 287
	LAC_PREFIX: INTEGER is 288
	LAC_RENAME: INTEGER is 289
	LAC_REQUIRE: INTEGER is 290
	LAC_RIGHT_PARAM: INTEGER is 291
	LAC_ROOT: INTEGER is 292
	LAC_SEMICOLON: INTEGER is 293
	LAC_STRING: INTEGER is 294
	LAC_SYSTEM: INTEGER is 295
	LAC_TRACE: INTEGER is 296
	LAC_USE: INTEGER is 297
	LAC_VISIBLE: INTEGER is 298
	LAC_YES: INTEGER is 299
	LAC_LIBRARY: INTEGER is 300;

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
