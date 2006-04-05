indexing
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

	initialize (e: like expr; a_as, l_as, r_as: like address_symbol) is
			-- Create a new EXPR_ADDRESS AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			address_symbol := a_as
			lparan_symbol := l_as
			rparan_symbol := r_as
		ensure
			expr_set: expr = e
			address_symbol_set: address_symbol = a_as
			lparan_symbol_set: lparan_symbol = l_as
			rparan_symbol_set: rparan_symbol = r_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_expr_address_as (Current)
		end

feature -- Roundtrip

	address_symbol: SYMBOL_AS
			-- Symbol "$" associated with this structure

	lparan_symbol, rparan_symbol: SYMBOL_AS
			-- Symbol "(" and ")" associated with this structure

feature -- Properties

	expr: EXPR_AS
			-- Expression to address

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := expr.first_token (a_list)
			else
				Result := address_symbol.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := expr.last_token (a_list)
			else
				Result := rparan_symbol.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

invariant
	expr_not_void: expr /= Void

indexing
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

end -- class EXPR_ADDRESS_AS
