note
	description: "Internal names for infix and prefix functions, Bench version"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PREFIX_INFIX_NAMES

inherit {NONE}

	SYNTAX_STRINGS
		export
			{NONE} all
		end

	OPERATOR_KIND
		export
			{NONE} all
			{INTERNAL_COMPILER_STRING_EXPORTER}
				is_alias_id
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Queries

	is_mangled_alias_name (n: READABLE_STRING_8): BOOLEAN
			-- Does `n' represent a valid mangled alias name?
			--| I.e. either "[]", "()", or "infix "op"", or "prefix "op"".
		require
			alias_name_not_void: n /= Void
		do
			Result := not n.is_empty and then
				(n.same_string (bracket_str) or else
				n.same_string (parentheses_str) or else
				n.item (n.count) = '"' and then (n.starts_with (infix_str) or else n.starts_with (prefix_str)))
		ensure
			class
		end

feature -- Basic operations

	extract_symbol_from_infix_32 (op: READABLE_STRING_32): STRING_32
			-- Get the symbol part from infix qualified operator `op'.
		require
			op_not_void: op /= Void
		do
			create Result.make (op.count - infix_str.count - quote_str.count)
			Result.append_substring (op, infix_str.count + 1, op.count - quote_str.count)
		ensure
			class
			result_not_void: Result /= Void
		end

	extract_symbol_from_prefix_32 (op: READABLE_STRING_32): STRING_32
			-- Get the symbol part from prefix qualified operator `op'.
		require
			op_not_void: op /= Void
		do
			create Result.make (op.count - prefix_str.count - quote_str.count)
			Result.append_substring (op, prefix_str.count + 1, op.count - quote_str.count)
		ensure
			class
			result_not_void: Result /= Void
			instance_free: class
		end

	extract_alias_name_32 (op: READABLE_STRING_32): STRING_32
			-- Extract symbol part from alias name encoded as any of the following:
			--   prefix "..."
			--   infix "..."
			--   []
			--   ()
		require
			op_not_void: op /= Void
			op_not_empty: not op.is_empty
--			is_mangled_op: is_mangled_alias_name_32 (op)
		local
			c: CHARACTER_32
		do
			c := op.item (1)
			if c = 'p' then
					-- Unary (prefix) operator.
				Result := extract_symbol_from_prefix_32 (op)
			elseif c = 'i' then
					-- Binary (infix) operator.
				Result := extract_symbol_from_infix_32 (op)
			else
					-- Bracket or parenthesis.
				Result := op
			end
		ensure
			class
			result_not_void: Result /= Void
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Basic operations

	prefix_feature_name_with_symbol (symbol: READABLE_STRING_8): STRING_8
			-- Internal name corresponding to prefix `symbol'.
		require
			symbol_not_void: symbol /= Void
			symbol_not_empty: not symbol.is_empty
		do
				-- Allocate enough space for Result
				-- 9 = count of 'Prefix_str' + 'Quote_str'
			create Result.make (9 + symbol.count)
			Result.append (Prefix_str)
			Result.append (symbol)
			Result.append (Quote_str)
		ensure
			class
			Result_not_void: Result /= Void
		end

	infix_feature_name_with_symbol (symbol: READABLE_STRING_8): STRING_8
			-- Internal name corresponding to prefix `symbol'
		require
			symbol_not_void: symbol /= Void
			symbol_not_empty: not symbol.is_empty
		do
				-- Allocate enough space for Result
				-- 8 = count of 'Infix_str' + 'Quote_str'
			create Result.make (8 + symbol.count)
			Result.append (Infix_str)
			Result.append (symbol)
			Result.append (Quote_str)
		ensure
			class
			Result_not_void: Result /= Void
		end

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
