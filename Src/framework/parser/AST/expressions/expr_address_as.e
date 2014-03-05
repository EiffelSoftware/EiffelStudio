note
	description:
		"Abstract description of an Eiffel expression pointer. %
		%Version for Bench"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXPR_ADDRESS_AS

inherit
	EXPR_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (e: like expr; a_as, lp_as, rp_as: like address_symbol)
			-- Create a new EXPR_ADDRESS AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			if a_as /= Void then
				address_symbol_index := a_as.index
			end
			if lp_as /= Void then
				lparan_symbol_index := lp_as.index
			end
			if rp_as /= Void then
				rparan_symbol_index := rp_as.index
			end
		ensure
			expr_set: expr = e
			address_symbol_set: a_as /= Void implies address_symbol_index = a_as.index
			lparan_symbol_set: lp_as /= Void implies lparan_symbol_index = lp_as.index
			rparan_symbol_set: rp_as /= Void implies rparan_symbol_index = rp_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_expr_address_as (Current)
		end

feature -- Roundtrip

	address_symbol_index: INTEGER
			-- Index of symbol "$" associated with this structure

	lparan_symbol_index, rparan_symbol_index: INTEGER
			-- Index of symbol "(" and ")" associated with this structure

	address_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "$" associated with this structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, address_symbol_index)
		end

	lparan_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "(" associated with this structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, lparan_symbol_index)
		end

	rparan_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol ")" associated with this structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, rparan_symbol_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := address_symbol_index
		end

feature -- Properties

	expr: EXPR_AS
			-- Expression to address

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and address_symbol_index /= 0 then
				Result := address_symbol (a_list)
			elseif a_list /= Void and lparan_symbol_index /= 0 then
				Result := lparan_symbol (a_list)
			else
				Result := expr.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and rparan_symbol_index /= 0 then
				Result := rparan_symbol (a_list)
			else
				Result := expr.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

invariant
	expr_not_void: expr /= Void

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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

end -- class EXPR_ADDRESS_AS
