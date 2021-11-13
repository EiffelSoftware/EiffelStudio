note
	description: "An alias name in the multiple alias list (see `{FEATURE_NAME_ALIAS_AS}.aliases`)."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_ALIAS_NAME

inherit
	INTERNAL_COMPILER_STRING_EXPORTER
	SHARED_NAMES_HEAP

inherit {NONE}

	OPERATOR_KIND
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialize

	make (s: STRING_AS; a: detachable KEYWORD_AS; k: like kind_anchor)
			-- Initialize with the given alias string `s`, "alias" keyword `a`, and alias kind `k`.
			-- The alias string is expected to be correct by itself and with respect to `k`.
		require
			attached a
			not s.value.is_empty
			is_valid_kind (k)
		do
			alias_name := s
			if attached a then
				alias_keyword_index := a.index
			end
			kind := k
		ensure
			alias_name = s
			alias_keyword_index_set: alias_keyword_index = if attached a then a.index else 0 end
			kind = k
		end

feature -- Access

	alias_name: STRING_AS
			-- The alias operator string.

	alias_keyword_index: like {KEYWORD_AS}.index
			-- The index if the keyword "alias" if available, `0` otherwise.

	id: like {OPERATOR_KIND}.alias_id
			-- ID of the alias with both the alias name and the alias kind.
		do
			names_heap.put (alias_name.value_as_lower)
			Result := alias_id (names_heap.found_item, kind)
		ensure
			has_name: names_heap.id_of (alias_name.value_as_lower) > 0
			is_alias_id (Result)
			definition: Result = alias_id (names_heap.id_of (alias_name.value_as_lower), kind)
		end

feature -- Status

	is_binary: BOOLEAN
			-- Is the alias used for a binary operation?
		do
			Result := kind ⊗ is_binary_kind_mask /= kind.default
		ensure
			Result implies is_valid_binary
		end

	is_unary: BOOLEAN
			-- Is the alias used for an unary operation?
		do
			Result := kind ⊗ is_unary_kind_mask /= kind.default
		ensure
			Result implies is_valid_unary
		end

	is_valid_binary: BOOLEAN
			-- Is the alias a valid binary operator?
		do
			Result := kind ⊗ is_valid_binary_kind_mask /= kind.default
		end

	is_valid_unary: BOOLEAN
			-- Is the alias a valid unary operator?
		do
			Result := kind ⊗ is_valid_unary_kind_mask /= kind.default
		end

	is_bracket: BOOLEAN
			-- Is the alias a bracket operator?
		do
			Result := kind ⊗ is_bracket_kind_mask /= kind.default
		end

	is_parentheses: BOOLEAN
			-- Is the alias a parentheses operator?
		do
			Result := kind ⊗ is_parentheses_kind_mask /= kind.default
		end

	is_circumfix: BOOLEAN
			-- Is the alias a bracket or parentheses operator?
		do
			Result := kind ⊗ (is_bracket_kind_mask ⦶ is_parentheses_kind_mask) /= kind.default
		end

feature {NONE} -- Access

	kind: like kind_anchor
			-- Flags indicating the alias kind.

feature -- Element change

	set_is_binary
			-- Mark the alias as binary.
		require
			is_valid_binary
			not is_bracket
			not is_parentheses
		do
			kind := (kind ⦶ is_binary_kind_mask) ⊗ ⊝ is_unary_kind_mask
		ensure
			is_valid_binary
			is_binary
			not is_unary
			not is_bracket
			not is_parentheses
		end

	set_is_unary
			-- Mark the alias as unary.
		require
			is_valid_unary
			not is_bracket
			not is_parentheses
		do
			kind := (kind ⦶ is_unary_kind_mask) ⊗ ⊝ is_binary_kind_mask
		ensure
			is_valid_unary
			is_unary
			not is_binary
			not is_bracket
			not is_parentheses
		end

invariant
	is_valid_kind (kind)
	is_valid: is_bracket or is_parentheses or is_valid_binary or is_valid_unary
	is_valid_kind_restriction:
		(is_valid_unary or is_valid_binary).to_integer +
		is_bracket.to_integer +
		is_parentheses.to_integer = 1
	at_most_one_kind:
		is_unary.to_integer +
		is_binary.to_integer +
		is_bracket.to_integer +
		is_parentheses.to_integer <= 1

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
