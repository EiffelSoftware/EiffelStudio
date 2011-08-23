note
	description: "AST representation of manifest array."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class ARRAY_AS

inherit
	EXPR_AS
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (exp: like expressions; l_as: like larray_symbol; r_as: like rarray_symbol)
			-- Create a new Manifest ARRAY AST node.
		require
			exp_not_void: exp /= Void
		do
			expressions := exp
			internal_larray_symbol := l_as
			if r_as /= Void then
				rarray_symbol_index := r_as.index
			end
		ensure
			expressions_set: expressions = exp
			larray_symbol_set: internal_larray_symbol = l_as
			rarray_symbol_set: r_as /= Void implies rarray_symbol_index = r_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_array_as (Current)
		end

feature -- Roundtrip

	larray_symbol_index: INTEGER
			-- Index of symbol "<< associated with this structure
		do
			Result := internal_larray_symbol.index
		end

	rarray_symbol_index: INTEGER
			-- Index of symbol ">>" associated with this structure

	larray_symbol (a_list: detachable LEAF_AS_LIST): SYMBOL_AS
			-- Symbol ">>" associated with this structure
			--| We do not require `a_list' to be attached because we save the token.
		do
			Result := internal_larray_symbol
		end

	rarray_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS
			-- Symbol ">>" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := rarray_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Attributes

	expressions: EIFFEL_LIST [EXPR_AS]
			-- Expression list symbolizing the manifest array

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			Result := internal_larray_symbol
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			if a_list /= Void and rarray_symbol_index /= 0 then
				Result := rarray_symbol (a_list)
			else
				Result := expressions.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expressions, other.expressions)
		end

feature {AST_EIFFEL} -- Output

	string_value: STRING = ""

feature {NONE} -- Implementation

	internal_larray_symbol: SYMBOL_AS
			-- Symbol "<<" associated with this structure
			--| It is an attribute for accurate error messages.

invariant
	expressions_not_void: expressions /= Void
	larray_symbol_not_void: internal_larray_symbol /= Void

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

end -- class ARRAY_AS
