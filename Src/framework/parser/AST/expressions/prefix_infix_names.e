note
	description: "Internal names for infix and prefix functions, Bench version"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PREFIX_INFIX_NAMES

inherit
	SYNTAX_STRINGS
		export
			{NONE} frozen_str, infix_str, prefix_str, quote_str
		end

feature -- Queries

	is_mangled_name (name: STRING): BOOLEAN
			-- Is `name' a mangled name that does not match an original name?
			-- (Does it need special decoding? Cannot it be used as an identifier?)
		require
			name_not_void: name /= Void
		do
			Result := name.has ('"')
		end

	is_mangled_alias_name (alias_name: STRING): BOOLEAN
			-- Does `alias_name' represent a valid mangled alias name?
			--| I.e. either "[]", or "infix "op"", or "prefix "op"".
		require
			alias_name_not_void: alias_name /= Void
		do
			Result := not alias_name.is_empty and then
				(syntax_checker.is_bracket_alias_name (alias_name) or
				(alias_name.item (alias_name.count) = '"') and then
				(is_mangled_infix (alias_name) and then syntax_checker.is_valid_binary_operator (extract_symbol_from_infix (alias_name))) or
				(is_mangled_prefix (alias_name) and then syntax_checker.is_valid_unary_operator (extract_symbol_from_prefix (alias_name))))
		end

	is_mangled_infix (name: STRING): BOOLEAN
			-- Does `name' represent an internal name of an infix feature, i.e. "infix "op""?
		require
			name_not_void: name /= Void
		do
			Result := name.starts_with (Infix_str)
		end

	is_mangled_prefix (name: STRING): BOOLEAN
			-- Does `name' represent an internal name of a prefix feature, i.e. "prefix "op""?
		require
			name_not_void: name /= Void
		do
			Result := name.starts_with (Prefix_str)
		end

feature -- Basic operations

	prefix_feature_name_with_symbol (symbol: STRING): STRING
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
			Result_not_void: Result /= Void
		end

	infix_feature_name_with_symbol (symbol: STRING): STRING
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
			Result_not_void: Result /= Void
		end

	extract_symbol_from_infix (op: STRING): STRING
			-- Get the symbol part from infix qualified operator `op'.
		require
			op_not_void: op /= Void
		do
			Result := op.substring (Infix_str.count + 1, op.count - Quote_str.count)
		ensure
			result_not_void: Result /= Void
		end

	extract_symbol_from_prefix (op: STRING): STRING
			-- Get the symbol part from prefix qualified operator `op'.
		require
			op_not_void: op /= Void
		do
			Result := op.substring (Prefix_str.count + 1, op.count - Quote_str.count)
		ensure
			result_not_void: Result /= Void
		end

	extract_alias_name (op: STRING): STRING
			-- Extract symbol part from alias name encoded as any of the following:
			--   prefix "..."
			--   infix "..."
			--   []
		require
			op_not_void: op /= Void
			op_not_empty: not op.is_empty
			is_mangled_op: is_mangled_alias_name (op)
		local
			c: CHARACTER
		do
			c := op.item (1)
			if c = '[' then
					-- Bracket
				Result := op
			elseif c = 'p' then
					-- Unary (prefix) operator
				Result := extract_symbol_from_prefix (op)
			else
					-- Binary (infix) operator
				Result := extract_symbol_from_infix (op)
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	syntax_checker: EIFFEL_SYNTAX_CHECKER
			-- Checker for feature alias names
		once
			create Result
		end

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

end -- Class PREFIX_INFIX_NAMES
