indexing
	description:
		"Abstract description of a parenthesized expression. %
		%Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PARAN_AS

inherit
	EXPR_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (e: like expr; lp_as, rp_as: like lparan_symbol) is
			-- Create a new PARAN AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			if lp_as /= Void then
				lparan_symbol_index := lp_as.index
			end
			if rp_as /= Void then
				rparan_symbol_index := rp_as.index
			end
		ensure
			expr_set: expr = e
			lparan_symbol_set: lp_as /= Void implies lparan_symbol_index = lp_as.index
			rparan_symbol_set: rp_as /= Void implies rparan_symbol_index = rp_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_paran_as (Current)
		end

feature -- Roundtrip

	lparan_symbol_index, rparan_symbol_index: INTEGER
			-- Index of symbol "(" and ")" associated with this structure

	lparan_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS is
			-- Symbol "(" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := lparan_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	rparan_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS is
			-- Symbol ")" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := rparan_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Attributes

	expr: EXPR_AS
			-- Parenthesized expression

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and lparan_symbol_index /= 0 then
				Result := lparan_symbol (a_list)
			else
				Result := expr.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and rparan_symbol_index /= 0 then
				Result := rparan_symbol (a_list)
			else
				Result := expr.first_token (a_list)
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

end -- class PARAN_AS
