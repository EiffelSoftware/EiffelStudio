note
	description: "data for alias name in the multiple alias list : FEATURE_NAME_ALIAS_AS.aliases ."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_ALIAS_NAME

inherit
	ANY

	INTERNAL_COMPILER_STRING_EXPORTER

	EIFFEL_SYNTAX_CHECKER

	PREFIX_INFIX_NAMES

create
	make

feature {NONE} -- Initialize

	make (a_alias_name: STRING_AS; a_alias_keyword: detachable KEYWORD_AS)
		require
			a_alias_name_not_void: a_alias_name /= Void
			a_alias_name_not_empty: not a_alias_name.value.is_empty
			valid_alias_name:
				is_bracket_alias_name (a_alias_name.value) or else
				is_parentheses_alias_name (a_alias_name.value) or else
				is_valid_binary_operator (a_alias_name.value_32) or else
				is_valid_unary_operator (a_alias_name.value_32)
		do
			alias_name := a_alias_name
			if a_alias_keyword /= Void then
				alias_keyword_index := a_alias_keyword.index
			end

			if
				not is_bracket_alias and then
				not is_parentheses_alias
			then
					-- Make sure we do not get "prefix %"or%"" or alike
				if is_valid_unary_operator (a_alias_name.value_32) then
					set_is_unary
				elseif is_valid_binary_operator (a_alias_name.value_32) then
					set_is_binary
				end
			end
		end

feature -- Access

	alias_name: STRING_AS
	alias_keyword_index: INTEGER

	internal_alias_name_id: INTEGER
			-- `internal_alias_name' ID in NAMES_HEAP
		do
			if attached internal_alias_name as l_alias then
				Result := l_alias.name_id
			end
		ensure
			has_alias: alias_name /= Void implies Result > 0
			has_no_alias: alias_name = Void implies Result = 0
		end

	internal_alias_name: detachable ID_AS
			-- Operator associated with the feature (if any)
			-- augmented with information about its arity
		do
			if is_bracket_alias or else is_parentheses_alias then
				create Result.initialize (alias_name.value)
			else
					-- For alias, always consider lowercase operator name!
				if is_binary then
					create Result.initialize (infix_feature_name_with_symbol (alias_name.value_as_lower))
				else
					create Result.initialize (prefix_feature_name_with_symbol (alias_name.value_as_lower))
				end
			end
		ensure
			consistent_result: (Result /= Void) = (alias_name /= Void)
		end

feature -- status

	is_unary: BOOLEAN

	is_binary: BOOLEAN

	is_valid_unary: BOOLEAN
			-- Is the value of the feature name valid unary operator?
		do
			Result := is_valid_unary_operator (alias_name.value)
		end

	is_valid_binary: BOOLEAN
			-- Is the value of the feature name valid unary operator?
		do
			Result := is_valid_binary_operator (alias_name.value)
		end

	is_bracket_alias: BOOLEAN
		do
			Result := alias_name.value.item (1) = '['
		end

	is_parentheses_alias: BOOLEAN
		do
			Result := alias_name.value.item (1) = '('
		end

feature -- Element change

	set_is_unary
		do
			is_unary := True
			is_binary := False
		end

	set_is_binary
		do
			is_binary := True
			is_unary := False
		end

invariant

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
