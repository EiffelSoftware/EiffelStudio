note
	description: "AST representation of manifest tuple."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TUPLE_AS

inherit
	EXPR_AS
		redefine
			is_detachable_expression
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (exp: like expressions; l_as: like lbracket_symbol; r_as: like rbracket_symbol)
			-- Create a new Manifest TUPLE AST node.
		require
			exp_not_void: exp /= Void
		do
			expressions := exp
			if l_as /= Void then
				internal_lbracket_symbol := l_as
				lbracket_symbol_index := l_as.index
			end
			if r_as /= Void then
				rbracket_symbol_index := r_as.index
			end
		ensure
			expressions_set: expressions = exp
			lbracket_symbol_set: internal_lbracket_symbol = l_as and (l_as /= Void implies lbracket_symbol_index = l_as.index)
			rbracket_symbol_set: r_as /= Void implies rbracket_symbol_index = r_as.index
		end

feature -- Status report

	is_detachable_expression: BOOLEAN = True
			-- <Precursor>
			-- Although the expression is always attached, its computation might be costly.
			-- Treating it as detachable allows for reusing the same manifest tuple if needed:
			--    check
			--       attached [compute_x, compute_y] as point
			--       has_property_1 (point)
			--       has_property_2 (point)
			--    end

feature -- Attributes

	expressions: EIFFEL_LIST [EXPR_AS]
			-- Expression list symbolizing the manifest tuple.

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := lbracket_symbol (a_list)
			if Result = Void then
				Result := expressions.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and rbracket_symbol_index /= 0 then
				Result := rbracket_symbol (a_list)
			else
				Result := expressions.last_token (a_list)
			end
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_tuple_as (Current)
		end

feature -- Roundtrip

	lbracket_symbol_index: INTEGER
			-- Index of symbol "[" associated with this structure.

	rbracket_symbol_index: INTEGER
			-- Index of symbol "]" associated with this structure.

	lbracket_symbol (a_list: detachable LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "[" associated with this structure.
		local
			i: INTEGER
		do
				-- We use the token if available for reporting error message, otherwise
				-- the list.
			Result := internal_lbracket_symbol
			if Result = Void and a_list /= Void then
				i := lbracket_symbol_index
				if a_list.valid_index (i) and then attached {like lbracket_symbol} a_list.i_th (i) as l_result then
					Result := l_result
				end
			end
		end

	rbracket_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "]" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := rbracket_symbol_index
			if a_list.valid_index (i) and then attached {like rbracket_symbol} a_list.i_th (i) as l_result then
				Result := l_result
			end
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := lbracket_symbol_index
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result := equivalent (expressions, other.expressions)
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Output

	string_value: STRING = ""

feature {NONE} -- Implementation

	internal_lbracket_symbol: detachable SYMBOL_AS
			-- Symbol "[" associated with this structure.
			--| It is an attribute for accurate error messages.

invariant
	expressions_not_void: expressions /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
