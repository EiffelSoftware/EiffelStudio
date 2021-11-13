note
	description: "A utility to handle Eiffel operators and aliases."

class OPERATOR_KIND

feature -- Access: operator kind

	kind_anchor: NATURAL_8
			-- The anchor for a type declaring an operator kind.
		require
			False
		do
		ensure
			class
			False
		end

	is_bracket_kind_mask: NATURAL_8 = 1
			-- A mask for a bracket alias.

	is_parentheses_kind_mask: NATURAL_8 = 2
			-- A mask for a parentheses alias.

	is_valid_binary_kind_mask: NATURAL_8 = 4
			-- A mask for a valid binary alias.

	is_valid_unary_kind_mask: NATURAL_8 = 8
			-- A mask for a valid unary alias.

	is_binary_kind_mask: NATURAL_8 = 16
			-- A mask for a binary alias.

	is_unary_kind_mask: NATURAL_8 = 32
			-- A mask for an unary alias.

feature -- Status report: operator kind

	is_valid_kind (k: like kind_anchor): BOOLEAN
			-- Does `k` represent a valid operator kind?
		do
				-- A valid binary and unary operator can switch from unary to binary or back during recompilation.
				-- Therefore, the selection of a particular operator kind does not affect its validity.
			Result :=
				k = is_bracket_kind_mask or
				k = is_parentheses_kind_mask or
				(k ⊗ (is_valid_binary_kind_mask ⦶ is_valid_unary_kind_mask) /= k.default and
					(k ⊗ is_valid_binary_kind_mask = k.default implies k ⊗ is_binary_kind_mask = k.default) and
					(k ⊗ is_valid_unary_kind_mask = k.default implies k ⊗ is_unary_kind_mask = k.default) and
					k ⊗ (is_binary_kind_mask ⦶ is_unary_kind_mask) /= is_binary_kind_mask ⦶ is_unary_kind_mask)
		ensure
			class
		end

feature -- Status report: alias name ID

	is_alias_id (i: like alias_id): BOOLEAN
			-- Does `i` represent a valid alias ID?
		do
			Result :=
				{SHARED_NAMES_HEAP}.names_heap.has (name_id_of_alias_id (i)) and then
				(i = {PREDEFINED_NAMES}.bracket_symbol_id and name_id_of_alias_id (i) = i or
				i = {PREDEFINED_NAMES}.parentheses_symbol_id and name_id_of_alias_id (i) = i or
				is_valid_kind ((i.as_natural_32 ⧁ alias_kind_shift).as_natural_8))
		ensure
			class
			Result ⇒ {SHARED_NAMES_HEAP}.names_heap.has (name_id_of_alias_id (i))
			Result ⇒ (name_id_of_alias_id (i) = {PREDEFINED_NAMES}.bracket_symbol_id ⇒ i = {PREDEFINED_NAMES}.bracket_symbol_id)
			Result ⇒ (name_id_of_alias_id (i) = {PREDEFINED_NAMES}.parentheses_symbol_id ⇒ i = {PREDEFINED_NAMES}.parentheses_symbol_id)
		end

	is_fixed_alias_id (i: like alias_id): BOOLEAN
			-- Does `i` represent a valid fixed alias ID with a specific alias kind: bracket, parentheses, unary or binary?
		require
			is_alias_id (i)
		do
			Result :=
				i = {PREDEFINED_NAMES}.bracket_symbol_id or
				i = {PREDEFINED_NAMES}.parentheses_symbol_id or
				i ⊗ ((is_binary_kind_mask ⦶ is_unary_kind_mask).as_integer_32 ⧀ alias_kind_shift) /= i.default
		ensure
			class
		end

	is_lookup_alias_id (i: like alias_id): BOOLEAN
			-- Does `i` represent a fixed alias ID, suitable for lookup?
		do
			Result :=
				{SHARED_NAMES_HEAP}.names_heap.has (i ⊗ (1 ⧀ alias_kind_shift - 1)) and
				((i = {PREDEFINED_NAMES}.bracket_symbol_id).to_integer +
				(i = {PREDEFINED_NAMES}.parentheses_symbol_id).to_integer +
				(i ⊗ (is_binary_kind_mask.as_integer_32 ⧀ alias_kind_shift) /= i.default).to_integer +
				(i ⊗ (is_unary_kind_mask.as_integer_32 ⧀ alias_kind_shift) /= i.default).to_integer) = 1 and
				i ⊗ ((is_valid_binary_kind_mask ⦶ is_valid_unary_kind_mask).as_integer_32 ⧀ alias_kind_shift) = i.default
		ensure
			class
			definition: Result =
				(is_alias_id (i ⦶ is_valid_binary_kind_mask ⦶ is_valid_unary_kind_mask) and
				is_fixed_alias_id (i ⦶ is_valid_binary_kind_mask ⦶ is_valid_unary_kind_mask))
		end

	is_valid_binary_alias_id (i: like alias_id): BOOLEAN
			-- Does alias ID `i` represent a valid binary operator?
		require
			is_alias_id (i)
		do
			Result := i ⊗ (is_valid_binary_kind_mask.as_integer_32 ⧀ alias_kind_shift) /= i.default
		ensure
			class
		end

	is_valid_unary_alias_id (i: like alias_id): BOOLEAN
			-- Does alias ID `i` represent a valid unary operator?
		require
			is_alias_id (i)
		do
			Result := i ⊗ (is_valid_unary_kind_mask.as_integer_32 ⧀ alias_kind_shift) /= i.default
		ensure
			class
		end

	is_binary_alias_id (i: like alias_id): BOOLEAN
			-- Does alias ID `i` represent a binary operator?
		require
			is_alias_id (i)
		do
			Result := i ⊗ (is_binary_kind_mask.as_integer_32 ⧀ alias_kind_shift) /= i.default
		ensure
			class
		end

	is_unary_alias_id (i: like alias_id): BOOLEAN
			-- Does alias ID `i` represent a binary operator?
		require
			is_alias_id (i)
		do
			Result := i ⊗ (is_unary_kind_mask.as_integer_32 ⧀ alias_kind_shift) /= i.default
		ensure
			class
		end

feature -- Basic operations: alias name ID

	alias_id (n: like {ID_AS}.name_id; k: like kind_anchor): like {ID_AS}.name_id
			-- Alias ID for an alias operator `n` of kind `k`.
		require
			valid_name: {SHARED_NAMES_HEAP}.names_heap.has (n)
			valid_kind: is_valid_kind (k)
			bracket_kind: k = is_bracket_kind_mask ⇒ n = {PREDEFINED_NAMES}.bracket_symbol_id
			parentheses_kind: k = is_parentheses_kind_mask ⇒ n = {PREDEFINED_NAMES}.parentheses_symbol_id
			not_bracket_kind: k ⊗ (is_valid_binary_kind_mask ⦶ is_valid_unary_kind_mask) /= k.default ⇒ n /= {PREDEFINED_NAMES}.bracket_symbol_id
			not_parentheses_kind: k ⊗ (is_valid_binary_kind_mask ⦶ is_valid_unary_kind_mask) /= k.default ⇒ n /= {PREDEFINED_NAMES}.parentheses_symbol_id
		do
			Result := n + (k ⊗ ⊝ (is_bracket_kind_mask ⦶ is_parentheses_kind_mask)).as_integer_32 ⧀ alias_kind_shift
		ensure
			class
			same_name: name_id_of_alias_id (Result) = n
			bracket_kind: k = is_bracket_kind_mask ⇒ Result = n
			parentheses_kind: k = is_parentheses_kind_mask ⇒ Result = n
			valid_binary_kind: k ⊗ is_valid_binary_kind_mask /= k.default ⇒ is_valid_binary_alias_id (Result)
			valid_unary_kind: k ⊗ is_valid_unary_kind_mask /= k.default ⇒ is_valid_unary_alias_id (Result)
			binary_kind: k ⊗ is_binary_kind_mask /= k.default ⇒ is_binary_alias_id (Result)
			unary_kind: k ⊗ is_unary_kind_mask /= k.default ⇒ is_unary_alias_id (Result)
			is_alias_id: is_alias_id (Result)
		end

	lookup_alias_id (i: like alias_id): like alias_id
			-- A stripped version of alias ID `i` suitable for lookup.
		require
			is_alias_id (i)
			is_fixed_alias_id (i)
		do
			Result := i ⊗ ⊝ ((is_valid_binary_kind_mask ⦶ is_valid_unary_kind_mask).as_integer_32 ⧀ alias_kind_shift)
		ensure
			is_lookup_alias_id (Result)
		end

	name_id_of_alias_id (i: like alias_id): like {ID_AS}.name_id
			-- Name ID of the alias with ID `i`.
		require
			is_alias_id (i)
		do
			Result := i ⊗ ((1 ⧀ alias_kind_shift) - 1)
		ensure
			class
		end

	binary_alias_id (i: like alias_id): like alias_id
			-- Binary variant of the alias ID.
		require
			is_alias_id (i)
			is_valid_binary_alias_id (i)
		do
			Result :=
				(i ⦶ (is_binary_kind_mask.as_integer_32 ⧀ alias_kind_shift)) ⊗
				⊝ (is_unary_kind_mask.as_integer_32 ⧀ alias_kind_shift)
		ensure
			class
			name_id_of_alias_id (Result) = name_id_of_alias_id (i)
			is_valid_binary_alias_id (Result)
			is_binary_alias_id (Result)
			is_valid_unary_alias_id (Result) = old is_valid_unary_alias_id (Result)
			not is_unary_alias_id (Result)
			is_fixed_alias_id (Result)
		end

	unary_alias_id (i: like alias_id): like alias_id
			-- Unary variant of the alias ID.
		require
			is_alias_id (i)
			is_valid_unary_alias_id (i)
		do
			Result :=
				(i ⦶ (is_unary_kind_mask.as_integer_32 ⧀ alias_kind_shift)) ⊗
				⊝ (is_binary_kind_mask.as_integer_32 ⧀ alias_kind_shift)
		ensure
			class
			name_id_of_alias_id (Result) = name_id_of_alias_id (i)
			is_valid_unary_alias_id (Result)
			is_unary_alias_id (Result)
			is_valid_binary_alias_id (Result) = old is_valid_binary_alias_id (Result)
			not is_binary_alias_id (Result)
			is_fixed_alias_id (Result)
		end

feature {NONE} -- Access: alias name ID

	alias_kind_shift: INTEGER_32 = 24
			-- Number of bits to shift operator kind in mangled alias name ID.

invariant
	disjoint_kind_masks:
		is_bracket_kind_mask +
		is_parentheses_kind_mask +
		is_valid_binary_kind_mask +
		is_valid_unary_kind_mask +
		is_binary_kind_mask +
		is_unary_kind_mask =
		is_bracket_kind_mask ⦶
		is_parentheses_kind_mask ⦶
		is_valid_binary_kind_mask ⦶
		is_valid_unary_kind_mask ⦶
		is_binary_kind_mask ⦶
		is_unary_kind_mask
note
	date: "$Date$"
	revision: "$Revision$"
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
