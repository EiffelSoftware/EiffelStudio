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
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (exp: like expressions; l_as: like lbracket_symbol; r_as: like rbracket_symbol)
			-- Create a new Manifest TUPLE AST node.
		require
			exp_not_void: exp /= Void
			l_as_not_void: l_as /= Void
		do
			expressions := exp
			internal_lbracket_symbol := l_as
			if r_as /= Void then
				rbracket_symbol_index := r_as.index
			end
		ensure
			expressions_set: expressions = exp
			lbracket_symbol_set: internal_lbracket_symbol = l_as
			rbracket_symbol_set: r_as /= Void implies rbracket_symbol_index = r_as.index
		end

feature -- Attributes

	expressions: EIFFEL_LIST [EXPR_AS]
			-- Expression list symbolizing the manifest tuple

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			Result := internal_lbracket_symbol
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			if a_list /= Void and rbracket_symbol_index /= 0 then
				Result := rbracket_symbol (a_list)
			else
				Result := expressions.last_token (a_list)
			end
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_tuple_as (Current)
		end

feature -- Roundtrip

	lbracket_symbol_index: INTEGER
			-- Index of symbol "[" associated with this structure
		do
			Result := internal_lbracket_symbol.index
		end

	rbracket_symbol_index: INTEGER
			-- Index of symbol "]" associated with this structure

	lbracket_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS
			-- Symbol "[" associated with this structure
		do
			Result := internal_lbracket_symbol
		end

	rbracket_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS
			-- Symbol "]" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := rbracket_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expressions, other.expressions)
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Output

	string_value: STRING = ""

feature {NONE} -- Implementation

	internal_lbracket_symbol: SYMBOL_AS
			-- Symbol "[" associated with this structure
			--| It is an attribute for accurate error messages.

invariant
	expressions_not_void: expressions /= Void
	internal_lbracket_symbol_not_void: internal_lbracket_symbol /= Void

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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

end -- class TUPLE_AS

