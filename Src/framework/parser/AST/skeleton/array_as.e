note
	description: "AST representation of manifest array."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ARRAY_AS

inherit
	EXPR_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (exp: like expressions; l_as: like larray_symbol; r_as: like rarray_symbol)
			-- Create a new Manifest ARRAY AST node.
		require
			exp_not_void: exp /= Void
		do
			expressions := exp
			if l_as /= Void then
				internal_larray_symbol := l_as
				larray_symbol_index := l_as.index
			end
			if r_as /= Void then
				rarray_symbol_index := r_as.index
			end
		ensure
			expressions_set: expressions = exp
			larray_symbol_set: internal_larray_symbol = l_as and (l_as /= Void implies larray_symbol_index = l_as.index)
			rarray_symbol_set: r_as /= Void implies rarray_symbol_index = r_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_array_as (Current)
		end

feature -- Roundtrip

	larray_symbol_index: INTEGER
			-- Index of symbol "<<" associated with this structure.

	rarray_symbol_index: INTEGER
			-- Index of symbol ">>" associated with this structure.

	larray_symbol (a_list: detachable LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "<<" associated with this structure.
			--| We do not require `a_list' to be attached because we save the token.
		local
			i: INTEGER
		do
				-- We use the token if available for reporting error message, otherwise
				-- the list.
			Result := internal_larray_symbol
			if Result = Void and a_list /= Void then
				i := larray_symbol_index
				if a_list.valid_index (i) and then attached {like larray_symbol} a_list.i_th (i) as l_result then
					Result := l_result
				end
			end
		end

	rarray_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol ">>" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := rarray_symbol_index
			if a_list.valid_index (i) and then attached {like rarray_symbol} a_list.i_th (i) as l_result then
				Result := l_result
			end
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := larray_symbol_index
		end

feature -- Attributes

	expressions: EIFFEL_LIST [EXPR_AS]
			-- Expression list symbolizing the manifest array.

	type: detachable TYPE_AS
			-- Specified array type (if any).

feature -- Modification

	set_type (t: like type)
			-- Set type with `t`.
		do
			type := t
		ensure
			type_set: type = t
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached type as t then
				Result := t.first_token (a_list)
			end
			if not attached Result then
				Result := larray_symbol (a_list)
				if Result = Void then
					Result := expressions.first_token (a_list)
				end
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and rarray_symbol_index /= 0 then
				Result := rarray_symbol (a_list)
			else
				Result := expressions.last_token (a_list)
			end
			if not attached Result and then attached type as t then
				Result := t.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result :=
				equivalent (type, other.type) and then
				equivalent (expressions, other.expressions)
		end

feature {AST_EIFFEL} -- Output

	string_value: STRING = ""

feature {NONE} -- Implementation

	internal_larray_symbol: detachable SYMBOL_AS
			-- Symbol "<<" associated with this structure
			--| It is an attribute for accurate error messages.

invariant
	expressions_not_void: expressions /= Void

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
